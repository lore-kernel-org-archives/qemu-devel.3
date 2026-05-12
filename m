Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0BBCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoV-0002Wd-Aa; Tue, 12 May 2026 16:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoF-0002Nx-JC
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoC-0002RY-5x
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so49969695e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618066; x=1779222866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oMRIz1cYEobW+mCeavjxs++vW/jWBy8/z7iwSk26Nxs=;
 b=FxhFpBwgH+/1w/a/A8Wa+tI8PG+BZ208d7r8695oBwL2xr7DbkeMwovysQuBJTQ+Je
 jT+Qe8pweM4KJyHf4T8CGAhlXSv6zUw44f2ITD7jbImRxz0dm8jy6dmEsc4Pq99w5/So
 fR5szfjaE79lSnVLpyOhmUTNo70uNP226Oiuh6pYMt5iGJdRqRhVfsctveRqTPmqI7/4
 07R63gXNfdLVB8jDMbFpz2GBi/yLiQ4G07mg64JDt4xDhvsR5klhn/KnlcH9arm5g8AO
 XHWA+rrJ9A4b4qzNxu3RZHvrwQlwfaWaKTValc7JvpmHwlHMVIhGzjrSMIg8rqUYLuMs
 4pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618066; x=1779222866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oMRIz1cYEobW+mCeavjxs++vW/jWBy8/z7iwSk26Nxs=;
 b=W1zK1o8hfY75BxOQjt1NX2clG493Ms64F1I0NzzMkMGxZy9pYolrvHNRo49whqIiFg
 O2C7tKXCFT8OqH59aukkpx5xWZgP+3DizQP/VScTlgBC5bc8zQastDdi29r/1IHYpvPM
 TMMy5QedUxiUjtZAH9hmhY5bXw99JBslk8CMb8UAOmzfJY9Z5vblJo3ZOlLv8R1sBswK
 JunQ7/UkdNYvb+hk9rRGJ0W2gk+d7QCPKZ9p/buTyE6v7xJIu5zz8nsQWhKUKAEfokm8
 UgnVGle36nkxC8rMoA0koyBTbU63SVqnq95+cq6qHeEecAB0573KrrSX6bLIAAmdgZfk
 XC7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nKgNOUAFpBr/mj9u0wjPv1z1bXmtFN+m2RT9VNbgzYfQ+UYi6MrGQnKdQdPeZk2URfi0/QzX5bHbb@nongnu.org
X-Gm-Message-State: AOJu0Yw/51fwhf/18JKTpumj+6YC5twaXVenhzyZrN7Udgzcgh8ELwyR
 JRB4OVBG4yP+PJqQqDi+UaShiFokdo+MXEFIzGU7n83c4wB4gifD5B6czFROLRxcUV4=
X-Gm-Gg: Acq92OHKlgVwq3wQOr3dW2xX18M1XuGagYdObqYVU+d7TmlxnRd0Ek2Qp+3doT/8wm+
 ZiYnb1XzxMGf9T3i8Y9bdEQEdrvHz+JOrjLblTyvrFoFQQoyZc55O6xR5whJyrUTZf4TvcQhnqA
 DMEMVip/FZdFfi9BdQeeHWrqE4lZ7kqwDZ/d2shZME5d9yrHqk5qWn9iuOdjm5lQU10pwlmA9TD
 OS8SeI6pBCPEDIGNYDeUIFQIvZtfm+6d3H04KNZOKT6blfjClkDNRbEBkNvPo3ftCPVrkAyK66b
 r8rtA0t9fWS7HRwLbmyl9+pG0a1bl/VMADP884c8JVLmOovdvpSIYBwoBlErSG62D96vy5D9Gca
 aEmHloYe3hqLgu3Gkep/UgJtmNeq2To8MCYm1YLdit+ykxBhv1rCcp9+1tKp1tis7ytpZvh/a4i
 uFGQYLnQWcLIBpg5EgbwxgiNpFdNiAeSpXv58PbP/IQ1CbArVBZy0KdzWz4WnDweLQXNOIba6zl
 qUCA+cWJ6A+xbOFcb/IV0/Gu1t2YGk=
X-Received: by 2002:a05:600c:19ce:b0:48a:76a3:2b9b with SMTP id
 5b1f17b1804b1-48fc9a34866mr4834385e9.17.1778618065812; 
 Tue, 12 May 2026 13:34:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/12] hw/dma/omap_dma: Fold omap_dma_sys_read() and
 omap_dma_sys_write() into callers
Date: Tue, 12 May 2026 21:34:10 +0100
Message-ID: <20260512203414.3633237-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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


