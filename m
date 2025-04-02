Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4712EC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06WT-0005is-Bj; Wed, 02 Apr 2025 18:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Vh-0004qf-NM
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Vf-0002Yp-8D
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43948021a45so2145565e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632673; x=1744237473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF70aNm+iGgL2ioq9Xiaj6FEbb6pAabZS82CmNkwLqw=;
 b=NTBPdEmhWAFZDYelVwktQM4gu5tCJmN0Xc+3d8luoe191qeOPcReHtl3TD2f1KV9cn
 EpdiPzLSVzpd9ut00FjpDuO7VLdE/h5syp6oCnX/aYYw8Q74YQj83PzwlMJFvbrMP6YJ
 fpDW/5fZeB60yNwFIG+Ush3vn3dadUySNFQejyYhyi1il/hU4WzPDwZiVpeG79QGuZi+
 75a2yv/eCqRbG9FqHbbzwIpyl81wP5kdOw91THt9JLc8luw70o/ecD9z0mTKluZ+AjvB
 KNQmxysL1kVTZ67iyAqy/EvTfuSv9ckfb9uwA1s5BtWw3MVFBEBxEIzjQxm1CLRdfLXA
 r4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632673; x=1744237473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF70aNm+iGgL2ioq9Xiaj6FEbb6pAabZS82CmNkwLqw=;
 b=eN0herz7bSJTHVEKIFUWm+zpYfjahBqy66GUyvBCsNJDdP+e5uynyr6TF0PPbakufO
 nBvlmDORL+hdqswFiDP7A62V7jDwwfNLL1CX/dwxsJkMREUyrUbSPmJkB0IY0MQm0Scv
 tnOjaqbHXOWTpf/6AzSqvuFmFCRT/YGYPUgDgSMkiQWG+5dz6nNZRz87tShoUQjMtxBd
 hXxiMCnNkPfsgCYdLU/RFtelZMg0QnOsDW29TpxNx5Hea7jd/b9qOMBimriY08yWaI80
 H2weV2jZY2UQY5N+rUpDZEHViFhq4FbHAmMHk8yd1EQ/4JUxEtoQ/RGd5FxdXh2At+HZ
 ivmQ==
X-Gm-Message-State: AOJu0YyKQcK1Rbdk++IXA1ACl2yK3UlJGyRlcnjHRfV/xY6o7eMqD+jw
 3AY95a5MgrX/GoGRtkqJJ4Ox+beIahy1LAityf70LcrK7uH1Pza5DOSZjXXSY7hw1cIEPxlX3Fp
 9
X-Gm-Gg: ASbGncsDSP44yoysyKS12eyokZIrr8+TJad4sCzPH2l6xCnabMyolQ9sy8xjUn12Evg
 u7qjlcGm/TZScNA2z6iuYeaNafNqf8JfC62D4s1uW5SdhfV2oyOMnZMujH8Luire0A48N1tKTwD
 DEKeZGayNFhL1AejlIb1rZYQbUKJ2s76GdcSm5kd++2kazCqTonb3zQ0MHrveFB/PopycDdcJ2h
 CpF8Wshow1A+J6nCh4og+pmtnfVeHL75k5lRgO2xxgaUu/eCUapciVT1juRrRwNwyUsnzqdIfj8
 n3RJyHLFwjXcZk1tPks7/PFP3BBnlFoB9aSvG3UgAbuW4A4YMvwMaC7BscHQ3JkOBV5J7XjuML+
 YWV9d9/xIV2YN6eziY6c=
X-Google-Smtp-Source: AGHT+IG7QbtZeKRX8aRNTSlKy/Me1gfCFXMcvrIAm/6ZxnlccKJ55OEkrdnWXcihsxsJZ8TmoOAgDg==
X-Received: by 2002:a05:600c:34d0:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-43db61d8dcbmr162934155e9.6.1743632672939; 
 Wed, 02 Apr 2025 15:24:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226f1fsm40966f8f.95.2025.04.02.15.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 12/13] hw/arm/realview: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Thu,  3 Apr 2025 00:23:32 +0200
Message-ID: <20250402222334.66511-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

By using arm_cpu_has_feature() instead of arm_feature()
we don't need to include "cpu.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f81d084eb80..48cfe05add0 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
@@ -31,6 +30,7 @@
 #include "hw/sd/sd.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu_has_feature.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -77,7 +77,6 @@ static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
     ARMCPU *cpu = NULL;
-    CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram_lo;
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
@@ -138,16 +137,15 @@ static void realview_init(MachineState *machine,
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
     }
     cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-    if (arm_feature(env, ARM_FEATURE_V7)) {
+    if (arm_cpu_has_feature(cpu, ARM_FEATURE_V7)) {
         if (is_mpcore) {
             proc_id = 0x0c000000;
         } else {
             proc_id = 0x0e000000;
         }
-    } else if (arm_feature(env, ARM_FEATURE_V6K)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6K)) {
         proc_id = 0x06000000;
-    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6)) {
         proc_id = 0x04000000;
     } else {
         proc_id = 0x02000000;
-- 
2.47.1


