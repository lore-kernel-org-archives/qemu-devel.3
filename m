Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4F2C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH4M-0007Ur-Ke; Sun, 09 Mar 2025 09:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4I-0007T6-Lt
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4G-00025J-TP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KfI8+iFL+27Va8wugF7Ja64Lc6TjMqYF+YS6aGCqw0=;
 b=dLmkJ5nX1dfQionGbCxWB8Ox1fAZwNezOcvSFzlMBvGZEcneDR6DlqBwV9jUxDRC3c9CrD
 PseDd75J0d/xQip4dS1uRMx5AtultRDatTUrfbw6DGvPLhjkihy802SO3NAC1P+/v5ne7q
 7IC0v6xMdEouJQdjEdoqPIb7PNbT4PQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-l0w2qkJWMx6zKFDyxoPBgQ-1; Sun,
 09 Mar 2025 09:51:44 -0400
X-MC-Unique: l0w2qkJWMx6zKFDyxoPBgQ-1
X-Mimecast-MFC-AGG-ID: l0w2qkJWMx6zKFDyxoPBgQ_1741528304
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD20F180035D; Sun,  9 Mar 2025 13:51:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 435E81956095; Sun,  9 Mar 2025 13:51:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/46] tests/functional: Update OpenBMC image of romulus machine
Date: Sun,  9 Mar 2025 14:50:47 +0100
Message-ID: <20250309135130.545764-4-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the new do_test_arm_aspeed_openbmc() routine to run the latest
OpenBMC firmware build of the romulus BMC. Remove the older routine
which is now unused.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250129071820.1258133-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py                  | 16 ----------------
 tests/functional/test_arm_aspeed_romulus.py | 13 +++++++------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index ea75939e05f9..77dc8930fa41 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -7,22 +7,6 @@
 
 class AspeedTest(LinuxKernelTest):
 
-    def do_test_arm_aspeed(self, machine, image):
-        self.set_machine(machine)
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
-                         '-net', 'nic', '-snapshot')
-        self.vm.launch()
-
-        self.wait_for_console_pattern("U-Boot 2016.07")
-        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
-        self.wait_for_console_pattern("Starting kernel ...")
-        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
-        self.wait_for_console_pattern(
-                "aspeed-smc 1e620000.spi: read control register: 203b0641")
-        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
-        self.wait_for_console_pattern("systemd[1]: Set hostname to")
-
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
                                    cpu_id='0x0', soc='AST2500 rev A1'):
         hostname = machine.removesuffix('-bmc')
diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/test_arm_aspeed_romulus.py
index 747b616201ce..b97ed951b1f3 100755
--- a/tests/functional/test_arm_aspeed_romulus.py
+++ b/tests/functional/test_arm_aspeed_romulus.py
@@ -7,18 +7,19 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 
+
 class RomulusMachine(AspeedTest):
 
     ASSET_ROMULUS_FLASH = Asset(
-        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-         'obmc-phosphor-image-romulus.static.mtd'),
-        '820341076803f1955bc31e647a512c79f9add4f5233d0697678bab4604c7bb25')
+        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/romulus-bmc/openbmc-20250128071340/obmc-phosphor-image-romulus-20250128071340.static.mtd',
+        '6d031376440c82ed9d087d25e9fa76aea75b42f80daa252ec402c0bc3cf6cf5b');
 
-    def test_arm_ast2500_romulus_openbmc_v2_9_0(self):
+    def test_arm_ast2500_romulus_openbmc(self):
         image_path = self.ASSET_ROMULUS_FLASH.fetch()
 
-        self.do_test_arm_aspeed('romulus-bmc', image_path)
-
+        self.do_test_arm_aspeed_openbmc('romulus-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0x0',
+                                        soc='AST2500 rev A1');
 
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.48.1


