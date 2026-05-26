Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A33CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmY-00008c-V5; Tue, 26 May 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmF-0008FF-Qx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmD-0001Df-D7
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so112129105e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805740; x=1780410540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EOC7VbbJb0LqgDAM41t/rnAPXOgnOtxdsdEmcYnt9KU=;
 b=xx+4KJoJQ7YgRlOuzAh96oBreG7bu1tAf3fY/zuSDM8y4RHT3uXLWwvGwMXIRuNK9p
 ZWcJGNUvkU7DackD49BrgXElcPJoIFM3Kn/tjPhuLrrqzy1Uk660A0I2YrRrUG9GWRF7
 MbRDqNX+46hnqOjK++LQLwg/jfGE+DkeFMK+fzKUkE+G1p5f42NiBeSU6/hdcKX5WWci
 +tcakujgqqLoPyZmp4cuxaFQgh4D9aa4rJAQpFO2QKuF94ZrIBdVhSjbtRcaR7fSY3EG
 YXNhKIL/dXUjO02Q5YMEuBymvRgZJ8K/mkRrkkY0GgyvxGYZ0dKDbChzchyCT5OpybK9
 1+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805740; x=1780410540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EOC7VbbJb0LqgDAM41t/rnAPXOgnOtxdsdEmcYnt9KU=;
 b=cei5tNWShlmxkFaxkgFDCPvkPeI+1TDqUjGqZV+cEAL8Wgf84X8+8cIAHw0YUjwnSM
 IyUz5mE8EvQOvoDOtAykFCA5hBCBDbidP1PWilXYtFHR5pq9LkPYlVxDz0/M9R94fIAL
 yiVJiYdbBDtfyBekemHnGfX8yPOhoXugZP922CR1mCWbZKwkxbiZwBhW0h2mrQekzKoG
 59H1fzQM6VFa2IQpIognWDtTM9R7CCUNPBs8QWkDPFZPGkWE8MMjgr8d9io0/oVLzCb3
 hyViWXSlnivjdcRYdwCagIcb+iyHPLgELRikM+Yup1sF1QtL3DkX98sOdLhsVAUW/ZkJ
 qwHg==
X-Gm-Message-State: AOJu0YyUPrrrfHgo4vHWHuASl2CKN6irZnI12l+MbC1xftpTvZ9J9xAW
 xp9FwD9o0fMoCAGbD+DmKgCDZEHHSDYw2bbkjpxFWUG5wQv1jdNbRsjQRAQxV4jN3t2yUw9T9BB
 MloUl
X-Gm-Gg: Acq92OHgFxH0V6OVrmeaKYKQYW+Pma+u7t6AQRe/oGM/NiORqgzwWOqifpbnfnTjuMK
 rKvT9MbfLXLDjaqJ2Bj9+IdH3nF3mGy0PSpDWuEBBI136++zOBFim50WwBQRJpRFQvPMcR1si9N
 JyymxUaVMw0YkSZeMA4gY/fIeM/IUhtmJV8VrpJXza1vs3QRE+uxCKoXnzMfhm7Tm+dmzXX7lRQ
 u63xUnpo3OkkIvBg2+FxqzMtB0Z4uBAMwafi2nN0KjdZKJwcT6zRZnwPI+EK5nm6W7HWK3M0Md8
 VaAmYjroX7L00DqaKMcA3xrHymeVm9dOsfgO/UZeiAAU1KLnm+Rgm9615qBeimMFZR+FzHMEmsw
 x9xLmbA31UM1jGF+183I/vTlB2I3ZdpWN6HV59LKzbop9LZu375C3/jnz/cFC1qQ2qtFYk0kY7g
 u6PlQnFEUFXetNAYEYs/FHEY8ldTt7tc5khIrf788pyMkTeooE1fovruXHVsbyZ7EYIQs3kzKxH
 GXc6u7tfwh+zCEc6ykJXFyT0TN+ZC4=
X-Received: by 2002:a05:600c:5298:b0:48f:e230:2a26 with SMTP id
 5b1f17b1804b1-490428e16bamr318961375e9.33.1779805739430; 
 Tue, 26 May 2026 07:28:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/54] hw/dma/omap_dma: Remove support for dma_3_0 and dma_3_2
Date: Tue, 26 May 2026 15:28:04 +0100
Message-ID: <20260526142850.2326589-9-peter.maydell@linaro.org>
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

The omap_dma device has support for modelling different variants
of the DMA block, as enumerated by the omap_dma_model enum:
3_0, 3_1 and 3_2. However, our one remaining OMAP SoC always
passes omap_dma_3_1 into the omap_dma_init() function, so the
handling for 3_0 and 3_2 is never used.

Remove the support for the other versions; this lets us
delete entirely two large functions that were specific
to 3.2 DMA to the LCD controller, and all their associated
fields in the omap_dma_lcd_channel_s struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-8-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c     | 348 ++----------------------------------------
 include/hw/arm/omap.h |  28 ----
 2 files changed, 15 insertions(+), 361 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 784a3a4f7f..9a86d90b4e 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -110,7 +110,6 @@ struct omap_dma_s {
     omap_clk clk;
     qemu_irq irq[4];
     void (*intr_update)(struct omap_dma_s *s);
-    enum omap_dma_model model;
     int omap_3_1_mapping_disabled;
 
     uint32_t gcr;
@@ -752,10 +751,7 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
         break;
 
     case 0x02:  /* SYS_DMA_CCR_CH0 */
-        if (s->model <= omap_dma_3_1)
-            *value = 0 << 10;           /* FIFO_FLUSH reads as 0 */
-        else
-            *value = ch->omap_3_1_compatible_disable << 10;
+        *value = 0 << 10;           /* FIFO_FLUSH reads as 0 */
         *value |= (ch->mode[1] << 14) |
                 (ch->mode[0] << 12) |
                 (ch->end_prog << 11) |
@@ -892,8 +888,6 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
         ch->mode[1] = (omap_dma_addressing_t) ((value & 0xc000) >> 14);
         ch->mode[0] = (omap_dma_addressing_t) ((value & 0x3000) >> 12);
         ch->end_prog = (value & 0x0800) >> 11;
-        if (s->model >= omap_dma_3_2)
-            ch->omap_3_1_compatible_disable  = (value >> 10) & 0x1;
         ch->repeat = (value & 0x0200) >> 9;
         ch->auto_init = (value & 0x0100) >> 8;
         ch->priority = (value & 0x0040) >> 6;
@@ -1002,250 +996,6 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
     return 0;
 }
 
-static int omap_dma_3_2_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
-                uint16_t value)
-{
-    switch (offset) {
-    case 0xbc0: /* DMA_LCD_CSDP */
-        s->brust_f2 = (value >> 14) & 0x3;
-        s->pack_f2 = (value >> 13) & 0x1;
-        s->data_type_f2 = (1 << ((value >> 11) & 0x3));
-        s->brust_f1 = (value >> 7) & 0x3;
-        s->pack_f1 = (value >> 6) & 0x1;
-        s->data_type_f1 = (1 << ((value >> 0) & 0x3));
-        break;
-
-    case 0xbc2: /* DMA_LCD_CCR */
-        s->mode_f2 = (value >> 14) & 0x3;
-        s->mode_f1 = (value >> 12) & 0x3;
-        s->end_prog = (value >> 11) & 0x1;
-        s->omap_3_1_compatible_disable = (value >> 10) & 0x1;
-        s->repeat = (value >> 9) & 0x1;
-        s->auto_init = (value >> 8) & 0x1;
-        s->running = (value >> 7) & 0x1;
-        s->priority = (value >> 6) & 0x1;
-        s->bs = (value >> 4) & 0x1;
-        break;
-
-    case 0xbc4: /* DMA_LCD_CTRL */
-        s->dst = (value >> 8) & 0x1;
-        s->src = ((value >> 6) & 0x3) << 1;
-        s->condition = 0;
-        /* Assume no bus errors and thus no BUS_ERROR irq bits.  */
-        s->interrupts = (value >> 1) & 1;
-        s->dual = value & 1;
-        break;
-
-    case 0xbc8: /* TOP_B1_L */
-        s->src_f1_top &= 0xffff0000;
-        s->src_f1_top |= 0x0000ffff & value;
-        break;
-
-    case 0xbca: /* TOP_B1_U */
-        s->src_f1_top &= 0x0000ffff;
-        s->src_f1_top |= (uint32_t)value << 16;
-        break;
-
-    case 0xbcc: /* BOT_B1_L */
-        s->src_f1_bottom &= 0xffff0000;
-        s->src_f1_bottom |= 0x0000ffff & value;
-        break;
-
-    case 0xbce: /* BOT_B1_U */
-        s->src_f1_bottom &= 0x0000ffff;
-        s->src_f1_bottom |= (uint32_t) value << 16;
-        break;
-
-    case 0xbd0: /* TOP_B2_L */
-        s->src_f2_top &= 0xffff0000;
-        s->src_f2_top |= 0x0000ffff & value;
-        break;
-
-    case 0xbd2: /* TOP_B2_U */
-        s->src_f2_top &= 0x0000ffff;
-        s->src_f2_top |= (uint32_t) value << 16;
-        break;
-
-    case 0xbd4: /* BOT_B2_L */
-        s->src_f2_bottom &= 0xffff0000;
-        s->src_f2_bottom |= 0x0000ffff & value;
-        break;
-
-    case 0xbd6: /* BOT_B2_U */
-        s->src_f2_bottom &= 0x0000ffff;
-        s->src_f2_bottom |= (uint32_t) value << 16;
-        break;
-
-    case 0xbd8: /* DMA_LCD_SRC_EI_B1 */
-        s->element_index_f1 = value;
-        break;
-
-    case 0xbda: /* DMA_LCD_SRC_FI_B1_L */
-        s->frame_index_f1 &= 0xffff0000;
-        s->frame_index_f1 |= 0x0000ffff & value;
-        break;
-
-    case 0xbf4: /* DMA_LCD_SRC_FI_B1_U */
-        s->frame_index_f1 &= 0x0000ffff;
-        s->frame_index_f1 |= (uint32_t) value << 16;
-        break;
-
-    case 0xbdc: /* DMA_LCD_SRC_EI_B2 */
-        s->element_index_f2 = value;
-        break;
-
-    case 0xbde: /* DMA_LCD_SRC_FI_B2_L */
-        s->frame_index_f2 &= 0xffff0000;
-        s->frame_index_f2 |= 0x0000ffff & value;
-        break;
-
-    case 0xbf6: /* DMA_LCD_SRC_FI_B2_U */
-        s->frame_index_f2 &= 0x0000ffff;
-        s->frame_index_f2 |= (uint32_t) value << 16;
-        break;
-
-    case 0xbe0: /* DMA_LCD_SRC_EN_B1 */
-        s->elements_f1 = value;
-        break;
-
-    case 0xbe4: /* DMA_LCD_SRC_FN_B1 */
-        s->frames_f1 = value;
-        break;
-
-    case 0xbe2: /* DMA_LCD_SRC_EN_B2 */
-        s->elements_f2 = value;
-        break;
-
-    case 0xbe6: /* DMA_LCD_SRC_FN_B2 */
-        s->frames_f2 = value;
-        break;
-
-    case 0xbea: /* DMA_LCD_LCH_CTRL */
-        s->lch_type = value & 0xf;
-        break;
-
-    default:
-        return 1;
-    }
-    return 0;
-}
-
-static int omap_dma_3_2_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
-                uint16_t *ret)
-{
-    switch (offset) {
-    case 0xbc0: /* DMA_LCD_CSDP */
-        *ret = (s->brust_f2 << 14) |
-            (s->pack_f2 << 13) |
-            ((s->data_type_f2 >> 1) << 11) |
-            (s->brust_f1 << 7) |
-            (s->pack_f1 << 6) |
-            ((s->data_type_f1 >> 1) << 0);
-        break;
-
-    case 0xbc2: /* DMA_LCD_CCR */
-        *ret = (s->mode_f2 << 14) |
-            (s->mode_f1 << 12) |
-            (s->end_prog << 11) |
-            (s->omap_3_1_compatible_disable << 10) |
-            (s->repeat << 9) |
-            (s->auto_init << 8) |
-            (s->running << 7) |
-            (s->priority << 6) |
-            (s->bs << 4);
-        break;
-
-    case 0xbc4: /* DMA_LCD_CTRL */
-        qemu_irq_lower(s->irq);
-        *ret = (s->dst << 8) |
-            ((s->src & 0x6) << 5) |
-            (s->condition << 3) |
-            (s->interrupts << 1) |
-            s->dual;
-        break;
-
-    case 0xbc8: /* TOP_B1_L */
-        *ret = s->src_f1_top & 0xffff;
-        break;
-
-    case 0xbca: /* TOP_B1_U */
-        *ret = s->src_f1_top >> 16;
-        break;
-
-    case 0xbcc: /* BOT_B1_L */
-        *ret = s->src_f1_bottom & 0xffff;
-        break;
-
-    case 0xbce: /* BOT_B1_U */
-        *ret = s->src_f1_bottom >> 16;
-        break;
-
-    case 0xbd0: /* TOP_B2_L */
-        *ret = s->src_f2_top & 0xffff;
-        break;
-
-    case 0xbd2: /* TOP_B2_U */
-        *ret = s->src_f2_top >> 16;
-        break;
-
-    case 0xbd4: /* BOT_B2_L */
-        *ret = s->src_f2_bottom & 0xffff;
-        break;
-
-    case 0xbd6: /* BOT_B2_U */
-        *ret = s->src_f2_bottom >> 16;
-        break;
-
-    case 0xbd8: /* DMA_LCD_SRC_EI_B1 */
-        *ret = s->element_index_f1;
-        break;
-
-    case 0xbda: /* DMA_LCD_SRC_FI_B1_L */
-        *ret = s->frame_index_f1 & 0xffff;
-        break;
-
-    case 0xbf4: /* DMA_LCD_SRC_FI_B1_U */
-        *ret = s->frame_index_f1 >> 16;
-        break;
-
-    case 0xbdc: /* DMA_LCD_SRC_EI_B2 */
-        *ret = s->element_index_f2;
-        break;
-
-    case 0xbde: /* DMA_LCD_SRC_FI_B2_L */
-        *ret = s->frame_index_f2 & 0xffff;
-        break;
-
-    case 0xbf6: /* DMA_LCD_SRC_FI_B2_U */
-        *ret = s->frame_index_f2 >> 16;
-        break;
-
-    case 0xbe0: /* DMA_LCD_SRC_EN_B1 */
-        *ret = s->elements_f1;
-        break;
-
-    case 0xbe4: /* DMA_LCD_SRC_FN_B1 */
-        *ret = s->frames_f1;
-        break;
-
-    case 0xbe2: /* DMA_LCD_SRC_EN_B2 */
-        *ret = s->elements_f2;
-        break;
-
-    case 0xbe6: /* DMA_LCD_SRC_FN_B2 */
-        *ret = s->frames_f2;
-        break;
-
-    case 0xbea: /* DMA_LCD_LCH_CTRL */
-        *ret = s->lch_type;
-        break;
-
-    default:
-        return 1;
-    }
-    return 0;
-}
-
 static int omap_dma_3_1_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
                 uint16_t value)
 {
@@ -1462,12 +1212,10 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
 
     switch (addr) {
     case 0x300 ... 0x3fe:
-        if (s->model <= omap_dma_3_1 || !s->omap_3_1_mapping_disabled) {
-            if (omap_dma_3_1_lcd_read(&s->lcd_ch, addr, &ret))
-                break;
-            return ret;
+        if (omap_dma_3_1_lcd_read(&s->lcd_ch, addr, &ret)) {
+            break;
         }
-        /* Fall through. */
+        return ret;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
@@ -1476,20 +1224,13 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
         return ret;
 
     case 0x404 ... 0x4fe:
-        if (s->model <= omap_dma_3_1)
-            break;
-        /* Fall through. */
+        break;
     case 0x400:
         if (omap_dma_sys_read(s, addr, &ret))
             break;
         return ret;
 
     case 0xb00 ... 0xbfe:
-        if (s->model == omap_dma_3_2 && s->omap_3_1_mapping_disabled) {
-            if (omap_dma_3_2_lcd_read(&s->lcd_ch, addr, &ret))
-                break;
-            return ret;
-        }
         break;
     }
 
@@ -1511,12 +1252,10 @@ static void omap_dma_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case 0x300 ... 0x3fe:
-        if (s->model <= omap_dma_3_1 || !s->omap_3_1_mapping_disabled) {
-            if (omap_dma_3_1_lcd_write(&s->lcd_ch, addr, value))
-                break;
-            return;
+        if (omap_dma_3_1_lcd_write(&s->lcd_ch, addr, value)) {
+            break;
         }
-        /* Fall through.  */
+        return;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
@@ -1525,20 +1264,13 @@ static void omap_dma_write(void *opaque, hwaddr addr,
         return;
 
     case 0x404 ... 0x4fe:
-        if (s->model <= omap_dma_3_1)
-            break;
-        /* fall through */
+        break;
     case 0x400:
         if (omap_dma_sys_write(s, addr, value))
             break;
         return;
 
     case 0xb00 ... 0xbfe:
-        if (s->model == omap_dma_3_2 && s->omap_3_1_mapping_disabled) {
-            if (omap_dma_3_2_lcd_write(&s->lcd_ch, addr, value))
-                break;
-            return;
-        }
         break;
     }
 
@@ -1577,51 +1309,6 @@ static void omap_dma_clk_update(void *opaque, int line, int on)
             soc_dma_set_request(s->ch[i].dma, on);
 }
 
-static void omap_dma_setcaps(struct omap_dma_s *s)
-{
-    switch (s->model) {
-    default:
-    case omap_dma_3_1:
-        break;
-    case omap_dma_3_2:
-        /* XXX Only available for sDMA */
-        s->caps[0] =
-                (1 << 19) | /* Constant Fill Capability */
-                (1 << 18);  /* Transparent BLT Capability */
-        s->caps[1] =
-                (1 << 1);   /* 1-bit palettized capability (DMA 3.2 only) */
-        s->caps[2] =
-                (1 << 8) |  /* SEPARATE_SRC_AND_DST_INDEX_CPBLTY */
-                (1 << 7) |  /* DST_DOUBLE_INDEX_ADRS_CPBLTY */
-                (1 << 6) |  /* DST_SINGLE_INDEX_ADRS_CPBLTY */
-                (1 << 5) |  /* DST_POST_INCRMNT_ADRS_CPBLTY */
-                (1 << 4) |  /* DST_CONST_ADRS_CPBLTY */
-                (1 << 3) |  /* SRC_DOUBLE_INDEX_ADRS_CPBLTY */
-                (1 << 2) |  /* SRC_SINGLE_INDEX_ADRS_CPBLTY */
-                (1 << 1) |  /* SRC_POST_INCRMNT_ADRS_CPBLTY */
-                (1 << 0);   /* SRC_CONST_ADRS_CPBLTY */
-        s->caps[3] =
-                (1 << 6) |  /* BLOCK_SYNCHR_CPBLTY (DMA 4 only) */
-                (1 << 7) |  /* PKT_SYNCHR_CPBLTY (DMA 4 only) */
-                (1 << 5) |  /* CHANNEL_CHAINING_CPBLTY */
-                (1 << 4) |  /* LCh_INTERLEAVE_CPBLTY */
-                (1 << 3) |  /* AUTOINIT_REPEAT_CPBLTY (DMA 3.2 only) */
-                (1 << 2) |  /* AUTOINIT_ENDPROG_CPBLTY (DMA 3.2 only) */
-                (1 << 1) |  /* FRAME_SYNCHR_CPBLTY */
-                (1 << 0);   /* ELMNT_SYNCHR_CPBLTY */
-        s->caps[4] =
-                (1 << 7) |  /* PKT_INTERRUPT_CPBLTY (DMA 4 only) */
-                (1 << 6) |  /* SYNC_STATUS_CPBLTY */
-                (1 << 5) |  /* BLOCK_INTERRUPT_CPBLTY */
-                (1 << 4) |  /* LAST_FRAME_INTERRUPT_CPBLTY */
-                (1 << 3) |  /* FRAME_INTERRUPT_CPBLTY */
-                (1 << 2) |  /* HALF_FRAME_INTERRUPT_CPBLTY */
-                (1 << 1) |  /* EVENT_DROP_INTERRUPT_CPBLTY */
-                (1 << 0);   /* TIMEOUT_INTERRUPT_CPBLTY (DMA 3.2 only) */
-        break;
-    }
-}
-
 struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
                 MemoryRegion *sysmem,
                 qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
@@ -1630,20 +1317,16 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
     int num_irqs, memsize, i;
     struct omap_dma_s *s = g_new0(struct omap_dma_s, 1);
 
-    if (model <= omap_dma_3_1) {
-        num_irqs = 6;
-        memsize = 0x800;
-    } else {
-        num_irqs = 16;
-        memsize = 0xc00;
-    }
-    s->model = model;
+    assert(model == omap_dma_3_1);
+
+    num_irqs = 6;
+    memsize = 0x800;
     s->mpu = mpu;
     s->clk = clk;
     s->lcd_ch.irq = lcd_irq;
     s->lcd_ch.mpu = mpu;
 
-    s->dma = soc_dma_init((model <= omap_dma_3_1) ? 9 : 16);
+    s->dma = soc_dma_init(9);
     s->dma->freq = omap_clk_getrate(clk);
     s->dma->transfer_fn = omap_dma_transfer_generic;
     s->dma->setup_fn = omap_dma_transfer_setup;
@@ -1656,12 +1339,11 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
         s->ch[i].sibling = &s->ch[i + 6];
         s->ch[i + 6].sibling = &s->ch[i];
     }
-    for (i = (model <= omap_dma_3_1) ? 8 : 15; i >= 0; i --) {
+    for (i = 8; i >= 0; i--) {
         s->ch[i].dma = &s->dma->ch[i];
         s->dma->ch[i].opaque = &s->ch[i];
     }
 
-    omap_dma_setcaps(s);
     omap_clk_adduser(s->clk, qemu_allocate_irq(omap_dma_clk_update, s, 0));
     omap_dma_reset(s->dma);
     omap_dma_clk_update(s, 0, 1);
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index ea5c0eff8b..36569815e8 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -216,34 +216,6 @@ struct omap_dma_lcd_channel_s {
     hwaddr src_f2_top;
     hwaddr src_f2_bottom;
 
-    /* Used in OMAP DMA 3.2 gigacell */
-    unsigned char brust_f1;
-    unsigned char pack_f1;
-    unsigned char data_type_f1;
-    unsigned char brust_f2;
-    unsigned char pack_f2;
-    unsigned char data_type_f2;
-    unsigned char end_prog;
-    unsigned char repeat;
-    unsigned char auto_init;
-    unsigned char priority;
-    unsigned char fs;
-    unsigned char running;
-    unsigned char bs;
-    unsigned char omap_3_1_compatible_disable;
-    unsigned char dst;
-    unsigned char lch_type;
-    int16_t element_index_f1;
-    int16_t element_index_f2;
-    int32_t frame_index_f1;
-    int32_t frame_index_f2;
-    uint16_t elements_f1;
-    uint16_t frames_f1;
-    uint16_t elements_f2;
-    uint16_t frames_f2;
-    omap_dma_addressing_t mode_f1;
-    omap_dma_addressing_t mode_f2;
-
     /* Destination port is fixed.  */
     int interrupts;
     int condition;
-- 
2.43.0


