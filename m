Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB9D277C0
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKhV-000572-NF; Fri, 09 Jan 2026 17:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKhS-00056Z-Vl
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:11:19 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKhR-00021y-6l
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:11:18 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7bc248dc16aso2764568b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767996675; x=1768601475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuzLFVObEld/UodcpN8YUApn+id9310EnAdb7xer2wI=;
 b=VDW0R/CvNDNk1QZT414JXFlgMVlZKyUedz+8x+lJCFuw3ihzgmiUmzf6qwFuOWSh2e
 IwJS+w42hHUdJ3hjXOGMx9hDvw5XhvnlD9YahgRoGO/5e/7Q9LYH1HIaFu08j4ne3veI
 QDvPrIRff1NaJDMP47hNwFSEAmjImETjUMkbaPGARUKpTG/LK2o1IiRlKEgWFUg+V8Dp
 j3FwpMjq/iYpzjWZYyK48Qh2C4WGF6TY8nGX7TluUAoKWmoaiLtDHHt254g7GTE3tw1C
 Us+BEP2vdifJbhLWr8HMfKG7GMihUJp35Ye02WxE1vinry5PO7yDJJWFBLUlXr1Sl8iP
 CoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767996675; x=1768601475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuzLFVObEld/UodcpN8YUApn+id9310EnAdb7xer2wI=;
 b=YS3SBdDaQzZgRksBGoGpDfUOtO0iakTHuK9gnIpS9kabFPEFESD+QStjA/Vt8x+FXw
 bHvA2gXEkjmADeSrxhA8qK3/dshHpOjPZrhyXeIrJ7pPbv+pSk1aUWZfJQdpYEqZ3tTT
 sz5BWzQSnNN14RiFavqkDb00V/DtxG04XvQxRZ3+9oqgVEL6Julxi0//MEwSkuGsgksU
 uIz1qpmnMaBFXu13rDFFJPDTWNHgCH6UXqmVwyJCdhMb5TAss2KuyaryHVtE/Bx7oTni
 nZ8APBp5jTayF2jthqam3H/qGTqDOSUyq6egVQpjM18Ekyh7yNiGLEESyUB7FoF9cc+V
 Yhpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIESxSnaYwakpXpx6mM0N5sOqRepJ93SOon7Dz/fNONtsHArLaXMdTQxf2hCAlM0kHhPGE+WV3J68u@nongnu.org
X-Gm-Message-State: AOJu0YyWxY2yxCoGOhhf7JrN+Ejly4LcvuES8dJ7NnJ6ais4aXSUfLtp
 sknED59syWjoUm3SUf028OeUHByr4QZH55uihVrM4TZYFIy5my/7ZZwpcPyUyG020V0=
X-Gm-Gg: AY/fxX4MMnyuaDFjDhd1Dz6NMqQEKs+3nrwQOwWm9gUJuKNItFFDGw2WNVoskQrz4QM
 XicoEfqfFocw0FL60G8y7J+20mB8HigiIaJQLkaZM6Ag8KLMTMPlTADrHnRPvKR3BJfsgeAYvMw
 /miPUN9Dru+2xmq4QS9iiKEn4OtCyIbEJqmpOMyqVSdw7dw0qMHwsIqmeq1FgykEfMc8UW0GTKm
 qYk1p59b9Wi0RwTu9VA/LaMNU7lhxBFHzsLruKGyZUgoqBXnaIXwNI1ZM36EyBoRJCsmj1tflW9
 utg5Q57d5Z1iuOXq5J1rbVQ1SV9vl2BJ9Iwh+kuUgtOWssun4ej51GHEB6A+/0Ath8xMXBAIfge
 F2LfG97qpKFkI4DSHZH59o8SUovGCb9ZM3wsSD2MQha7OKaFGz0x+NeG42HMHTJgsQNy+t9uqYs
 0KOBvcbCbULwTLxAaA9T2qO0Uqj/ipgNk9mihbpWksTdh8axMJ8j4Y1IXt
X-Google-Smtp-Source: AGHT+IGwkOZprvQcHbRbqE87LbO8DbLy9Dqk+dylYMbxLxd8dw4qTsOFLpK5jptLrKO0VW2yV8zQnA==
X-Received: by 2002:a05:6a00:430d:b0:7ae:8821:96dd with SMTP id
 d2e1a72fcca58-81b7f1045acmr9465532b3a.24.1767996675284; 
 Fri, 09 Jan 2026 14:11:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e46339579sm2705560b3a.18.2026.01.09.14.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:11:14 -0800 (PST)
Message-ID: <f12d31b4-48e1-4683-be30-31ba469ceb38@linaro.org>
Date: Fri, 9 Jan 2026 14:11:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/9/26 2:02 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
>> headers. The goal here is to allow a compilation unit to set explicitely
>> which variant of the arch it's targeting (32 vs 64 bits).
>>
>> By default, we simple let it defined as TARGET_LONG_BITS, so existing
>> code does not need to be changed, and we can progressively convert new
>> files.
>>
>> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
>> some TARGET_AARCH64 defines). For other arch, this is a work that will
>> have to be done before converting them.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
>>    include/tcg/tcg-op-gvec.h         | 11 +++--------
>>    include/tcg/tcg-op.h              | 22 +++++++---------------
>>    3 files changed, 31 insertions(+), 23 deletions(-)
>>    create mode 100644 include/tcg/tcg-op-address-bits.h
>>
>> diff --git a/include/tcg/tcg-op-address-bits.h b/include/tcg/tcg-op-address-bits.h
>> new file mode 100644
>> index 00000000000..71e9de65280
>> --- /dev/null
>> +++ b/include/tcg/tcg-op-address-bits.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef TCG_OP_ADDRESS_BITS
>> +#define TCG_OP_ADDRESS_BITS
>> +
>> +#ifdef COMPILING_PER_TARGET
>> + #include "exec/target_long.h"
>> + #ifndef TARGET_ADDRESS_BITS
>> +  #define TARGET_ADDRESS_BITS TARGET_LONG_BITS
>> + #endif
>> +#else
>> + #ifndef TARGET_ADDRESS_BITS
>> +  #error TARGET_ADDRESS_BITS must be defined for current file
>> + #endif
>> +#endif /* COMPILING_PER_TARGET */
>> +
>> +#if TARGET_ADDRESS_BITS != 32 && TARGET_ADDRESS_BITS != 64
>> + #error TARGET_ADDRESS_BITS must be 32 or 64
>> +#endif
>> +
>> +#endif /* TCG_OP_ADDRESS_BITS */
>> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
>> index b0a81ad4bf4..422a270b694 100644
>> --- a/include/tcg/tcg-op-gvec.h
>> +++ b/include/tcg/tcg-op-gvec.h
>> @@ -8,13 +8,10 @@
>>    #ifndef TCG_TCG_OP_GVEC_H
>>    #define TCG_TCG_OP_GVEC_H
>>    
>> +#include "tcg/tcg-op-address-bits.h"
>>    #include "tcg/tcg-op-gvec-common.h"
>>    
>> -#ifndef TARGET_LONG_BITS
>> -#error must include QEMU headers
>> -#endif
>> -
>> -#if TARGET_LONG_BITS == 64
>> +#if TARGET_ADDRESS_BITS == 64
>>    #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
>>    #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
>>    #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
>> @@ -28,7 +25,7 @@
>>    #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
>>    #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
>>    #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
>> -#elif TARGET_LONG_BITS == 32
>> +#elif TARGET_ADDRESS_BITS == 32
>>    #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
>>    #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
>>    #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
>> @@ -42,8 +39,6 @@
>>    #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
>>    #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
>>    #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
>> -#else
>> -# error
>>    #endif
> 
> Not address related.  Not even close.
> 
> 
>>    
>>    #endif
>> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
>> index bf76749d1c5..9e4e58a2d4b 100644
>> --- a/include/tcg/tcg-op.h
>> +++ b/include/tcg/tcg-op.h
>> @@ -8,20 +8,14 @@
>>    #ifndef TCG_TCG_OP_H
>>    #define TCG_TCG_OP_H
>>    
>> +#include "tcg/tcg-op-address-bits.h"
>>    #include "tcg/tcg-op-common.h"
>>    #include "tcg/insn-start-words.h"
>> -#include "exec/target_long.h"
>>    
>> -#ifndef TARGET_LONG_BITS
>> -#error must include QEMU headers
>> -#endif
>> -
>> -#if TARGET_LONG_BITS == 32
>> +#if TARGET_ADDRESS_BITS == 32
>>    # define TCG_TYPE_TL  TCG_TYPE_I32
>> -#elif TARGET_LONG_BITS == 64
>> +#elif TARGET_ADDRESS_BITS == 64
>>    # define TCG_TYPE_TL  TCG_TYPE_I64
>> -#else
>> -# error
>>    #endif
> 
> Ok, there's been a fundamental misunderstanding about what we discussed.
> 
> There should be *no* changes to target_long, TCGv or TCG_TYPE_TL.
> 
> There should be a *new* file, include/tcg/tcg-op-mem.h which deals with TCGv_va,
> TCG_TYPE_VA, and all of the tcg_gen_qemu_{ld,st}* helpers based on that.
> 
> The only thing that should happen in tcg-op.h is:
> 
> #define TARGET_ADDRESS_BITS  TARGET_LONG_BITS
> #include "tcg-op-mem.h"
> 

To be fair, I should have mentioned that I didn't understand why you 
were insisting to *only* deal with memory operations.
Yes, target/arm uses TCGv *only* for addresses, but it's very 
arm-centric to think about this.

So what's the benefit to split memory operations instead of parameterize 
TCGv directly?
In this case, I agree that TARGET_ADDRESS_BITS is definitely a bad name, 
but I wanted to stick to the one you said, I should not have though 
because the end result is not consistent.

> 
> r~


