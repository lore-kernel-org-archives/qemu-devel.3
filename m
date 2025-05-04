Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B5AC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc6U-0008E6-Ly; Sun, 04 May 2025 12:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc6T-0008Dt-Ud
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:22:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc6S-0007m0-2k
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:22:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso4940400b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375726; x=1746980526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ndDhIW14pK8IkolQgEpyEOmdYP4fJJ6SOj1tajl/8JQ=;
 b=UyLz/HkgzVceObOFhbu+4IXora6M+V193ThSOhC7b1xny392Q7pwObU2f2lRxILM4R
 lSNCHoXROm39L8ptd3pLxv1rVYNdjg3wVcOFIHlWx2Gc6JU9OTU0RNnAXguKYbo8mz3B
 DOh5eokyDyAYCfTXpJz0WelhEKP8bCQxSwdcI5eOW6jKLx5rM3weqOJ/4+R/iC9tL3nF
 5r1NbDokQOkF2VJXj5+fkfcFRWJQDzWZWIAnMyOOZHmPQ49ZNJXxkS89/KB3BSH87rtN
 ZqNjcEt7TDmlpNkqBsjPWu/8AhtX3unP5bT344mwR0r53kSV+l0+DVL8fk4CoB6UQcQH
 bkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375726; x=1746980526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndDhIW14pK8IkolQgEpyEOmdYP4fJJ6SOj1tajl/8JQ=;
 b=Ksd39zWLclQ1zDkIwPx8EVG8WZDoFVfzxudAl5iGTemunsuyttupxeui+e+fqNZdrW
 IApdgrwzQrBpFXqtZK4OyIDQwlUIZmvHTWoa2REp/jiALCQHwRQydK/Vspp23NYNg+BU
 H3Omm9RwCOJ5Hk/dQ2+pfCWr3e4NZb8uW9/+Maupd1BfQEtWb+vdopD7VRBso6Uhr/5k
 3Axnnx6unQSmtRQ9mJmk4b0XUyzTB6ToM0zNtHmhFe6E6e2Ty0sYqWpPrKJkxpJcGmN9
 cYH175hwKuR2ak98qalq6PFDsJJ4IVhsIpIGE51mktL0umDTO0SLHh5EX0NoK75kt0UU
 J+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj/b6Ko9CdaREez7DirvOEizav00Y0OgZwMAvPWpcnuyo37oLDb5Lu4eGctmTl7ZilviVFI3AyMGMA@nongnu.org
X-Gm-Message-State: AOJu0YxinW4vlumIs/Wvr631DTEh/rrHu9U5GA+07OTEaeB0t8Kh5n6U
 pv5P5yy1j6M+130cixOy7dREHJ/XRNd9mVOW61yOiyIWNOqWbMjOLp4FPjGs2sA=
X-Gm-Gg: ASbGncvi/TIuyeNM/udwDUYPVDYMLGKZy2AGQcZTAhBLmJuDxhQ7UATLvyRejcK5dGw
 EQzqSCRaxNvluGf2Juo67HFqul2wO2QGSrnWLpCIjc4f8RtpWbIa695kmmbDYdQbBCKHx+H00bT
 52IRj8YGuhoBScNaQ5oOIDTtkMPRGhFGJ/4/osH0LE7t85wZVHHg8slEIygJnHdshRHAD1SmgX9
 1Pp31OM/9btjrL2w7ubWo0mLZ248kLHGQVMe34mb/8YaKS7F73Ak4nYwdH/8KC0iaGc2AWs5k0o
 Fjy73gxeLl8rS7I7mB/qzeQd9texy72Q5fpEicK/cgZ+zttRecYM8WGiJ65hz6D7bPEW09xNY8i
 ivQOE7TQ=
X-Google-Smtp-Source: AGHT+IHVJPSMpIDvkRNVyiQSjsJkxQ58q8D2M+vHLwC2ekg+35/hzKUAXwGeniC9hDYK89dJmepvyQ==
X-Received: by 2002:a05:6a00:4409:b0:73b:71a9:a5ad with SMTP id
 d2e1a72fcca58-740673faa0bmr8590456b3a.16.1746375725859; 
 Sun, 04 May 2025 09:22:05 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021090sm5039609b3a.116.2025.05.04.09.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:22:05 -0700 (PDT)
Message-ID: <2d9560be-1120-42f9-85db-69b8407c49b8@linaro.org>
Date: Sun, 4 May 2025 09:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 38/40] target/arm/machine: move cpu_post_load kvm bits
 to kvm_arm_cpu_post_load function
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-39-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-39-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h |  4 +++-
>   target/arm/kvm.c     | 13 ++++++++++++-
>   target/arm/machine.c |  8 +-------
>   3 files changed, 16 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index d156c790b66..00fc82db711 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -83,8 +83,10 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu);
>    * @cpu: ARMCPU
>    *
>    * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
> + *
> + * Returns: true on success, or false if write_list_to_kvmstate failed.
>    */
> -void kvm_arm_cpu_post_load(ARMCPU *cpu);
> +bool kvm_arm_cpu_post_load(ARMCPU *cpu);
>   
>   /**
>    * kvm_arm_reset_vcpu:
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8f68aa10298..8132f2345c5 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -977,13 +977,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
>       }
>   }
>   
> -void kvm_arm_cpu_post_load(ARMCPU *cpu)
> +bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>   {
> +    if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
> +        return false;
> +    }
> +    /* Note that it's OK for the TCG side not to know about
> +     * every register in the list; KVM is authoritative if
> +     * we're using it.
> +     */
> +    write_list_to_cpustate(cpu);
> +
>       /* KVM virtual time adjustment */
>       if (cpu->kvm_adjvtime) {
>           cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
>           cpu->kvm_vtime_dirty = true;
>       }
> +
> +    return true;
>   }
>   
>   void kvm_arm_reset_vcpu(ARMCPU *cpu)
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 868246a98c0..e442d485241 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -976,15 +976,9 @@ static int cpu_post_load(void *opaque, int version_id)
>       }
>   
>       if (kvm_enabled()) {
> -        if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
> +        if (!kvm_arm_cpu_post_load(cpu)) {
>               return -1;
>           }
> -        /* Note that it's OK for the TCG side not to know about
> -         * every register in the list; KVM is authoritative if
> -         * we're using it.
> -         */
> -        write_list_to_cpustate(cpu);
> -        kvm_arm_cpu_post_load(cpu);
>       } else {
>           if (!write_list_to_cpustate(cpu)) {
>               return -1;


