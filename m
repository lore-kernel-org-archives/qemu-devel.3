Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2848C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0EB-0006C9-F0; Tue, 07 Jul 2026 03:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wh0E9-0006At-Ia
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:28:21 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wh0E7-0006DN-Om
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:28:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2589272a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783409297; x=1784014097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFYPyrOKlOOI8q1ON7eTlSHXPmZ33Hmg9/5mVXy8t68=;
 b=UBOfVWQ2tguOz9HRWSzenfkoa6OI+F14mfBYDRuh3/t3lny8GpccJBLpLnmX7GHh4i
 ASEec4s5WWzRuGPlIBAkVaiHJEkxsMIILPKGyC1GN0SIV/NdKKefLedlyEzIXPKYl4Q8
 DjaZL5A2DrBe+ZIQxk/kW8ITnToEDnA/IsMGT3DN5FXFxBNtLznmtSmdsuckW0M+LWnG
 00pp7PH+gdFSS67U7rNsdBvX3CGg/4qak5GGntLFZwIovMiQs+fZDZJAZNau+Fi2h6Gl
 Ai9Yn2/LzZzZoZ613E6Xyv+509rtGv6lrYVV3SM/iwFB64ow0/Zp+ApNR2vfG9A6UQE5
 BBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783409297; x=1784014097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xFYPyrOKlOOI8q1ON7eTlSHXPmZ33Hmg9/5mVXy8t68=;
 b=X3gn0e1b+P87brvDkUBCETAsRb/Yy0lIGOm45r3T56vxWv14/01odqGxz7ZHwq1Ish
 zwbePC/y6/Cu1fcWFd8hk7Rb4QjCB/aj7DKBCfiyezzMkcOl4qBV2nebFJA99XgykBnq
 3Jh45JB08yuh7C9pTy05TbDjxXym9sDpGHvF6zcwztCXy9qmSjKTYsqv9PVo3WBFozS2
 DhmNtgY93l46UJhEQXsk+lOkjogK0uZ/aluhGryOMnyUWODfcUEzuEfXLydmMIN/OePM
 5j4epdgh/u6Q0uaXcL88kcp5gc2dKhm4y5AV1GBrzs/1nmkZDuRy8etYuX5+np83edj4
 et/g==
X-Gm-Message-State: AOJu0Yy3NnanfFiX6MnYaL3uud1DpKK3ApcsowaGQ1dZAqvp/4oPx0/U
 Hherv9RzmXtM8jjW7Kr/Gs1KctATddjbBRAIovztV78WPK3EmcZ1ydzEHz2q6g==
X-Gm-Gg: AfdE7clqoCuYIVTfdCfshkv6CQkPemJwJBhiq0Z4yzjfiZlFK5WFt7NtZpaF1D8sW1L
 dAU3xzXeVGmjSFyeUOI+DfazTF5NiccFDoAREyxZe6yxA4aZQZU+V9qaRMEBk9lBZxO2OiWydlg
 zoIAWXmwoN10LhV5VQ1eQnSxn0AaUz4xvsUUMNCvbZNCBX4USLMxvQaUMnRcp9iT3y2iFGmQ5AE
 VMg/5Oc9fZZBnQUM1FA6yN5mhLvOaFtvFm6yJ7TlmbfGmy9bv1ROxv/ZWG8o2S+1j1OIs3xNDzf
 BqqnTN3r4Wiee1w+uU91LMxTWyTCkP3fUxGDcAfzDM4tL50AVlJii8zX301niIcZPsZanfE5i5w
 +nij6tJIOZ8urVVKPUfdyPeSgG8TM1ly4NtcvpJfKPO45ds8YdhItJIRcZ2Yu30Hur5RaN8DODI
 NtBPdNqsY2XIOCgVJBZPFu
X-Received: by 2002:a17:90b:2dcb:b0:387:e0db:3d8e with SMTP id
 98e67ed59e1d1-387e0db436fmr1771691a91.41.1783409296973; 
 Tue, 07 Jul 2026 00:28:16 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf7678sm6927905ad.20.2026.07.07.00.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 00:28:16 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: physicalmtea@gmail.com, jeuk20.kim@samsung.com, qemu-stable@nongnu.org,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 j-young.choi@samsung.com
Subject: [PATCH v2] hw/ufs: avoid double unref of wrapped scsi-hd
Date: Tue,  7 Jul 2026 16:28:05 +0900
Message-ID: <490abae1212bebcf005624924783ed61d2eaea95.1783408494.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178019129273.471607.15668084929091826093@gmail.com>
References: <178019129273.471607.15668084929091826093@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
v2:
- Respun by Jeuk Kim.
- Run the acpi-eject qtest in a subprocess so it cannot leave the shared
  qos-test QEMU instance without the UFS device for subsequent tests.

 hw/ufs/lu.c            |  5 +----
 tests/qtest/ufs-test.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1e75b1eb4d..13f4a90145 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -530,10 +530,7 @@ static void ufs_lu_unrealize(DeviceState *dev)
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
index 3b85296a72..9a9c5ca834 100644
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
@@ -1682,6 +1695,7 @@ static void ufs_register_nodes(void)
                                              "mcq=false,nutrs=32,nutmrs=8,"
                                              "wb-max-size=1024,"
                                              "wb-min-size=256" };
+    QOSGraphTestOptions acpi_eject_test_opts = { .subprocess = true };
 
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
@@ -1700,6 +1714,10 @@ static void ufs_register_nodes(void)
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
2.43.0

