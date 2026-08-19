Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DDDC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdn-00080g-92; Wed, 19 Aug 2026 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOG-0004cK-Ab; Wed, 19 Aug 2026 08:27:32 -0400
Received: from outbound.soverin.net ([185.233.34.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOE-0003Ai-9W; Wed, 19 Aug 2026 08:27:32 -0400
Received: from smtp.freedom.nl (unknown [10.10.4.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4hQ5S03FCGz1Plr;
 Wed, 19 Aug 2026 12:27:28 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl
 (Postfix) with ESMTPSA id 4hQ5Rz1r9vzQQ; 
 Wed, 19 Aug 2026 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fvhovell.nl;
 s=soverin; t=1787142448;
 bh=Zt7X8g+BYQeA6Fi9nt+gvcWUPGKEFYNiUind+mA1MXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qI6M9HRyXbPO3JfurIO6FjaeEfwY2Za1tAPXbYbT3NqygN9lav2ox3Lt9RTzvJ8UV
 NqDDnUT7YM55URXpNQKrjFHFDvdgu7D+6VePrCLhRvLY7bL4G2PoDNrGXHD6DVdQXx
 2TK+EITtHIT7y8dr6gDJ/4v0Nd3zg9UKU0VLvdTNCTafxAE6wx89v9XQ2TX8CwqDsF
 uJAXizKf+JiqYh1/nAqB5BWMIN/5KuoXDCnBMJsX/lUatZ0KPVX6Z3qbe1aMYrp4jk
 SNSGb8KY3W0ju5Ry2k/KrBYV4J71CLhAEy5ZK17JWWgsySPYM6N7iV1cXHt/Gk/NjU
 T6Abh7apMlLWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fvhovell.nl; s=soverin1;
 t=1787142448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyMUscUJzQccMg0Dy0oDzVQzZKQaEVKGa0eTI94X+pI=;
 b=c1V6UABa+0F5j+z6cw7BFSxMRvmowrYTryc06Zi2C3+6oSnVwD+9+FkEhcz2wLiugcztoY
 EeVtF6Dp2AW3MuoVO5rdzuyKRJWyk+knTvazgYp30yZfLHSDV1dVumolslaFCleXYBqh0l
 VhoqmqllFARTBS4xmVg14SFchbTdCnjhSZPYv/7ogBu3YWEqMxUD0cAE2Q86fTFWWv9/J8
 3s3M4/jmSELlsIk2HJhvziZb7Je7Nmj4zm+XVx1meuDIp/1uE5dLq6HiqOn42/K/DaL367
 1xxd9mT/IP78/0zz5+JFnEbA6cMXLbys266cQR1OispxDAQmVjV3/pOLw0SyHA==
X-CM-Envelope: MS4xfM9TyRmFwhdpQV/GijNsnd4ecDiIrM5ZeyZXZDNd65cPLys/Foo3Cmg4XLf7rgwku2BN+XH8tjSjvrBhPdJsagJ+zdu56ri6NUCEWTa30RxArp60DaEg
 XNCEJuMXhAtmt91iBdXSx1lY4Yq3A0+0b7XRW2uFa4sGU1upMwvgguJ5ixQlJb00f7nKxX9CRnLQsNDu47oOZhfRKTHa2deAYj5EE6D31afa2h30/5jxzJbS
 hmInZDzXEvb9iq7he+Lu2emvlu2oWXfl157bozC4yRK5SciITwQo3oPnVw89BWgc4BZJpKyTpsuhrauf2SC0G9ptetXEgqXJm1mCRRUAOjxJ1SxYwrR6kr1T
 mBPHKkyoF+jCbY0io0h3n3Ym2evRCk2qvLrgsdj5DlZ67pvLcTw=
X-Soverin-Id: 01a019fd-a380-7816-a0da-d0ce7b19ea72
From: opensource@fvhovell.nl
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>
Subject: [PATCH 3/4] hw/arm/raspi: implement booting firmware at 0x0 using
 -bios on boards 3ap, 3b and 4b
Date: Wed, 19 Aug 2026 14:27:01 +0200
Message-ID: <20260819122702.54173-4-opensource@fvhovell.nl>
In-Reply-To: <20260819122702.54173-1-opensource@fvhovell.nl>
References: <20260819122702.54173-1-opensource@fvhovell.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham
Received-SPF: pass client-ip=185.233.34.18;
 envelope-from=opensource@fvhovell.nl; helo=outbound.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

From: Frederik van Hövell <frederik@fvhovell.nl>

Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
---
 docs/system/arm/raspi.rst               | 12 ++++++++++++
 hw/arm/raspi.c                          | 17 +++++++++++------
 tests/functional/aarch64/test_raspi3.py | 12 ++++++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c33..fb912da129b 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -43,3 +43,15 @@ Missing devices
  * Pulse Width Modulation (PWM)
  * PCIE Root Port (raspi4b)
  * GENET Ethernet Controller (raspi4b)
+
+Boot options
+------------
+
+The Raspberry Pi models support booting via either a Linux kernel (``-kernel``)
+or UEFI/EDK2 firmware images (``-bios rpi_efi.fd``).
+
+When booting Raspberry Pi 3 (``raspi3b``, ``raspi3ap``) and Raspberry Pi 4 (``raspi4b``)
+boards with EDK2 firmware via ``-bios``, the firmware image is loaded at physical
+memory address ``0x0``, matching the platform expectations. Older 32-bit models
+(``raspi0``, ``raspi1ap``, ``raspi2b``) load firmware at their respective legacy addresses
+(``0x8000``).
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428c..c0b177f8cb1 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -33,8 +33,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
-#define FIRMWARE_ADDR_2 0x8000 /* Pi 2 loads kernel.img here by default */
-#define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
+#define KERNEL_ADDR_PI2 0x8000 /* Pi 2 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
 struct RaspiMachineState {
@@ -193,7 +192,7 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
                        RaspiProcessorId processor_id, size_t ram_size)
 {
     RaspiBaseMachineState *s = RASPI_BASE_MACHINE(machine);
-    int r;
+    ssize_t r;
 
     s->binfo.ram_size = ram_size;
 
@@ -226,9 +225,15 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = processor_id <= PROCESSOR_ID_BCM2836
-                             ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
-        /* load the firmware image (typically kernel.img) */
+        hwaddr firmware_addr;
+        if (processor_id <= PROCESSOR_ID_BCM2836) {
+            // For RPi 0/1/2 (arm, 32 bit mode) support kernel.img loading at default address
+            firmware_addr = KERNEL_ADDR_PI2;
+        } else {
+            // For RPi 3 or newer boards (aarch64), support edk2 firmware
+            firmware_addr = 0x0;
+        }
+        /* Load the firmware image (typically kernel.img or edk2 firmware) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr, NULL);
         if (r < 0) {
diff --git a/tests/functional/aarch64/test_raspi3.py b/tests/functional/aarch64/test_raspi3.py
index ae9eed3589f..709c7221fa4 100755
--- a/tests/functional/aarch64/test_raspi3.py
+++ b/tests/functional/aarch64/test_raspi3.py
@@ -29,6 +29,18 @@ def test_aarch64_raspi3_atf(self):
         self.vm.launch()
         self.wait_for_console_pattern('version UEFI Firmware v1.15')
 
+    def test_aarch64_raspi3_bios(self):
+        efi_name = 'RPI_EFI.fd'
+        efi_fd = self.archive_extract(self.ASSET_RPI3_UEFI, member=efi_name)
+
+        self.set_machine('raspi3b')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-cpu', 'cortex-a53',
+                         '-nodefaults',
+                         '-bios', efi_fd)
+        self.vm.launch()
+        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.55.0


