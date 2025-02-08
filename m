Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F257AC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnry-00015n-Tx; Sat, 08 Feb 2025 11:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrq-00013z-2e
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:42 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrl-0008QO-Iw
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:39 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dcc6bfbccso801446f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032775; x=1739637575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHdzv7+PANz1XyqKozB4I/EYUC6swY8LmKK++HWkyR0=;
 b=kDBBkTv5KppBmGHg2Z3/AtNBByktxo4YP96cIxp6k8dNUvy3z7g+dqTQfPmcIYSI1x
 HtNI10BDaUDKFK8e7sE33WEdg/j9xvblmAfExTJMk6wZQgEjLajFlJLSF8azJrZnHpGh
 swV5bXtNdy/UmyA9egR/kOOuA03egrZ7qtpubenX+HiIi5xm5IPYXkmERrPpAF6jqOnL
 5zxvY9zIPYM4xfoXhRuiualMpt2ik/XjqSUj0Hw+Gm6LoTgvI7wufcTh+w4+knAxJLRK
 Aa85bi+swxFScco0aDKA7HR7paSxul97NLh5PZQuoXPG3JhRihk4a6dkgQac61x/6fGL
 MnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032775; x=1739637575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHdzv7+PANz1XyqKozB4I/EYUC6swY8LmKK++HWkyR0=;
 b=MB+P3inv12ipyoNIvkwHte8QOvmnyRS/jqYUUB9+C/+0B146zLCNCCgdnJCyz6sS93
 2QtCWB+J0gXnAm4llEl6R9WogBc1Iksw67tyZhJgF+c/A+IaN8PlmmEiWQlzIgk75HjN
 0lHrg+l8wBjQmu3I5mtOTFKHRnGR+phSXzy3YM1SpxHjzxd7yhsPMr/4CdwJBnPjWpgW
 PtMKPmX8D0iwXaM0cjDw9hHtzGhlzY8wRk0vU3PQ9LqLY/JG8R8g2m6pMC040zC+VvFS
 BMKU4QIUofALFDAgIVQyqhlQ++PYJeiQZkGgKCbBGahEmpk9S7fj9EkLBmdHU34ePJ3b
 SlOA==
X-Gm-Message-State: AOJu0Ywb+N4vqbJLiRpGTQfz3R1j3sxv4MvdEF0IofGkUPps79jnqHKP
 +TT30gN2nm5D3+M4YxqHI/08cO6AwSivtRwCXTX9+LuXECt2wClgWvWV7hk8VNp5L4Qs3jlMJTe
 HvCI=
X-Gm-Gg: ASbGncsOeU+K1mDMuXExvQaWMr64cufN3rB/g0JJO18mPPnayQzQWdSeWMwiAchhz9c
 S3ElGMGYq5CgAYNwJCX7vCpO+rU8j3cXoJd8NwtImal3p0RuENV3PoV9DzKbGGdWIqfg1wBUwDI
 6a0zVSSy40T/JraRvDY5QRmSFddCe8a4dwwFJp/ybBO+SscMCp5UuEh1fBTigw8Ly4o4taHuyW3
 COqkbC3x8RLIk484BdxRkpy9VLqLSHnW9XAIsSoghFyG/ic47lTpjypjwSpkBf+/YVFCnPc9wIm
 2s3UIsNH2WguweBYgr+JgiMAPqyi+M8LlMU0Nv8VR9yOEbcP7FgfGC4qYVbbXsMD4g==
X-Google-Smtp-Source: AGHT+IH6YpUMdG322bhbp1b6ekVP+kxaXrw7iSiny0srrOqCy4sWpckqu3Y/SBLQQuH4TYwy4uKzVg==
X-Received: by 2002:a5d:5915:0:b0:38b:f4dc:4483 with SMTP id
 ffacd0b85a97d-38dc8fe80bcmr4396795f8f.29.1739032775508; 
 Sat, 08 Feb 2025 08:39:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d964c7csm124581855e9.17.2025.02.08.08.39.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/7] hw/char/pl011: Trace FIFO enablement
Date: Sat,  8 Feb 2025 17:39:08 +0100
Message-ID: <20250208163911.54522-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 4 +++-
 hw/char/trace-events | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index b9c9e5b5983..447f185e2d5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -148,6 +148,7 @@ static bool pl011_loopback_enabled(PL011State *s)
 
 static bool pl011_is_fifo_enabled(PL011State *s)
 {
+    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) != 0);
     return (s->lcr & LCR_FEN) != 0;
 }
 
@@ -464,8 +465,9 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
-        /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
+            /* Reset the FIFO state on FIFO enable or disable */
+            trace_pl011_fifo_enable(value & LCR_FEN);
             pl011_reset_rx_fifo(s);
             pl011_reset_tx_fifo(s);
         }
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 3d07866be5c..dd635ac6012 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -63,6 +63,8 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
+pl011_fifo_enable(bool enable) "enable:%u"
+pl011_fifo_is_enabled(bool enabled) "enabled:%u"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
-- 
2.47.1


