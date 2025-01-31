Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2383EC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFS-0005Nl-AD; Fri, 31 Jan 2025 16:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFG-0004EJ-Vb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:13 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFD-00081a-MG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:10 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1230032f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357685; x=1738962485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv4y1qDnwLVDwhBF6zOkYg6dg7wJIzwFJo+NloWuB10=;
 b=HSpozAvZ3EaxWXbLuaTKO2mrbKejCUxwNgQTNfJ097oa5kJFR/VyThQI/bJ08M86Kt
 kscKzZneqcPZj7NaheRdGB/Pz8og+UPA4zNkZHSg3Oui26TWSKICY6NTRW9gKtT8rdgu
 VT5Ah6K5Z+2OfNdVIEO+gC+U9i2qhNYAU72cVIwJTsSsArSKMFR1E8JCLpSXMCB8bOf/
 f5J3tyqc0LNZ4Yyhr2yD37SDG1X6DvRqvxxoxhJUJpNAxQ4EPgcD65mkJsh0tIDBjTuJ
 exFELOC/we3kQ6i0b5eSJr44VdZ/vA0AMJJv/aB2d/hAChja1J+R3flPIwTDBJzflVOo
 95Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357685; x=1738962485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv4y1qDnwLVDwhBF6zOkYg6dg7wJIzwFJo+NloWuB10=;
 b=j5vMclVs/Xj+L8YBJHpI8aCiHUe/QMJnCu8rcBgxyAy9krGHA2DzHFdqiRknxm0aNc
 pQd95w+wq2hY2ZgK3DINeY80Wsl5RTtjfcCiP2OypUDESw8shrAuQvK6jLxJSBLdNEqA
 QAN0jIzKkBKFrFYH/1STQoazLxtiArofIjygYY6Drk8MO1isrQZia+aiMYS+G0F6RNOV
 7ElS2j9yLsQxYQt9is0PxRTfBGqViCBIyUiMImi17ui5bsHYYLnP5wdWxyJrh+KCyGSP
 U6WxCB6aFKFhutM2I1V85SJeldHr/xSHWytp9f2dA0UmF1/6r6u485De/3ePqNuHGJ3C
 97Zg==
X-Gm-Message-State: AOJu0Yxr2QkVf+ANhOGH2NAxRFZOQaaS+3dtVALs74qDIy+eE8iz7nUb
 MnQfgc7fdRquERWTS52cOYMMmOAwA/5ci0C+RTYr233rkFSgoM8ixL6bbSPz3QZhOJFhufhcKnD
 xn2I=
X-Gm-Gg: ASbGncuQZ6ZHtzrE4aZU7s4RQSNI3vVND7Q9N/RKnlFOMyJDznlFmYrnXFvP7UQg5sT
 IBI6zyj7t0tySit77tX5YN/0bMCFcygV08K+an5XjkfXnm7iYTXE1nvkDL2VGkVg180+1QqREqa
 +BA5+KeoJRd5snKt1qcmX4TcAnZIlJMqTxaieAELQwfrznnpLOGTvBI3cHRoqOXTgEKi/+Nhtqb
 F644QEpRPX3V6Sb1fMJGuq4j6rMl8NmTrau+sIymIWFLsKZM/aOCEqMHPEqxYoMQ8gOqs+0ZGyo
 /HjVacKoyhJ25LxFyxePomHHba5NOtDmwO8ITsGIDmUfEdco8hbyHbN2vK1yuwrVEA==
X-Google-Smtp-Source: AGHT+IE6hUPdR/SXyFDHCOa+lFrqDttxrT6bo1Axt4r7eX2LuabN3x1RNkwTs3smACNNejySQB1BfQ==
X-Received: by 2002:a5d:64a1:0:b0:385:f17b:de54 with SMTP id
 ffacd0b85a97d-38c5193112amr10794729f8f.5.1738357684885; 
 Fri, 31 Jan 2025 13:08:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c11b363sm5543100f8f.40.2025.01.31.13.08.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:08:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/36] hw/sd/omap_mmc: Untabify
Date: Fri, 31 Jan 2025 22:05:16 +0100
Message-ID: <20250131210520.85874-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

This is a very old source file, and still has some lingering
hard-coded tabs; untabify it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-9-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/omap_mmc.c | 124 +++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 18016a2f2e2..bbe7b971bbe 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -109,11 +109,11 @@ static void omap_mmc_fifolevel_update(OMAPMMCState *host)
 
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
 
@@ -229,7 +229,7 @@ static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
     if (timeout)
         host->status |= 0x0080;
     else if (cmd == 12)
-        host->status |= 0x0005;	/* Makes it more real */
+        host->status |= 0x0005;         /* Makes it more real */
     else
         host->status |= 0x0001;
 }
@@ -338,32 +338,32 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
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
@@ -378,42 +378,42 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
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
@@ -432,7 +432,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
     }
 
     switch (offset) {
-    case 0x00:	/* MMC_CMD */
+    case 0x00:  /* MMC_CMD */
         if (!s->enable)
             break;
 
@@ -447,17 +447,17 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
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
@@ -477,27 +477,27 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
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
@@ -508,18 +508,18 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
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
@@ -534,38 +534,38 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
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
2.47.1


