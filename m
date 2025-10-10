Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B2ECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7G9J-0003FA-DO; Fri, 10 Oct 2025 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7G9C-0003D6-FM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:39:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7G90-00023c-MZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:39:10 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC5273FCD8
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760114331;
 bh=Y4iIKwW/REG2fy7zqN/4K0VxvoaFykjEUhPEfuHJTMk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ph8scYjSKJxw48lGhaMiTPyIcSfob9Baez/q986mjt7hmCW/y6l7k27cv9CqcIu8K
 3WHQLYRL/I6Kjp/Pts8dwNoQpvZpfgAGNr8gYNrorhUcoNUZLG9x+OSzMMYWjYTJRM
 EX5i7ej6Y252LTD0V25mpFMIamgLcNwZ7wh4kww5zSRDPc5jPQTwA+V0/SvVV+od+6
 Gcuey7NjLQcL9l23treV+yQeDJx2gL890xz/F5fcjyGVWh272xgSwRCtFG79ZvfCa/
 C2x93GbOWXwuWT/Gx1EDWD4fT3TAJ+YMfaMhHaIdvFIWV7X0DWicSeQlVI7Fsj/Sb+
 nrDX7cQkt0AaJYpZk/0MgG5wbX9095kk9sBQkmVOkB/gusyw+WrThbgb6dIHWtJbQl
 OWsjTaurcdx7AkTlCjYMQHzYY8I6AxT7zjk8SIDMQh1yDhTskSHkmfVpYUBT9UrRA4
 S2uN55K30UEysIrzWC7fRuj0nX/lPZBxwiy4ifGaP8rX2xelUJubVVlZPZgMI6e8lx
 DClO8xPizWfSwzvM/5ESsDazknvof3KHi1ujROk7oz5uQU9nYtw1dwGpjA0lA/wk14
 sqms/4AStxvnhk9dTGMsKxETbXorV0B4d+JgAt2MJBRPIzFWJTIEHr03C4M0C2T0oU
 ZLyJFDyH7bsFV/TXr37MgQGg=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e39567579so11585655e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760114329; x=1760719129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4iIKwW/REG2fy7zqN/4K0VxvoaFykjEUhPEfuHJTMk=;
 b=Wmk/Ych47eGxCd9FYloJyKAZJDVoo3c2SizlIMHLSeEoXOVFj+UOi/7Owzj+wCb1Ad
 n5PtbbcHvij04UginkNV86xOFx+1EW9PF4F4LPhep+JIO4rCHTv45z9BDhd0z0n4ZMC6
 AxEXBQWcnPrDPL4tWVaVEWQe99EQOp3gOs93tZV2PzslwGJTZsNtaWjMJ7rgoMDY7GTH
 OErLNEs+u/8v6ASIQAZgrcvmUaoP1huCGiMbJDygRiIvpNHKWYa+cXr/nd7rRvUAiThc
 4Hr0iNqROYTnjsnYSAwL6MluWzL6JhQf+62h+CJfdVrICzUDsYHDi845h9vXQevr5gjC
 gYRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxzqNT8fX9V4G+XsQCLT7Pw+m50QYGC0cqvnWv1XjlV54TxbVNsV69njvCz5tqF7ou9DBAeHI5/50U@nongnu.org
X-Gm-Message-State: AOJu0YxTwEh+0YEW79bkO+wrDxOnxp3zRwF6O/T3yh/t2kBom5tguzAE
 LJ7aM07PLYw+6nKy+EZNtdS8zZSE7v8dHneV4vUb4H+sR7wFYseOp65SMVV0tN7wrAdtBJ+F1NA
 iwftnHUHadMCyLZmleeVC//EXGVjCyckaHecBaaTWsah17C1wvi1R0NribunkiS9OiDlZmVBt
X-Gm-Gg: ASbGncvnBv5qJ//lpz6/ATcWeQRda4Y8t/f+2GnJA4ethmYOTIxGjAV7kwTWCH0UCZV
 1lHpNZBXizFWd/w23m/RqBMG+1bfwU6Shvj4fPizVyV3WPZzwx8IMuC5FP0/Bt09+MbszFMFCK9
 CHpzokVUhyRic7Sh6Y/T6bPaVsGya04iA+YSU+1IXzxPgarshSM4WNGotzz3FWZ2+qkJFu+62hu
 3lFPnw38ljLVUoWb5z6nHnWMDvEfmI83uIbve8Wc1PF/FZG/MAu7Ux9orBXFhS2ESt+SasU2KqO
 ApIKYYxuIQ2nCO79YoX787ONfpe7h32TXLIWnfoFeAPX111HDhmK4zeRt6ZEQJk+FGN+AMuIBqG
 ROHLQSXYdEbjGsMcDnEUtmcg8EFkrT9KnYLle7LnWb6OSYZah
X-Received: by 2002:a05:600c:4752:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-46fa9aa48d7mr91075665e9.15.1760114329210; 
 Fri, 10 Oct 2025 09:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiEuIKCmOtGqvJgAJqkvjEdLIdBMsg4fCh16P5xIzF/GR83E2w+iJm/EX3eLpvQ1mCPZ0RJQ==
X-Received: by 2002:a05:600c:4752:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-46fa9aa48d7mr91075405e9.15.1760114328766; 
 Fri, 10 Oct 2025 09:38:48 -0700 (PDT)
Received: from [192.168.103.116]
 (dynamic-046-114-109-147.46.114.pool.telefonica.de. [46.114.109.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4982b30sm53309035e9.6.2025.10.10.09.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:38:48 -0700 (PDT)
Message-ID: <174e2a19-85f4-48f5-9a22-aadd8c3848a6@canonical.com>
Date: Fri, 10 Oct 2025 18:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] target/riscv: Introduce mo_endian_env() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 Ben Dooks <ben.dooks@codethink.co.uk>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-14-philmd@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251010155045.78220-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/10/25 17:50, Philippe Mathieu-Daudé wrote:
> mo_endian_env() returns the target endianness from CPUArchState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

LGTM

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   target/riscv/op_helper.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c486f771d35..9d048089e2a 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -28,6 +28,18 @@
>   #include "exec/tlb-flags.h"
>   #include "trace.h"
>   
> +static inline MemOp mo_endian_env(CPURISCVState *env)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    return MO_TE;
> +}
> +
>   /* Exceptions processing helpers */
>   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>                                         RISCVException exception,
> @@ -633,7 +645,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>   
>       return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
> @@ -642,7 +654,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>   
>       return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
> @@ -651,7 +663,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
>   
>       return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
> @@ -669,7 +681,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>   
>       cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
> @@ -678,7 +690,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>   
>       cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
> @@ -687,7 +699,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, false, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
>   
>       cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
> @@ -703,7 +715,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, true, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>   
>       return cpu_ldw_code_mmu(env, addr, oi, GETPC());
>   }
> @@ -712,7 +724,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
>   {
>       uintptr_t ra = GETPC();
>       int mmu_idx = check_access_hlsv(env, true, ra);
> -    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>   
>       return cpu_ldl_code_mmu(env, addr, oi, ra);
>   }


