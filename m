Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254BCC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6s-0001ag-1Y; Tue, 28 Jan 2025 05:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj69-0001AV-Fs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj66-0003ZV-DV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so2905946f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061130; x=1738665930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1f0V/uP3+Z6Rm6pHIUK22c1PN0PD4Ozc5f+Izcv90c=;
 b=k/jo6XOtx1Z4WFxJCq7VqUn9Ym7KcBs0ix8JkMLKFiK4Ws0rd9xAiGlq25uphvrEj2
 +yu2uCycaFxQyKiTGa+DT/r73LYKDcQwwUgQA08zajR1cMqXAsAU0t6AooamtaeiluPS
 02F+WEV//BLnC0th3jKYBMmGLwSK9FOt5U5qqclIaQU9i8CoFtj2kUyRkz3QvgA5s6bu
 wYrZJUO0NZpFNZY/9QnMrc6jNjystFkKJtDN2DOjqvvsIIh/StW0S2Z4rsgJBzgHx0zV
 24RHwHEBzdSOm0OLU4IgubK7fBEdXjPSAuU0lqWJBM6LI5hAo0FoojCxdfy8IQou7Lm5
 ukaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061130; x=1738665930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1f0V/uP3+Z6Rm6pHIUK22c1PN0PD4Ozc5f+Izcv90c=;
 b=r20wALS0NI1ipujSZ9EPHJdvGXgVcjjBfTuykdrufgLn5sd6sYYUyXkyJwqKmZNTf2
 ksnUytog1k9V3E1gqohfBW8Rtyq0vbBd6Nxdtxp1VnjwTvRLa8kVc/Z60Jq/HBViY6gP
 uN8klit/ffuA00Dx5dNOxKQA5jFYOmIGhi8N//6rzHN5gWWx9P8ehDyuoNsh7ez3OeN2
 oDPENU/r4TA+4jBO1gUXwRkLP712h+K2DjaEF9JNkyuWLyptiBc3L66/tTM6EXgbvftH
 rIGwKdpiCOZMvi4dZpgLOSmcXUF8jLtaS9+6JCwI9yBe1UkXopsJP5/5BLmFQFUFf6zL
 F6Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiRghlnYzO7/8zMz9qDbjoZw+KNH6ZvBkLQGkSOqy6v0A7YR6zPkGm4CocfDTnDwZFI60QVC7+FwyX@nongnu.org
X-Gm-Message-State: AOJu0Yyx1hBulR0M8002yin5uscjqxH3+tzaGhv5m7Nk08721bKBOFXH
 w9krRHQf+gfn0ilXr8dx9ICZu08tTe+7c16ftIZhIKPAtvXcDBwiZw5o15jj9o8=
X-Gm-Gg: ASbGncvKSQLqmG4Z1wPm49tbsE5VN79Q6JSHjzpkxmwOKHzaAdB2pqxpaI/hrAmxn3x
 5I029ICxwCSGiT1bjn4vu2BSh9yyjWkXx1kXo2YGkcrkuveoGKksD32BmAzqTaxDZAZPSUez4S8
 JKZM9okWQCPrROFecHZuLgAr2x/xwANPRYHBXBHnDAjX8CqxyYelXcj3Xx3XHxv9oRDF7Sdxkul
 ImZRa3/T+PycYJjm9xpHXyyA8G7QOk4v+6L6IIA6lxX6aLpWEA370W276fNOjV998tmfrsJSwDk
 /w0Ff0s7m56xtU39boJZ
X-Google-Smtp-Source: AGHT+IGmHW76lvNRLCHv3G9HZfLJRYxaAYggNDZvlmXA2sGmkybUXdigPXv9aQd8P9v3MrJLMyEKKw==
X-Received: by 2002:a5d:64a1:0:b0:385:e8dd:b143 with SMTP id
 ffacd0b85a97d-38bf56627d7mr34514066f8f.19.1738061130339; 
 Tue, 28 Jan 2025 02:45:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 08/11] hw/sd/omap_mmc: Untabify
Date: Tue, 28 Jan 2025 10:45:16 +0000
Message-Id: <20250128104519.3981448-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a very old source file, and still has some lingering
hard-coded tabs; untabify it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't propose to try to bring the whole file up to modern
coding style, but hard-coded tabs are a particular wart.
---
 hw/sd/omap_mmc.c | 124 +++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 07d47421bc8..c1598135f44 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -110,11 +110,11 @@ static void omap_mmc_fifolevel_update(OMAPMMCState *host)
 
 /* These must match the encoding of the MMC_CMD Response field */
 typedef enum {
-    sd_nore = 0,	/* no response */
-    sd_r1,		/* normal response command */
-    sd_r2,		/* CID, CSD registers */
-    sd_r3,		/* OCR register */
-    sd_r6 = 6,		/* Published RCA response */
+    sd_nore = 0,        /* no response */
+    sd_r1,              /* normal response command */
+    sd_r2,              /* CID, CSD registers */
+    sd_r3,              /* OCR register */
+    sd_r6 = 6,          /* Published RCA response */
     sd_r1b = -1,
 } sd_rsp_type_t;
 
@@ -230,7 +230,7 @@ static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
     if (timeout)
         host->status |= 0x0080;
     else if (cmd == 12)
-        host->status |= 0x0005;	/* Makes it more real */
+        host->status |= 0x0005;         /* Makes it more real */
     else
         host->status |= 0x0001;
 }
@@ -339,32 +339,32 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* MMC_CMD */
+    case 0x00:  /* MMC_CMD */
         return s->last_cmd;
 
-    case 0x04:	/* MMC_ARGL */
+    case 0x04:  /* MMC_ARGL */
         return s->arg & 0x0000ffff;
 
-    case 0x08:	/* MMC_ARGH */
+    case 0x08:  /* MMC_ARGH */
         return s->arg >> 16;
 
-    case 0x0c:	/* MMC_CON */
+    case 0x0c:  /* MMC_CON */
         return (s->dw << 15) | (s->mode << 12) | (s->enable << 11) | 
                 (s->be << 10) | s->clkdiv;
 
-    case 0x10:	/* MMC_STAT */
+    case 0x10:  /* MMC_STAT */
         return s->status;
 
-    case 0x14:	/* MMC_IE */
+    case 0x14:  /* MMC_IE */
         return s->mask;
 
-    case 0x18:	/* MMC_CTO */
+    case 0x18:  /* MMC_CTO */
         return s->cto;
 
-    case 0x1c:	/* MMC_DTO */
+    case 0x1c:  /* MMC_DTO */
         return s->dto;
 
-    case 0x20:	/* MMC_DATA */
+    case 0x20:  /* MMC_DATA */
         /* TODO: support 8-bit access */
         i = s->fifo[s->fifo_start];
         if (s->fifo_len == 0) {
@@ -379,42 +379,42 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
         omap_mmc_interrupts_update(s);
         return i;
 
-    case 0x24:	/* MMC_BLEN */
+    case 0x24:  /* MMC_BLEN */
         return s->blen_counter;
 
-    case 0x28:	/* MMC_NBLK */
+    case 0x28:  /* MMC_NBLK */
         return s->nblk_counter;
 
-    case 0x2c:	/* MMC_BUF */
+    case 0x2c:  /* MMC_BUF */
         return (s->rx_dma << 15) | (s->af_level << 8) |
             (s->tx_dma << 7) | s->ae_level;
 
-    case 0x30:	/* MMC_SPI */
+    case 0x30:  /* MMC_SPI */
         return 0x0000;
-    case 0x34:	/* MMC_SDIO */
+    case 0x34:  /* MMC_SDIO */
         return (s->cdet_wakeup << 2) | (s->cdet_enable) | s->sdio;
-    case 0x38:	/* MMC_SYST */
+    case 0x38:  /* MMC_SYST */
         return 0x0000;
 
-    case 0x3c:	/* MMC_REV */
+    case 0x3c:  /* MMC_REV */
         return s->rev;
 
-    case 0x40:	/* MMC_RSP0 */
-    case 0x44:	/* MMC_RSP1 */
-    case 0x48:	/* MMC_RSP2 */
-    case 0x4c:	/* MMC_RSP3 */
-    case 0x50:	/* MMC_RSP4 */
-    case 0x54:	/* MMC_RSP5 */
-    case 0x58:	/* MMC_RSP6 */
-    case 0x5c:	/* MMC_RSP7 */
+    case 0x40:  /* MMC_RSP0 */
+    case 0x44:  /* MMC_RSP1 */
+    case 0x48:  /* MMC_RSP2 */
+    case 0x4c:  /* MMC_RSP3 */
+    case 0x50:  /* MMC_RSP4 */
+    case 0x54:  /* MMC_RSP5 */
+    case 0x58:  /* MMC_RSP6 */
+    case 0x5c:  /* MMC_RSP7 */
         return s->rsp[(offset - 0x40) >> 2];
 
     /* OMAP2-specific */
-    case 0x60:	/* MMC_IOSR */
-    case 0x64:	/* MMC_SYSC */
+    case 0x60:  /* MMC_IOSR */
+    case 0x64:  /* MMC_SYSC */
         return 0;
-    case 0x68:	/* MMC_SYSS */
-        return 1;						/* RSTD */
+    case 0x68:  /* MMC_SYSS */
+        return 1;                                               /* RSTD */
     }
 
     OMAP_BAD_REG(offset);
@@ -433,7 +433,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
     }
 
     switch (offset) {
-    case 0x00:	/* MMC_CMD */
+    case 0x00:  /* MMC_CMD */
         if (!s->enable)
             break;
 
@@ -448,17 +448,17 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         omap_mmc_update(s);
         break;
 
-    case 0x04:	/* MMC_ARGL */
+    case 0x04:  /* MMC_ARGL */
         s->arg &= 0xffff0000;
         s->arg |= 0x0000ffff & value;
         break;
 
-    case 0x08:	/* MMC_ARGH */
+    case 0x08:  /* MMC_ARGH */
         s->arg &= 0x0000ffff;
         s->arg |= value << 16;
         break;
 
-    case 0x0c:	/* MMC_CON */
+    case 0x0c:  /* MMC_CON */
         s->dw = (value >> 15) & 1;
         s->mode = (value >> 12) & 3;
         s->enable = (value >> 11) & 1;
@@ -478,27 +478,27 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
             omap_mmc_pseudo_reset(s);
         break;
 
-    case 0x10:	/* MMC_STAT */
+    case 0x10:  /* MMC_STAT */
         s->status &= ~value;
         omap_mmc_interrupts_update(s);
         break;
 
-    case 0x14:	/* MMC_IE */
+    case 0x14:  /* MMC_IE */
         s->mask = value & 0x7fff;
         omap_mmc_interrupts_update(s);
         break;
 
-    case 0x18:	/* MMC_CTO */
+    case 0x18:  /* MMC_CTO */
         s->cto = value & 0xff;
         if (s->cto > 0xfd && s->rev <= 1)
             printf("MMC: CTO of 0xff and 0xfe cannot be used!\n");
         break;
 
-    case 0x1c:	/* MMC_DTO */
+    case 0x1c:  /* MMC_DTO */
         s->dto = value & 0xffff;
         break;
 
-    case 0x20:	/* MMC_DATA */
+    case 0x20:  /* MMC_DATA */
         /* TODO: support 8-bit access */
         if (s->fifo_len == 32)
             break;
@@ -509,18 +509,18 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         omap_mmc_interrupts_update(s);
         break;
 
-    case 0x24:	/* MMC_BLEN */
+    case 0x24:  /* MMC_BLEN */
         s->blen = (value & 0x07ff) + 1;
         s->blen_counter = s->blen;
         break;
 
-    case 0x28:	/* MMC_NBLK */
+    case 0x28:  /* MMC_NBLK */
         s->nblk = (value & 0x07ff) + 1;
         s->nblk_counter = s->nblk;
         s->blen_counter = s->blen;
         break;
 
-    case 0x2c:	/* MMC_BUF */
+    case 0x2c:  /* MMC_BUF */
         s->rx_dma = (value >> 15) & 1;
         s->af_level = (value >> 8) & 0x1f;
         s->tx_dma = (value >> 7) & 1;
@@ -535,38 +535,38 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         break;
 
     /* SPI, SDIO and TEST modes unimplemented */
-    case 0x30:	/* MMC_SPI (OMAP1 only) */
+    case 0x30:  /* MMC_SPI (OMAP1 only) */
         break;
-    case 0x34:	/* MMC_SDIO */
+    case 0x34:  /* MMC_SDIO */
         s->sdio = value & (s->rev >= 2 ? 0xfbf3 : 0x2020);
         s->cdet_wakeup = (value >> 9) & 1;
         s->cdet_enable = (value >> 2) & 1;
         break;
-    case 0x38:	/* MMC_SYST */
+    case 0x38:  /* MMC_SYST */
         break;
 
-    case 0x3c:	/* MMC_REV */
-    case 0x40:	/* MMC_RSP0 */
-    case 0x44:	/* MMC_RSP1 */
-    case 0x48:	/* MMC_RSP2 */
-    case 0x4c:	/* MMC_RSP3 */
-    case 0x50:	/* MMC_RSP4 */
-    case 0x54:	/* MMC_RSP5 */
-    case 0x58:	/* MMC_RSP6 */
-    case 0x5c:	/* MMC_RSP7 */
+    case 0x3c:  /* MMC_REV */
+    case 0x40:  /* MMC_RSP0 */
+    case 0x44:  /* MMC_RSP1 */
+    case 0x48:  /* MMC_RSP2 */
+    case 0x4c:  /* MMC_RSP3 */
+    case 0x50:  /* MMC_RSP4 */
+    case 0x54:  /* MMC_RSP5 */
+    case 0x58:  /* MMC_RSP6 */
+    case 0x5c:  /* MMC_RSP7 */
         OMAP_RO_REG(offset);
         break;
 
     /* OMAP2-specific */
-    case 0x60:	/* MMC_IOSR */
+    case 0x60:  /* MMC_IOSR */
         if (value & 0xf)
             printf("MMC: SDIO bits used!\n");
         break;
-    case 0x64:	/* MMC_SYSC */
-        if (value & (1 << 2))					/* SRTS */
+    case 0x64:  /* MMC_SYSC */
+        if (value & (1 << 2))                                   /* SRTS */
             omap_mmc_reset(s);
         break;
-    case 0x68:	/* MMC_SYSS */
+    case 0x68:  /* MMC_SYSS */
         OMAP_RO_REG(offset);
         break;
 
-- 
2.34.1


