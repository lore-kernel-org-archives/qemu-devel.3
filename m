Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C840C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6jI-0000sl-0X; Mon, 03 Feb 2025 19:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6jF-0000ha-Ri
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6jD-000784-E7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso5215138f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628625; x=1739233425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hQiwa2G4uGjFgckcI0Yx0+nxXdng0uMBIPPXR9mbN0=;
 b=KXmV0YLORGdBchskuC28+TKYuHyS+RDSw0/1/1dbNZvMsOvjZPSvn0KQ9En/U/Nyxf
 u/mAZttXv9BSgadyALVCmwTHuGPDL4w+/lb+112StiNXa9p6H4ovHrdDKC9e8THKVptw
 OQUZRE4y6BXCi5sCzIEg5i2vbaWKPVY4Z//T24g1oZhCSQBmPOsNgp691C3IFqS2epAG
 MUI5X00ZMggKZo7VpaituW41A9By39bG/izOqWNMRr+AHaTrnIkF+WCvVHWXEzyrKwJf
 ewsxg7cgvczrrG7T+32L0HDiwYkwSwFypnxrkVii0smQTLiqokMhpz1YWGz88XGf+GRi
 r5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628625; x=1739233425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hQiwa2G4uGjFgckcI0Yx0+nxXdng0uMBIPPXR9mbN0=;
 b=W3VGEnXJbxqp0c22JsaCx8wkjXSIOnmhcOYEFZDyS5lkY3S0ot43VyBnySydueqMse
 9/OFo9OBGNOR8DVcwfVFGmyeRJOFY3rYRdPFzLZry5xE5Z2mXdtTKLkVJE/PzfjO0Quw
 r5Ulv02f+kStiyXvG7J9ybfEsyfwxzOGeuJcbvC28dYBw4o8eFzn1uDatYQ9HWyRy9sV
 Ivk9+ORXxJHLkKkJ3jHmjJXnfyQJRcDMuoSf4wEUX3Z97O2UX2yEdJzlWB0W9rUN7lbI
 njiJvLQPcoNvhnnsi5f8tULWP1udX+4YvIm88cqFGBb199iq/Vu3+fITMIp9Shs+L7Zr
 4h1Q==
X-Gm-Message-State: AOJu0Yx5IZd4F7Ot7VrCWQLrkrhIwemhdz+qLo9s3XObyMqrqz0C0Rlt
 ts1xxk/uhPocfNOASfoWyQuUQkukb1/s9qZm1HAOLvptT5Sew5VHxt0WNA/Q3DmPuhGt/+jcaDm
 OWBM=
X-Gm-Gg: ASbGncvZW7ftWwnvuc9JzmtP+zuDR4SJ4fvEtUgagDX6lYK9vWptrvto9WlU8QXSE4y
 sQrBplTtJYDM+wQ66ZVDNyA0RK6VyOJmmWjel+LpiMJu04UYOnIukUvG/8tauXPi52bppM6fnLP
 mGKKYtgmYWK9uHAEQjWA6clQ3Yblt07w+QUEu1bIhPVl5MwIt9kI6AkkcwC8eGYjPH2le3HI1na
 VU/w8NTuUpoIbHk8R+hORodhzfiLazBJLoyMjWAxyAg5P5VTGoF+CAK/krSDnDV9PYoOgEhHAok
 X08apypI1zeYP3dft4cEdtk8vMZL2SY8nCKZ0tnaqg7A6AMyRIobcB2POASIvZ3kAw==
X-Google-Smtp-Source: AGHT+IGlQD4ZmGLKUil5WfVZGYdxEsJmCOEa6i0RsnTR0Suea1nAcU2pJ0fJ4ozP82WDv94mnLgENA==
X-Received: by 2002:a05:6000:186f:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38c520a34b6mr25211298f8f.46.1738628625510; 
 Mon, 03 Feb 2025 16:23:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c11fadbsm13895097f8f.44.2025.02.03.16.23.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
Date: Tue,  4 Feb 2025 01:22:39 +0100
Message-ID: <20250204002240.97830-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All previous raspi machines can be created using the
generic machine. Deprecate the old names to maintain
a single one. Update the tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
QOM HMP introspection test fails because without the 'model'
argument set, no machine is created...

  $ qemu-system-aarch64 -M raspi
  qemu-system-aarch64: Missing model, try -M raspi,model=help
---
 docs/about/deprecated.rst               | 13 +++++++++++++
 hw/arm/raspi.c                          |  5 +++++
 tests/qtest/bcm2835-dma-test.c          |  2 +-
 tests/qtest/bcm2835-i2c-test.c          |  2 +-
 tests/qtest/boot-serial-test.c          |  3 ++-
 tests/functional/test_aarch64_raspi3.py |  5 ++---
 tests/functional/test_aarch64_raspi4.py |  4 ++--
 tests/functional/test_arm_raspi2.py     |  4 ++--
 8 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962a..c9a11a52f78 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
 Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
 CPUs. Big endian support is not tested.
 
+ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and ``raspi4b`` machines (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Raspberry Pi machines have been unified under the generic ``raspi`` machine,
+which takes the model as argument.
+
+    - `raspi0`` is now an alias for ``raspi,model=Zero``
+    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
+    - `raspi2b`` is now an alias for ``raspi,model=2B``
+    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
+    - `raspi3b`` is now an alias for ``raspi,model=3B``
+    - `raspi4b`` is now an alias for ``raspi,model=4B``
+
 Backend options
 ---------------
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 8cae1ff6f93..86ecc988e06 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -637,6 +637,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = 0x920092; /* Revision 1.2 */
     raspi_machine_class_init(mc, rmc->board_rev);
+    mc->deprecation_reason = "-M raspi,model=Zero";
 };
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
@@ -646,6 +647,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = 0x900021; /* Revision 1.1 */
     raspi_machine_class_init(mc, rmc->board_rev);
+    mc->deprecation_reason = "-M raspi,model=A+ (-m 512m)";
 };
 
 static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
@@ -655,6 +657,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = 0xa21041;
     raspi_machine_class_init(mc, rmc->board_rev);
+    mc->deprecation_reason = "-M raspi,model=2B -m 1g";
 };
 
 #ifdef TARGET_AARCH64
@@ -665,6 +668,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
     raspi_machine_class_init(mc, rmc->board_rev);
+    mc->deprecation_reason = "-M raspi,model=3A+ -m 512m";
 };
 
 static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
@@ -674,6 +678,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
+    mc->deprecation_reason = "-M raspi,model=3B -m 1g";
 };
 
 static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
diff --git a/tests/qtest/bcm2835-dma-test.c b/tests/qtest/bcm2835-dma-test.c
index 18901b76d21..705e6b2362b 100644
--- a/tests/qtest/bcm2835-dma-test.c
+++ b/tests/qtest/bcm2835-dma-test.c
@@ -111,7 +111,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/bcm2835/dma/test_interrupts",
                    bcm2835_dma_test_interrupts);
-    qtest_start("-machine raspi3b");
+    qtest_start("-machine raspi,model=3B -m 1g");
     ret = g_test_run();
     qtest_end();
     return ret;
diff --git a/tests/qtest/bcm2835-i2c-test.c b/tests/qtest/bcm2835-i2c-test.c
index 15991949260..15904abf393 100644
--- a/tests/qtest/bcm2835-i2c-test.c
+++ b/tests/qtest/bcm2835-i2c-test.c
@@ -104,7 +104,7 @@ int main(int argc, char **argv)
     }
 
     /* Run I2C tests with TMP105 slaves on all three buses */
-    qtest_start("-M raspi3b "
+    qtest_start("-M raspi,model=3B -m 1g "
                 "-device tmp105,address=0x50,bus=i2c-bus.0 "
                 "-device tmp105,address=0x50,bus=i2c-bus.1 "
                 "-device tmp105,address=0x50,bus=i2c-bus.2");
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index a05d26ee996..fbafd73facb 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -188,7 +188,8 @@ static const testdef_t tests[] = {
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
-    { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
+    { "arm", "raspi,model=2B -m 1g", "", "TT",
+      sizeof(bios_raspi2), 0, bios_raspi2 },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
index 74f6630ed26..05766d93b3f 100755
--- a/tests/functional/test_aarch64_raspi3.py
+++ b/tests/functional/test_aarch64_raspi3.py
@@ -21,10 +21,9 @@ def test_aarch64_raspi3_atf(self):
         efi_name = 'RPI_EFI.fd'
         efi_fd = self.archive_extract(self.ASSET_RPI3_UEFI, member=efi_name)
 
-        self.set_machine('raspi3b')
+        self.set_machine('raspi,model=3B -m 1g')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-cpu', 'cortex-a53',
-                         '-nodefaults',
+        self.vm.add_args('-nodefaults',
                          '-device', f'loader,file={efi_fd},force-raw=true')
         self.vm.launch()
         self.wait_for_console_pattern('version UEFI Firmware v1.15')
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index 7a4302b0c5a..3becee9333a 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -34,7 +34,7 @@ def test_arm_raspi4(self):
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='boot/bcm2711-rpi-4-b.dtb')
 
-        self.set_machine('raspi4b')
+        self.set_machine('raspi,model=4B -m 1g')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=pl011,mmio32,0xfe201000 ' +
@@ -64,7 +64,7 @@ def test_arm_raspi4_initrd(self):
                                         member='boot/bcm2711-rpi-4-b.dtb')
         initrd_path = self.uncompress(self.ASSET_INITRD)
 
-        self.set_machine('raspi4b')
+        self.set_machine('raspi,model=4B -m 1g')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=pl011,mmio32,0xfe201000 ' +
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index d3c7aaa39b0..37390a9c360 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -39,7 +39,7 @@ def do_test_arm_raspi2(self, uart_id):
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='boot/bcm2709-rpi-2-b.dtb')
 
-        self.set_machine('raspi2b')
+        self.set_machine('raspi,model=2B -m 1g')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                serial_kernel_cmdline[uart_id] +
@@ -65,7 +65,7 @@ def test_arm_raspi2_initrd(self):
                                         member='boot/bcm2709-rpi-2-b.dtb')
         initrd_path = self.uncompress(self.ASSET_INITRD)
 
-        self.set_machine('raspi2b')
+        self.set_machine('raspi,model=2B -m 1g')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=pl011,0x3f201000 console=ttyAMA0 '
-- 
2.47.1


