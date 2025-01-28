Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81114C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxm-00028l-1F; Tue, 28 Jan 2025 15:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxh-00025k-Us
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxg-0001Zt-9e
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso41557665e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095207; x=1738700007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iOQ6dq9zHrqw31qzUJLni5cZshrkkrmLO9hIUOItrE8=;
 b=yAhiYfz/Ft5FOkXs0FAZwluXgFVl7n7pMfw5I0S2gfh6Mff2NT3TUBHbvbPVDk0TOI
 +0Cqye1glrhImZlDUpCfDU9Ds/LbUT5Dez7A0qnaxSKpJZsuNksBAcAEpbbhuhyvQUqw
 c7AytDc0S/pK+5HIZH00p+pQVgu7/sj9VC3+gp9fRUvcz+Pkb6Tm9zfbFOfduu7RuLZ8
 jCZGZDrDQTq1fLmVUMkPKguAmgu4lNl96Sa1qNLKMjT8YUymOEx5/bQJ0hyfr/W/Lhqs
 Rxiz8v9i6SmIi7ZTvrAFc67pzs9mvvF9wNm/WddjM4jvPMSMo3Ixg19QwO9Q+T+QiPwy
 26bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095207; x=1738700007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOQ6dq9zHrqw31qzUJLni5cZshrkkrmLO9hIUOItrE8=;
 b=cCppPMp0jiGo3R9SGwoB/RYKuFw23GToouQDXZYBXd7fjle2sVuWPxc3xyTq8RRawa
 iUWHqSP1T0w92e2Ngi7/vju4qcZ6QEzw5cNrlXlcqb1d8sZ+2CzZnlagUB0BpdeAvYJY
 R7rYT1r+QSPncbiazx80FTrv9gHAkPO5xPjVQGRbrxsgHtINVNcSzPrZVyPMKkvWeErN
 82ImD6H888kIdZrjQTZq8Yw2pVUbCI6tnDr7Brli+bg5yAdLNeqZFQWAxylWftPZ7ktw
 I8vItMwK2oZHjbW9HQ/XZv9oXocD9h8Y2y4orz2nwf3QiH5R4QOHBJFq/8LCTSM7M2Oc
 /5iw==
X-Gm-Message-State: AOJu0YwAFyk96mKYw98y8v7XaMnUagwoifo22wwiHIyT49jupGK1L1TU
 ksIZm01g1VxJS8AJC5fDSqvgYSwH8jaEsD4B2vLs1MAOexMVyVvZzKX+MBTFxnU2s9vmhZv5SM4
 E
X-Gm-Gg: ASbGnctViCAlLdJF0mK25RoPQEUsYyDjtLowg4z6yrBGAXheo4Xl7mGo0j43LhiJBwA
 dnSSnghgFDpNtUHRaXsO2SFGwTvziyzfKJnzBm4vv8jF2WRKiG/AS7IRO2hBpBI3bVl3do/zeRc
 cJzoI1Vx9ldJT6XETeS1CW0ZmlID+d4mTYyXIG/RVQn5bS9X+YciBJNbm8/6StjUNnE/7UlL+Eg
 AsIZdu/TEcIfrLo/sO7xsl85/Uu1slckChiLCswoqKZ1dsVbbtEkNYiv2XCC987gN6ylpeMVN5z
 K5jenTHZLRNJwrGWcgEX3w==
X-Google-Smtp-Source: AGHT+IEo9vCNFtr05Gmpb06MIfMkR/Mro0C9CWKz84Jj2bFr7cMppUotYOmt2krTrcU6vl/2xegMdg==
X-Received: by 2002:a05:600c:4704:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-438dc42a445mr2749935e9.30.1738095206660; 
 Tue, 28 Jan 2025 12:13:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] hw/arm/stellaris: Replace magic numbers by definitions
Date: Tue, 28 Jan 2025 20:12:48 +0000
Message-Id: <20250128201314.44038-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add definitions for the number of controllers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 4df02138ac5..dd342b17d2a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -49,6 +49,11 @@
 #define NUM_IRQ_LINES 64
 #define NUM_PRIO_BITS 3
 
+#define NUM_GPIO    7
+#define NUM_UART    4
+#define NUM_GPTM    4
+#define NUM_I2C     2
+
 typedef const struct {
     const char *name;
     uint32_t did0;
@@ -989,12 +994,12 @@ static const stellaris_board_info stellaris_boards[] = {
 
 static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 {
-    static const int uart_irq[] = {5, 6, 33, 34};
-    static const int timer_irq[] = {19, 21, 23, 35};
-    static const uint32_t gpio_addr[7] =
+    static const int uart_irq[NUM_UART] = {5, 6, 33, 34};
+    static const int timer_irq[NUM_GPTM] = {19, 21, 23, 35};
+    static const uint32_t gpio_addr[NUM_GPIO] =
       { 0x40004000, 0x40005000, 0x40006000, 0x40007000,
         0x40024000, 0x40025000, 0x40026000};
-    static const int gpio_irq[7] = {0, 1, 2, 3, 4, 30, 31};
+    static const int gpio_irq[NUM_GPIO] = {0, 1, 2, 3, 4, 30, 31};
 
     /* Memory map of SoC devices, from
      * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
@@ -1030,9 +1035,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      */
 
     Object *soc_container;
-    DeviceState *gpio_dev[7], *armv7m, *nvic;
-    qemu_irq gpio_in[7][8];
-    qemu_irq gpio_out[7][8];
+    DeviceState *gpio_dev[NUM_GPIO], *armv7m, *nvic;
+    qemu_irq gpio_in[NUM_GPIO][8];
+    qemu_irq gpio_out[NUM_GPIO][8];
     qemu_irq adc;
     int sram_size;
     int flash_size;
@@ -1124,7 +1129,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     } else {
         adc = NULL;
     }
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < NUM_GPTM; i++) {
         if (board->dc2 & (0x10000 << i)) {
             SysBusDevice *sbd;
 
@@ -1158,7 +1163,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
 
-    for (i = 0; i < 7; i++) {
+    for (i = 0; i < NUM_GPIO; i++) {
         if (board->dc4 & (1 << i)) {
             gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
@@ -1179,7 +1184,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < NUM_UART; i++) {
         if (board->dc2 & (1 << i)) {
             SysBusDevice *sbd;
 
-- 
2.34.1


