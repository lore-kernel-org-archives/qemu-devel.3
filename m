Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D2C27C7B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1M3-00040F-2G; Fri, 14 Jun 2024 03:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1M1-0003tr-K8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lz-0000pu-Nw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mT67xMIBp6ZET7ERJdeOwGv7TN1Z8yNGX5Ar50EezKI=;
 b=UOvPM3T04w1AMBO7BJE5LvVCAZPMsqKTkRRiCezy7366fGhVgt0jD9i1IcEKPedgwY0cku
 +mV/aoMdCG88yl/+PaAcobl2y2N4llyuIn7xtc6hUTlk76oM5773t60NERq+M8EUnrVPOC
 nU+pBk77mRecVppNb6si6hHYH4qj+QI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-eLg-FX4vO_yyLe-KG9tiPA-1; Fri,
 14 Jun 2024 03:28:05 -0400
X-MC-Unique: eLg-FX4vO_yyLe-KG9tiPA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C0FE1954208; Fri, 14 Jun 2024 07:28:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C7D43000219; Fri, 14 Jun 2024 07:28:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 17/19] test/avocado/machine_aspeed.py: Add AST2700 test case
Date: Fri, 14 Jun 2024 09:26:18 +0200
Message-ID: <20240614072620.1262053-18-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a test case to test Aspeed OpenBMC SDK v09.01 on AST2700 board.

It loads u-boot-nodtb.bin, u-boot.dtb, tfa and optee-os
images to dram first which base address is 0x400000000.
Then, boot and launch 4 cpu cores.

```
qemu-system-aarch64 -machine ast2700-evb
    -device loader,force-raw=on,addr=0x400000000,file=workdir/u-boot-nodtb.bin \
    -device loader,force-raw=on,addr=uboot_dtb_load_addr,file=workdir/u-boot.dtb\
    -device loader,force-raw=on,addr=0x430000000,file=workdir/bl31.bin\
    -device loader,force-raw=on,addr=0x430080000,file=workdir/optee/tee-raw.bin\
    -device loader,cpu-num=0,addr=0x430000000 \
    -device loader,cpu-num=1,addr=0x430000000 \
    -device loader,cpu-num=2,addr=0x430000000 \
    -device loader,cpu-num=3,addr=0x430000000 \
    -smp 4 \
    -drive file=workdir/image-bmc,format=raw,if=mtd
```

A test image is downloaded from the ASPEED Forked OpenBMC GitHub release repository :
https://github.com/AspeedTech-BMC/openbmc/releases/

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 tests/avocado/machine_aspeed.py | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index cec018142453..3a20644fb2ad 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -311,6 +311,17 @@ def do_test_arm_aspeed_sdk_start(self, image):
             self, 'boot', '## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
 
+    def do_test_aarch64_aspeed_sdk_start(self, image):
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw')
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2023.10')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern("systemd[1]: Hostname set to")
+
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
 
     def test_arm_ast2500_evb_sdk(self):
@@ -375,3 +386,54 @@ def test_arm_ast2600_evb_sdk(self):
              'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
         year = time.strftime("%Y")
         self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
+
+    def test_aarch64_ast2700_evb_sdk_v09_01(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:ast2700-evb
+        """
+
+        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
+                     'download/v09.01/ast2700-default-obmc.tar.gz')
+        image_hash = 'b1cc0fd73c7650d34c9c8459a243f52a91e9e27144b8608b2645ab19461d1e07'
+        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
+                                      algorithm='sha256')
+        archive.extract(image_path, self.workdir)
+
+        num_cpu = 4
+        image_dir = self.workdir + '/ast2700-default/'
+        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
+        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
+
+        load_images_list = [
+            {
+                'addr': '0x400000000',
+                'file': image_dir + 'u-boot-nodtb.bin'
+            },
+            {
+                'addr': str(uboot_dtb_load_addr),
+                'file': image_dir + 'u-boot.dtb'
+            },
+            {
+                'addr': '0x430000000',
+                'file': image_dir + 'bl31.bin'
+            },
+            {
+                'addr': '0x430080000',
+                'file': image_dir + 'optee/tee-raw.bin'
+            }
+        ]
+
+        for load_image in load_images_list:
+            addr = load_image['addr']
+            file = load_image['file']
+            self.vm.add_args('-device',
+                             f'loader,force-raw=on,addr={addr},file={file}')
+
+        for i in range(num_cpu):
+            self.vm.add_args('-device',
+                             f'loader,addr=0x430000000,cpu-num={i}')
+
+        self.vm.add_args('-smp', str(num_cpu))
+        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
+
-- 
2.45.2


