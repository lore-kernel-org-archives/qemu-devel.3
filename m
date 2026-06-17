Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5424ECD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoyw-0004Ew-Be; Wed, 17 Jun 2026 08:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZorK-0002KW-Lq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:55:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZorH-0005z7-K8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:55:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c40397e3caso54817565ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781697302; x=1782302102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HuoZ1XF/SGtRMQNUv5o7lgVgKw3GW1pchp5QRRK8IPk=;
 b=Zr4yCHxfwQKuphQl9w5v0iw1P1Oebhg52X/S9tY/9ty663qA/73EhVo7tHrHWp6GiU
 EHHIpieQ+ymYPslVbYeCmO8pdHgS+nyqqq4+RvTGn8ZZhhSJuL0N1OBu25vDujZzlebX
 K/537d9lcJd5I+g6zq0E8A9oY6J+fm3RTSsj5ZfL27NVbKZrqOPXl4Sdba9Oq+Vb8Ggu
 nzTVe1xCm4K/j8Lxq1uJD3Hi3wjzOqauF4S01w1+I4lrjrfoWB/Q6m5cH3N2RuV6MOzy
 WjQAPTa7ROOCq2LKjiGEJA/TmqKRyPojmD7FmIkW1sLA/NoRFow7liQ7zlK+FukcfG7E
 573w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781697302; x=1782302102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuoZ1XF/SGtRMQNUv5o7lgVgKw3GW1pchp5QRRK8IPk=;
 b=My3ntG21bHAjOsAHZ9ked65s/Rzo0sm0KLWyh3nE7MKpy9oVhzudV/pRXCxR2eQ4Di
 YfhJ3Ve/0OoSIanuDioPBJ/6/p5KsHicFAT4V0mipFL8MxQJcvplHtLgU6pB0+iTNqa9
 jYFrGkM+V3zEDPAL5b1IE2YzbCgqE0K2tOy5C0MFbY/Mp7dRqpuq07RrbA1sbGnYPAC3
 GczONyQQoFMLDWqrmTOlv6A7wvDQOrRv4PDRANJYgIAaP41rNrmoBdUYaarzxBEOtjhH
 aWxQinPw+GfTNRCHoAKIk3ffLOw6tMLMiZ+ZSSqIzasdXrN5/YJpRwOK2KmRtGj8h+Iz
 27AA==
X-Gm-Message-State: AOJu0Yxj3XfhndRN8HEN9NJK+aGLNZAwtlFzmZIzq6aFc0GcTdkd2xqY
 rKTXp6Vko1HPI0goqcyck53tELmTpx5BJLmFOf+rNbxT4YBTE4l4K5nA2TrPCg==
X-Gm-Gg: AfdE7cn0yAMTHRS63O0P2LWIaZ1t/WYV99qMAaqGKnpTsNu9j8VdDl9CcSmUdTTGB+P
 Rd2PV8y5Olqqu2seIDSWIaUWHEmEdMBm1msvCeyJZ7Vm6nXIfviHvW3/fQZnyshphqh+oM9VXt5
 7M2jWAFjMMJMjOi/1/tUSbMElfk8nOteIXsFH9xxhyYy1i1dsGYiLWs99/0U9HoImukghFZP4Zi
 m+BpbN3Z1gC5dSIy4YysOlq2+LMDTozSh9rsYvAhAQw7CBVbk/c9nQl0izhuECTnenEj1pFZJYi
 xvp8Qr8pj9fi7LiX0x0jyERxQD0pTd5ovJeDYVzIpd0J5xdoO27M2HP4aG0m1sFiTWzeCLX7Cxh
 AMwJaAZgXzDX3uhunOA3b3rlx79SycJRM+BOjhoiszOrn2VylDj4WDsHAohXVERqNoZ62EcA2xp
 Tec2wQNzqyzZHcLY9qBvrK+Q2g
X-Received: by 2002:a17:902:f609:b0:2c1:b8af:18ab with SMTP id
 d9443c01a7336-2c6bc20b7f0mr36324575ad.19.1781697301939; 
 Wed, 17 Jun 2026 04:55:01 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f1f1014sm163576605ad.16.2026.06.17.04.54.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 04:55:01 -0700 (PDT)
From: jw_mac <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 jw_mac <77239050qq@gmail.com>, Wang <163wangjack@gamil.com>
Subject: [PATCH trivial] Signed-off-by: jw_mac <163wangjack@gamil.com>
Date: Wed, 17 Jun 2026 19:54:41 +0800
Message-ID: <20260617115442.91715-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:02:38 -0400
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

From: jw_mac <77239050qq@gmail.com>

hw/timer/imx_epit: Replace DPRINTF with trace events

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: Wang <163wangjack@gamil.com>
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


