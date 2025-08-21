Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651F7CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 09:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up1Y2-00026t-TZ; Thu, 21 Aug 2025 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1up1Y0-00026P-8A
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 05:25:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1up1Xu-0007UQ-Fn
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 05:25:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so4028965e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755768316; x=1756373116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZoF9TVqviGqvmmUCsga6Mg8l8qam59AXQYKXFI6LJI=;
 b=oqwPHWCNvEOyHITmX8M7KnD5hJQ2rHJhxgrQMY9mLlha2C6vErWhD6vDkhIUzMAHjP
 3F+z/6IrbX5U9stURwlRpQi+6/Ffpa9oPzorqeKK2m12ez0OiMkHTvlOd76yNosmdfUU
 xXeE/xuAN/7wdzEXYCdlJb+wAiWUy+sBhVvKvJiXrKJkj0nrDH8Iv/BJxAVc0DYRGc5Q
 M6cfVm2y32SJfnLXJbVgmI3C28zSXC7ijvhyKwWqaUEioTB2BTa7FknCQVWgXG2F8Qn5
 le8APxVGvJ08TyJMQDvrWidmydU3Nxm4VqndWweea+pGwwRJDLAI5bWHYJikyBWrWQJ9
 Wdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755768316; x=1756373116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZoF9TVqviGqvmmUCsga6Mg8l8qam59AXQYKXFI6LJI=;
 b=Y3P5xxtIso4u1oMaHKCVMTVB2YtwfFbZ/AeDrUtixgjK5eQq7y1O4iaCITjXa+H4r5
 780ZXDzbDxVVh2s7S6HVgcTMp4l0pilLEsqccLhSFMYsqCuqB5Vu/2668tHVbERKUvlD
 rnLtQtgUIhoHSxhj3m1TucVUgbHFFy5uC/zLbmu4ZNuptyhb7iNJTutHOX77dWvqim2M
 P+84Hi+PoWZ4Migjat4euAkLPr8CZKaQ2eq8v/dqdSNUUJIORf5gefiMoqHkK5U1whZY
 +IolQrhWTH1ch2fw9aJU0tQAGmxR5BT6ggVzwZiaIatrDqmRR6u0pnuZiO7/W7/gGRfA
 lmBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU1fPPiMVTFSf0F2QfAXJox0NMPo1QlbkoZrSwSbQMu+csfmxY99uh1WnWBaU7dsg3KZXEbC4ek8af@nongnu.org
X-Gm-Message-State: AOJu0YxWDOnmgiY1cfXLYRcuMyOgPOivpwhpql9nVAUxG23D1X9gsHI0
 g+o/wtzlGO+9NF2xdqumeBv5irgYwNn22GB2pG5Br3m2tLyzOlYQkFFTF6r7JfWBaQ8=
X-Gm-Gg: ASbGncs2Mzf3cJiTmV4pe8HbTkThcOTSrAxte1TpMoLfc5/AMTj4gnL8NEXNw08d6D5
 gA+kWyffnm1aU9fL6huT6fNxqVCyE3hljkNlynzwUqMvc/W48OA2lWIP4bGiy4ki6vbA0cC7yJU
 olhZhFmg6KKlhX3DCMSKX8N9IsuBfJLWQZ38ipnV/CwxIX51bm0vKE0dlc6G6RTse7UEzpjFfhP
 nr6C3MdAd+0Xc5Bijrgcn9H7WFvcEDkCFm03L3cRAjcgpj6KPAgdU/9tIR+Xhmz6FOc1MIW5bvV
 jgShT4LdiQ7EVj5Pj2DJaGmS9cVruVvjIfjc0JL7fkQMfxpq/mZtWBn2X6QXQMKST7UwJ+Vsv3D
 pfGnPdr04f5x/A2vDuzdgO5buIJ89HQ/4IcfMCMT6YeyWJKn6K3CcGz+22ma0EQcIDZOQ1d+gYv
 PF+GdsSQ==
X-Google-Smtp-Source: AGHT+IEv++PoUuG9FqcgPs8nXbX80C5qlHOlqJT5APZQXRWFvSLKaDV5ZxHAlQWPpPES4s+i+N6z9A==
X-Received: by 2002:a05:600c:3109:b0:459:aa0a:db2d with SMTP id
 5b1f17b1804b1-45b4d84e721mr12895685e9.28.1755768315810; 
 Thu, 21 Aug 2025 02:25:15 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0771c166bsm10971148f8f.33.2025.08.21.02.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 02:25:15 -0700 (PDT)
Message-ID: <d42e9b86-80d6-4357-8d8a-158a60db0eb9@linaro.org>
Date: Thu, 21 Aug 2025 11:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/30] target/riscv: Implement privilege mode filtering for
 cycle/instret
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-22-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240718021012.2057986-22-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

(old patch merged as b2d7a7c7e4e30fb5341d38deac968de675f9419c)

On 18/7/24 04:10, Alistair Francis wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> Privilege mode filtering can also be emulated for cycle/instret by
> tracking host_ticks/icount during each privilege mode switch. This
> patch implements that for both cycle/instret and mhpmcounters. The
> first one requires Smcntrpmf while the other one requires Sscofpmf
> to be enabled.
> 
> The cycle/instret are still computed using host ticks when icount
> is not enabled. Otherwise, they are computed using raw icount which
> is more accurate in icount mode.
> 
> Co-Developed-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Message-ID: <20240711-smcntrpmf_v7-v8-7-b7c38ae7b263@rivosinc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h        |  11 ++++
>   target/riscv/pmu.h        |   2 +
>   target/riscv/cpu_helper.c |   9 ++-
>   target/riscv/csr.c        | 117 ++++++++++++++++++++++++++------------
>   target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++
>   5 files changed, 194 insertions(+), 37 deletions(-)


> +#if defined(CONFIG_USER_ONLY)
>   /* User Timers and Counters */
> -static target_ulong get_ticks(bool shift, bool instructions)
> +static target_ulong get_ticks(bool shift)
>   {
> -    int64_t val;
> -    target_ulong result;
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (icount_enabled()) {
> -        if (instructions) {
> -            val = icount_get_raw();
> -        } else {
> -            val = icount_get();
> -        }
> -    } else {
> -        val = cpu_get_host_ticks();
> -    }

I see this comes from old commit c7b95171881 ("RISC-V: Implement
modular CSR helper interface"), ...

> -#else
> -    val = cpu_get_host_ticks();
> -#endif
> -
> -    if (shift) {
> -        result = val >> 32;
> -    } else {
> -        result = val;
> -    }
> +    int64_t val = cpu_get_host_ticks();
> +    target_ulong result = shift ? val >> 32 : val;
>   
>       return result;
>   }


> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_ticks;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_ticks = icount_get();
> +    } else {
> +        current_ticks = cpu_get_host_ticks();
> +    }

... but still I wonder, why not use cpus_get_elapsed_ticks()?

Regards,

Phil.


