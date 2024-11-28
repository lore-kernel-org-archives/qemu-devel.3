Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2D3D69104
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe0g-0000zN-Cm; Thu, 28 Nov 2024 07:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGe0e-0000z8-LQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:52:40 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGe0c-0005hX-SH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:52:40 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-296252514c2so787650fac.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732798357; x=1733403157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sONac1UZTPlQJ79ugVwCXUUdJC3EvN/RS0YEjiIkD+A=;
 b=m8rBYITrzKCDO7HhiwhMreOgR+PDf4YlQRxzpOV3vORXGnSCbBBMuJRQLf4HXtLpOU
 ASE9EeHY9OlBQA8Ch97CeM6oXH4CKam8QGHbobZ5G5AMo6e3sqphYRWzqkhhVWMrFAvy
 pms6Asi+oA0unshD8u0H9U1Hwg9un06lO1veIT4WJKxTSZE7yMAkEks0keGn+mwK9p+y
 VRktqnVr6+olzdTwMztEeylHT6GRP0puosnClfs+9YSQnb1v2z3uOudyviRZsSbUNVGg
 xNgIHYuHhtqPf0mE0j2vOzVSUQ71YGa4+6c4KmqRHgD+RJRk/TWK8LrknPsO/V09oIpX
 EsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732798357; x=1733403157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sONac1UZTPlQJ79ugVwCXUUdJC3EvN/RS0YEjiIkD+A=;
 b=NxQ9gUjHdTRN5HL2lrukV6INm9qSLiIMvkTPR2osQVpWuNzQBpyFPQ/92wefhxXfy2
 PKtyGUuQLG0Fnmm+rP9/44Gh4uf83M0e4nW6MKBpikTgeggXN+eldM+LLFjCOJv+WrAg
 2SLSyrWuzGsVfs+SDdmeHjE2HN/dAyPrG2Z4abidvztaiMRN/VAhUZ80AAZH80fAu5BJ
 WFDfzCopdasBWpbF1n3GLuOrT8EL9hM/7QnNzalNrqxVRzTEUeZ89or6reNST4hspsFJ
 8SqHrOk4E4ov9Cl7kA+PMR/r5S4WeSOAxzJho19l1mQykWRWYg8qzkkhtUUAk7xx2PoU
 Ky/g==
X-Gm-Message-State: AOJu0Yw9CMUvpkkvFf2X5Lljh+/NsTWyRmaEJ8fnHN9gSroqg3WYUum3
 B6teiV1GCT8jOgB/4nMmZNeNWmpRWXPT84wiLgx2L47heMQB4xagxM6w1IRHGy9IjPPJeCzjZFY
 PSjs=
X-Gm-Gg: ASbGncsvi81kbRUDo7/S1m1/8NGc+gIQ/TbfgbUzId2Dbxkk52QZNAniRnxzP9DP+A5
 oknAaGc3gs6yNElz/lTp1lLMpHfFLNfPCgE/2WD27kljj4Xn53nI9wTyvbgA7mAg7NCtxyC0jtH
 +rYbx5Wtc4SQJC2WZPgsIR7A20XUt01vC+gnc+cCztoC4eR48Nvan5g/yxxHECf+vUL3zvJQqLq
 oLJMzWliVL4K/CGJZUFQ8OkmEB711vLmV8exxPNJfo6sA4lyeat2z1SHpiD4t9OQI7Xpi3JWu+M
 FFKTNGyMDMFQJ95vJsSdc7etzXht
X-Google-Smtp-Source: AGHT+IGwIxSXG2XsBke5Om0WA5f5lfpZHW5rlP0v2MV3Qa/I5hdapAG692Qg0i2Bc9F7NudBssNIHg==
X-Received: by 2002:a05:6870:f61b:b0:296:fff8:817 with SMTP id
 586e51a60fabf-29dc43933f5mr7290312fac.35.1732798357306; 
 Thu, 28 Nov 2024 04:52:37 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725432b6sm295531a34.20.2024.11.28.04.52.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:52:36 -0800 (PST)
Message-ID: <60013b3f-c886-405c-9d32-9834aec0cd2a@linaro.org>
Date: Thu, 28 Nov 2024 06:52:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] target/riscv: Support generic CSR indirect access
To: qemu-devel@nongnu.org
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-4-476d6f36e3c8@rivosinc.com>
 <3db7857b-0987-49f4-b39e-0cf69c3888b0@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3db7857b-0987-49f4-b39e-0cf69c3888b0@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 11/28/24 05:52, Daniel Henrique Barboza wrote:
> 
> 
> On 11/17/24 10:15 PM, Atish Patra wrote:
>> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>>
>> This adds the indirect access registers required by sscsrind/smcsrind
>> and the operations on them. Note that xiselect and xireg are used for
>> both AIA and sxcsrind, and the behavior of accessing them depends on
>> whether each extension is enabled and the value stored in xiselect.
>>
>> Co-developed-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
>> ---
>>   target/riscv/cpu_bits.h |  28 ++++++++-
>>   target/riscv/csr.c      | 149 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 171 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index 385a2c67c24b..e13c5420a251 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -173,6 +173,13 @@
>>   #define CSR_MISELECT        0x350
>>   #define CSR_MIREG           0x351
>> +/* Machine Indirect Register Alias */
>> +#define CSR_MIREG2          0x352
>> +#define CSR_MIREG3          0x353
>> +#define CSR_MIREG4          0x355
>> +#define CSR_MIREG5          0x356
>> +#define CSR_MIREG6          0x357
>> +
>>   /* Machine-Level Interrupts (AIA) */
>>   #define CSR_MTOPEI          0x35c
>>   #define CSR_MTOPI           0xfb0
>> @@ -222,6 +229,13 @@
>>   #define CSR_SISELECT        0x150
>>   #define CSR_SIREG           0x151
>> +/* Supervisor Indirect Register Alias */
>> +#define CSR_SIREG2          0x152
>> +#define CSR_SIREG3          0x153
>> +#define CSR_SIREG4          0x155
>> +#define CSR_SIREG5          0x156
>> +#define CSR_SIREG6          0x157
>> +
>>   /* Supervisor-Level Interrupts (AIA) */
>>   #define CSR_STOPEI          0x15c
>>   #define CSR_STOPI           0xdb0
>> @@ -288,6 +302,13 @@
>>   #define CSR_VSISELECT       0x250
>>   #define CSR_VSIREG          0x251
>> +/* Virtual Supervisor Indirect Alias */
>> +#define CSR_VSIREG2         0x252
>> +#define CSR_VSIREG3         0x253
>> +#define CSR_VSIREG4         0x255
>> +#define CSR_VSIREG5         0x256
>> +#define CSR_VSIREG6         0x257
>> +
>>   /* VS-Level Interrupts (H-extension with AIA) */
>>   #define CSR_VSTOPEI         0x25c
>>   #define CSR_VSTOPI          0xeb0
>> @@ -863,10 +884,13 @@ typedef enum RISCVException {
>>   #define ISELECT_IMSIC_EIE63                0xff
>>   #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
>>   #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
>> -#define ISELECT_MASK                       0x1ff
>> +#define ISELECT_MASK_AIA                   0x1ff
>> +
>> +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
>> +#define ISELECT_MASK_SXCSRIND              0xfff
>>   /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
>> -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
>> +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
>>   /* IMSIC bits (AIA) */
>>   #define IMSIC_TOPEI_IID_SHIFT              16
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index c91a26a52ef6..57e9c9e25f02 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -306,6 +306,17 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
>>       return any32(env, csrno);
>>   }
>> +static RISCVException csrind_any(CPURISCVState *env, int csrno)
>> +{
>> +    RISCVCPU *cpu = env_archcpu(env);
> 
> It is desirable to avoid env_archcpu() calls because it's a bit costly.

No, it's not.  You're thinking of RISCV_CPU, with the qom dynamic cast assert.
env_archcpu is one subtraction.


> If you're
> doing something else with the RISCVCPU pointer then it is what it is, but if you
> want it just to access cpu_cfg you can use riscv_cpu_cfg(env).

... but using riscv_cpu_cfg is still a good idea here.  :-)


r~

