Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A30DC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskyT-0004nJ-VX; Fri, 05 Apr 2024 10:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskyR-0004n6-Sn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:55:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskyO-0004ZW-OO
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:55:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e2119cffeso2410180a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712328919; x=1712933719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ijlyU4nDrmHoOKdgulA+74bZHVcBmxFPH9lhNWYKBF4=;
 b=cd5zeZXUF42w/UNFyIF5m+OeAba7tQmizr1H6Pf+c4eW2FNMgNUn25SIYAZcHpgKmP
 WkwgL+BuesTqj/xiD4kBzqRO4MchGxvvMae8NTcB7hjInCqeEnztnlJLtc1iEruiogFk
 An2FzTAMcW6CBUUtmw7KyMlZM3S4MFZphk9k9xe4mkI5GOHwzerOyuuZufNxmIembRrZ
 YkPCrTyPb6MyRnql13enVzfm4q6tM/1C2VBeuaYE46dL1jH7AAJuLSx+GHNEbPV4OdRO
 RkkiKtF4EPNWkdW+rw7Lk8uS5Hecd2m35X6ewhTKPbEM0YUHtiHdRXlpCvS/rPrKaiXh
 zlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712328919; x=1712933719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ijlyU4nDrmHoOKdgulA+74bZHVcBmxFPH9lhNWYKBF4=;
 b=gVho4neXiMLJqbzgBuInPzqQ4VtY3KybwWJTBVK6WZPHOPEX5g9t/nzZwion4/GVrU
 HJ4zyiT5lwaS0Zb/3tBRooqjs7i01edYALX0tE5y9JeOWz7jsuqEtvN52P9qPmpRtAkA
 w9KZL7TmHDITvl83XPZNAxYBqxhcocsWxCL70lVqJf420w0MnRRBRCGFcuvOiLwOcIFE
 G+AroKUXhrfydMOCYtBJnkN1SapSNKH2Z9Dp426yRyQMeJWzTvYBsS5SVkgjhAxTG79t
 M3Z69ku+0NpSzYIujp0TPub0FhjZxWb3n9+F93DunPLP2a4ihbcxCio4Hndek+WxDbD9
 fksQ==
X-Gm-Message-State: AOJu0YzQPwdOwWi/MbIPAr9fZSf/stRXVr2C8dRm9uYojjYNvjceRhIC
 rWw0Vw4esY8lt09oSu4V4xQZs4JkI7gLL9WDZa9M5z/ystu3iu9PpduHAcXi2eeBfuZPuScIuWD
 AIQOSwh1LM3qGkHpPYGQFHkau+ttyotMnAgQfCQ==
X-Google-Smtp-Source: AGHT+IFoRdmGROzubFKfjls+rqQMVSDFTAUBpq1ZtS+SyMwYwtE8+828FQ7vo8Wnx7t4cy+rSIog2g2fJmHrwmDV7zU=
X-Received: by 2002:a50:8717:0:b0:566:2f24:b063 with SMTP id
 i23-20020a508717000000b005662f24b063mr1218666edb.23.1712328918891; Fri, 05
 Apr 2024 07:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240405075404.2122-2-zack@buhman.org>
In-Reply-To: <20240405075404.2122-2-zack@buhman.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 15:55:07 +0100
Message-ID: <CAFEAcA93s+=sHFNU0duK8--3GhUg1tZ+n+UhiGeFErJoY5_+jQ@mail.gmail.com>
Subject: Re: [PATCH] sh4: mac.w: implement saturation arithmetic logic
To: Zack Buhman <zack@buhman.org>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 5 Apr 2024 at 08:55, Zack Buhman <zack@buhman.org> wrote:
>
> The saturation arithmetic logic in helper_macw is not correct.
>
> I tested and verified this behavior on a SH7091, the general pattern
> is a code sequence such as:
>
>         sets
>
>         mov.l _mach,r2
>         lds r2,mach
>         mov.l _macl,r2
>         lds r2,macl
>
>         mova _n,r0
>         mov r0,r1
>         mova _m,r0
>         mac.w @r0+,@r1+
>
>  _mach: .long 0xffffffff
>  _macl: .long 0xfffffffe
>  _m:    .word 0x0002
>         .word 0
>  _n:    .word 0x0003
>         .word 0
>
> test 0:
>   (mach should not be modified if an overflow did not occur)
>
>   given, prior to saturation mac.l:
>     mach = 0xffffffff ; macl = 0xfffffffe
>     @r0  = 0x0002     ; @r1  = 0x0003
>
>   expected saturation mac.w result:
>     mach = 0xffffffff (unchanged)
>     macl = 0x00000004
>
>   qemu saturation mac.w result (before this commit):
>     mach = 0x00000001
>     macl = 0x80000000
>
>   In the context of the helper_macw implementation prior to this
>   commit, initially this appears to be a surprising result. This is
>   because (prior to unary negation) the C literal `0x80000000` (due to
>   being outside the range of a `signed int`) is evaluated as an
>   `unsigned int` whereas the literal `1` (due to being inside the
>   range of `signed int`) is evaluated as `signed int`, as in:
>
>     static_assert(1 < -0x80000000 == 1);
>     static_assert(1 < -1 == 0);
>
>   This is because the unary negation of an unsigned int is an
>   unsigned int.

So we could also fix this by getting the C literals right
so that they are correctly the signed 64 bit values that
the author intended, right?

>   In other words, if the `res < -0x80000000` comparison used
>   infinite-precision literals, the saturation mac.w result would have
>   been:
>
>     mach = 0x00000000
>     macl = 0x00000004
>
>   Due to this (forgivable) misunderstanding of C literals, the
>   following behavior also occurs:
>
> test 1:
>   (`2 * 3 + 0` is not an overflow)
>
>   given, prior to saturation mac.l:
>     mach = 0x00000000 ; macl = 0x00000000
>     @r0  = 0x0002     ; @r1  = 0x0003
>
>   expected saturation mac.w result:
>     mach = 0x00000000 (unchanged)
>     macl = 0x00000006
>
>   qemu saturation mac.w result (before this commit):
>     mach = 0x00000001
>     macl = 0x80000000
>
> test 2:
>   (mach should not be accumulated in saturation mode)
>   (16-bit operands are sign-extended)
>
>   given, prior to saturation mac.l:
>     mach = 0x12345678 ; macl = 0x7ffffffe
>     @r0  = 0x0002     ; @r1  = 0xfffd
>
>   expected saturation mac.w result:
>     mach = 0x12345678 (unchanged)
>     macl = 0x7ffffff8
>
>   qemu saturation mac.w result (before this commit):
>     mach = 0x00000001
>     macl = 0x7fffffff
>
> test 3:
>   (macl should have the correct saturation value)
>
>   given, prior to saturation mac.l:
>     mach = 0xabcdef12 ; macl = 0x7ffffffa
>     @r0  = 0x0002     ; @r1  = 0x0003
>
>   expected saturation mac.w result:
>     mach = 0x00000001 (overwritten)
>     macl = 0x7fffffff
>
>   qemu saturation mac.w result (before this commit):
>     mach = 0x00000001
>     macl = 0x80000000
>
> All of the above also matches the description of MAC.W as documented
> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
>
> Signed-off-by: Zack Buhman <zack@buhman.org>
> ---
>  target/sh4/op_helper.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index ee16524083..b3c1e69f53 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -187,20 +187,41 @@ void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>
>  void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>  {
> -    int64_t res;
> +    int16_t value0 = (int16_t)arg0;
> +    int16_t value1 = (int16_t)arg1;
> +    int32_t mul = ((int32_t)value0) * ((int32_t)value1);
>
> -    res = ((uint64_t) env->mach << 32) | env->macl;
> -    res += (int64_t) (int16_t) arg0 *(int64_t) (int16_t) arg1;
> -    env->mach = (res >> 32) & 0xffffffff;
> -    env->macl = res & 0xffffffff;
> +    /* Perform 32-bit saturation arithmetic if the S flag is set */
>      if (env->sr & (1u << SR_S)) {
> -        if (res < -0x80000000) {
> -            env->mach = 1;
> -            env->macl = 0x80000000;
> -        } else if (res > 0x000000007fffffff) {
> +        const int64_t upper_bound =  ((1ul << 31) - 1);
> +        const int64_t lower_bound = -((1ul << 31) - 0);

UL is usually the wrong suffix to use (and more generally,
in QEMU the "long" type is rarely the right type, because
it might be either 32 or 64 bits depending on the host).
Either we know the value fits in 32 bits and we want a 32-bit
type, in which case U is sufficient, or we want a 64-bit type,
in which case we need ULL.

> +
> +        /*
> +         * In saturation arithmetic mode, the accumulator is 32-bit
> +         * with carry. MACH is not considered during the addition
> +         * operation nor the 32-bit saturation logic.
> +         */
> +        int32_t mac = env->macl;
> +        int32_t result;
> +        bool overflow = sadd32_overflow(mac, mul, &result);
> +        if (overflow) {
> +            result = (mac < 0) ? lower_bound : upper_bound;
> +            /* MACH is set to 1 to denote overflow */
> +            env->macl = result;
>              env->mach = 1;
> -            env->macl = 0x7fffffff;
> +        } else {
> +            result = MIN(MAX(result, lower_bound), upper_bound);

Maybe I'm confused, but result is an int32_t, so when can it
be lower than lower_bound or higher than upper_bound ?

> +            /* If there was no overflow, MACH is unchanged */
> +            env->macl = result;
>          }
> +    } else {
> +        /* In non-saturation arithmetic mode, the accumulator is 64-bit */
> +        int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
> +
> +        /* The carry bit of the 64-bit addition is discarded */
> +        int64_t result = mac + (int64_t)mul;
> +        env->macl = result;
> +        env->mach = result >> 32;
>      }
>  }
>

thanks
-- PMM

