Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8177CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OXO-00011B-H5; Wed, 24 Sep 2025 08:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v1OX9-0000wA-RS
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:23:44 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v1OX3-0000Rl-Bp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:23:42 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-723ad237d1eso62774697b3.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758716614; x=1759321414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgWN7UIbJZ/ZuVQ3yAJWjm/lbr2P12F6KEt8R4Wdkbs=;
 b=mnotR0kTLLpH/Efn2taJdVwbvik8GL/uXh/Cf3L3GNsFYqAm9eADsU13lTFepZGRhN
 RHqhpXNU/A2U1ACISMmcZ38BTqY2zZ9NylgQwgOgTiCt/gmshKm3k1Bd+4u2g9ni+w/O
 OifrAZeXiO55MMm+SG2N39klez54ifiLFBDFH36CR2qqXNv9an37s5l0WF3W1A0FGEoQ
 /t3QEPjZe8BmxHgHCR09nDAY2yJagHNNFaHJIbWxsil1DgO4ssyPgoJgtc1eez1dB1im
 YUBBYUq2cobWqKopykvUejH4j72EimNqpfrTt5PZu/YRnaHjGq0GXeyUKi9yzSaRIzxB
 9Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758716614; x=1759321414;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgWN7UIbJZ/ZuVQ3yAJWjm/lbr2P12F6KEt8R4Wdkbs=;
 b=RHDYhX/27upCd1bYnP0Tf4msxQX/TIwYvD4rJylwjD70HSNi8Lcz81DuZu4UNjWT0+
 VwsMNIJNd9wD8PrB+ForNZQTNLMHRq/nfMci1fThzCntn1stOF8r879XYF8wchxxIZPI
 CanTWlJZa4KaUfUY+yCvTli6CJWJIo+BdTUdwFkuB2amOqvugR9UDpWDjXRCARWwjTag
 mtl4ZTcf0OBPlDrzokIF7asZPT1qiAj4f3KfG91nWqFW8HHVQtJK1/CNaCisuUvi5/EX
 TaKM9C2SF1QqTrScQXhJIAxGjVOxleBox3aNMmmVNvGHgQ/QexWOOEiRQ29z2Jgwar6L
 zeag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFf/+XwgTlmeuxzpTiTyVgVUyMxj5ukjLlI1zuwNbNf9L4uWK8Tg8G54SVAZ2wtWNfjM0agCwClWl9@nongnu.org
X-Gm-Message-State: AOJu0YybkP7hOF+ewdU521xFrotiqeCzZSr0X1M/ujt381GvHE0Rd+J0
 EBTMMVlbWNiZapTy7hK0pOCn2wqNSsiLlUXEi0gi68iSuLN2KKwdXGK0dVkHGWsaUUs=
X-Gm-Gg: ASbGncuH+KQZmk3LdkOvAj2BOXbMk/4ylfIBplzkJQMB86uN/8TyzQlgYQLvcnR8yMf
 8m7EnCHXgYT24rQquRE43bUv93DwTZMTHOio3gGaOWB31Dhuexp7w+Os9KK4Zw7hH5rgGIHOIVM
 W471iRUOCgkESmQlwriFR5nlnJuiKvnC/Y8kufGTxJGo2acmhc/t/TAfIgen7MKVSoEMMw6mqw8
 V125PdKG3roCJfq7wSdX1JhscVo3eW87pW8oAvblSdigPGHLw5sZyHLnGJF2SY4J3y+mQA2r2y3
 Q2BBxZgiiWcoR9ZORW2dFb15KyLVRNaqsn8cyrYRznlyUeJcMxA9jc49gTOx53P4ahI+9N9QJA6
 mYJXoVxZjgaexe5TwgZ9vB+2MzwpPeHdeDhGv1Q==
X-Google-Smtp-Source: AGHT+IEadO0HcG37pdz7hLk5/yL62pKo3mjFZjN4191Ffuf7Jg7wnfRmuKOetvmHcHBcvqtrpVA8xA==
X-Received: by 2002:a05:690c:3507:b0:734:f858:b1f2 with SMTP id
 00721157ae682-758a2c0c0c4mr50428077b3.30.1758716614486; 
 Wed, 24 Sep 2025 05:23:34 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.123.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-747ff308313sm29236287b3.37.2025.09.24.05.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 05:23:34 -0700 (PDT)
Message-ID: <f9cf2b82-4857-460a-a613-cc4a00a8bedc@ventanamicro.com>
Date: Wed, 24 Sep 2025 09:23:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-5-richard.henderson@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250923023922.3102471-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112f.google.com
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



On 9/22/25 11:39 PM, Richard Henderson wrote:
> The tb_flush within write_misa was incorrect.  It assumed
> that we could adjust the ISA of the current processor and
> discard all TB and all would be well.  But MISA is per vcpu,
> so globally flushing TB does not mean that the TB matches
> the MISA of any given vcpu.
> 
> By recording misa in the tb state, we ensure that the code
> generated matches the vcpu.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: qemu-riscv@nongnu.org
> ---
>   target/riscv/csr.c         | 3 ---
>   target/riscv/tcg/tcg-cpu.c | 3 ++-
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8842e07a73..3c8989f522 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -25,7 +25,6 @@
>   #include "pmu.h"
>   #include "time_helper.h"
>   #include "exec/cputlb.h"
> -#include "exec/tb-flush.h"
>   #include "exec/icount.h"
>   #include "accel/tcg/getpc.h"
>   #include "qemu/guest-random.h"
> @@ -2173,8 +2172,6 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>           env->mstatus &= ~MSTATUS_FS;
>       }
>   
> -    /* flush translation cache */
> -    tb_flush(env_cpu(env));
>       env->xl = riscv_cpu_mxl(env);
>       return RISCV_EXCP_NONE;
>   }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 78fb279184..143ab079d4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -191,7 +191,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>   
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
> -        .flags = flags
> +        .flags = flags,
> +        .cs_base = env->misa_ext,
>       };
>   }
>   


