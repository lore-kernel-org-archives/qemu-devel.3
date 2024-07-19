Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AA2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs5m-0006JE-30; Fri, 19 Jul 2024 14:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5H-00052D-J5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5E-0003yG-P5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso899460f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412714; x=1722017514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr9xFBvmiXrV+CsrPSg+/78zPNAgl06z+/3j2DOHoiE=;
 b=bVH804gcJd/lt8vcj4B9UObTTlo8ioE3Jkk/DoOeg8Gsd8scIK/QVRbd8odaBqpSH1
 dx8wd/l75JJDFmVUGpDqaHZQwaCmkDL8p/h08JN2nRHFYnEFxX4f70a12+/U2rjBSptM
 8tauZDVg2Ye/6pil/gvDve7TgzNdX21m0kXhIrlmQXDX9jyS2B0468aECEjd+oVpOTsF
 IPDr6/1OkVFVBk5aOwYRwnJrtnlQSMyVY1eHJFCcSqfoMjxDII+sVtSr9QHMEp81Wt8J
 IwP6RzWUamSsg+j2/pcQbnwI1uH57aHsvH6CUpni5oquScT8/dEZOqX0DXT26kZZXaSY
 nyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412714; x=1722017514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr9xFBvmiXrV+CsrPSg+/78zPNAgl06z+/3j2DOHoiE=;
 b=gne8ujCUw3DIJGNF5PslGizGVBHpV9dmG/abZpsn+WxxSGEUesLWog4pVYfOtfIHm4
 nhKgLqCE4P1nsQpzD9rLtwClf3igq3hZbuof808QycOR5JrmNgjy3EqbyZh98+yW3h/x
 T3KWOsr6n6I7HhMVx1aRB+JkDfVT2coMup6SDBO04GDUjJv+fEBLaMUfGZoxJasAfoLv
 D3ywpuhIE+U5aGkfcMnU5VLFgE4bL3ocRqRyD25gwhoy9ljJUBDuIeVbpDApsszALoOB
 LPNta+Lcl7qL6aE/lABgkX0CXIKM6haR70EpkBTBdwRSEopB1YtKGhltPFd+99YkqjCW
 THBQ==
X-Gm-Message-State: AOJu0YzawIMFRbmTJ+zXNLtFqCxl13kYisi2MzuqxhMaBsx3i83e4jOz
 bnmXRyGFBQwfP0ZacB3j7NxCphLE9UqTWUFnS63EJLU7MDPHO11PoeiM6+f3eDT/Jzgwyp+BziN
 C
X-Google-Smtp-Source: AGHT+IEqx9LH5SRstVmm6eRi3r01852AxHvWp7MOR3vnRYdIZMpHUdz7EkxQSStRpODYu2p4pEaVVw==
X-Received: by 2002:a05:6000:4026:b0:365:32e0:f757 with SMTP id
 ffacd0b85a97d-36831737983mr6929266f8f.50.1721412714557; 
 Fri, 19 Jul 2024 11:11:54 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a95530sm55455065e9.45.2024.07.19.11.11.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 11/16] hw/char/pl011: Rename RX FIFO methods
Date: Fri, 19 Jul 2024 20:10:36 +0200
Message-ID: <20240719181041.49545-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In preparation of having a TX FIFO, rename the RX FIFO methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c      | 12 ++++++------
 hw/char/trace-events |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0ce91c13d3..c42c6d1ac2 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -174,7 +174,7 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_TXFE;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
+static void pl011_fifo_rx_put(void *opaque, uint32_t value)
 {
     PL011State *s = (PL011State *)opaque;
     int slot;
@@ -185,9 +185,9 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
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
@@ -221,7 +221,7 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
      *
      * For simplicity, the above described is not emulated.
      */
-    pl011_put_fifo(s, value);
+    pl011_fifo_rx_put(s, value);
 }
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
@@ -502,13 +502,13 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
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
2.41.0


