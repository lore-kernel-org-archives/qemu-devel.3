Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16278C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz9I-0003hk-2B; Tue, 07 Jul 2026 02:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz9D-0003fn-HE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:13 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz99-0001H6-Rs
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:11 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 8CE1D240101
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783405144;
 bh=7QgkWxDqsKGyeHGrlZEQIjZR/SmL5z10D2fm4AH3XoU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=FWDtk92+IbQU3JIOy7uVnE1dHXzsaaijxMa4Ijkl6Wkv/umi2srmBpu7xGffm/fvA
 TO7X8gLZZdNwc8jijK3G9SFNfMj3QNnTBGNYmtlTIwCMIxMxWrZgdsOyRK0n0QBoN8
 4jEjU72ASmwfvzIeQC/n2mNJydLkvM6YuHuJCQyNGu8M7iQ8+HREdh4s63EyCU+AdC
 h2WRJiG1KWiQpoYQA7eWoYCuj2Ptxck4MrsHFplhjSU/TOI3tNd+ifkgDj4PSQ3MX6
 5DppaG9smLtQtf6VCg3lowJOzRaTjoYDmXUS7gBLdxO6DPdpeO5LeAg0E9DaRVY1mq
 GaF24awAqhsrw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gvWJm10fGz9rxF;
 Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 2/3] tests/functional/aspeed: unify boot completion detection
 on 'login:' prompt
Date: Tue, 07 Jul 2026 06:19:04 +0000
Message-ID: <20260707061851.8298-3-th.huth@posteo.eu>
In-Reply-To: <20260707061851.8298-1-th.huth@posteo.eu>
References: <20260707061851.8298-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The boot completion check in AspeedTest waits for the systemd
"Hostname set to" message, which occasionally causes intermittent test
timeouts, e.g. on ast2500 SoC machines. The root cause seems to be
console output interleaving of both systemd and the getty login
process. This results in the expected pattern string being broken up.

Unify and simplify all boot completion checks by looking for the
generic 'login:' substring in AspeedTest.wait_for_boot_complete().
With the override gone, remove the redundant FacebookAspeedTest class
and update the Anacapa, Bletchley, and Catalina tests to inherit
directly from AspeedTest. Also drop the now-dead image_hostname
parameter from do_test_arm_aspeed_openbmc().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3117
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260617042718.2883655-1-clg@redhat.com>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 tests/functional/arm/test_aspeed_anacapa.py   |  6 +++---
 tests/functional/arm/test_aspeed_bletchley.py |  6 +++---
 tests/functional/arm/test_aspeed_catalina.py  |  6 +++---
 .../arm/test_aspeed_gb200nvl_bmc.py           |  3 +--
 tests/functional/aspeed.py                    | 21 ++++---------------
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56..809afeaeb8 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -5,10 +5,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
-from aspeed import FacebookAspeedTest
+from aspeed import AspeedTest
 
 
-class AnacapaMachine(FacebookAspeedTest):
+class AnacapaMachine(AspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_anacapa_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    FacebookAspeedTest.main()
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
index 3000d0c302..5a60b24b3d 100755
--- a/tests/functional/arm/test_aspeed_bletchley.py
+++ b/tests/functional/arm/test_aspeed_bletchley.py
@@ -5,10 +5,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
-from aspeed import FacebookAspeedTest
+from aspeed import AspeedTest
 
 
-class BletchleyMachine(FacebookAspeedTest):
+class BletchleyMachine(AspeedTest):
 
     ASSET_BLETCHLEY_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_bletchley_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    FacebookAspeedTest.main()
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index 2694e4b005..dc2f24e7b4 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -5,10 +5,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
-from aspeed import FacebookAspeedTest
+from aspeed import AspeedTest
 
 
-class CatalinaMachine(FacebookAspeedTest):
+class CatalinaMachine(AspeedTest):
 
     ASSET_CATALINA_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_catalina_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    FacebookAspeedTest.main()
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
index e5f2dce0f5..f9e736d047 100755
--- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
+++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
@@ -19,8 +19,7 @@ def test_arm_aspeed_gb200_openbmc(self):
 
         self.do_test_arm_aspeed_openbmc('gb200nvl-bmc', image=image_path,
                                         uboot='2019.04', cpu_id='0xf00',
-                                        soc='AST2600 rev A3',
-                                        image_hostname='gb200nvl-obmc')
+                                        soc='AST2600 rev A3')
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 88b6590934..076da1036c 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -8,14 +8,7 @@
 class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
-                                   cpu_id='0x0', soc='AST2500 rev A1',
-                                   image_hostname=None):
-        # Allow for the image hostname to not end in "-bmc"
-        if image_hostname is not None:
-            hostname = image_hostname
-        else:
-            hostname = machine.removesuffix('-bmc')
-
+                                   cpu_id='0x0', soc='AST2500 rev A1'):
         self.set_machine(machine)
         self.vm.set_console()
         self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
@@ -28,10 +21,10 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
         self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
         self.wait_for_console_pattern(f'ASPEED {soc}')
         self.wait_for_console_pattern('/init as init process')
-        self.wait_for_boot_complete(hostname)
+        self.wait_for_boot_complete()
 
-    def wait_for_boot_complete(self, hostname):
-        self.wait_for_console_pattern(f'systemd[1]: Hostname set to <{hostname}>.')
+    def wait_for_boot_complete(self):
+        self.wait_for_console_pattern('login:')
 
     def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
         self.require_netdev('user')
@@ -71,9 +64,3 @@ def generate_otpmem_image(self):
         with open(path, "wb") as f:
             f.write(pattern)
         return path
-
-
-class FacebookAspeedTest(AspeedTest):
-
-    def wait_for_boot_complete(self, hostname):
-        self.wait_for_console_pattern(f'{hostname} login:')
-- 
2.54.0


