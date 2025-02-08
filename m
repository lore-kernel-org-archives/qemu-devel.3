Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6731AC0219E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgns0-000170-AF; Sat, 08 Feb 2025 11:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrs-00014M-Lb
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrq-0008Ss-Ii
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso20144505e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032780; x=1739637580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3jwnJ8U5C1FFKFcPCQMKp4F/bw0CDqtfmKmUBOfDPU=;
 b=PLCXSLcY1sDgcW6mxmLM6RZ4tYvUVioAUI0gOQNPAv6HZbFUNIn1N3Lrls9V1i9JHK
 HitLDG20y1l/SXuVE3hYS02dvMhfqPK4994PPYvDTAlNGfC1pYqdH7jrRQtfQXpSRm1f
 k8c/hR9qMZNZBa8NIaKHF1SdgVsXdQXiHUm09GD/f8v+6imdNrDcz3AgeVjzu7hugrdQ
 yhABqGyZtR9Ye6hIw+i719aw1Nudya1B+vDC8Pdl/zAozhCiamMv/jfLOCs6BAC68pnU
 IyYGy3wgq1DkQxxMXUjul9hl14UrrWH4+0WVic/JIIBD0GDYBxAoPrPLv1EUQnpG1c+u
 KJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032780; x=1739637580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3jwnJ8U5C1FFKFcPCQMKp4F/bw0CDqtfmKmUBOfDPU=;
 b=pMdDI3QXLTx0J0RRJOIrJ0ozspNuJF6P+lMTuIjWhxM68lFEBpWg1WkDR1z0Y+S53f
 IsC+LlNeI1K8LIKlZTWpYLrusVV1Ms+LwdiSP3vhCvH3It7zFcctfAq+RyCFtt3xuIhg
 +qZr2sUKFzNdcvmFMwd23d/OIq1ga+sHbvV9o02Tc5tvG30Ve5UeoYk20knUk7bjz/2k
 VhvpL63AkpPwTRzxmOUS7UWhFXmGgG8YrZkMAJj3n/RJhF7QeR+WUIlxLdsZfvYUCH2m
 umiZFboOen1B85RGQwVxiqXeoLcFMu5xgz+7ZpC5q8EAkIkHmCavdBgn1SGlcKt+0AUG
 aW6w==
X-Gm-Message-State: AOJu0YxDh7z+tftNm3e3bSTU+jSKVF9Yx0OIzo9kmiCelbGYZmd79K7h
 0KS7YGA/oA6vwSBt4AW6Y2DoaBCTDmtk3N7p3La6fNaiufpgSCsaVpUXrOqHN8iqWi0I9oRN+ZG
 5n6Y=
X-Gm-Gg: ASbGncuG9VIFYCQMAFAQMlNzNEDOYg/fcICdYgZNyPz2y+vCNS0BzZB6mq3CTmJfFmj
 xM+oxdpnKsycxI1rTld7xmtKoB8mPs0E3HRYfh5C+WcbQFUVxwgyq5Pf8Ad70PeLCQ7B2jHa0c4
 f/E6vprDSbjnqlBQcxYPa5eiYzX9y8wOpMV5ll/gdzhiSbDBKtPVrHgBJjFMc8SzHSRvaYjUyiU
 p6YTmr5gsuaBiPtwRqPzx1+fpxpTHmsRE8rBVklRMulnuV6jmz4uSdG7y4V6lzwKI+OZsZwcsP9
 JLTQ1XQSf5Jt5ZPb5APdqEFPPgDc1rDRZ8a1gEHW4hno434U2QPIakNC1iOR0qZH9A==
X-Google-Smtp-Source: AGHT+IGiNbPF0hpneHG2b2A0Hn0xLt9FrKz3WmDdZusUAVuNNTx1ruYM+CySYBMFZZ2UaThcWdrCkA==
X-Received: by 2002:a05:600c:4e0f:b0:436:1b7a:c0b4 with SMTP id
 5b1f17b1804b1-4392497d53amr49853725e9.1.1739032780459; 
 Sat, 08 Feb 2025 08:39:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc9ef8ac6sm4922432f8f.27.2025.02.08.08.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 5/7] hw/char/pl011: Consider TX FIFO overrun error
Date: Sat,  8 Feb 2025 17:39:09 +0100
Message-ID: <20250208163911.54522-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

When transmission is disabled, characters are still queued
to the FIFO which eventually overruns. Report that error
condition in the status register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 20 ++++++++++++++++++++
 hw/char/trace-events |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 447f185e2d5..ef39ab666a2 100644
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
@@ -158,6 +161,16 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
+static bool pl011_is_tx_fifo_full(PL011State *s)
+{
+    if (pl011_is_fifo_enabled(s)) {
+        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fifo));
+        return fifo8_is_full(&s->xmit_fifo);
+    }
+    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo));
+    return !fifo8_is_empty(&s->xmit_fifo);
+}
+
 static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
@@ -264,6 +277,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
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
index dd635ac6012..8234f3afa13 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -67,9 +67,11 @@ pl011_fifo_enable(bool enable) "enable:%u"
 pl011_fifo_is_enabled(bool enabled) "enabled:%u"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_is_full(const char *desc, bool full) "mode:%s full:%u"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
+pl011_fifo_tx_overrun(void) "TX FIFO overrun"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.47.1


