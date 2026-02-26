Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E32FC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYcm-0004LA-Kq; Thu, 26 Feb 2026 05:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYck-0004Jo-N1
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:29:38 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYcj-0005Ys-4c
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:29:38 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ae222d978so470472d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772101776; cv=none;
 d=google.com; s=arc-20240605;
 b=aT31XU7SvrVfwA8hIouMafKl/GeB77AoNB3CCIpLlKNH7H68fpmmY0x0l6f0pUg78j
 BNO8bmeF4jlwwDIxpcNoAn6rZKRKJ0SKQtxyD66xHIn4dhJ099AoApizgcPshTNY4mBJ
 GnuRahYsCkiacUnbskLk/cxjobuy1qzZUemaZfkwJh67XHxsR5ritfa4RwgSqmQvcfC1
 BUfU7d6thVI9fe5lHAvaJtwsziM3YT83u/Mf1uTgP2bXo9Eimer/uW5Jme/eFAd5nbdW
 gag8RxeFOYtIjONOfHm4C6ugWM6ycyc4nPvK8SqonrFLcMV41BWakcvOp6i2aeDu9gCK
 cIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ah9ojG0q3uo3b9b+2P9a9B8y88QGjOnwpMnd7A74Iz8=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=JGmV9qd8E2gmLRjCmLCbw/8QxCy66Wi+461vdqraSI2JVqCHyt6fHNu6wqKOLjvl1I
 boptvqFRP70q4G9anTKuztMGZdkE/SC4/Hj/bUocECV2CwcMD6oe0oBj69BrMeFWGsVB
 byQxXEAswLooQGvr2QeGI2Yv6vVq62WGudF3qnhQV/6YuWU/xEr1D+8uh/GwqSLdyiJc
 4vkajZecgxevw8ZmIRFv+z7KbGSkNwmQkn8FRxmGMmgQPo84SZZvu2z+A7rPMRN/CiwR
 qf+4+025oVtiBEexKUW8iDYCgEQ75G9+AuLjHAVJ137CRlUkfjeFWRcYB902430RvZLQ
 poqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772101776; x=1772706576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah9ojG0q3uo3b9b+2P9a9B8y88QGjOnwpMnd7A74Iz8=;
 b=pjxBn1N8LzKZ378tiMKBYr7cxjN6iRJjz7pk1W2Nam6adGYnmtxVlTARk/1QhetaNv
 ASO6SlhYAN5IfPgh8jBEyW4vhtoTbLrBoBqtd1KBlkxf4qd4lw3a25IFVW52etrF5O0X
 tlCarRVWmfFnxcRfmMc4f2SQmxTpEC46yDQNHDILK8AqyE5ndur/oQAKBUbMJ6MxUGOG
 EdOWXKKS2qwqrkrrQ070KtNQcDNNc9lcUShfSc4zh/J45DzTpaww8tOvQQKLMLNbYUJv
 E3T8m+XT9uS/JeFAczacS7EM7jKBcvAd+2YlDNwBG4jEzyKNLdXvFoWBciiVczk+YkbD
 +nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772101776; x=1772706576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ah9ojG0q3uo3b9b+2P9a9B8y88QGjOnwpMnd7A74Iz8=;
 b=mEEkZQIKCaWEVvDCy+qH9/O/cbnqjplEVlMQZxMTNfHk+VAXohvyf9c2mlEiCGi4v9
 ET5pboYTzzAQ5zv77u+1ZB/ynD9CivFeK5cztV/9BLGRf6Fsdinkdy4JK0QsgHWnIw27
 4e3hzS8TlHy8vzBwFNmXYZ3EDKbpapdurp9AaDKg1n7yoRUEq4ZgvthsI9V0MAXBg/kg
 9f4tp2zA64TdPpqsNxofcL/RXjEWZvvJZ+KVBXE1OBLnFEoMfU/DULFzAWzcjle0UWlM
 aXRwazzW7cbpu3EaO/P/3nKfzmkMEldXEPL1gAvX1L1lZ0qdBGuZJtxHl1EWMLDVEShu
 zG0A==
X-Gm-Message-State: AOJu0Yzpf3SoFpKNLdxyaZZFKFr05DL72eLOto77OlmNWTDKHple4d2v
 /bEAsiuWKegX0KIKl52oO7HdnFPy4Z/L77ve+1GS/HiYTpUVyV/B68V2WW8x1u1+Tq7KT/MY8JF
 D6pbY3FIjHDTx6YoiWGsdfwopwirIacmIHeiHNP4BvQ==
X-Gm-Gg: ATEYQzy4hMeSEj0mDE9QIcy1HHcjIVq/FITa+jVUKyH+yz7k1VnzXztwmsJgu7ly6nv
 U3ssKKTtnbzSwkdML8Lb+9Vl2sC29MIQNTu70DjTm6a9z3BXcAjDNPtybHuppAmDry3+E+Cu7vS
 uhHofvquc0FlHjR5VWc2Hk0qi/RZVEu1FJ1YSgX33cTfTFnUP79E2xz7X8smW0HDCrqA1TtXYBu
 wgKpwpxt7pGBdU7EjMvS0LYiUM0guYG7DvpICRKeCoftuZJVXfZerW5bao7+Z2aHsinLUX2LEZO
 Pj6kymzgqK1VpQ99gsWknJlnBnqKP9hoS2PEy4PL1N4CSXLzxAFlaq2ve1Ao3VQKJwY=
X-Received: by 2002:a53:ac88:0:b0:64c:b242:496e with SMTP id
 956f58d0204a3-64cb2425731mr2910841d50.17.1772101775643; Thu, 26 Feb 2026
 02:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-4-alex.bennee@linaro.org>
In-Reply-To: <20260224154347.344219-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 10:29:24 +0000
X-Gm-Features: AaiRm52sjpMfL2DsXcKotaMr15GNp12jlu3XaMBA5wXiQeZ0_juQvmmrhoogx40
Message-ID: <CAFEAcA8km4H10ZseUd=D6KWTpHQptUaL0D3dSrg3-LGWY1bcgg@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/arm: pass rd directly to wfit helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> If we generate an exception for WFIT we could also fill out the rv/rn
> fields of the ISS. To facilitate this pass the register number
> directly and read the timeout value in the helper itself.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/tcg/helper-defs.h   | 2 +-
>  target/arm/tcg/op_helper.c     | 4 +++-
>  target/arm/tcg/translate-a64.c | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
> index 5a10a9fba3b..a9a062cf777 100644
> --- a/target/arm/tcg/helper-defs.h
> +++ b/target/arm/tcg/helper-defs.h
> @@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, vad=
dr)
>  DEF_HELPER_1(setend, void, env)
>  DEF_HELPER_2(wfi, void, env, i32)
>  DEF_HELPER_1(wfe, void, env)
> -DEF_HELPER_2(wfit, void, env, i64)
> +DEF_HELPER_FLAGS_2(wfit, TCG_CALL_NO_WG, void, env, i32)

Why the change to NO_WG ? The code change doesn't remove any
writes to globals...

>  DEF_HELPER_1(yield, void, env)
>  DEF_HELPER_1(pre_hvc, void, env)
>  DEF_HELPER_2(pre_smc, void, env, i32)
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index aa14f15eb62..28a1c7243ad 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -409,7 +409,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
>  #endif
>  }
>
> -void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
> +void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>  {
>  #ifdef CONFIG_USER_ONLY
>      /*
> @@ -428,6 +428,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>      int target_el =3D check_wfx_trap(env, false, &excp);
>      /* The WFIT should time out when CNTVCT_EL0 >=3D the specified value=
. */
>      uint64_t cntval =3D gt_get_countervalue(env);
> +    uint64_t timeout =3D env->xregs[rd];
> +
>      /*
>       * We want the value that we would get if we read CNTVCT_EL0 from
>       * the current exception level, so the direct_access offset, not
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 5d261a5e32b..073454b9195 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2064,7 +2064,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *a=
)
>      }
>
>      gen_a64_update_pc(s, 4);
> -    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
> +    gen_helper_wfit(tcg_env, tcg_constant_i32(a->rd));
>      /* Go back to the main loop to check for interrupts */
>      s->base.is_jmp =3D DISAS_EXIT;
>      return true;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

You might squash this in to patch 4 if you like.

thanks
-- PMM

