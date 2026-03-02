Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB63EB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBM8-0000Lo-Dh; Mon, 02 Mar 2026 17:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM6-0000Jp-F0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM4-00017A-Ut
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:10 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b5d78592so1421775f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488987; x=1773093787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9Q4ujscL56Vj60CvB2c6SJCwK31JFBh4t887aTpkrQ=;
 b=YTSqNU2iuKkmoUbTcxS+BBymp0dOdjvQWwabOuER/RYINJcRQPFExepsz29BJbAZj9
 Xgu6se8YzCtKBAAo37wlL5Hoq5lWRREYU52mT3wYeDn2zY2rx0Pbkb0T61tz1jrWwEdV
 c3qHeLompUsChYoubcwD9JW0jyzMX61Iqrveg+0m8VpvsgK7KrcSuCvOElpvbRCvGQiS
 82rA4FOWJqCZaRidMR1cTn+drPgJSE5As0D28L2L06e9pNaD01a3jSM8kn18oY0/hcrL
 VipQpqtgLNKAswo27i7ht7IR9+BIu8tQAP9y040g50XB3cqBx0nJuyBVSrmI7JCjp8Es
 zWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488987; x=1773093787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/9Q4ujscL56Vj60CvB2c6SJCwK31JFBh4t887aTpkrQ=;
 b=p3b/upUpn9tjX+Tq3Dt7HRxOAjL6F+4XsG08b7sd7S2ulhPofK8fOnii+qkUgyJRYk
 d4ldTzCuloUYq2TMbOKDzZ/y1n8hX8o4CElu8lNPYSIXqkpApD8vCEvAzjZfYxpzGDMU
 PCfm5kS6F3vQ08gyy5XT6fdJBh9ISrPEiuJXgonAr6wQV8OXvG9JJq86shu+A/CDhJaM
 370s055d35TFUU7s+tW747MUdqtbBisTqmf7FN8rSl5q/m9Eu8rLKy097YA9AP8XD5nJ
 K4P+LfCN/L0TK6LjsZmlnCXyJznhA71mrJ9b+053FH0cW7QS1BI6IGZtWZ/14BSy27gG
 guyQ==
X-Gm-Message-State: AOJu0YyIKfae2QcViygZcRHqUqOtlXVXorUlIFUxEOMph7o74Tzd6Y7g
 ykX3TZsu1CGEesnOJICTHAoavFtx0ofX+Ip0mS0/APTRZOcz2SZJaSYJ2e+3JQ==
X-Gm-Gg: ATEYQzwo5eXcdpKnl4LDyy3qxneNCH0R0CJSFQ68Gdu9o3vfAbKaUo9ZdIWVmWnEcVj
 THF2eRPRp340/TucFFVojtGsjjAPBuoiqgNcNfafcXA24/r7by0qbXP+noKJcySTzfUhy2rYNnS
 jQ9uWSU/c3pnIdfhl7bJQ8eKEti+Yo7llrEGiZJeP64tNKMtw8X5/ww7E6WcuK09JtHdSfAPo1O
 nCPqE67Gz+rNi4ccwO4Kn8wsUMK5LpJo/9b34X8xwLGOaQMvODGyiR5Ewy0vJoD4/ZocM6NuUpz
 XUrs2nuDOpMxK3yLGaxcHYrWVVOyYmIH/ewojVZx1l4GE7f2UEbsafNcabxakbEAwoXcxn+0DXw
 GiX+dGsmR5pi/JVK6/nwYZaH4ZUv5Ctmqnkxi1a4o6NB596+a7mkgvWBP1CCGMTlqmsCGbcskOX
 /EC3ZFi2hjXCs+5yMQYvC2DwdGdHGHYEdNTrDlPN9dtdQsN3otQTtoXDapRfz7cAPna/87fmXVv
 rA3dd6PXl7xxlGJRVkwyHSdA6bDvxo8XPiO6qtlSHXRxbc=
X-Received: by 2002:adf:e586:0:b0:439:abcd:b317 with SMTP id
 ffacd0b85a97d-439abcdb61amr14182499f8f.14.1772488986717; 
 Mon, 02 Mar 2026 14:03:06 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:06 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/12] hw/char/serial: Prefer fifo8 methods over open-coding
Date: Mon,  2 Mar 2026 23:02:45 +0100
Message-ID: <20260302220254.1166849-4-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


