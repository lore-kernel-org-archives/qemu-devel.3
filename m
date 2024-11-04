Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B26D132D3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yC6-00086n-Mw; Mon, 04 Nov 2024 09:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7yC5-000867-F7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:36:37 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7yC3-0003Wu-RV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:36:37 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-723db2798caso833163b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730730994; x=1731335794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8M/FL/xjMX5xGJffF8YSjnj9dbeNo9YjNKE+lvn3Qw=;
 b=GGhh8EkrjUgks9y5SvLCn+5QD+6fH8e/ZrA2SITNDPM2o1lXypCrGTuXOcdfjTiRM7
 EC9kD8pgVvfASJUaGyinFytY87rHaS0VR8MpUaDfKEpJvJSNxnRQps2h6MbwAoqCf+wn
 gqYI8rhG6tlGgzL/Go8096RRL4oeIaZho/qtQ71yF0m1VJDX+wokbpynaubFdxAn22X8
 UhyrWaDJD2AkDFyOlKrpT7nQK1tDiPGkI9/zAc06AEC0QcAO6m6oAZixPwSdW6WVBIOI
 RgoHfqmC1Hir83MImaJITi4/IZ6hIBlLNSWFN21D/XMQhrBH+qSb16oxpyHmsAz6cadt
 nSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730730994; x=1731335794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8M/FL/xjMX5xGJffF8YSjnj9dbeNo9YjNKE+lvn3Qw=;
 b=uVcm6eLkDVQ+o6gWSarvYar63P8mHH/lyT9kN7ZEQf+tTOmjgZw03lApwPiOJxOkw9
 DUztdunQQulLuSjkdET/ZfyRdWbVObkIU8v6iFXdykXLE2wBZDxHXJM1Pl/FNtWDiQZn
 lu0chrc1Vu9pYzvpTi+8Jk0aHLXrSKoxfnrZgWJ2Q2w1Cr/s/2mCdfFv7ODZUeFvBo2c
 KAu5mVDzfEbR0ii6f8iP/PkcvrSlECLCKtKEeYOC+wMs55RC1Pz0/Df+3YKnkVRBT66+
 f5vzFPgskV2Uo5VbtRhQ8c1/TUqfL+qMQSg4iGjmviR0HEgJbX9IHLCvwiaXvaF/5L1e
 efgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg7yqYQ2octpLv4nLRi4hiKm1hElQnEnO8tGco0qEdiS/wdfr6evSRSyPGWadPFWSOAo+2BvcfU59U@nongnu.org
X-Gm-Message-State: AOJu0YyNixj1fpy2B+UUpNrRqDHmKMJNtJnEuOtmzpGT/Rg8elSN53ca
 +VmTlTR2gLrf4l4okhkIKK31rA2FFOLl1NLJddTYyBIhUlgfMgqZ9N9CpedG671XqGWOVrgGa9h
 B
X-Google-Smtp-Source: AGHT+IEfofvv++LSViFzOXpu2nP2BPbSQMPosmxNaaD7qa8vvCNAbxofsOIg6HSuELn7xjsAi8QeYQ==
X-Received: by 2002:a05:6a20:121a:b0:1db:a33e:2c6 with SMTP id
 adf61e73a8af0-1dba33e02f1mr13030321637.18.1730730994211; 
 Mon, 04 Nov 2024 06:36:34 -0800 (PST)
Received: from [192.168.0.102] (200-207-104-238.dsl.telesp.net.br.
 [200.207.104.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1e592asm7530342b3a.60.2024.11.04.06.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:36:33 -0800 (PST)
Message-ID: <d8827389-1de1-45b6-b572-33c6697f3b13@linaro.org>
Date: Mon, 4 Nov 2024 11:36:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Enable FEAT_CMOW for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20241101013541.883785-1-gustavo.romero@linaro.org>
 <9994b8dd-0522-43ff-94ff-1a94aafd5ce2@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <9994b8dd-0522-43ff-94ff-1a94aafd5ce2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Richard,

On 11/4/24 07:59, Richard Henderson wrote:
> On 11/1/24 01:35, Gustavo Romero wrote:
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
>>   docs/system/arm/emulation.rst | 1 +
>>   target/arm/cpu-features.h     | 5 +++++
>>   target/arm/cpu.h              | 1 +
>>   target/arm/tcg/cpu64.c        | 1 +
>>   4 files changed, 8 insertions(+)
>>
>> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
>> index 35f52a54b1..a2a388f091 100644
>> --- a/docs/system/arm/emulation.rst
>> +++ b/docs/system/arm/emulation.rst
>> @@ -26,6 +26,7 @@ the following architecture extensions:
>>   - FEAT_BF16 (AArch64 BFloat16 instructions)
>>   - FEAT_BTI (Branch Target Identification)
>>   - FEAT_CCIDX (Extended cache index)
>> +- FEAT_CMOW (Control for cache maintenance permission)
>>   - FEAT_CRC32 (CRC32 instructions)
>>   - FEAT_Crypto (Cryptographic Extension)
>>   - FEAT_CSV2 (Cache speculation variant 2)
>> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>> index 04ce281826..e806f138b8 100644
>> --- a/target/arm/cpu-features.h
>> +++ b/target/arm/cpu-features.h
>> @@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
>>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
>>   }
>> +static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
>> +}
> 
> This isn't used, so it may be omitted.
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Got it. I wasn’t entirely sure if I should add it for future convenience.

k, I'll omit it if I come across a similar case. Thanks.

Since I'm using it after Peter's comment for v2, I kept it, and added your R-b.


Cheers,
Gustavo

