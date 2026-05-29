Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A88BCD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgu-0001k7-So; Fri, 29 May 2026 07:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgs-0001iH-Dx
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgq-0008FJ-Ke
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so177682f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055267; x=1780660067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5EAWUWr4AJq45/iqbCnBFS2ikIkq25zXWdRXk2fFgzs=;
 b=RHDRfpP5zmqXw7Vslh2ynBJqlFv017JxGcYkSGAqKzDxFTodG8c2plgAc7JGNLmNXs
 yObk2FEry41B0KrJ3gs5hd6qlX55XjqqJCv3xPFiMPpXeTAw8BU2TJSdc//jc9p8Rjrj
 HX5p4/2Q/JP0TmN6r/bo5ojDiSQ/O1f0UtGq6f78czhmQPWRMMYcyt1Lr6Yn4lrcSY8o
 iyymK9Kvdg5DdKwneiRGyMNVkRadno3mrLZ6zKfdtbfx5O69aWog7Zs5Cl9mS7q7b2+M
 n5U9jb8xpTj9V4ImEWJJEeYgf+qq6/QJ1OgcGhuSKi2C6RFuRCkKlOEQP1y1oO11O7m/
 Sfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055267; x=1780660067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5EAWUWr4AJq45/iqbCnBFS2ikIkq25zXWdRXk2fFgzs=;
 b=CA9FBcvlBmujbvaXOPHX9AQN1ImEcrUgIYVu74cahaQS56Bh576lUDIkpRtgRbhJn2
 SO4JVQQPeHIlIc+0VwFquh+06Iklnx/3paumXv2K0Ne9UNSXc4c10gpeNZ786hx0uCx1
 1teyNnsXaErwc1dy66WON9kDdPb9ZPhCP+RM2dnvQ9HhIb/5UptUjxcjKGgEATjhoSRx
 YEPOx7j9cAVzPfnVB9ZbL8lilqd+iIJZsh8NElju9kTWz9ylPZ//EqpFMTgsqudBbcAb
 0xDeX2iB2oVnlzgp4Sfu/Ik+o7cHXw/7rXCyt7G/EfVUbhpZc76LvJ3HHoBHs1N13K0x
 XZkQ==
X-Gm-Message-State: AOJu0YwgLnmowiK9tNI5f5x2dkHaBpO81kOVIMDSyHtgbRsfvdS3lblp
 XPt6UgHzs1RdzmtsYqQ/tvWFioZqUqQRwBBQ3YBdZMawX/8FQQfz2r0RFnfj1zjIozSlk7IvNHs
 DVuMF
X-Gm-Gg: Acq92OEfNhn4WqJgWhsCzdp+bdWX02GVafyx3M/RMKA+lgU+6st/gGU9Vb4WtZ5xCKI
 AEXypjPWCYWy8bYt1WYyDkIOW1OdStwQFqHS3sAb4jtobqCy2609oNaTuP5Yo2sgPQ3p4YCh2f0
 e/plnrr7QWTmRQYQFBXzqVi9C31IjPvr01NQ7EcVdSGv63DgIBBa4YB/Q7F8Q/mIUT0HwfbuTik
 14LqIzbdB8BX/4cmK6OidzZLBiFzNgeTMlmn9nlQ2JjDmFbl3o2VuJIcrVU83SFXghy9KmD9AZ6
 qtf5gsYovZkJIecNweuWNlCJShtyyuSaO+91bpXh3ovWK+TKKop5ja2m8BG/hoi5TSCEdodu4mU
 tXSvCKKQzyE4kUF1U2UyK5OoACF+FbvNOVtztsSzcPnPNLsj563droo+dq9Rmrty1RcQCoeKg2L
 9OBymJf4NWrhs2apQTy977/gh4HkwIPWcPCkUrB6aCgfst13mZeuGikkLyhO0kCXF3CUNPWgqol
 wRRv1L+xfMJ/RHtCA9boppOj7mfccjVjaP4SsdGkA==
X-Received: by 2002:a05:600d:8498:10b0:490:3d3d:805a with SMTP id
 5b1f17b1804b1-4909c14dcfbmr28883435e9.12.1780055267126; 
 Fri, 29 May 2026 04:47:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] hw/dma/omap_dma: Fix coding style in
 omap_dma_transfer_setup()
Date: Fri, 29 May 2026 12:47:21 +0100
Message-ID: <20260529114723.42040-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

We're about to fix indent in a section of the
omap_dma_transfer_setup() function, which will make checkpatch
complain.  Since we're touching the code anyway, fix the uses of if()
with no braces and wrongly formatted multiline comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260528152852.3349928-3-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index a93d9ad196..b8bbb707c4 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -471,49 +471,59 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
 
         /* If the channel is element synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_element_sync])
+        if (min_elems == elements[omap_dma_intr_element_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* If it is the last frame, set the LAST_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_last_frame])
+        if (min_elems == elements[omap_dma_intr_last_frame]) {
             ch->status |= LAST_FRAME_INTR;
+        }
 
-        /* If exactly half of the frame was reached, set the HALF_FRAME
-           interrupt */
-        if (min_elems == elements[omap_dma_intr_half_frame])
+        /*
+         * If exactly half of the frame was reached, set the HALF_FRAME
+         * interrupt
+         */
+        if (min_elems == elements[omap_dma_intr_half_frame]) {
             ch->status |= HALF_FRAME_INTR;
+        }
 
         /* If a full packet has been transferred, set the END_PKT interrupt */
-        if (min_elems == elements[omap_dma_intr_packet])
+        if (min_elems == elements[omap_dma_intr_packet]) {
             ch->status |= END_PKT_INTR;
+        }
 
         /* If the channel is packet-synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_packet_sync])
+        if (min_elems == elements[omap_dma_intr_packet_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* If the channel is frame synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_frame_sync])
+        if (min_elems == elements[omap_dma_intr_frame_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* Set the END_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_frame])
+        if (min_elems == elements[omap_dma_intr_frame]) {
             ch->status |= END_FRAME_INTR;
+        }
 
         if (min_elems == elements[omap_dma_intr_block]) {
             /* End of Block */
             /* Disable the channel */
 
-            if (!ch->auto_init)
+            if (!ch->auto_init) {
                 omap_dma_disable_channel(s, ch);
-            else if (ch->repeat || ch->end_prog)
+            } else if (ch->repeat || ch->end_prog) {
                 omap_dma_channel_load(ch);
-            else {
+            } else {
                 ch->waiting_end_prog = 1;
                 omap_dma_deactivate_channel(s, ch);
             }
 
-            if (ch->interrupts & END_BLOCK_INTR)
+            if (ch->interrupts & END_BLOCK_INTR) {
                 ch->status |= END_BLOCK_INTR;
+            }
         }
 
         /* Update packet number */
@@ -522,8 +532,10 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
             a->pck_element %= a->pck_elements;
         }
 
-        /* TODO: check if we really need to update anything here or perhaps we
-         * can skip part of this.  */
+        /*
+         * TODO: check if we really need to update anything here or perhaps we
+         * can skip part of this.
+         */
         if (dma->update) {
             a->element += min_elems;
 
@@ -534,11 +546,14 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
             a->dest += min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
 
             /* If the channel is async, update cpc */
-            if (!ch->sync && frames)
+            if (!ch->sync && frames) {
                 ch->cpc = a->dest & 0xffff;
+            }
 
-            /* TODO: if the destination port is IMIF or EMIFF, set the dirty
-             * bits on it.  */
+            /*
+             * TODO: if the destination port is IMIF or EMIFF, set the dirty
+             * bits on it.
+             */
         }
 
     omap_dma_interrupts_update(s);
-- 
2.43.0


