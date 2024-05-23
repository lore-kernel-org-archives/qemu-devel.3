Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2ABC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATg-00084Z-DI; Thu, 23 May 2024 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATU-0007q1-HL
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0002SX-2t
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so1813474f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478510; x=1717083310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LrmhrKaXF0DEYxLjGzXZ63cc61xp2WM9kMJXk0bodfg=;
 b=TXsc4N3V1OAE7rvM2Q+yw1XpQqxcSLlLV06ASizTHnqO9jzxSlGSCsDUAoamnZcHQq
 i0OzoomzcIxbJPfiM4UO2XE8mk5zEgnnNIQbNGU8A5xgUtfU7Mo+9FYzCKfgBf/miTMn
 Jw4a1uYS2DNfXJAVTjrygdkoZ/zM9E3tntEhEB929lvaZiHx041YaAlFjFvQksemFJbt
 /PGXJwcFueKIsuiRLWjiNgpsfIPlhjgYMTYvpltcZo4o5lFc7IiNy9TAyLphRRR4sFyF
 PSivBb9W5i3kJ1VXEUmEqWLJR6HtkOwRck1GrwtVU3cTrXy8vLhL/8WHSrMipGwPYOHy
 9OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478510; x=1717083310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrmhrKaXF0DEYxLjGzXZ63cc61xp2WM9kMJXk0bodfg=;
 b=BaGOdx8pDw8pwIciRrHQgRAxxe0Ipi3aC8Gy9WBYXETedAeXhRHkyYH2ElQSsu100m
 1PaT+XHMNN7N6NS8V3M28rCoV4BAV/vIkKWfpMEkh3iSbnG1wdpHXkvstvID19Bzbstk
 sed1pln5I4PyKoy826a9xKcHpXl3X5FO/VKuWeqh/icQfFSipmLn+uregAub+DS/x+7e
 Y98gwKzGK85oppNWeSfSTzzbPIpIRpjmK2ApAqNRld0bB4SE6Wy81ItMeLTvkfB7/eAI
 bA9joKlUwyAN/lJjlfqdV4dExg9y4f37GUwvNDBsBnJcL3NBwqG9x0gnk0qS3xy7accW
 VDFQ==
X-Gm-Message-State: AOJu0YzP62BVjjFyvEvV33BbtyLVlibzOgq3CONiZ/A0ceGS5vv6JGsf
 1XdV3wf/SyP7TIWw4z2FLmYkdxzfP80O/bcm/GKm1aHbtyQHB+uskHSZaez1wxinbr0aLpF9uqv
 3
X-Google-Smtp-Source: AGHT+IGZfKhqK21ULiv4V3ZakwLj3lwqHpBu4YtidOcO6+oENmv8iNpOgCzxEn3LuP9oxcAmk7TYsw==
X-Received: by 2002:a05:6000:1047:b0:34e:4105:b3f6 with SMTP id
 ffacd0b85a97d-354d8cf97d4mr4202596f8f.39.1716478510398; 
 Thu, 23 May 2024 08:35:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/37] hw: arm: Remove use of tabs in some source files
Date: Thu, 23 May 2024 16:34:35 +0100
Message-Id: <20240523153505.2900433-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Tanmay Patil <tanmaynpatil105@gmail.com>

Some of the source files for older devices use hardcoded tabs
instead of our current coding standard's required spaces.
Fix these in the following files:
	- hw/arm/boot.c
	- hw/char/omap_uart.c
	- hw/gpio/zaurus.c
	- hw/input/tsc2005.c

This commit is mostly whitespace-only changes; it also
adds curly-braces to some 'if' statements.

This addresses part of https://gitlab.com/qemu-project/qemu/-/issues/373
but some other files remain to be handled.

Signed-off-by: Tanmay Patil <tanmaynpatil105@gmail.com>
Message-id: 20240508081502.88375-1-tanmaynpatil105@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c       |   8 +--
 hw/char/omap_uart.c |  49 +++++++++--------
 hw/gpio/zaurus.c    |  59 ++++++++++----------
 hw/input/tsc2005.c  | 130 ++++++++++++++++++++++++--------------------
 4 files changed, 130 insertions(+), 116 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a4..d480a7da02c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -347,13 +347,13 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
     WRITE_WORD(p, info->ram_size / 4096);
     /* ramdisk_size */
     WRITE_WORD(p, 0);
-#define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
+#define FLAG_READONLY 1
+#define FLAG_RDLOAD   4
+#define FLAG_RDPROMPT 8
     /* flags */
     WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD | FLAG_RDPROMPT);
     /* rootdev */
-    WRITE_WORD(p, (31 << 8) | 0);	/* /dev/mtdblock0 */
+    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
     /* video_num_cols */
     WRITE_WORD(p, 0);
     /* video_num_rows */
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 6848bddb4e2..c2ef4c137e1 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -61,7 +61,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->fclk = fclk;
     s->irq = irq;
     s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
-                               omap_clk_getrate(fclk)/16,
+                               omap_clk_getrate(fclk) / 16,
                                chr ?: qemu_chr_new(label, "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
     return s;
@@ -76,27 +76,27 @@ static uint64_t omap_uart_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (addr) {
-    case 0x20:	/* MDR1 */
+    case 0x20:  /* MDR1 */
         return s->mdr[0];
-    case 0x24:	/* MDR2 */
+    case 0x24:  /* MDR2 */
         return s->mdr[1];
-    case 0x40:	/* SCR */
+    case 0x40:  /* SCR */
         return s->scr;
-    case 0x44:	/* SSR */
+    case 0x44:  /* SSR */
         return 0x0;
-    case 0x48:	/* EBLR (OMAP2) */
+    case 0x48:  /* EBLR (OMAP2) */
         return s->eblr;
-    case 0x4C:	/* OSC_12M_SEL (OMAP1) */
+    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
         return s->clksel;
-    case 0x50:	/* MVR */
+    case 0x50:  /* MVR */
         return 0x30;
-    case 0x54:	/* SYSC (OMAP2) */
+    case 0x54:  /* SYSC (OMAP2) */
         return s->syscontrol;
-    case 0x58:	/* SYSS (OMAP2) */
+    case 0x58:  /* SYSS (OMAP2) */
         return 1;
-    case 0x5c:	/* WER (OMAP2) */
+    case 0x5c:  /* WER (OMAP2) */
         return s->wkup;
-    case 0x60:	/* CFPS (OMAP2) */
+    case 0x60:  /* CFPS (OMAP2) */
         return s->cfps;
     }
 
@@ -115,35 +115,36 @@ static void omap_uart_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x20:	/* MDR1 */
+    case 0x20:  /* MDR1 */
         s->mdr[0] = value & 0x7f;
         break;
-    case 0x24:	/* MDR2 */
+    case 0x24:  /* MDR2 */
         s->mdr[1] = value & 0xff;
         break;
-    case 0x40:	/* SCR */
+    case 0x40:  /* SCR */
         s->scr = value & 0xff;
         break;
-    case 0x48:	/* EBLR (OMAP2) */
+    case 0x48:  /* EBLR (OMAP2) */
         s->eblr = value & 0xff;
         break;
-    case 0x4C:	/* OSC_12M_SEL (OMAP1) */
+    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
         s->clksel = value & 1;
         break;
-    case 0x44:	/* SSR */
-    case 0x50:	/* MVR */
-    case 0x58:	/* SYSS (OMAP2) */
+    case 0x44:  /* SSR */
+    case 0x50:  /* MVR */
+    case 0x58:  /* SYSS (OMAP2) */
         OMAP_RO_REG(addr);
         break;
-    case 0x54:	/* SYSC (OMAP2) */
+    case 0x54:  /* SYSC (OMAP2) */
         s->syscontrol = value & 0x1d;
-        if (value & 2)
+        if (value & 2) {
             omap_uart_reset(s);
+        }
         break;
-    case 0x5c:	/* WER (OMAP2) */
+    case 0x5c:  /* WER (OMAP2) */
         s->wkup = value & 0x7f;
         break;
-    case 0x60:	/* CFPS (OMAP2) */
+    case 0x60:  /* CFPS (OMAP2) */
         s->cfps = value & 0xff;
         break;
     default:
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 5884804c589..7342440b958 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -49,19 +49,20 @@ struct ScoopInfo {
     uint16_t isr;
 };
 
-#define SCOOP_MCR	0x00
-#define SCOOP_CDR	0x04
-#define SCOOP_CSR	0x08
-#define SCOOP_CPR	0x0c
-#define SCOOP_CCR	0x10
-#define SCOOP_IRR_IRM	0x14
-#define SCOOP_IMR	0x18
-#define SCOOP_ISR	0x1c
-#define SCOOP_GPCR	0x20
-#define SCOOP_GPWR	0x24
-#define SCOOP_GPRR	0x28
+#define SCOOP_MCR       0x00
+#define SCOOP_CDR       0x04
+#define SCOOP_CSR       0x08
+#define SCOOP_CPR       0x0c
+#define SCOOP_CCR       0x10
+#define SCOOP_IRR_IRM   0x14
+#define SCOOP_IMR       0x18
+#define SCOOP_ISR       0x1c
+#define SCOOP_GPCR      0x20
+#define SCOOP_GPWR      0x24
+#define SCOOP_GPRR      0x28
 
-static inline void scoop_gpio_handler_update(ScoopInfo *s) {
+static inline void scoop_gpio_handler_update(ScoopInfo *s)
+{
     uint32_t level, diff;
     int bit;
     level = s->gpio_level & s->gpio_dir;
@@ -125,8 +126,9 @@ static void scoop_write(void *opaque, hwaddr addr,
         break;
     case SCOOP_CPR:
         s->power = value;
-        if (value & 0x80)
+        if (value & 0x80) {
             s->power |= 0x8040;
+        }
         break;
     case SCOOP_CCR:
         s->ccr = value;
@@ -145,7 +147,7 @@ static void scoop_write(void *opaque, hwaddr addr,
         scoop_gpio_handler_update(s);
         break;
     case SCOOP_GPWR:
-    case SCOOP_GPRR:	/* GPRR is probably R/O in real HW */
+    case SCOOP_GPRR:    /* GPRR is probably R/O in real HW */
         s->gpio_level = value & s->gpio_dir;
         scoop_gpio_handler_update(s);
         break;
@@ -166,10 +168,11 @@ static void scoop_gpio_set(void *opaque, int line, int level)
 {
     ScoopInfo *s = (ScoopInfo *) opaque;
 
-    if (level)
+    if (level) {
         s->gpio_level |= (1 << line);
-    else
+    } else {
         s->gpio_level &= ~(1 << line);
+    }
 }
 
 static void scoop_init(Object *obj)
@@ -203,7 +206,7 @@ static int scoop_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool is_version_0 (void *opaque, int version_id)
+static bool is_version_0(void *opaque, int version_id)
 {
     return version_id == 0;
 }
@@ -265,7 +268,7 @@ type_init(scoop_register_types)
 
 /* Write the bootloader parameters memory area.  */
 
-#define MAGIC_CHG(a, b, c, d)	((d << 24) | (c << 16) | (b << 8) | a)
+#define MAGIC_CHG(a, b, c, d)   ((d << 24) | (c << 16) | (b << 8) | a)
 
 static struct QEMU_PACKED sl_param_info {
     uint32_t comadj_keyword;
@@ -286,16 +289,16 @@ static struct QEMU_PACKED sl_param_info {
     uint32_t phad_keyword;
     int32_t phadadj;
 } zaurus_bootparam = {
-    .comadj_keyword	= MAGIC_CHG('C', 'M', 'A', 'D'),
-    .comadj		= 125,
-    .uuid_keyword	= MAGIC_CHG('U', 'U', 'I', 'D'),
-    .uuid		= { -1 },
-    .touch_keyword	= MAGIC_CHG('T', 'U', 'C', 'H'),
-    .touch_xp		= -1,
-    .adadj_keyword	= MAGIC_CHG('B', 'V', 'A', 'D'),
-    .adadj		= -1,
-    .phad_keyword	= MAGIC_CHG('P', 'H', 'A', 'D'),
-    .phadadj		= 0x01,
+    .comadj_keyword     = MAGIC_CHG('C', 'M', 'A', 'D'),
+    .comadj             = 125,
+    .uuid_keyword       = MAGIC_CHG('U', 'U', 'I', 'D'),
+    .uuid               = { -1 },
+    .touch_keyword      = MAGIC_CHG('T', 'U', 'C', 'H'),
+    .touch_xp           = -1,
+    .adadj_keyword      = MAGIC_CHG('B', 'V', 'A', 'D'),
+    .adadj              = -1,
+    .phad_keyword       = MAGIC_CHG('P', 'H', 'A', 'D'),
+    .phadadj            = 0x01,
 };
 
 void sl_bootparam_write(hwaddr ptr)
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index ac7f54eeafb..54a15d24410 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -28,10 +28,10 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-#define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
+#define TSC_CUT_RESOLUTION(value, p)  ((value) >> (16 - (p ? 12 : 10)))
 
 typedef struct {
-    qemu_irq pint;	/* Combination of the nPENIRQ and DAV signals */
+    qemu_irq pint;  /* Combination of the nPENIRQ and DAV signals */
     QEMUTimer *timer;
     uint16_t model;
 
@@ -63,7 +63,7 @@ typedef struct {
 } TSC2005State;
 
 enum {
-    TSC_MODE_XYZ_SCAN	= 0x0,
+    TSC_MODE_XYZ_SCAN = 0x0,
     TSC_MODE_XY_SCAN,
     TSC_MODE_X,
     TSC_MODE_Y,
@@ -82,100 +82,100 @@ enum {
 };
 
 static const uint16_t mode_regs[16] = {
-    0xf000,	/* X, Y, Z scan */
-    0xc000,	/* X, Y scan */
-    0x8000,	/* X */
-    0x4000,	/* Y */
-    0x3000,	/* Z */
-    0x0800,	/* AUX */
-    0x0400,	/* TEMP1 */
-    0x0200,	/* TEMP2 */
-    0x0800,	/* AUX scan */
-    0x0040,	/* X test */
-    0x0020,	/* Y test */
-    0x0080,	/* Short-circuit test */
-    0x0000,	/* Reserved */
-    0x0000,	/* X+, X- drivers */
-    0x0000,	/* Y+, Y- drivers */
-    0x0000,	/* Y+, X- drivers */
+    0xf000, /* X, Y, Z scan */
+    0xc000, /* X, Y scan */
+    0x8000, /* X */
+    0x4000, /* Y */
+    0x3000, /* Z */
+    0x0800, /* AUX */
+    0x0400, /* TEMP1 */
+    0x0200, /* TEMP2 */
+    0x0800, /* AUX scan */
+    0x0040, /* X test */
+    0x0020, /* Y test */
+    0x0080, /* Short-circuit test */
+    0x0000, /* Reserved */
+    0x0000, /* X+, X- drivers */
+    0x0000, /* Y+, Y- drivers */
+    0x0000, /* Y+, X- drivers */
 };
 
-#define X_TRANSFORM(s)			\
+#define X_TRANSFORM(s)      \
     ((s->y * s->tr[0] - s->x * s->tr[1]) / s->tr[2] + s->tr[3])
-#define Y_TRANSFORM(s)			\
+#define Y_TRANSFORM(s)      \
     ((s->y * s->tr[4] - s->x * s->tr[5]) / s->tr[6] + s->tr[7])
-#define Z1_TRANSFORM(s)			\
+#define Z1_TRANSFORM(s)     \
     ((400 - ((s)->x >> 7) + ((s)->pressure << 10)) << 4)
-#define Z2_TRANSFORM(s)			\
+#define Z2_TRANSFORM(s)     \
     ((4000 + ((s)->y >> 7) - ((s)->pressure << 10)) << 4)
 
-#define AUX_VAL				(700 << 4)	/* +/- 3 at 12-bit */
-#define TEMP1_VAL			(1264 << 4)	/* +/- 5 at 12-bit */
-#define TEMP2_VAL			(1531 << 4)	/* +/- 5 at 12-bit */
+#define AUX_VAL       (700 << 4)  /* +/- 3 at 12-bit */
+#define TEMP1_VAL     (1264 << 4) /* +/- 5 at 12-bit */
+#define TEMP2_VAL     (1531 << 4) /* +/- 5 at 12-bit */
 
 static uint16_t tsc2005_read(TSC2005State *s, int reg)
 {
     uint16_t ret;
 
     switch (reg) {
-    case 0x0:	/* X */
+    case 0x0: /* X */
         s->dav &= ~mode_regs[TSC_MODE_X];
         return TSC_CUT_RESOLUTION(X_TRANSFORM(s), s->precision) +
                 (s->noise & 3);
-    case 0x1:	/* Y */
+    case 0x1: /* Y */
         s->dav &= ~mode_regs[TSC_MODE_Y];
-        s->noise ++;
+        s->noise++;
         return TSC_CUT_RESOLUTION(Y_TRANSFORM(s), s->precision) ^
                 (s->noise & 3);
-    case 0x2:	/* Z1 */
+    case 0x2: /* Z1 */
         s->dav &= 0xdfff;
         return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s->precision) -
                 (s->noise & 3);
-    case 0x3:	/* Z2 */
+    case 0x3: /* Z2 */
         s->dav &= 0xefff;
         return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s->precision) |
                 (s->noise & 3);
 
-    case 0x4:	/* AUX */
+    case 0x4: /* AUX */
         s->dav &= ~mode_regs[TSC_MODE_AUX];
         return TSC_CUT_RESOLUTION(AUX_VAL, s->precision);
 
-    case 0x5:	/* TEMP1 */
+    case 0x5: /* TEMP1 */
         s->dav &= ~mode_regs[TSC_MODE_TEMP1];
         return TSC_CUT_RESOLUTION(TEMP1_VAL, s->precision) -
                 (s->noise & 5);
-    case 0x6:	/* TEMP2 */
+    case 0x6: /* TEMP2 */
         s->dav &= 0xdfff;
         s->dav &= ~mode_regs[TSC_MODE_TEMP2];
         return TSC_CUT_RESOLUTION(TEMP2_VAL, s->precision) ^
                 (s->noise & 3);
 
-    case 0x7:	/* Status */
+    case 0x7: /* Status */
         ret = s->dav | (s->reset << 7) | (s->pdst << 2) | 0x0;
         s->dav &= ~(mode_regs[TSC_MODE_X_TEST] | mode_regs[TSC_MODE_Y_TEST] |
                         mode_regs[TSC_MODE_TS_TEST]);
         s->reset = true;
         return ret;
 
-    case 0x8:   /* AUX high threshold */
+    case 0x8: /* AUX high threshold */
         return s->aux_thr[1];
-    case 0x9:   /* AUX low threshold */
+    case 0x9: /* AUX low threshold */
         return s->aux_thr[0];
 
-    case 0xa:   /* TEMP high threshold */
+    case 0xa: /* TEMP high threshold */
         return s->temp_thr[1];
-    case 0xb:   /* TEMP low threshold */
+    case 0xb: /* TEMP low threshold */
         return s->temp_thr[0];
 
-    case 0xc:	/* CFR0 */
+    case 0xc: /* CFR0 */
         return (s->pressure << 15) | ((!s->busy) << 14) |
-                (s->nextprecision << 13) | s->timing[0]; 
-    case 0xd:	/* CFR1 */
+                (s->nextprecision << 13) | s->timing[0];
+    case 0xd: /* CFR1 */
         return s->timing[1];
-    case 0xe:	/* CFR2 */
+    case 0xe: /* CFR2 */
         return (s->pin_func << 14) | s->filter;
 
-    case 0xf:	/* Function select status */
+    case 0xf: /* Function select status */
         return s->function >= 0 ? 1 << s->function : 0;
     }
 
@@ -200,13 +200,14 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         s->temp_thr[0] = data;
         break;
 
-    case 0xc:	/* CFR0 */
+    case 0xc: /* CFR0 */
         s->host_mode = (data >> 15) != 0;
         if (s->enabled != !(data & 0x4000)) {
             s->enabled = !(data & 0x4000);
             trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
-            if (s->busy && !s->enabled)
+            if (s->busy && !s->enabled) {
                 timer_del(s->timer);
+            }
             s->busy = s->busy && s->enabled;
         }
         s->nextprecision = (data >> 13) & 1;
@@ -216,10 +217,10 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
                           "tsc2005_write: illegal conversion clock setting\n");
         }
         break;
-    case 0xd:	/* CFR1 */
+    case 0xd: /* CFR1 */
         s->timing[1] = data & 0xf07;
         break;
-    case 0xe:	/* CFR2 */
+    case 0xe: /* CFR2 */
         s->pin_func = (data >> 14) & 3;
         s->filter = data & 0x3fff;
         break;
@@ -258,10 +259,12 @@ static void tsc2005_pin_update(TSC2005State *s)
     switch (s->nextfunction) {
     case TSC_MODE_XYZ_SCAN:
     case TSC_MODE_XY_SCAN:
-        if (!s->host_mode && s->dav)
+        if (!s->host_mode && s->dav) {
             s->enabled = false;
-        if (!s->pressure)
+        }
+        if (!s->pressure) {
             return;
+        }
         /* Fall through */
     case TSC_MODE_AUX_SCAN:
         break;
@@ -269,8 +272,9 @@ static void tsc2005_pin_update(TSC2005State *s)
     case TSC_MODE_X:
     case TSC_MODE_Y:
     case TSC_MODE_Z:
-        if (!s->pressure)
+        if (!s->pressure) {
             return;
+        }
         /* Fall through */
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
@@ -278,8 +282,9 @@ static void tsc2005_pin_update(TSC2005State *s)
     case TSC_MODE_X_TEST:
     case TSC_MODE_Y_TEST:
     case TSC_MODE_TS_TEST:
-        if (s->dav)
+        if (s->dav) {
             s->enabled = false;
+        }
         break;
 
     case TSC_MODE_RESERVED:
@@ -290,13 +295,14 @@ static void tsc2005_pin_update(TSC2005State *s)
         return;
     }
 
-    if (!s->enabled || s->busy)
+    if (!s->enabled || s->busy) {
         return;
+    }
 
     s->busy = true;
     s->precision = s->nextprecision;
     s->function = s->nextfunction;
-    s->pdst = !s->pnd0;	/* Synchronised on internal clock */
+    s->pdst = !s->pnd0; /* Synchronised on internal clock */
     expires = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
         (NANOSECONDS_PER_SECOND >> 7);
     timer_mod(s->timer, expires);
@@ -331,7 +337,7 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
     TSC2005State *s = opaque;
     uint32_t ret = 0;
 
-    switch (s->state ++) {
+    switch (s->state++) {
     case 0:
         if (value & 0x80) {
             /* Command */
@@ -343,8 +349,9 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
                 if (s->enabled != !(value & 1)) {
                     s->enabled = !(value & 1);
                     trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
-                    if (s->busy && !s->enabled)
+                    if (s->busy && !s->enabled) {
                         timer_del(s->timer);
+                    }
                     s->busy = s->busy && s->enabled;
                 }
                 tsc2005_pin_update(s);
@@ -368,10 +375,11 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
         break;
 
     case 1:
-        if (s->command)
+        if (s->command) {
             ret = (s->data >> 8) & 0xff;
-        else
+        } else {
             s->data |= value << 8;
+        }
         break;
 
     case 2:
@@ -412,8 +420,9 @@ static void tsc2005_timer_tick(void *opaque)
 
     /* Timer ticked -- a set of conversions has been finished.  */
 
-    if (!s->busy)
+    if (!s->busy) {
         return;
+    }
 
     s->busy = false;
     s->dav |= mode_regs[function];
@@ -438,8 +447,9 @@ static void tsc2005_touchscreen_event(void *opaque,
      * signaling TS events immediately, but for now we simulate
      * the first conversion delay for sake of correctness.
      */
-    if (p != s->pressure)
+    if (p != s->pressure) {
         tsc2005_pin_update(s);
+    }
 }
 
 static int tsc2005_post_load(void *opaque, int version_id)
-- 
2.34.1


