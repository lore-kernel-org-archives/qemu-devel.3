Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF231C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIOA-0001DI-U0; Sat, 02 Aug 2025 15:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiINd-0000ok-NP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 15:58:58 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiINb-0008A7-Fg
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 15:58:57 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71b49bbb95cso18744257b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754164733; x=1754769533; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lI5GgggGllKsuw+DE8TThSvm0V8Y/SvDHkXe+2MDftM=;
 b=dS2V1K1lc/8Tw72O5HsD8sgDDA+GFQQ7vWWuxBHStlz3/0nU2002Se6JXO/rizgEm1
 LpDBDh7qdVNJB249R9CStk6PopiTlAsSMD0gx0VjhVJwEqTAJDI5CCSQUi4YBOIWdkEt
 WH95d4PewQvhZeurJI+XLyUySU31QTbhPsPcGSbp9sQnTAQJ4k6JHxd0IIxkxTg2QtUW
 wX3WBwBxV4nGPdB7fev3ULM7ukNwdy+YKOBRWFmTNDJz+qvHS/ORffeXNYHN98old6p1
 f9Kf4XUjqsyOUDN/8tMBqSIVc3wCpB+m/zsKrNpCF2Qh+wp8f42/9uaao1K3iCyJAxg7
 LdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754164733; x=1754769533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lI5GgggGllKsuw+DE8TThSvm0V8Y/SvDHkXe+2MDftM=;
 b=LF5Q6k4inym8EQQ0wBBKM5zby6BgoTIpEHXMCOKc5cp6Dw6v7yDV+GYSw0iBgMvzCG
 JV4msnkokLVzeE9fxlp50y1nx+mut9eQU4b3KpIAnOenB8U7mT7D1L65U313aZIcLODc
 ueClcALytseK1eMhiQht5cswi4np1cUfhN79XV1wA0p1UKtqJXUnaEAr/T9VzT9+xEdK
 VNfs6YW/ywdwL/TpMQ2lNeU+KrjcDmEv8UISmvE0p7lklGzUWIMwclg7oTlWk2QHdi7A
 u9/AIeqij47DMmSHgfZ+isOZ8cp0+Uj7vy3QwfhydRISc8WVp1TFlksa77VVJuECZZK8
 YBpg==
X-Gm-Message-State: AOJu0Yw/cizs0r5cCaAp1iBoKeTgyzdFmvx5EdVtuESvPcCxDjFgdZ2Z
 fvIkC3k1qwyTJ/4X2zuzVDCT8TwNAyecEWY7skqaw3CWsnTh/UlrSK++ABdq/tIjCdHfaHdherx
 2CEh17VO+TYx7rO8Ha7rsECjXg1GDG0VZtP9ReB1TTA==
X-Gm-Gg: ASbGnct3uRkPW0J/MNHda64/gNusoAwEIOxY4GUK54pamLmueyimCYQetZRwAyYOnMO
 0EXJXfMFcoXIg3FTwF6+o/syNVRJBoevkgUVqe6ey80KjJLSbcs9eNEwz55Pm90+JKLen4ZJhZn
 HXE23hpFvtw976utqnwv3aX5WV0IX0ErO0WDAPYpA6H53TfGf7/T/NtiGb9ELEOaItP3BDNL+/j
 h4zQw0w
X-Google-Smtp-Source: AGHT+IEYP7FeuY7tUb0Ppwh0HIE9EYfAYBTDh3qhSw3+sykWjWqV12AI651KEy5HIqjcvOadZvygj4B6buXuSvu0cgY=
X-Received: by 2002:a05:690c:d94:b0:719:c5dc:adc5 with SMTP id
 00721157ae682-71b7ef24014mr58999127b3.9.1754164733254; Sat, 02 Aug 2025
 12:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
 <20250801232609.2744557-5-pierrick.bouvier@linaro.org>
In-Reply-To: <20250801232609.2744557-5-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 20:58:41 +0100
X-Gm-Features: Ac12FXwWn2vPDM5EZNnBaI19qRoUBhHurp2xuBD7-QTW_t3Dsf_fVKwfAM-Gjtw
Message-ID: <CAFEAcA93+MwVESZCqayPr2HVYUc+3qMFy4vDdKaDNe3sN5o3og@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] semihosting/arm-compat-semi: remove
 common_semi_sys_exit_extended
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 richard.henderson@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org, 
 philmd@linaro.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 2 Aug 2025 at 00:26, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> This allows to get rid of sizeof(target_ulong) for riscv, without
> changing the semantic.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/arm/common-semi-target.h   | 5 -----
>  target/riscv/common-semi-target.h | 5 -----
>  semihosting/arm-compat-semi.c     | 4 +++-
>  3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
> index da51f2d7f54..7ebd2136d93 100644
> --- a/target/arm/common-semi-target.h
> +++ b/target/arm/common-semi-target.h
> @@ -34,11 +34,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
>      }
>  }
>
> -static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
> -{
> -    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
> -}
> -
>  static inline bool is_64bit_semihosting(CPUArchState *env)
>  {
>      return is_a64(env);
> diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
> index 7c8a59e0cc3..63bbcd2d5fa 100644
> --- a/target/riscv/common-semi-target.h
> +++ b/target/riscv/common-semi-target.h
> @@ -25,11 +25,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
>      env->gpr[xA0] = ret;
>  }
>
> -static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
> -{
> -    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
> -}
> -
>  static inline bool is_64bit_semihosting(CPUArchState *env)
>  {
>      return riscv_cpu_mxl(env) != MXL_RV32;
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 3f653c6e7a9..ef57d7205c8 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -755,7 +755,9 @@ void do_common_semihosting(CPUState *cs)
>      {
>          uint32_t ret;
>
> -        if (common_semi_sys_exit_extended(cs, nr)) {
> +        bool extended = (nr == TARGET_SYS_EXIT_EXTENDED ||
> +                         is_64bit_semihosting(cpu_env(cs)));

This doesn't look right. Whether a target supports the sensible
(extended) semantics for SYS_EXIT is a different question from
whether it's 32 bit or not. For Arm, it happens that the point
where we defined the newer semantics coincided with the A64
architecture. For riscv I don't know -- if they made the 32-bit
riscv not have SYS_EXIT_EXTENDED that was an unfortunate choice
but they're probably stuck with it now. For any future architecture
that decides to adopt Arm-compatible semihosting the right
choice will be to provide the extended semantics regardless of
bit width.

This is why there's a common_semi_sys_exit_extended() function
that each target architecture needs to implement.

thanks
-- PMM

