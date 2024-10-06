Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9CCFB442
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 16:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxURi-00060i-1u; Sun, 06 Oct 2024 12:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURe-0005zU-Ua
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURc-0008Au-Dy
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6D0C94E6039;
 Sun, 06 Oct 2024 18:49:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id TXdJrdIPRymz; Sun,  6 Oct 2024 18:49:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7E3F54E6031; Sun, 06 Oct 2024 18:49:14 +0200 (CEST)
Message-Id: <0f5949d8ece522e30f990d25981f79965bf05bbf.1728232526.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1728232526.git.balaton@eik.bme.hu>
References: <cover.1728232526.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] log: Suggest using -d guest_error,memaccess instead of
 guest_errors
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sun, 06 Oct 2024 18:49:14 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
a warning for -d guest_errors to remind using guest_error,memaccess
instead but preserve previous behaviour for convenience.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
As this is a debug switch I think no formal deprecation is needed but
this is to allow people to change their commands and scripts then it
may be removed eventually.

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
index 83fd79e922..7ed836c12d 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -46,7 +46,7 @@ def common_vm_setup(self, custom_kernel=False):
         self.vm.add_args("-accel", "kvm")
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-machine", "iommu=smmuv3")
-        self.vm.add_args("-d", "guest_errors")
+        self.vm.add_args("-d", "guest_error,memaccess")
         self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
                          'edk2-aarch64-code.fd'))
         self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 7f64d597ac..63a2acf9de 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -418,7 +418,7 @@ static void test_host_i2c(const void *data)
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
-                      "-d guest_errors",
+                      "-d guest_error,memaccess",
                       machine, SMT, SMT);
 
     /* Check the I2C master status registers after POR */
diff --git a/util/log.c b/util/log.c
index 1aa7396277..279c2b5cfb 100644
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
+                        "Use guest_error,memaccess instead.");
+            mask |= LOG_GUEST_ERROR | LOG_MEM_ACCESS;
 #ifdef CONFIG_TRACE_LOG
         } else if (g_str_has_prefix(*tmp, "trace:") && (*tmp)[6] != '\0') {
             trace_enable_events((*tmp) + 6);
-- 
2.30.9


