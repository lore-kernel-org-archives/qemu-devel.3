Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F6C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4TT-0007g1-Bo; Fri, 28 Feb 2025 12:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T7-0007R9-Br
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T1-0005Mc-NJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4398738217aso21724025e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740764886; x=1741369686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN07gCc2oP06ECRd8sreJOokFNA6cGgOnl4Jc0WaVu4=;
 b=w4k8A0ArvYP84JD1o+L4/HEwueeIZ4o9XETaih4MKeiD2BFqS//Zi339KMooC4Hp9q
 aeZmHIGZT8pwWNRfTsuWO8gs8pZg1sTX9gesYtSHUa/NSFZ8bzW2g7FyXIDLjr2HMW9t
 MwQ3dPhoqjKhGpjM8sCYiEA4iSqNxHKhUPDMVew6tqYv5wfABuKarMJ+Di3Ph3K60UvY
 W/+8rSqLiVyX0o9NrbXYRCE93ugzGbyQe6EVv3mQ8EvORRSHnlTlDzchiJZuajYUk/EC
 Arg1HqGUKkTeDequbHZTaoQ8vNAhivPsQX+WIjQcz+XE9/eltyerghJ0IJk22dsnqJ91
 lNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740764886; x=1741369686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eN07gCc2oP06ECRd8sreJOokFNA6cGgOnl4Jc0WaVu4=;
 b=SeZ/5Sa7wJ1xTyku2iN0KT6BxuPTh1NtX9PeChWhjMwgMRqLhP2U6TFv21na3MFRs5
 BrpLjTpRp5hmZuihQDd2FklgqoUM6R/6yZGEMrc7S/3NxjELhka657i+o7LmlIyrXOml
 ZB1c2uxhU8aL0zLrdkFU0JxAkj7udyrrUm+6ODl2uMkDJ7EJm7J4ImTyW+SRP1FT1WFr
 e7SXcCDGG87wpyknZGopNvTutO63FzLbDk10PWpILgjzh3BmFg2JlE1iVpx9WBSINuIs
 BtxNVB0sXucZcWBH5eTtr9qMhpsQzzf8oA0BZLel3wd4cloLYo8lszRKvsoouWn+lz3J
 +MbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ5FGETEWdSoRiJcZhw465WZcz2qSSJxePxHfqy/NbAqKkZMAw4xVq/j8L88dsvDooNQBhvtxTUxGx@nongnu.org
X-Gm-Message-State: AOJu0YyT4Ke0RuVxhB68ah2IESZXptasve+e0vY0n0hn807DOU42yaYZ
 TY6sKppdi2rOgOItjMle/ZtG4ibm/CO0Lw0BroykS3DKbUJ5U9gZjXXOueyERlwZxs3MF5zCGa+
 1
X-Gm-Gg: ASbGncsJinGwE0OndsHjFWMp/qI8Epo30gf/R94+dIBNlVzCRqQHDtJWnEn6yyY9qyD
 mJ227f5DuUEEOw0lJ/hHrqvuu4ekWMl8/G9ks4fLZDfQShIJTZDMuERE2Y2GdIXJJ8OY5v4ein7
 PIqjqHzBphUUEF/PjVz1fT0tAzg64QsJ7inB51qTvFhDu0xbyOi0gCVRF7SXwPVobXWof1Owgdr
 U0OhJwf09qr6lkN7GW7legygl1jDN1zw5qYdOdghT3Z/8QSVNATYJeH/Ed/7/Jy8nLmI9DxH7J9
 GHBFET1dtR62ptP6MIt12/x9LFdR/n2S
X-Google-Smtp-Source: AGHT+IFTDzG/AG8cluvdOSFouLD9fvwivS/Vmmwy0TNqtwDkEzUwgJeyJhwI/+kkG1woycmQ5wIEkQ==
X-Received: by 2002:a05:600c:1d82:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43ba6727b65mr33765805e9.21.1740764885856; 
 Fri, 28 Feb 2025 09:48:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm5979556f8f.15.2025.02.28.09.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:48:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/3] hw/net/smc91c111: Sanitize packet numbers
Date: Fri, 28 Feb 2025 17:47:59 +0000
Message-ID: <20250228174802.1945417-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228174802.1945417-1-peter.maydell@linaro.org>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
2.43.0


