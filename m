Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C0C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr276-0003LF-4G; Sat, 08 Mar 2025 16:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26z-0003G3-N9
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26x-0000vS-CN
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so1667903f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470814; x=1742075614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP5TiKKy+g7zDm1v/BM9VjWiPBsi9a9+GYKmDxVZNDU=;
 b=tQLgd+dRHbreJppvVDOQZVLx+WAqVNL9RWTlcMDKi1BoMyVy2UgBDTRsUkZJ0a38xl
 JRTCUvEpNT9pvBr7hHr8KejcIBh+0FPoGJKtrUIwtbHnbyXBawAYqpJ1WIoCOx4lhzZ4
 620UQBMdSL1mR5zXrABNN5W4zZlARXNC+zI5MluunL2YlYbgCVtazVComRrLyTZ0l3uO
 fACB7ZpBGIuB9syaoDhc3RZdQgaseLrDqRuRMKDG4cPoCoQ3lEuwljiOZqhvmt/cTE9y
 Lt8J/gTD97u/Vwd0jzCkpSOzzrpSvACI+PuTgn0RThTwkfNuke9x8Sl7lYAapRp1bS8C
 sE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470814; x=1742075614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP5TiKKy+g7zDm1v/BM9VjWiPBsi9a9+GYKmDxVZNDU=;
 b=t/VeBNc76fFbvzQzJBszzDEsWaeaJu4JhG4Z2khwZvmTSgvMLJLZ++v8D5jllflV8R
 aqcgH6HJ0FWEIloM5wp0Grvct2a99vKCSVXz3v/YcJqozs6wi+rFI3G+F9ehglwSq0Vj
 xCdAsA33huldvvbwiITXTVLhVRvIMNx4qAnoCNBb18UDiQxl9T0Q7j7lTPQxqWX6oJof
 L+bT0sXUce9Dke31j4qKeXEI6VhEUhHUks4UuutyxrvoxlS42iCSODpjtlo9cJcn2H36
 2TY0VkeqEPup6SECGDNns08OJFA4mKicWyYdiMogoMpGOuXL9RTzu33oPez14iwu8lRI
 Qu2g==
X-Gm-Message-State: AOJu0Yxx7YvmeuODO19Kc5tXLdzDZDzDuWOaHxQYtKJOeFrKZzmv1iOp
 jHFFycXK5ROtHhT9aawnRT/gXgrrPCUtY63asaEKtr0+8GZbDba8TUbdhUFglto=
X-Gm-Gg: ASbGnctdWTIREHuUuzfg+ROl8EJaoXezd117gDCspFzdw0pFLFaAF09gm3F9yJIaur6
 neEKoSx71VHZzyFNcuDU7tH7igj6Y6UmszfgRowMKi1WkMzv7A6hKl4mX7ti2kUe4hKT8kaRDJj
 7uteWfp6uYT35AXeWf+gMjgCePYnhkfa0SVQ9uUzJ52DcJlVf0iAsA3v+XuBO3VZdbZCvASMtky
 qHZpMfp3xn1/EZfDlPLbeRgH0ydXElxw9Jf49EORm0hKtkTm56oDe78wdcz++NOKu2REQE2d3OV
 XRgmtvDMT13d9I6Jccy42dvhqagaxfr4GFgzG1oCfU1csS5GYazoX0WPew==
X-Google-Smtp-Source: AGHT+IEirWalxOVjPt/KuG1FsttI+w//qnpxKddMslJgsgbCWleV4w4nhSGhRWl0cmzudVS55qRtoQ==
X-Received: by 2002:a5d:47cc:0:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-39132dbb069mr5450159f8f.41.1741470813805; 
 Sat, 08 Mar 2025 13:53:33 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2bacsm9933579f8f.78.2025.03.08.13.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01B0760065;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 05/31] tests/functional: skip vulkan tests with nVidia
Date: Sat,  8 Mar 2025 21:53:00 +0000
Message-Id: <20250308215326.2907828-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-6-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index eea1e8c973..32949f6a34 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -17,6 +17,9 @@
 
 from qemu_test.linuxkernel import LinuxKernelTest
 
+from re import search
+from subprocess import check_output
+
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
     ASSET_VIRT_GPU_KERNEL = Asset(
@@ -94,6 +97,11 @@ def test_aarch64_virt_with_vulkan_gpu(self):
 
         self.require_device('virtio-gpu-gl-pci')
 
+        vk_info = check_output(["vulkaninfo", "--summary"], encoding="utf-8")
+
+        if search(r"driverID\s+=\s+DRIVER_ID_NVIDIA_PROPRIETARY", vk_info):
+            self.skipTest("Test skipped on NVIDIA proprietary driver")
+
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
         self._run_virt_weston_test("vkmark -b:duration=1.0",
                                    "debug: stuck in fence wait with iter at")
-- 
2.39.5


