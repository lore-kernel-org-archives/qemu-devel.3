Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50FCC021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI11-000149-O8; Wed, 26 Feb 2025 09:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0u-0000ud-Ie
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0q-0005dh-5s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4399deda4bfso47176285e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578626; x=1741183426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTNw3ExiwY0hSDPVxjA6iIZ/5nHNcZO4ZN/EW3ctQwU=;
 b=J1eYwTVNkQ+Bs1+KhF6zD7l0aYhjYQ8+j01yurLbXDxUBe+KrpCXy7fiNd0xdv1m48
 aHUw7HbqB3PqwEAEBpJwNTyMdrh/T67JIq1t+laof/Fju1bySUM/6AOU5+1tNeeVS7vQ
 XNHLLWjWA+Xxxf7kccSO4net8R/p7GmpLZ4A05ntbts7TYbn6UZfpMTfZ0OI7+PUISN8
 iCbCrZ50fXBzs1TJxIgTMOEVk4jG9tklfCqYgaK6OClSLV6nT566chr21GkzTG0oWs3R
 cvpRK6Xy8NdFUlXFUgwWqPbYx6HhCgfuSQrT5rVGHgXT4tsrMYSwUk3ypxnK13FxSz3P
 TSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578626; x=1741183426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTNw3ExiwY0hSDPVxjA6iIZ/5nHNcZO4ZN/EW3ctQwU=;
 b=rKcEzTf/5U7Pn1Gm2YHNbHnL6hJ+FCI+9BYWPGbAkRza8oBPxQmAoydiQFR+MCN/Ne
 gNlwsBC5iMIIenXmIhEvukcKX4lHkaKdlKLDzlW54eNEHqvM4pO1cubOk0kNf9AXHVLX
 WIffN8XlmEYrs3Jzip6klBe4YCXpnjnxV7UtApPEQQAy9k6XxSfpgQm9l5HIL7YVxKxQ
 AfxKJahCk1X92E9dXQXaqpHo0N/6iTRm1gD+veRbo3NrBxb7KBFJ6J4SFDJvq3hoIUA0
 OpiHs4E4OLimt53yw3qHcgb0VpT2u1bR+6T89+ddQVY2Hk63/D/5L8Gz19PAL2pT7cw2
 tN8w==
X-Gm-Message-State: AOJu0YwSl9bLMlRGjwBWencpPa09+nZ7wsdwdzXeeEb3gxnL1eg+ZmdM
 BLnxlo5ebtpiIeCsQ6nmzlx8ldjOOr/aQScYvfvScDeXoI41f6VUbgMLcObaWGs=
X-Gm-Gg: ASbGncti1fsSD7rBnRm0gsuSAM5N8G6lF570XcGOrexqzhzFXXk+Si7qGlJ6pAQkBKn
 Ts3E4gzltkgf8JgaYpjA9CWPnuOuvAJmuYZ4Q6WXTSAzd9HuCxRtYOvvEyHFCemdRixij1rrb/P
 NScIObDrgY4eeonPiVSUxvujldEEadby3Nyvb//DgSgago43k9SaBZMwmBO4sTO62SyOjScqBBH
 /VGIXm9a2z7epllroBupksL/NCfwLwp0+NgHh6mGMPWZvgzfh2AJ2r0Z0d8ANBSIqDhdknuIMSM
 jr+Qec7Xa1WigLpKIflJPyu5p9VF
X-Google-Smtp-Source: AGHT+IEBR736tL0k56kxlAJdUfHuO/VhLL9clFzLSzVVTRtzuy8oeMiNoaWkGELR+RPqWMw6+qLBIg==
X-Received: by 2002:a05:600c:3b91:b0:439:9a40:aa16 with SMTP id
 5b1f17b1804b1-43aafab917fmr102350055e9.16.1740578626025; 
 Wed, 26 Feb 2025 06:03:46 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba549be9sm22704255e9.34.2025.02.26.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 446A5601A1;
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
Subject: [PATCH 04/25] tests/functional: expand tests to cover virgl
Date: Wed, 26 Feb 2025 14:03:22 +0000
Message-Id: <20250226140343.3907080-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Add two more test modes using glmark2-wayland to exercise the OpenGL
pass-through modes with virgl. Virgl can run with or without the
hostmem blob support.

We might want to eventually add more directed tests and individual
features later on but the glmark/vkmark tests are a good general
smoke test for accelerated 3D.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250219150009.1662688-5-alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index c9463d7285..7a8471d1ca 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -89,6 +89,26 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {weston_cmd}"
         exec_command_and_wait_for_pattern(self, full_cmd, weston_pattern)
 
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        gpu_device = "virtio-gpu-gl-pci"
+        weston_cmd = "glmark2-wayland -b:duration=1.0"
+        weston_pattern = "glmark2 Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_blobs_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on"
+        weston_cmd = "glmark2-wayland -b:duration=1.0"
+        weston_pattern = "glmark2 Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
+
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
-- 
2.39.5


