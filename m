Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A74C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk70t-0005iz-Cg; Mon, 17 Feb 2025 14:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk70s-0005ik-36
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:42:42 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk70o-0001fx-3J
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:42:41 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-221057b6ac4so35630785ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739821355; x=1740426155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HB9tO5wpNafJPBaNIUoUsfkUO89aS77jM0PVGG/5HU8=;
 b=ibn5oLieczN1s+BUMHTgYvWjD+/nQlGyJWgQkMOl53eG2lJMwticlTIeFLzhzdRV4M
 1irPunUkzM1phJ9Hk4ZJLruQlt52Rnh1CI7wbbsXz/nTwyVECHpD5efP/KtmDr/g835B
 1mH8TbcXX759TUZoh12sC7iPAoIpPApkYZphalO39aiQgUh9dTcI70Hl7RyNZmU2R0ch
 6Wixa9c8tlI1etGkw2iRcEuPBWe9n/atxBEDPDmvlRXghguqOc48vqc4fuu04zNuhqw6
 tJU7XvTJc8yWTMyYtAto+gUafloSFgzkmCLEncdJEogV/jm9LUQhAwmvpH19gKQL9ugv
 6/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739821355; x=1740426155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HB9tO5wpNafJPBaNIUoUsfkUO89aS77jM0PVGG/5HU8=;
 b=PRGvGJ+Rd0RMImhZDp0Fu9oqk6M9NKYdhs5WGWwtqImH3Z4zYVyllRBmHiqq0uy7Iw
 fNXpt6LjxSNeIoggPLIOV5lRUliOJDWcSIJ7WJOb4UvJgHJEyH+dIMKgX9J6T+1gC+jU
 FmrvCKFaIkVhTizYdloYFKTbWtHFYFq3UjgEZWIqo//bVsL6MkG5t0Q2K6iS0NKt4R0s
 OG1fempzkl9v2+aL2uCx1nn/adcVRhDGyDYWJch/FQOx9lz8YhUQ608Xj6wixbdAoqWq
 i5L9ZX29unDfBqv5wJn1Evs7xVKdX2AsQKqj8gpsKtsqbzR8LY5sTsdoupmV7lqUSvHa
 Y6sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt5xQw+/57Bt55oIkPOZ3AJ8PBm+1lPJX8CwAnFCWC/LLCatJ1c2RWI6WMs+WlzYOzNie7kz/C97jI@nongnu.org
X-Gm-Message-State: AOJu0YwaPpmAPOU/cMzgL4Ay3WWy98hLJRvkpZy7oKcACt2jG2xwvu8y
 kvDVGXFUrfrA2rn+lvJ61DoJvxe7nuWk+U6O4AqF8O6qT0PNpyTNPkS8LclFcPU=
X-Gm-Gg: ASbGncvGDp821mroItAF+xv+ZJR9UMmbTLoyxn1IyD91faGz+2DfxtE54eX+JBXoilV
 fsFKRFtICyRPtxDefGYyHwvGue8iaBP36UFO5Yxf7/qyJundl7cChRRTNmjXGFu8Uqf4fNAileZ
 xMRuqVEsewNqaeYT5GKryWikKqXc7G5c91FV62r4yH7xgOkn2VGydu83pFMxUcfyaW/vqUnSgUX
 BwP6JdyR0nIhGUf8HQAaOSWapfxFb6oXzm2pCnIWywwSwldPKGBfVk+EApqde961RFUFRFNPCM2
 vfu3WNBer9NlR6X9YgSfYAVAb5JY2gxggqHvFkDNjQZy4lPQU/Urr+k=
X-Google-Smtp-Source: AGHT+IEqTLa8yIb6tR937i5vnXAlDaEnuohFUGCvXjK6d3M8sVvPUF6mGQU/MSbDT6bEPm9x2eadkA==
X-Received: by 2002:a05:6a20:6a1e:b0:1ee:89a0:484f with SMTP id
 adf61e73a8af0-1ee8cb3e6b4mr19066216637.19.1739821355462; 
 Mon, 17 Feb 2025 11:42:35 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0e439774sm5732352a12.0.2025.02.17.11.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:42:35 -0800 (PST)
Message-ID: <a14a3bbf-3c13-4185-bc3f-e3696b0b3964@linaro.org>
Date: Mon, 17 Feb 2025 11:42:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 043/162] tcg: Merge INDEX_op_divu_{i32,i64}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-44-richard.henderson@linaro.org>
 <003d3f5c-16e3-4754-9a3c-a26f61b9bdcb@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <003d3f5c-16e3-4754-9a3c-a26f61b9bdcb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/17/25 00:29, Philippe Mathieu-Daudé wrote:
> On 17/2/25 00:08, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h    |  3 +--
>>   tcg/optimize.c           |  9 +++++----
>>   tcg/tcg-op.c             | 16 ++++++++--------
>>   tcg/tcg.c                |  6 ++----
>>   tcg/tci.c                |  5 ++---
>>   docs/devel/tcg-ops.rst   |  2 +-
>>   tcg/tci/tcg-target.c.inc |  2 +-
>>   7 files changed, 20 insertions(+), 23 deletions(-)
> 
> 
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index 127d0f9390..77386eacb7 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -551,9 +551,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>>           }
>>           return (int64_t)x / ((int64_t)y ? : 1);
>> -    case INDEX_op_divu_i32:
>> -        return (uint32_t)x / ((uint32_t)y ? : 1);
>> -    case INDEX_op_divu_i64:
>> +    case INDEX_op_divu:
>> +        if (type == TCG_TYPE_I32) {
>> +            return (uint32_t)x / ((uint32_t)y ? : 1);
>> +        }
>>           return (uint64_t)x / ((uint64_t)y ? : 1);
> 
> or directly:
> 
>       return (tcg_target_ulong)x / ((tcg_target_ulong)y ? : 1);
> 

No, 64-bit hosts need both expressions.


r~

