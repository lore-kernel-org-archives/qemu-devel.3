Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59q-0006ax-2o; Tue, 07 Jul 2026 08:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59g-0006Wh-5n
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59e-0005DE-7C
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mYCfhw4kexlqT/Cfa5HLsm4Wk66922gaexKsQ8O/bs=;
 b=BNX0ix9Vv6kHweQqWAf5VbGPPNZArs6WCvVWZu4Umc8gk8hE68UeVF0NxtFNGIIhoJnzJf
 NHWP8NPlGnxWwvz4ke93syKkqps0fxIufID+tl2BL7VIKlFU1KSbMxOBLhSRpEDJRm6fto
 UuSl1TQkcWcTx6H2pMWf6YtLAupxSjI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-gJZ12XQVPWaBUxyrQ6Xi-Q-1; Tue,
 07 Jul 2026 08:43:58 -0400
X-MC-Unique: gJZ12XQVPWaBUxyrQ6Xi-Q-1
X-Mimecast-MFC-AGG-ID: gJZ12XQVPWaBUxyrQ6Xi-Q_1783428237
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D2771953986; Tue,  7 Jul 2026 12:43:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC14F3691B; Tue,  7 Jul 2026 12:43:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/8] tests/functional/aspeed: unify boot completion detection
 on 'login:' prompt
Date: Tue,  7 Jul 2026 14:43:43 +0200
Message-ID: <20260707124349.662198-3-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260617042718.2883655-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_anacapa.py   |  6 +++---
 tests/functional/arm/test_aspeed_bletchley.py |  6 +++---
 tests/functional/arm/test_aspeed_catalina.py  |  6 +++---
 .../arm/test_aspeed_gb200nvl_bmc.py           |  3 +--
 tests/functional/aspeed.py                    | 21 ++++---------------
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index b16c6035c95e..363b4c2a1d09 100644
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
         'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_anacapa_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    FacebookAspeedTest.main()
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
index 3000d0c302b1..5a60b24b3d2c 100755
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
index 2694e4b005b7..dc2f24e7b43c 100755
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
index e5f2dce0f569..f9e736d04712 100755
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
index 88b659093467..076da1036cfd 100644
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


