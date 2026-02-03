Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A16E83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn73r-0003N9-7d; Mon, 02 Feb 2026 22:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn73p-0003Lx-BI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:26:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn73n-0002i1-N7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:26:41 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso34774555ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089198; x=1770693998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EGa/hqp5GKihdVNqYGoPwpQJjZEEgHf+5zsac7FVN/k=;
 b=EpWodyf2RI8WxwQcxRrliPsLlInnzNRmmdioCLSNJtlbGDJcabSGH5jUMZ2OlgcIv0
 ez4iNxpbCl9llaxV1b5bFCrkyP5VzqzvrnKLJbNpmtmsGx1Mja2fc9fHYmrdxyiOjFgA
 pR5pcxj1z3HBejgXkO+78QUwK0rKd6NjoMLDOD2rSzwiEVA8zZZkhfdAQDVsi7UY7Ues
 VKf1Xip0Wd4v8hqj+kFblt65kMMae6gs83ANJscmiXCiJepafK0zjIa3TKQ/cXTaK93S
 e98fGUflWE11fODz22uamzXkWmhlHHlVCGGZwDPMQrWNG12IWQltofHMvDPYSggejE/M
 Ep7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089198; x=1770693998;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGa/hqp5GKihdVNqYGoPwpQJjZEEgHf+5zsac7FVN/k=;
 b=iu9uqBZiHtz7FWapZ79ofGVN7GWUddQMMt8Hi8DsW5NhsONBkwBFzMUun1qvlOvpgx
 2me7CskW/y3Fp/94xtFAQHWV4DOVHvfuO0KeMGFvYbaVDg8aw+bkP8U72I83fJUbKa9c
 PdL1AypghFpRJVBHNja7aT3jp6Q9ksMqNIjjjevX56jb0+TiXt33j+J9GJXLhe4lYvY4
 b+Z9lUbYFy+4D1gkAMNVdXTUtBFBsJCmuf+3BSLQXwMe054HTD0slACS6l62V/T1Krwd
 +EhV/jXUbCjbi0glrExbcTCzDVFxpr8eXoxCUg+mk89HIaOPjf1LmR8H+bTGvfgj7i8u
 01Rg==
X-Gm-Message-State: AOJu0YxMo2T6Wmfg8BjM8GmJAl6H6pBMIQb+49B1meFKb2F0r7zi0dwM
 l5uc6uC7yGjaNYoSnvyUVmuugw+QeLqMKuaLx7AyGRDHF5AWz/0YkUrUar2pDDqufHvXI3vGIyG
 7y6Bvd93MPw==
X-Gm-Gg: AZuq6aIRddwT/yaDQtxYrF5oMGUYKh+TA4pzMNsUoyy3bBRhajhwx5FzoCkPxFyX3cO
 9ceAKwt7dnqo8CxfaE2fYiHG35MqvbWkMPN2+qZBZ/iJ7NI9gTu1MYFYMY1WortzqQDlZj5QKbb
 PkJkSXX7UtFMIoHgby/NGDVqJHiFUGgyucmWdSK9uperXwkyH7/+0mSBnxQTE8kcAm308fYO13p
 KvlNVdAs6kC7ziyAcglT8nAcM4ffxZYnqo1pTipt+gjNiZNro17oMrad1eZJEWZ5VF3YAtTioZk
 e8jyao5IwzW7fgrIz+wr4y8oLs4vvyHT8dqUnMYPoaNxcFq+wGhEpkJk4MtNTtv2GKSyBK1AOxQ
 ihHGkr4tCb5zKd7D/jgd6WuR/CPi9/1hn0lKcRES3PUBODkqDZuGVpbDHNa4dyIsw62E5u5YUd1
 migXPGyOHSadq6CKpGZbBGFMNkUh5dVnzDkUFdUpR95B1EIvcwXLFkJ1/t64pxxw4bMt32drd7
X-Received: by 2002:a17:902:f60d:b0:2a7:682b:5098 with SMTP id
 d9443c01a7336-2a8d959b11emr121563385ad.9.1770089197549; 
 Mon, 02 Feb 2026 19:26:37 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b1ef88sm14519378b3a.8.2026.02.02.19.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:26:36 -0800 (PST)
Message-ID: <761fd603-2279-4900-9910-957049a3cd21@linaro.org>
Date: Tue, 3 Feb 2026 13:26:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Inline cpu_ld[lq]_code() calls
To: qemu-devel@nongnu.org
References: <20260202214317.99090-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202214317.99090-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/3/26 07:43, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ldl_code() and cpu_ldq_code()
> wrappers, inline them.
> 
> Since RISC-V instructions are always stored in little-endian order
> (see "Volume I: RISC-V Unprivileged ISA" document, chapter
> 'Instruction Encoding Spaces and Prefixes': "instruction fetch
> in RISC-V is little-endian"), replace MO_TE -> MO_LE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/translate.c  | 3 ++-
>   target/riscv/zce_helper.c | 8 ++++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d8261aeb662..cb4f4436018 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1181,8 +1181,9 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>       CPUState *cpu = ctx->cs;
>       CPURISCVState *env = cpu_env(cpu);
> +    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cpu, true));
>   
> -    return cpu_ldl_code(env, pc);
> +    return cpu_ldl_code_mmu(env, pc, oi, 0);
>   }
>   
>   #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
> diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
> index 55221f5f375..15bf0a99c8a 100644
> --- a/target/riscv/zce_helper.c
> +++ b/target/riscv/zce_helper.c
> @@ -23,6 +23,8 @@
>   
>   target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
>   {
> +    unsigned mmu_index = cpu_mmu_index(env_cpu(env), true);
> +    MemOpIdx oi;
>   
>   #if !defined(CONFIG_USER_ONLY)
>       RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_JVT);
> @@ -43,11 +45,13 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
>       }
>   
>       if (xlen == 32) {
> +        oi = make_memop_idx(MO_LEUL, mmu_index);
>           t0 = base + (index << 2);
> -        target = cpu_ldl_code(env, t0);
> +        target = cpu_ldl_code_mmu(env, t0, oi, 0);
>       } else {
> +        oi = make_memop_idx(MO_LEUQ, mmu_index);
>           t0 = base + (index << 3);
> -        target = cpu_ldq_code(env, t0);
> +        target = cpu_ldq_code_mmu(env, t0, oi, 0);
>       }
>   
>       return target & ~0x1;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

