Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC36BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhbp-0003vp-O9; Tue, 18 Jun 2024 18:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhbo-0003vF-2K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:47:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhbm-000166-6h
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:47:23 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9885d5c04so15497055ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718750841; x=1719355641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPSZ9H54xbAxtJlQYOVaSiG4Qopo67aBp31sNcHg2g0=;
 b=N1rviF76RE3CxAV/CkNY38RGMn+F2i/oSwC+XTierzlFtZtYW7R+PjkWBdubx4SMcx
 goiSGjUduQWvLI2CRrz+8VPFL6KZ18Bsn+9/hcGzMHrAQ5v0Ip/kMvr8va9Y4612chdN
 3Fea+AnYKh0JyLvw6qJ3RtR225q/fB1erAI7QmvOt90Bp2IRZViPM0OLGoNSYywH9N+S
 LPrHKpBlqiUI7s67neDms1UhMQatLrgwU9QPPzouJ+zkBW+ekEapjVIaDTNagJnLJQAh
 hOb4QxSWId4Fz299mSOCBqjV98ZF8jJK3D3K2emz0VAFP+6uIEYaFIzxQpt3IcmP09L+
 3+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750841; x=1719355641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPSZ9H54xbAxtJlQYOVaSiG4Qopo67aBp31sNcHg2g0=;
 b=gNbjyn5en+2QSpToFZ3ZCkxqNDK/bLZEGKDeNpe2TZtP9t6L+0Ra9nHthQ5HMVllaM
 L/SFpT7fUi3r49RVEABfm5QgoVWLXQrnYa0tkWHZrBEpw6pDB8BJvkr3X5xHg6ruNCTS
 8N4bS8fHunzmXsVahsOKJ3H+38KOwrprSzvHmwJYbmyvgb7lk8d8K91u+vR03g+f2fqt
 Evo3TGYKwoxcw9MS6hIAdp8Tu4Im7ClRSP8c++hl2T1fqYJOonp5XDwC2XFAZ5JgD2hu
 dE5xyYa022r+91Bfo4N0rT4vh0btSvQnNFkx0BH97K+Is28/ZIzHJ0AhcM+DBQzBLIaj
 1d6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfYrHRYmxF8eqxF1PKYMV3+AC5skrh4AhUwq/iSgz6QGd59s5ydCTT9bmWhHG39MMenZ0vNDw2bVFSbbHHTih7V3wcfa0=
X-Gm-Message-State: AOJu0YwtxcliWjCSR5fReOlUp+OwNj827/0YsIwFk1HWFgpeyB4XGWcn
 8wqmbzUxYyk6bfbezv+MjrUoPk7GmYlg+AMtt7bODoiuqYe+cfTaCUARuiOnXfU=
X-Google-Smtp-Source: AGHT+IGmS5R9IowiFcd/w2LKdywyuxCZsP4Z2BvvYXDtP/i9Ky6SCeWe48nLqcsWalyH52v9R27qJg==
X-Received: by 2002:a17:902:d4cd:b0:1f9:9cdd:dc5c with SMTP id
 d9443c01a7336-1f9aa3bc97emr10991495ad.4.1718750840464; 
 Tue, 18 Jun 2024 15:47:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f076fbsm102678335ad.198.2024.06.18.15.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:47:20 -0700 (PDT)
Message-ID: <7d9b3af4-54cb-4805-a569-9ba228bfae0d@linaro.org>
Date: Tue, 18 Jun 2024 15:47:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/23] Add get_mcontext function for ARM AArch64 in
 bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-21-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-21-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/17/24 11:58, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> function to retrieve machine context,it populates the provided
> target_mcontext_t structure with information from the CPUARMState
> registers
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> index 98861f9ab3..ab3bf8558a 100644
> --- a/bsd-user/aarch64/signal.c
> +++ b/bsd-user/aarch64/signal.c
> @@ -51,3 +51,33 @@ abi_long set_sigtramp_args(CPUARMState *regs, int sig,
>   
>       return 0;
>   }
> +
> +/*
> + * Compare to get_mcontext() in arm64/arm64/machdep.c
> + * Assumes that the memory is locked if mcp points to user memory.
> + */
> +abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
> +{
> +    int err = 0, i;
> +    uint64_t *gr = mcp->mc_gpregs.gp_x;
> +
> +    mcp->mc_gpregs.gp_spsr = pstate_read(regs);
> +    if (flags & TARGET_MC_GET_CLEAR_RET) {
> +        gr[0] = 0UL;
> +        mcp->mc_gpregs.gp_spsr &= ~CPSR_C;
> +    } else {
> +        gr[0] = tswap64(regs->xregs[0]);
> +    }
> +
> +    for (i = 1; i < 30; i++) {
> +        gr[i] = tswap64(regs->xregs[i]);
> +    }
> +
> +    mcp->mc_gpregs.gp_sp = tswap64(regs->xregs[TARGET_REG_SP]);
> +    mcp->mc_gpregs.gp_lr = tswap64(regs->xregs[TARGET_REG_LR]);
> +    mcp->mc_gpregs.gp_elr = tswap64(regs->pc);
> +
> +    /* XXX FP? */

Reasonably simple.  See target_setup_fpsimd_record from linux-user/aarch64/signal.c.


r~

