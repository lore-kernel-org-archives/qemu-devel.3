Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76E0C282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdV5-0003wj-Hs; Tue, 04 Mar 2025 20:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUc-0002Sv-L0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUa-0007Ct-P0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43996e95114so42450515e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137851; x=1741742651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0YNIJlxmbjMyr4LODgtrAg0p6qQTSAHOFsEzvnJxFk=;
 b=nS4DNtB4pnJCHZSbvX5cy1fNttUxfSwS1EUQ3gRI0GemZkRrIDf5Wwmf6mTW4+T9LD
 EIBBZxU3ALVsKPgBp/aA85+KE/d4wtEYp/YIZux6Nsf2E8j2zddhrnqUQBLgkbQkCgt7
 Q914r8u4zG49i1rMsaYN6hOrQqlcecyQuVys8PXP3biJhgg9vxHP+t2cpwjWak0N+jlw
 3TAnxLivCyCsV304FuOyICeGISsOsSDPjQ2/bk+J5VkBD+wxoY8FrnN8iFv6Ana5dkRK
 Pje1yooy5aGwm2RClJZItP3FX71J46X+0+dFPn2iQsqbcuBI/G0vycj+W1jktp7KLyLp
 T4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137851; x=1741742651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0YNIJlxmbjMyr4LODgtrAg0p6qQTSAHOFsEzvnJxFk=;
 b=R3nEM87/tpD4cZarAfz1t/g2n469U/d9MpvGTvbdL4htpok5gDa0Z+/Ic5K9SntkFM
 lqokEZyQSjwIarL3u//pWlyfg60jG6WwVOQR9j7o/xU3M+6wt/NfzfQecPZ8fTjEvT+9
 zq1bP8nHN/eh7R+sQiaa9WC4qHPEoScebCIBDlFPNjiP3OSSe6NyADes6fH+Hz45k64n
 kkjeSMYyQE7KGnYqBLLXncEO4ugrvszYw8rVlajS2eYK8kSs6tU6CY+83tLxiG3/KnzI
 j2a5umQOknCsb65/GL73RM1QQhy145rkJCVWRNRfzzBvqiE/seWaj10QeW3RpCdmaZNu
 n1dQ==
X-Gm-Message-State: AOJu0YwNuxN3sui59bJN2/6c6pMlOgVp4k64Ps61JpyanPgxJcJQ75hQ
 fixPvFV/gx3HggsmxO037g6KSGGEHnMXpyfUwR125/l2zEBThMz+dd4v0UEw7QznM2A7+xWHNu2
 VSTQ=
X-Gm-Gg: ASbGncs+Q5qTBGQppdZlBitPuAtN0kWP0TaS8sCvoTFWSStd6zgmZ4ieccMs6tNf++Z
 SeU7v/VJFb6e9/efvdfSF++B+z4Sqr5x0a8uDVBrWzbbhcoY0ZyZgQMBd8PmHyduytgusqTWP1i
 KJ9abVMfo0GJFbrsggnjCjMETwGVyjopRbK14LgHrlJ0EzovnzWAVaDPLTCYM8o068rR5Vz+wKy
 KX3VCdCKEu8ZOc/z2+7wyiiYaI6H7le007mTQNcjG8x9pyWorOfOKd5tkr4+cr2tYP2KlrGq/oM
 GC5BZ0UwulTKVgzpq2wj58jn/6yR0aTVeeNt1KyU7a2dM9moAT+i1mE+SnqQ6TbP59wnnOwDjvr
 lZw1BmLWfLYWm8/L+qB4=
X-Google-Smtp-Source: AGHT+IG4zPitGzF0AHLIpsN2Kc8zjT27A7xrp5GOLGyiAmj00b3x1ZF7XE+m9Mfre38Qbbbmw8fHyA==
X-Received: by 2002:a05:600c:1d0f:b0:43b:d203:da18 with SMTP id
 5b1f17b1804b1-43bd295494bmr6488485e9.13.1741137850946; 
 Tue, 04 Mar 2025 17:24:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292af0sm2020075e9.12.2025.03.04.17.24.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/41] hw/char/sh_serial: Return correct number of empty RX
 FIFO elements
Date: Wed,  5 Mar 2025 02:21:42 +0100
Message-ID: <20250305012157.96463-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-10-philmd@linaro.org>
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


