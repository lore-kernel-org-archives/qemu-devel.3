Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AE5E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoS-0008Sp-FG; Wed, 18 Dec 2024 11:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwo1-0007zm-Ad
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:49 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnZ-0006ry-KS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:49 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so1326884866b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538878; x=1735143678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbIajMA3E3GTrFxU+Daap9kPiHkc5XfXpPO7y+547RQ=;
 b=N3P2tDY8UQ9FUmNk4zkUUnJaN5p6bF6XZDBjmTbtL/YM61LWt24FSJnYtoDrqfruxv
 27Pk2v6/ByjIH9ZEYToXMAMKD7CWReicEDjISLq1NTd90GcuKxuyYGrquimba4VuMAuN
 HJ7YuAPOT54gwQH06+1L7kY6yrV190JDs/7QgwZFSiZqjQ1PzxAV7JG6uTCsyLuVLd9E
 LD8epxOzhfQA9G2d9XnjJ543TGqYzLFl86LXcympr2a39/xagEUrlZ0XSwvHzX8o+e7I
 fcVVTEQ2E8UH20cRNPDAj+g6rsO8gE7pvFDQGQsaedt9BSiXmCyYQD3qLNX2dNwKjd0c
 a6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538878; x=1735143678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbIajMA3E3GTrFxU+Daap9kPiHkc5XfXpPO7y+547RQ=;
 b=S9c5qOnh83+qBYBRkfQyhTlksOqOoEQOBYd8E9lsKgPMn5xf5K3ho/NyP4yx1TdOGc
 gOEdamX2pFf5K7z30fcrO2IsQu+UTQFTCA7Lq2RrP9keunOtiXnuozHGXieD/sS+clD2
 cEFtaP1tvdtefyIp+VHLoov92gHUzFnSbIHW02FL816qfR0ILqcnAXxRNHDE19PBwiAn
 SEc1/YGNtLduqN1haUECIVUwiSvEKsXcnRBt8MqVA796idEt/3YESkQTraUzqo46FiKi
 U5Y371zChx9b7C33ETKJpgSGAD8254yDxOFDWCmtSwYj+lP09/FUfdQne+2ZU6p1OlO4
 ytag==
X-Gm-Message-State: AOJu0YzwB3uU+J2STUZqy40PkyhmBISa3/KVi5/rrXp7kRZcygbL+TeQ
 GYYKrri0xKz8A/509uZ8DjZdZpbHpwxfJkSEPr20mW5IucHOUXuTZhP50oCheNo=
X-Gm-Gg: ASbGnctvVIxnVRxtH60LiX/CFbkdofnHUrE+DEPTLf3fEI/90tQ1outVqi08O6CO3xA
 MrRRGoyjaB9/ZTVZYQImdyqwW68vF/WSQH2XyBsus+r6Wc3biCnvvfaaqU1CxF65giAL+ErhCl8
 ErlAtkf2rau60NFkcu/zA1YoOwcjzx1lquV+rVK/qXHyOTOf79zn9PjzxOds4jTYeOSg4zr52RJ
 DwmXr/Q+yor9OWQVVo6de+0oWrMdyH2jV8MRm+7vXi9FyGRVCqnsos=
X-Google-Smtp-Source: AGHT+IGV5gAclFKkhebwGJqSJnRG+/Cc/aTLLbVkx+me2jgc1mgkQSTr13Ltv7daxK9OdHcavT3Y8A==
X-Received: by 2002:a17:907:7fa4:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-aabf48d52afmr296990066b.46.1734538877632; 
 Wed, 18 Dec 2024 08:21:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96006b34sm572991366b.13.2024.12.18.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17B4260B86;
 Wed, 18 Dec 2024 16:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 20/27] tests/functional: extend test_aarch64_virt with
 vulkan test
Date: Wed, 18 Dec 2024 16:20:56 +0000
Message-Id: <20241218162104.3493551-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Now we have virtio-gpu Vulkan support lets add a test for it.
Currently this is using images build by buildroot:

  https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use decorator for has_cmd(zstd)
  - move set_machine/require_accelerator to top of test
  - un-handled->unhandled
  - drop extra - from --snapshot
  - drop unneeded virtualization=on
  - only show 1s of each scene
  - fix long lines
---
 tests/functional/test_aarch64_virt.py | 84 ++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 453e84c39f..4ac66905b8 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -13,11 +13,14 @@
 import os
 import logging
 
+from qemu.machine.machine import VMLaunchFailure
+
 from qemu_test import BUILD_DIR
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
-from qemu_test import get_qemu_img, run_cmd
-
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import has_cmd, get_qemu_img, run_cmd
+from unittest import skipUnless
 
 class Aarch64VirtMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -101,7 +104,9 @@ def common_aarch64_virt(self, machine):
 
         # Add the device
         self.vm.add_args('-blockdev',
-                         f"driver=qcow2,file.driver=file,file.filename={image_path},node-name=scratch")
+                         "driver=qcow2,file."
+                         "driver=file,file."
+                         f"filename={image_path},node-name=scratch")
         self.vm.add_args('-device',
                          'virtio-blk-device,drive=scratch')
 
@@ -130,5 +135,78 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
+    ASSET_VIRT_GPU_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+         'download?path=%2F&files='
+         'Image'),
+        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset(
+        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+         'download?path=%2F&files='
+         'rootfs.ext4.zstd'),
+        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+
+    @skipUnless(*has_cmd('zstd'))
+    def test_aarch64_virt_with_gpu(self):
+        # This tests boots with a buildroot test image that contains
+        # vkmark and other GPU exercising tools. We run a headless
+        # weston that nevertheless still exercises the virtio-gpu
+        # backend.
+
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
+        image_path_zst = self.ASSET_VIRT_GPU_ROOTFS.fetch()
+        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
+
+        image_path = self.workdir + "/rootfs.ext4"
+
+        run_cmd(['zstd', "-f", "-d", image_path_zst,
+                 "-o", image_path])
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0 root=/dev/vda')
+
+        self.vm.add_args("-accel", "tcg")
+        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-machine", "virt,gic-version=max",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "2048")
+        self.vm.add_args("-device",
+                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-display", "egl-headless")
+        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
+        self.vm.add_args("-blockdev",
+                         "driver=raw,file.driver=file,"
+                         "node-name=hd0,read-only=on,"
+                         f"file.filename={image_path}")
+        self.vm.add_args("-snapshot")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "old virglrenderer, blob resources unsupported" in excp.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in excp.output:
+                self.skipTest("No venus support for virtio-gpu")
+            else:
+                self.log.info("unhandled launch failure: {excp.output}")
+                raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command(self, 'root')
+        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
+        exec_command_and_wait_for_pattern(self,
+                                          "weston -B headless "
+                                          "--renderer gl "
+                                          "--shell kiosk "
+                                          "-- vkmark -b:duration=1.0",
+                                          "vkmark Score")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


