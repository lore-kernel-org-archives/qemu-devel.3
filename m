Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98808C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpt-0008Sw-1O; Sat, 11 Jul 2026 18:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpq-0008Af-9N; Sat, 11 Jul 2026 18:06:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpn-0000hh-I9; Sat, 11 Jul 2026 18:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=OyyLouD3KzjMvGtRSL93d2KC9SpgmZJSaUXwj8zN9Qc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q9PMXdCSBiiYlQQ5nb7L37BBxBKjQUKtSZZ6lzHUTI0mTig6vXnwxya/uIZTCWNLX
 FXImsWfebK+oznKr5sF6OplrzzhOUf3cUTDt3/N1x/XF+kaI1fOGHPOXQFR7tC5jQK
 KsaiDggiZ3KrS++UFomegghZ+vduELwocLQJeyf5rR8iCRbJQ+h/+cVCZ5uVn0z4Pc
 1Fncl0ZXHutvdpxQMFyLCsrAuGedvbqpUWf0kzuYyWDX7SB8zVTcCFXMj5JwKhPp8h
 sc1D1Dj8f48n0P4ytjarBH26z4g2vh3pX7stCp26h4jWF5xlF+jlvPh7+dK+kuBD8h
 yHSrLAeVP+xeA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C1271C0ACD;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 538213EAF58;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D6C8313367; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jia Jia <physicalmtea@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 66/81] hw/ufs: avoid double unref of wrapped scsi-hd
Date: Sun, 12 Jul 2026 00:58:44 +0300
Message-ID: <20260711215904.3757-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jia Jia <physicalmtea@gmail.com>

ufs_init_scsi_device() creates an internal scsi-hd and adds it as a
child of lu->bus. qdev_realize_and_unref() then drops the construction
reference, leaving the bus child ownership to tear it down.

ufs_lu_unrealize() still unrefs lu->scsi_dev directly. If the UFS
controller is ejected through ACPI PCI hotplug, the scsi-hd object can be
finalized there and then the bus child removal RCU callback later unrefs
the same object again.

Keep lu->scsi_dev as a borrowed pointer and clear it during unrealize
without unreffing it.

Add a qtest that ejects the UFS controller through the x86 ACPI PCI
hotplug eject register. On an ASAN build, the test reproduces the UAF
before the fix.

Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 90aacd5bc405cb71f77472616093f9e5ad9afd2b)
(Mjt: tests/qtest/ufs-test.c: context fixup)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 709d6adcf68..ebaf979313e 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -416,10 +416,7 @@ static void ufs_lu_unrealize(DeviceState *dev)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
 
-    if (lu->scsi_dev) {
-        object_unref(OBJECT(lu->scsi_dev));
-        lu->scsi_dev = NULL;
-    }
+    lu->scsi_dev = NULL;
 }
 
 static void ufs_lu_class_init(ObjectClass *oc, const void *data)
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f999441552..564202e5849 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -34,6 +34,8 @@
 #define TEST_QID 0
 #define QUEUE_SIZE 32
 #define UFS_MCQ_MAX_QNUM 32
+#define ACPI_PCIHP_ADDR 0xae00
+#define PCI_EJ_BASE 0x0008
 
 typedef struct QUfs QUfs;
 
@@ -635,6 +637,17 @@ static void ufstest_reg_read(void *obj, void *data, QGuestAllocator *alloc)
     qpci_iounmap(&ufs->dev, ufs->bar);
 }
 
+static void ufstest_acpi_eject(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    QTestState *qts = ufs->dev.bus->qts;
+
+    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << 4);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'query-status' }");
+    g_usleep(3 * G_USEC_PER_SEC);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'query-status' }");
+}
+
 static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
 {
     QUfs *ufs = obj;
@@ -1234,6 +1247,8 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };
 
+    QOSGraphTestOptions acpi_eject_test_opts = { .subprocess = true };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -1251,6 +1266,10 @@ static void ufs_register_nodes(void)
         g_test_message("Skipping ufs io tests for ppc64");
         return;
     }
+    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+        qos_add_test("acpi-eject", "ufs", ufstest_acpi_eject,
+                     &acpi_eject_test_opts);
+    }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
-- 
2.47.3


