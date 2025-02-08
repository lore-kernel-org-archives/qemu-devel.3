Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53466C0219E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnrp-00013J-1b; Sat, 08 Feb 2025 11:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnri-00012f-RT
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrh-0008P5-5e
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so20191525e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032771; x=1739637571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHNgIGYUe1Afrdl08LOWU03e5kzF56Zt76xmOxbCwW0=;
 b=Cmq7FRNyadq2jHatYbe3wjIa26my42RrvWRY8QMLUH96D640yfZ7NLEeTUwx5ESVWE
 bieJ+iK24hG7zLAPRp8tNkRI6UsH+We43xBPK1HUwDiOkIncMmH4AfjnTdX7nh/M1S2c
 KGtK3JPThYZtyh88N91+z8niXOyb4mAP190+bKVdOeQm9F35/yqAJaDx1GnH3BLYsXNK
 gcajfM6pKpXqpQ98epmhMbOVy9+4KMYnsgtJuObwhlt3zwxCQDZAU3eO3de6MrCCr79T
 Kb/Nm2DG7F63Cl2r7evaMJAMpqv9nGPTv7yOI7YHRb7Yn8CTPspp+Ox8MUeWoTKoj3CR
 QgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032771; x=1739637571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHNgIGYUe1Afrdl08LOWU03e5kzF56Zt76xmOxbCwW0=;
 b=XbcUoOdfmTKFrkxhGpmOr/t2xME+kNTw0QxAg5vszZgkBJKdroGXc67a7HRdQdq6EC
 IulFymlH8M62bl0FxgZCrxEPoAvdl2elz/uatHrFrnGwnW0ThlJh+a43G4yXiQ/Llu/6
 wRdE2GJtaDIlGQVKAi/8LsH6QWm/ZL/DuQlsSZrvX5+8MKpbtPBHTjg4QN85S2nfiFDU
 T1vFbe06rMltIZGjTASlwo+cePRq11q6PYemmvR/DFGy0e/wGdmK1c2TVIGTw4Hj5k9c
 9bJ4oGxkacZ8ygawHKp76aYsuNn8sicgH/NIO7rSRnDKku8N4qKF9o7HL+kUXTPMsEEY
 9Pew==
X-Gm-Message-State: AOJu0Yy4eBPA9FQMbuIkPGbzGyd/8ZCPtA/IhqSFuFCG0UbcGCX++zqR
 BT8ker6Cu56RypnB8RPj1HPYkclnTRFmHNquXi3e7zZ4OEWkoS21+KgwxIh4KRk6ajQEY2YaVzi
 vR5c=
X-Gm-Gg: ASbGncudEuGSkfeiU50vW819tV744JmkttTipmyzzGnG1HDZlv+De178NMArnmMcM9m
 gYu8N1StrvoaTQcIN3SQguMlDh2Bv1tID6BEkxeD4CQcSh1A4QUq4DByW9ZM2vBzo76PxyFMoPd
 bjJsTm2Ytu2nHe+9CKUFgFaSx3lIVBD1JeE1zBl28rSMIRLt1CKRbxnFHXBfkQzLW4I8chGfWk5
 J/sWCmV8RtauRSjIxKrjoEXhVkWDSxKLmELt2rQyfeTQBNv2LWK886uMT+/Px8elRi7A19yPwGG
 7fQ9larjxu5K7VLFrDMqooaneufFFGR/FKY+LgnndR37HJQ/PT3eBlXu8WB448CkKQ==
X-Google-Smtp-Source: AGHT+IFYXCzbTFyNpFo+/GYGePnB+ahiUdqXKhY+NZKi+ZPsvLUsiHHLIKejAHlbITfeO0ayn66qUw==
X-Received: by 2002:a5d:6d8b:0:b0:38d:d328:7987 with SMTP id
 ffacd0b85a97d-38dd3287fd1mr2148023f8f.40.1739032770614; 
 Sat, 08 Feb 2025 08:39:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd1d3a2c3sm2661793f8f.50.2025.02.08.08.39.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 3/7] hw/char/pl011: Introduce pl011_xmit() as GSource
Date: Sat,  8 Feb 2025 17:39:07 +0100
Message-ID: <20250208163911.54522-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Extract pl011_xmit() from pl011_write_txdata(). Use the
FIFO to pass the character to be transmitted.

Implement it using the FEWatchFunc prototype, since we want
to register it as GSource later. While the return value is
not yet used, we return G_SOURCE_REMOVE meaning the GSource
is removed from the main loop (because we only send one char).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 36 +++++++++++++++++++++++++++++-------
 hw/char/trace-events |  3 +++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 807fcdee50b..b9c9e5b5983 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -226,6 +226,32 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
+{
+    PL011State *s = opaque;
+    int bytes_consumed;
+    uint8_t data;
+    uint32_t count;
+
+    count = fifo8_num_used(&s->xmit_fifo);
+    trace_pl011_fifo_tx_xmit_used(count);
+
+    data = fifo8_pop(&s->xmit_fifo);
+    bytes_consumed = 1;
+
+    /*
+     * XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks
+     */
+    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
+    trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
+    s->int_level |= INT_TX;
+
+    pl011_update(s);
+
+    return G_SOURCE_REMOVE;
+}
+
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
     if (!(s->cr & CR_UARTEN)) {
@@ -237,14 +263,10 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
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
+    pl011_xmit(NULL, G_IO_OUT, s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b2e3d25ae34..3d07866be5c 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -65,6 +65,9 @@ pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x val
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
+pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
+pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.47.1


