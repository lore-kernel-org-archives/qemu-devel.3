Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D9C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpahP-0005bN-MR; Tue, 04 Mar 2025 17:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagy-0005MX-RN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:49 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagw-0006UB-Bn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:48 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e535e6739bso5031276a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127085; x=1741731885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jU9KyNmccT/smoB+ETVGsRZ3o/UDWF2xDiNaobfo+g=;
 b=Va5OHodHbo5xv5zn1yCwgSvUBmOL40ZfFawkMCUek7c928l5xjPdPLyI5sMMT0GkeE
 i3Jev10UeujaCYW+Gao04eZ1xvgEnQmCmYuvuiVEE5oNf/u8Qur/pfWEbtmyRxhVpSth
 n7OWl7ebOobUm8925yJQPskUjkFWVWkhvKctaTlTbPeQJtC4qqSD3nPn+9UonhtwK/4u
 1YT2DBNJRMkxKacy2Yw4571lQCQub8nE7tLToC/dV8MDnAQBz8IKMA6VLXKAZAxppbkr
 pHWA6j+re/DTfL5R7BP3nRx+zfk7jZ65zmy6ffrRIpAUydPpiQ8RWCJwqM91KAXF1zpX
 cqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127085; x=1741731885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jU9KyNmccT/smoB+ETVGsRZ3o/UDWF2xDiNaobfo+g=;
 b=X6h7TVXjwq1sFryLd0ca2UzKhaZKsKQ2GEI2Gel699vJCU88DwrccIyNNCwwCYJExu
 c02BlpwnTT3JgTm6qOp19oWcWP/UInJl/RnWmquMGqlroDQ5RHRup5ymrhIXuLcDcgZ6
 pnG/3n4aEq/aH4nzY1MXDz19zN4NtgI8FltyQUxzEwKN1z4c7Vhr4B4DoIPiZ6G05SYt
 eDQUi5lHRthxLtzudjiZmK24wUWGiG9rLasybqaANOyqZBB+OwRlX8pbdkXouZ+bOdki
 Uj7B3QVGpCEdOQQtvTfrc+gD69pdpjp9/spszAtLXA7yDlEtBUOaStpECDOBHdje/6lJ
 JjAQ==
X-Gm-Message-State: AOJu0YzDMvf5TUTgN2g1GvpWyHxDAmZbxBMQUGpAClHUAusSuCELwkoy
 3GM4tE/fOW9rb+kpyacpJNiTDQxxhXOR2BwKVMfmbfQrYPNMc0IhbX1mpDPBah8=
X-Gm-Gg: ASbGncuCBvX83pVE1bgAiwaIai+EuMeDVGdoOxL+ud8EAI38JTqjqbu5CoRwtDLzQAz
 4/Ybjf0Hkfg+k0+JYCKx8cvJP6a52eo+rxI/eKwWwENEXcpXgBEy1MmBEOzaZ8pdSTsOxht6bqQ
 q1FZuFXuJNftrKOC8vYSN4QA4BAQLOPUDKqLv5bLW2iAdraAh/OAV0uAaBhQNeXeMu57KG5gR37
 YuS8mAhcbUvaCi8QQRf2YFAHYMu/5/MyIMxwYuk6V7lFXVCJZ4alU3dMpLmrvpfCgjyyOB5kkuC
 Q81tSp6Gu0Yp1+h0LZGivPKHu0c4nmfi/+YRVO/c31Toqf0=
X-Google-Smtp-Source: AGHT+IE5F3SwNS1yYIDIrfNQm+QdYZSpAwgRpHfiGBEkVwQyoGILdxKi/YMM/uS4e9VGhvfhmDaedg==
X-Received: by 2002:a05:6402:2546:b0:5d0:bcdd:ffa1 with SMTP id
 4fb4d7f45d1cf-5e59f3632cbmr811042a12.2.1741127084592; 
 Tue, 04 Mar 2025 14:24:44 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b4aa13sm8651808a12.7.2025.03.04.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 937005FC1A;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 02/32] tests/functional: factor out common code in gpu test
Date: Tue,  4 Mar 2025 22:24:09 +0000
Message-Id: <20250304222439.2035603-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

In preparation for handling more tests split out the common machine
setup details from the test specific stuff and add a helper for
launching the weston test. Instead of searching for "vkmark score" we
set a custom PS1 and wait for a successful completion. This ensures we
capture the score in the console log which otherwise wouldn't log
anything.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250226140343.3907080-3-alex.bennee@linaro.org>

---
v2
  - don't be cute with the -display options
  - dropped r-b as I factored more
  - split into _launch_virt_gpu and _run_weston_test
  - detect PS1 success
---
 tests/functional/test_aarch64_virt_gpu.py | 38 +++++++++++++----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 616e6ed656..bd325577c0 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -12,7 +12,7 @@
 from qemu.machine.machine import VMLaunchFailure
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
 from qemu_test import skipIfMissingCommands
 
 from qemu_test.linuxkernel import LinuxKernelTest
@@ -31,12 +31,7 @@ class Aarch64VirtGPUMachine(LinuxKernelTest):
         'rootfs.ext4.zstd',
         '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
 
-    @skipIfMissingCommands('zstd')
-    def test_aarch64_virt_with_vulkan_gpu(self):
-        # This tests boots with a buildroot test image that contains
-        # vkmark and other GPU exercising tools. We run a headless
-        # weston that nevertheless still exercises the virtio-gpu
-        # backend.
+    def _launch_virt_gpu(self, gpu_device):
 
         self.set_machine('virt')
         self.require_accelerator("tcg")
@@ -54,10 +49,10 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "2048")
-        self.vm.add_args("-device",
-                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-device", gpu_device)
         self.vm.add_args("-display", "egl-headless")
         self.vm.add_args("-display", "dbus,gl=on")
+
         self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
         self.vm.add_args("-blockdev",
                          "driver=raw,file.driver=file,"
@@ -81,14 +76,23 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                 raise excp
 
         self.wait_for_console_pattern('buildroot login:')
-        exec_command(self, 'root')
-        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
-        exec_command_and_wait_for_pattern(self,
-                                          "weston -B headless "
-                                          "--renderer gl "
-                                          "--shell kiosk "
-                                          "-- vkmark -b:duration=1.0",
-                                          "vkmark Score")
+        ec_and_wait(self, 'root', '#')
+
+    def _run_virt_weston_test(self, cmd):
+
+        # make it easier to detect successful return to shell
+        PS1 = 'RES=[$?] # '
+        OK_CMD = 'RES=[0] # '
+
+        ec_and_wait(self, 'export XDG_RUNTIME_DIR=/tmp', '#')
+        ec_and_wait(self, f"export PS1='{PS1}'", OK_CMD)
+        full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
+        ec_and_wait(self, full_cmd, OK_CMD)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_vulkan_gpu(self):
+        self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self._run_virt_weston_test("vkmark -b:duration=1.0")
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


