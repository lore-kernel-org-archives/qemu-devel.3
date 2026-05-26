Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEBCD5BDD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0G-0005DM-Qx; Tue, 26 May 2026 04:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0F-0005Cd-Pm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0D-0007Xo-3n
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4gGzKqYkZPtmFpeWH6+ZIWiEl85pUcGY2JyRRLoYIQ=;
 b=dtAy2R2b3uefbUt0CdX0451O8hkiIrB+Uegfn9o/Y3pdpyDi3n7+wHZJpjEGC+BkBVlpNz
 jshdBwWh6In9rat+Qw9pqwZrfbCuHtiXPOWlIY0hZCLzWB6c3BKF9NBpiweNdYegdON2wB
 ZKyAPiOXkdqdgnnXsycySRk2rc/JwCQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-4zegLKX8OIildaC280HBRw-1; Tue,
 26 May 2026 04:19:00 -0400
X-MC-Unique: 4zegLKX8OIildaC280HBRw-1
X-Mimecast-MFC-AGG-ID: 4zegLKX8OIildaC280HBRw_1779783539
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E75418002E0; Tue, 26 May 2026 08:18:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD3DA180056E; Tue, 26 May 2026 08:18:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: William de Abreu Pinho <williamdapinho@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/37] tests/functional/aspeed: introduce FacebookAspeedTest
Date: Tue, 26 May 2026 10:18:14 +0200
Message-ID: <20260526081848.651835-4-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: William de Abreu Pinho <williamdapinho@gmail.com>

Facebook OpenBMC Images include an early script [1] that lowers the
console log level to warning.  This suppresses the "Hostname set to"
message from the serial console.  Introduce FacebookAspeedTest (a
subclass of AspeedTest), that waits for login prompt instead.  Update
bletchley-bmc and catalina-bmc to use the new class.

This is also used by the anacapa-bmc machine introduced in the following
patch.

[1]: https://github.com/openbmc/openbmc/blob/6a56a45931fb7015a3fc18553415909105b484d6/meta-facebook/recipes-phosphor/initrdscripts/phosphor-static-norootfs-init/999-reduce-printk

Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260519-add-anacapa-machine-v3-1-56c23993a20a@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_bletchley.py | 6 +++---
 tests/functional/arm/test_aspeed_catalina.py  | 6 +++---
 tests/functional/aspeed.py                    | 8 ++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
index 5a60b24b3d2c..3000d0c302b1 100755
--- a/tests/functional/arm/test_aspeed_bletchley.py
+++ b/tests/functional/arm/test_aspeed_bletchley.py
@@ -5,10 +5,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
-from aspeed import AspeedTest
+from aspeed import FacebookAspeedTest
 
 
-class BletchleyMachine(AspeedTest):
+class BletchleyMachine(FacebookAspeedTest):
 
     ASSET_BLETCHLEY_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_bletchley_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    AspeedTest.main()
+    FacebookAspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index dc2f24e7b43c..2694e4b005b7 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -5,10 +5,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
-from aspeed import AspeedTest
+from aspeed import FacebookAspeedTest
 
 
-class CatalinaMachine(AspeedTest):
+class CatalinaMachine(FacebookAspeedTest):
 
     ASSET_CATALINA_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
@@ -22,4 +22,4 @@ def test_arm_ast2600_catalina_openbmc(self):
                                         soc='AST2600 rev A3')
 
 if __name__ == '__main__':
-    AspeedTest.main()
+    FacebookAspeedTest.main()
diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 47e84e035bd0..88b659093467 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -28,6 +28,9 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
         self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
         self.wait_for_console_pattern(f'ASPEED {soc}')
         self.wait_for_console_pattern('/init as init process')
+        self.wait_for_boot_complete(hostname)
+
+    def wait_for_boot_complete(self, hostname):
         self.wait_for_console_pattern(f'systemd[1]: Hostname set to <{hostname}>.')
 
     def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
@@ -69,3 +72,8 @@ def generate_otpmem_image(self):
             f.write(pattern)
         return path
 
+
+class FacebookAspeedTest(AspeedTest):
+
+    def wait_for_boot_complete(self, hostname):
+        self.wait_for_console_pattern(f'{hostname} login:')
-- 
2.54.0


