Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8515CD98F5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoyk-00046U-H7; Wed, 17 Jun 2026 08:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZomB-0000rJ-KQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:49:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZomA-0003cd-2F
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:49:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bf30d530bdso56547915ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781696984; x=1782301784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HuoZ1XF/SGtRMQNUv5o7lgVgKw3GW1pchp5QRRK8IPk=;
 b=Yukfyo4u71NPca1lFCyFX20MtuBdeE+0BSBxKb9Vfss7mieu1D5W8MeQTi368PToEX
 hE4fdYaK/VGuE854KL4RVKH7wY0YDgFmg3pMjNDe4S96BdNzzeasiO9U4pldIOmXU9SC
 OSNCC8oXqdlZV4hqGwq6jJ5pdQ20o+6OSWf7aEqOEIV0NSjrc40b/nSc4qDjdVEWvXvt
 RtxHMs14vBi0Eiqi+df/HBPWnQgC3kXpAX60hNIu1j8cKIR+98ja/fiLZgzBufyMrEsZ
 Rt+yW54FIYZ29wPeNI0RYITY3p4Y17bxDmQM9ZwJ4Hn1QdIbEqaAP1mjdk8B0GyG9tQN
 4+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696984; x=1782301784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuoZ1XF/SGtRMQNUv5o7lgVgKw3GW1pchp5QRRK8IPk=;
 b=r8uA04A1sOSwxMRArJERvPODExwh3C5g/XbkeAlx7IzGin6buMpYPhQ0LCTlKVFQ5t
 b+KgH9AlPFlvV3ppnCrXzz7IEsOCrSd5+BxyzKK+qGX0vxbwxbNUw/cPOttZ1cG7eMJc
 tnlMTVuevt5OvZImtC/9a5b+3E9uz0VFj7Nir2sxpkAelW3qRPTY2L6YEXFH6SE+BPFY
 CnPpNSYdV3f53bXI8gBQ1Qk9bhFa9hor0j8KFKkEubRcv69uLie5/ax2muGpgMJcnBY1
 N5TJL3zqA73zNvB3Ad4L1+xQir3Kbw5ofcncXtPv9KCdRTOIUcbpIFvlEP3l6PDu2ook
 MQ+w==
X-Gm-Message-State: AOJu0YwjmB0zAJH7BQ4whLBeY0VMLyGRAarVdhYmn2y75eb1B5dSnIab
 fwlG5z55m0no6D7D4GxKElDYXGWUS3efCUrvceH2YgaWJVeIrjAm7zllkmhrPg==
X-Gm-Gg: AfdE7clF+uGzeyn9QgIZVXZ6+uGU/5OZ8g95Md4gc88e+IFdppBK5GYIMXdNvBKZzmu
 A3EsKHcuAhfQpaceazGA2lliZpPIKl/fzrBWCMmzMNifCxWMxEs1DXL2KBAx57VtBmWMC8GSF4j
 eN1JqwxsR3GrSMkffcEhYX2syfRiLBBiRolYkOozIFxg6Kcvr1fmdVA/R8dSmC+6c3K2NuMa3KR
 ZzPeHMU7b9mqAm145qYGvR/i4YijbR/t9hEliXZ5w5Win2KasDzuhjdRwDKNIXfPWJmJrXGNnLz
 mxq9KgOGACn2d8o4LbRtLJe3hjP8O/krWIjCBJBGH16r7h6Hkv0ZmF1NM9ZtQ31EBhjfKgqdPD/
 XZ1Ru96N73qfiNfsuv8lgYTRW9AbS9GIMa+yTxBNAEeCySWLah/CdO3aGpFkjJEhnQLg1EghoBU
 5LofPouSkMOgobeUyxVxowyJhX
X-Received: by 2002:a17:902:da8c:b0:2bf:175a:db61 with SMTP id
 d9443c01a7336-2c6bc099eb7mr33665965ad.7.1781696984033; 
 Wed, 17 Jun 2026 04:49:44 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c43345e3ffsm164290415ad.71.2026.06.17.04.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 04:49:43 -0700 (PDT)
From: jw_mac <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 jw_mac <77239050qq@gmail.com>, Wang <163wangjack@gamil.com>
Subject: [PATCH trivial] Signed-off-by: jw_mac <163wangjack@gamil.com>
Date: Wed, 17 Jun 2026 19:49:12 +0800
Message-ID: <20260617114912.82494-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:02:34 -0400
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


