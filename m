Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53668C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI15-00019f-To; Wed, 26 Feb 2025 09:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0x-0000yF-SA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0u-0005g7-7g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so67384735e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578630; x=1741183430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2xRkDDnfQohyxAsgCKQln4PNyvpl97r1V0oBiZCInQ=;
 b=AQypDvfkyZFm8SBemBEM4MYU/uYBzmHUwLLmzTgvah9XPvz8CUOS6Fh6RnrAdELFO/
 g3+A4dmlwrMBw//3LJBshhuP5kqb2YKqEk227njxnXNLJLyG/JWYuAdth9NxbbLRv+m5
 mNGR7qLt9WRR+gEbSfxbek8aLO0XsOtndnTvjeVpnXw1nGcAppCed4mJuu3RkkYezKub
 x/yiZ0qkOpFvifB2j3SNDoodfGQ3yglOPbMMsFaOh+9IR1TZR761uudUe1UzHM7aFzJ4
 +G8rkAFb9+zvEE2LDTaI1Iy/YvaoeXhuU+ZIxIRQj6oy0AliSsU2bFCFKSxa+0atTKKJ
 9bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578630; x=1741183430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2xRkDDnfQohyxAsgCKQln4PNyvpl97r1V0oBiZCInQ=;
 b=Je/09McEA5DSyUQUm8VPTGJnJ8q2Xhiqv6XmSWFCP/ZtUoakLSPW3la36QZNpFczWd
 CI5QKJHbePug1+O39wm9yDDYyPl5DMDrot1b69WSz4LgbZasKj18tflc3bSfk3/FhpDq
 EXvGLBhNKjHPQQPW1+aP2T8qHmkOH9g7WYoWjGbUDpZ47S6p3h11Lh0cHLPbdhjEjjhu
 o7ys6I+JRlaAzCMNZMyGOApNLtZCdcJJFwnmHMXWguoxs0OAepy1rbyr2mVm0W7pbW+I
 UJyJ8CneMfN5lfJkBZPmoag3RVaBUkKpGIapvsw8gmrUIfPv71uByOQnX6luN8gU3+MB
 Lfeg==
X-Gm-Message-State: AOJu0YxLquju8swqKIGL9jjyzvpsIzoZ/tKqg603aLbFoAqDHMKpd+TT
 DQKxhRuYfdFWrGrUN9cSCrQEHk34GihbPAzLYYC3vu9M2syOICfkmYiLEKu09Hc=
X-Gm-Gg: ASbGncuqwQNXnUbllM0Us5QYIJumjIB+3UTyCeWycv5nv+kmwT7e3Wg0rnWJbzzGkA3
 LoXm7Krn/fR/oENb5d41Efksecv0vQ/6OOEIjqSTyWUqA75alqu8KDzLpXEbDMAh5ZhA1JT2xsF
 KLOLqaHuofarP3TcaefNJNoV6Ejw3y86rdc8fgwOi1zqlwtt+eyKJHU5VEBT0yDnZ7KefrAru7e
 oSifgC7f0ZwbWJsBP/hMrGKaA09P32vnFLQm5EWhTlOW1tuP9cZx3uy3WxvMf/A+SD1v77pBwju
 HNbArd0guSi7RBhYKOzdtEuSoRS8
X-Google-Smtp-Source: AGHT+IGByyGMb/XmFI+zsx74dS+z083dE0NDwFvwEVRfRLW7t4mCyQje2PF4g0yOygQG4y+8giLLjA==
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id
 5b1f17b1804b1-43ab0f42a24mr80584445e9.18.1740578630475; 
 Wed, 26 Feb 2025 06:03:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882a64sm5537849f8f.46.2025.02.26.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A46516034D;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 08/25] tests/functional: skip vulkan tests with nVidia
Date: Wed, 26 Feb 2025 14:03:26 +0000
Message-Id: <20250226140343.3907080-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

While running the new GPU tests it was noted that the proprietary
nVidia driver barfed when run under the sanitiser:

  2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
  EOTF mode SDR and colorimetry mode default.
  2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
  profile: stock sRGB color profile

  and that's the last thing it outputs.

  The sanitizer reports that when the framework sends the SIGTERM
  because of the timeout we get a write to a NULL pointer (but
  interesting not this time in an atexit callback):

  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
  0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
  T471863)
  ==471863==The signal is caused by a WRITE memory access.
  ==471863==Hint: address points to the zero page.
      #0 0x7a18ceaafe80
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #1 0x7a18ce9e72c0
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #2 0x7a18ce9f11bb
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #3 0x7a18ce6dc9d1
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #4 0x7a18e7d15326 in vrend_renderer_create_fence
  /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
      #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd

The #dri-devel channel confirmed:

  <digetx> stsquad: nv driver is known to not work with venus, don't use
      it for testing

So lets skip running the test to avoid known failures.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

---
v2
  - implement block at the test level
---
 tests/functional/test_aarch64_virt_gpu.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 7a8471d1ca..a4ae5777e6 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -9,8 +9,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import logging
-
 from qemu.machine.machine import VMLaunchFailure
 
 from qemu_test import QemuSystemTest, Asset
@@ -18,6 +16,10 @@
 from qemu_test import wait_for_console_pattern
 from qemu_test import skipIfMissingCommands
 
+from re import search
+from subprocess import check_output
+
+
 class Aarch64VirtGPUMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     timeout = 360
@@ -110,10 +112,16 @@ def test_aarch64_virt_with_virgl_blobs_gpu(self):
         self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
 
     @skipIfMissingCommands('zstd')
+    @skipIfMissingCommands('vulkaninfo')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
         self.require_device('virtio-gpu-gl-pci')
 
+        vk_info = check_output(["vulkaninfo", "--summary"], encoding="utf-8")
+
+        if search(r"driverID\s+=\s+DRIVER_ID_NVIDIA_PROPRIETARY", vk_info):
+            self.skipTest("Test skipped on NVIDIA proprietary driver")
+
         gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
         weston_cmd = "vkmark -b:duration=1.0"
         weston_pattern = "vkmark Score"
-- 
2.39.5


