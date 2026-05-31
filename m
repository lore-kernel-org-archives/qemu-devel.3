Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BCCD6E4C
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 01:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTV4w-0006O3-2K; Sat, 30 May 2026 21:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wTV4u-0006Nh-Tw
 for qemu-devel@nongnu.org; Sat, 30 May 2026 21:35:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wTV4s-0003pP-Tc
 for qemu-devel@nongnu.org; Sat, 30 May 2026 21:35:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so1653655ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780191297; x=1780796097; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z5urK5Co7KTaFSOLKHX13+BcuuEu3ZMB+J9ucm5HP/c=;
 b=UcQjHp1MSM2HDiA93nZysLzQOxqNbJZZ6POeO5nUYEDDB3F91Ixo3Y+udmFkK9keTJ
 5Qf3Ug+f6bET7m5A4uMkTPa6367+jBVxZLAlIml1PVhWuBZXk8JWTR4czhlm5XRXxPI2
 /nZb2wJ55fWFQXRQrC9lnTp1EfhAyvsVD861y5ipbuJuvDFbx482ZrCmlYrul3E8hg1W
 +cH73rB+AFVHszTK4+r8Rgutan6ZQJ9M3GJu0r8cstdTq0AVKgsqf6CS4c2keHcN2q28
 QskwzEYH5oRhOefSe722deEpvGii055aqi/w9wbw9aM4TxEkbeJTewikomNcerfmtwhK
 dY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780191297; x=1780796097;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5urK5Co7KTaFSOLKHX13+BcuuEu3ZMB+J9ucm5HP/c=;
 b=l1j4bNmUgtGV9l9biUVhXmAtpva4mZ+YWsmMU1N6FwXpofvNnVY9hIfS4EI/lpdSuD
 UnV8QtuNhAwE4Qte4UxNF2ZxnijU40w5o/Blwt5LiA+7gP4a2fdz0iwk73grEBjy8e6a
 RSzARfS3+WLbvoVLulvWV8C009+0I65xrM0/UCL6F2CkIOjkMYmn2l8H1FNwXhQR+24a
 SDT9TTnxHfvEkJMJRRdGrRkBTI5xJXE2rcRIWd8sRlrLgYhxxKZmzT0pjZ799Er/g4u8
 XqCQIoylT6hIomE6yyFWZr474R2TtlmsiSYPH8/tFs4z85E0UP6TJAALvO7d78RFqjY+
 SsFA==
X-Gm-Message-State: AOJu0Yz7pTbmzfnB9sMqk/HeSSHyp1oTp2xtDUA8xA3ZjfvCLy+e+pRq
 0uepNZzZehGWDVaLsogQMHD4EzTiZ54kmiJHnqXaVxr5P0/e5bxS6JEXqtV5xf0P
X-Gm-Gg: Acq92OGu63jVAqY/+Nw6TW8C9EJs1MolzvQ7Q2b9dZh3QSB0bMvyf3Sc6tYGS25nTU7
 VzV5AuSPsosXLohXWlbzjcV0rSCHNCWOm5IiAUxiu64Xsim5JUtjLHUa71h9yGzQEYIzrjfA3qw
 0MKgIAYc0H7Hf2iWN06UOPiurZJfyVQ1s+ij3AKnLQW56bD5cGkkj5L1Ms1wjB/Nw+kB1afFwYD
 9jDGMYaiEpFjle1/FEJQpxs87m9eH1h2Ue8VMHO+2UIj3+0hJF1jAOuI9tvuDzHXJc3nj+/izXg
 pj/+4AxB/R0dK47vzdD76aBHwo+yEy08hQqTcJ7DLSSiB9APeOCXAl8Ughh8/1VSsPwq2nRurUj
 2gpwbAm7htJ9hx1anInP9+rNqFfmBAGEkEKLcCAjyq9ZdG7aav0IgHRZxb51lDu3I918Z5FYkJz
 VR2A4iHnykozIyZZpdCKHluWt8kbHBttJh0FubgQ==
X-Received: by 2002:a17:902:e78b:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2bf3687a3ddmr64447235ad.37.1780191297049; 
 Sat, 30 May 2026 18:34:57 -0700 (PDT)
Received: from [127.0.1.1] ([114.249.134.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239fd6edsm75896655ad.18.2026.05.30.18.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 18:34:56 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-stable@nongnu.org
Subject: [PATCH] hw/ufs: avoid double unref of wrapped scsi-hd
Date: Sun, 31 May 2026 09:34:52 +0800
Message-ID: <178019129273.471607.15668084929091826093@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/ufs/lu.c            |  5 +----
 tests/qtest/ufs-test.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index f13fc6e342..41593a7117 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -516,10 +516,7 @@ static void ufs_lu_unrealize(DeviceState *dev)
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
index f677896db0..0ae03c3433 100644
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
@@ -1426,6 +1439,9 @@ static void ufs_register_nodes(void)
         g_test_message("Skipping ufs io tests for ppc64");
         return;
     }
+    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+        qos_add_test("acpi-eject", "ufs", ufstest_acpi_eject, NULL);
+    }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);

