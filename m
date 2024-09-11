Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D348EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJ1-0005XV-7G; Wed, 11 Sep 2024 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIC-00021K-Dq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMI9-0007aY-0D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso40414745e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057064; x=1726661864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VR2UR1dthqYJR71A2WcgwFe6vVtppJkQRzukW2+d1s=;
 b=OBuAiYyHgsBMIkMx0Py7t8Jku/lpMKHLbsCwVey7KAoM4raxaabvDSXP632AhoGlnP
 C2LLBMz9sfz+Vs3scgjKdyg9CnwcBZtkSz37aGviAQrEhgxYkQfanZ8tmFsPffVopkd8
 H0hrs/13mmxkPqQfiKdDtI6KrHqWlc8747pwPeL09goQPTV+CXwDz2IDR3gsNLXsQH7A
 f7ibyabEFQUac+AxNO6BcRuKrDB+JySJxc4Xpq1Mb9aCt3uRc0+E0wGjENYOIXJ0ru4k
 HHsPgiDwx8avzcAGfzNbkFYdgAEh4gVZg3APpwxNOnrV0MzYArd5otVV2V9QyszEaYif
 Fpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057064; x=1726661864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VR2UR1dthqYJR71A2WcgwFe6vVtppJkQRzukW2+d1s=;
 b=rDLGfsX0ltOOXUVw+SqJlIRBEBUBWoyzAmE4PB+57YwSYiahVZt5CfXKnWRKseynty
 lzlOkbi9cOZxXEwIujUW1tUXhPo27GKazdLQ+rkp7C3OKLPh/fRJluI8+Hi+KFwtGpsb
 tQo8NoOUb4GYVH7bENFXiFw1dA9AudnL04uWbPc+ObtcwwYdeBym+rSvHJR6rL2mj0z2
 yrLGLpVO+WGNd8mgphBfuybvDVyM0OsZ9y6QQml2DSpAxYwL4biGPUnLN9Dm450EhfSE
 W40m3Zr3tv2ckUi4kAtLLAaxsRTJn5cbPae7bMDyocpMPN5wvqmAnSzPujbPXDWvGpF/
 rZlQ==
X-Gm-Message-State: AOJu0Ywvwy+zmfg434Vu7wqpk5CP/re7xQFiLKfpgKgmnE4cyfE3RRwn
 N/tmsUsTg1bH88+MUtYVNWsfRnfDYkv/Qiw+/wGGyb1n3aw5xO+SnnEu0LMJBpzb0bg8LxUp5aX
 L
X-Google-Smtp-Source: AGHT+IHfZ1TgJsVOLnr0L5y3WPBmQ0dzb5Wem6cC9z0XKTrmzyMVnDQU2TfAVmSa424cj9u/+UKupA==
X-Received: by 2002:a05:600c:3d93:b0:426:62c5:4742 with SMTP id
 5b1f17b1804b1-42cad74649emr110286175e9.7.1726057064145; 
 Wed, 11 Sep 2024 05:17:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb44473sm140415835e9.26.2024.09.11.05.17.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/56] hw/char/pl011: Rename RX FIFO methods
Date: Wed, 11 Sep 2024 14:13:55 +0200
Message-ID: <20240911121422.52585-31-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

In preparation of having a TX FIFO, rename the RX FIFO methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240719181041.49545-12-philmd@linaro.org>
---
 hw/char/pl011.c      | 12 ++++++------
 hw/char/trace-events |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 9c045d3709..7ac2f39ac2 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -173,7 +173,7 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_TXFE;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
+static void pl011_fifo_rx_put(void *opaque, uint32_t value)
 {
     PL011State *s = (PL011State *)opaque;
     int slot;
@@ -184,9 +184,9 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
     s->read_fifo[slot] = value;
     s->read_count++;
     s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_put_fifo(value, s->read_count);
+    trace_pl011_fifo_rx_put(value, s->read_count);
     if (s->read_count == pipe_depth) {
-        trace_pl011_put_fifo_full();
+        trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
     }
     if (s->read_count == s->read_trigger) {
@@ -220,7 +220,7 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
      *
      * For simplicity, the above described is not emulated.
      */
-    pl011_put_fifo(s, value);
+    pl011_fifo_rx_put(s, value);
 }
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
@@ -503,13 +503,13 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
         return;
     }
 
-    pl011_put_fifo(opaque, *buf);
+    pl011_fifo_rx_put(opaque, *buf);
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
     if (event == CHR_EVENT_BREAK && !pl011_loopback_enabled(opaque)) {
-        pl011_put_fifo(opaque, DR_BE);
+        pl011_fifo_rx_put(opaque, DR_BE);
     }
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 8875758076..59e1f734a7 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -58,8 +58,8 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
-pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
-pl011_put_fifo_full(void) "FIFO now full, RXFF set"
+pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
+pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.45.2


