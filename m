Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDBCC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWY-00022q-0U; Thu, 25 Apr 2024 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0001ys-G8
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWM-0007A6-H0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34a00533d08so465366f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041605; x=1714646405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aKgAIExeXe22iXmvncCzPBD6wUC7eTZRMMv1MDBAcwE=;
 b=ZjT8EGa4SbQ2lcNkoeukDJwUQYz1onssSsS0noMIBneJQtqiDdZ6PonzUCzSk7Nfp3
 DWteL+jCaDkVj6z1SyZS6jMeHe/Zu/7qa31WuvrLBChvTARnzsRb9WISxvBOsG6AMmlY
 KQdd88Yfq7t5UelBOZQSiNohu+Eqy5zcUPavJ1Komm/IY0ZagveA7+gT/CVKiWPldSvb
 C2BwufixCILM9rwr64AxP6l7LSkqhYpEXVeSi1IvrHVNTQolyYD5s6/gD/n4v+1PdlZG
 IYQy1e342viqnoqshRkWiv3kEnXkzLMvOSgsGAIIZ6GumwHUgg2cXo4tM6cN/kjftgqF
 W9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041605; x=1714646405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKgAIExeXe22iXmvncCzPBD6wUC7eTZRMMv1MDBAcwE=;
 b=XHkgP43VO3WjPgEeA/9Kb6qQKXlBIKt4A4bKUlUXkV57DPrPApPm12jm4zbdV8dB/z
 gZKWzSe6zEZcHqSo6xJJLbC14d5ej5jR/H1dgFutCofnrSoOxw3Yua43pZH4dz5OUoeD
 1niU6uu3cIj0qAxOKhKt5qSJpa/fz+uj9f7byBoer2fX4P7B7vKq761RZFKRlBY4UgOO
 7hjoUlPDgq9zIDIrd/NuXe3o/EMV/+uT8mnRF0z2z1qZg2Jx6iB+3XVu61YmVNQENoRr
 f/TNyjqDYe9b49h7xkpdHJ81EYipKeHUJOiCSDaUp7u5k1wmqKxbhHMxQhcpaoKQDwMR
 zVmQ==
X-Gm-Message-State: AOJu0YzZ5J17d/w7+suwpDCJQiSWSnBKl4wvCPaypqpIEb1ribX0AQ4v
 evb6bhFJq90BXwBLy493P6eLJ52X13n3/sKgJs2ZdddU0+CRvEgIklTFHylBloWIYSIt5Q6y+mj
 J
X-Google-Smtp-Source: AGHT+IH4ZI0My2ovJWqjUWMox/A0hOF+S40KWYbGcCXyVHkq2Qb1XVK3lopDxZ75yeJQdpnyx49KwA==
X-Received: by 2002:a05:6000:1361:b0:349:9e18:9f73 with SMTP id
 q1-20020a056000136100b003499e189f73mr5218145wrz.67.1714041605094; 
 Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/37] target/arm: Handle IS/FS in ISR_EL1 for NMI,
 VINMI and VFNMI
Date: Thu, 25 Apr 2024 11:39:29 +0100
Message-Id: <20240425103958.3237225-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add IS and FS bit in ISR_EL1 and handle the read. With CPU_INTERRUPT_NMI or
CPU_INTERRUPT_VINMI, both CPSR_I and ISR_IS must be set. With
CPU_INTERRUPT_VFNMI, both CPSR_F and ISR_FS must be set.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-9-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08a6bc50de2..97997dbd087 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1398,6 +1398,8 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_N (1U << 31)
 #define CPSR_NZCV (CPSR_N | CPSR_Z | CPSR_C | CPSR_V)
 #define CPSR_AIF (CPSR_A | CPSR_I | CPSR_F)
+#define ISR_FS (1U << 9)
+#define ISR_IS (1U << 10)
 
 #define CPSR_IT (CPSR_IT_0_1 | CPSR_IT_2_7)
 #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPSR_Q \
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4ee59b37059..6b6d8a349a2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2021,16 +2021,29 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
+        if (cs->interrupt_request & CPU_INTERRUPT_VINMI) {
+            ret |= ISR_IS;
+            ret |= CPSR_I;
+        }
     } else {
         if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
             ret |= CPSR_I;
         }
+
+        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+            ret |= ISR_IS;
+            ret |= CPSR_I;
+        }
     }
 
     if (hcr_el2 & HCR_FMO) {
         if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
+        if (cs->interrupt_request & CPU_INTERRUPT_VFNMI) {
+            ret |= ISR_FS;
+            ret |= CPSR_F;
+        }
     } else {
         if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
             ret |= CPSR_F;
-- 
2.34.1


