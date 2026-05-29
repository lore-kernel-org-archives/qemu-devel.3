Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79853CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgv-0001kD-7n; Fri, 29 May 2026 07:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgt-0001jW-Np
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgr-0008FS-Me
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso506791f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055268; x=1780660068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6NWO6d9ExJHQj9pOcS0mvnOh3Ls1e0Xs5nWSzTsKqPM=;
 b=FvujYUbo+lyBESsILMGHfgJDII7aucXpoLBrqJnoaPoHnKnybHKsGWrzUi+t8wduhi
 IRlBbWwcE0JTXTU/ldJq4eSMHqxLSYHA6lqcA75ubuZwINrsj0xDV5nc9nmLi5KTG/yl
 iqbngsOZrwYP1UFqzKJuZf4XjlLsOUvEpGgyh0fKFjboRn3tHWDIQ1/TPttnf5WUWzw8
 nskxPIYHrMmLwap585h+X1qouQVDG/jjobMb4vyKfwuP5Dsd1uy2XmgYK0hKlpLg46Xe
 LWA3mz9FcjxQD7scY5gAQ4ErKQ2hwEl7sBaByglGo0oZRZxODQSiRYrvFKQOzVxHQML4
 8tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055268; x=1780660068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6NWO6d9ExJHQj9pOcS0mvnOh3Ls1e0Xs5nWSzTsKqPM=;
 b=SGttoPNQkUbkBbeAs++JQ/pFrxEPNT8Erokuq/VuTBE43bLuJmHDtmBog4xUBGBw+A
 hENGJq239SyH9UGcC06BdCljgxtz01zCps5itCUMkzNpmEEbo3p3lbPk6OV2sNHiGxwq
 XorKXcm3jNt8p/yZkPbickGSRp0UTPimErOXGXR+qHZezrcRFIEmXQiStBbaW7eSjInN
 IAlxtKG/9IA3WTCxeA5X7rSGJkUioNeaIUzBKUon/qcqhwMD490duRoahicQ0cgTkPTm
 QeiuFcgdSm1sEs91kLrDsMDf370q3SbsU2O9NfYsDpE68OajghAZiz9eZecBUSX1q+Ba
 7u1w==
X-Gm-Message-State: AOJu0YwHG2aTQhYRJjcrlEbGUx3PJlRpZhDm9k9Yyliix0HsLgtHBJFL
 ymFYuzlZK1IPJcfoYSc7WX/UeUxUmQ6U4BP7lP9CGYWOiWlTwxn7nibBoq3kGhQ2ugu7r6WoUDV
 BJsLT
X-Gm-Gg: Acq92OGgAey5qAL/SSRmcXrBbIgN2KDXmJEHoccZUUAYCyhxuZl76MlOTthG7FzhInd
 zVq+J9PCmlj7TkDlc9rlN+9n5+KuV7cpbOg8zZ9o7qCV8X16sNN7fjOZF0OxlHgO8a0AOTTqFuE
 mz7/6bZmbjEGZGrYMTRsfucyyloSVy6he51cBS78VYnawZkDc9cXl48ZJnwF1iAQZACBuebtCNE
 4XaVgPoUQ/0/q+LOwROaoOW5Rk0WeCb4KJK8xwWwudZDQSu8rOYYWeQx5JrrZgsml7nXMZHCVrW
 2e9BESfXcWjTZQ9iwiqfALJohFHTAMWiPRTkQw8vFIKGjmQfFONzIEX608nj+HexOymRqxxmkSA
 btvDoh6gD4yCex+cPs/Tw+6rr9h8Uci5ZKXlX7qocotdGN+c2s7p3ucMDIT916Wl6+nwub/2bNF
 9q9KXp4vc+A+xz/VhgarGfJYgB71X6Hl9QpE/TGk3ZdAroTGyrw+xSZ6LhyeOfPVxnHRwxr5iXO
 YHuUJL7pWNbewAJGT8uLWFWMi6iDU/7IvhjHugm8A==
X-Received: by 2002:adf:e001:0:20b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-45ef13ed5cbmr3414686f8f.5.1780055268201; 
 Fri, 29 May 2026 04:47:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] hw/dma/omap_dma: Fix indentation after ifdef removal
Date: Fri, 29 May 2026 12:47:22 +0100
Message-ID: <20260529114723.42040-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260528152852.3349928-4-peter.maydell@linaro.org
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


