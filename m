Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E9DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 11:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIuU-0005Dw-35; Thu, 02 Jan 2025 05:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuR-0005DU-Gy
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuQ-0000Mk-0V
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so127607045e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735815512; x=1736420312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX7tyC+IoyNuHMxTftdexw4ZA/q9//BvhZNltMexCoQ=;
 b=xPYNw20s+MGDHaFG6UvUVaiZ3FBoKWKb0lchbwKENNyZ7kUK8uAXBC4GTrdlltWBLe
 xWCH0PkRLnOFwZpcuZ/3FDGfZjS9RsOemguvsWqD1ulddmkzHf350D1WQYuVoCgPrt+z
 j5NTs5piZQjkQEDghc5e77HTfMbN+YT/28kIMlta+o2RpfnZpNrHXHMtYTUVW1LL9MS/
 GJufMuE0lq9KSL3EGfv7CoBpH3s8k62lMDaXsb5m/QjmSoonHxDWMaqOjFY7N9lbxH8I
 SAAhXbMx6IT/Vdh7D9y/PhFZl/wHdFh0TvrTsa/ux7K4fEDX1bi6H4awLV8YtCVv9xSL
 hOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735815512; x=1736420312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zX7tyC+IoyNuHMxTftdexw4ZA/q9//BvhZNltMexCoQ=;
 b=hmQaNPsevSWPtJMsNNvOnPuCWRLRAa+E+QfmHdBpFAbeVbbEtGM6f/2sCIJyq9jBMs
 rGyCVBmLc2TVCnr8VubXSzxRCiDA8/TYGf6yC073w0I6FZUynp19GxLqHzsZ2FjGZdrJ
 P3Mz87+9+hwC/ergf4nGiQng8A0CtzoS8g+K22Cb4EUisFxH0ZkX8slAGRM/IGjVTCU6
 CUf0vEGW9Wa9wNSup43PogfL12H34iP8Ycu2nellQlYzbfPGE2oVAFHafCwf+IdzYV+7
 R43oaPFbjen+2a19XX0xu1zNWmvlstzAYSFEHRxlKvXrgfnsE27vxPQX+V0mpKBXzl/T
 1bSQ==
X-Gm-Message-State: AOJu0YxDHc+87MWCxez+5JWUTgcYdoBrOe2MIi9gV6doG5gLS/u7fEvd
 1ji0StkJ71f88mtouKt13xRkAEnlxd2Fuy5U8ziVY2wA5EMx6vvyL3cVTPmMVDnHpFlN5L2ZSE9
 k8paaSA==
X-Gm-Gg: ASbGncvcG4Hi2efA5wDfsR35pMt3DvVQcR+P4gjdgto2xUHa/BJhm2E6dmtRPXXrAH6
 dXRsxfZnXT7aszGgQMkd1kxrjeh5zLCks/E/xlxdwfSeBGE3ema2hQAQbyP1hB/8DsU03/aPbBC
 KawB+JVzxDP/61Ub9BMWOMHITSVKKy1WQx9LGqGonjGAPKM2ALTJOvnd9WEmckPJGQlwNx+MIAp
 Ss4yhnGNgEabgPtft6mgZi2vpMFO3BIX4aXoz8TNd9w8jPcmjWQxPkZrf5pfrmlMjpjYv/Nwd0A
 p5rkrC72p2Lkx9jIcWVLX97mGTNBRw9dkXZwT1f21MCR7Q==
X-Google-Smtp-Source: AGHT+IHii8N4pfm5p6MS0RNJwt010PoGN9LwuCakORhwKneS09QTm35pW1YS5NZ/5CkRBu9JP4n/eQ==
X-Received: by 2002:a05:600c:468a:b0:436:1b96:7072 with SMTP id
 5b1f17b1804b1-4366854c062mr380870555e9.5.1735815512299; 
 Thu, 02 Jan 2025 02:58:32 -0800 (PST)
Received: from localhost.localdomain
 (161.red-88-29-191.dynamicip.rima-tde.net. [88.29.191.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm444588155e9.44.2025.01.02.02.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:58:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/4] tests/qtest/boot-serial-test: Improve ASM comments of
 PL011 tests
Date: Thu,  2 Jan 2025 11:58:19 +0100
Message-ID: <20250102105822.43532-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102105822.43532-1-philmd@linaro.org>
References: <20250102105822.43532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Re-indent ASM comments adding the 'loop:' label.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d506..a71d2857807 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,18 +70,18 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get base */
-    0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
-    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
-    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
-    0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
+    0x08, 0x30, 0x9f, 0xe5,                 /* loop:  ldr     r3, [pc, #8]   Get &UART0 */
+    0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
+    0x00, 0x20, 0xc3, 0xe5,                 /*        strb    r2, [r3]       *TXDAT = 'T' */
+    0xfb, 0xff, 0xff, 0xea,                 /*        b       -12            (loop) */
+    0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
-    0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
-    0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
-    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
+    0x81, 0x0a, 0x80, 0x52,                 /* loop:  mov    w1, #'T' */
+    0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x41, 0x00, 0x00, 0x39,                 /*        strb   w1, [x2]        *TXDAT = 'T' */
+    0xfd, 0xff, 0xff, 0x17,                 /*        b      -12             (loop) */
 };
 
 static const uint8_t kernel_nrf51[] = {
-- 
2.47.1


