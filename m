Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BE3C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 01:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjU3y-0000pI-4w; Wed, 28 Aug 2024 21:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjU3v-0000oA-MP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 21:34:59 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjU3u-0004zV-3U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 21:34:59 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5af7ae388so624375eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724895297; x=1725500097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qep8yR8s+rY1Ef9UBF07/Ay4uhtiHegsBcniif4fzWI=;
 b=vRhPXS94r2YHyH2lYiwj/Y9IHQFiYUNs30dEpqvcHd38FwyahpbmUugzYRdPpnwrvG
 4JtbkqcGgGrSvzSRYXyYfdNNpDVh2DlsYthGYlYnU/hxWCPWIINPcbnzbnruYEFPEXYZ
 808t8Ykbb4rp16uYVUy80CpWVzEFGK4GAPVso6VeWOv5Ep39KytjYwZK4hPOrrVv1ncE
 OWZcPXqgrvYLUo0ziLrPlLI+4An+pq4kj94SiRYmf0Cxwz+8+6Jm+lcKEOZCOhd/IaZl
 e6L6lHzT+0IV24veTfXqdRW//M0rhElkeD4gdTQQ1QjTC3V57qed1gTCJRH8WNPDr2T0
 5ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724895297; x=1725500097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qep8yR8s+rY1Ef9UBF07/Ay4uhtiHegsBcniif4fzWI=;
 b=tflABn0PRbgHkmq2cUDIOyjOOtdc8LTm34LeMzaV9z+zsRrFAR8FqBQSHew1KZk8lD
 YwPZKUcatLcc/P6nleogQ6cT8+vIe1vHFwmMoFpSzkaDDXc2laJLjiV+XRt4pWfUlJ5p
 aSh4eOFtroa4X0me9bjKPV/LNEhG/zwYpuux6byBmc3xgarwRmwectzhn2vvIqIVEFm3
 onJyf1bgCx8h6jel5Nr5IyJE6voVKAhpoW0F9t1My/Qw1bi6alzIkG8nksj4HnvMG/LB
 /XL56hKoKFMjPWti3Mm0cYR0LMMTqUfRGgKkrLOh8d7vQcQ0TxsrDiQEjrkoawzLOWwI
 bNfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdlrtZ5dmAFYfsZDKCD6B+8Zy5/8bklmRECxDj2J9sc5dxPv6ifECiiBYh7fMQLmyk+n7LCK3RZkMY@nongnu.org
X-Gm-Message-State: AOJu0YyFur3Sz+6dTs+BerIPajbXq1P+sXIM6PqOaaF9NkIEVvi6EDG+
 XGEwy06rZ3R5yIwu5EFnBv3VXpKXP1IKThjWoqnh1uOMQHzIs6mf3fiB0xblAAA=
X-Google-Smtp-Source: AGHT+IH11RFil94bYuSqIYb6Ojv1CrJ47fzCO+9WZ9tthT8AcMrLiZZ775MIXrxzR+Sowk4dk6wSjw==
X-Received: by 2002:a05:6870:56a8:b0:268:282b:be0e with SMTP id
 586e51a60fabf-2779b731bc9mr11221fac.15.1724895296605; 
 Wed, 28 Aug 2024 18:34:56 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f60c73484sm38699a34.24.2024.08.28.18.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 18:34:56 -0700 (PDT)
Message-ID: <58b2e7af-3ec0-49ff-a44f-e32924a99062@linaro.org>
Date: Thu, 29 Aug 2024 11:34:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 12/20] target/riscv: tb flag for shadow stack
 instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-13-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240828174739.714313-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/29/24 03:47, Deepak Gupta wrote:
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -169,6 +169,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>           flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
>       }
>   
> +    if (cpu_get_bcfien(env)) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
> +    }
> +
>   #ifdef CONFIG_USER_ONLY
>       fs = EXT_STATUS_DIRTY;
>       vs = EXT_STATUS_DIRTY;
...
> @@ -1241,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
>       ctx->ztso = cpu->cfg.ext_ztso;
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
> +    ctx->bcfi_enabled = cpu_get_bcfien(env) &&
> +                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
The call to cpu_get_bcfien here is wrong -- only test TB_FLAGS.
(1) The compile-time check vs env is incorrect,
(2) You've already done the check in cpu_get_tb_cpu_state.


r~

