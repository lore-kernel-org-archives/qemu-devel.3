Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015F0CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScfQ-0006vB-K0; Thu, 28 May 2026 11:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfO-0006te-0d
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:29:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfM-0004TN-4T
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:29:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so52305135e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982139; x=1780586939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2EJwGI7q6G04dldtqGDuhK+ytkl5e4vXy4BHhse+K1Q=;
 b=KEVTFR3VYh1VuaXzeu3U/F7nQEQd4MeUV0xkmJg8uiyF/QsPmsAF9WM10QLFvBnPah
 Hv6ruYi0aqtpFRWlVV5ao0Z78MVjCjeuLRqXiI/LKzjeBw9L1cDSh3lkzADQshnXvogh
 pKqqfrG7N1hAfPw9e2xQG9Api7o0XhhQYdHAyHknbfsBJrXlT9vo4Mkc3HTCjh2QTqq3
 V95A7iqyzaSojsIQ72auJLYZAwrA/26WuBnYws5exLGYJY7Tl0F/h/bwNQorLaDbvV+V
 WrVEJL/0pwCVsLZzXzkt9F2K5f/HO0FJaFdtYGZohi+TpWpsQ4ohvUwtJbDZFq54di46
 wxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982139; x=1780586939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2EJwGI7q6G04dldtqGDuhK+ytkl5e4vXy4BHhse+K1Q=;
 b=j9ecdmk7bxfGDgvli+NF6Pl6ZjSYLX997nOH/6IjL6UHEAICOv7ROIGEh74WkJX93Y
 g3d9vw54cJa9CufmwlPbP3A+Q9RQQ34pxcmDeCyj4foE2KzzSSt9X3V2MD93/mdQh1DR
 GbXhQ35y/tt9Vo9iiSpdXDt+Ec3mi/HqEZnxEIpiQbGOosfO+th3t4C3GDkP56uxdcZR
 0f8Psys+Tc1nd729Nk/rItQBR+e+0e3AqSgJfuiWaFp2qQ4FhC06WCa5Tp3DTul6WCGG
 XjF+jRyxb8mae/ionuhSMffOcUFrbLCTp3OKYVGTN9em5piDqdL4e5dj7fZEcGn/0+4P
 tTTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mGw1S3qxbv46Zc9zV/HIc6VhwiGnXz0IJkFhqOYr2m003g/y9/o2tiG2HoRkJWTYbMROYrto7WIFw@nongnu.org
X-Gm-Message-State: AOJu0Yw0n149THXPTvUD2jAXLpY9EW0JfYdeF/meVKdUP2A27xk1m1cw
 XI/KHEZ6057LuW/TVTQCe5UluhBptnUNkIrYJE9Wr0y7Cxv/p7M3O349zb0AUBQKHJo=
X-Gm-Gg: Acq92OEv6/dkOMfOcjwa4PBAdWUQ/6lh+24W3V+B5NrcIszRR68/+52SPlkwZAREczW
 CI24uD3eP9CImfip0E8W1WqiIvAqjFWVxdm2pX/btJpVfZbL0+2uOW0ZNWbCWF6o9JpD5pI/bi4
 skPJPV67SlTo3OXeS7AhcXV1u8AKLmlH8ImNHfym+/bqon00Glp5BieAJUfrES5VSC2V+Y3RBJC
 LqtMfpaxdhUz7Z69gPhtqTBQq1IZ0H19IOGTGaMjTzkjEEaljyDnTjG4WHUH7IjsUAWmv42QozG
 BuY4wA2t0fORVWhngMqK6pNNs0O5jPQoMVMu970D4/vTK+N5By3XoAmuLkeReTL3igMbnKxgDrc
 gp2DuItKRZJDHP3e/1o4MJphVUIbZ/dSBTkoHka3uTCO+hDKme6BUl5OxxtVe7zQ0wHICZIhVO9
 LJMbc/6T6l+KAPr9b0u2+7yixIINGOm5P0QqgOoFy4LBGPYsmGVycHYSvaL1bJuRDLP9X1Jg385
 E3JWrhHvvhDGBNpr3zR2gcKkCGuXwvC0sn5ntIAQQ==
X-Received: by 2002:a05:600c:1c0b:b0:490:44eb:c1dc with SMTP id
 5b1f17b1804b1-49044ebc2e0mr492333825e9.20.1779982138660; 
 Thu, 28 May 2026 08:28:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b7a70b9sm19116605e9.12.2026.05.28.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:28:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/dma/omap_dma: Fix indentation after ifdef removal
Date: Thu, 28 May 2026 16:28:52 +0100
Message-ID: <20260528152852.3349928-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528152852.3349928-1-peter.maydell@linaro.org>
References: <20260528152852.3349928-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Some of the ifdefs in omap_dma_transfer_setup() which we just
removed had if() blocks in them. Now that the code inside them
is always unconditional it has an extra unnecessary layer of
indentation; fix this, as a whitespace only change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 156 +++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index b8bbb707c4..668fc49054 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -470,91 +470,91 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     /* Set appropriate interrupts and/or deactivate channels */
 
 
-        /* If the channel is element synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_element_sync]) {
+    /* If the channel is element synchronized, deactivate it */
+    if (min_elems == elements[omap_dma_intr_element_sync]) {
+        omap_dma_deactivate_channel(s, ch);
+    }
+
+    /* If it is the last frame, set the LAST_FRAME interrupt */
+    if (min_elems == elements[omap_dma_intr_last_frame]) {
+        ch->status |= LAST_FRAME_INTR;
+    }
+
+    /*
+     * If exactly half of the frame was reached, set the HALF_FRAME
+     * interrupt
+     */
+    if (min_elems == elements[omap_dma_intr_half_frame]) {
+        ch->status |= HALF_FRAME_INTR;
+    }
+
+    /* If a full packet has been transferred, set the END_PKT interrupt */
+    if (min_elems == elements[omap_dma_intr_packet]) {
+        ch->status |= END_PKT_INTR;
+    }
+
+    /* If the channel is packet-synchronized, deactivate it */
+    if (min_elems == elements[omap_dma_intr_packet_sync]) {
+        omap_dma_deactivate_channel(s, ch);
+    }
+
+    /* If the channel is frame synchronized, deactivate it */
+    if (min_elems == elements[omap_dma_intr_frame_sync]) {
+        omap_dma_deactivate_channel(s, ch);
+    }
+
+    /* Set the END_FRAME interrupt */
+    if (min_elems == elements[omap_dma_intr_frame]) {
+        ch->status |= END_FRAME_INTR;
+    }
+
+    if (min_elems == elements[omap_dma_intr_block]) {
+        /* End of Block */
+        /* Disable the channel */
+
+        if (!ch->auto_init) {
+            omap_dma_disable_channel(s, ch);
+        } else if (ch->repeat || ch->end_prog) {
+            omap_dma_channel_load(ch);
+        } else {
+            ch->waiting_end_prog = 1;
             omap_dma_deactivate_channel(s, ch);
         }
 
-        /* If it is the last frame, set the LAST_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_last_frame]) {
-            ch->status |= LAST_FRAME_INTR;
+        if (ch->interrupts & END_BLOCK_INTR) {
+            ch->status |= END_BLOCK_INTR;
+        }
+    }
+
+    /* Update packet number */
+    if (ch->fs && ch->bs) {
+        a->pck_element += min_elems;
+        a->pck_element %= a->pck_elements;
+    }
+
+    /*
+     * TODO: check if we really need to update anything here or perhaps we
+     * can skip part of this.
+     */
+    if (dma->update) {
+        a->element += min_elems;
+
+        frames = a->element / a->elements;
+        a->element = a->element % a->elements;
+        a->frame += frames;
+        a->src += min_elems * a->elem_delta[0] + frames * a->frame_delta[0];
+        a->dest += min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
+
+        /* If the channel is async, update cpc */
+        if (!ch->sync && frames) {
+            ch->cpc = a->dest & 0xffff;
         }
 
         /*
-         * If exactly half of the frame was reached, set the HALF_FRAME
-         * interrupt
+         * TODO: if the destination port is IMIF or EMIFF, set the dirty
+         * bits on it.
          */
-        if (min_elems == elements[omap_dma_intr_half_frame]) {
-            ch->status |= HALF_FRAME_INTR;
-        }
-
-        /* If a full packet has been transferred, set the END_PKT interrupt */
-        if (min_elems == elements[omap_dma_intr_packet]) {
-            ch->status |= END_PKT_INTR;
-        }
-
-        /* If the channel is packet-synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_packet_sync]) {
-            omap_dma_deactivate_channel(s, ch);
-        }
-
-        /* If the channel is frame synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_frame_sync]) {
-            omap_dma_deactivate_channel(s, ch);
-        }
-
-        /* Set the END_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_frame]) {
-            ch->status |= END_FRAME_INTR;
-        }
-
-        if (min_elems == elements[omap_dma_intr_block]) {
-            /* End of Block */
-            /* Disable the channel */
-
-            if (!ch->auto_init) {
-                omap_dma_disable_channel(s, ch);
-            } else if (ch->repeat || ch->end_prog) {
-                omap_dma_channel_load(ch);
-            } else {
-                ch->waiting_end_prog = 1;
-                omap_dma_deactivate_channel(s, ch);
-            }
-
-            if (ch->interrupts & END_BLOCK_INTR) {
-                ch->status |= END_BLOCK_INTR;
-            }
-        }
-
-        /* Update packet number */
-        if (ch->fs && ch->bs) {
-            a->pck_element += min_elems;
-            a->pck_element %= a->pck_elements;
-        }
-
-        /*
-         * TODO: check if we really need to update anything here or perhaps we
-         * can skip part of this.
-         */
-        if (dma->update) {
-            a->element += min_elems;
-
-            frames = a->element / a->elements;
-            a->element = a->element % a->elements;
-            a->frame += frames;
-            a->src += min_elems * a->elem_delta[0] + frames * a->frame_delta[0];
-            a->dest += min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
-
-            /* If the channel is async, update cpc */
-            if (!ch->sync && frames) {
-                ch->cpc = a->dest & 0xffff;
-            }
-
-            /*
-             * TODO: if the destination port is IMIF or EMIFF, set the dirty
-             * bits on it.
-             */
-        }
+    }
 
     omap_dma_interrupts_update(s);
 }
-- 
2.43.0


