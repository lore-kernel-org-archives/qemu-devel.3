Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3B7C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2uG-0004Zi-Oc; Thu, 20 Feb 2025 04:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2uC-0004AD-0e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:40 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2u9-0003z3-WE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:39 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so1401182a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043896; x=1740648696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrT6wI7eGWijFG9r07os9uEfYAKBYpxue/APgueq34E=;
 b=IFCAq/tP5qNAEyYu2CEnloHHyGPFmbJoqGuuq9wzr+cUS+81vbIB+tOF6O+BdiIDzG
 gLllUN7CPZiuSWK0QqjfpvHrS+aITQL9jSeDvw12DE1aZ+brrObIzrCv7+qBGl5FoD6P
 nF82aGYLBkIzZf4nNzTHuM/te+iO9nWDwmBM2RSGX/8PrujgRvTzPoU/361+n/klKaHR
 q7kdA1wntMldeUpCtxWBGXVp8i5H7Qrx6mx6JSIM12M3MKo1Z5xV578h4PS8YaqyW71V
 gsM5EouFySa25HDEmFmvoulIbzZOd2RhqAcAbaqS6pMdiXKK2s0iKrsGvKsx00uPjDNE
 opyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043896; x=1740648696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrT6wI7eGWijFG9r07os9uEfYAKBYpxue/APgueq34E=;
 b=fovPoNN942yUuTNpaaE4C6pWgXJrTW4UYO2tV7lJqIUJMZE6wWSMNN6oO2sE6RApRd
 Mh19KWJPSqgZKfR8es8DJz861ufCkcvFXVseBQfVhrXS7bxHXs0jCo4sv3ZUbbZG9UBW
 Em6h1Kduf08OJtWk/F62uXcW42w0L1I97JLzr9Fqx//01h0vT5E7l+pQD9dflEcbHeNA
 4/nO9c4SAnscfBodiAPtmi9xor77lBOEYVWASBDroj5WVlddjJ7JYh7ThYrY1GGQJnb8
 1FT0Pio1lWwa45gx9dSYeypOjIXynzNRTRlGKSo0YnB0xolcRmTjZvLimFn04W5lpq37
 H2NQ==
X-Gm-Message-State: AOJu0YxfWS1TbrmWFLzHG1MzVNdfZsiGjIkbSy0S/9txjqsv0dlkax5l
 Zsxl3T+OUyHWLGxljnlqhD+IB/Iotlqu/QIqDbuPhx/keXNrUnpiZ9rX/mpLAo5MewhM06/+Mxk
 ry3E=
X-Gm-Gg: ASbGncujLw+FnbKNnuoaDz7HpcaYD/KN1oE3298gY+wSJnX8QvFO92wDTYWtqPAoFAq
 HeiouRZV04tBMH6Kvv0dJ08QmsyEK5POr/PEd93aJaAkrbkRTRcoMMQpBIir1APnYb+xlkLgJQl
 V+kmvYSaNsFm8L09i/uMpOOZzjaC4a4HEPc5DT2rioDkyQlVkYroCrQkssBjdEJ3Yd6n3gWR2r3
 HA9GeS60b5qpTkGqKN49kILyojWoWGq55VKIl3O81Vjuz5NBLb2Z30SCbFN5j91hPYpFs61Exj1
 7S58M91toYr4DJLQ15eu9gvJfZayUIhzb2BE4mZ9NYL4Y2l6p2vifzLIt5GlnZj5XQ==
X-Google-Smtp-Source: AGHT+IHzB09fOgQ9JAxm6Hg43hIcwbgKVGg/0WdEobzd0QwenNGTBOK1RXpNvRCYw4fa0qda/VG64w==
X-Received: by 2002:a17:90b:2f8f:b0:2ef:2d9f:8e58 with SMTP id
 98e67ed59e1d1-2fc411508famr28637110a91.34.1740043895854; 
 Thu, 20 Feb 2025 01:31:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fcbaaf3f38sm1628375a91.1.2025.02.20.01.31.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:31:35 -0800 (PST)
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
Subject: [PATCH v2 9/9] hw/char/sh_serial: Return correct number of empty RX
 FIFO elements
Date: Thu, 20 Feb 2025 10:29:02 +0100
Message-ID: <20250220092903.3726-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1032.google.com
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

In the IOCanReadHandler sh_serial_can_receive(), if the Serial
Control Register 'Receive Enable' bit is set (bit 4), then we
return a size of (1 << 4) which happens to be equal to 16, so
effectively SH_RX_FIFO_LENGTH.

The IOReadHandler, sh_serial_receive1() takes care to receive
multiple chars, but if the FIFO is partly filled, we only process
the number of free slots in the FIFO, discarding the other chars!

Fix by returning how many elements the FIFO can queue in the
IOCanReadHandler, so we don't have to process more than that in
the IOReadHandler, thus not discarding anything.

Remove the now unnecessary check on 's->rx_cnt < SH_RX_FIFO_LENGTH'
in IOReadHandler, reducing the block indentation.

Fixes: 63242a007a1 ("SH4: Serial controller improvement")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/sh_serial.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 247aeb071ac..41c8175a638 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -320,7 +320,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 
 static int sh_serial_can_receive(SHSerialState *s)
 {
-    return s->scr & (1 << 4);
+    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_head : 0;
 }
 
 static void sh_serial_receive_break(SHSerialState *s)
@@ -353,22 +353,20 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
     if (s->feat & SH_SERIAL_FEAT_SCIF) {
         int i;
         for (i = 0; i < size; i++) {
-            if (s->rx_cnt < SH_RX_FIFO_LENGTH) {
-                s->rx_fifo[s->rx_head++] = buf[i];
-                if (s->rx_head == SH_RX_FIFO_LENGTH) {
-                    s->rx_head = 0;
-                }
-                s->rx_cnt++;
-                if (s->rx_cnt >= s->rtrg) {
-                    s->flags |= SH_SERIAL_FLAG_RDF;
-                    if (s->scr & (1 << 6) && s->rxi) {
-                        timer_del(&s->fifo_timeout_timer);
-                        qemu_set_irq(s->rxi, 1);
-                    }
-                } else {
-                    timer_mod(&s->fifo_timeout_timer,
-                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
+            s->rx_fifo[s->rx_head++] = buf[i];
+            if (s->rx_head == SH_RX_FIFO_LENGTH) {
+                s->rx_head = 0;
+            }
+            s->rx_cnt++;
+            if (s->rx_cnt >= s->rtrg) {
+                s->flags |= SH_SERIAL_FLAG_RDF;
+                if (s->scr & (1 << 6) && s->rxi) {
+                    timer_del(&s->fifo_timeout_timer);
+                    qemu_set_irq(s->rxi, 1);
                 }
+            } else {
+                timer_mod(&s->fifo_timeout_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
             }
         }
     } else {
-- 
2.47.1


