Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8D8CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmWu-0007Xu-6N; Thu, 25 Jun 2026 12:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWs-0007T3-5H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:14 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWq-0006Yr-2s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:13 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c88e3e82d81so12951a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782403331; x=1783008131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYqeGOOKD55RKQc/1pd1ELcCZGaTrj86Fmjnba5w4Eo=;
 b=nf7zWj4AHH9VVnewtzO0LnSnFD5wunpOqolNw6JQwlaujJ3WpT3XsT72sgTLfZlciR
 hY/t3DZWKg5BbDVE+7j+Ej61ArM9PC22qnUm2D0vt3VPt93Up5kSiEjn1PVqqZeGHO86
 yzD9Z+jUqfhm90Xmw0DvFqD3inDCmpW9+tOiAqV3zb9wA9pO7EzPG18Jk5eKJhuKdbzK
 t+GN7/7wHW9c4zeYquwjTnY0oJWHfcrc714fdHTPNm3KUccGpPneHOsjHskpoub3OSqA
 Akl30QQaCdzK6z+Gz1d1eyb9XYLffgNglqyo0ku+La1ELcBuPnR1iDvQmDTW0hg/28BH
 0QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403331; x=1783008131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MYqeGOOKD55RKQc/1pd1ELcCZGaTrj86Fmjnba5w4Eo=;
 b=Fg3DXiciS5hCJ9hajalncey/Kvy176GWSTKTg/HcjeIBpZA48ihHmTlgHmP4h+Pz82
 NxICCmNTbeXgiqm4V56gyIKX0hXWH/li5udfEtWXuIRVl/NDjX4XEFCVA2/N2kqKkoxQ
 q5nL1KTEBtJaFMhfymcCaIJJp2DylX8/JeMVBC3z56IhJ/AKcdpt7l7sRV5yH1HGmHB3
 tar/xRGRCOXP/uIQXMQE7OFRcxWl7Bxq3gW/BimoiExBAaUjxhlbn2Xj8uezRngUdQv9
 AnMtmD2YfPsfMM7dX76QMy43heghYUnUK68GIQgwE91HiUlv/Lj/zskUDGCGzvQX8cbd
 L90w==
X-Gm-Message-State: AOJu0YwoCz4BTV6CU8QAQDzbx3NC0ZNt7OPBdDAoMXAd64y4VQg9gJMC
 uzqev5+fFSf5ZgqbfZmda3XB2DaSBqpqW+Br8AB9+rXIOfi3ht0fsbaoCU6WM+HCTWs=
X-Gm-Gg: AfdE7cn0xuvxpMG1/OCyLu+VwEB9dnd0XQi2RHoPiP1ZzpeoOtOQ5IRwyxyxNEH4WmF
 Lpb3BwdiId5uB5uznh/mhMuqj9gcFIDptn1vgYNjtGqq61TouBAubhpCezhz5j60+51sbfo2hLO
 54ChspUhouTOD/0BpgWltIAkq8cZ7IAGeZAUgyJNbjHvG3VsW09x5AmRWPyhf9RICfOEFhGn6EO
 8t58gWmOm4TVDljRH+KE7OWrTqlg10posJVSLLwHkVxvAayERvINhARTPd0J/vIK9aL9wruU/do
 QtbP+gVz2P6aNzwXo0AM/oS+qoDhCLSsLbOhogZ9Bn4UpQ/YuPVPNb/Mk07I1nFecmEoW6a9nkG
 LKyzxCj/5HwDC+R9/sIiDgCUU254rEPHr2IQi+ALLtZXSB5LyL1mmzkXRA134mzEz+DpdT+a0u0
 8ZZMX22sMThXcYjGFEHLTKlA0bSxI=
X-Received: by 2002:a05:6a20:734c:b0:3b4:65ac:e2e6 with SMTP id
 adf61e73a8af0-3bd4b239a52mr3736512637.36.1782403330185; 
 Thu, 25 Jun 2026 09:02:10 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92bcb9c14asm1924522a12.24.2026.06.25.09.02.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:02:09 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-arm@nongnu.org (open list:i.MX25 PDK)
Subject: [PATCH v2 2/3] hw/misc/imx25_ccm: Replace DPRINTF with trace events
Date: Fri, 26 Jun 2026 00:01:43 +0800
Message-ID: <20260625160144.94565-3-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160144.94565-1-163wangjack@gmail.com>
References: <20260625160144.94565-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x52c.google.com
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

Signed-off-by: jack wang <163wangjack@gmail.com>
---
 hw/misc/imx25_ccm.c  | 34 ++++++++++------------------------
 hw/misc/trace-events |  9 +++++++++
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index a6665d5535..d051e8a2d1 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -16,18 +16,8 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/misc/trace.h"
 
-#ifndef DEBUG_IMX25_CCM
-#define DEBUG_IMX25_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX25_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX25_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
 
 static const char *imx25_ccm_reg_name(uint32_t reg)
 {
@@ -118,12 +108,12 @@ static uint32_t imx25_ccm_get_mpll_clk(IMXCCMState *dev)
         freq = imx_ccm_calc_pll(s->reg[IMX25_CCM_MPCTL_REG], CKIH_FREQ);
     }
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_mpll_clk(freq);
 
     return freq;
 }
 
-static uint32_t imx25_ccm_get_mcu_clk(IMXCCMState *dev)
+static uint32_t imx25_ccm_get_mcu_clk(IMX25CCMState *dev)
 {
     uint32_t freq;
     IMX25CCMState *s = IMX25_CCM(dev);
@@ -136,7 +126,7 @@ static uint32_t imx25_ccm_get_mcu_clk(IMXCCMState *dev)
 
     freq = freq / (1 + EXTRACT(s->reg[IMX25_CCM_CCTL_REG], ARM_CLK_DIV));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_mcu_clk(freq);
 
     return freq;
 }
@@ -149,7 +139,7 @@ static uint32_t imx25_ccm_get_ahb_clk(IMXCCMState *dev)
     freq = imx25_ccm_get_mcu_clk(dev)
            / (1 + EXTRACT(s->reg[IMX25_CCM_CCTL_REG], AHB_CLK_DIV));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_ahb_clk(freq);
 
     return freq;
 }
@@ -160,7 +150,7 @@ static uint32_t imx25_ccm_get_ipg_clk(IMXCCMState *dev)
 
     freq = imx25_ccm_get_ahb_clk(dev) / 2;
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_ipg_clk(freq);
 
     return freq;
 }
@@ -168,7 +158,7 @@ static uint32_t imx25_ccm_get_ipg_clk(IMXCCMState *dev)
 static uint32_t imx25_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
-    DPRINTF("Clock = %d)\n", clock);
+    trace_imx25_ccm_get_clock_frequency(clock, freq);
 
     switch (clock) {
     case CLK_NONE:
@@ -186,7 +176,7 @@ static uint32_t imx25_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         break;
     }
 
-    DPRINTF("Clock = %d) = %u\n", clock, freq);
+    trace_imx25_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -195,8 +185,6 @@ static void imx25_ccm_reset(DeviceState *dev)
 {
     IMX25CCMState *s = IMX25_CCM(dev);
 
-    DPRINTF("\n");
-
     memset(s->reg, 0, IMX25_CCM_MAX_REG * sizeof(uint32_t));
     s->reg[IMX25_CCM_MPCTL_REG] = 0x800b2c01;
     s->reg[IMX25_CCM_UPCTL_REG] = 0x84042800;
@@ -238,8 +226,7 @@ static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX25_CCM, __func__, offset);
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx25_ccm_reg_name(offset >> 2),
-            value);
+    trace_imx25_ccm_read(imx25_ccm_reg_name(offset >> 2), value);
 
     return value;
 }
@@ -249,8 +236,7 @@ static void imx25_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMX25CCMState *s = (IMX25CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx25_ccm_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx25_ccm_write(imx25_ccm_reg_name(offset >> 2), value);
 
     if (offset < 0x70) {
         /*
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index fdb4844045..ebe9b4fb22 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -273,6 +273,15 @@ imx6_src_reset(void) ""
 imx7_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx7_src_write(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
 
+# imx25_ccm.c
+imx25_ccm_get_mpll_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_mcu_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_ahb_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_ipg_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(clock = %d) = %u"
+imx25_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx25_ccm_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
+
 # iotkit-sysinfo.c
 iotkit_sysinfo_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 iotkit_sysinfo_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.53.0


