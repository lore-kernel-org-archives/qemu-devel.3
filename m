Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FC7C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJSQ-0007Zx-Kk; Thu, 03 Jul 2025 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJSN-0007MH-H7
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:54:27 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJSJ-0000UF-T9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:54:26 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7d3cc0017fdso605744885a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751547262; x=1752152062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tkfBzDpddJr9lZn50dau+4PajXSOU4T2a0a2JU/cuOI=;
 b=J8clbtbxOER8u6aAnMLkoLfEz1f5m4+/+xThNY9SD3RyoHMIYjHj2fuj1XJ8zde5Xl
 Uqp8s7uNBc8+bluLKRSAWh0IBc4Gl/uJPD1oX+qFdA2SMluoHPyd13R0/IZJnjYzQ+zV
 Lc6CDvvQ9Jdj/tfgDA7XHJwZ7nwkV7BjYTKsYR/5kADTsqc5CJELmYCUsRRC/bjsJ6ke
 ZWpe6ZiGKxkzopTuDL+qYuxtADxwXaRTOfICoc9uNwuUIHg8KcqikthVfxKBv3HuWzpA
 7zinLd9HeXcKRNbBcRGLg6MAn708HmgdVZUvl7aSaGSHKU4QPNnW8r9ivSycXD0TgZI6
 vxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751547262; x=1752152062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tkfBzDpddJr9lZn50dau+4PajXSOU4T2a0a2JU/cuOI=;
 b=oxAAJId/ATjlGpPTEKQC/kdVUeGBRRzGOhG/b4pgaDZKTWSvnzKWDgVtShnHnBo5JM
 Hh8zvplhphpArCzkPx3z5AmynfEtfBEaWkM3ZDrrmyFzmwj7G1S4DxY/Rly3mbkc6Ldc
 qutrNhmj6LtEHzf0k51ruJmlvMwdI8PL+02kkvNwKyfNOom7TSpObXLF3f44N0xRMtCz
 nDVRn9x/uPS8gQzK6ODeOB0ORBvnMsPogn0CvrAngLwn4wvPkDCAqUuiW0297+ECqTW7
 EB9t9yEwAhlIgN4/yr+GYHX40uoFwr1IC1ruMMqNysAGzgxC8d+E5Fj6kKDz2GkQWTcn
 kO9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUentVwpU4EkfvgerWWHqL6cj1iRwXX+tZhJ2nSsr0CO8p1BYCdSx+j5PbkLfjFQXdykwThUoZp7qus@nongnu.org
X-Gm-Message-State: AOJu0YxXKSbF4eThuTNnc6RyruQdW1lErrAdmMrDApekFsGDjbLyJoHB
 qLSzIVyLUGR11PwcJdtn3aiRvROoCt/sr9TQASWmbX8IdWOcoRzFcvwUqR1QFDh7ojA=
X-Gm-Gg: ASbGncsqAoUUdDWyb6qX8ipcX0IZKMdAkW/xz7YXOdAlxCjB66ybfrVd8ckaEp0VhtY
 7oLqyVo4F0j48bt7hPb/hpRe05yk2wmHpDIH9MMHF50KpYcD6psC53KSFVejGRQIMT1s3CcyRgt
 wl4fGSYK19mP+dXlMW5noTAXUbQqd4T8mH7zq+DSnM+2h0XOJG18f6ssu/6+FPMJgjB3c2prGz4
 iLoyDJ1MPZY7aiTULjbUJpx7ebPI3kuG0Nscx7ybSDI4e/9rJwbHsLzHyTcPJj68+u7CM2U9pSG
 rNKp49kpDuYS9ezcLmLKs1g0jDIfcu+9As/Jc8MRX6a3zuFxzuNnktuLS4aTMVZ0f4ekpLKTSl9
 ZTg==
X-Google-Smtp-Source: AGHT+IEBgS/H5ia4+tdim/wpP8Iw2YZ5rqmDuahfJJaU627vIX6VdZnGcDy+wGvktqTqlPDplnqYKw==
X-Received: by 2002:a05:620a:7003:b0:7ce:d04a:83c2 with SMTP id
 af79cd13be357-7d5d14a0209mr523900185a.50.1751547261741; 
 Thu, 03 Jul 2025 05:54:21 -0700 (PDT)
Received: from [192.168.68.110] ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204ffasm1108236185a.70.2025.07.03.05.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 05:54:20 -0700 (PDT)
Message-ID: <73a34e0e-0451-4f5d-98b8-c0af00c0ff3a@ventanamicro.com>
Date: Thu, 3 Jul 2025 09:54:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
 <20250703104925.112688-3-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250703104925.112688-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x734.google.com
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



On 7/3/25 7:49 AM, Djordje Todorovic wrote:
> Add a new function, so we can change reset vector from platforms
> during runtime.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c | 13 +++++++++++++
>   target/riscv/cpu.h |  4 ++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..e584bdc5ac 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,19 @@ bool riscv_cpu_option_set(const char *optname)
>       return g_hash_table_contains(general_user_opts, optname);
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +    CPUState *cpu_state = qemu_get_cpu(vp_index);
> +    if (cpu_state == NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "cpu_set_exception_base: invalid vp_index: %u",
> +                      vp_index);
> +    }
> +    RISCVCPU *vp = RISCV_CPU(cpu_state);
> +    vp->env.resetvec = address;
> +}
> +#endif
> +

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
>   {
>   #define BOOL_FIELD(x) dest->x |= src->x;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..fba0b0506b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -656,6 +656,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>   target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>   void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>   
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +#endif
> +
>   FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>   FIELD(TB_FLAGS, FS, 3, 2)
>   /* Vector flags */


