Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B9CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuK-00043h-7D; Fri, 01 May 2026 06:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuG-00041j-Qp
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuF-0000Cs-4M
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so19479275e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630533; x=1778235333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ErZn9qmgXZtVOOp/Xbnqo1NJ59jCbutyDEpe1t2jpNk=;
 b=pOGxbXOSxh14t82MqsQAZX2KtcTHkrg8XyhfHPD0jsYwbzOkw/+6aWQ/o/qay5WK3Y
 +h3vOO7oEmJqiz2nLgM1aaau13FUER1kxDJDUMZjq2Nhtz06VAttL3TGEI925sOJdHJ2
 LzBX1zt3odvGUoyMdijR1j6meEZ1hbgau6ZY0Fs46IuIBCKqi/cHjj6vqbaOrHM/BUxR
 9CtVTYOSVOOtQ6cSsXLDtd4Ft8LGtBaHuxv/zc0l7/sDBsb29fZUYZgCxUfdM6EIuy2R
 3w/EIEbjhn4+/htOOS7xdf6eZkWw6Qzh5zJ7Q/zxcD32iEKIWlZu0iadSzHEMbzObPYp
 V01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630533; x=1778235333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ErZn9qmgXZtVOOp/Xbnqo1NJ59jCbutyDEpe1t2jpNk=;
 b=GIeSVF0cndpRX/EgOHqsEIvoFpuknQdPGmLFlFEZx3NCEzs/5PTh9Mu9rmeO51/7SN
 UZNOJzGNMVcuJjLHt918pehTjT6CuvAQ4h/gZ5gQ/mfTSxJnww2YUYESf31WtwG1+PPZ
 W7gGX45GwGKfSoIs0F70nTfaqloShgOB2lDVJ+FhgVhsoWHv7xmGHnJzGt3XqkFsLMFs
 cA+ilAYGOBcBx+8RT5DZ6M4i6wGgxppxH3XR9J7D4Dq27XxEkfEqFYBf7YgkIrL1hxNO
 jWX02XlYWykvie46+56T7Zcccf0NJHC8DL1Te2Nm1v9SmKRxjDYemi6hozFCqz0VmfCF
 CoUg==
X-Gm-Message-State: AOJu0YyT6d5TKL/KX68iiPxPawtlMlJDjYVjPrvJXn9ErC3IgVbWcIE9
 oNCRthTjQc7SLXARuyMS+1uM6wezN3Mi/1fBHQ3ObQDqcAE9MfNm1I+KMJd2AeBhAq/8cSaKDYU
 xcWGo
X-Gm-Gg: AeBDietYQxjyo57JISKM/cBpLUR0EUPD5P2tJaaPA8zQffZayGDkIrvRkT+wR1xjNF2
 IWcsf+AugJiQLMUadY89fOiYIpZBL5xxHYPNN1bgwClbz4gynjCNRCltpcsT0YVCRFeGMk4ch0o
 2rnoVTdKXbzH+6frnBZxEgyxh0bi/Pu6RRYyflaIyAdydBGt7eSni89AFFuwMGGuP9Q0Rd2WgtT
 kw5y947hpy+WBtTVqk1sfr+5excF3qp2uFYtCNkRut4stTfzeKhKejg1lQr5bwd1OLCcTo8uRrG
 HqSROs8J6ODH2muCeZTPF+C/AcUOyeeXSBY1u31qcmBQZmpiRzSoJYMxvgTzdCnU5yc2e3QlLDn
 L6pEPxcANdOO0ej0naHtlTITy8nNeYK4sNdhAD1HSnOuLBxvTPKonDqVGqtk8ummkxI9oxJkWRN
 8dICc3QyaUW7FYcigzFI3IEQSx3MYrnpEQOuTVRlEU8M+4r8//3mcE3dy/dE9tyj1qRq0goao1y
 oVQxpDfSh+8cywTmVYkLo/WXxE8rzosGg7YZ/Rz0A==
X-Received: by 2002:a05:600c:a119:b0:48a:75b9:5e07 with SMTP id
 5b1f17b1804b1-48a844f4de3mr80097015e9.11.1777630532647; 
 Fri, 01 May 2026 03:15:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/28] hvf: gate ARM_FEATURE_PMU register emulation when using
 the Apple vGIC
Date: Fri,  1 May 2026 11:14:57 +0100
Message-ID: <20260501101505.3485916-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

From Apple documentation:

> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>  hv_vcpu_exit_t object contains the information about this exception.

> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
> field of ID_AA64DFR0_EL1 register.
> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
> exceptions, which are sent to the guest.
> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.

However, despite what that documentation says this is actually gated on using the Apple vGIC
instead of nested virtualisation per se. Apple introduced both at the same time.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260429190532.26538-8-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fa0a22fdc3..9d64f2e1a5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1601,7 +1601,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1862,7 +1862,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.43.0


