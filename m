Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E70EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY85-0004iz-MG; Tue, 03 Mar 2026 17:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY83-0004hh-A2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY81-0002Qn-Rd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so38152515e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576528; x=1773181328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOiFzMYt3nqjzzSrXRu86P7xq+XKX8Q8xCa2W8q3YHY=;
 b=kXPMI8l8ALa++p4ATRP1My4VsDS9Sh+oBWmuvmcvd8boyC+Fz2OdEq26dzHHSYn0N8
 P1ZBuyf0IjcuyQKTRN9dPHz1ZWiDaDoaxoIzdhBjZWwyujzlBsF/Exzf0HQe8kF0j4WK
 pOFFBv4XrlCopCX78z/rKJjknuwsvum17Q/uTZ31Hg0zu7f1dlq2Zn0d0bfY63lr44wK
 jMtU82SLfhSVYnLpl4MhJVK2ZGmrvGCvgOht0ekKcVZAiFSbYXXzHc7PHsLlnpgmTwG+
 YdvycMyU8olR7pRxOhGr8blHqeMBGJSGiQGFT+AlaqzPkij26iKatFB9Dq25NiMFm6kK
 vsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576528; x=1773181328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOiFzMYt3nqjzzSrXRu86P7xq+XKX8Q8xCa2W8q3YHY=;
 b=tObmBrhoycC1n7L4/wEFqh+zHJlL7mw6IMbw0X2c0O1EuhSw0etbWOWIPMJd/q7h98
 BmBh3qt50g5RgXCee91wX6qkqdFzyI3boWZ3MX28Xt3ATqBQgFQmXysDxkQCtw0vyIK6
 GXM9B9h+YSlWCYYgKeISIXsepknsIPTQfyA6tS5SEVL6tGh44VPCBb23wBUeb75On7TZ
 1DQJUGmFmO4ur5BQB96lp7SVnVQHG+F9WHFJYRz7m+FTabqbm+TVBDNVZTpolnUYq2cG
 acLcsu2LCWYzB8Y/d2YunDFfQZ4ccWTSglFeZ5jvooCuxbtyPBQnZICeBhGV1A33NHVD
 fEBw==
X-Gm-Message-State: AOJu0YzK7UMCRsBLyN99xR2i3iKDdo3yE9NsfaOcfoD5xF+HzR5cAQiw
 KFMkl/Z8D6dKP1WHEpVSN5ylBCDXwSlOcPiFm9a1aTkmh7AcAx/LPZsVtlP6IQ==
X-Gm-Gg: ATEYQzzjpNwZE/Kz5Ec/x+BiyCCZAIcuPjMn2oRjuvXvX9vLHsxSAcu2OVhxlKkR8uV
 oiIkRP95Wj74GdrRpQDlFbsU9VrqQdV7KK16LlECv88XNBi6/dppPIlAqjW/8l0XmrLWgw8YFON
 hJe2Mpv0l8o8xRRcmOVyff+GHlvCzy/JWgAlGfE59f88jofBajhgmfaF1gRo3gzWoC8SIr6ypRO
 n1WW5cfVmU76lHeFbkvbfRWADiGZTJVH1pUbNQvINnfXNr4iejB0OqHsQ+Rxcg2vDACRY7N7/wK
 oDeBGT5eg1MBGO7rymaBoQPdtNhjKHPXXHps6Ma/sns1BrXaxZi7YUVzMo5MRtqsAHtH4DQsU8r
 Uz/CU+TAYz03/wBlW70J4bqeOmnaUh3l++/2JhaHhOxxuQmuhPbqzfOGjs5FyxqYnoBEwcBiYQp
 NgyGGDi++OWz8DU9Daa2umXOdVtwgTbM6VtfrpKnRUC5L2//5SYlpAjfhreCyumm3a3dzsAYf1z
 AuXeAJYXMTN6qxjBwXT/rZvZEz0ilA=
X-Received: by 2002:a05:600c:530c:b0:483:afbb:a077 with SMTP id
 5b1f17b1804b1-483c9b971a3mr296550795e9.1.1772576527895; 
 Tue, 03 Mar 2026 14:22:07 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 05/13] hw/char/serial: Prefer fifo8 methods over open-coding
Date: Tue,  3 Mar 2026 23:21:35 +0100
Message-ID: <20260303222143.142741-6-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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


