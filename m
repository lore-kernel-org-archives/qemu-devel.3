Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EC1C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJZ4-00054y-LU; Fri, 25 Jul 2025 10:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ufJYu-0004hq-5e
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:38:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ufJYs-0002Cg-GK
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:38:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-234bfe37cccso19052165ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753454292; x=1754059092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Wz2BNiYoiP5762BvBbM2ntZFH1GD69odO+hoPGRlsI=;
 b=UCVIViausw6fnuZkhCYhVBBLt0O77JU1uQoEnHb94NqS/1+/vVWHkagkhHySngV0KQ
 X5VplObF3jB1pIO+dVCbj3IVwv5cBXI8MHnh//axEyyENp+r8+HmAXj/wmNBxbzMHYKL
 pHmNkZCNB40K+rz5qSk2Z3eZesgxOAb9FN/BM0josIV5Bl9zCgAQgQ1jZv52lPZinfOr
 1vBahPWzj58anIgyjEFpnUOzVufEKq4uAtLy6KWJpbZklxcNnzfRbsP7TFNnsbnM3Not
 j0ajdNDaR+o5x2FSfsTV0vnjZLUcWajp+R/y/wu1IkQH5ytnMa/WVhzIyR7oTQLG0ehr
 ra2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753454292; x=1754059092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Wz2BNiYoiP5762BvBbM2ntZFH1GD69odO+hoPGRlsI=;
 b=dQw07D35jObXvloSNjy+onIcB2By2GqEYY7lzfakZD9BgPwyb3oLPyQfOriDDQ2huh
 7CZBQL0HRDWBszpTHW08bTqCVihmE3yUSGhfnxO6ZRNSOrKanR5nJ069vE6WkAkixrZf
 1tofHvdzsZ5r9VDjSRvyVE7Sl/w+NhWPyV+8lIZwlM8MPg62Vce1gcqBYOMzzjtbMdim
 ss+f1uL1gVdFMr9HgiCkt6bL899VVy64rhfD0YcID0jIa3G3H0wyD2I3knLEVjWwPesd
 D7iGBcpJVMN6VQt9TpgsUniWINMvUB0XMwuN2hO0OzxnJOZPm8c1lYvuUsqgqrtcYQV2
 aBbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCMjSYiiXdtB8t75PyN6kTfxpQuhaPyq50r/BtNZmvLny8/OkoXngQQx+yotN54clacHmXX5+BhPPh@nongnu.org
X-Gm-Message-State: AOJu0YxJuWVDguS4/wPXm8Wc1dmADk0zW6wTFx/dNOHolSGozOjcdKrp
 ty85RBVpnn+LSt5Gr9hNR35cius7QgrBOkylpFMarXafN292HlVup7VmUZZ0pCYiuGWPv2Spqzm
 cYHW17EU=
X-Gm-Gg: ASbGncvoDvpd/7oiyC2zkUsQpa9vdlvhX1aX2CnuhDdXpfhuOhPRyfrS1tDbZGe53EZ
 4Q8DhnYh7AZFUmb0ClUYpZyd1hif0s7lLttUcAqi+QjYSioDCkJNpbA3rUqNc89M7pw98V9EPqD
 pdLtuxop8QOAyxOm4hn+eujUpCyX822/4HAzqmVKA/JcyJzzl3LxNK63L79rkmgvQI+ZdUpS0X5
 ISYfzPY0YiXwLA2ELlaj/aEjlWEPwChSlk5B4yPw9rHwp4zmnke0CRlPmiyyq5zHIxcVDwd9CH6
 F+FFsEMmatwfQi4mfIWHPm2wKhVrKTmWsJzKZgcaoJM6nFALSIWHB6VyZUR56pNuiNGqRtieJdV
 B7+Ftp/P3Q+qA9j6QKvK2rRCTwnwbBrpiiw==
X-Google-Smtp-Source: AGHT+IHXqgdV1VBd7n3lEXtGGNKU6MxbLxfcrfdGyogWou0f57/FPlDAqqqnmKNAeFvScFwg6Mu5Wg==
X-Received: by 2002:a17:903:1aee:b0:236:6fbb:a5f3 with SMTP id
 d9443c01a7336-23fb30e8023mr33117895ad.40.1753454292454; 
 Fri, 25 Jul 2025 07:38:12 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.37.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa475f3a6sm39036565ad.6.2025.07.25.07.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 07:38:12 -0700 (PDT)
Message-ID: <aad0c640-b736-4f5a-a6cf-e5459f60630d@linaro.org>
Date: Fri, 25 Jul 2025 11:39:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Clean up of register field definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20250725014755.2122579-1-gustavo.romero@linaro.org>
 <17254b66-4902-4ee0-8c9a-4082146255e3@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <17254b66-4902-4ee0-8c9a-4082146255e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Phil,

On 7/25/25 10:18, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 25/7/25 03:47, Gustavo Romero wrote:
>> Clean up the definitions of NSW and NSA fields in the VTCR register.
>> These two fields are already defined properly using FIELD() so they are
>> actually duplications. Also, define the NSW and NSA fields in the
>> VSTCR register using FIELD() and remove their definitions based on VTCR
>> fields.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   target/arm/internals.h | 8 +++-----
>>   target/arm/ptw.c       | 8 ++++----
>>   2 files changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index c4765e4489..052f7b641c 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -113,11 +113,6 @@ FIELD(DBGWCR, WT, 20, 1)
>>   FIELD(DBGWCR, MASK, 24, 5)
>>   FIELD(DBGWCR, SSCE, 29, 1)
>> -#define VTCR_NSW (1u << 29)
>> -#define VTCR_NSA (1u << 30)
>> -#define VSTCR_SW VTCR_NSW
>> -#define VSTCR_SA VTCR_NSA
>> -
>>   /* Bit definitions for CPACR (AArch32 only) */
>>   FIELD(CPACR, CP10, 20, 2)
>>   FIELD(CPACR, CP11, 22, 2)
>> @@ -220,6 +215,9 @@ FIELD(VTCR, NSA, 30, 1)
>>   FIELD(VTCR, DS, 32, 1)
>>   FIELD(VTCR, SL2, 33, 1)
>> +FIELD(VSTCR, SW, 29, 1)
>> +FIELD(VSTCR, SA, 30, 1)
>> +
>>   #define HCRX_ENAS0    (1ULL << 0)
>>   #define HCRX_ENALS    (1ULL << 1)
>>   #define HCRX_ENASR    (1ULL << 2)
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 561bf2678e..ed5c728eab 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -193,9 +193,9 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
>>           return ARMMMUIdx_Phys_Realm;
>>       case ARMSS_Secure:
>>           if (stage2idx == ARMMMUIdx_Stage2_S) {
>> -            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
>> +            s2walk_secure = !(env->cp15.vstcr_el2 & R_VSTCR_SW_MASK);
> 
> FYI register API provides helper macros:
> 
>              s2walk_secure = !FIELD_EX32(env->cp15.vstcr_el2, VSTCR, SW);
> 

Do you know which form is currently preferred? I see that R_<REGNAME>_<FIELD>_MASK is used a lot, .e.g, in helper.c.

Also, even tho the SW field in VSTCR is <= 31, VSTCR is a 64-bit register, so should I really use FIELD_EX32 (which works) or FIELD_EX64 (my first thought would be to use it, i.e. based on the register size, not the field)?

Thanks.


Cheers,
Gustavo

