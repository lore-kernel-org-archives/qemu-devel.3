Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAABBC021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2tr-0002ZV-Vw; Thu, 20 Feb 2025 04:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2tl-0002JH-9K
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2th-0003u3-CD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220ec47991aso8165325ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043865; x=1740648665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DkPTvskXfEKDS8ksEDRN9mL+hSgQIvFZ8gbNR3D4CQ=;
 b=o9jRQniZFP6SPB2geLA9fOSDZiPXUKMvcUemBeogrZgnfOrUzlFOvLHZKW7Y7t3CmF
 oKQImuwgEDegVkT/p9LcmVqp4V9DkyFdzWKAv8tUeK8ErB9F4Tnp+kShjr0Fy9mByCWP
 nbixPnAnRIsbJcYrWxvksPQMXJ0zZzXAiGkpxyDKmAgEqwxbP0oXhmly2yXDEB/UpNsU
 n8PzUfb8+yHP/nBPw9DryFkw0cgEUb5RtIEH1QZK+WiND/RyOcKxs246ND0vKN612ed+
 /BWsRSM7elAoKWBEbl6T7zZ3PcxRcsweCGXsE3acTWwWnofNvCRvoAzGPXyVpgsP7f10
 QYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043865; x=1740648665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DkPTvskXfEKDS8ksEDRN9mL+hSgQIvFZ8gbNR3D4CQ=;
 b=FvGYO5FVM2XbQLfhBRm/BKx2gxZWPIyeX2ErsTXz+qEpSmiql5GzdTPszIHjX6vk3i
 +3sQgNtOWhVCY9ni9nNEJNmFB7pgD0zZLoKZxQveZ/lnuliEO++EnV+ZVcpDwY+tjXUR
 HiX9qn54xjXz66n4rdscGwsI6ektAAyHmDx19Nd4SaLWiTM0yuH9KMJ4aTZ6V0vvQ9P0
 flzBqbUqZWiZiD3J9XDC9K6P6RxWhHjI+hjEKKoHLjEuv1LSKYS+NpusqASoBY/sT1uN
 907EwRp6mD4xJ9oUTe1TdJwa+XpXZodgVfFFc9ZfJ9kuDKavswR7BiAMBGmzMkWVdfiB
 IBvg==
X-Gm-Message-State: AOJu0YyU4sInbQ9M/+DzjFNMGzyzfuZ+b/xzo2NEJGB19mmyLGDVBqlw
 0YKOlULfWT3t3yO16lcTUrM8EcpQNmbuOCIUDifEGqblVYOJzVXRfUmI+Odhj8shaD29bky93t0
 zP/M=
X-Gm-Gg: ASbGnct40kRsHG8ucmV9BqK9mWpjI4FHTZOprNo+p7Zggv4/TLcT1/VQgK/K6LoVUUl
 iyasC3q0LDL4w01redQGB7SHDyS4fbRqcjEXGCdKJ3dW79i5766vWt0a9pas56xiolxM8eEIUN+
 2eEzJX4gtONHlZT7tbO8JXyPrXHz3CxGqLYYJUK0kvdNs3puqntshFCw+LmnrLUiVAX0JCeptNO
 r5r74CnydqZfKkue6bewWZ43wVHLmeoYTOgBIxWqiALNyxeErVO5E21pvq84/OdDrhwph5sNGYe
 P1ggZfWZYft62ULTFINUk5hAc8deumgFfw5a5m3IZOXEwDpIyfwXA6ShbuRdAmdP9w==
X-Google-Smtp-Source: AGHT+IHfmzLHtddJkZK0gPhKTcPtzUPZ89z8b0ccPmyhcf7pVBkVxv9DNWrVsElk7Iw2TdScMKzjvA==
X-Received: by 2002:a17:902:d2c6:b0:220:c095:901e with SMTP id
 d9443c01a7336-2217119ecedmr125278895ad.35.1740043865224; 
 Thu, 20 Feb 2025 01:31:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349077sm118268655ad.1.2025.02.20.01.30.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:31:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 7/9] hw/char/mcf_uart: Use FIFO_DEPTH definition instead of
 magic values
Date: Thu, 20 Feb 2025 10:29:00 +0100
Message-ID: <20250220092903.3726-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

Defines FIFO_DEPTH and use it, fixing coding style.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
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


