Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017F1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWP-0001zK-8j; Thu, 25 Apr 2024 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWN-0001xm-1q
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWL-00079Z-BQ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:06 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51b09c3a111so1153259e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041603; x=1714646403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4h8d6UwgIGiFHRbvrM5SoXNPNiyUuHID0a2JGu04tl8=;
 b=bj/szA5oyR7tLutdUtFaONVA/nF7IIAw0DRks2cvxEECuL7yymK1xp71pGxilQjaeH
 Vfi6K+5xdXXz9wMoIi7o+vyyzn6OWgU4JbJ2IKQI6P6MPHKZGvVnG2CaP3X+569dhDHc
 S7hUgb1LPdnRP+/UUEvf7iKTnhG6KNQySURu/E8L7jZu30XtWKm2KezgspMyez8q1xd7
 r255IpmMSIGmlCqh7H9qQ5VLeFTwfT9YNiu481E40HER3V4wKKfao768uMqAcXcxg+l2
 1cx/qgV8UJJ30k/TdL3aqNDgB+e6hYStcsRWIMNPwi4gdaRmdxjQfgZVPIj2kmJCrK6f
 hZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041603; x=1714646403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h8d6UwgIGiFHRbvrM5SoXNPNiyUuHID0a2JGu04tl8=;
 b=W1VZ3nAvaYG5IDQDXvdNNWCw/cJsi3o4CbIjfKSsV4reoCt2RJOO1A97qTiThlD6aZ
 1JfvK2i4iRffRyyNICcKUpZD6YxpL0AP4WSXVk/FyKEbFbKjX+2+RJM8TH/5zJbWkdVT
 QMZVXenXLYsLOLwvQrQZ75knE+onYsyRcBirKT3CIY47D1tEhVcLUt7Lq5hHxhv81wvc
 o0hE3jqeptJ4VswOwpp9qfOyKL33NzeOp5icp8LxOY6cflEa2Ph5t4jbtkC68BnxTHRO
 WnB6ZgVV5bKlwkebJtf3c3APeRaUVZuKApKTLaOmopPcAqk+hfANLf+5of//Add/n/EF
 Rdrg==
X-Gm-Message-State: AOJu0YzlqTc0ejn0AQrPw1b9UJ1ypzli1A7+PdtDbdtjfFOmR9gXTRVw
 N6V6ffrDNLpAyeza/LDIaJIJe6lhzNwwUr3rZjP3cHlH3RauQM6ay1aeK3jwoIRj+E6MKMFZqze
 h
X-Google-Smtp-Source: AGHT+IHh7R2H3MrreGwb9lPEO2OFsfbTJ43qR6IFMxBlCW1GU2ireBotU1cVi9qXxWLF6cXy9cSyfA==
X-Received: by 2002:a05:6512:1384:b0:51c:76af:f87e with SMTP id
 fc4-20020a056512138400b0051c76aff87emr430998lfb.57.1714041603278; 
 Thu, 25 Apr 2024 03:40:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/37] target/arm: Support MSR access to ALLINT
Date: Thu, 25 Apr 2024 11:39:26 +0100
Message-Id: <20240425103958.3237225-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

Support ALLINT msr access as follow:
	mrs <xt>, ALLINT	// read allint
	msr ALLINT, <xt>	// write allint with imm

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-6-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7a25ea65c9a..b9443b1813a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7500,6 +7500,37 @@ static const ARMCPRegInfo rme_mte_reginfo[] = {
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 14, .opc2 = 5,
       .access = PL3_W, .type = ARM_CP_NOP },
 };
+
+static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    env->pstate = (env->pstate & ~PSTATE_ALLINT) | (value & PSTATE_ALLINT);
+}
+
+static uint64_t aa64_allint_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_ALLINT;
+}
+
+static CPAccessResult aa64_allint_access(CPUARMState *env,
+                                         const ARMCPRegInfo *ri, bool isread)
+{
+    if (!isread && arm_current_el(env) == 1 &&
+        (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo nmi_reginfo[] = {
+    { .name = "ALLINT", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 0, .crn = 4, .crm = 3,
+      .type = ARM_CP_NO_RAW,
+      .access = PL1_RW, .accessfn = aa64_allint_access,
+      .fieldoffset = offsetof(CPUARMState, pstate),
+      .writefn = aa64_allint_write, .readfn = aa64_allint_read,
+      .resetfn = arm_cp_reset_ignore },
+};
 #endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
@@ -9894,6 +9925,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nv2, cpu)) {
         define_arm_cp_regs(cpu, nv2_reginfo);
     }
+
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        define_arm_cp_regs(cpu, nmi_reginfo);
+    }
 #endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
-- 
2.34.1


