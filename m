Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D8FE9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqaz-00026F-23; Tue, 24 Feb 2026 06:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqax-00025W-84
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:28:51 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqav-0004wL-7o
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:28:51 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so616517d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932528; cv=none;
 d=google.com; s=arc-20240605;
 b=HnaelI6lOo4x3eiJ5A09Cvu2BM0+ySGuHq1vimKtBT50j85ka2BnI50tvCVmHjwJ22
 S1SI780c98AlIkT0MIuW2O9+oQU7afMMrLH5PcjbmXP/nbQIm+LLal3gJe2VSAhtJZQf
 dFi8Gs33aiT5jFSZRagPWh6G+QgV1zH65hDIZb8g65AZvpisrFctw+bRxQc8HyJQ+OZt
 SEWZRbBiAnR4dcvzz+QgkqfX0ErbOQ+B0/ZW5ML93MyRC04112b3/hXtKaYk5c+cMsYl
 gikwbARNbmHKC2ZuFm3ia/cPfXFfdwxvbSdwUzZAtUv/unAakxxuw0K0ph2WQPLg4IeP
 nmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WIVox6HUyXE5wDRrl16/Oe1LcsApPYvicGTXvqTgRwc=;
 fh=hT/1TK9TWjEBRNRGuaL6qZN1E9+YZtv5CNgw1KQF0e0=;
 b=cD1sYa7IBft3H6OasUktyUfAz5d0dHH1W/sdVMVE7j/Fumi2zaUlm+Nt8js3jgktoU
 SNKH1FbN6LpDB+DJTMMvMZ2xcFm6/knT2EyY8UQODxeBZMn0l7Qb2e2DebUgN7ABBk6S
 42Cm4WQNlxEL6aF0C+esoGMW/hL+cTVwn/66xenve8eQu9HBv0LxcS5MLk1iLDVoXftR
 fWsocBBJMcXLeZGgC0fRzCeT5X4KWUfHzVS/+I/Tu9GcrC258Xzkuzz2C6wJ7Xod73wI
 6JKNhaBbYHaYi9Z6uwjnvHrXd1dslkXUwNZYyA00xafjWM4YBxDuKz94czehlBTKiSXk
 ou0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932528; x=1772537328; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WIVox6HUyXE5wDRrl16/Oe1LcsApPYvicGTXvqTgRwc=;
 b=NXuOBdiMkgXiMX241+YYYVPgHp6HSS5cXR64Z8v0TNZrBGAYV722FT+NIEGE3qjahO
 KsImAca8eah0gnMGL4PT1JuII4x3XzoTVHo79aCEvJ3BLAQy9Q2hRwuP2t1XPwLNLjvb
 hCu+iAu/3QVs9ghKyirPuVwq5hdUwv2d/i0nZ44qFgaCpdYfwuAoY5JWAiE1glTsfSMw
 rZCbc3RAbmbba3hy8Yvc5/uhTYKbH1JgMYsDf+kUUC0nTje/y3185Osz/mbQoVV6eutL
 pbiyZ1Fpb61M8ULgr3kiMbMGJjrUtD5MjiBad3RpAkcyGSvsf9N6ZSbwiq/lMk+rSnZo
 a0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932528; x=1772537328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIVox6HUyXE5wDRrl16/Oe1LcsApPYvicGTXvqTgRwc=;
 b=Xz8SMJL3DHkRm4QAHQdjYUAmhjmjuS04B3K3aAGtZxEylphE6oDflc+7Xz8n5/52JQ
 YNIObptFIaDAou5mYHeFtqXqTvxgzk+x9UAlKHUaaTDE5BMFGYCj6afq4c4Xk8DX4u9Y
 Pp+8Q8XyEvgg/7/Yt5wcHnr9BLp20ygX53ooDe74n6o/+lO0yWx2vFu+MG/zfmE62/jT
 W/AYtIpa49DPNliiIcd4fitZRYkadr5HW16TkeeePwsJXZBZgWDtJ1uFICCyrbOM4sCf
 TCssJWJX9QW7pAIGuTZc+00qoUX5WD1/RENx6RubhuWhBfjTt0po1THkaqJGwo2AZWsP
 bb+g==
X-Gm-Message-State: AOJu0YwyvepAyljsdcm7WH/yRkvJC9iwQQy7TN6dmj+JlMIaEquj7oRd
 8GOW/Rn9Sqc9HpXjVKGyScFnnsKTAxk1ByxhxfU1YSkalfklemiOglHY1y/LNywoc5cGibj0g3U
 bz7PzvVirAlKvTIzE9W6pIDRPCY5UjgTVekwHeIVRtYzEu2JK8+dy
X-Gm-Gg: ATEYQzyDbYumF6CHO9VZJiKA5e4DMmMDYGNbBF1bervXqo6Ed4WBUF6o+U6tWOC8Igp
 BlSXR5BkO+N0Gv5wqLcocIB66eyxaiRNMV+92ZeCoV2qUYEWBPTzxk5jX1QdeCdGmtqz6o7cBYp
 YzJu9bwlAWHoXSA0SrYNmt2c7hqZQ4MgevaSiFI3/0xpKmz4K0dzdwUX/B+MexAWnRhHAD5SsX3
 8ooFeaXe79mUZ/iYhWhkkrasGSYMs8M/lpchlPQ4dj6EHDcFNqRmtOe3YVgsenEPgb+QEv6HXm2
 sXM+Fj18EP5fGHdaA0M8I5VcS/DJcWmTNhIH2bfhn7eej0KkqRpKlwn09o7pd1Rbad4=
X-Received: by 2002:a53:d008:0:b0:649:405b:20de with SMTP id
 956f58d0204a3-64c790a6416mr9503494d50.86.1771932527634; Tue, 24 Feb 2026
 03:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20260212150753.1749448-1-peter.maydell@linaro.org>
In-Reply-To: <20260212150753.1749448-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:28:35 +0000
X-Gm-Features: AaiRm53ulo2Xs_6mMGfSuGw-5l3uwloLcqKPxX2Z9UPQCH1yAkiIaqBUHZqjWos
Message-ID: <CAFEAcA9B6-egOf9MuYqimWNSjkUEVGSOm8NCM4ObOLsnjRmBfw@mail.gmail.com>
Subject: Re: [PATCH] target/ppc/translate: Fix TCG debug assert translating
 CLRBWIBC
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

Thanks for the code review -- is anybody going to take this via a
PPC pull request? If not, I can take it via target-arm.next as a
one-off -- let me know if you'd prefer that.

thanks
-- PMM

On Thu, 12 Feb 2026 at 15:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The test case in the ppe42 functional test triggers a TCG debug
> assertion, which causes the test to fail in an --enable-debug
> build or when the sanitizers are enabled:
>
> #6  0x00007ffff4a3b517 in __assert_fail
>     (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
> #7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
> #8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
> #9  0x0000555555d02abe in setjmp_gen_code
>     (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
>     at ../../accel/tcg/translate-all.c:257
> #10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
> #11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
> #12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
> #13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
> #14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
> #15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
> #16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
> #17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
> #18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
>
> This can be reproduced "by hand":
>
>  ./build/clang/qemu-system-ppc -display none -vga none \
>     -machine ppe42_machine -serial stdio \
>     -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
>     -device loader,addr=0xfff80040,cpu-num=0
>
> (assuming you have the image file from the functional test
> in your local cache).
>
> This happens for this input:
>
> IN:
> 0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04
>
> which generates (among other things):
>
>  not_i32 $0x80000,$0x80000
>
> which the TCG optimization pass turns into:
>
>  mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff
>
> and where we then assert because we tried to write to a constant.
>
> This happens for the CLRBWIBC instruction which ends up in
> do_mask_branch() with rb_is_gpr false and invert true.  In this case
> we will generate code that sets mask to a tcg_constant_tl() but then
> uses it as the LHS in tcg_gen_not_tl().
>
> Fix the assertion by doing the invert in the translate time C code
> for the "mask is constant" case.
>
> Cc: qemu-stable@nongnu.org
> Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/ppc/translate/ppe-impl.c.inc | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
> index 0a0590344e..1c27facb89 100644
> --- a/target/ppc/translate/ppe-impl.c.inc
> +++ b/target/ppc/translate/ppe-impl.c.inc
> @@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
>          shift = tcg_temp_new();
>          tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
>          tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> +        if (invert) {
> +            tcg_gen_not_tl(mask, mask);
> +        }
>      } else {
> -        mask = tcg_constant_tl(PPC_BIT32(a->rb));
> -    }
> -    if (invert) {
> -        tcg_gen_not_tl(mask, mask);
> +        target_ulong mask_const = PPC_BIT32(a->rb);
> +        if (invert) {
> +            mask_const = ~mask_const;
> +        }
> +        mask = tcg_constant_tl(mask_const);
>      }
>
>      /* apply mask to ra */
> --
> 2.43.0
>

