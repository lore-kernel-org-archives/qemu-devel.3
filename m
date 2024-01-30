Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63649C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjPZ-0001Q9-55; Tue, 30 Jan 2024 03:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjPT-0001Mj-Pe
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:23:59 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjPS-0002vz-4X
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:23:59 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55c33773c0aso3707550a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603036; x=1707207836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Bj2PIdaGNrPAoFX7CRZa9+Rakq3s8HSS3Cz0DN4H30=;
 b=LEoivonlhO80biSGlEToAJtdrWBMgogDmH445NhLDZZcNE2VZFSlSCd19n3jX8xraT
 Pq3Ea3/qjScj4yZVQAytCMk/nSyq2nyiX+5LUywGDjJNrBsCsKmK6xE59Kx0vBOCLrHe
 H7Ja3HcLalSCsxoTam2NDQUJONR6a53qmn3ZgkeBcPoyIgDT7H/1SaVYek8h5Wkv8aTb
 4MV4+IZl5ySDiQelt0sX2MQ00Ik3QMYjWeGLihgSbpc8SiEsZEoS/A2fICdkGbSCXQty
 urkO61A3L3TzTt+wWcDnlsjwwuARrbcFmjYivLhlM9H8G9QdR/uOtzVC13I+vhCxpoHd
 mDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603036; x=1707207836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Bj2PIdaGNrPAoFX7CRZa9+Rakq3s8HSS3Cz0DN4H30=;
 b=bxyH6pnJxdTGLoPcmxWSN5XtgH8KHEj4oYjuCy+KVkp5o2sdIcD3qbSwE2+G6ZUbsP
 sNYzl/X19gDDZuvKcMmabk3YxO9O98cZuZsWgWDXrym8ckp091jI32iIts7H8jpmvzsy
 vbG1q5kT5ESdoVsfjYsqXSW+QbEsHAemjl7MjZ3mKnrASwdWUSpu5X2OvQnTe4MNj0mu
 QB2h48vnndImT5fJmruN5q/6OsyfIhsSHwbM7ZML3MG1Yrp7vlU0By/Lwsr0eApNzGNj
 MRBFpfB0msObLNutKRqnqQf3wj2SMrouYkn3wjmloIzl0S3KiElXyKACo0whEAN6ZDll
 zgJw==
X-Gm-Message-State: AOJu0Yxw0ON07bNzTm98neAzbmF4UhRPltivKfAfvt4YshA5wSDRxrn7
 IYeh7cKItmYVT1Lr8/Ws/c1iRIDwZbKffSb3mypwum+pS8AJUlXjhYJtJAVskOs=
X-Google-Smtp-Source: AGHT+IExDl20dK8itOf6K9uhu62yWprftIeZ8VXSDLGgTczqKQWwOBZr5ipBH0p8dPEES2M+cuw/BA==
X-Received: by 2002:a05:6402:50ce:b0:55f:4602:bf7d with SMTP id
 h14-20020a05640250ce00b0055f4602bf7dmr465161edb.26.1706603036571; 
 Tue, 30 Jan 2024 00:23:56 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a05640243ce00b0055edbe94b34sm2821012edc.54.2024.01.30.00.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:23:56 -0800 (PST)
Message-ID: <7bf17208-14ed-48c2-8995-ea4c580f73e2@linaro.org>
Date: Tue, 30 Jan 2024 09:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] include/exec: Implement cpu_mmu_index generically
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129233043.34558-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 30/1/24 00:30, Richard Henderson wrote:
> For user-only mode, use MMU_USER_IDX.
> For system mode, use CPUClass.mmu_index.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h    |  4 ++++
>   include/exec/cpu-common.h | 19 +++++++++++++++++++
>   target/alpha/cpu.h        |  5 -----
>   target/arm/cpu.h          | 13 -------------
>   target/avr/cpu.h          |  5 -----
>   target/cris/cpu.h         |  4 ----
>   target/hexagon/cpu.h      |  9 ---------
>   target/hppa/cpu.h         | 10 ----------
>   target/i386/cpu.h         |  6 ------
>   target/loongarch/cpu.h    | 10 ----------
>   target/m68k/cpu.h         |  4 ----
>   target/microblaze/cpu.h   |  6 ------
>   target/mips/cpu.h         |  5 -----
>   target/nios2/cpu.h        |  6 ------
>   target/openrisc/cpu.h     |  6 ------
>   target/ppc/cpu.h          |  5 -----
>   target/riscv/cpu.h        |  2 --
>   target/rx/cpu.h           |  5 -----
>   target/s390x/cpu.h        |  2 --
>   target/sh4/cpu.h          |  6 ------
>   target/sparc/cpu.h        |  6 ------
>   target/tricore/cpu.h      |  5 -----
>   target/xtensa/cpu.h       |  5 -----
>   target/hppa/cpu.c         |  2 +-
>   target/i386/cpu.c         |  2 +-
>   target/loongarch/cpu.c    |  2 +-
>   target/microblaze/cpu.c   |  2 +-
>   target/nios2/cpu.c        |  2 +-
>   target/openrisc/cpu.c     |  2 +-
>   target/sh4/cpu.c          |  2 +-
>   target/sparc/cpu.c        |  2 +-
>   31 files changed, 31 insertions(+), 133 deletions(-)


> +#ifndef CONFIG_USER_ONLY
> +/**
> + * cpu_mmu_index:
> + * @env: The cpu environment
> + * @ifetch: True for code access, false for data access.
> + *
> + * Return the core mmu index for the current translation regime.
> + * This function is used by generic TCG code paths.
> + *
> + * The user-only version of this function is inline in cpu-all.h,
> + * where it always returns MMU_USER_IDX.
> + */
> +static inline int cpu_mmu_index(CPUArchState *env, bool ifetch)
> +{
> +    CPUState *cs = env_cpu(env);
> +    return cs->cc->mmu_index(cs, ifetch);

Can we add here:

       [tcg_debug_]assert(index < NB_MMU_MODES);

> +}
> +#endif /* !CONFIG_USER_ONLY */


