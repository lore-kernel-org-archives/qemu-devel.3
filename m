Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A306C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC61-00011K-QW; Mon, 04 Mar 2024 12:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhC5z-0000zu-84
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:27:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhC5x-0008Ap-AU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:27:22 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so40741225ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709573240; x=1710178040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTd0DPsfURrIrCcbXM8PEnn29nN7bPwAfFryTCWeXxo=;
 b=CXEVEodrb8qKjwMKMlKIqs7rWD60MoykPW5Us5eApxAlEXeyGviT9PLT+LijvcJjrc
 D45HYg8SvB2dKFLezXqhfUmApEL8I50tiIIcEgMhxn0fjRNnIcp21bMin6E7tPClEyL3
 nMG7s9xajYTfyrqayaW+fnXnnTjzylNq6G69iS1DqjO0555RHnvR2zz2HSC/JaDS3EPa
 Hj+ewmDLRtAH4L4Uh6OnpOmGF96HS593Mt24NNk5vZSWO8sto2X6k/HpoT2ZFE91VnuQ
 iMCmdztl2A0pPvPHjmoVTi8uaJ3iAFdO110u8eZYLaNXtJVLzePOpJKxPIA5m3gxJmzx
 ZWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573240; x=1710178040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTd0DPsfURrIrCcbXM8PEnn29nN7bPwAfFryTCWeXxo=;
 b=Pw1mttsgcx/3aaTJTCTbkCVJ+TWOUl+b3lmZedfwnWcKJaXurZuk/ESmG6Hga9Wud3
 fNsuH6vsYt/V2cIoGXoiU4Z9PE54ZZZ3rEUljH/wcNyX/Aqqf8ED4CsVfCjQU5qpTvOO
 6mMng22KG4fdnhwVJ6ta44193M1JzlCg/yij1GViFUncuckqiGAfqjVMuhqUTeyKPIwZ
 NonfzHnuuGAJWJ7oveenGxkKmK3LYhlks3xTOKlGsvv+c8/7ckQ6eZg3Rn/9urXmv905
 v354O49uKjoQBbeROXoNdA3fBITUidzGQS+plBK6MFrdS6k2QEveRXdiYDPAFiS7i9TW
 Kn4Q==
X-Gm-Message-State: AOJu0Yw7gL4Gojng2n7E1dUN9AGw7Yx16gN2dqyBuKhusfU0ZNgF69tV
 OxkSh8SYwsliuDhhX6KMCmtpdTWze3jBLVQHj8zm3QW/fDgSCiMQFA2ZaoJqQyA=
X-Google-Smtp-Source: AGHT+IFUGsJkDt9uTKjLZK7W8KXo1apQ4Vye2imTJARpyht8aIM2xk0ji/kgdj73/F4LgUP2ys5MeA==
X-Received: by 2002:a17:902:da87:b0:1dc:c8b3:9376 with SMTP id
 j7-20020a170902da8700b001dcc8b39376mr202158plx.7.1709573239680; 
 Mon, 04 Mar 2024 09:27:19 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 a8-20020a170902b58800b001d9b537ad0bsm8737336pls.275.2024.03.04.09.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:27:19 -0800 (PST)
Message-ID: <8f571406-4192-4be7-ac24-f23a06690cab@linaro.org>
Date: Mon, 4 Mar 2024 07:27:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] target/arm: Do memory type alignment check when
 translation enabled
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-7-richard.henderson@linaro.org>
 <CAFEAcA-RCuHCR18q6V+xGi_igE-7-+PUrX1eOjduJeeeWFq7EA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-RCuHCR18q6V+xGi_igE-7-+PUrX1eOjduJeeeWFq7EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/4/24 07:10, Peter Maydell wrote:
> On Fri, 1 Mar 2024 at 20:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> If translation is enabled, and the PTE memory type is Device,
>> enable checking alignment via TLB_CHECK_ALIGNMENT.  While the
>> check is done later than it should be per the ARM, it's better
>> than not performing the check at all.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> +    /*
>> +     * Enable alignment checks on Device memory.
>> +     *
>> +     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
>> +     * should have priority 30, while the permission check should be next at
>> +     * priority 31 and stage2 translation faults come after that.
>> +     * Due to the way the TCG softmmu TLB operates, we will have implicitly
>> +     * done the permission check and the stage2 lookup in finding the TLB
>> +     * entry, so the alignment check cannot be done sooner.
>> +     */
> 
> Looks like in rev J.a the priority list has had some extra entries
> added, so these are now items 35, 36 and 37 in the list.
> Maybe we should drop the numbering and say
> 
>   * Per R_XCHFJ, this check is mis-ordered. The correct ordering
>   * for alignment, permission, and stage 2 faults should be:
>   *    - Alignment fault caused by the memory type
>   *    - Permission fault
>   *    - A stage 2 fault on the memory access
>   * but due to ...
> 
> ?
> 
>> +    if (device) {
>> +        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
>>      }
> 
> In v7, the alignment faults on Device memory accesses are only
> architecturally required if the CPU implements the Virtualization
> Extensions; otherwise they are UNPREDICTABLE. But in practice
> QEMU doesn't implement any CPU types with ARM_FEATURE_LPAE
> but not ARM_FEATURE_V7VE, and "take an alignment fault" is
> something that the UNPREDICTABLE case allows us to do, so
> it doesn't seem necessary to put in a check for ARM_FEATURE_LPAE
> here. We could mention it in the comment, though.
> 
> I propose to fold in this comment diff and take the patchset into
> target-arm.next:
> 
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2141,12 +2141,19 @@ static bool get_phys_addr_lpae(CPUARMState
> *env, S1Translate *ptw,
>       /*
>        * Enable alignment checks on Device memory.
>        *
> -     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
> -     * should have priority 30, while the permission check should be next at
> -     * priority 31 and stage2 translation faults come after that.
> -     * Due to the way the TCG softmmu TLB operates, we will have implicitly
> -     * done the permission check and the stage2 lookup in finding the TLB
> -     * entry, so the alignment check cannot be done sooner.
> +     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
> +     * for alignment, permission, and stage 2 faults should be:
> +     *    - Alignment fault caused by the memory type
> +     *    - Permission fault
> +     *    - A stage 2 fault on the memory access
> +     * but due to the way the TCG softmmu TLB operates, we will have
> +     * implicitly done the permission check and the stage2 lookup in
> +     * finding the TLB entry, so the alignment check cannot be done sooner.
> +     *
> +     * In v7, for a CPU without the Virtualization Extensions this
> +     * access is UNPREDICTABLE; we choose to make it take the alignment
> +     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
> +     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)

Looks good, thanks for the update.


r~

