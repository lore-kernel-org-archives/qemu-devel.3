Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6995C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI11-000148-OD; Wed, 26 Feb 2025 09:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0v-0000wF-KH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:54 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0r-0005f0-Dt
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f6475f747so3272353f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578628; x=1741183428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUhUbtMcQJqw0qeJKuxjiQtAZ+OPms82YWwNVqH6kds=;
 b=Dp8VN2Fa8gmm9MP4uyh3b3dQVwnjWLbpGpOj/7HGgWjk/Dm9k535UL2JEjipmMDeXK
 +RytYEZ/CHKKGafBTppr3LTE/1IkbqQvbH5dhQV6K0MvxujJ+eB0xRrPW4+LqBHI1Pg0
 3EjcF6za0+Ft/sTnP0+j3GAbuHQzuspy40kqigdiBK0uDhUlQEsIFrt2blxHqWkGd+M6
 p/Xw4i8fZkK5pjslCxb8xKX7jOQLjHDqMn/GkfQwjJDASiI+KqCzXI+5kCTVoX3q4IQf
 6PfvGvanQgFIbQuB2dTSamrG7Sj5XX94zrHexorKlvnKtN6UaRuOtG3DfUHGXbl6d0fW
 emRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578628; x=1741183428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUhUbtMcQJqw0qeJKuxjiQtAZ+OPms82YWwNVqH6kds=;
 b=WYmutlTMkKTswOFxqf9p2uTYwUNMUZx+HV7FzX6aPAC4kl3a9ufCTHI+4n0gdJkeTE
 ulhO1V0O4WkWTvjAFUai8DxzrW/g6TMx82gG/Gh5wzNwlWwbLjRSjmKH9iz3EGAuatm9
 kcXK2rFnbdx/O29/ov6LQcVD52S1hm0IZASz5PnBgAdAoVssyzq/NZDlRMHDbw9Yw/Jk
 NfU1iByZ+jD8CLhcpw8nondRgEtD66D/JQzg3zhTjpsCNPGRTRp85bNmzvzd7puG1XkU
 AkHcg/ZTz9LLHhFsXaHIdzMLEaGb4ejJ9F04eySnJjNJX33tT1IDo7b5eidFlgn1F+A3
 5W/Q==
X-Gm-Message-State: AOJu0Yz1OgaDOQuTYS3BChOqDJMw1luAJpv8pOw5Fl7hk+xkdPMlk5zu
 Qb299Tnd/Ngs6xXbNFWa+A9XpQC0zDousO8gzwuCD/0QPmjwb3EPGmx5OYHg3wU=
X-Gm-Gg: ASbGncu7MbX15eYVvie2xkdwu0dI97YoRBr3Diw/iTjjldyVc0XHsFc2/7Sc8C885mH
 N7ZxQeSreQXDgwGs7nVNDe1bmcvyqWAjFvx4QlL/s0+u4qC4QjYS3ByyCFNTr6bsxc1rzm78vMn
 7ivnlENCqVvJGYDCcocxHcZ0EsCS3LJCReRudHoJ4ct87Nvob60Dq5dImDV4V8uNo36M3sCU9dh
 bwNQSEEm/lKwfsCWyMZEBPMgQRftweSWXqAeZJzoeB5JTBBdgHhhpSiYhdO0a254AXb48fN+PQ9
 TuczLVfNyV7CuufGX9PLO5MjSejh
X-Google-Smtp-Source: AGHT+IHoS4tSPp+i6qS/7to7tqxCd/HEXqRftOyybB0zjpC5f8Xunz69CNK0iFeMOlDSF1N9Fnyl3g==
X-Received: by 2002:a5d:47ac:0:b0:38f:516b:5429 with SMTP id
 ffacd0b85a97d-38f6e96738amr22428153f8f.25.1740578627605; 
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc9b3sm5710878f8f.97.2025.02.26.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 196F15FC78;
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
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 02/25] tests/functional: factor out common code in gpu test
Date: Wed, 26 Feb 2025 14:03:20 +0000
Message-Id: <20250226140343.3907080-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
setup details from the test specific stuff.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250219150009.1662688-3-alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 30 +++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index f21ae18392..06093c6b60 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -39,12 +39,7 @@ def wait_for_console_pattern(self, success_message, vm=None):
         'rootfs.ext4.zstd',
         '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
 
-    @skipIfMissingCommands('zstd')
-    def test_aarch64_virt_with_vulkan_gpu(self):
-        # This tests boots with a buildroot test image that contains
-        # vkmark and other GPU exercising tools. We run a headless
-        # weston that nevertheless still exercises the virtio-gpu
-        # backend.
+    def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
 
         self.set_machine('virt')
         self.require_accelerator("tcg")
@@ -62,10 +57,10 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "2048")
-        self.vm.add_args("-device",
-                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
-        self.vm.add_args("-display", "egl-headless")
-        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", gpu_device)
+        for opt in ["egl-headless", "dbus,gl=on"]:
+            self.vm.add_args("-display", opt)
+
         self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
         self.vm.add_args("-blockdev",
                          "driver=raw,file.driver=file,"
@@ -91,12 +86,15 @@ def test_aarch64_virt_with_vulkan_gpu(self):
         self.wait_for_console_pattern('buildroot login:')
         exec_command(self, 'root')
         exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
-        exec_command_and_wait_for_pattern(self,
-                                          "weston -B headless "
-                                          "--renderer gl "
-                                          "--shell kiosk "
-                                          "-- vkmark -b:duration=1.0",
-                                          "vkmark Score")
+        full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {weston_cmd}"
+        exec_command_and_wait_for_pattern(self, full_cmd, weston_pattern)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_vulkan_gpu(self):
+        gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
+        weston_cmd = "vkmark -b:duration=1.0"
+        weston_pattern = "vkmark Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


