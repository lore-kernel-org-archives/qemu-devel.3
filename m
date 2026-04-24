Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3FFB44C5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAlY-0002Mf-G5; Fri, 24 Apr 2026 03:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAlQ-0002La-MQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:15:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAlJ-0000Kh-JZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:15:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ba840146so67129225e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777014940; x=1777619740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aO+pVKRE5JjEtTa4KGnF+otF0zYfiNqJ2NW6e07bi7s=;
 b=Cbh3i52pqpgEEWJXF/M9vlXJkZ7p7XEu48RMTjLb7TbsqdlFq8HKev3FymoTTLYy73
 OCe8yQAG6+WDRgs9UYHyFP7H4W5rcnaPryoGz9jxV0pnIWblbNEYGT6K02QuFnEj8Zmb
 3Ohdr/bwwGwhIfIEhtYdSQd0TLN/DahGDu2SQbK3acZH/Ppdg1h8dhjtR3yffoZHVq4B
 tRIcTaOkvprTPnx6Xe3XYxb5tPOu4AP35Z8J5AwgqhyiMct08kanIqOusNREa9vIgOnw
 iIpfkYApQ6P3f0vWykrcSFfk2IdcWeyDLhw5SVHQLJcTVIbBtgYyrXUuZgR3I/wbK4Pa
 C4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777014940; x=1777619740;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aO+pVKRE5JjEtTa4KGnF+otF0zYfiNqJ2NW6e07bi7s=;
 b=GG8r0BGfegIXNPuJz6gHEXzvUdCaIYJZLURiIPr2OxZl2tOYgDR+awkJgjF/wNAH7z
 8lMocscOhXrjghsj0cMBrlGDayfXz4I+MQwCOs2dWMRm2/grvA2V1vT49x1d2z33mcPe
 qxvrjLQUToky+dR4x3hsL2PRShBj09RgPiAn9gp+ifbsg6N+bqf1bYGjC8syMTGsPZua
 7grLZA6ojkR7Nsyi6PsE6KT5BVioFpOOaBInk613gAKAlDymXH5BlG5Qf8SzUq3LLgn9
 dyc5rgUoBoVMkFJuvO180HHH+ZfWqvAXC4enRsvUNTrMnQ7jfwdaZOq1JALJS0aeGcOK
 /XVA==
X-Gm-Message-State: AOJu0Yx8pebNbPFqrNgrwQ8Pm7GznuqKPynNxHRZyVLE31SjwquDOAat
 OU7WlNXOLHrPv+vY9BLPzO2LV3Ho/IUdx5sKuWKgFqcqAs4DFql49Ng+mIWCDWH0T3hjQmrKTOO
 1t0hClvc=
X-Gm-Gg: AeBDiet6H5hp6lCRh/6C33ATFZ7m2oiqcClsKYWAYqOTNYFUn5mVkgeVt/HFEtMuptn
 TKQc2kGTIJcnkhoQHEWBiGY4ic3rvCIEg5j4D8P82zTT1QW0gJgj8PjUqEa8KetKQZ7MiGklSqz
 3IMKLNecOLcXROcAKxxwqesiEzHovQlOFhTzVWG4x0qNHJ51VDSVKKuOogfnUrCOyFv6kP6c48P
 O3IAt3xeARbFdJdkyGUtuvqbBIVCR4I/nhbN2vwMBwfF2wS4UWncRitbkYQQt75AuFGWqMCz5ux
 I/1tZmsUKfR9bhylnTNTOq6SpPRXGMaQuVPws9WbXjIXiezDW3GHbIlk3Fjo97HjT7rIcauCDAl
 flDbbu7JPtL3a/f9WD3urWkDYeVfNpA1Ahn8u2hzAcuttF889VUV7ZrKKqniFELpznrJuOwiPU4
 I19lG9vkmXAxLf6P3zELQGNKQJVxrHV9/S2RLcOAi2OBuTzoqFiecMrB0pGql8S4KI33Zywfked
 MxM84rFjMc+WcJL84XhPMqhs4ZZwq9jdcq+lSr22VnUnpdzGtVWJWY31Ve+hOMRTr/25nYR
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-488fb739cd9mr361725705e9.1.1777014940030; 
 Fri, 24 Apr 2026 00:15:40 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1cfbf2sm590660555e9.15.2026.04.24.00.15.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:15:39 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:15:26 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v20 07/15] hvf: gate ARM_FEATURE_PMU register emulation
 when using the Apple vGIC
User-Agent: meli/0.8.13
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-8-mohamed@unpredictable.fr>
In-Reply-To: <20260316130642.13246-8-mohamed@unpredictable.fr>
Message-ID: <tdzli2.3nqzzsd8i5ktn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Mon, 16 Mar 2026 15:06, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>From Apple documentation:
>
>> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
>> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>>  hv_vcpu_exit_t object contains the information about this exception.
>
>> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
>> field of ID_AA64DFR0_EL1 register.
>> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
>> exceptions, which are sent to the guest.
>> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
>> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.
>
>However, despite what that documentation says this is actually gated on using the Apple vGIC
>instead of nested virtualisation per se. Apple introduced both at the same time.
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/hvf/hvf.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index 04c4106a3e..c971aa8cce 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -1601,7 +1601,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
>     ARMCPU *arm_cpu = ARM_CPU(cpu);
>     CPUARMState *env = &arm_cpu->env;
> 
>-    if (arm_feature(env, ARM_FEATURE_PMU)) {
>+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
>         switch (reg) {
>         case SYSREG_PMCR_EL0:
>             *val = env->cp15.c9_pmcr;
>@@ -1862,7 +1862,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
>                            SYSREG_OP2(reg),
>                            val);
> 
>-    if (arm_feature(env, ARM_FEATURE_PMU)) {
>+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
>         switch (reg) {
>         case SYSREG_PMCCNTR_EL0:
>             pmu_op_start(env);
>-- 
>2.50.1 (Apple Git-155)
>
>

