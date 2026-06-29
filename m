Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBEC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfx-00071V-5n; Mon, 29 Jun 2026 08:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfI-0006pR-Px
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfF-0007Gk-HU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so1874336f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734436; x=1783339236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LyhKlDdDcEZAv6sqTUFEF9PTo3TL06w67QzpnS1/n9k=;
 b=yeaH4pZpAPYIH96HztRd7Z4tWL0KKYjA35JWYekdQ3NBk0yO9DjsdFwXMq9dnlO1Xl
 RPBrNZxaBuZsUrmGjHi8B9hXK94oZiD8TYsLt5Ib1nc+mUGkgNyzTBes99hcJsdhoNgN
 VH01nXBCt2W9KpEejfTf6EZr5CoGlhaunVl+JC5NCY1bdx3Q5s3lQd6DuWgUAkLbtqG2
 EsDGNvFsuyB4MfsWlmvRI1VLdO8YbLsBBixEFl4ROrkCfKPqIldVr8aTROt/z8znQC26
 P9xPTuedBKRwp7a7obLNLeTUhmoBSP2Hgll6U19intTQ/jNDpgZNO3ka7YLsDmtXr0gN
 n57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734436; x=1783339236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LyhKlDdDcEZAv6sqTUFEF9PTo3TL06w67QzpnS1/n9k=;
 b=NUejq6nlBcKDy6WGnRJY6p4EWKZG80LOO3VHrDsbmAjZ6fGIRfmeFUSr1UaGa6hyfD
 vlFtHi7/Yh8wY+FoDw1hbb5L0EKbK7Q88pkkDFRN3Fgi6/iGEsOpvncm9ig8qmsfl2xk
 8mPrkvcXJ1EjHegs4gxHFCGfa6z6pJ8nSCTPLeyq3YNyXCGPYq5a5UnwSf+30jsqP6Dq
 1/lg8aJqIzsuM81b/C7NTUMf5GfkVJ2tqTOm2Pqo5khiyhRnhykscrimmTRA1Pr8DNd2
 6Oh4IV6oyChIdMC8zsv0RJ7s8SAakJXXo1Y0fXZNtkcjLjt9Dfsbzo/qJS+7ghqFPIyx
 I7wg==
X-Gm-Message-State: AOJu0YynfIU3yCGuKkjzrf98gDw1wHE7vW2i5YnwprLo9eIQwQbisFDU
 Qc2StI60mT5VKmvsiGQZMXUQJH5iJB67JCQc38g9vVnwWyEJKgWm+qYzsHCef7ecEaxa3QLkiY3
 8Mc2Q
X-Gm-Gg: AfdE7ckocnr8QglbEI/chhdQsbCD62YP4iUK300PjpO/Oxrq4LLj+KXhBYkKYYGAanO
 YKKZr40gTLUCWVxOsPHvmnrJf3uZFhZQD/MtiR/7evTm198uJkmW51m4Opdei05bAf/MvoL8UQN
 G/jb9/8Z1sfCDXixzoKaU5bvi8ZRL9Qwkz/Mgys43mjMjFNEs9VzSpoZnsR5a/PTJ0wOrkqrGvQ
 jos9EmVetuTz/UgQUljsHc/7SzgssaDTXIXZITBfe/cg8dGbnzaPXcCAg8Q+TQTpOszZQyFkZHO
 X9/mFqGOiKhg/kWm6f4OKeGSkB0ZrYfJVX8mGLvt8ETw8QAa4zXc2PhAM5NoPDyK6VSqN34H74V
 E1QnkBORQpuf8yDZ+9yvPv1I6LRdqJ8+wgyT0pXrVJDH5+9WY6sPjiDW+erZnxc3AoCedb12pJ8
 MO6yzuwNZi6FSY7QSqSHVPzewpGRD95nOBaCEB21Wz+nXoe2rvvKdSxIO5k3bSX999cJ7PYcfO/
 9raPmjNXOWE3epr+3HJ9w==
X-Received: by 2002:a05:600c:46d5:b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-493b718fb6emr8183305e9.8.1782734435766; 
 Mon, 29 Jun 2026 05:00:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/54] hw/timer/imx_epit: Replace DPRINTF with trace events
Date: Mon, 29 Jun 2026 12:59:39 +0100
Message-ID: <20260629120032.1645265-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

From: jack wang <163wangjack@gmail.com>

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: jack wang <163wangjack@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260617161406.14705-1-163wangjack@gmail.com
[PMM: remove stray blank lines from bottom of trace-events file]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/imx_epit.c   | 25 +++++--------------------
 hw/timer/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index c67a39f10c..374ec7d324 100644
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
+    trace_imx_epit_write(imx_epit_reg_name(offset >> 2), value);
 
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
index ac5afe84e8..634ba1da27 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -122,3 +122,9 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
+
+# imx_epit.c
+imx_epit_get_freq(uint32_t freq) "ptimer frequency is %u"
+imx_epit_read(const char *name, uint32_t value) "(%s) = 0x%08x"
+imx_epit_write(const char *name, uint64_t value) "(%s, value = 0x%08" PRIx64 ")"
+imx_epit_cmp(uint32_t sr) "sr was %d"
-- 
2.43.0


