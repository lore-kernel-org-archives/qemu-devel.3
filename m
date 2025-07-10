Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1844BC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZssm-0002F8-ME; Thu, 10 Jul 2025 11:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZsqf-0000Qg-O9
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:06:09 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZsqc-00064N-Sd
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:06:09 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so714837fac.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752159965; x=1752764765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXFneuohW2JTYeRWvN54I5URuuJY2O/m/l/1PRDfWMY=;
 b=Ybm2eWd8AHn3qfQK4wXEdt3T8ILSRBAmmo0ovg+LgxmLr5bxpG7jOHNVUjXlWFgL6O
 +41m+gRrAUTaRnGS1FqMybekWfETcYXogJVDZuyKJarcTeZXYwme6LT8zbagGxDW65oz
 kVtxjJnbeZXbwiN+n5tWwlGDU/xa+nwL5KdFFdABm2M2/O99illWcFWyN3HlLsIkoUrQ
 xSi1INx1tSV6LqtiInKangc3wldfyw9MvZpQLFGjgZQEOKJmEvmHJNVvzPcOcOnZngLt
 r16ZrmL4CuEb9Ww3HIGhxgBaOojcqzCthGAN8hR4LanPcQbHbggiptglSV8/+p18LXuq
 SLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752159965; x=1752764765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXFneuohW2JTYeRWvN54I5URuuJY2O/m/l/1PRDfWMY=;
 b=h1HjZe8rk+xrq3aihs/AlLwjaRUNm4oRw2v7NEYA8g+P8RA+pyTfI4trfWtZ2Jm338
 v6RWf5Yhmj2k4JilH+IppwYn4VkLy0eezHXqHXsXU9LudRxORHHhKIqot368uT4pVhNy
 uMndEabeMetg8eoJwhkk52Pml+6blmVTOPWXVJocsUEchUKm4rhKI7QhQqhgdDWcAjOW
 OwiVDbFTphyVnS5MkS2R58SYYLfgbCpkivu+qJCt4uOEifTU3GvNeFP9AOzHtV/wcZZ0
 LeA2G+5/YPRzVrlN8MccEcTprf4US+UyRWxtzz3/DcUpe34gzVk0snSQBMQCCVwqLqKP
 Vh+w==
X-Gm-Message-State: AOJu0YxJMVrtp+CedFgiiwMV4fHSUUmUaDy8zZ3vb4cDh8XqAOKQg38I
 QGp6AKrE9zZ+NPjle+PfAi9eQ8igXeRW9gBXc691prZ9YR4fyoJ4jSwXE9Mmtm/EyjLsua04L/R
 NsWxeCGA=
X-Gm-Gg: ASbGncv0D/MOYGZEtskqrdovPIxJ2Ilzy9uoE0JO2ibOtep7EHCszY/uwCsMmxjVW5y
 nNkXr9d/3Q5oTP2BImajCkMCOQjh00rUXWJPfxr37+YFJlbCK6+k4kH84vDGp+rxPbn8d9NR7/n
 MHMGMOEfvisfD5KfBu8jVFRiEPD+34t7jraA1cl3riyA+BlrxtndtEvkm/t5c9ZcgrpCLLtXCTA
 nuEJbnn5ye7pk38C/fLPoHsdESpYyohCpzyNzk3YGqxzWP+LTyQHYBsgiPCxQK6hUzT3P5eJlmJ
 6VQoXcyCB8pUQjr3h9dHDqoxCFqdsqW3HKKIrpU1OFolag9kAEnMDlFq8gh9wfaHaAXfw/WzlP8
 p0BI=
X-Google-Smtp-Source: AGHT+IH9e2wygTlOGNzC+9frJ75ZSCcBoQB0GyGefhyiaSTnJe4OBMuW4+A4F65LV/jywD+KTMconw==
X-Received: by 2002:a05:6870:e40c:b0:2bc:8c4a:aac2 with SMTP id
 586e51a60fabf-2fef875d724mr5210103fac.27.1752159964976; 
 Thu, 10 Jul 2025 08:06:04 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1172e579sm331299fac.45.2025.07.10.08.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:06:04 -0700 (PDT)
Message-ID: <c9b6afa4-d97f-44b7-9b69-3ae607834a2d@linaro.org>
Date: Thu, 10 Jul 2025 09:06:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] target/arm: Convert get_phys_addr_lpae to
 access_perm
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250707202111.293787-1-richard.henderson@linaro.org>
 <20250707202111.293787-4-richard.henderson@linaro.org>
 <CAFEAcA9UcPCQ5qqrM+Ao5hrOJ=xYgOJ6==WNDj0xPpr2qh-TfA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9UcPCQ5qqrM+Ao5hrOJ=xYgOJ6==WNDj0xPpr2qh-TfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 7/10/25 05:59, Peter Maydell wrote:
> On Mon, 7 Jul 2025 at 22:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/ptw.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 39ecc093a5..7503d1de6f 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -1643,14 +1643,14 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
>>    * @env: CPUARMState
>>    * @ptw: Current and next stage parameters for the walk.
>>    * @address: virtual address to get physical address for
>> - * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
>> + * @access_perm: PAGE_{READ, WRITE, EXEC}, or 0
>>    * @memop: memory operation feeding this access, or 0 for none
>>    * @result: set on translation success,
>>    * @fi: set to fault info if the translation fails
>>    */
>>   static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>>                                  uint64_t address,
>> -                               MMUAccessType access_type, MemOp memop,
>> +                               unsigned access_perm, MemOp memop,
>>                                  GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
>>   {
>>       ARMCPU *cpu = env_archcpu(env);
>> @@ -1678,7 +1678,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>>           int ps;
>>
>>           param = aa64_va_parameters(env, address, mmu_idx,
>> -                                   access_type != MMU_INST_FETCH,
>> +                                   !(access_perm & PAGE_EXEC),
>>                                      !arm_el_is_aa64(env, 1));
>>           level = 0;
> 
> This will treat a "don't check access permissions" call as
> a data-access (relevant for TBI), and means there's no way
> to say "do an address lookup for INST_FETCH but don't do the
> access-permission check". Is that what we want?
> We should at least comment this.
It does happen to be what we want for ats1a.
I can add a comment.

r~

