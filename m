Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D11E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW2Dj-00056j-J3; Thu, 09 Jan 2025 18:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW2Di-00056b-Di
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:45:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW2Dg-0005T8-RJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:45:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso11907895e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736466343; x=1737071143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bFUt6YW85gVRUwGLF6/fhds9uj5ORIZRYSwA6iPRUvU=;
 b=bCTyQUCnpC1K8pIWiFK9lri9Qy/B9P2e0jxjSNODeaaN2Bqs6iAy39PwjlWL9Tahn4
 uVbQvwtQ3OWhLfReYWsjjD2TRo2PA7rzIupmArZynQtPxkW/l7q5vonyjomoPRrwahE4
 kIcs7q8eFasdv+5YD84uZbQMRXutL90n6aHWvuSFfcfBPaB2avgp0PT2UoOSDWoKsM15
 BUSPupIXexC2CH1+9h1jJIwx24xoeZzLwylQu84sB15vqmnmambxuYjKfS3Vy/n7+ySC
 3Cfys/fYD92SsElDH7flz9HXCYST1ft+W0exBr6lBQObtXi137aLGGgQCzouVGIbJykK
 f5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736466343; x=1737071143;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFUt6YW85gVRUwGLF6/fhds9uj5ORIZRYSwA6iPRUvU=;
 b=LiIa+C324bI2lPHO47HcryWCR9Z9D/8SLUYLM7xB8riam/HuH0Tj2dx/VEQlMc+YwU
 Wwttj6BCvRUOQDwWADeQFrW3dH5y4OFswLDOGZWlsPOD2oAOpPgBA9GnKHDb1IpCickA
 bfFTtxjlwY8J8JK3joO0ZmpO+CY4dzNZhE9tuT/diLHoQEJLhyoJyxuHWL6/f02B99ne
 gzQIQng+cgj1wgN5+BUYmiE4eNOfZOTnTzDJKc9c+O8u072S8WtjUA2J0f9q2ERA5Qyl
 gu75owQXYeaRozpKaqtQkRsnSd/y5H4+wZSSk+NIPfP6gu32OE0GrxHxpoLbcLMtM3Tf
 PXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlYqRG08Y+b/l26B2SjWgxil+5w6ogIOoeLOLHYA0O5EdriIojzTaaLLSez34E/zpy005txL35Cg8A@nongnu.org
X-Gm-Message-State: AOJu0YypROWd13pDSoLMTRqcm6nrYxZi56Y3GKS3fOdyLcVsQow/3Mj0
 iGTS/bryTHcelWWw38/zUk1Pk/+Tao8/mNjvtAM9v+8pQ3rQHgUatRYZmHfAzuzQxHvztSwCybn
 erl8=
X-Gm-Gg: ASbGncv0Cvi/soMjy2mtc9zVOocAuxM+olw1vzaxvwmjd8rAHKUpnjIjr6nfuQ5J0+x
 svFKOAj9uwyfBiUFK/t+DtuNtB2wrrMdoU9vOWOuQ228ooPKCmxiak2AEi0ymx676GCGgNBm5lM
 FlPOrq7SHpqEF1PSIKW+GuGc9umbPXz2ICVAIu0zFsPSViV2iDqlbK87lV0UWKbPUqwx9S9x5i8
 VrTZL3grlzactm/rq15BxmdTC0a2xesBg5I1Q+u/VrtRZ5y9jP6LgWDfVi/lAuzcVJdhe/bvO9G
 SmBNpuTo7W0DTfD/9pE0Q9K9Cow=
X-Google-Smtp-Source: AGHT+IH5DCb8JB50bsl/0rRTLKOFtZlo96JQQ548Z2rFkKdtVO7/bGDtT2/zDQRRmIJzi5eUE0rsUg==
X-Received: by 2002:a5d:6d02:0:b0:385:df43:223c with SMTP id
 ffacd0b85a97d-38a87303941mr7704591f8f.13.1736466343071; 
 Thu, 09 Jan 2025 15:45:43 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e384054sm2976669f8f.36.2025.01.09.15.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:45:41 -0800 (PST)
Message-ID: <c5d18e72-57a8-41d1-a0df-2aebc55b9f2b@linaro.org>
Date: Fri, 10 Jan 2025 00:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/81] tcg/sparc64: Use SRA, SRL for {s}extract_i64
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-45-richard.henderson@linaro.org>
 <45d29837-466b-4439-a8d5-b522e1135263@linaro.org>
 <7911f9e6-a9d5-4457-978a-d0191ce172d1@linaro.org>
Content-Language: en-US
In-Reply-To: <7911f9e6-a9d5-4457-978a-d0191ce172d1@linaro.org>
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

On 10/1/25 00:44, Philippe Mathieu-Daudé wrote:
> On 10/1/25 00:00, Philippe Mathieu-Daudé wrote:
>> On 7/1/25 09:00, Richard Henderson wrote:
>>> Extracts which abut bit 32 may use 32-bit shifts.

(Fix typos?)

>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tcg/sparc64/tcg-target-has.h |  9 +++++++--
>>>   tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
>>> index d9ca14cc3d..2db461efed 100644
>>> --- a/tcg/sparc64/tcg-target-has.h
>>> +++ b/tcg/sparc64/tcg-target-has.h
>>
>> Missing:
>>
>> -- >8 --
>> @@ -33,8 +33,8 @@ extern bool use_vis3_instructions;
>>   #define TCG_TARGET_HAS_ctz_i32          0
>>   #define TCG_TARGET_HAS_ctpop_i32        0
>>   #define TCG_TARGET_HAS_deposit_i32      0
>> -#define TCG_TARGET_HAS_extract_i32      0
>> -#define TCG_TARGET_HAS_sextract_i32     0
>> +#define TCG_TARGET_HAS_extract_i32      1
>> +#define TCG_TARGET_HAS_sextract_i32     1
>>   #define TCG_TARGET_HAS_extract2_i32     0
>>   #define TCG_TARGET_HAS_negsetcond_i32   1
>>   #define TCG_TARGET_HAS_add2_i32         1
>> ---
> 
> Otherwise patch LGTM, so with that squashed:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>
>>> @@ -68,8 +68,8 @@ extern bool use_vis3_instructions;
>>>   #define TCG_TARGET_HAS_ctz_i64          0
>>>   #define TCG_TARGET_HAS_ctpop_i64        0
>>>   #define TCG_TARGET_HAS_deposit_i64      0
>>> -#define TCG_TARGET_HAS_extract_i64      0
>>> -#define TCG_TARGET_HAS_sextract_i64     0
>>> +#define TCG_TARGET_HAS_extract_i64      1
>>> +#define TCG_TARGET_HAS_sextract_i64     1
>>>   #define TCG_TARGET_HAS_extract2_i64     0
>>>   #define TCG_TARGET_HAS_negsetcond_i64   1
>>>   #define TCG_TARGET_HAS_add2_i64         1
>>> @@ -83,4 +83,9 @@ extern bool use_vis3_instructions;
>>>   #define TCG_TARGET_HAS_tst              1
>>> +#define TCG_TARGET_extract_valid(type, ofs, len) \
>>> +    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
>>> +
>>> +#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
>>> +
>>>   #endif
>>
> 


