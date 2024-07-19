Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD767C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs5w-0000I1-3P; Fri, 19 Jul 2024 14:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5a-0006P1-0S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5X-00041X-HI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4267345e746so15652315e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412734; x=1722017534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kzt7MO4LraScd40R9aNwzx12/7fqeBF/DeM0jkgAnc4=;
 b=EeHvyC8/Ik2aQQ4eg9NE8B2lQAQxFUU1Bs0CG7RDzozuXK21MVZUkw+bcPCM8Is6hX
 9V2k7xAQds1atqL0n13z8zkcmNk/UFDwizhdEGfXbN7UM0APf7jteulrxImdTL1M2a02
 0ANlSLHVuNkXVteitL6lHoEatw8dYhCzeHkFVfTKyxZflHieTCczfaKQqpiWDcFfewzX
 kl+QuzRDTSNcNhItf17ispnimma18nJ4hd7tEFQ7LAeX/zNEKrpimKNylAmwn5HwXP58
 1fINEeGb7tT3J54Yp60uBb78eVR/pzJl7odxeByR+bNKxKO1ROPyg6tQP4xFhOgF2WKM
 FvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412734; x=1722017534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kzt7MO4LraScd40R9aNwzx12/7fqeBF/DeM0jkgAnc4=;
 b=sdoyekXWQc7ric1F8U+v9hhXVXU0J23SVnSW2V6KEL2deqoaq6dOU5hqHlCA0zjJFK
 iCmlsmP71IhwEgIfcDv8B4TAp32OI0WrOLmR/4iwQwqGPmlCTmPURbdSzs/KgQLSbgyJ
 sM93nQOD1XbuyXyjfCNHBIYUJUeZPxgfsPsBPuYqIEqY2K0ZbPeV6joDD2r5jQmsqzar
 z29MdkqoFe5uRHi82djXhouuxJpvileN5AR2NRJgTpuP0jsns2H2f+j9ReIayaJon5Y9
 YNvtXz/PbsxqO2M0M1IQVM9IsI0PhzqIYbASEx5pv7lqr8rWhvPIcSEHVSOe/E5rzOcn
 7b/A==
X-Gm-Message-State: AOJu0Yy7gj3f51WlQnV8LHzizfJwgNvqbgIQ/xQUx2Ncerm6atZkY/PK
 B69IeVJPS9Y04TPZmfQKcYXR5hKkhYhSdt34XLujAwPhASQsjGLzwLQPtazKPgM1Gy0Zzb2A7G5
 x
X-Google-Smtp-Source: AGHT+IFAlTBZGNzmud28AaYdKNsP59hLbnRyUBwyNJoUflUjfuejIehacn9/40ePZEK8Z5xNXkj1/Q==
X-Received: by 2002:a05:600c:c08:b0:426:6f15:2e4d with SMTP id
 5b1f17b1804b1-427c2cc27f0mr56979845e9.9.1721412733714; 
 Fri, 19 Jul 2024 11:12:13 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6efc5sm60849745e9.21.2024.07.19.11.12.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:12:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 14/16] hw/char/pl011: Consider TX FIFO overrun error
Date: Fri, 19 Jul 2024 20:10:39 +0200
Message-ID: <20240719181041.49545-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 hw/char/pl011.c      | 17 +++++++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 6394d6eb36..b8cde03f98 100644
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
@@ -232,6 +235,13 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
     int bytes_consumed;
     uint8_t data;
 
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled UART\n");
+    }
+    if (!(s->cr & CR_TXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
+    }
+
     data = fifo8_pop(&s->xmit_fifo);
     bytes_consumed = 1;
 
@@ -257,6 +267,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
     }
 
+    if (fifo8_is_full(&s->xmit_fifo)) {
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
index 30d06a2383..4a9c0bd271 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -62,6 +62,7 @@ pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit(int count) "TX FIFO pop %d chars"
+pl011_fifo_tx_overrun(void) "TX FIFO overrun"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.41.0


