Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42937C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 11:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSDGB-0001nK-5o; Thu, 19 Jun 2025 07:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSDG8-0001n3-V8
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 07:16:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSDG7-0006u2-2X
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 07:16:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a528243636so437845f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750331800; x=1750936600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VsV7XSYlhVGZ9HquleMGhubOrNSe9ZmrMCHxUfeGJWw=;
 b=nvStZf1pwLw+93WZAuUJExI77dcv/qgnO+V6GpVBvrjsw4ICdqpKbf7jQO2R6nAgMN
 KDz7G8eC/YcGrVTOlN6yTUPyt8WN09ql8foEDNaivc1okC7xDtaEqu9++10Jj3Aoq1is
 aO1EZ/DXEFW6c+dWrVzTPGBpDVE3fNB4yZH7t4TH9rvKY02ZGExHCJetbROksbTz9G8F
 b3BGX9NoIaCHGVs2+zwU7KWJugQYxlEma1H3zjQ1OMFFtvk+q2n6ts+lgASVe1tVg+i9
 uMAPaqqvm11LcwFPuGVbtpAavbI8FEwuautRXg3p+fl9wP0ZHRLBIvCk10iaQeDXrWkM
 pIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750331800; x=1750936600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VsV7XSYlhVGZ9HquleMGhubOrNSe9ZmrMCHxUfeGJWw=;
 b=L3WCqEpoufiAaDJ+9T9WJQ4YSsWxcNcLGU5nn+EKfHhqn5VrGEr8NG8N0LnMGM1Onm
 2E7sIeOqoi/ltcI8DXkGtcj25YNBMylFqCmTZR+8U8rcNI32SJQNGcbiN29yDTSUOoLd
 qcekOCJrCYJQNa9DztZ0LrTAq0v3sUooM6iWfKyzU8GLluyPl96akmbVNjLkWJPq8vLZ
 vxDvomsn0Gd/4SqK6Ki7ULNaXRAg43EvtFr9oENQENw4e2MaxM31paypBDX6YbAhWM6C
 uFDheh742NxKKPkVNjuGlb5+seKzcFlQmqt18MfntNnD4WNzGbjOoGLtFVZ6oVTu+K+b
 hN4g==
X-Gm-Message-State: AOJu0Yy2GSgyeYfZufO8S8rkIGN8SJRGc0U5UTnny1/h9Y3Bs2Ulmqob
 DPuuOOnNr1ktT2h36q06mChlnfZxrrjpFVbI3O5Ijdgp7jBmp5UPUX77/tSZOM8rLxK+9hOka8D
 /5OkHnIo=
X-Gm-Gg: ASbGnctLLEmFr+GFdd5d8ipeLrLivjZI72j7GUf8kEt6JZNDGAzHPFXTq8t9MRoM9r3
 sMzWRmSHE0+XwXsKzOEDar0A2CgwICPdNpCocmOGbCeorehdAQWQ7sYgcll9VJ9SOhjrqJaVaQr
 WJFYZvEdA96ZtU/UlsxQHZojzTHUD/hcLZnSBwfOapAXfCILlG05eltQqjx/lYVTHuLLpHNFRY5
 BRWuLczYtT7JZEtWXSy7rJvMWtld1Vtu6i52tzhv3elYGSldJdkGCfqxKynNxFRpzGAjE8LuLpg
 2o1Ql0e4aq3u1BCSkch/ORfg8I9vuIucC/XAUOXbl+f8i6q6+zZSsNrVIOeeHHY=
X-Google-Smtp-Source: AGHT+IE/LxOporILaIJQnp+eEQSo0ewsMfL1X3aVk7Rz+YJb2CgbMjcnYakWS01ZbhvWEX5of3LTpg==
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47ba with SMTP id
 ffacd0b85a97d-3a572e925c6mr17694768f8f.44.1750331800461; 
 Thu, 19 Jun 2025 04:16:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm18818851f8f.89.2025.06.19.04.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 04:16:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 305AF5F713;
 Thu, 19 Jun 2025 12:16:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] pc-bios/meson: split blobs by available targets
Date: Thu, 19 Jun 2025 12:16:32 +0100
Message-ID: <20250619111632.1076331-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While building some kvm-unit-tests inside a buildroot environment I
noticed the QEMU installer installs all blobs regardless of the
enabled targets. Buildroot images typically try and keep filesystem
and thin as possible we probably should skip blobs that will never be
used.

We could also go further and refer to enabled devices to further
filter out things like option roms.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 pc-bios/meson.build | 202 ++++++++++++++++++++++++++++----------------
 1 file changed, 129 insertions(+), 73 deletions(-)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 3c41620044..cb0b59fbce 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -1,19 +1,36 @@
 roms = []
 if unpack_edk2_blobs
-  fds = [
-    'edk2-aarch64-code.fd',
-    'edk2-arm-code.fd',
-    'edk2-arm-vars.fd',
-    'edk2-riscv-code.fd',
-    'edk2-riscv-vars.fd',
-    'edk2-i386-code.fd',
-    'edk2-i386-secure-code.fd',
-    'edk2-i386-vars.fd',
-    'edk2-x86_64-code.fd',
-    'edk2-x86_64-secure-code.fd',
-    'edk2-loongarch64-code.fd',
-    'edk2-loongarch64-vars.fd',
-  ]
+
+  fds = []
+  if 'aarch64-softmmu' in target_dirs
+    fds += [ 'edk2-aarch64-code.fd' ]
+  endif
+
+  if 'arm-softmmu' in target_dirs or 'aarch64-softmmu' in target_dirs
+    fds += [ 'edk2-arm-code.fd',
+             'edk2-arm-vars.fd' ]
+  endif
+
+  if 'riscv64-softmmu' in target_dirs
+    fds += [ 'edk2-riscv-code.fd',
+             'edk2-riscv-vars.fd' ]
+  endif
+
+  if 'i386-softmmu' in target_dirs
+    fds += [ 'edk2-i386-code.fd',
+             'edk2-i386-secure-code.fd',
+             'edk2-i386-vars.fd' ]
+  endif
+
+  if 'x86_64-softmmu' in target_dirs
+    fds += [ 'edk2-x86_64-code.fd',
+             'edk2-x86_64-secure-code.fd' ]
+  endif
+
+  if 'loongarch64' in target_dirs
+    fds += [ 'edk2-loongarch64-code.fd',
+             'edk2-loongarch64-vars.fd' ]
+  endif
 
   foreach f : fds
     roms += custom_target(f,
@@ -27,65 +44,104 @@ if unpack_edk2_blobs
   endforeach
 endif
 
-blobs = [
-  'ast27x0_bootrom.bin',
-  'bios.bin',
-  'bios-256k.bin',
-  'bios-microvm.bin',
-  'qboot.rom',
-  'vgabios.bin',
-  'vgabios-cirrus.bin',
-  'vgabios-stdvga.bin',
-  'vgabios-vmware.bin',
-  'vgabios-qxl.bin',
-  'vgabios-virtio.bin',
-  'vgabios-ramfb.bin',
-  'vgabios-bochs-display.bin',
-  'vgabios-ati.bin',
-  'openbios-sparc32',
-  'openbios-sparc64',
-  'openbios-ppc',
-  'QEMU,tcx.bin',
-  'QEMU,cgthree.bin',
-  'pxe-e1000.rom',
-  'pxe-eepro100.rom',
-  'pxe-ne2k_pci.rom',
-  'pxe-pcnet.rom',
-  'pxe-rtl8139.rom',
-  'pxe-virtio.rom',
-  'efi-e1000.rom',
-  'efi-eepro100.rom',
-  'efi-ne2k_pci.rom',
-  'efi-pcnet.rom',
-  'efi-rtl8139.rom',
-  'efi-virtio.rom',
-  'efi-e1000e.rom',
-  'efi-vmxnet3.rom',
-  'qemu-nsis.bmp',
-  'multiboot.bin',
-  'multiboot_dma.bin',
-  'linuxboot.bin',
-  'linuxboot_dma.bin',
-  'kvmvapic.bin',
-  'pvh.bin',
-  's390-ccw.img',
-  'slof.bin',
-  'skiboot.lid',
-  'pnv-pnor.bin',
-  'palcode-clipper',
-  'u-boot.e500',
-  'u-boot-sam460-20100605.bin',
-  'qemu_vga.ndrv',
-  'edk2-licenses.txt',
-  'hppa-firmware.img',
-  'hppa-firmware64.img',
-  'opensbi-riscv32-generic-fw_dynamic.bin',
-  'opensbi-riscv64-generic-fw_dynamic.bin',
-  'npcm7xx_bootrom.bin',
-  'npcm8xx_bootrom.bin',
-  'vof.bin',
-  'vof-nvram.bin',
-]
+blobs = []
+
+if 'aarch64-softmmu' in target_dirs
+  blobs += [ 'ast27x0_bootrom.bin',
+             'npcm7xx_bootrom.bin',
+             'npcm8xx_bootrom.bin' ]
+endif
+
+# Most x86 blobs start in real mode anyway, need to check which blobs
+# are x86_64 only. Also we could limit the option roms based on the
+# build config.
+if 'x86_64-softmmu' in target_dirs or 'i386-softmmu' in target_dirs
+  blobs += [ 'bios.bin',
+             'bios-256k.bin',
+             'bios-microvm.bin',
+             'qboot.rom',
+             'vgabios.bin',
+             'vgabios-cirrus.bin',
+             'vgabios-stdvga.bin',
+             'vgabios-vmware.bin',
+             'vgabios-qxl.bin',
+             'vgabios-virtio.bin',
+             'vgabios-ramfb.bin',
+             'vgabios-bochs-display.bin',
+             'vgabios-ati.bin',
+             'pxe-e1000.rom',
+             'pxe-eepro100.rom',
+             'pxe-ne2k_pci.rom',
+             'pxe-pcnet.rom',
+             'pxe-rtl8139.rom',
+             'pxe-virtio.rom',
+             'efi-e1000.rom',
+             'efi-eepro100.rom',
+             'efi-ne2k_pci.rom',
+             'efi-pcnet.rom',
+             'efi-rtl8139.rom',
+             'efi-virtio.rom',
+             'efi-e1000e.rom',
+             'efi-vmxnet3.rom',
+             'multiboot.bin',
+             'multiboot_dma.bin',
+             'linuxboot.bin',
+             'linuxboot_dma.bin',
+             'kvmvapic.bin',
+             'pvh.bin' ]
+endif
+
+if 'sparc32-softmmu' in target_dirs
+  blobs += [ 'openbios-sparc32',
+             'QEMU,tcx.bin',
+             'QEMU,cgthree.bin' ]
+endif
+
+if 'sparc64-softmmu' in target_dirs
+  blobs += [ 'openbios-sparc64' ]
+endif
+
+if 'ppc64-softmmu' in target_dirs
+  blobs += [ 'openbios-ppc',
+             'slof.bin',
+             'skiboot.lid',
+             'pnv-pnor.bin',
+             'u-boot.e500',
+             'u-boot-sam460-20100605.bin',
+             'vof.bin',
+             'vof-nvram.bin' ]
+endif
+
+if 'ppc32-softmmu' in target_dirs
+  blobs += [ 'qemu_vga.ndrv' ]
+endif
+
+if host_os == 'windows'
+  blobs += [ 'qemu-nsis.bmp' ]
+endif
+
+if 's390x-softmmu' in target_dirs
+  blobs += [ 's390-ccw.img' ]
+endif
+
+if 'alpha-softmmu' in target_dirs
+  blobs += [ 'palcode-clipper' ]
+endif
+
+if 'hppa-softmmu' in target_dirs
+  blobs += [ 'hppa-firmware.img',
+             'hppa-firmware64.img' ]
+endif
+
+if 'riscv32-softmmu' in target_dirs
+  blobs += [ 'opensbi-riscv32-generic-fw_dynamic.bin' ]
+endif
+
+if 'riscv64-softmmu' in target_dirs
+  blobs += [ 'opensbi-riscv64-generic-fw_dynamic.bin' ]
+endif
+
+blobs += [ 'edk2-licenses.txt' ]
 
 if get_option('install_blobs')
   install_data(blobs, install_dir: qemu_datadir, install_mode: 'rw-r--r--')
-- 
2.47.2


