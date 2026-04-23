Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220D4FDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2V1-00064p-7V; Thu, 23 Apr 2026 18:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Uz-00064L-MG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:26:17 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Uy-0001Q2-3b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:26:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so4814022a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983174; x=1777587974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n/iigfwgrfWLAXFD3CTn0dBiOigG9aIfPf4zFLqqEFY=;
 b=jdhyfM3E8TqZpNlbsc6nbSzZhHwCNMStO48YWM8pctTfx4vpkMwW1EpFuJeIscuZ7d
 +6FwZs94b7ueFcXxD/Ahpq/kbak1Kcdp9F0zAslKn0huKJbfClP6EcNw8dKeP+7dPZnu
 RIw3Au3nA7si2ckihO0H+UEZv6hQJLs3UI45WVsNVDg3MYpcCsQKT4IHajZL6t7P4bA5
 SPWGeTdiTznefwSMujR68BrLNt4ckTgtcpTvcx/OuPTlUmCfu3LXgYNovy6awuZ6R255
 yMrZFIJzNUQJSpVFBg1unZTt7vfw01TBCTn98Wguve1HpgecwgbBII+eOVC3YjljVdnD
 v8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983174; x=1777587974;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n/iigfwgrfWLAXFD3CTn0dBiOigG9aIfPf4zFLqqEFY=;
 b=kpCKZF91Sijr4J7YAqSkYPfbatAL4dz733kWC23UlicVh/oO21Gxk5mjPe+4sp5w6n
 RJSo24JhzZ8SbOiJyorV/OeQXTs/3EOXzuV6EZ9UaF1yeS9ucCtbElsxIX2LfZeeJYO8
 Puyu4JWRAyxOwsnZTHfHakzxQMXDJWhFtfMPjyhkhV6ZGxvPmI8y9f8ptLP5ITPU4Uo3
 CV8g4mPVkOnPW+SlqxAWyu+hXYNMCbt6HgaV/mbB0NL7kht9OPCRVCb4qjb5XQs72+EE
 KojUnn7Yv0O4Ont7Oft3MoMRrP30UczCfPi730GSKmdGM6vgZe3tj5u6EIS2+JNWLLWL
 1JaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tBrxn7ZJ6yYiVIJG49bizkCqHJHMXwUv04CDpMcC3idqBSz7fHtFENmP+TKlhiVlV6i7Ayc000hhF@nongnu.org
X-Gm-Message-State: AOJu0YzduLskEQKgNGvc7UnEPvBhIZpGe64HRZQvYY/eVRM6GtN6ERCF
 9YiHySO0TADZm4uXoygk+P6+bvYlHKgZIINWVtLbTyTCpa5f0KJ/cnQPAlwEAXj7hPw=
X-Gm-Gg: AeBDietuZgcNQMY0IbPdzFsxRRonur9j1pGEhP6MlzJd7s50ttqYH7UUSa2fyQX3+r6
 uPCv72iOyTggyVnYVzrnBhYHuPtYHmmGswBL+EPrG/hiYoGEh+ohk6s0XDd6+KCxVxvZc4qNm+p
 n3e3+zAftpA0voxysMMOiW7BWoiCHb0mLNEwH7U1N+k10mlMLsWy9p0FEPvI39mIi//ujoixTDy
 mBOBeYUOUPLwhcGxGzVDyoeilP1BXyAeaJY4yLCp71dzK8cJGIAKG2zE5J8ZRl6QVnXalMZ0due
 wk2REKr+F8Iy0rmlBfqQb3fJj2+EwqhbWIw9sEmPwNXyDnjgjonDiqa0fbewuAuu1N4VZ+TIZfF
 8cVlyk7Qmcpn68zzBmE6p6fdCDeO7sJnL16vSLzwomgE7r0nhTcqlwOa1283CjNv3NgBHY94VVV
 WjqKaa7ecXP6GAXwU/HnCw8U5cjHjlY2ZxX7ft2cTeRhsR6MCjmQ==
X-Received: by 2002:a17:90b:1fc4:b0:35b:e4f8:7cb0 with SMTP id
 98e67ed59e1d1-36140491cfcmr31031374a91.21.1776983174092; 
 Thu, 23 Apr 2026 15:26:14 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fb42e25sm10353803a91.3.2026.04.23.15.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:26:13 -0700 (PDT)
Message-ID: <03119ad8-de87-4bb4-8f73-062de85e8d6d@linaro.org>
Date: Fri, 24 Apr 2026 08:26:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] target: Simplify env_archcpu(cpu_env(cpu))
 expression
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> env_archcpu(cpu_env(CPUState)) expands to ArchCPU,
> available via the ARCH_CPU() macro. Use the latter
> to avoid using &env.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c       | 2 +-
>   target/hexagon/translate.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd9..2fb768048b8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2303,7 +2303,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>   
>   static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>   {
> -    ARMCPU *arm_cpu = env_archcpu(cpu_env(cpu));
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>       int ret = 0;

ARM_CPU has an object_dynamic_cast_assert() inside; the env* converters do not.
You should be making a considered choice about this change, not just "simpler".


r~

>   
>       switch (exit->reason) {
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 633401451d8..825b236dd24 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -978,7 +978,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>                                             CPUState *cs)
>   {
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
> -    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
> +    HexagonCPU *hex_cpu = HEXAGON_CPU(cs);
>       uint32_t hex_flags = dcbase->tb->flags;
>   
>       ctx->mem_idx = MMU_USER_IDX;


