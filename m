Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F1AF513E4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGt2-00019e-CN; Thu, 05 Mar 2026 17:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGss-00011Q-GD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsq-0002FZ-TQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48375f10628so57086145e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748567; x=1773353367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOiFzMYt3nqjzzSrXRu86P7xq+XKX8Q8xCa2W8q3YHY=;
 b=D2zMpfj+NJwRli0CBo8oYz5wjWOQZv9h4VLd/K+6Vs1Poc6e2WAqsniLwe3P67ZY7a
 +sHC0rKCwWrA8RGfTKOr0Vmq0hgxiRSEgwsjs/I6SygtJ/JfAWH3/IeZdiRVSQbm1+uS
 M4CFOlI3TSPjlx5f3koGvV777UeKT4VaFoOgePyoSetNtyeLI6f1vv4q3GxN7imO9kjt
 os120g8c3+7rtun/MSDTqvoNXjws/SVl9c0jJ8as1UU+t9p1/plYrW/yBB/LarLeGE6s
 02VuL/XzUSERyW+dKcgygAPSxxucqKYmQB7rK5lsLlffduaOPRjoylCL1Jxs9MdRBIPj
 Wd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748567; x=1773353367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOiFzMYt3nqjzzSrXRu86P7xq+XKX8Q8xCa2W8q3YHY=;
 b=g65mYML2b6Fln49y5SclCWCRyoDoC4KKeLUvL6tjGZutJ0c+WTi1Uw3vY1oiDXCnEH
 VXhGJeK0ZGdFQZa4Rpbxi68e5GC9YQZ5nxgWVWscT+/ZbJ03Eu7BZNREFNWP31nsPJpy
 dsRnoTOFT7WicS5ighXyRT97kiW5SKbj0TMhOGHj/92BmENsOQpLbEWv4fvUnrtFhcP/
 yI9g7+ztHBcr6YviBeicpMo5CP5621FsLn9SNg1tshGQHSnGcOB4h8+YBIHCIc4dKNcT
 neaRDInN498+KUEbjG2zQmx/aD5G6FTpB+PdrZdW0gMvXm3bE3KEP5oloT1871b29/zG
 WnRA==
X-Gm-Message-State: AOJu0Yx75JkbnJOfOFUvwkuqw5dblJaagJbG0Cv+wT17t7P2WCiiqgbM
 23TWuxaU6RAEUPGSlOn5qPGVjLuSAvJFBaq6N9vwhuITfbvPDH86JtHRHmoLPQ==
X-Gm-Gg: ATEYQzxBFt2moZhFWcERWeNxQClQ1w1Y3lwDL/TcaKlt2k8yq7GmK3gl7EczEeJsrlV
 TFJHL20Xcw0VoXYZwLAHpH8Y4vCCiN4+7k05pAyVLl/Va/Q/isz/y0Or4wqBQchn4bmv/cy/Hpf
 OtEXEj23mVycvw46sPU3ScT/KdNK5Bu86TycCu3Ju7Dq34BGzp/p+wfUjnCepWNZ9+Du6RNN9Ge
 FyavHhnWdsnWvvHQKog/XiCUl//ctVmRk+OsQVXe4wrEuu1XczbwLwfTuuZtcZ1Hb8nudB0iglT
 LGc/vG/djGktDko2FEJHqtyG66KCsUAYXY9lHXXr81qLXw4/K0D/9rGSvYS6Br/V6f4aweVeMFP
 +qcIGlIl3l6ixmrbaRb5w7mPLcxl8pGgjcHTfWr8q1P6+0BsJo3eJnA30KFDxCvoUnye3oaMiku
 6uiISdXL3IDZK4QobVx7GqL03jGVhTQYOiQKy24ZB/LnDzr+jL2L+U9Z4o8C6gq6s5oy9E8ANah
 /6pY4wXMCEPv6BkxIP3YDtbHwmc4uo2EBpJWWILNiptW5E=
X-Received: by 2002:a05:600c:528e:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-48519828c69mr136498285e9.2.1772748566767; 
 Thu, 05 Mar 2026 14:09:26 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:26 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 06/14] hw/char/serial: Prefer fifo8 methods over open-coding
Date: Thu,  5 Mar 2026 23:09:03 +0100
Message-ID: <20260305220911.131508-7-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use fifo8_is_empty() and fifo8_is_full() to improve readability of the
code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f2e79dfba..20f68fd2f8 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -239,7 +239,7 @@ static void serial_xmit(SerialState *s)
             if (s->fcr & UART_FCR_FE) {
                 assert(!fifo8_is_empty(&s->xmit_fifo));
                 s->tsr = fifo8_pop(&s->xmit_fifo);
-                if (!s->xmit_fifo.num) {
+                if (fifo8_is_empty(&s->xmit_fifo)) {
                     s->lsr |= UART_LSR_THRE;
                 }
             } else {
@@ -481,7 +481,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
             if(s->fcr & UART_FCR_FE) {
                 ret = fifo8_is_empty(&s->recv_fifo) ?
                             0 : fifo8_pop(&s->recv_fifo);
-                if (s->recv_fifo.num == 0) {
+                if (fifo8_is_empty(&s->recv_fifo)) {
                     s->lsr &= ~(UART_LSR_DR | UART_LSR_BI);
                 } else {
                     timer_mod(s->fifo_timeout_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time * 4);
@@ -555,7 +555,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
 static int serial_can_receive(SerialState *s)
 {
     if(s->fcr & UART_FCR_FE) {
-        if (s->recv_fifo.num < UART_FIFO_LENGTH) {
+        if (!fifo8_is_full(&s->recv_fifo)) {
             /*
              * Advertise (fifo.itl - fifo.count) bytes when count < ITL, and 1
              * if above. If UART_FIFO_LENGTH - fifo.count is advertised the
@@ -585,7 +585,7 @@ static void serial_receive_break(SerialState *s)
 /* There's data in recv_fifo and s->rbr has not been read for 4 char transmit times */
 static void fifo_timeout_int (void *opaque) {
     SerialState *s = opaque;
-    if (s->recv_fifo.num) {
+    if (!fifo8_is_empty(&s->recv_fifo)) {
         s->timeout_ipending = 1;
         serial_update_irq(s);
     }
-- 
2.53.0


