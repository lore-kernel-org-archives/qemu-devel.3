Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBB0EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIs-000587-DO; Wed, 11 Sep 2024 08:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMI5-0001xR-OK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMI3-0007Zt-Qx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374c8cef906so4596179f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057058; x=1726661858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeNvT7txJznOF0zd6v7UUyaauDX8I3k5a8TXKDaI5uY=;
 b=Skn9Uu+xhlyAByc5cc9hfAOs5wvgdQNq/ML2tqtgKrqwQuPdOmaf0fvc5XqFDUhfzE
 VIERsDFkGK7Js0Inn2uUR3hZt/L4lo8cwr0fDVjuCNBIT0ydpI3lL+o7y4u8qkDdGFyw
 UrmabdLcTtHgG3af1/Jy82m6FD0AJtR9sBKel9/8WsNh37Gmx8RKEdoa4G8g0i3XpCW/
 pTZTrxdjnuqU6DM1EE6wKSJ6plTLem4fdnCfoo4kExeRcKOXuw5TFPxYH9IqZQIzS5JN
 6W1Gf6cvapD7+gtouZi4jiWTx5D06hljCrm7LoN3eWEX+b7YCD38NBtpRKX0toG42Pfu
 G4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057058; x=1726661858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeNvT7txJznOF0zd6v7UUyaauDX8I3k5a8TXKDaI5uY=;
 b=C93ysjSs0Q7e5YWVjjBySf4/d6wMWkJhIXagJP8Xc1TCB584TeOUso0fZp+M/uJFVj
 hUKfqHpOF/QN8jizNCHW1DTg1COK/O15Laueg9NPo/RUvMYUC2L79Vny9o21i0AUaEcN
 X0Sxo1SAP99O/3UvEUeC/Q46aK09u92VJQgIxLEl3iYT2OEnKpnZza7aIl5b0kNUkZcB
 SjtlxaTYVaYsp/xhyeF9i7E+rYU/hPfdkNw+rsJDpWgXJylR9BwunPuiBhecrptmqXK4
 dd2UzACzyXThQOiFibY5AAsMgF9FHonEokqr15yKJ8G9xr5X8y95De3y08uvMY8hWXXx
 tCLw==
X-Gm-Message-State: AOJu0Yz0uBgwqE2sTP1Jg4wa/4M63xieGVUgosL+iJHD03Ey+ZWVdO3U
 4mz5613y9NLl9dSdCRDCjZt2BkX2qofl4Ks2tRfzDAQG0pRKw9sklRhhHALPQI2ZcwJE30SiNse
 b
X-Google-Smtp-Source: AGHT+IGCJ5sgFrGpyBZCb8zD3+9sNJ0WHi1L1wGsRDxwyYPuWEPSfD4m6tyjpkezuANrXsGGfzrnuA==
X-Received: by 2002:a5d:5545:0:b0:374:c269:df6e with SMTP id
 ffacd0b85a97d-378895ddf36mr10972331f8f.25.1726057058481; 
 Wed, 11 Sep 2024 05:17:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d37a1sm11389072f8f.77.2024.09.11.05.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/56] hw/char/pl011: Warn when using disabled transmitter
Date: Wed, 11 Sep 2024 14:13:54 +0200
Message-ID: <20240911121422.52585-30-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

We shouldn't transmit characters when the full UART or its
transmitter is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240719181041.49545-9-philmd@linaro.org>
---
 hw/char/pl011.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 26d391a16d..9c045d3709 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,7 +85,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
+#define CR_UARTEN   (1 << 0)
 
 /* Integer Baud Rate Divider, UARTIBRD */
 #define IBRD_MASK 0x3f
@@ -223,7 +225,14 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
-    /* ??? Check if transmitter is enabled.  */
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 data written to disabled UART\n");
+    }
+    if (!(s->cr & CR_TXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 data written to disabled TX UART\n");
+    }
 
     /*
      * XXX this blocks entire thread. Rewrite to use
-- 
2.45.2


