Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3538CD5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEob-00018K-8d; Mon, 15 Dec 2025 15:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoZ-00013N-Qr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoY-00082H-40
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so48304295e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765829100; x=1766433900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIQyQh8GF13j69cAMgld8RnRzJ3XfP6rx5cpAIOmmeE=;
 b=R2fhryZJzATmq1Bu1UebNQcU2gCnqFJPlxZBHIePiI1E2ZulTh7xJOt2x5hUY7pbW8
 pJqMoRbpf7UiJNf+HBXAJt80XRKPSYJduwkkncVuXBuX3VM087jTkWjwuZvgqQYbxAC6
 zg/xdMT4w5TrHHzVhWtnXH9gOSoXpVOUHDGobePrjXlUKazmqGqS+DFx7n2V/jv/g82m
 TLknDqCx4e0TmQLzmQ41oaILsKWYUw7B8TYfuzFQxkpx512uoeNMe5D/QWwv2eLCLsCa
 XVqzyIQ4tfdXBfYQrPuEMj7qwDanE12VMzpJS0bALUzSZ3ItpDzO0SOIrmWiwBOmx2dP
 jUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765829100; x=1766433900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIQyQh8GF13j69cAMgld8RnRzJ3XfP6rx5cpAIOmmeE=;
 b=lBD4e06U60t8HpQEddlKfVvBf0Z2hkA3pdKftJzegFb6I8EtUf3NAAIKfAvY7m41bJ
 3EiLjbvxa/YRLPavpOF7/crktssONNevPB/mCUC5CiXxztcAVzibgI+Ik1SKrm7jjyY/
 H4eU4ThVZsGQBl8mS0gyZzMQvgrPtI2+bFg6fpPvEB2VBeBjcVuAQYysKwHg0KPhgZsK
 eNzpPxFZXoFahNDNYVeSDM0oz6ZPkLTggLF9EvArbFwVzxpyGPfhMhuLA5nFXkrkQHyW
 2+l+nhohBnaDtDO5NfKiFyCv9RmQGaLD7jp6SpdguRSCRkdSihVR8cnxLngvcrn6Znzm
 mE5A==
X-Gm-Message-State: AOJu0YxwAl9QtQ1ppCIRKysU2RzQnbdCSxUzQ5UlKQDOb1jSAasdG+pk
 ydh88ru6IHgLFVGqVHSZGsS+rcIUFoudNR7ZWct//ls6vi1VVvQs/XfF0rvSeg==
X-Gm-Gg: AY/fxX7vOw/yydSLSmRCk1SAPv3fPzSEFCa1Uh1a6t4SMkMJIpDJ9qiohnRKfJtx3J7
 T4Zf2ZeS+KxSB5EofEz80ILl5rHm3jS/9VqEtfJw2Tvqcb9igV6l4zsTdJf7ZcHaAmM4BP7EveF
 e4urDWI8Ed1MjtsBO7KOzTFO2+E7oGmmwQ/2s/++4zi6Jlxf6dxKrM4EXoqVehs5p4bDUWdpyf8
 mWyUQpPErcyYB6ow7ew4drsVqWbAIaaUtF8Aks7HuvpXIKKTEEYtm77DopiEIMPkyjOPrtPh8HN
 WhzE9fZAYe1keyAPJhlR38JeeFyaCMWuGfc+wQNuC9otllGFqw2b8CSOOtm1t4w6JRVdPMPpMG+
 mgsAVj+TwSKPq1n4NlTiP7nxISqllu3U0m5o+XGS9pzGKH2W3jE5Nfsb7hnWUO/VL9MRtQINnZu
 KupEFQMRL7jg3OuLX5L4wuF5mzambAmBvYZkPNeFAQ+w==
X-Google-Smtp-Source: AGHT+IHGzjFdXWkucI2HN2rttHSI75zX6AI0br8kDDZKQbDbVkYNWiTvF1DM76p47G6w94MEVS2Agg==
X-Received: by 2002:a05:600c:4f89:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-47a8f90c5b0mr130408985e9.31.1765829100203; 
 Mon, 15 Dec 2025 12:05:00 -0800 (PST)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f703efesm72603235e9.16.2025.12.15.12.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:04:59 -0800 (PST)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v1 2/6] hw/misc/imx6_ccm: Add PLL3 and CAN clock
Date: Mon, 15 Dec 2025 21:03:11 +0100
Message-ID: <033163952bd2ccb3fcbdde1176d289f4df39c4b1.1765826753.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add fixed frequency (480 MHz) PLL3, of which the FlexCAN
clock is derived, and compute FlexCAN frequency based on
divider configuration.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
---
 hw/misc/imx6_ccm.c         | 24 ++++++++++++++++++++++++
 hw/misc/trace-events       |  2 ++
 include/hw/misc/imx6_ccm.h |  4 ++++
 include/hw/misc/imx_ccm.h  |  1 +
 4 files changed, 31 insertions(+)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index a10b67d396..45fdd0d5a8 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -257,6 +257,15 @@ static uint64_t imx6_analog_get_pll2_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_analog_get_pll3_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 480000000;
+
+    trace_imx6_analog_get_pll3_clk(freq);
+
+    return freq;
+}
+
 static uint64_t imx6_analog_get_pll2_pfd0_clk(IMX6CCMState *dev)
 {
     uint64_t freq = 0;
@@ -344,6 +353,18 @@ static uint64_t imx6_ccm_get_per_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_ccm_get_can_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6_analog_get_pll3_clk(dev) / 8;
+    freq /= (1 + EXTRACT(dev->ccm[CCM_CSCMR2], CAN_CLK_PODF));
+
+    trace_imx6_ccm_get_can_clk(freq);
+
+    return freq;
+}
+
 static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
@@ -358,6 +379,9 @@ static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_IPG_HIGH:
         freq = imx6_ccm_get_per_clk(s);
         break;
+    case CLK_CAN:
+        freq = imx6_ccm_get_can_clk(s);
+        break;
     case CLK_32k:
         freq = CKIL_FREQ;
         break;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index eeb9243898..7c4f1c45b8 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -242,11 +242,13 @@ imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll3_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_analog_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
 imx6_ccm_get_ahb_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_ipg_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_per_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_can_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock = %d) = %u"
 imx6_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_ccm_reset(void) ""
diff --git a/include/hw/misc/imx6_ccm.h b/include/hw/misc/imx6_ccm.h
index ccf46d7353..f498732727 100644
--- a/include/hw/misc/imx6_ccm.h
+++ b/include/hw/misc/imx6_ccm.h
@@ -164,6 +164,10 @@
 #define PERCLK_PODF_SHIFT        (0)
 #define PERCLK_PODF_LENGTH       (6)
 
+/* CCM_CSCMR2 */
+#define CAN_CLK_PODF_SHIFT        (2)
+#define CAN_CLK_PODF_LENGTH       (6)
+
 /* CCM_ANALOG_PFD_528 */
 #define PFD0_FRAC_SHIFT          (0)
 #define PFD0_FRAC_LENGTH         (6)
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index 7e5678e972..9ce3adf332 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -46,6 +46,7 @@ typedef enum  {
     CLK_EXT,
     CLK_HIGH_DIV,
     CLK_HIGH,
+    CLK_CAN,
 } IMXClk;
 
 struct IMXCCMClass {
-- 
2.52.0


