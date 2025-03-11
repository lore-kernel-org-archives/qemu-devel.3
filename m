Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034CCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5dg-0006tV-93; Tue, 11 Mar 2025 15:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5de-0006sa-FX
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dc-0007Qu-Kr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so1135665e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722698; x=1742327498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGCDYX13GS9d/sRLMs5uKLdwVFCuiGaxeg/YGNrcVkU=;
 b=RQjLX4q/M9mV6hiQcZ2y/+HPvXGgISN+pWNa+GHaVd8vseGDYaHPHjZrkFwIbi+/Tl
 x0ZkksTTGbQ3ocXj/6P18mGc47/WpA9U5ivIO6noRZSIrOLoejJ5Xr/9f3wvbzpjr9Ur
 0zFCCC25zPEg5tisQIUe1Du8WoBqHoG11yz1yqnth80bE09bHzLOvQ8GMFtlZJD2S3Po
 tK3QpkPdsO8AHfJptDoeXXxRHXKbdszlwGG73wRnrUEotoOQpjkCuYoQoPHFRmNa+F/3
 n3uOMOEg9jSq/buv67eR3Xcv2iEhL1jzlYY87ZJPiagWpJh/dnj/t2lO0dxtXJDHbtgg
 nx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722698; x=1742327498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGCDYX13GS9d/sRLMs5uKLdwVFCuiGaxeg/YGNrcVkU=;
 b=g7XNLhcWAKtmBuFTwgy/GYPNsRCxtok1M9qQAKYT4iH3BZR5LvTyMPuwCvTPBrQr8J
 t3s9yYOXxGWz9nL3+Ls0iSOLP1D6I+IcFbIRooL0T7V91sWMizOQsPgMaCDjSFKXDTbq
 Iv7JDBqwYlVkZL7hndLC5dqpAYbBobxXh2W/mxNgu5QrfNbR/Sd6rNx33d7Bmd72zl5u
 Eh3g0OJgsVl5fgsuQILd2is1b9ATvl9H3X97JJhBF7ILXSkWi4+vEWRXcCFvKoubg1pC
 ZltM3GeC+N+rts70oKHzUdASeukrGpo92fdf6q7203BUPqNIcLiGLQPKBgE1FMXvWnK5
 jwjw==
X-Gm-Message-State: AOJu0YwbInxKucTIX0WKh/+oK99Bb/9TPGb0PFXSPETzsXevsGXLco6k
 CPE6HDED81hGf4JeAT36OioHxi1vB9p7ytANoaxhfwegaHkGeFGM8NUt5ej1XA0XMXDT6N3lcIg
 3Ozg=
X-Gm-Gg: ASbGncti/vYlw/UN0BFLaYsojfk29lfjCK4W7rDDs1/VFcVBSqCNlPdyeTPx8IbbCMS
 c30p3543zBfYxLgF/kNd10s7kveQ4Yykwyws74cGFAvsu7rSl54EqKg9btwcsoMXogGzvWB5N3D
 J8Fg5HYwElkhv7hP3ZnRL3XVEEZQibZPB24ER7HZefrXUGkio+TH+ErkScMkzymmce18pNkk63z
 pL7SLYsCw5DkygfVFOiDSPPMJtIzHOVjvh7OPgfEbF4uMYgFHlue3edvvvQ4YRpegf/nSe5y4EY
 BniOcuJ7DlRopHqWiOVZZefvFZ1erHdbNsLB/qTNvsm1FVEFqwQOvT4y+Y42XV0zvZJ//JiXgHB
 /sBSJU+T81/NPYQPSXe8=
X-Google-Smtp-Source: AGHT+IGb7y6Cw27hxarVhsW1Xm59TJPSslXTJKr70l/gQib24nhbV/wsTAP/sMgFWJAKHEkhrDRAAw==
X-Received: by 2002:a5d:64a7:0:b0:38d:d222:ee70 with SMTP id
 ffacd0b85a97d-3926d1234a5mr6356135f8f.20.1741722698570; 
 Tue, 11 Mar 2025 12:51:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c106a1asm18914729f8f.100.2025.03.11.12.51.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/14] hw/net/smc91c111: Sanitize packet numbers
Date: Tue, 11 Mar 2025 20:51:12 +0100
Message-ID: <20250311195123.94212-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The smc91c111 uses packet numbers as an index into its internal
s->data[][] array. Valid packet numbers are between 0 and 3, but
the code does not generally check this, and there are various
places where the guest can hand us an arbitrary packet number
and cause an out-of-bounds access to the data array.

Add validation of packet numbers. The datasheet is not very
helpful about how guest errors like this should be handled:
it says nothing on the subject, and none of the documented
error conditions are relevant. We choose to log the situation
with LOG_GUEST_ERROR and silently ignore the attempted operation.

In the places where we are about to access the data[][] array
using a packet number and we know the number is valid because
we got it from somewhere that has already validated, we add
an assert() to document that belief.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228174802.1945417-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 0e13dfa18b2..2295c6acf25 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -118,6 +118,11 @@ static const VMStateDescription vmstate_smc91c111 = {
 #define RS_TOOSHORT     0x0400
 #define RS_MULTICAST    0x0001
 
+static inline bool packetnum_valid(int packet_num)
+{
+    return packet_num >= 0 && packet_num < NUM_PACKETS;
+}
+
 /* Update interrupt status.  */
 static void smc91c111_update(smc91c111_state *s)
 {
@@ -218,6 +223,17 @@ static void smc91c111_pop_tx_fifo_done(smc91c111_state *s)
 /* Release the memory allocated to a packet.  */
 static void smc91c111_release_packet(smc91c111_state *s, int packet)
 {
+    if (!packetnum_valid(packet)) {
+        /*
+         * Data sheet doesn't document behaviour in this guest error
+         * case, and there is no error status register to report it.
+         * Log and ignore the attempt.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "smc91c111: attempt to release invalid packet %d\n",
+                      packet);
+        return;
+    }
     s->allocated &= ~(1 << packet);
     if (s->tx_alloc == 0x80)
         smc91c111_tx_alloc(s);
@@ -239,6 +255,8 @@ static void smc91c111_do_tx(smc91c111_state *s)
         return;
     for (i = 0; i < s->tx_fifo_len; i++) {
         packetnum = s->tx_fifo[i];
+        /* queue_tx checked the packet number was valid */
+        assert(packetnum_valid(packetnum));
         p = &s->data[packetnum][0];
         /* Set status word.  */
         *(p++) = 0x01;
@@ -287,6 +305,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
 /* Add a packet to the TX FIFO.  */
 static void smc91c111_queue_tx(smc91c111_state *s, int packet)
 {
+    if (!packetnum_valid(packet)) {
+        /*
+         * Datasheet doesn't document behaviour in this error case, and
+         * there's no error status register we could report it in.
+         * Log and ignore.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "smc91c111: attempt to queue invalid packet %d\n",
+                      packet);
+        return;
+    }
     if (s->tx_fifo_len == NUM_PACKETS)
         return;
     s->tx_fifo[s->tx_fifo_len++] = packet;
@@ -457,6 +486,13 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
                     n = s->rx_fifo[0];
                 else
                     n = s->packet_num;
+                if (!packetnum_valid(n)) {
+                    /* Datasheet doesn't document what to do here */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "smc91c111: attempt to write data to invalid packet %d\n",
+                                  n);
+                    return;
+                }
                 p = s->ptr & 0x07ff;
                 if (s->ptr & 0x4000) {
                     s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x7ff);
@@ -605,6 +641,13 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
                     n = s->rx_fifo[0];
                 else
                     n = s->packet_num;
+                if (!packetnum_valid(n)) {
+                    /* Datasheet doesn't document what to do here */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "smc91c111: attempt to read data from invalid packet %d\n",
+                                  n);
+                    return 0;
+                }
                 p = s->ptr & 0x07ff;
                 if (s->ptr & 0x4000) {
                     s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x07ff);
@@ -713,6 +756,8 @@ static ssize_t smc91c111_receive(NetClientState *nc, const uint8_t *buf, size_t
         return -1;
     s->rx_fifo[s->rx_fifo_len++] = packetnum;
 
+    /* allocate_packet() will not hand us back an invalid packet number */
+    assert(packetnum_valid(packetnum));
     p = &s->data[packetnum][0];
     /* ??? Multicast packets?  */
     status = 0;
-- 
2.47.1


