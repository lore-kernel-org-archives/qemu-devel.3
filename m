Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16842D26D60
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEXE-0002ra-PD; Fri, 09 Jan 2026 10:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veEXC-0002py-1l
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veEX9-00015b-OJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767972974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cE1H/GQ6nZZ5y9q23Qpd6NowyFBZxC6VqYeoFLa0os0=;
 b=IvUiDr9vB904H82DedlCeRJW1i8vy8FSkzkxi5HO+GH1v5btrC2QUBrWgxWNv4kcRn7Zqw
 m8VVyj3xBV2sjsdhbcT6lhMSk5JsedYe4Z/grDCX2pMXATjthHvLSdyMVjHHpsDYKF8ibp
 ERc7Nm8HsK0nbB+GDvyiMDg7rWb2INg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-OkgQjpkaPVyVV4ZCN1fGlw-1; Fri, 09 Jan 2026 10:36:13 -0500
X-MC-Unique: OkgQjpkaPVyVV4ZCN1fGlw-1
X-Mimecast-MFC-AGG-ID: OkgQjpkaPVyVV4ZCN1fGlw_1767972972
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so3284257f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767972972; x=1768577772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cE1H/GQ6nZZ5y9q23Qpd6NowyFBZxC6VqYeoFLa0os0=;
 b=YBEAPi6DxR50xYOd0CYd//h0bwVSL4+2BXn00yV0gyAc1EeYbAoao7pVsbDOz4LtTz
 Ky0qiv75hnRV0YOaCtCCwkXzWjQtD3kwziYUrn1DYPPUh/HRByPdmqG2QKbfrYrpsFAc
 1WD0gdQ6EzArbbXAxan5oURldhNFiTcgDkifVI9NPlxjTkfHtIJoWFvKndv4MdFeJRhL
 beeGTuEZ2dg7Em4XGnMKRnkkmJRCsxVhh3+x6dRdRcHdLWGnRJZeabUqKruWCyc8xAyi
 3ID2KwVhBn/4eQdhpSBK7yHrMtFR8SmUScGXRGsOR66zl4zlFynJjGZTPkq1tM7Dsvf5
 Yrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767972972; x=1768577772;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE1H/GQ6nZZ5y9q23Qpd6NowyFBZxC6VqYeoFLa0os0=;
 b=dDfhQXF9stS1iM5MdNoKCKRbVwjzDx+McSGNd9FYyetBiQP36rHwnondJQOGBQuHs0
 9ORof5MB88aaJkIhrgw+jkKsqa5i6vpsmWipJwGeowx01lG1V1xTn7viejPIABhsS91M
 rpVQUh3ugmBunZ2XpYGq0O8Wpiw4Km6Y+g0CNrQEddRaNzkyxoh/B4YwAcbkMVRTe1T8
 vOmnxXffMvs/2juOCsXstNNG9Cg/6012E2B93z6NgNB4Vj5UJH1VRSVEygICWEo32rhH
 3JzMuzx6b1E/GvQAoQN2zm/QgcQCvE4Gn63d1n81WGCi5SknLA842FnahY/jd3dRyjQE
 UAIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlToKvHplVo+p4+BDoNCqAQEX+KtBJ7La0a3i1hWi9OQDPInw9OX4trhkyP/hSrGX0x7Xhbd3ZbNQy@nongnu.org
X-Gm-Message-State: AOJu0YzRx+cnRL8PF/cwCj93OPcfaaJ9Mc1SORSstueDXfNMXu8k/5GK
 l5EEol4AdDrb3agYoi5d3Y/8Ur01ji6fSVxjmYtxa2dvrShrcLHNQt1VSxmRvw8M7i4hlKQWxA1
 F0MFbywEq+bhRFglfk4+l1YI0SpNiI94xj4FKB8Kz/0+XtEsmF3onW+37
X-Gm-Gg: AY/fxX7Nmgd1At4YcoPYwebBPc8JIi7r8fgy2/a+c+Di5KqyDRuPV/I4PZSBSxJccQ7
 +Vl5/V/0LYjq00zA6JCK88jw9PUnZp3/U9BqyXuioOdGVeX/zPh5IWQzF0uqB5wN6o3KgN54mg2
 HioXJHMfkpqh3GyHRfrwbucGUOSWo+sQCDHJl1yAuuzjaeC6sOnXDp3LnQx5ml5Db7yqkvEP4yj
 fuHhr/WIXueWPxO19DachiGBzMsSvQz17ho66yy5Q4WVfySvhbL+GamQVPxPer6Sww7JAKN1SXw
 e0e9YJ6UfVXWo5DjmjYH5+JdH6pWlof+QUfIb7ULzSsbfu44SaY2pzc97CRxx3irRGS6KEEZ1Le
 kIJoV2KY489hEEVwYyJZp6E7yyYhhVjdSajw7o0QRSjg1x8HbeituUfZ5stWWnjmz7fBZarQKww
 3OUmATOkCTXYDovw==
X-Received: by 2002:a05:600c:3484:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-47d84b1fd4bmr121985105e9.15.1767972971709; 
 Fri, 09 Jan 2026 07:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiNOjuKp1I/n5XtajrAcN6gmCUwhw+rl0Ei36HYoU43TfwieF+49VNFAjcwkhwOb8L1CZI8g==
X-Received: by 2002:a05:600c:3484:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-47d84b1fd4bmr121984895e9.15.1767972971244; 
 Fri, 09 Jan 2026 07:36:11 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee893sm22673316f8f.37.2026.01.09.07.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:36:10 -0800 (PST)
Message-ID: <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
Date: Fri, 9 Jan 2026 16:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/9/26 06:31, Pierrick Bouvier wrote:
> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
> headers. The goal here is to allow a compilation unit to set explicitely
> which variant of the arch it's targeting (32 vs 64 bits).
> 
> By default, we simple let it defined as TARGET_LONG_BITS, so existing
> code does not need to be changed, and we can progressively convert new
> files.
> 
> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
> some TARGET_AARCH64 defines). For other arch, this is a work that will
> have to be done before converting them.

ARM is pretty special in this regard because it has separate registers 
arrays regs[] and xregs[].  The other five multi-size targets (i386, 
mips, ppc, riscv, sparc) probably will *not* use target_common_arch as 
much as ARM is doing, and will keep support two TCG _tl sizes: 32 for 
the 32-bit single-target binaries, 64 for the 64-bit single-target 
binaries and for the single multi-target binary.

For them, the death of target_long/target_ulong is not really possible, 
because they will have to reinvent include/exec/target_long.h for their 
CPUStates.

For the sake of this series, I would rename TARGET_ADDRESS_BITS to 
TCG_ADDRESS_BITS, add to include/tcg/tcg-op.h something like:

#if TCG_ADDRESS_BITS == 32
typedef TCGv_i32 TCGv_addr;
#define tcg_temp_new_addr() tcg_temp_new_i32()
#define tcg_global_mem_new_addr tcg_global_mem_new_i32
#define tcgv_addr_temp tcgv_i32_temp
#define tcg_gen_qemu_ld_addr tcg_gen_qemu_ld_i32
#define tcg_gen_qemu_st_addr tcg_gen_qemu_st_i32
#elif TCG_ADDRESS_BITS == 64
typedef TCGv_i64 TCGv_addr;
#define tcg_temp_new_addr() tcg_temp_new_i64()
#define tcg_global_mem_new_addr tcg_global_mem_new_i64
#define tcgv_addr_temp tcgv_i64_temp
#define tcg_gen_qemu_ld_addr tcg_gen_qemu_ld_i64
#define tcg_gen_qemu_st_addr tcg_gen_qemu_st_i64
#else
#error Unhandled TARGET_LONG_BITS value
#endif

and use TCGv_addr in tcg_gen_qemu_ld_i32 and friends.  This first step 
clearly separates (at least in the long run) target_long from TCG addresses.

 From the point of view of this is all I would like to see: 
TARGET_ADDRESS_BITS renamed to TCG_ADDRESS_BITS, and TCGv_addr 
introduced in include/tcg/tcg-op.h and tcg/tcg-op-ldst.c at the same 
time as TCG_ADDRESS_BITS.

In the rest of the message I'm going to describe why and what more I 
envision.

In the long run TCGv and _tl can become entirely optional, leaving the 
door open for single-size targets to use TCGv_{i32,i64,addr} 
exclusively.  For this reason, the second step (independent of this 
series) is for single-size targets, who have already mostly moved 
towards removing target_long, to remove TARGET_LONG_BITS from 
configs/targets/ altogether.  To this end I would create two files like 
this:

include/exec/target_long32.h
----------------------------
#ifndef TARGET_LONG_BITS
#define TARGET_LONG_BITS 32
#endif
#define TARGET_ADDRESS_BITS 32
#define TARGET_LONG_SIZE 4
typedef int32_t target_long;
typedef uint32_t target_ulong;
#define TARGET_FMT_lx "%08x"
#define TARGET_FMT_ld "%d"
#define TARGET_FMT_lu "%u"
#define MO_TL MO_32

include/exec/target_long64.h
----------------------------
#ifndef TARGET_LONG_BITS
#define TARGET_LONG_BITS 64
#endif
#define TARGET_ADDRESS_BITS 64
#define TARGET_LONG_SIZE 8
typedef int64_t target_long;
typedef uint64_t target_ulong;
#define TARGET_FMT_lx "%016" PRIx64
#define TARGET_FMT_ld "%" PRId64
#define TARGET_FMT_lu "%" PRIu64
#define MO_TL MO_64

... and use them in include/exec/target_long.h:

include/exec/target_long.h:
#ifndef TARGET_LONG_BITS
#error TARGET_LONG_BITS not defined
#elif TARGET_LONG_BITS == 32
#include "exec/target_long32.h"
#elif TARGET_LONG_BITS == 64
#include "exec/target_long64.h"
#endif

Then the single-size targets can replace TARGET_LONG_BITS with:
- a "#define TCG_ADDRESS_BITS" in their translate.c
- a #include "exec/target_longNN.h" in their cpu.h.

Dual-size targets, instead, can add to their cpu.h an initial stanza 
like this:

#ifdef TARGET_I386
#include "exec/target_long32.h"
#else
#include "exec/target_long64.h" // x86_64 or single binary
#endif

and keep using target_long.

And as a final third step, TCG should excise "_tl" definitions 
altogether if "!defined TARGET_LONG_BITS".  For targets that want to use 
exclusively TCGv_{i32,i64,addr}, this lets them stop including 
exec/target_longNN.h.

Thanks,

Paolo

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
>   include/tcg/tcg-op-gvec.h         | 11 +++--------
>   include/tcg/tcg-op.h              | 22 +++++++---------------
>   3 files changed, 31 insertions(+), 23 deletions(-)
>   create mode 100644 include/tcg/tcg-op-address-bits.h
> 
> diff --git a/include/tcg/tcg-op-address-bits.h b/include/tcg/tcg-op-address-bits.h
> new file mode 100644
> index 00000000000..71e9de65280
> --- /dev/null
> +++ b/include/tcg/tcg-op-address-bits.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef TCG_OP_ADDRESS_BITS
> +#define TCG_OP_ADDRESS_BITS
> +
> +#ifdef COMPILING_PER_TARGET
> + #include "exec/target_long.h"
> + #ifndef TARGET_ADDRESS_BITS
> +  #define TARGET_ADDRESS_BITS TARGET_LONG_BITS
> + #endif
> +#else
> + #ifndef TARGET_ADDRESS_BITS
> +  #error TARGET_ADDRESS_BITS must be defined for current file
> + #endif
> +#endif /* COMPILING_PER_TARGET */
> +
> +#if TARGET_ADDRESS_BITS != 32 && TARGET_ADDRESS_BITS != 64
> + #error TARGET_ADDRESS_BITS must be 32 or 64
> +#endif
> +
> +#endif /* TCG_OP_ADDRESS_BITS */
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index b0a81ad4bf4..422a270b694 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -8,13 +8,10 @@
>   #ifndef TCG_TCG_OP_GVEC_H
>   #define TCG_TCG_OP_GVEC_H
>   
> +#include "tcg/tcg-op-address-bits.h"
>   #include "tcg/tcg-op-gvec-common.h"
>   
> -#ifndef TARGET_LONG_BITS
> -#error must include QEMU headers
> -#endif
> -
> -#if TARGET_LONG_BITS == 64
> +#if TARGET_ADDRESS_BITS == 64
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
>   #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
>   #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
> @@ -28,7 +25,7 @@
>   #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
>   #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
>   #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
> -#elif TARGET_LONG_BITS == 32
> +#elif TARGET_ADDRESS_BITS == 32
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
>   #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
>   #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
> @@ -42,8 +39,6 @@
>   #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
>   #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
>   #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
> -#else
> -# error
>   #endif
>   
>   #endif
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index bf76749d1c5..9e4e58a2d4b 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -8,20 +8,14 @@
>   #ifndef TCG_TCG_OP_H
>   #define TCG_TCG_OP_H
>   
> +#include "tcg/tcg-op-address-bits.h"
>   #include "tcg/tcg-op-common.h"
>   #include "tcg/insn-start-words.h"
> -#include "exec/target_long.h"
>   
> -#ifndef TARGET_LONG_BITS
> -#error must include QEMU headers
> -#endif
> -
> -#if TARGET_LONG_BITS == 32
> +#if TARGET_ADDRESS_BITS == 32
>   # define TCG_TYPE_TL  TCG_TYPE_I32
> -#elif TARGET_LONG_BITS == 64
> +#elif TARGET_ADDRESS_BITS == 64
>   # define TCG_TYPE_TL  TCG_TYPE_I64
> -#else
> -# error
>   #endif
>   
>   #if INSN_START_WORDS != 3
> @@ -56,22 +50,20 @@ static inline void tcg_gen_insn_start2(uint64_t pc, uint64_t a1,
>       tcg_set_insn_start_param(op, 2, a2);
>   }
>   
> -#if TARGET_LONG_BITS == 32
> +#if TARGET_ADDRESS_BITS == 32
>   typedef TCGv_i32 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i32()
>   #define tcg_global_mem_new tcg_global_mem_new_i32
>   #define tcgv_tl_temp tcgv_i32_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
> -#elif TARGET_LONG_BITS == 64
> +#elif TARGET_ADDRESS_BITS == 64
>   typedef TCGv_i64 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i64()
>   #define tcg_global_mem_new tcg_global_mem_new_i64
>   #define tcgv_tl_temp tcgv_i64_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
> -#else
> -#error Unhandled TARGET_LONG_BITS value
>   #endif
>   
>   static inline void
> @@ -171,7 +163,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
>   #undef DEF_ATOMIC2
>   #undef DEF_ATOMIC3
>   
> -#if TARGET_LONG_BITS == 64
> +#if TARGET_ADDRESS_BITS == 64
>   #define tcg_gen_movi_tl tcg_gen_movi_i64
>   #define tcg_gen_mov_tl tcg_gen_mov_i64
>   #define tcg_gen_ld8u_tl tcg_gen_ld8u_i64
> @@ -419,5 +411,5 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
>           : (qemu_build_not_reached_always(), 0))                    \
>        :  (target_long)dup_const(VECE, C))
>   
> -#endif /* TARGET_LONG_BITS == 64 */
> +#endif /* TARGET_ADDRESS_BITS == 64 */
>   #endif /* TCG_TCG_OP_H */


