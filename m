Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B4FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf0i-0004ww-Db; Tue, 16 Apr 2024 05:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwezd-0003Yd-S3; Tue, 16 Apr 2024 05:20:47 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwezc-0007iy-5S; Tue, 16 Apr 2024 05:20:45 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 17:19:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 15/16] test/avocado/machine_aspeed.py: Add AST2700 test case
Date: Tue, 16 Apr 2024 17:19:02 +0800
Message-ID: <20240416091904.935283-16-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a test case to test Aspeed OpenBMC SDK v09.01 on AST2700 board.

It loads u-boot-nodtb.bin, u-boot.dtb, tfa and optee-os
images to dram first which base address is 0x400000000.
Then, boot and launch 4 cpu cores.

```
qemu-system-aarch64 -machine ast2700-evb
    -device loader,force-raw=on,addr=0x400000000,file=workdir/u-boot-nodtb.bin \
    -device loader,force-raw=on,addr=uboot_dtb_load_addr,file=u-boot.dtb\
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
---
 tests/avocado/machine_aspeed.py | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index cec0181424..3a20644fb2 100644
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
2.25.1


