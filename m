Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824BFCD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZp0q-00071z-I9; Wed, 17 Jun 2026 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZp0m-00070t-6Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:04:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZp0k-0001oU-96
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:04:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36d5fd50d20so4107415a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781697889; x=1782302689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pmyemtd2tBPHiSgwGu31+6185CPgr9ELPJ5HzFh6rR8=;
 b=dV0wBZcgSMhcCsZJrGF5QgFwBbax9bkb0jdl1pJIGsSJUeC8ArW02F8vK5R49Wn9G1
 z6DGUGtPZhJUcNkEYadA85vzI3SnVhauzCE5/MCR4+EBFbytjD8lslgJbwZbHR3F5u3Q
 5RcO/E+CGKAiupqOWxp0GGwGZl1InCUJIdbBN9WN/qmQZ9LT4CO76rS6Z5VtR4oYHYQC
 JkvCiRRK+ceJZi1UwoZSajy062fLWFIA4jFZoAMa8qgw0MFweeHi1lvoTKVLxH2st31+
 DTamfhrWRVEfBxvnuhtr9DitEwV5BwDblplumEe/z12FLZSIedoBeEPF8vTinqaz4Tct
 OP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781697889; x=1782302689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pmyemtd2tBPHiSgwGu31+6185CPgr9ELPJ5HzFh6rR8=;
 b=dDw2v4XU+ctpZuPuQL33B5jvuj9Haw2FjtNfIEbTS1yaZ4VSONV2y9El/dLWKzbZEZ
 T3QPIysdjlS6IfMrqJWOCR/zamzTRjp8YUeLmvyl+qF6jb/COkc7KLDrsLxmpuN6bEzX
 vVy6NxiWQe1RGPgUKDPGRLlf0/vma+Ls0eRpG6Dcf/YLHi2q8RV5bhC5wRLBWl06MecZ
 5hSc4LTYBnCDwtdZI4Yr+K7sUSNqoJ7xX4Rwm+vhKy2yRB734B7xIWNX45F/VlaIYJ/4
 /ht/GXMj7YTfiGQ0L0hKKG5xnnOYC5RSdNIm/FAfXueoGRXhHPOS51YIuPh9ugBEMsPk
 PLZQ==
X-Gm-Message-State: AOJu0Yx/CaTA6/c4O8lw0xS+Y1V5Co70ZC2W+R2uABxPWfmjb7TOPvRn
 cBkwxJIqhvbpdU8po74Z/5MGUVMG4aI7ENBjqARx8cKsO7gcQlr4sy8GcwSAiw==
X-Gm-Gg: AfdE7ckrA0YN/RusMzw1lrVDoFuw/0Vcvf7gz7AdIy1ot04sfEMOWu7QFjbPQ6kt7nk
 4E+biCGE5fX8tBUoAeHQNA23kqbGdsp1KDcUm+xE5kIpIGnOhcWbilog7i5s8FHVifIPV19AAcC
 eTeeKD5TY+ZQ2ZRbo5hanfF1OSOsnm9yK5x19YLc2hPBSiXWse/EzHsiDbsbmWK8tyBpoJFXq07
 wy+djyRmNkEXQsHAkIwlOvqv987UNzHC0+gbduK+SvlPRpe0ULljSck1cXYZYujZWT4VI45V+Al
 V7FjboXOwl/CNeoTsuYyKcXCf4+KuIMnEreSN1uvXjpI7aekfcYb9wJuCLQ6y3Vn1qDNGcvTehX
 jgN2ZGg6mS7QSIekxwhpCaQScJSxPkEb6FsRdhm9OwvCLuPkiohr+AHoyngJ5gPVKfzreKgCrSq
 C9CrVAr8VX61WmlNbvmlD1z4kP
X-Received: by 2002:a17:90b:3f84:b0:369:de03:29c8 with SMTP id
 98e67ed59e1d1-37c9ed01f9bmr3192172a91.23.1781697888749; 
 Wed, 17 Jun 2026 05:04:48 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37cd2ee88ddsm23672a91.2.2026.06.17.05.04.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 05:04:48 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 jack wang <163wangjack@gmail.com>
Subject: [PATCH trivial v3] hw/timer/imx_epit: Replace DPRINTF with trace
 events
Date: Wed, 17 Jun 2026 20:04:29 +0800
Message-ID: <20260617120429.95176-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: jack wang <163wangjack@gmail.com>
---
 hw/timer/imx_epit.c   | 25 +++++--------------------
 hw/timer/trace-events |  8 ++++++++
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index c67a39f10c..476e2771b3 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -20,18 +20,7 @@
 #include "hw/misc/imx_ccm.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-
-#ifndef DEBUG_IMX_EPIT
-#define DEBUG_IMX_EPIT 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_EPIT) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_EPIT, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx_epit_reg_name(uint32_t reg)
 {
@@ -80,7 +69,7 @@ static uint32_t imx_epit_get_freq(IMXEPITState *s)
     uint32_t prescaler = 1 + extract32(s->cr, CR_PRESCALE_SHIFT, CR_PRESCALE_BITS);
     uint32_t f_in = imx_ccm_get_clock_frequency(s->ccm, imx_epit_clocks[clksrc]);
     uint32_t freq = f_in / prescaler;
-    DPRINTF("ptimer frequency is %u\n", freq);
+    trace_imx_epit_get_freq(freq);
     return freq;
 }
 
@@ -146,8 +135,7 @@ static uint64_t imx_epit_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX_EPIT, __func__, offset);
         break;
     }
-
-    DPRINTF("(%s) = 0x%08x\n", imx_epit_reg_name(offset >> 2), reg_value);
+    trace_imx_epit_read(imx_epit_reg_name(offset >> 2), reg_value);
 
     return reg_value;
 }
@@ -328,8 +316,7 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMXEPITState *s = IMX_EPIT(opaque);
 
-    DPRINTF("(%s, value = 0x%08x)\n", imx_epit_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx_epit_write(imx_epit_reg_name(offset >> 2), (uint32_t)value);
 
     switch (offset >> 2) {
     case 0: /* CR */
@@ -362,7 +349,7 @@ static void imx_epit_cmp(void *opaque)
     /* The cmp ptimer can't be running when the peripheral is disabled */
     assert(s->cr & CR_EN);
 
-    DPRINTF("sr was %d\n", s->sr);
+    trace_imx_epit_cmp(s->sr);
     /* Set interrupt status bit SR.OCIF and update the interrupt state */
     s->sr |= SR_OCIF;
     imx_epit_update_int(s);
@@ -399,8 +386,6 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
     IMXEPITState *s = IMX_EPIT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    DPRINTF("\n");
-
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_epit_ops, s, TYPE_IMX_EPIT,
                           0x00001000);
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index ac5afe84e8..3c282800c6 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -122,3 +122,11 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
+
+# imx_epit.c
+imx_epit_get_freq(uint32_t freq) "ptimer frequency is %u"
+imx_epit_read(const char *name, uint32_t value) "(%s) = 0x%08x"
+imx_epit_write(const char *name, uint32_t value) "(%s, value = 0x%08x)"
+imx_epit_cmp(uint32_t sr) "sr was %d"
+
+
-- 
2.53.0


