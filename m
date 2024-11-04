Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D65FD132D3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7y47-0005lB-Bf; Mon, 04 Nov 2024 09:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7y46-0005ko-2c
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:28:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7y44-0001WY-8H
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:28:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20e6981ca77so44864955ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730730499; x=1731335299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ESl+iGLPzsB1AzAb5/vx0YGyULMc6i4rrVJE+Xl3loo=;
 b=ucLJVS509Gq7lQWeYKY35G6TfSoDSUSXa1u128zoy1V+329FUPnqewViQrc7vCf8YH
 wjmGsnVaxzbRi2+ymjEuc/JYJfiP7T03ws9wHj8oojQ8kG20CkrFQkNaJgcxsMIGI6p2
 5TBtnGZAH7KkGujngMRnrLKnJ+oeQPx5a0NpjbE4vOIWjxh0YsCIe37SeCblIzNsGJhL
 /jJPKjqlSSZDDfTPxBh9JohHwqpa/qyLjAdJ5jUsgO4rSU8M26hbjlTbPtJxmU2IdbjN
 X5lvK8krEknEo/tZAoOAsKsoqfHa9QRrMuyMTlcqHYu2eBojgiXSBfhA1XvlviihKX6d
 TYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730730499; x=1731335299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESl+iGLPzsB1AzAb5/vx0YGyULMc6i4rrVJE+Xl3loo=;
 b=MGzY2EF2ffxlYLKvkD5phJT/CjTiTBhKoLVE34OpTp4o4k6NOgfD6zz07rEa7ERH5a
 2pX+biet5gZ12DGy0lFbf90GrvArbwWMXjd5Vg86c3r/eaEaCKsNR/JTt89ZmDQ8ThDb
 BV1lmW5PoPBxrOiqOePvjoB/Xct4Wdluk8gHqpqkEVPGcaYmokw8YG+y7lHnV1jfhRBO
 93paYpEIdGEFlxzm4AWsoI0nhhe7ZdnGmuz24icGQILbERzCxu7ugCrximAU1gylbltP
 wb9+zdU12hAL9BmAsfJwur2M1I3pLlGpAjus7yseOe0Z0wwr0lDqI+BMVWlVz8lihvn/
 j35w==
X-Gm-Message-State: AOJu0YzDhOp/upmp4lvreUFx7FxypNNJq/EXj0mkCjgoIJTF7DGAxiR7
 aKN0nTqqyUGHS4UTjNYwZjGueocOryAauG5XKDANPnulK4fW3pep0QZEETvAzm4=
X-Google-Smtp-Source: AGHT+IGyUL5IH5ekTT0KKYcrtAR2/+dluIPbZy4HZ/0VNaB+CGHELKBSAjlVGUPqechxiGcHo5UErg==
X-Received: by 2002:a17:903:943:b0:205:68a4:b2d8 with SMTP id
 d9443c01a7336-21103aaa063mr238331515ad.11.1730730498820; 
 Mon, 04 Nov 2024 06:28:18 -0800 (PST)
Received: from [192.168.0.102] (200-207-104-238.dsl.telesp.net.br.
 [200.207.104.238]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2110571b6e9sm61134935ad.116.2024.11.04.06.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:28:18 -0800 (PST)
Message-ID: <c3b41710-e0b0-45fc-b974-6e4a0cfebaa4@linaro.org>
Date: Mon, 4 Nov 2024 11:28:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Enable FEAT_CMOW for -cpu max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20241101013541.883785-1-gustavo.romero@linaro.org>
 <CAFEAcA-aNf7ca1jYc0YnzSYKjvC42u178gmFTB+5p+TSgz0MfA@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA-aNf7ca1jYc0YnzSYKjvC42u178gmFTB+5p+TSgz0MfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Peter!

On 11/4/24 10:38, Peter Maydell wrote:
> On Fri, 1 Nov 2024 at 01:36, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> FEAT_CMOW introduces support for controlling cache maintenance
>> instructions executed in EL0/1 and is mandatory from Armv8.8.
>>
>> On real hardware, the main use for this feature is to prevent processes
>> from invalidating or flushing cache lines for addresses they only have
>> read permission, which can impact the performance of other processes.
>>
>> QEMU implements all cache instructions as NOPs, and, according to rule
>> [1], which states that generating any Permission fault when a cache
>> instruction is implemented as a NOP is implementation-defined, no
>> Permission fault is generated for any cache instruction when it lacks
>> read and write permissions.
>>
>> QEMU does not model any cache topology, so the PoU and PoC are before
>> any cache, and rules [2] apply. These rules states that generating any
>> MMU fault for cache instructions in this topology is also
>> implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
>> MMU faults either, instead, we only advertise it in the feature
>> register.
>>
>> [1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
>> [2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   docs/system/arm/emulation.rst | 1 +
>>   target/arm/cpu-features.h     | 5 +++++
>>   target/arm/cpu.h              | 1 +
>>   target/arm/tcg/cpu64.c        | 1 +
>>   4 files changed, 8 insertions(+)
>>
>> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
>> index 35f52a54b1..a2a388f091 100644
>> --- a/docs/system/arm/emulation.rst
>> +++ b/docs/system/arm/emulation.rst
>> @@ -26,6 +26,7 @@ the following architecture extensions:
>>   - FEAT_BF16 (AArch64 BFloat16 instructions)
>>   - FEAT_BTI (Branch Target Identification)
>>   - FEAT_CCIDX (Extended cache index)
>> +- FEAT_CMOW (Control for cache maintenance permission)
>>   - FEAT_CRC32 (CRC32 instructions)
>>   - FEAT_Crypto (Cryptographic Extension)
>>   - FEAT_CSV2 (Cache speculation variant 2)
>> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>> index 04ce281826..e806f138b8 100644
>> --- a/target/arm/cpu-features.h
>> +++ b/target/arm/cpu-features.h
>> @@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
>>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
>>   }
>>
>> +static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
>> +}
>> +
>>   static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
>>   {
>>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 8fc8b6398f..1ea4c545e0 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1367,6 +1367,7 @@ void pmu_init(ARMCPU *cpu);
>>   #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
>>   #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
>>   #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
>> +#define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
>>   #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
>>   #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
>>   #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>> index 0168920828..2963d7510f 100644
>> --- a/target/arm/tcg/cpu64.c
>> +++ b/target/arm/tcg/cpu64.c
>> @@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>       t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
>>       t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
>>       t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
>> +    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
>>       cpu->isar.id_aa64mmfr1 = t;
>>
>>       t = cpu->isar.id_aa64mmfr2;
> 
> We don't need to do anything for the actual cache operations,
> but we do need to make sure that the SCTLR_ELx and HCRX_EL2
> control bits for it can be set and read back. Our sctlr_write()
> doesn't impose a mask, so no change nedeed there, but
> our hcrx_write() does set up a valid_mask and doesn't allow
> the guest to write bits that aren't in that mask. So we
> need to add an
>     if (cpu_isar_feature(aa64_cmow, cpu)) {
>         valid_mask |= HCRX_CMOW;
>     }
> in there.

Ough. Sure! Fixed in v2. Thanks a lot.


Cheers,
Gustavo

