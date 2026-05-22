Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886DCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDOl-00031c-3U; Thu, 21 May 2026 20:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNy-0002PH-90
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:09 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNq-00040B-QR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so43977795ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408297; x=1780013097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpKQmCzdzg3fotqF1bomQ3jmeLPsPlAsYk7oZ3kgloI=;
 b=qViZkPcxX1n50i62vMwNlbV40XF5v8yFfFte2kKxyMxXP5D/tJWUarFaATxvZefcZZ
 RE/U+XpnHGgYsWoX0uppabVrB8MdSzi90NCifgRBSeYpMdDVnkwsab7adiHNBq3iW8iC
 giGS5th24lELRX+EpGQ/Aua7qwXNjkiEZlM8iZnXK0t3Nf1f+q3R7fcp9pzVxnIt0bK7
 Q6wIobHicMi9ez38fkhTujkWHbsg2Nf/KJMZWMjOxI6jifq4Zlw+1HaF7Ji2gG3+KYR6
 1puVAN/UA9sAQzWmYDgIq82u5gaB5GgP34tPjdiB+vNIClbw4YkHL7tTGfl5P0z+YnNb
 +QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408297; x=1780013097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpKQmCzdzg3fotqF1bomQ3jmeLPsPlAsYk7oZ3kgloI=;
 b=ZLO3+oxgH31mXCbs3pSyJMqPE2HSI7iasTKzEvTBeaL5lQJ9XKG8XruQ3alRZY/b0o
 70JOu5jeMZsVjDNBz8JCtEOlVZg+gUjSSZnnAYDj/cgevNZ9xU5Rq4Oh9iJ3cnndYvgq
 XNPYAG110vf3Gy3/ric7aoYGenaMQxQsyCtDgaCw3dWluJU1G8zwjI3Blkb6YCl2CMYS
 6T2sJOn77FH3QEZCFUkOVteiFCsJHelfd4rycU5n6FzP/AdMTk574AMBR5yEWfKsA7oz
 sXAp3kIfCD0I8tx+pb2ksb7G4lpmmg2BTzRBM+iGPrzonYy7Lw0GdWJiL5fWmX6JcSqK
 2V2g==
X-Gm-Message-State: AOJu0Ywl0HY42e5iacSmQSBwuAdefcnc+5QTwf9+Bl5zO/GRAkkT1ydA
 U17fjMoiV/Ze/xrhsWYjcA1zZIwFy5wSOWWanBOjTaoz+9CWeXmnhv23wePtYUjS
X-Gm-Gg: Acq92OHHNCfR0x0qZ4WHutM6TDgVy/aSZ2LH9T/YLO987N/T4qJL1+n7RT2HKbcFYUI
 eIYFbiArciYFej3bPkDHVQbyiAO4tkB/5GRERkZXSjw7QwoVglKS55ITZpiC37JyGvBgwF70pLo
 Zko5G40N+EKCI2U0SRWWvJC/q7hz1JU7IBVHIpjL53YhDMm/Y0gz4LXgk1HUnt/2RqpIRp/5mA9
 MaT/P8gPJ2Z6E177gflDyqEEu5nsz+58D+hGDqvj5wdmc/9trQBTbsKDWLtl4UNCpYY3b9vfCXM
 d6cP/B+m9KXWVWcGfWhAOE5qtYrlAsedumroC+cTy0cqJBWFU8orwNwxkvyGLpq7oGrDEpr79A2
 yKo+N/Ty8b4mQ9BRf4AcT34SmgHYgvNfoV2w/4UmqhukeYEURyChzv1SyAvoMi/umDsmsoADSGH
 TYGhLbeTlljeMM7IEoH7H0dbpe/O4e5WhRllkRd7ef4A==
X-Received: by 2002:a17:903:3bcf:b0:2ba:df8c:11d3 with SMTP id
 d9443c01a7336-2beb06c0336mr10893845ad.32.1779408296946; 
 Thu, 21 May 2026 17:04:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/48] hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg
 clock dividers
Date: Fri, 22 May 2026 10:03:01 +1000
Message-ID: <20260522000324.23255-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

Minimal clock register configuration required to boot Linux
without backtraces in the clock code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514-reference-overhand-749149e36a88@spud>
[ Changes by AF:
 - Fixup checkpatch errors
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 47 +++++++++++++++++++++++++++++-
 hw/misc/mchp_pfsoc_sysreg.c        | 13 +++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index eaaa2ac5d9..9687ea25b1 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -35,6 +35,8 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion mailbox;
     MemoryRegion cfg;
     MemoryRegion ccc;
+    MemoryRegion pll_nw_0;
+    MemoryRegion pll_nw_1;
     MemoryRegion pll_mss;
     MemoryRegion cfm_mss;
     MemoryRegion pll_ddr;
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 05538d012a..09b702e520 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -53,6 +53,8 @@
 #define IOSCB_MAILBOX_BASE          0x07020800
 #define IOSCB_CFG_BASE              0x07080000
 #define IOSCB_CCC_BASE              0x08000000
+#define IOSCB_PLL_NW0_BASE          0x08100000
+#define IOSCB_PLL_NW1_BASE          0x08200000
 #define IOSCB_PLL_MSS_BASE          0x0E001000
 #define IOSCB_CFM_MSS_BASE          0x0E002000
 #define IOSCB_PLL_DDR_BASE          0x0E010000
@@ -92,6 +94,16 @@ static const MemoryRegionOps mchp_pfsoc_dummy_ops = {
 /* All PLL modules in IOSCB have the same register layout */
 
 #define PLL_CTRL    0x04
+#define PLL_REF_FB  0x08
+#define PLL_DIV_0_1 0x10
+#define PLL_DIV_2_3 0x14
+#define PLL_CTRL2   0x18
+#define PLL_CAL     0x1c
+#define PLL_PHADJ   0x20
+#define SSCG_REG_0  0x24
+#define SSCG_REG_1  0x28
+#define SSCG_REG_2  0x2c
+#define SSCG_REG_3  0x30
 
 static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
                                     unsigned size)
@@ -103,6 +115,22 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
         /* PLL is locked */
         val = BIT(25);
         break;
+    case PLL_DIV_0_1:
+    case PLL_DIV_2_3:
+        val = 0x01000100; /* return valid post divider values */
+        break;
+    case PLL_CTRL2:
+        val = 0x00001110;
+        break;
+    case PLL_REF_FB:
+        val = 0x00000100; /* RFDIV := 1 */
+        break;
+    case SSCG_REG_2:
+        val = 0x00000001; /* INTIN := 1 */
+        break;
+    case PLL_PHADJ:
+        val = 0x00000401;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
@@ -113,9 +141,18 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static void mchp_pfsoc_pll_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                       "(size %d, value 0x%" PRIx64
+                       ", offset 0x%" HWADDR_PRIx ")\n",
+                       __func__, size, value, offset);
+}
+
 static const MemoryRegionOps mchp_pfsoc_pll_ops = {
     .read = mchp_pfsoc_pll_read,
-    .write = mchp_pfsoc_dummy_write,
+    .write = mchp_pfsoc_pll_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -240,6 +277,14 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.ccc", IOSCB_CCC_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_CCC_BASE, &s->ccc);
 
+    memory_region_init_io(&s->pll_nw_0, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_nw_0", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_NW0_BASE, &s->pll_nw_0);
+
+    memory_region_init_io(&s->pll_nw_1, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_nw_1", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_NW1_BASE, &s->pll_nw_1);
+
     memory_region_init_io(&s->pll_mss, OBJECT(s), &mchp_pfsoc_pll_ops, s,
                           "mchp.pfsoc.ioscb.pll_mss", IOSCB_SUBMOD_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_PLL_MSS_BASE, &s->pll_mss);
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index f190ecc78e..1d9154280a 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -29,6 +29,8 @@
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
 
+#define CLOCK_CONFIG_CR 0x8
+#define RTC_CLOCK_CR    0xc
 #define MSS_RESET_CR    0x18
 #define ENVM_CR         0xb8
 #define MESSAGE_INT     0x118c
@@ -39,6 +41,17 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
     uint32_t val = 0;
 
     switch (offset) {
+    case CLOCK_CONFIG_CR:
+        /* Icicle kit reference design cpu/axi/ahb divider setting */
+        val = 0x24;
+        break;
+    case RTC_CLOCK_CR:
+        /*
+         * Bit 16 enables the RTC clock, 0x7d is the required divider
+         * setting for a 125 MHz reference.
+         */
+        val = BIT(16) | 0x7d;
+        break;
     case ENVM_CR:
         /* Indicate the eNVM is running at the configured divider rate */
         val = BIT(6);
-- 
2.53.0


