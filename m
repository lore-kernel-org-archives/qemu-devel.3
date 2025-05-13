Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E2C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEto6-0001b3-8B; Tue, 13 May 2025 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcN-0000V1-54
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcL-0003Pw-8T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so60863045e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158035; x=1747762835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbZkU9N2W70mmJR5tu1c9TOXd68jr3evYSE4eI0rwy4=;
 b=KYEDzG5B79szxCqqIK1YlbABlWYoXX5ubDAmC7T50qmDSYaJhg3qRAa7T5eXtgrfl+
 i6a9m+s+cmlngSYMhSWExJXr819QJc48jJuqp/91NyjOwTYDK0OkwKVxt5cbtHc2nvgD
 r4QIv1U5DG+y16Kh68n3AE2MmiSPr/97Sa1ScQCJTR6Rwy8U+VqeH+XJ/iao/ctUTCaU
 adKxvFBiaUIa4aTASDGHknjvEroVJybS45EzZz3XC9oxL1pLHqI59gZNZ/EP5xwyzgKQ
 9yIBBACNfx/j9xEWxwTbS5wjbF1JGBMnfwIQDgS7IZcz5/Wr7EIOpjlfWvB/G5l17K11
 Z1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158035; x=1747762835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbZkU9N2W70mmJR5tu1c9TOXd68jr3evYSE4eI0rwy4=;
 b=YLWBFiGZfoTogM/tJiR0ENED9IsA5qqXYJixvuScpu39iKXgPzbqZKrYvk86C9kOVy
 3iPKUAOv2cmYeUCKSpiOjpyJlmz4J3coz3blGoROeE5mCRn6D5DjklZ2+WT4yG+HHg0L
 2WyXl7OBMhZINLwDmrKsC48qHLbtUrBKp9pX2isfzWywR2eH5khtyEB39zRqJUVjnDR9
 Je1uYxthfbxuA7t23w4PbDb6GjddBEg72zdtqT+DmS9Wa7n9ueD3RJmxl4jLEBwJkwY0
 Ou5yarPoYMNueAnnhl1h9LiiB+lA6NpCpDJv1mJMGOFIi4Kh+z0orKMoSGR5sp+bCt/V
 TtBA==
X-Gm-Message-State: AOJu0YxRrAfyU7F55ZVD57jFBYOnKimJ0CFJGcHyhhtmFYLnA6HJ7B0R
 BvThfS7itBbSCIin9jkwUBrH2grWia+mlTk0eoHG6PckGLBt3Jglps7AkStEI9EeF0cfqiIgrcu
 ybrY=
X-Gm-Gg: ASbGncvGoOjDFWSvkgPWCHvx0LprpZ2Yav4OsKUCuFO8eytpWvGJfisYVqfmsvHyUBU
 eGi3qxiRdoDB9i2w6VWKO+QAVm/ggBuxAB315lsQhaNUXAyNbNpJw6N/c2UqJZVJMofE1ot4Mj8
 RYbolJZnF+6Lqs3dTpcYk8lhZGDHm2QP6nfwgfT5+6EEWT+sGl7+aEbYIBffridrCXij9zcs4QV
 hgZqfuIr7GjjhwAWneBy56RVIgUQEPZFm3U3DuoJoz0JiU2YK53h2vdg6iADANIVD3raoXoUZMS
 C7OKXUiJDNSn9W03lFZD3gJQv9d28eSdMqCx8dNHuIkvMgpr2UMYCSE8xJojduBHown5mTIGR6d
 vkK1u3rCZWKjT1o7Z1nwdrY9wnX5w
X-Google-Smtp-Source: AGHT+IH6YO1K+1l57Glqnx6HVrhCtUqdw4YNIV8uhl/OfLwKH+cm3ibPIiAqPrnNEnoxkf6kJU9gUA==
X-Received: by 2002:a05:600c:358b:b0:442:e9ec:4654 with SMTP id
 5b1f17b1804b1-442f20e1ad3mr2562725e9.8.1747158035045; 
 Tue, 13 May 2025 10:40:35 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d14e6d74sm206848455e9.21.2025.05.13.10.40.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/19] hw/arm: Include missing 'target/arm/gtimer.h' header
Date: Tue, 13 May 2025 18:39:22 +0100
Message-ID: <20250513173928.77376-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index a38c2a19751..ad017237f3f 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
 #include "qemu/log.h"
+#include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
 #define AST2700_SOC_IO_SIZE          0x01000000
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 22aa754613c..20709bf19e8 100644
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
index e83a88d3369..24b3c0b5d29 100644
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
index 23e662c16ca..3528adb90f1 100644
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
index 889d291401e..8c743be3cb5 100644
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
index e6c16537eef..7802768c384 100644
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
index 47f23b6e2c0..2dc5e15e791 100644
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
index 575e566280b..073a8319fa5 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "target/arm/gtimer.h"
 #include "cpregs.h"
 
 #define SIGNBIT (uint32_t)0x80000000
-- 
2.47.1


