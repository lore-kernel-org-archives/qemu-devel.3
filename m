Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32589E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7D5s-0001if-DF; Sat, 02 Nov 2024 08:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5i-0001h2-2w
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:18:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5c-0007b4-NA
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:18:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B2B34E603E;
 Sat, 02 Nov 2024 13:17:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id roDQnPP4svkX; Sat,  2 Nov 2024 13:17:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 47E374E603D; Sat, 02 Nov 2024 13:17:36 +0100 (CET)
Message-Id: <e7113bae5acae3b595e8af0d0d9584834d0c0329.1730549443.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1730549443.git.balaton@eik.bme.hu>
References: <cover.1730549443.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/2] log: Suggest using -d guest_error, invalid_mem instead
 of guest_errors
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
    philmd@linaro.org
Date: Sat, 02 Nov 2024 13:17:36 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename guest_errors to guest_error to match the log constant and print
a warning for -d guest_errors to remind using guest_error,invalid_mem
instead but preserve previous behaviour for convenience.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This patch is optional, only to preserve current behaviour if that's
desired.

 docs/devel/secure-coding-practices.rst | 2 +-
 tests/avocado/smmu.py                  | 2 +-
 tests/qtest/pnv-host-i2c-test.c        | 2 +-
 util/log.c                             | 6 +++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/devel/secure-coding-practices.rst b/docs/devel/secure-coding-practices.rst
index 0454cc527e..b330b01956 100644
--- a/docs/devel/secure-coding-practices.rst
+++ b/docs/devel/secure-coding-practices.rst
@@ -85,7 +85,7 @@ request completes.  Unexpected accesses must not cause memory corruption or
 leaks in QEMU.
 
 Invalid device register accesses can be reported with
-``qemu_log_mask(LOG_GUEST_ERROR, ...)``.  The ``-d guest_errors`` command-line
+``qemu_log_mask(LOG_GUEST_ERROR, ...)``.  The ``-d guest_error`` command-line
 option enables these log messages.
 
 Live Migration
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index 83fd79e922..1632e8cfbc 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -46,7 +46,7 @@ def common_vm_setup(self, custom_kernel=False):
         self.vm.add_args("-accel", "kvm")
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-machine", "iommu=smmuv3")
-        self.vm.add_args("-d", "guest_errors")
+        self.vm.add_args("-d", "guest_error,invalid_mem")
         self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
                          'edk2-aarch64-code.fd'))
         self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 7f64d597ac..316933c873 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -418,7 +418,7 @@ static void test_host_i2c(const void *data)
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
-                      "-d guest_errors",
+                      "-d guest_error,invalid_mem",
                       machine, SMT, SMT);
 
     /* Check the I2C master status registers after POR */
diff --git a/util/log.c b/util/log.c
index b87d399e4c..f05e36e7ec 100644
--- a/util/log.c
+++ b/util/log.c
@@ -486,7 +486,7 @@ const QEMULogItem qemu_log_items[] = {
       "show CPU state before CPU resets" },
     { LOG_UNIMP, "unimp",
       "log unimplemented functionality" },
-    { LOG_GUEST_ERROR, "guest_errors",
+    { LOG_GUEST_ERROR, "guest_error",
       "log when the guest OS does something invalid (eg accessing a\n"
       "non-existent register)" },
     { CPU_LOG_PAGE, "page",
@@ -521,6 +521,10 @@ int qemu_str_to_log_mask(const char *str)
             for (item = qemu_log_items; item->mask != 0; item++) {
                 mask |= item->mask;
             }
+        } else if (g_str_equal(*tmp, "guest_errors")) {
+            warn_report("Log option guest_errors is deprecated. "
+                        "Use guest_error,invalid_mem instead.");
+            mask |= LOG_GUEST_ERROR | LOG_INVALID_MEM;
 #ifdef CONFIG_TRACE_LOG
         } else if (g_str_has_prefix(*tmp, "trace:") && (*tmp)[6] != '\0') {
             trace_enable_events((*tmp) + 6);
-- 
2.30.9


