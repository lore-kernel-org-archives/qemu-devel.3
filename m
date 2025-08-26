Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506BDCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqstK-0006n3-NQ; Tue, 26 Aug 2025 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqstH-0006le-Jn
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:35:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqstD-0001ZT-J7
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:35:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3c763484ccdso1864014f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756211698; x=1756816498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OVImhz4TNfHl3GmVSBulLFByeCJIESRF7O8GLCtrNtA=;
 b=vH7AQgZ+wS2E1vDSc2ug+Q+ChLXCSigwNmtXbNsPB7FXMHGLA12r+waG1N04g10ov3
 nw251AWNIi3718CfMmfv6ibWcrC0PaLaxBxcCIWZPP3A9PPcSM/jOiO9svjAAN0QH6WB
 zUPvuswCWeOHzVvNMPHBWMjt2TRzAej2gv6MCP/Zno3yPvDoSzrO7BvY/y9y9BuwikRI
 cY8UPN0pEKVhfGDQmJyXgsyiQ1EYY2mIaR1Oku8Ld+Cx0v4OfDYCkGq15v6XkTwY/kCL
 DeBu3bIKeVoRTlTiwqz3jNMyPxeo/rxWyiCjnJfIySQlHw9MA2GYfFj+p1C4/jbRwQwc
 vGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756211698; x=1756816498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OVImhz4TNfHl3GmVSBulLFByeCJIESRF7O8GLCtrNtA=;
 b=FNOIAyCr4HRw+ig2Fdg7ayMaKAaQsJWCsNZkIr219HRP+jkCm8+cCNS+4jn54CmtW0
 vpxTMNszN5xsV/b9lC3AAqud9EI8tPvRFxhwLLmU7PwzRJVDS+6Z/uTjD8Z24VDvOKI0
 HCOmJFXRmklFEITgNjN6IvHY2DJiZyylNvyZbYfrJ3wMYWQua7/Xh8sfCVdx7bQxjOdS
 BOOe08ZkfQXagJkI9RIIXCfouX/Yx/ytO7LesMkjfqfIcAtZh40M8Z1nu5PdEb/fHChD
 AvRGBw1rJGPzCarMH8Iu3Wt5lAqTIWSY5LUerlhqO6DRR5xoJSQivFP92KhmskHsAgCc
 PnLg==
X-Gm-Message-State: AOJu0Yyy/QTw9vmhCSp2xwEdaO5I9O3nxQbqQ0wJVwMcJr7dXYKJP2Ce
 ZhGVFmpcPuqJJNcazzZYss76SK3jYUi2mTbOADPmMgKU5qOFB/aYrNjNzLDAOgGgRAs62vP8ueP
 hm25K
X-Gm-Gg: ASbGnctHLcAT9L43uCghA0CDhvulnxBopwucL8LOi7kl2AcVJOHj4ygeWxTIG+qwFJr
 5Ok2grK7/L5mK3OX6dI54pUOl4jvVjvrAZOgae8kGqvxQgqzc1BkvKxABdcmMfQB4s/xJihOdkx
 8sGXqe6T4YUogeGgM9OEY1v6aQFxJUKcj87WpKtkgtBHtu4pneaCtFYERMupkpd94dI1pRPKzOD
 J4gX1iOUoGfPhX+suN+4HlVX1DF2j8LzUKVvgIJulsYQdjVEb5bXbylhUCM1eOvR5+qgkJnxD6R
 JYEVU1TZJugikQU1DCI21fg7J4XG7uDNozMr8tPA9mh9ryc4kYTZSUwwPIjyAS99NnowHEmdX4U
 Ic4m5C2i+76gRq5PIQmPPXFWhssXUlyEBNxUyQSU=
X-Google-Smtp-Source: AGHT+IF8IbqJLZBq/KHOeQPkii07d+3jeqU5Z57ns6OfeJdMTy6U4Hhc5punwGBEz3SGh6tCpTtinw==
X-Received: by 2002:a05:6000:3106:b0:3bd:13d6:6c21 with SMTP id
 ffacd0b85a97d-3cbb15ca095mr1380703f8f.0.1756211697538; 
 Tue, 26 Aug 2025 05:34:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66cb60e1sm13140455e9.6.2025.08.26.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 05:34:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip test if EGL
 won't initialize
Date: Tue, 26 Aug 2025 13:34:55 +0100
Message-ID: <20250826123455.2856988-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

If you are using the Nvidia drivers and have installed new versions
of those packages but have not yet rebooted the host kernel,
attempting to use the egl-headless display will cause QEMU to fail to
start with

$ qemu-system-aarch64 -M virt -display egl-headless
qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
qemu-system-aarch64: egl: render node init failed

together with this complaint in the host kernel dmesg:

[7874777.555649] NVRM: API mismatch: the client has the version 535.247.01, but
                 NVRM: this kernel module has the version 535.230.02.  Please
                 NVRM: make sure that this kernel module and all NVIDIA driver
                 NVRM: components have the same version.

This isn't a problem with QEMU itself, so reporting this as a test
failure is misleading.  Instead skip the tests, as we already do for
various other kinds of "host system can't actually run the EGL
display" situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I run into this fairly often so I got fed up with just ignoring the
spurious test failure messages...
---
 tests/functional/test_aarch64_virt_gpu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 38447278579..4e50887c3e9 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -76,6 +76,8 @@ def _launch_virt_gpu(self, gpu_device):
                 self.skipTest("egl-headless support is not available")
             elif "'type' does not accept value 'dbus'" in excp.output:
                 self.skipTest("dbus display support is not available")
+            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
+                self.skipTest("EGL failed to initialize on this host")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.43.0


