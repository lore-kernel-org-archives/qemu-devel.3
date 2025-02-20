Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A2C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2sm-0000Lg-VL; Thu, 20 Feb 2025 04:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2sk-0000F5-90
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2se-0003Ws-Je
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220e6028214so13346905ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043802; x=1740648602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X18oBKzoazjCfVrAQBfQueu5gB0Bm4XcS+Nhh43VH0E=;
 b=sGyhHRgz5I3An6YFRbya1PIY9SMupm2+Re9sI0O+Q6yqx7DzfMY96Z1gAW0mlesRkz
 mXfUVZq12+oBKuuU7UMZ0TeO+o5CenudcH/9jg1E4auXWJ4Mz0QOHshHXvxaYFoCvGXB
 hGceEhMj6A1pJPr9odOMDkGam35xU+RjinYPY7bTgs0WWLXfpL/njQLks7RHveD/800a
 ug7m6mU2srIwe3XGMIFJjOREF9Qsre9OYnapxxwulKhqYSfNbqKnl7ZX+2HtvfTSjR9k
 8dqbHEhWNRQsYaARc7DuGDFs2zcAXMr0HvmJIho8iy0okncIpjmeOJxhb/YkLa0r+ghS
 /gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043802; x=1740648602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X18oBKzoazjCfVrAQBfQueu5gB0Bm4XcS+Nhh43VH0E=;
 b=C1AbF2sSpAHdjYdckqngE/4owWdPbK7LplnWvoh3eb5SjkYRIS40mxtEN150TmwrfA
 Euv0n5slQPADRW5rbCm7CtwoICOEEls5IclOVQo0HwQEI68oLMX9aJHIq82lz4RIMQNu
 y4zFkuxNp8peY885AMXQ0CHQgnhz4mMleIfkyWo6nQ6FInDqCti9kj94U6cKNBlZSbf1
 xhHxV62XzdJiJReF0vn9wFvDQiedEjnZktPDyW3rzcDwk3kK/lavnlv1S0qjtrWzHFxG
 0lqXO5d8NIaEBlKE2SZ2woLEKPSi4C1QasvnA+Z2BM3hVDY3KvmqyZihoSbwGu8wRsQv
 YGnA==
X-Gm-Message-State: AOJu0YwBp8q/Bl3FB2flYOLjHYi4i++Y956cUA57MQlV0v1I/LG3rGmJ
 lavsH0PMPO9yfgq45WUI0BPRKWfP0/hCXb8v40Kqlj63gywO23IuAZOZgFpGWKcl+X7BBfuSdzh
 8Wos=
X-Gm-Gg: ASbGncvet4f5kH7kj1SH09d6q0LRYX3uVAaUKkG4GrWu5AW30XE4RFwFfmgutpKRLGk
 2JfVelk1iSFr7wXa6KTHDPxzx+bIAG02VVsXyFMJIweCndswcKErEq6QagLMsC1J3vwmZa4oMCR
 9VB7VO4Yy/7oG8O1/6ztckpP3xmWMJ93erRKLeYalWXvXYpa/lPkiMWzEWF35jWCPoxXV0gVR+w
 m0B96NMqJl8dyafT//I0fOynsE3lM6O8yF/JNFxp+ePnsETNTfl1OyDjYIXPNw8Bv268QLw91sf
 qTkvbzHoKXeu/3LrN34FH4Kd6gi93a7mzU6Je34TYqLLaku8uPLlMJnyUfu+/lXprg==
X-Google-Smtp-Source: AGHT+IFsfx5MgTFFxNPP9UpuBqTLo0Re7CfdCmPk801bj7BN1KDQujSk/EOnRTupB/bvHjXFwNsLLg==
X-Received: by 2002:a05:6a20:72a0:b0:1ee:d07b:5ff2 with SMTP id
 adf61e73a8af0-1eee5dab919mr2997879637.40.1740043802484; 
 Thu, 20 Feb 2025 01:30:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732581df0bbsm11052819b3a.156.2025.02.20.01.29.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:30:02 -0800 (PST)
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
Subject: [PATCH v2 3/9] hw/char/pl011: Improve RX flow tracing events
Date: Thu, 20 Feb 2025 10:28:56 +0100
Message-ID: <20250220092903.3726-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
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

Log FIFO use (availability and depth).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/pl011.c      | 10 ++++++----
 hw/char/trace-events |  7 ++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 5bb83c54216..f7485e7c541 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -185,7 +185,7 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
     s->read_fifo[slot] = value;
     s->read_count++;
     s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_fifo_rx_put(value, s->read_count);
+    trace_pl011_fifo_rx_put(value, s->read_count, pipe_depth);
     if (s->read_count == pipe_depth) {
         trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
@@ -248,12 +248,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
 static uint32_t pl011_read_rxdata(PL011State *s)
 {
     uint32_t c;
+    unsigned fifo_depth = pl011_get_fifo_depth(s);
 
     s->flags &= ~PL011_FLAG_RXFF;
     c = s->read_fifo[s->read_pos];
     if (s->read_count > 0) {
         s->read_count--;
-        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
+        s->read_pos = (s->read_pos + 1) & (fifo_depth - 1);
     }
     if (s->read_count == 0) {
         s->flags |= PL011_FLAG_RXFE;
@@ -261,7 +262,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
     if (s->read_count == s->read_trigger - 1) {
         s->int_level &= ~INT_RX;
     }
-    trace_pl011_read_fifo(s->read_count);
+    trace_pl011_read_fifo(s->read_count, fifo_depth);
     s->rsr = c >> 8;
     pl011_update(s);
     qemu_chr_fe_accept_input(&s->chr);
@@ -498,12 +499,13 @@ static int pl011_can_receive(void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PL011 receiving data on disabled RX UART\n");
     }
-    trace_pl011_can_receive(s->lcr, s->read_count, r);
+    trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
     return r;
 }
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
+    trace_pl011_receive(size);
     /*
      * In loopback mode, the RX input signal is internally disconnected
      * from the entire receiving logics; thus, all inputs are ignored,
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b2e3d25ae34..05a33036c12 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -60,12 +60,13 @@ imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
+pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
-pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
+pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
+pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
+pl011_receive(int size) "recv %d chars"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.47.1


