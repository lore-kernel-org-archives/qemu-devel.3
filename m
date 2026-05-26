Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C7DCD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmZ-0000FU-LN; Tue, 26 May 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmF-0008FE-LN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmE-0001Dm-0q
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ed9336049so488925f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805740; x=1780410540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iKoI6jb4oPXbwYLz4nwwqaE8QARRc2bglnNlB7mB23c=;
 b=W3oaxyBrk7/m+Clr/mq5wcH/vkauAiCbJzlazFZKxudSPwA1Cpsd+WEkw9fm0blwuS
 aFXRdyKO88rwtNjB8owKUEcEp0ZhJQERQx6OUwT9Tejz5PB9kPOHIhbqvho3XrUJfkoH
 R1sZWJR+lyKbt6Unkt8uMRel0/HcSKRDFiYckY/su9ryqoRkN79PqfQfQmcXlJ3auwCr
 W3QQQq5pib0VYQdBBDSdAcU7uzc5XIH+qHoiAe7u2LxX82grPnqzS5AyMt8YJnXtknLC
 Y6tUa4CvxnFUC0BLxU6/tXqcGC2weaWiJ5w4b6OuSyjV8uH7h6tdhFpJGe+dJsAM0Sqp
 qBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805740; x=1780410540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iKoI6jb4oPXbwYLz4nwwqaE8QARRc2bglnNlB7mB23c=;
 b=WuquzBQ/oTTaEFlPSN5XioezadBXEaq2o6bO7EhHuQ3QKOHiJf7l+PJccsXgOvnFms
 e7tah/MN11rE8zHOtq8OgCk9h9ce/Qc4rW06j4z/w7eqgf3vIC/pFS/mjxr5maXIA6XX
 29hjyXO3wJjfOcIDvLLB0WS+8pdS3c8w+DybNG0w8V0XvYpJ5BKixVAmgh8n9x9KY9GN
 deuo/MmTXrTQnvY4SZCbSxtoSEE9CAKFbx2rkXeKfBOuTwA3J8Mz9BZOmP1IVXVoVI66
 09hJhd5oeFhmvYQCZaP3zUkgEerH2QYIzxNYYgo6uQH786NDlc+OpPy0W8D43w0vGNbd
 LcBw==
X-Gm-Message-State: AOJu0YwBTxehYHlWMjStjkQKOdpuynB6Zn4XHCXcbX1++5TEO76oPcRb
 S2ht0gtlmr4T5hcCrQYRlfaEjgZXQWQXtMMO3sSyeIGa3+EQAIzD5nA+M4xjff7eqOHNlohBSty
 toceQ
X-Gm-Gg: Acq92OFrC1/v6xnU0e515BScSXpS1xgUNwwcyqLHzyTa/OXmYCW2O/qT7jDP4Dlj5kL
 QnvFT/sCk/ZUf0qPdAmKwXeuzycCQtboRmux4H3uMG9iz8uU/qFKuQKXoondE0HTQjVIb4hPoxb
 aCtJt6YWR8GyT1w5qo7fVZHhfWx9Dzri3Gnuif55NH68nBxZTczseNPR2gEWDU8o8jbFMFHnWmu
 RELgjwpkSOK4qYZm6IZaer1VqUO8+XkZOYsU0OfZ/3bOUWz1ugikaFNQNW9sOCc0I9HL5LDYE7M
 IXkRAA7J4BJPljn1Hf/xks6UJnz2yLegTJr8fuOeysKJjAtl6uW6jSi5L9JQJ/rPC5y8VSwcTzM
 XJ1Adk6LEoeoE2cww+waP5Veht2IuCAkjReDT129D25kaeC0JEXCevDlcQOSz7uIBiVaCzk4EO3
 yhzI+IQKBJhYO6iDxGeu0Jkxa0Jq33oC9BV+7m0T+ZoTsUor5KmDnMTSEa1Q3Lnl2zUazMAETHa
 zQsjm5y/TER8/sjKJWYjDlu4niIJww=
X-Received: by 2002:a05:6000:2688:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-45eb3670427mr31446204f8f.6.1779805740479; 
 Tue, 26 May 2026 07:29:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/54] hw/dma/omap_dma: Fold omap_dma_sys_read() and
 omap_dma_sys_write() into callers
Date: Tue, 26 May 2026 15:28:05 +0100
Message-ID: <20260526142850.2326589-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Now we have removed the DMA 3.2 support, we call omap_dma_sys_read()
only for the single address offset 0x400, and similarly for
omap_dma_sys_write().  The other cases in those functions are DMA
3.2-only and now dead code.  Fold the 0x400 register directly into
the callers, and remove the rest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-9-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 121 ++--------------------------------------------
 1 file changed, 5 insertions(+), 116 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 9a86d90b4e..49348f40c5 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -317,16 +317,6 @@ static void omap_dma_interrupts_3_1_update(struct omap_dma_s *s)
         qemu_irq_raise(ch[5].irq);
 }
 
-static void omap_dma_interrupts_3_2_update(struct omap_dma_s *s)
-{
-    struct omap_dma_channel_s *ch = s->ch;
-    int i;
-
-    for (i = s->chans; i; ch ++, i --)
-        if (ch->status)
-            qemu_irq_raise(ch->irq);
-}
-
 static void omap_dma_enable_3_1_mapping(struct omap_dma_s *s)
 {
     s->omap_3_1_mapping_disabled = 0;
@@ -334,13 +324,6 @@ static void omap_dma_enable_3_1_mapping(struct omap_dma_s *s)
     s->intr_update = omap_dma_interrupts_3_1_update;
 }
 
-static void omap_dma_disable_3_1_mapping(struct omap_dma_s *s)
-{
-    s->omap_3_1_mapping_disabled = 1;
-    s->chans = 16;
-    s->intr_update = omap_dma_interrupts_3_2_update;
-}
-
 static void omap_dma_process_request(struct omap_dma_s *s, int request)
 {
     int channel;
@@ -1106,98 +1089,6 @@ static int omap_dma_3_1_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
     return 0;
 }
 
-static int omap_dma_sys_write(struct omap_dma_s *s, int offset, uint16_t value)
-{
-    switch (offset) {
-    case 0x400: /* SYS_DMA_GCR */
-        s->gcr = value;
-        break;
-
-    case 0x404: /* DMA_GSCR */
-        if (value & 0x8)
-            omap_dma_disable_3_1_mapping(s);
-        else
-            omap_dma_enable_3_1_mapping(s);
-        break;
-
-    case 0x408: /* DMA_GRST */
-        if (value & 0x1)
-            omap_dma_reset(s->dma);
-        break;
-
-    default:
-        return 1;
-    }
-    return 0;
-}
-
-static int omap_dma_sys_read(struct omap_dma_s *s, int offset,
-                uint16_t *ret)
-{
-    switch (offset) {
-    case 0x400: /* SYS_DMA_GCR */
-        *ret = s->gcr;
-        break;
-
-    case 0x404: /* DMA_GSCR */
-        *ret = s->omap_3_1_mapping_disabled << 3;
-        break;
-
-    case 0x408: /* DMA_GRST */
-        *ret = 0;
-        break;
-
-    case 0x442: /* DMA_HW_ID */
-    case 0x444: /* DMA_PCh2_ID */
-    case 0x446: /* DMA_PCh0_ID */
-    case 0x448: /* DMA_PCh1_ID */
-    case 0x44a: /* DMA_PChG_ID */
-    case 0x44c: /* DMA_PChD_ID */
-        *ret = 1;
-        break;
-
-    case 0x44e: /* DMA_CAPS_0_U */
-        *ret = (s->caps[0] >> 16) & 0xffff;
-        break;
-    case 0x450: /* DMA_CAPS_0_L */
-        *ret = (s->caps[0] >>  0) & 0xffff;
-        break;
-
-    case 0x452: /* DMA_CAPS_1_U */
-        *ret = (s->caps[1] >> 16) & 0xffff;
-        break;
-    case 0x454: /* DMA_CAPS_1_L */
-        *ret = (s->caps[1] >>  0) & 0xffff;
-        break;
-
-    case 0x456: /* DMA_CAPS_2 */
-        *ret = s->caps[2];
-        break;
-
-    case 0x458: /* DMA_CAPS_3 */
-        *ret = s->caps[3];
-        break;
-
-    case 0x45a: /* DMA_CAPS_4 */
-        *ret = s->caps[4];
-        break;
-
-    case 0x460: /* DMA_PCh2_SR */
-    case 0x480: /* DMA_PCh0_SR */
-    case 0x482: /* DMA_PCh1_SR */
-    case 0x4c0: /* DMA_PChD_SR_0 */
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: Physical Channel Status Registers not implemented\n",
-                      __func__);
-        *ret = 0xff;
-        break;
-
-    default:
-        return 1;
-    }
-    return 0;
-}
-
 static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
 {
     struct omap_dma_s *s = opaque;
@@ -1225,10 +1116,9 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
 
     case 0x404 ... 0x4fe:
         break;
-    case 0x400:
-        if (omap_dma_sys_read(s, addr, &ret))
-            break;
-        return ret;
+    case 0x400: /* SYS_DMA_GCR */
+        return s->gcr;
+        break;
 
     case 0xb00 ... 0xbfe:
         break;
@@ -1265,9 +1155,8 @@ static void omap_dma_write(void *opaque, hwaddr addr,
 
     case 0x404 ... 0x4fe:
         break;
-    case 0x400:
-        if (omap_dma_sys_write(s, addr, value))
-            break;
+    case 0x400: /* SYS_DMA_GCR */
+        s->gcr = value;
         return;
 
     case 0xb00 ... 0xbfe:
-- 
2.43.0


