Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298B4C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJy-0002Js-Q5; Wed, 19 Feb 2025 16:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJu-0002CH-L4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJs-00009L-H0
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43998deed24so1776215e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999362; x=1740604162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncwU6cIOgR/ePA4sESjtym4cDIkeSMiSmL8ykeDbSSE=;
 b=Y7AaV4qWY/zxIhtF4RQMYrMPX7b3vlZTMWMA8ZLfeh6sVorHRr+n44gto9Dcdcuers
 b/rzQSbG7obgNX1HvifJQqxqUa9nprzu17hGCqgRZjAo1QqNxxggQiVCIW+x95oyQAg6
 f8qe75p0ehKN+NNOYEks0tqKu92XnUlApQdoiWcvSJWAkjTQLnI9/GBSkQQfMlVS5EzM
 7my4wAe/96hJEhhcg4SiOWCaPS558MBteYLfbm19xYq7SG+239asKVsSnedXSBYW0DpD
 htjmPRfMXvIflaPkdPsg20OLVYDXA0Y4d0mlmBjaWIIOESnAbJ/qQu1S4vmSPxvVskVA
 KuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999362; x=1740604162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncwU6cIOgR/ePA4sESjtym4cDIkeSMiSmL8ykeDbSSE=;
 b=TotPkx0izTtv01nb2kRYAqG9ybdpW8H6C8DB3+90VJeiMrEy+WwQEb64Q1/d5jhbun
 QkGXF0omTBhFNM3jE9DO2nPsiaKK0YkAuIW1xylMCn7oxNnnCs2ttuBraMPZZY2PI4n9
 RBLEbDkfvcdDq9c4UPod3vYGvW3BlteIo25hEAO8OITwvQP2baYDjTfkll4h3t5SI+p5
 +f5PGGY6ABpjlzhOHgc0QzQRO3/X8fojl+AqknEgh9sjux/uu84brhpej0wSxg1F+dYx
 LrmdBeVyLpo7Xbevy3qpZIsWAW0jQwlo0oAlBuBGpVIq6VpWWOpBg9ZZ7AkjAFzAD7BI
 0Ydw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5d2XLebYzJHzhhOdT8F/rWhfCZ0QDVMTBKZam5tSxqiBC4+/mksAPu23LH5kIhy0iCm+EBSorrhN3@nongnu.org
X-Gm-Message-State: AOJu0YzWZnNpXRALdWaK7dYTTTMzx/cKUUMbU15e9H/dZaaUURJ0Fh85
 2U0ovbqjoLuvn5T82o5KQ0eZfbmscuTZRhJuQ/MPQ1EZuh52COthSCsql3KRSpU=
X-Gm-Gg: ASbGnctmW48sh5D7d2c4q+e9fNIzDhNZqalHMccW50U7jClP9szem5UnXs0o+/HvYnB
 V9zlTdBt+rFHyBSg/w4y3QYhQLT8wLzv3w6ev8mLmoXsHQBwyRvNWW2ywZNoRY4aeauueTeGeWL
 7sUBlRlMhrO2qK72nxUFsJ4NrM44e+5V1WEttT77pi5/AVZwy5Iz09TgQ8jqQsXAvQ/O/fhIJNU
 vxa92MQyIi2TqKAI0W4zf33CA4q8hnr1H8sOxPQ030qDcwvfE4rCqQTtV9ESh4YbEQKu/bJMvtW
 dXlpWHfXKL/RpiE8565otsbk+KxHaTQVG8c4593F+h1+xMZ++s5zP3cYE3pufq+89A==
X-Google-Smtp-Source: AGHT+IHLn2DhGG+7Yh/k913XG4CFtz456lhGRiGEqJ6Nc1tDG2VfSs35DS+XKl2GKFUDG/NXJIFQaQ==
X-Received: by 2002:a05:600c:3591:b0:439:969e:d80f with SMTP id
 5b1f17b1804b1-439969edc14mr76162405e9.31.1739999361993; 
 Wed, 19 Feb 2025 13:09:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7987sm18500465f8f.87.2025.02.19.13.09.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 7/9] hw/char/mcf_uart: Use FIFO_DEPTH definition instead of
 magic values
Date: Wed, 19 Feb 2025 22:08:39 +0100
Message-ID: <20250219210841.94797-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Defines FIFO_DEPTH and use it, fixing coding style.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/mcf_uart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 980a12fcb7d..95f269ee9b7 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -17,6 +17,8 @@
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
+#define FIFO_DEPTH 4
+
 struct mcf_uart_state {
     SysBusDevice parent_obj;
 
@@ -27,7 +29,7 @@ struct mcf_uart_state {
     uint8_t imr;
     uint8_t bg1;
     uint8_t bg2;
-    uint8_t fifo[4];
+    uint8_t fifo[FIFO_DEPTH];
     uint8_t tb;
     int current_mr;
     int fifo_len;
@@ -247,14 +249,16 @@ static void mcf_uart_reset(DeviceState *dev)
 static void mcf_uart_push_byte(mcf_uart_state *s, uint8_t data)
 {
     /* Break events overwrite the last byte if the fifo is full.  */
-    if (s->fifo_len == 4)
+    if (s->fifo_len == FIFO_DEPTH) {
         s->fifo_len--;
+    }
 
     s->fifo[s->fifo_len] = data;
     s->fifo_len++;
     s->sr |= MCF_UART_RxRDY;
-    if (s->fifo_len == 4)
+    if (s->fifo_len == FIFO_DEPTH) {
         s->sr |= MCF_UART_FFULL;
+    }
 
     mcf_uart_update(s);
 }
-- 
2.47.1


