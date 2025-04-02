Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D1C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06Vb-0004m0-Gj; Wed, 02 Apr 2025 18:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VO-0004jB-IG
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VM-0002U0-EK
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so1208675e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632654; x=1744237454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDr84eNBH4L+uB6tLy9qxz5WkTQN5f+BnjFqIVkh0pg=;
 b=dfrR6a1wIPdiPei7WF7XM0Ko8GxFbS80cTrKYt1JFjs/yXD9K+xnLH6tAfpAgy/BJz
 //9f+pSu9PuUycD6DTyoTn0qDf3ZISJqTChOqlVeHHD1yW9q78C0LCSRbl9oHOAc6wBp
 WEdas7ZxLwtKycrehh9LLQbdKEH0o8Fa6LMLzQ4pKn9b0SLbZgQ9XlgKZL0Fn1kYEoel
 Ww90qqOZOFSD0g6g8JHnGrdhnxkklk3Rv0I9VU72LlY5E4sAdm/Z++t+8KsnbIELCiAp
 Bt6HvLqwtL5/kpiDN2KuUnPHQZ4ThcAY4eKldveC3WfFu9K06SQqLHRNp8/9dMjCDBja
 wbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632654; x=1744237454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDr84eNBH4L+uB6tLy9qxz5WkTQN5f+BnjFqIVkh0pg=;
 b=Iy+OIqCkE34J23VtLRB/eZNEZ3lJFQQYKtIkFa/qHVyYiNtsIzadibem7OKX2Eh+vg
 C2YRE9OPS3vw9BWQLNKoXbRxiqXOW7fErwN2scfFaSkf+uzHPNAUlnWif0AzLra9gj9i
 ugjrmDPT3SyfX4IFQwrE5++1LUM6d3+Gvwl8F41em7h1D9AsjCPB2peLU8W5nTq6umN7
 giHs06Pg3UdbJwrM5ySuSkuN+XiFvyqtMTBajihqXdFiAFGfvDnaAePbRm3XdpIvI3FI
 x5JcaSfO3+wY+UD9oefl5XG8x3YGu0MhnorJXcp6RQUCdb5voo+05FkkhopY/yRs6nR0
 86KQ==
X-Gm-Message-State: AOJu0Yx4MKH92N7UH57B78Cei+h913D+pI6BpQ8iZGYl031VdJVuFEEo
 qEud+dF5vIW+FnZec9SS4Ot1fHHKunpNTgZe2jqpWPDlGjcApHr/d2eQIDNHMEul7P2vdB4pXXc
 1
X-Gm-Gg: ASbGncsxQbS13IurzTFMpoHhOYlhKzdR5QBgTSsaHUAzDXI37lclMIwZjTPyx2/BVQr
 i57U+LZUuR/R1v8JkYwlyTJg/MLR4iJGIax0yc6t+yQmqliegASBb7NHXG5j7EZDBCuepXgxAFd
 Mgr/7MQWOl+w0BGhvMiuumWBPyHAt9315hI5UR0zLAxoCyjXWxsLmDPlnNjChdnVGyncSLAoXkd
 wcON9/tXISoDkDSLitsQQFfhnQmsEA7w3tiJGZbN0oberhQP8d6AlqgOKSs15Vi7j71SRq/nuUw
 pkysoEC+UO7vkQtNxjxoVuDmf7uTRUj5BdsBXOCaxbx1UW5QWMJ5W9nvRdxi01Dq71NnBSTDdn2
 AecHqDnEri/PlevQ9+7qgU+/XWoNXpg==
X-Google-Smtp-Source: AGHT+IHr+g3GPa20rzmhI5yiZLfBs0RhmZKeTC9cHby0QsS1e8z/85I4+ZlEdwGSFNtBX8U6htmWFQ==
X-Received: by 2002:a05:600c:6d45:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-43eb63d417dmr27595655e9.19.1743632654268; 
 Wed, 02 Apr 2025 15:24:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34ae0c5sm416475e9.15.2025.04.02.15.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 08/13] hw/arm: Include missing 'target/arm/gtimer.h'
 header
Date: Thu,  3 Apr 2025 00:23:28 +0200
Message-ID: <20250402222334.66511-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0.c    | 1 +
 hw/arm/bcm2838.c           | 1 +
 hw/arm/exynos4210.c        | 1 +
 hw/arm/fsl-imx8mp.c        | 1 +
 hw/arm/mps3r.c             | 1 +
 hw/arm/npcm8xx.c           | 1 +
 hw/vmapple/vmapple.c       | 1 +
 target/arm/tcg/op_helper.c | 1 +
 8 files changed, 8 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 37bfeef304d..5c2481225dd 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
 #include "qemu/log.h"
+#include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index ddb7c5f757a..38d9b785a75 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -12,6 +12,7 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 #include "hw/arm/bcm2838.h"
+#include "target/arm/gtimer.h"
 #include "trace.h"
 
 #define GIC400_MAINTENANCE_IRQ      9
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 01e6e2fb052..ca40df3db75 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -36,6 +36,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 2cf5eeaf313..180feca9d80 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -17,6 +17,7 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 604f6845fde..37c0de28a92 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -47,6 +47,7 @@
 #include "hw/ssi/pl022.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
+#include "target/arm/gtimer.h"
 
 /* Define the layout of RAM and ROM in a board */
 typedef struct RAMInfo {
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 3987e55355b..2f11bc53a86 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "system/system.h"
+#include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
 /*
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 9bb5b0553a2..25652b16f0c 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -51,6 +51,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
 struct VMAppleMachineState {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..005f84082af 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "target/arm/gtimer.h"
 #include "cpregs.h"
 
 #define SIGNBIT (uint32_t)0x80000000
-- 
2.47.1


