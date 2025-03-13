Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57557C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmQx-00010w-M1; Thu, 13 Mar 2025 13:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmQn-0000x7-1A
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:33:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmQj-0001ZA-Gy
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:33:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2239c066347so27368065ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741887191; x=1742491991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ruGx1jSidkqoB+TfzfTbSHBH7kbOTGPD1srCGqacgw=;
 b=PqVICxou0ejtEqK6FjGaeOxgGVuZauxO/l4gVcK2+L4bKr6FoVXI3eYAqhbiHobbbC
 tithwqZ6k6whdoAbmt/zE5uuJw+58HL6zPF5g7g7y87JdJclNhEabJrPskc+IbzYMDCY
 lXS1aL4gvqgRVrI0kfMXteh1Bia7SKXKp/R/MAcKQwTdf37jnqFeY7fwFjJPCJIB8Y5b
 2cE1QTrfVgAr/6xLbTwSC2hwAjYtOog4hw7HsIqchpFsEZzxQtPjdv2PFApOwGowQVAa
 BOI2/hyNqSV+IEAMR7BoZ6VhbbdvicAE03d8hNJuEYtMQkGOg9yXYuO2PmmKz+d6nR2d
 l3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741887191; x=1742491991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ruGx1jSidkqoB+TfzfTbSHBH7kbOTGPD1srCGqacgw=;
 b=NHs4Fg5HX5GPhRTJcH7hI9K2JKOAVKvXsLzw1mMnZxEhwK2IykPPB9L4xTDJZGGPXF
 F5PSi9lx746YSgO59tAyr3e6PtDHXwOIEghXfT+rwzaDUN8LzDeYdQXuUfS0R0yvYnva
 XGpsmwMYkQaUEir3dHQisi8mXGdO8Jht/EPuwTzv5H+7fuCNbqGFLCKOKalQZabao+sL
 DNtAB0GCh8r7iiVAxYL6e77XzX9KGepFp19KdS8pWdVsC5FuOIGwgjYI1Uzr1Z5aKEWh
 KdaMFKCajBSphSpia/wNtru03okDr9Si2Mzfu2nYopauJP94qPDkojeNjqsmSkBorPv6
 Oexw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuPHK4pvLI6tdAGf8DGKn6/Q4YU3PlwgBXb/XMRLVkb/+J581SiPHpqZdcU44mAYWvtdjsqn5Lr7Ej@nongnu.org
X-Gm-Message-State: AOJu0Yzmmkb/nM2916UTll59aqt52udIoBm+ZAFtjxQc3an/C8oX86ln
 9LiLlOIF+GpfQwlac+FDnfF/AE7e1BG/8LVvgbZLDgb36mgJehes1VpOOjedvhw=
X-Gm-Gg: ASbGncsrkKjT3o7VfrxrontKqFiaykJbT9UZZICB4xNjbdlN60FQb4ybioaxOYsH+XH
 ZBW6mFpPCwp5cNzutcxQu0UcDIPyLd+RejBtIiLt6Dol53DoW7Bn3qhZyKvdSMZRxbZ2cO/RNuT
 /+gYI0Jo6qq1lJtYaQtJ19XZHzvDcmBZuVTE2mndBlykANHo1HzrW4D91AbBXKO4iaibXBGvXsM
 nrr6pHpiwz81dcRwOmCQpAecOtCc2aEhUhk5TvK4giWIecdcZqVRhoyz6mGQXYyXPu27vD9Gj60
 PxqChtMgUr1iLyrrQ0ewiyXCZM33ma8U9tXrOf/jWJ7iPGaljIFhRXeA3Q==
X-Google-Smtp-Source: AGHT+IHP8y/6QPFoHiRbkACTbPbxuO3uMRppUcFqjqN/gQd1zY+CzzouI4vFNQWTo2pw2ZPyAshVTA==
X-Received: by 2002:a05:6a00:10c8:b0:736:9fa2:bcbb with SMTP id
 d2e1a72fcca58-7371f1a4251mr610294b3a.24.1741887190671; 
 Thu, 13 Mar 2025 10:33:10 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737115294besm1600707b3a.21.2025.03.13.10.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:33:10 -0700 (PDT)
Message-ID: <025651b5-3b4c-4326-9aec-87f81df725c6@linaro.org>
Date: Thu, 13 Mar 2025 10:33:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/37] accel/tcg: Implement translator_ld*_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> Add a new family of translator load functions which take
> an absolute endianness value in the form of MO_BE/MO_LE.
> Expand the other translator_ld* functions on top of this.
> Remove exec/tswap.h from translator.c.
> 

Is there a need further down the road to break the dependency to tswap?
I am not sure of the benefit to drop tswap, as the resulting code is 
more complicated than simply calling tswap*().

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 49 ++++++++++++++++++++++++---------------
>   accel/tcg/translator.c    | 26 +++++++++++++++------
>   2 files changed, 49 insertions(+), 26 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 205dd85bba..3c32655569 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -18,7 +18,7 @@
>    * member in your target-specific DisasContext.
>    */
>   
> -#include "qemu/bswap.h"
> +#include "exec/memop.h"
>   #include "exec/vaddr.h"
>   
>   /**
> @@ -181,42 +181,53 @@ bool translator_io_start(DisasContextBase *db);
>    */
>   
>   uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc);
> +uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
> +                             vaddr pc, MemOp endian);
> +uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian);
> +uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian);
> +
> +#ifdef COMPILING_PER_TARGET
> +static inline uint16_t
> +translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +{
> +    return translator_lduw_end(env, db, pc, MO_TE);
> +}
> +
> +static inline uint32_t
> +translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +{
> +    return translator_ldl_end(env, db, pc, MO_TE);
> +}
> +
> +static inline uint64_t
> +translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +{
> +    return translator_ldq_end(env, db, pc, MO_TE);
> +}
>   
>   static inline uint16_t
>   translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
>                        vaddr pc, bool do_swap)
>   {
> -    uint16_t ret = translator_lduw(env, db, pc);
> -    if (do_swap) {
> -        ret = bswap16(ret);
> -    }
> -    return ret;
> +    return translator_lduw_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
>   }
>   
>   static inline uint32_t
>   translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
>                       vaddr pc, bool do_swap)
>   {
> -    uint32_t ret = translator_ldl(env, db, pc);
> -    if (do_swap) {
> -        ret = bswap32(ret);
> -    }
> -    return ret;
> +    return translator_ldl_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
>   }
>   
>   static inline uint64_t
>   translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
>                       vaddr pc, bool do_swap)
>   {
> -    uint64_t ret = translator_ldq(env, db, pc);
> -    if (do_swap) {
> -        ret = bswap64(ret);
> -    }
> -    return ret;
> +    return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
>   }
> +#endif /* COMPILING_PER_TARGET */
>   
>   /**
>    * translator_fake_ld - fake instruction load
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 64fa069b51..405e0b44c4 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -8,13 +8,13 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
>   #include "exec/cpu-ldst-common.h"
>   #include "exec/translator.h"
>   #include "exec/plugin-gen.h"
> -#include "exec/tswap.h"
>   #include "tcg/tcg-op-common.h"
>   #include "internal-target.h"
>   #include "disas/disas.h"
> @@ -467,7 +467,8 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
>       return val;
>   }
>   
> -uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
> +                             vaddr pc, MemOp endian)
>   {
>       uint16_t val;
>   
> @@ -476,10 +477,14 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>           val = cpu_ldw_code_mmu(env, pc, oi, 0);
>           record_save(db, pc, &val, sizeof(val));
>       }
> -    return tswap16(val);
> +    if (endian & MO_BSWAP) {
> +        val = bswap16(val);
> +    }
> +    return val;
>   }
>   
> -uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian)
>   {
>       uint32_t val;
>   
> @@ -488,10 +493,14 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>           val = cpu_ldl_code_mmu(env, pc, oi, 0);
>           record_save(db, pc, &val, sizeof(val));
>       }
> -    return tswap32(val);
> +    if (endian & MO_BSWAP) {
> +        val = bswap32(val);
> +    }
> +    return val;
>   }
>   
> -uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
> +uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian)
>   {
>       uint64_t val;
>   
> @@ -500,7 +509,10 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>           val = cpu_ldq_code_mmu(env, pc, oi, 0);
>           record_save(db, pc, &val, sizeof(val));
>       }
> -    return tswap64(val);
> +    if (endian & MO_BSWAP) {
> +        val = bswap64(val);
> +    }
> +    return val;
>   }
>   
>   void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)


