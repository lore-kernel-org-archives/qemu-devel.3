Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE5AC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUA-0003zg-Ix; Thu, 03 Apr 2025 20:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UU5-0003cX-SZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UU3-0002zT-11
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso15510545e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724829; x=1744329629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWzncIlD/jPDOChfnrDcKNqYdRNXnmA3myNJZtWNdQo=;
 b=RAf1QEd6y4EmPzQW5alBRJhZA9hS00J3OS3cXfiZ4qtNFdLcdgyNF/PnxXAhAC87go
 Fpcy7HpKVBbpz0ney/gY4vIg0OFuc70HtaES0hss+GsZ0XXJdsUEQp+Wx/9bS+GVIO6w
 23TgdooopUrj2BOsppaw1gGGYM/xqEu5PugrMzOSOxSZoRZKuycs2FDx0znIINvJo9Ce
 MMIXUjCRH9Hq3If7vEj7hD/ZkU+UWSY9vNtT++BWbtG4qzaxAZjvEOFQJCEXYeIsBV98
 XiDBZ1VxYRsjzpufQF+C6g/TKZFdYZH8wkWGdKU3+PTKVvYzmElPS4bkBMiJwQoceGrv
 ryyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724829; x=1744329629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWzncIlD/jPDOChfnrDcKNqYdRNXnmA3myNJZtWNdQo=;
 b=JHTOMvzREm7Nq8QdKz4+/XfqMPeEmIa2a7aPb97MZ8oWNCNoUFCG6xBFn8az4qbMBp
 2qcQ3JAWTuR2jiTNefpF0dXPB2a6uKLAaQm79S7MQjU5umx+Lqlrmgqo8MjeAalg6FmG
 MQnHED2LDMMt4kJu5YfFNyy/jXILout1Tx90Q4YiPVGVnEIPhStiEPNq4dP7SFOda4Wu
 R6KvEQ8PCCbJ/rpo9xNzIZ50r0/1sX48MCRhRVMKBKeyOcf8z2Ohrko+2N+kYDoW/nQS
 G1lvCUxyt9qJBiBtGpK+I5+38QNYmhJkNs+irbMkpSOkDSogO5JDiard67hE/hpw1tYt
 lVWA==
X-Gm-Message-State: AOJu0YwLM+ULLg7JQlvvsFSCbfpBB7i7VVMeqx29IskteIaHwAXLF8pm
 045fk2SEvhRokeEI3ISr6Q3ihyk1Y3iHcw+I9HSK9bX8+jz/1pCr2Lvz6++lk2V2Bp44N7Q1OC2
 a
X-Gm-Gg: ASbGncsCUOBg8cwqaETId9El3uS/1HnXsRvHOfhTMkNGoMqYGe99Rr2LH3YYI1hognb
 6cnBnPuhp5tpbtZ6zdIe25CdH5yF0wBv7p8jFf2+hMpGIYKDZR8WJpPB8Yo0/GpIXUAXFwYFntt
 2Y88zKdC1h1nty3D6La+Yj7je8GN5jips05pDio4yswxLUoanGto61EQ8vrj1NUrXBuBWNmDBez
 4O7NeiOVo6hgvfuGJnlOIp3q4yoz+ER0SF7ah/X1Rzye9EcNmoyUEDEb2nLHOndcf2dZdb6rlou
 TeM12BDew+nn/alXVSyCtZcs+uT72GXnQSd0uSf8wA1maicTF/54n3ExLU+8ML1oojkxbda7XZF
 Q9lU6EEcN5dRm4YJ+juk=
X-Google-Smtp-Source: AGHT+IFG64zDHb5Pvt4t+IvngcBkXhgLKZqlZzqyNCO8ncDN8ez/4L/iNIdQDA3mtzXh0vsdwzBiTQ==
X-Received: by 2002:a05:600c:4503:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43ecf8eb2bbmr7344195e9.15.1743724829228; 
 Thu, 03 Apr 2025 17:00:29 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16049sm61437675e9.0.2025.04.03.17.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 19/39] hw/arm: Include missing
 'target/arm/gtimer.h' header
Date: Fri,  4 Apr 2025 01:58:01 +0200
Message-ID: <20250403235821.9909-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


