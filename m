Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950AECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 07:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLx3-0001UK-N0; Fri, 22 Aug 2025 03:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upLx2-0001Tt-9f
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:12:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upLwz-0004Zr-8f
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:12:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a286135c8so14153155e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755846754; x=1756451554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gq5QaCBH3PfELDbEFJWuDYYvIi201XrAw2c4ht2gWNQ=;
 b=z2LONBNAl6YKSl28OjIjjSI2uG7Yxq7nnrsmuZe3DDxnC0toxiIyhW9zyrfkxCSnaS
 Ckzzwlxb88UOdIlR6pXz8lxEGH9hHsPsBeLA+QcmAPIk09YZE3ClVCbpICjc5xpBIBQb
 k44jJYpLrq58CoSyXfN72CPBJBH3kRjuFemQirtY3yGP7WGNVv/MF0aBJLKaCKnvCHx2
 2iq70f/ikazR0OILsSUULu80R49nfjDtuxzejBu7i0X9LbHxFadeUy+egpPDsQ6wNA+B
 6fST084CWLlKhg2MWb/LiI+fSdNZKvPYlEqeLXejUrjNyK9Z6xjxEJl4pJVhEsYRRQKx
 jHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755846754; x=1756451554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gq5QaCBH3PfELDbEFJWuDYYvIi201XrAw2c4ht2gWNQ=;
 b=YPnMSqT/V99GV6qEfK/vNTB5d9FdPPbrGbh0vpQFH27IbOokd1tZ1uI+cQprf/qT2m
 uckaMcZs3jc3RAGERLrCOEURDwczrPG/bQg5JxPi23BjIDmfle/8Btg83YZeMFMkmP22
 9+RFeuwFhrfERm4Hmp2hH+6jqJyRKiayB8lw7SaoOpK+cUtd25iv7iSBYpjHyCtZP/Rh
 9D8rM+HEFSv4eheLUYuRqzPZ70pdeAJH7IqC4ibEAwHcTuoQ1DNvUKMKPq2NLijMijRt
 U18dnHS2/i7M/KgKtZeQeHj07ZPHsiJwb6JH59RBdeKIXgIbXuU0FU3MjN4mAqpN2Oac
 YQhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeCvAvzizKbbsZyDEWITJfsGmBpbJ+RQwPNSqPbGH8G7W1CUsjWjtnN9/7NSuNOW7V0EnnRCbg+2hD@nongnu.org
X-Gm-Message-State: AOJu0YyFQX83E/DcK9X4xwkg+v9JP2iJ3RJIEhhsT07Ynq+U0PDQQt4b
 Sz5MPLUbhYn1SXcPsQhgSogida1O3BCeV8ZA4tq1gQ3xSO817P8diiYH5lY2s30iuho=
X-Gm-Gg: ASbGnctTgjST+wakRfYPoK8e9er2TL1+y9HNP0MRanW/0vdqKPOsvr6EhVXg34Rqihn
 RZBYGWO0aVIaRITH1kqz41W+PAn6pHRs0HtB9YHAoqHgMwL7qJDrdJ7AhRBUidTt9nJKzqHK4tT
 fP3ODHfyrOfrAmskw2Y7pijZuF2bUQBPtFjxJIafVG1ZDIcNiL+4QUb3flfsIiPFqMVeDdmkRnw
 z0PtyZvJXSI7b6VY0u9bpVRk3ZjqzHvtCHkfHlP+Js1jhEDok4r3A2ufcIcwThc54QujkWlXWMQ
 aNUOeKpQF01x0FVmQcHyk7Zpamq95WJRWl0i0/EGXACzlovBxM5TxFbCyZCOQU006wmhIMCTj8c
 mpO+gVz7XviRiQvedMJAWd/nuMIy+KOL8sC0TKlRsClF9dSwmX2/hC8AkZlbsdjWTWwfj9iU=
X-Google-Smtp-Source: AGHT+IGVzjuhpaG5yMsdrzuR+WXPPp7DLAK+ZnK6fOJf7EKeoavE+Pjmc0KY0Q0GNJZxIvzLBzIwBQ==
X-Received: by 2002:a05:600c:45d4:b0:45b:47e1:ef7b with SMTP id
 5b1f17b1804b1-45b5179e933mr15306545e9.17.1755846754346; 
 Fri, 22 Aug 2025 00:12:34 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8ae6aasm26713045e9.5.2025.08.22.00.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 00:12:33 -0700 (PDT)
Message-ID: <19837997-57c3-47b7-ab25-f8bad6bd3d4f@linaro.org>
Date: Fri, 22 Aug 2025 09:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] kvm/arm: implement a basic hypercall handler
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alexander Graf <graf@amazon.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
 <20250617163351.2640572-11-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250617163351.2640572-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 17/6/25 18:33, Alex Bennée wrote:
> For now just deal with the basic version probe we see during startup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/kvm.c        | 44 +++++++++++++++++++++++++++++++++++++++++
>   target/arm/trace-events |  1 +
>   2 files changed, 45 insertions(+)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0a852af126..1280e2c1e8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1507,6 +1507,43 @@ static int kvm_arm_handle_sysreg_trap(ARMCPU *cpu,
>       return -1;
>   }
>   
> +/*
> + * The guest is making a hypercall or firmware call. We can handle a
> + * limited number of them (e.g. PSCI) but we can't emulate a true
> + * firmware. This is an abbreviated version of
> + * kvm_smccc_call_handler() in the kernel and the TCG only arm_handle_psci_call().
> + *
> + * In the SplitAccel case we would be transitioning to execute EL2+
> + * under TCG.
> + */
> +static int kvm_arm_handle_hypercall(ARMCPU *cpu,
> +                                    int esr_ec)
> +{
> +    CPUARMState *env = &cpu->env;
> +    int32_t ret = 0;
> +
> +    trace_kvm_hypercall(esr_ec, env->xregs[0]);
> +
> +    switch (env->xregs[0]) {
> +    case QEMU_PSCI_0_2_FN_PSCI_VERSION:
> +        ret = QEMU_PSCI_VERSION_1_1;
> +        break;
> +    case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> +        ret = QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No trusted OS */
> +        break;
> +    case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
> +        ret = QEMU_PSCI_RET_NOT_SUPPORTED;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unhandled hypercall %"PRIx64"\n",
> +                      __func__, env->xregs[0]);
> +        return -1;
> +    }
> +
> +    env->xregs[0] = ret;
> +    return 0;
> +}
> +
>   /**
>    * kvm_arm_handle_hard_trap:
>    * @cpu: ARMCPU
> @@ -1538,6 +1575,13 @@ static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
>       switch (esr_ec) {
>       case EC_SYSTEMREGISTERTRAP:
>           return kvm_arm_handle_sysreg_trap(cpu, esr_iss, elr);
> +    case EC_AA32_SVC:
> +    case EC_AA32_HVC:
> +    case EC_AA32_SMC:
> +    case EC_AA64_SVC:
> +    case EC_AA64_HVC:
> +    case EC_AA64_SMC:

Should we increment $pc for SVC/SMC?
The instruction operation pseudocode [*] is:

   preferred_exception_return = ThisInstrAddr(64);

[*] 
https://developer.arm.com/documentation/ddi0602/2022-06/Shared-Pseudocode/AArch64-Exceptions?lang=en

> +        return kvm_arm_handle_hypercall(cpu, esr_ec);
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
>                   __func__, esr_ec, esr_iss, esr_iss2, esr_il);
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 69bb4d370d..10cdba92a3 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -15,3 +15,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>   kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>   kvm_sysreg_read(const char *name, uint64_t val) "%s => 0x%" PRIx64
>   kvm_sysreg_write(const char *name, uint64_t val) "%s <=  0x%" PRIx64
> +kvm_hypercall(int ec, uint64_t arg0) "%d: %"PRIx64


