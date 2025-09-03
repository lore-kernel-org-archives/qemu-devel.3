Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6789CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfQR-0006sB-5u; Wed, 03 Sep 2025 00:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utfQP-0006rw-VS
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:48:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utfQJ-00031c-F9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:48:49 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afcb7ace3baso494211466b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756874921; x=1757479721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asBm/GvpfmgXh327S6YnUa9JQDhxmxl0IcfTuPFqKeg=;
 b=WVUye9baJH/MKifMb2lVa/+HEkXQn4ZwpMdn6DhgFB2cSLizZg4xVKOfChJq310PTE
 hxI7OIcPfXmeHZTdtuxmjkG+tZGnYR47O6lEJaRB+r2wqKFTmrC5zr5qI16mRQ8LLnZ7
 Xpvx1cc0ikdgMmBWsDj6LX9R9I5/LIaMwTplLEbCJPYYnKRxpPDBbO3u7IUHmttUNt+2
 vKP1oED9/J2rqcf42Pkee1bPIqQ3A4RHdrKpcI/udeidZH9HfmuHMQPYXiXJ6/6SU/88
 /ArHQ5kAzgeKOxfFYWqqzXidyIK0EvhyszCiTZAt/FSizToUkJePrGHZG0w7n1xJINbG
 QKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756874921; x=1757479721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asBm/GvpfmgXh327S6YnUa9JQDhxmxl0IcfTuPFqKeg=;
 b=wHF5Zi2i1WyfH253U9folAFNaR1e1/2C0EqThEk53N7M37k+8Ys1cTyO1gBd6E6TKp
 TuxeXn33rUkBREQb7X3WdHK7d0HZv+cq36aooFpSBmCSoWFG+fkntOyJ8MB6hO9lWVVs
 Du14LtiiBEPrwZosMnAdW1eFrtEilKW0FUwaii6LcjgwU7I4bHdKOzC0ioNNLUyq+9UR
 6vyK5I4Wjnbwifjtcvx+UzcV2QkeVqTuDtJdi5e7Unt8yzMirFPh++7AZ3BreEgs6Kny
 WLbtGmw1HMSdSsfg0UJa2HWO347hA/OzwZZ/AZoaK77yb8zM3BumllYMTu8W9aTtkqYV
 YIQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3tIJg3AZpdvzU2s1iLl403SJ3nK3vm/Bl3+ZLg9bmckxXbGfVX8lqrhI/d80dwzZnTVAJOK3eUx+M@nongnu.org
X-Gm-Message-State: AOJu0Yy7j3NabQ3GQUSIcN+oYONsaKBIszb1ICSyq0I/841+QfCdNtqE
 8tSUUXcqeCd0OAlbQBV1C8Qikr4Zp3a9k0696ZyH+8/7DwW5R16YFuk6kud3ier0tss=
X-Gm-Gg: ASbGnctWoVNBAcehDMOn0Igz+LKoJsia6uSlgsCu+5GsMy2HhB3kZCei4FdTcoxOd99
 QzYuwodk9RatzcVigXAQjW988bceo3F/5Yy2X3LFpgqWFuvineiQqzLhlKwevoTRER4WoQtNHUf
 vLC7AyyaSw1OXvUyJ8puPPVANpdv6wVO8HoA1dqrv35p/vHoUH2jUE6X7phBEnvr9fk17zq9tA5
 CYLJqfXavSyItD0XmTIknyENDPESFKRl9Uqjwe06C96LzNEyJCcuUaDI0x8mhTdFe6Vmq4fLm3Z
 CK8c3Qko7KUk1u0X/Wve2hcWy+N1h/XStXY2CGudW93xaJj2rPeFq0s6frre7GABYvqjO5jcANz
 YxTewmNt7XAXYUIldytEmzCbCarymljm7H14vcTYM4UDY9v4ReNc3aMyttNH2RAcJShlPlfMDxQ
 lZ7e2aVA==
X-Google-Smtp-Source: AGHT+IHovdSNKD30xqY7eDQn/51KWdMYLXm/75cL+XQD424mUHkbOIMvVIIyPqx0CN4qMasAJEKI+g==
X-Received: by 2002:a17:907:7293:b0:b04:568b:8a42 with SMTP id
 a640c23a62f3a-b04568b947dmr376385266b.29.1756874921452; 
 Tue, 02 Sep 2025 21:48:41 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04132c77d9sm839957666b.20.2025.09.02.21.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 21:48:40 -0700 (PDT)
Message-ID: <34d6884b-fb83-4c53-85a4-4b18ffff0ed0@linaro.org>
Date: Wed, 3 Sep 2025 06:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/61] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-19-richard.henderson@linaro.org>
 <t1qv86.8eeulsm1hy3p@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <t1qv86.8eeulsm1hy3p@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 8/29/25 09:13, Manos Pitsidianakis wrote:
> On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>> Prepare for 128-bit fields by using a better query api.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/arm/cpregs.h  | 10 ++++++----
>> target/arm/gdbstub.c |  7 +++++--
>> target/arm/helper.c  | 18 +++++++++++++-----
>> 3 files changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>> index 812fb1340a..b6c8eff0dd 100644
>> --- a/target/arm/cpregs.h
>> +++ b/target/arm/cpregs.h
>> @@ -22,6 +22,7 @@
>> #define TARGET_ARM_CPREGS_H
>>
>> #include "hw/registerfields.h"
>> +#include "exec/memop.h"
>> #include "target/arm/kvm-consts.h"
>> #include "cpu.h"
>>
>> @@ -1053,12 +1054,13 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
>> void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
>>
>> /*
>> - * Return true if this reginfo struct's field in the cpu state struct
>> - * is 64 bits wide.
>> + * Return MO_32 if the field in CPUARMState is uint32_t or
>> + * MO_64 if the field in CPUARMState is uint64_t.
>>   */
>> -static inline bool cpreg_field_is_64bit(const ARMCPRegInfo *ri)
>> +static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
> 
> Using MemOp is slightly confusing though I understand where you're
> coming from. Would introducing a BitWidth enum be a good idea?
> 
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index cf7da3362e..9104c4f162 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -14,15 +14,26 @@
>   
>   #include "qemu/host-utils.h"
>   
> +typedef enum BitWidth {
> +    BW_8     = 0,
> +    BW_16    = 1,
> +    BW_32    = 2,
> +    BW_64    = 3,
> +    BW_128   = 4,
> +    BW_256   = 5,
> +    BW_512   = 6,
> +    BW_1024  = 7,
> +}
> +
>   typedef enum MemOp {
> -    MO_8     = 0,
> -    MO_16    = 1,
> -    MO_32    = 2,
> -    MO_64    = 3,
> -    MO_128   = 4,
> -    MO_256   = 5,
> -    MO_512   = 6,
> -    MO_1024  = 7,
> +    MO_8     = BW_8,
> +    MO_16    = BW_16,
> +    MO_32    = BW_32,
> +    MO_64    = BW_64,
> +    MO_128   = BW_128,
> +    MO_256   = BW_256,
> +    MO_512   = BW_512,
> +    MO_1024  = BW_1024,
>       MO_SIZE  = 0x07,   /* Mask for the above.  */

I'm not sure this is helpful.  We already (ab)use MO_n quite often as a symbolic name for 
log8(n) outside of the context of memory operations.


r~


PS. If I were to do it over I'd always count in bytes not bits, since bits are not 
addressable.  Though I suppose we might have been lead by uintN_t and friends.

