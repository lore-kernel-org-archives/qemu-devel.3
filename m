Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA7CC28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwz-00045b-Sq; Sun, 09 Mar 2025 21:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwy-00045H-0T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:29:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRww-0006Tp-B2
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so20985285e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570136; x=1742174936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mdjFtYQM1H0sW4TtB9D0TGJccy9eC3YWJZP9lSZSPQ=;
 b=jeWRAsYJBSqJk4z3I/s3CMUO2uCKN2jOKOigcTysUVjL1sw6yQDg+WiW1r3eA2Wv77
 SVCS0Nb9ZovqyKPQ+lox7JHxWjNunK4cGqsf3XXaqsllSdeTshB4Lqn0qVGRiWxynhM6
 1nSYYyBJF04wai108do4GUB8c+d/tDeegxgQafVs4gKfOMYu+jfiIMhTkjih1bQE6q7g
 MCtz2etTVuoZsrjAYAGJjg01qAcxbkyI+WxMMITdY1+dF0xDTTpKNC3LSnY9zmNyil1e
 2qD3+zPQCxQgnyT54A/OcSIPasZfL+T6wr+g1Q1mMoXrsO29EBQiL/646M1hZ5h7bOEj
 fzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570136; x=1742174936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mdjFtYQM1H0sW4TtB9D0TGJccy9eC3YWJZP9lSZSPQ=;
 b=qiPnaFbiKk9lIvW6RgFgzBl7wCTOvMasJJevwv7xWGF6QqaUmpUy/YI5i4ljVe9Jd6
 mOsnRP7bUQuj0pV1LWbNUjIYL1U9A1h9P80i8XYBCHHutIzxxB540bue6BH7eJftGXPR
 ZPGI560sd0rVql+M79niLesontr0+qcDBySc7qiYj/Y7hNwb4AaZDAn5bhqnLxJhQ3Zl
 B9m1km79m1+UOT/He+q9c+vtk7edG5dVyfMqVeXELyDK+F+RODHAnozOAHNamB5/Y/as
 L7ZKQpUahnPP5c9jsV4kKUW2fQZ7MM7Pj4w5TMTr6gnL6W0jOorlDYfA/v1jqSv+3WQQ
 fonw==
X-Gm-Message-State: AOJu0YyqbPfdgKpKgi4yBVszfyet0x6aH+6DeKj+E8W3GAwUUUNgXHWh
 gSKi77Zzwi+vWudRq7cCJI7uNaRBWihRCAFAGDuCVMfjpRrKBxQ2cdeUZEUds3y0pGxS6lq/Lfr
 q0Ro=
X-Gm-Gg: ASbGnctrsWOoSEzDg8brFIS6dI/y22dYs3OLNa5W0pXrixwapBQDnch8GoPI2dKzCJ1
 pGeUWPrq0WvKwE22hiZaOrrDWLvB6wS1AyactS2bWge+wlcE8SGfn8BfeMluQeSl+JA+3x8UtSv
 ArayXsXCyh87qIf/b7Yv1eHcleJOWYhoBtjjZriwWQ8UDsBbPvSUUm80TlZrTxs4v+EcjyB8qtR
 bp47ZxWqAq9QAsSZdhF6F671erEesdKIHP6nKlG2AgZU4us+lESnrMrxqWO7J7N7Cn9+rDxTJ5C
 F0cd17fjDIBx1l2vfv0EKM9/oWq58LdFAELfzkbKkobRknOkNaDyuYNudxQMyDt7SO7i0YbucMZ
 toeRZeUK5kxZQh2qjJAI=
X-Google-Smtp-Source: AGHT+IGphJAcD0hHs9UVKSzIESU0UZmz+rBU6+wpQxVMMaLI67PcRhQxTFZwaPkKhax6w6i6hAIsrA==
X-Received: by 2002:a05:600c:1c95:b0:439:98fd:a4b6 with SMTP id
 5b1f17b1804b1-43ce4dd7f59mr42259595e9.15.1741570135956; 
 Sun, 09 Mar 2025 18:28:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb799fsm13221355f8f.2.2025.03.09.18.28.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 5/7] hw/char/pl011: Consider TX FIFO overrun error
Date: Mon, 10 Mar 2025 02:28:23 +0100
Message-ID: <20250310012825.79614-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When transmission is disabled, characters are still queued
to the FIFO which eventually overruns. Report that error
condition in the status register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c      | 22 ++++++++++++++++++++++
 hw/char/trace-events |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 34a5cb3af5d..f67ce951ac9 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -61,6 +61,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 /* Data Register, UARTDR */
 #define DR_BE   (1 << 10)
 
+/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
+#define RSR_OE  (1 << 3)
+
 /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
 #define INT_OE (1 << 10)
 #define INT_BE (1 << 9)
@@ -157,6 +160,18 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
+static bool pl011_is_tx_fifo_full(PL011State *s)
+{
+    bool fifo_enabled = pl011_is_fifo_enabled(s);
+    bool tx_fifo_full = fifo_enabled
+                        ? fifo8_is_full(&s->xmit_fifo)
+                        : !fifo8_is_empty(&s->xmit_fifo);
+
+    trace_pl011_fifo_tx_is_full(fifo_enabled ? "FIFO" : "CHAR", tx_fifo_full);
+
+    return tx_fifo_full;
+}
+
 static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
@@ -275,6 +290,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
                       "PL011 data written to disabled TX UART\n");
     }
 
+    if (pl011_is_tx_fifo_full(s)) {
+        /* The FIFO is already full. Content remains valid. */
+        trace_pl011_fifo_tx_overrun();
+        s->rsr |= RSR_OE;
+        return;
+    }
+
     trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
     fifo8_push(&s->xmit_fifo, data);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index c857f4c4b38..d52f511a1e2 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -66,9 +66,11 @@ pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, uns
 pl011_fifo_enable(bool enable) "enable:%u"
 pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_is_full(const char *desc, bool full) "mode:%s full:%u"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
+pl011_fifo_tx_overrun(void) "TX FIFO overrun"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 pl011_receive(int size) "recv %d chars"
 
-- 
2.47.1


