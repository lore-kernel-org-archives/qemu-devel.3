Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D511CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmY-00005p-LX; Tue, 26 May 2026 10:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmH-0008Ix-DD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmF-0001Dz-JW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso91106995e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805742; x=1780410542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aVnB0vrWXEEak9W9o+bTVpAMY2S7rxcLtmOrEhnqvjk=;
 b=UVISmIDt/4FYBovIZ8VxtQYxjo/H6E9SO3AAzBvyIaHewrWRhclvATj+v1uSaDatck
 sgETlknxR4K7f2yjJaDyhrboSymINcGP1JEsO2xw5dszQEf8gOUGMnrJ/OfABDX6q0Wd
 TSDRJLkImb0NZeklxW5iVn9Exw8g44bL0tF7wyjAs76Ovcbx10cXcrx/ujDsO2Pc3Cei
 IJ1d7OuZ0eIJmlCPUlGYhlx6WSMvr6Rxr5KcfRAnEkPkwReLczU63Iz3HLdQvLdlXDsm
 OqJnpC6PHmKUY0ggLRJykxc2wuzzuzcMzVXI+XuMoroWpwR6T55ZwX/8gt8WcXmpI0hz
 Ihxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805742; x=1780410542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aVnB0vrWXEEak9W9o+bTVpAMY2S7rxcLtmOrEhnqvjk=;
 b=OJU39BMNnOKiJPWmqOk++q+oWRqPirPFTvQVUpf0DwJ6SVkmj9t2A9ahbZkgtLyMjW
 25LPnND8MI8uUpaqFu5JdsBHk+TItZWTPSDiyDdRtGnr2rfPTJ6Woh/TnQp3bBLdpPFw
 HImYuMj4BmVN11hi+o8b0m/6KcKYv2Yw2oAwB494aZKYfVFeTr4gLr0aDOUnzdp6UlLM
 v/eb5HeVg4amD/bIMVhfavGt3ObQhBNoI9uI3KiBoZJF9ka3COjXvBnUpRCFyOjTFeeX
 BZLTnKnN2mZ3oa/e/rsGMAgzSD47cRnP57dtTJovmPPtdHoCGeRtWo7VG052xRPSoFdo
 fgMA==
X-Gm-Message-State: AOJu0YxvtdTuXXeYDL7nKVI4bzlIBkS34Ca2NA4dbptf4omEdOq7DTK2
 InJG8YH+XPT0mdB2QpJrXxeVsCW6D3bVJnydFwSuoHCv7SJC7OmLLkdwaEVFPDOmv9Iolw1N264
 KFOuf
X-Gm-Gg: Acq92OGfrBJmIwsaX98bHA63QDeZ1uZ8jzICfZSBwzBuljSxZGT4/V2BApxycZ1FWk5
 hpt+f7HYrgpUmVZJeU+sI7hwu0HNODaMuEvh0WgSd1yqqeiye6di2FC7VZF3yMBU7bRXL39hZt4
 JEbrgnGFjA5O3sz4lG63dIXrbOeXq7uf5OGZeuHpwcLajBGBJXZAvGNrbT6XNYDs/hu7E3qmnE7
 +QEShedGC3uVHyXJaLoJ7YwogDmfbKtVdA4Nwh6sink9RFAJIxYTcjA0LVMWXca7nFWfC68CnnQ
 QAKWsyud/aVs1dzJYOFj1Kx2DSHpeofL28Mf7Ha+67JEuowo5YhwGMbatNjVH2OiMOlvPcKndH9
 44oDGmCe1HNYliKcgiBnNjYTiXpQWq70sdkFqTru2d2qu3rxWS1A0H+687cr/yYdC2+KbrXCAZh
 Snt01BnSz7axexl4OFosYovlYybv5hkYg/BWy/WljBn1KnjHYNAmhE8M56i9lZaln3j1jNEGKvb
 8DbUYbHCCbP/r0L0jivUiXtHdyE4C8=
X-Received: by 2002:a05:600c:444b:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490424aa04fmr318571005e9.11.1779805741512; 
 Tue, 26 May 2026 07:29:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/54] hw/dma/omap_dma: Remove omap_3_1_compatible_disable flag
Date: Tue, 26 May 2026 15:28:06 +0100
Message-ID: <20260526142850.2326589-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The OMAP DMA device has an omap_3_1_compatible_disable flag in its
channel struct, which the 3.2 version of the DMA block used to tell
whether it should behave compatibly with 3.1 or not.  Now we have no
3.2 support, the omap_3_1_compatible_disable flag is set to false and
can't be changed, so we can remove it, folding out all the conditions
where we were testing it as always-false.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-10-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 59 +++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 49348f40c5..fe43fec58d 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -73,9 +73,6 @@ struct omap_dma_channel_s {
     int fs;
     int bs;
 
-    /* compatibility */
-    int omap_3_1_compatible_disable;
-
     qemu_irq irq;
     struct omap_dma_channel_s *sibling;
 
@@ -144,7 +141,6 @@ static void omap_dma_channel_load(struct omap_dma_channel_s *ch)
 {
     struct omap_dma_reg_set_s *a = &ch->active_set;
     int i, normal;
-    int omap_3_1 = !ch->omap_3_1_compatible_disable;
 
     /*
      * TODO: verify address ranges and alignment
@@ -177,14 +173,14 @@ static void omap_dma_channel_load(struct omap_dma_channel_s *ch)
             break;
         case single_index:
             a->elem_delta[i] = ch->data_type +
-                    ch->element_index[omap_3_1 ? 0 : i] - 1;
+                    ch->element_index[0] - 1;
             a->frame_delta[i] = 0;
             break;
         case double_index:
             a->elem_delta[i] = ch->data_type +
-                    ch->element_index[omap_3_1 ? 0 : i] - 1;
-            a->frame_delta[i] = ch->frame_index[omap_3_1 ? 0 : i] -
-                    ch->element_index[omap_3_1 ? 0 : i];
+                    ch->element_index[0] - 1;
+            a->frame_delta[i] = ch->frame_index[0] -
+                    ch->element_index[0];
             break;
         default:
             break;
@@ -442,20 +438,13 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
                 /* End of Block */
                 /* Disable the channel */
 
-                if (ch->omap_3_1_compatible_disable) {
+                if (!ch->auto_init)
                     omap_dma_disable_channel(s, ch);
-                    if (ch->link_enabled)
-                        omap_dma_enable_channel(s,
-                                        &s->ch[ch->link_next_ch]);
-                } else {
-                    if (!ch->auto_init)
-                        omap_dma_disable_channel(s, ch);
-                    else if (ch->repeat || ch->end_prog)
-                        omap_dma_channel_load(ch);
-                    else {
-                        ch->waiting_end_prog = 1;
-                        omap_dma_deactivate_channel(s, ch);
-                    }
+                else if (ch->repeat || ch->end_prog)
+                    omap_dma_channel_load(ch);
+                else {
+                    ch->waiting_end_prog = 1;
+                    omap_dma_deactivate_channel(s, ch);
                 }
 
                 if (ch->interrupts & END_BLOCK_INTR)
@@ -610,19 +599,13 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
             /* End of Block */
             /* Disable the channel */
 
-            if (ch->omap_3_1_compatible_disable) {
+            if (!ch->auto_init)
                 omap_dma_disable_channel(s, ch);
-                if (ch->link_enabled)
-                    omap_dma_enable_channel(s, &s->ch[ch->link_next_ch]);
-            } else {
-                if (!ch->auto_init)
-                    omap_dma_disable_channel(s, ch);
-                else if (ch->repeat || ch->end_prog)
-                    omap_dma_channel_load(ch);
-                else {
-                    ch->waiting_end_prog = 1;
-                    omap_dma_deactivate_channel(s, ch);
-                }
+            else if (ch->repeat || ch->end_prog)
+                omap_dma_channel_load(ch);
+            else {
+                ch->waiting_end_prog = 1;
+                omap_dma_deactivate_channel(s, ch);
             }
 
             if (ch->interrupts & END_BLOCK_INTR)
@@ -711,7 +694,6 @@ void omap_dma_reset(struct soc_dma_s *dma)
         s->ch[i].cpc = 0x0000;
         s->ch[i].fs = 0;
         s->ch[i].bs = 0;
-        s->ch[i].omap_3_1_compatible_disable = 0;
         memset(&s->ch[i].active_set, 0, sizeof(s->ch[i].active_set));
         s->ch[i].priority = 0;
         s->ch[i].interleave_disabled = 0;
@@ -752,7 +734,7 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
     case 0x06:  /* SYS_DMA_CSR_CH0 */
         *value = ch->status;
         ch->status &= SYNC;
-        if (!ch->omap_3_1_compatible_disable && ch->sibling) {
+        if (ch->sibling) {
             *value |= (ch->sibling->status & 0x3f) << 6;
             ch->sibling->status &= SYNC;
         }
@@ -791,11 +773,8 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
         *value = ch->element_index[0];
         break;
 
-    case 0x18:  /* SYS_DMA_CPC_CH0 or DMA_CSAC */
-        if (ch->omap_3_1_compatible_disable)
-            *value = ch->active_set.src & 0xffff;   /* CSAC */
-        else
-            *value = ch->cpc;
+    case 0x18:  /* SYS_DMA_CPC_CH0 */
+        *value = ch->cpc;
         break;
 
     case 0x1a:  /* DMA_CDAC */
-- 
2.43.0


