Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74BCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOddV-0008LW-SQ; Sun, 17 May 2026 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOddO-0008LF-G8
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:42:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOddK-0005cf-QB
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:42:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so15427885e9.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779032544; x=1779637344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMbDrkvtCtd6UvJc33ms9/XbJib8gw5zzxz0w3QAZxc=;
 b=fk5KC7ZGiSKzsVmSJiXbhi9IzmzoCh4CVs3h45YJ9zDom+PDvEdnxRpCYcyJ9nOa0P
 r+/RYtycjlM6/ycqpCRC4H6gAhzDj9Xgfbjijyk2rxqlTnMXtlHsngqgk1Mj+5MeT0xC
 cmvOtxgVfXEwx+Y7sIjoTYSPgQifIP+tWORebukTJhzKVU3JQIIpbRvlgRjGwAkcy6s5
 LruP9IMM15oTRYCR1J64Z3HPskdGO9ae06dgjZSUFbcHH/ZSq5YQ5lHdMzB41oSxo56s
 0wJHrOuTs61t0nxUy/g748McHTRDpTikR5kh5tN7W8GhDOGX6DexUoSgGxM2/SKCYBbe
 qT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032544; x=1779637344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMbDrkvtCtd6UvJc33ms9/XbJib8gw5zzxz0w3QAZxc=;
 b=CB41HbGH6EKzIuMEGng+bpUjOcb92fZB7o2e96bYGu44lC+EZ/ZEA4mjKqwrReRwhU
 adxtUXD20umj0HgxIpFLWhrYNSbqLbuKB6IuEwB07DWWGh9YAH34oP+YKKhi2WhkDtu9
 1v5OPOzQYSWpqzV4QZN8IA/rLIEmWkAyJqOGVyJ+sWHfPtalh27eyASrdXasomNdviVa
 4DdJdd7kn0w6LaXBzYhA6FUmmNz7SxmtXqZP1tRFmHTVxblnIsaCOntNlJS+TVRdhcFm
 YKtL6IcVC7a+gl4KBoK0E8jcxURrZFKNjrxU+asHDmY+NGzNJROpjkIQVuU3AHUx/XfV
 29jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uJJQ2TPxt2jfwGU+CmbN4PSZ7F1visIplF78SPWIILSezm362ldjpDU3th5tB78pxY7AMMOke2EtO@nongnu.org
X-Gm-Message-State: AOJu0YxZR2W4UJNaJM3DQv4Fltl/sMCXOX8v/qgfYgMqQQa8xJUGg2Gv
 ZKvjb2FzfzlYFFQhsChvibYm7HmFCk3veifn/HJGRQtjxAKav/PgZGVdOxoRVtqUq8o=
X-Gm-Gg: Acq92OECRh8DQ+d0l0PXNxzx5ZqDaZJibIVHqfB+8oGPZHC1vfJo4gQ8xn4uUQqmz9z
 yv/hQjsbriXBiDHYF3rBmWtnYbjYf7kcrbg6s7amiqH6hgfhUKZ5TlHVCYk/EqKiJ7F/jBBEsju
 ko7rVS1I/Oqd/ejjLD6O2fVnhH1qKEGSlC8eizd6Yw6Zz3kIPU7X9GKXuJBN6LcaxXAZAEqBT3F
 zbP0vjxRQ6qzwhCVQvirrw+fUjSlt/5l/+N2G8BzIyS2YTAxdfgAGV1mhD1Jx3UT0XzVK47DQrp
 liZoY5idLVsaMpT1qJk2pbMf7+Bwfg5JFwzR/jP/A5F5JI8NrsEsbfZC2g8Rt1cda4pjxhOb2nM
 9pypO5doa6EPK09hZQPE8zUhw6o3j1BCN8fS6xG5bj6vrUXVTMEnwujI17sY3QjQk4IPbtxg1+f
 gdE/9KZQBX6joRV2JS62sDBYWcyfxlWxmNfYfstrypuiJSFgh6ud6YmItt6b7QIpKuAkIa/8hsy
 IRf
X-Received: by 2002:a05:600c:a406:b0:48e:82cc:4d4c with SMTP id
 5b1f17b1804b1-48fe6514939mr143010085e9.23.1779032543653; 
 Sun, 17 May 2026 08:42:23 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm196781765e9.2.2026.05.17.08.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:42:22 -0700 (PDT)
Message-ID: <38468155-e075-4974-909c-5c7b6a52df5b@linaro.org>
Date: Sun, 17 May 2026 17:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/27] target/riscv: Introduce externally facing CSR
 access functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-25-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515180437.23620-25-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/5/26 20:04, Anton Johansson wrote:
> Convert riscv_csr_[read|write]() into target_ulong angnostic CSR access
> functions that can be safely used from outside of target/ without
> knowledge of the target register size.  Replace the 4 existing CSR
> accesses in hw/ and linux-user/.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h        |  7 ++++++-
>   target/riscv/csr.h        | 13 -------------
>   hw/riscv/riscv_hart.c     |  7 +++----
>   linux-user/riscv/signal.c |  5 +++--
>   target/riscv/csr.c        | 17 +++++++++++++++++
>   5 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index eb18e1f59f..3352409676 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -903,7 +903,12 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
>   RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
>   uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>   
> -#include "target/riscv/csr.h"
> +/*
> + * Externally facing CSR access functions, wrappers around riscv_csr*().

Return: #RISCVException

> + */
> +
> +int riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val);
> +int riscv_csr_read_i64(CPURISCVState *env, int csrn, uint64_t *res);

s/int/RISCVException/?

>   
>   /*
>    * The event id are encoded based on the encoding specified in the
> diff --git a/target/riscv/csr.h b/target/riscv/csr.h
> index fef3cd34cb..370da83a69 100644
> --- a/target/riscv/csr.h
> +++ b/target/riscv/csr.h
> @@ -23,19 +23,6 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
>                                    target_ulong new_value,
>                                    target_ulong write_mask);
>   
> -static inline void riscv_csr_write(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> -{
> -    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
> -}
> -
> -static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
> -{
> -    target_ulong val = 0;
> -    riscv_csrr(env, csrno, &val);
> -    return val;
> -}
> -
>   typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
>                                                    int csrno);
>   typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index e675358e1a..d1c7188369 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -67,12 +67,11 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
>       RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
>       CPURISCVState *env = &cpu->env;
>   
> -    int ret = RISCV_EXCP_NONE;
> +    RISCVException ret = RISCV_EXCP_NONE;
>       if (strcmp(cmd, "get_csr") == 0) {
> -        ret = riscv_csrr(env, csrno, (target_ulong *)val);
> +        ret = riscv_csr_read_i64(env, csrno, val);
>       } else if (strcmp(cmd, "set_csr") == 0) {
> -        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> -                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
> +        ret = riscv_csr_write_i64(env, csrno, *val);
>       }
>   
>       g_assert(ret == RISCV_EXCP_NONE);
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 358fa1d82d..9d5ba300e4 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -90,7 +90,8 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
>           __put_user(env->fpr[i], &sc->fpr[i]);
>       }
>   
> -    uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
> +    uint64_t fcsr;
> +    riscv_csr_read_i64(env, CSR_FCSR, &fcsr);
>       __put_user(fcsr, &sc->fcsr);
>   }
>   
> @@ -159,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
>   
>       uint32_t fcsr;
>       __get_user(fcsr, &sc->fcsr);
> -    riscv_csr_write(env, CSR_FCSR, fcsr);
> +    riscv_csr_write_i64(env, CSR_FCSR, fcsr);
>   }
>   
>   static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6cc3fcd4e3..3ffb56e938 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5716,6 +5716,23 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>       return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, ra);
>   }
>   
> +int riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
> +{
> +    RISCVException ret;
> +    ret = riscv_csrrw(env, csrno, NULL, val,
> +                      MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
> +    return ret;

(Directly return?)

> +}
> +
> +int riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
> +{
> +    RISCVException ret;
> +    target_ulong val = 0;
> +    ret = riscv_csrr(env, csrno, &val);
> +    *res = val;

Clever :)

> +    return ret;
> +}
> +
>   static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
>                                           Int128 *ret_value,
>                                           Int128 new_value,


