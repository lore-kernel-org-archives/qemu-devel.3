Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E012FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rXh-00010u-Gt; Wed, 01 Oct 2025 03:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rXd-00010I-W6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:46:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rXU-0000q1-Rp
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:46:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso44810955e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304770; x=1759909570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IoTDv6hFn4BfIhUBxHuam7RuE+a6664jD93Q/0Jfhc0=;
 b=oLQqk5A/FSIEuCm4k2PdeJT5SeTNVT9NpxZA7jMIHAGAlZgcLDQPUTjf73NDfFnPPp
 xBMIA6tzihKV0CCU7APr6i7YjMHDLH5FpNpeurq80MrzoosFqOTY8bCzS9Sf8IFcAe6R
 67t6UZhkhuvyZ5SAkITuGynBHvsIR9mUDvkALLUToONng9XKejlQqg/2+W6zv2gU8Gjj
 mlo26OkANp9m9DJGFr9U/gWN/uSgRdL1iQvmDRDzXGkRaYvhTnNNowtQ9FJEd6TohNX9
 K/Qe2uK4Ar/n0mifAtybwWWfaDGa7b9gIkNfpW0EQswSP+9slynFoA6skx24ZZYBE+PK
 0shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304770; x=1759909570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IoTDv6hFn4BfIhUBxHuam7RuE+a6664jD93Q/0Jfhc0=;
 b=n2C5y/xF4+pBxmuUlRUEztvtCIENugmfM+bXyUk5usMZ5vIQ2zoqqrcxvpMpv7WUof
 SUpONIzDVLHli+omAQexyA3DNIuHfZP4HmNG3Q3DkaCgCXenPY4Le++4fCrkWkF6wzvr
 DUiNlsQfN7kDablzGNtYaLdm+gnvlYOt00PS0HljlqOgipGxuBEXjUF9KiPK8JidWi8u
 ddtkEqZfoxXezb1oPYVmqVMX7v4m4m0FHRwlIHXkhZn9j4mHkpGnjDz+q52tN0X7ofit
 btkkDkwc/p+zAXp7AGZMCbYhYepPVfljaYNtLzxJm6AtJf2FTEzaWFRHQ4fi8uifDkRL
 ENmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu16cig47FD5mNjoIxBLhvbGFvVmw48Gn/bo6W5qG3dt9+MFu7EbQnUQn48E/dE/UKD99rHierL68C@nongnu.org
X-Gm-Message-State: AOJu0YxJozu8B0P9pjdInJZUnxSLj7wFKi7GHkkahSqjQUR0ss9OSdTB
 BhgyVfbX5hIVvFeik+XojMu32bCj1KKQVJgG0vyXyYjXBqo9bm7RwwcAuc9m4dWK2Ro1gFQybYw
 8m1S7XVe4cw==
X-Gm-Gg: ASbGncsjA2J62yTGFJt88UG42awNYbY73Q3QY767nhlFgEkJMFKuN3AetP4Ymkpw+kR
 LvtSOBwghYYORogYQ5UG7SaeYfB1T9KvDvP6o0cgjgD748SYktq94zGzlhrUvezRX7nsMqGMhEz
 0BTpJE2Ak2jRrRdhz6j/WQ7uVluh1DarMGBSpdLgsy+AlAcODneSWYI1y1nnM6iOA+dCXEqOyMw
 plY024wXdPJOkhRvS5aQcGmtDAZcPmzhQ1E5blb4P+/ZZUL85nQO8iw/HJS098VHHKM62DyU0RC
 cixxLR0YCCu+cymGEB/DNoQGLdbAE7hzH6NigA0OzH8b7P7jBNajAGE0sJzBLeUHYKktBlMRVAW
 Z91xhqNYCmWHHQIPQpdvhdOT8h6L0TYrCOOBcBmWbSA4B4xV8wQijstEp3fhzpCnG63EVjCy95K
 OwtDQ4vwE/YYgZxoU36WXQk7Pn
X-Google-Smtp-Source: AGHT+IHZRbx1bXKunYFNuVLO/ZCFnr3YibLoZkswCHTmNb9SbZSji5mVzOMeQy26EAWrzLhRzcThww==
X-Received: by 2002:a05:600c:4fc6:b0:46e:45fd:946e with SMTP id
 5b1f17b1804b1-46e612860fdmr22436135e9.31.1759304769946; 
 Wed, 01 Oct 2025 00:46:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199193dsm26905275e9.1.2025.10.01.00.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:46:09 -0700 (PDT)
Message-ID: <fa726eae-ef77-4619-ae24-ff00e21421d5@linaro.org>
Date: Wed, 1 Oct 2025 09:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/33] target/riscv: Fix size of trigger data
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-29-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-29-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/10/25 09:33, Anton Johansson wrote:
> mcontext is at most 14 bits in size with the H extension, fix to 16
> bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
> elements, fix to 8 bits.
> 
> Note, the cpu/debug VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     | 10 +++++-----
>   target/riscv/machine.c | 12 ++++++------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b17aca0e02..b718f6f3b1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -460,11 +460,11 @@ struct CPUArchState {
>       target_ulong mseccfg;
>   
>       /* trigger module */
> -    target_ulong trigger_cur;
> -    target_ulong tdata1[RV_MAX_TRIGGERS];
> -    target_ulong tdata2[RV_MAX_TRIGGERS];
> -    target_ulong tdata3[RV_MAX_TRIGGERS];
> -    target_ulong mcontext;
> +    uint16_t mcontext;
> +    uint8_t trigger_cur;
> +    uint64_t tdata1[RV_MAX_TRIGGERS];
> +    uint64_t tdata2[RV_MAX_TRIGGERS];
> +    uint64_t tdata3[RV_MAX_TRIGGERS];
>       struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>       struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
>       QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 18dbc1bfa9..aa71aa6eb1 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -238,15 +238,15 @@ static int debug_post_load(void *opaque, int version_id)
>   
>   static const VMStateDescription vmstate_debug = {
>       .name = "cpu/debug",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .needed = debug_needed,
>       .post_load = debug_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
> +        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),

Should mcontext be migrated?

>           VMSTATE_END_OF_LIST()
>       }
>   };

