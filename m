Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485F4C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwm-0003yV-IB; Sun, 09 Mar 2025 21:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwh-0003xX-Af
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwf-0006Qr-JN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1540528f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570119; x=1742174919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tm1aRIWaBwgx/6x0GFSv25uAoJq4igL/u+tjPwXH2Gs=;
 b=qh1eI1c0ouGSETKIEx3D8o8IPsQlrJ8bitK4tBhFViZE6wd2AqSq/+dna024B1eBW6
 PZm8OY6aFFa2YC4X/jsg14r4aBlzjRvIz4ObuH9OiknK9CfofdwR9MKUiRJi6lLXTnrr
 MwVMFEGz+SCUiYHSg1jqBZpBXdx4r3csCyfFTQ5e39vdgr3vT4o71r9jj3c28eyg5YT7
 U25AglI/GQ3FGl6VZzkYrekf23lHahZ/dXalBR3AY28COJNaP2aelkfGgo3RJIkSTjGU
 q7ixlfk7SpDbsplsV9KNvtjgORQT3i2Xisq3SSSeKdqMGqBmVldobktseZTxSzmDkxMm
 oEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570119; x=1742174919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tm1aRIWaBwgx/6x0GFSv25uAoJq4igL/u+tjPwXH2Gs=;
 b=USIruzQjrwjrTFc7aGMs/Ijb/8MKeYM+MnuVAfp4QuTtw2577aXAFKLNz1DIfN1ZEK
 WFl7bugMZUFIYslv5SoZB7b5NwH8I2riEIQObPFDcLnRVmogzpOCRI5ki7ippAwwnOQ1
 8SpoPVKuWJw7FVA9gRYBlSQEw0BUqi50Ljd0FCC7a9WBB+f1MsLnhiMmC5Q9HDBTw4Jp
 aqIrcFYh4WH+KZkYOFTS+JvLVwtwIcihPT4sYBXqdlLHY+2diZhsMV3hYnGRmEBpX8Ac
 +txfzpOPycR/L8FbFuPmrDWO8yq1bVrqRwQRSmkor4p03LVP3qDw86NWfS0mK1S2VPDV
 qPrg==
X-Gm-Message-State: AOJu0YzaBResL0qmptcnZoeLo6dZIv22UrOpzcKNJm68CtGH+/4W5Co2
 0ggfFHlNu8xxSn0fSV60M9bY/eG6OXzGxxGj4WSxrQykxHVaP6HGHn3Q6vjFHkvAyz2DSbqGjC7
 bD6Q=
X-Gm-Gg: ASbGncuF+RiYD+q7OMyFM0QkPoefp65IJBkiz6x87HpNnrFgdZSIxuihqDMOtS3n8TA
 nXwbqFwiVBKB5up4m9k6PPE4r5eX8yC8Bwrv/WFWxfWY27uIZLD0QQtsk58tk0DW7LF8J0F1L1/
 BDTFCjFSSINxcZk679i9oVTvuidVrJxaZayfOcZjHg/+4pCdxIc2HzzBI/J4EFDRkFMNv1vnKVa
 8QbEiN+c9/S0aKAnq0ufYbNEZNFtE/uYIACiloLyl1bmveJedykUgidMfOkwQ72KFZYXhc4tYtx
 lZAsIkiFDznFxJLIPOQns1HzISabFSHWD7pwdYj3UqjtZbjJne6z7jW+bG+yr5/cQzDSV/qa86X
 GtyVyES/Kkgbmi5bwhhK9xV2JJlbwlw==
X-Google-Smtp-Source: AGHT+IH20yJX06giVzvivOa3QisLS22r9+2wZ9shvU/XR8v/DxHT+Vns6c2HBLmMYL96VsU4Q9vEtg==
X-Received: by 2002:a05:6000:18a3:b0:391:1388:64b7 with SMTP id
 ffacd0b85a97d-39132da8f0amr7923213f8f.46.1741570119480; 
 Sun, 09 Mar 2025 18:28:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cef25f075sm45918365e9.28.2025.03.09.18.28.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 2/7] hw/char/pl011: Introduce pl011_xmit()
Date: Mon, 10 Mar 2025 02:28:20 +0100
Message-ID: <20250310012825.79614-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Extract pl011_xmit() from pl011_write_txdata().
Use the FIFO to pass the single character to be transmitted.
Update flags appropriately.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 43 ++++++++++++++++++++++++++++++++++++-------
 hw/char/trace-events |  3 +++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0e9ad5d5d90..113b29cd9e6 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -226,6 +226,36 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static void pl011_xmit(PL011State *s)
+{
+    int bytes_consumed;
+    uint8_t buf[PL011_FIFO_DEPTH];
+    uint32_t count;
+    bool emptied_fifo;
+
+    count = fifo8_num_used(&s->xmit_fifo);
+    trace_pl011_fifo_tx_xmit_used(count);
+
+    buf[0] = fifo8_pop(&s->xmit_fifo);
+    bytes_consumed = 1;
+
+    /*
+     * XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks
+     */
+    qemu_chr_fe_write_all(&s->chr, buf, bytes_consumed);
+    trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
+    s->int_level |= INT_TX;
+    s->flags &= ~PL011_FLAG_TXFF;
+
+    emptied_fifo = fifo8_is_empty(&s->xmit_fifo);
+    if (emptied_fifo) {
+        s->flags |= PL011_FLAG_TXFE;
+    }
+
+    pl011_update(s);
+}
+
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
     if (!(s->cr & CR_UARTEN)) {
@@ -237,14 +267,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
                       "PL011 data written to disabled TX UART\n");
     }
 
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
-    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
-    s->int_level |= INT_TX;
-    pl011_update(s);
+    fifo8_push(&s->xmit_fifo, data);
+    s->flags |= PL011_FLAG_TXFF;
+    s->flags &= ~PL011_FLAG_TXFE;
+
+    pl011_xmit(s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 05a33036c12..1bab98fb5f3 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -65,6 +65,9 @@ pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x val
 pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
 pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
+pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
+pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 pl011_receive(int size) "recv %d chars"
 
-- 
2.47.1


