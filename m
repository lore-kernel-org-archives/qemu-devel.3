Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF3CD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5l-0002Zr-Kf; Tue, 03 Sep 2024 12:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5i-0002Ec-50
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5d-00030c-BS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374bd0da617so2184754f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379748; x=1725984548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=woCPrbI3R+Np+REB27zbFUXCAusB9NajxbY/iA0dKFE=;
 b=ZRZd12420MUjICp9gGRsXXE3oN9UlHq6Ab1nC620GaILCLPawCUuZK/2Blrox9MS9O
 PkjizQtu8z4/D0nz8dqF/CaNsBmf9BM2KFZV6f88jOQqW1OcEuF1amSUXQH5lubnpONp
 MfvWL4Uiq43d0cYSzbjymClnGrs2FGID8NflL0jt27Eh4GibrWdbUCqUNLqpyU+WLFmJ
 SCwweolBQqgUrkZ1vpdDgJG+ezI+P/p6NdvPJ0hQiMDtKGvn8+L3tOO0BDK+Udd29VyB
 Ogjyrv2+CGyfDiC8WFwp4XcRY1HHDVynPLjXsy+EIFsyWroxuv2zGONCjtJGJXlRGA0h
 XrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379748; x=1725984548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woCPrbI3R+Np+REB27zbFUXCAusB9NajxbY/iA0dKFE=;
 b=JrdqWQp9tty3o8xkNdQ8qSWweivfVyuP0Ibzki6RRZxil3IisP8bYTjpagV9AFbgkV
 Yju1k+3KXoryygWrdjV9q1vcf7KNCq03OmhTI0UBsQvLpquT9GppdmS9jYLh5p4NbYSU
 7HFEEAmrVZrx1LGVcaWSQ8oGjEl06hprCytEhMsnxxweWnCckxxvOpCAxsD8MLvZ5Ybh
 27T+t1f5ivyW8vDmRy+8DXWLUWCuIzEM6QqkVj2l+XeTotjAFXkxRxzRRAu1H0dB835v
 MbskKOMTbqTgXd2tT5KlpXOczHlQU10GyNKzA7kIMPDB5SgNtEfuFyKWbp2ONr3+lFH4
 c6dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWARcgrNFia8rQ90sa49Tn0cNCic+0NMzCxCboXo8/yGxgL8VaBsrAwuiVyTKg10/QqaVYxF4aou1tX@nongnu.org
X-Gm-Message-State: AOJu0Yw0ksC8Px+dV4LrTRn8CgXLOb7Qvlkk7MIGfniUFKEDbMXq08yd
 QqPxjeI6o8pnbZtoBbOz+9FhKVCQagCIxpt/HAHgBTs6YCNMJtT1XUZOr56YN2Jfkjs5bjwkkgD
 w
X-Google-Smtp-Source: AGHT+IG5lMeeK7SieKLq4drsjRpqmXCtLA1rcoTQS1YjlWKvs0CxS/0MY3hH+WVs2rJW70REQ0K2vw==
X-Received: by 2002:adf:978c:0:b0:371:8dcc:7f9e with SMTP id
 ffacd0b85a97d-374bce9864bmr10164712f8f.2.1725379747771; 
 Tue, 03 Sep 2024 09:09:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:09:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 51/53] hw/misc/omap_clk: Remove OMAP2-specifics
Date: Tue,  3 Sep 2024 17:07:49 +0100
Message-Id: <20240903160751.4100218-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Remove the handling for all non-OMAP1 SoCs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/omap_clk.c | 527 +--------------------------------------------
 1 file changed, 2 insertions(+), 525 deletions(-)

diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index c77ca2fc74e..0157c9be759 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -35,9 +35,6 @@ struct clk {
 #define CLOCK_IN_OMAP730	(1 << 11)
 #define CLOCK_IN_OMAP1510	(1 << 12)
 #define CLOCK_IN_OMAP16XX	(1 << 13)
-#define CLOCK_IN_OMAP242X	(1 << 14)
-#define CLOCK_IN_OMAP243X	(1 << 15)
-#define CLOCK_IN_OMAP343X	(1 << 16)
     uint32_t flags;
     int id;
 
@@ -59,8 +56,7 @@ static struct clk xtal_osc12m = {
 static struct clk xtal_osc32k = {
     .name	= "xtal_osc_32k",
     .rate	= 32768,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
-            CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_ref = {
@@ -507,449 +503,10 @@ static struct clk i2c_ick = {
 static struct clk clk32k = {
     .name	= "clk32-kHz",
     .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-            CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+            ALWAYS_ENABLED,
     .parent	= &xtal_osc32k,
 };
 
-static struct clk ref_clk = {
-    .name	= "ref_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 12000000,	/* 12 MHz or 13 MHz or 19.2 MHz */
-    /*.parent	= sys.xtalin */
-};
-
-static struct clk apll_96m = {
-    .name	= "apll_96m",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 96000000,
-    /*.parent	= ref_clk */
-};
-
-static struct clk apll_54m = {
-    .name	= "apll_54m",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 54000000,
-    /*.parent	= ref_clk */
-};
-
-static struct clk sys_clk = {
-    .name	= "sys_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 32768,
-    /*.parent	= sys.xtalin */
-};
-
-static struct clk sleep_clk = {
-    .name	= "sleep_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 32768,
-    /*.parent	= sys.xtalin */
-};
-
-static struct clk dpll_ck = {
-    .name	= "dpll",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .parent	= &ref_clk,
-};
-
-static struct clk dpll_x2_ck = {
-    .name	= "dpll_x2",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .parent	= &ref_clk,
-};
-
-static struct clk wdt1_sys_clk = {
-    .name	= "wdt1_sys_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate	= 32768,
-    /*.parent	= sys.xtalin */
-};
-
-static struct clk func_96m_clk = {
-    .name	= "func_96m_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor	= 1,
-    .parent	= &apll_96m,
-};
-
-static struct clk func_48m_clk = {
-    .name	= "func_48m_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor	= 2,
-    .parent	= &apll_96m,
-};
-
-static struct clk func_12m_clk = {
-    .name	= "func_12m_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor	= 8,
-    .parent	= &apll_96m,
-};
-
-static struct clk func_54m_clk = {
-    .name	= "func_54m_clk",
-    .flags	= CLOCK_IN_OMAP242X,
-    .divisor	= 1,
-    .parent	= &apll_54m,
-};
-
-static struct clk sys_clkout = {
-    .name	= "clkout",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk sys_clkout2 = {
-    .name	= "clkout2",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_clk = {
-    .name	= "core_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &dpll_x2_ck,	/* Switchable between dpll_ck and clk32k */
-};
-
-static struct clk l3_clk = {
-    .name	= "l3_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk core_l4_iclk = {
-    .name	= "core_l4_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &l3_clk,
-};
-
-static struct clk wu_l4_iclk = {
-    .name	= "wu_l4_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &l3_clk,
-};
-
-static struct clk core_l3_iclk = {
-    .name	= "core_l3_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk core_l4_usb_clk = {
-    .name	= "core_l4_usb_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &l3_clk,
-};
-
-static struct clk wu_gpt1_clk = {
-    .name	= "wu_gpt1_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk wu_32k_clk = {
-    .name	= "wu_32k_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk uart1_fclk = {
-    .name	= "uart1_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_48m_clk,
-};
-
-static struct clk uart1_iclk = {
-    .name	= "uart1_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk uart2_fclk = {
-    .name	= "uart2_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_48m_clk,
-};
-
-static struct clk uart2_iclk = {
-    .name	= "uart2_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk uart3_fclk = {
-    .name	= "uart3_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_48m_clk,
-};
-
-static struct clk uart3_iclk = {
-    .name	= "uart3_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk mpu_fclk = {
-    .name	= "mpu_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk mpu_iclk = {
-    .name	= "mpu_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk int_m_fclk = {
-    .name	= "int_m_fclk",
-    .alias	= "mpu_intc_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk int_m_iclk = {
-    .name	= "int_m_iclk",
-    .alias	= "mpu_intc_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_clk,
-};
-
-static struct clk core_gpt2_clk = {
-    .name	= "core_gpt2_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt3_clk = {
-    .name	= "core_gpt3_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt4_clk = {
-    .name	= "core_gpt4_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt5_clk = {
-    .name	= "core_gpt5_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt6_clk = {
-    .name	= "core_gpt6_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt7_clk = {
-    .name	= "core_gpt7_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt8_clk = {
-    .name	= "core_gpt8_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt9_clk = {
-    .name	= "core_gpt9_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt10_clk = {
-    .name	= "core_gpt10_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt11_clk = {
-    .name	= "core_gpt11_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk core_gpt12_clk = {
-    .name	= "core_gpt12_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &sys_clk,
-};
-
-static struct clk mcbsp1_clk = {
-    .name	= "mcbsp1_cg",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor	= 2,
-    .parent	= &func_96m_clk,
-};
-
-static struct clk mcbsp2_clk = {
-    .name	= "mcbsp2_cg",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor	= 2,
-    .parent	= &func_96m_clk,
-};
-
-static struct clk emul_clk = {
-    .name	= "emul_ck",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_54m_clk,
-};
-
-static struct clk sdma_fclk = {
-    .name	= "sdma_fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &l3_clk,
-};
-
-static struct clk sdma_iclk = {
-    .name	= "sdma_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l3_iclk, /* core_l4_iclk for the configuration port */
-};
-
-static struct clk i2c1_fclk = {
-    .name	= "i2c1.fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_12m_clk,
-    .divisor	= 1,
-};
-
-static struct clk i2c1_iclk = {
-    .name	= "i2c1.iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk i2c2_fclk = {
-    .name	= "i2c2.fclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_12m_clk,
-    .divisor	= 1,
-};
-
-static struct clk i2c2_iclk = {
-    .name	= "i2c2.iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk gpio_dbclk[5] = {
-    {
-        .name	= "gpio1_dbclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &wu_32k_clk,
-    }, {
-        .name	= "gpio2_dbclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &wu_32k_clk,
-    }, {
-        .name	= "gpio3_dbclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &wu_32k_clk,
-    }, {
-        .name	= "gpio4_dbclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &wu_32k_clk,
-    }, {
-        .name   = "gpio5_dbclk",
-        .flags  = CLOCK_IN_OMAP243X,
-        .parent = &wu_32k_clk,
-    },
-};
-
-static struct clk gpio_iclk = {
-    .name	= "gpio_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &wu_l4_iclk,
-};
-
-static struct clk mmc_fck = {
-    .name	= "mmc_fclk",
-    .flags	= CLOCK_IN_OMAP242X,
-    .parent	= &func_96m_clk,
-};
-
-static struct clk mmc_ick = {
-    .name	= "mmc_iclk",
-    .flags	= CLOCK_IN_OMAP242X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk spi_fclk[3] = {
-    {
-        .name	= "spi1_fclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &func_48m_clk,
-    }, {
-        .name	= "spi2_fclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &func_48m_clk,
-    }, {
-        .name	= "spi3_fclk",
-        .flags	= CLOCK_IN_OMAP243X,
-        .parent	= &func_48m_clk,
-    },
-};
-
-static struct clk dss_clk[2] = {
-    {
-        .name	= "dss_clk1",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &core_clk,
-    }, {
-        .name	= "dss_clk2",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &sys_clk,
-    },
-};
-
-static struct clk dss_54m_clk = {
-    .name	= "dss_54m_clk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &func_54m_clk,
-};
-
-static struct clk dss_l3_iclk = {
-    .name	= "dss_l3_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l3_iclk,
-};
-
-static struct clk dss_l4_iclk = {
-    .name	= "dss_l4_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent	= &core_l4_iclk,
-};
-
-static struct clk spi_iclk[3] = {
-    {
-        .name	= "spi1_iclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &core_l4_iclk,
-    }, {
-        .name	= "spi2_iclk",
-        .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent	= &core_l4_iclk,
-    }, {
-        .name	= "spi3_iclk",
-        .flags	= CLOCK_IN_OMAP243X,
-        .parent	= &core_l4_iclk,
-    },
-};
-
-static struct clk omapctrl_clk = {
-    .name	= "omapctrl_iclk",
-    .flags	= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    /* XXX Should be in WKUP domain */
-    .parent	= &core_l4_iclk,
-};
-
 static struct clk *onchip_clks[] = {
     /* OMAP 1 */
 
@@ -1019,80 +576,6 @@ static struct clk *onchip_clks[] = {
     &i2c_fck,
     &i2c_ick,
 
-    /* OMAP 2 */
-
-    &ref_clk,
-    &apll_96m,
-    &apll_54m,
-    &sys_clk,
-    &sleep_clk,
-    &dpll_ck,
-    &dpll_x2_ck,
-    &wdt1_sys_clk,
-    &func_96m_clk,
-    &func_48m_clk,
-    &func_12m_clk,
-    &func_54m_clk,
-    &sys_clkout,
-    &sys_clkout2,
-    &core_clk,
-    &l3_clk,
-    &core_l4_iclk,
-    &wu_l4_iclk,
-    &core_l3_iclk,
-    &core_l4_usb_clk,
-    &wu_gpt1_clk,
-    &wu_32k_clk,
-    &uart1_fclk,
-    &uart1_iclk,
-    &uart2_fclk,
-    &uart2_iclk,
-    &uart3_fclk,
-    &uart3_iclk,
-    &mpu_fclk,
-    &mpu_iclk,
-    &int_m_fclk,
-    &int_m_iclk,
-    &core_gpt2_clk,
-    &core_gpt3_clk,
-    &core_gpt4_clk,
-    &core_gpt5_clk,
-    &core_gpt6_clk,
-    &core_gpt7_clk,
-    &core_gpt8_clk,
-    &core_gpt9_clk,
-    &core_gpt10_clk,
-    &core_gpt11_clk,
-    &core_gpt12_clk,
-    &mcbsp1_clk,
-    &mcbsp2_clk,
-    &emul_clk,
-    &sdma_fclk,
-    &sdma_iclk,
-    &i2c1_fclk,
-    &i2c1_iclk,
-    &i2c2_fclk,
-    &i2c2_iclk,
-    &gpio_dbclk[0],
-    &gpio_dbclk[1],
-    &gpio_dbclk[2],
-    &gpio_dbclk[3],
-    &gpio_iclk,
-    &mmc_fck,
-    &mmc_ick,
-    &spi_fclk[0],
-    &spi_iclk[0],
-    &spi_fclk[1],
-    &spi_iclk[1],
-    &spi_fclk[2],
-    &spi_iclk[2],
-    &dss_clk[0],
-    &dss_clk[1],
-    &dss_54m_clk,
-    &dss_l3_iclk,
-    &dss_l4_iclk,
-    &omapctrl_clk,
-
     NULL
 };
 
@@ -1230,12 +713,6 @@ void omap_clk_init(struct omap_mpu_state_s *mpu)
         flag = CLOCK_IN_OMAP310;
     else if (cpu_is_omap1510(mpu))
         flag = CLOCK_IN_OMAP1510;
-    else if (cpu_is_omap2410(mpu) || cpu_is_omap2420(mpu))
-        flag = CLOCK_IN_OMAP242X;
-    else if (cpu_is_omap2430(mpu))
-        flag = CLOCK_IN_OMAP243X;
-    else if (cpu_is_omap3430(mpu))
-        flag = CLOCK_IN_OMAP243X;
     else
         return;
 
-- 
2.34.1


