Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58601FC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYgi-0005hc-4J; Thu, 26 Feb 2026 05:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvYge-0005h2-Cc
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:33:40 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvYgb-00067s-MU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:33:39 -0500
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so1355751a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772102016; x=1772706816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a50vn565+HHWHNtpAnMWwLQRnfJLyrNr/JVZBxH2Ee8=;
 b=wpjngdsnI7xmHLjJjwvKij9nIp9/phQJVYkcJ+kTJTAKpv2qPEhr2qsTIkpBBI/eJd
 Mb1P5rQeRe9491JJfx8HIUHxd7a31+/RhpZt8L2j96kOGPT3Y03KjpMpKziXathEdPmC
 JQEHaP2idmY5AF0+HJMrceQ3M+i9IkF2B2ZXqBzr6GRI7cR2h4efLGKGux1UOumelvYD
 aHkl/w2+RbA7KCpRLdnnc/gfw9ITkljo2iQ+eUiTsOAWfdjOCvYjNzWLy7YXwNCk8HMX
 s4x4WpxE1xM+hh4hT/iAApJWKGe7Z9x6UsWQLJvzxeATTtQspJv+iQ8ka5u3zDW/wF/m
 QqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772102016; x=1772706816;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a50vn565+HHWHNtpAnMWwLQRnfJLyrNr/JVZBxH2Ee8=;
 b=HugTDUbi7m7T8N5zdpeoJtk0m6DIU+PFjLbJSLDrmf6Bvcd248kmj4UUfrswWci8lX
 H1BGoR1wxiUo1hKOkp3G6q5SXSS2Z0TCRuZm1szOsj/i008NGbdRHZKtPzJLjT+oW3q2
 8zuzxJpfBNz4w9LITkg6O32Fdr419hYap5W+sa7MDp0Qpn7rti3h4iqT24YM49Q5jogm
 0ZHmBFq9U7GX/F5d+fshwmA/e38dC46E8GWxIT1xTm7O91oFfoQgdXyGiOrfcYjZMC17
 XqHolzEc4w6YzUMsEu5NQ50R49cQm/3rlG2za/3wY6BEcyoqd9QED/OW58dfGtozQhja
 ylEg==
X-Gm-Message-State: AOJu0YyfMGQ+Ur10oxdodlDc95wRFqT2d6sSfdMmbXHFzZdgbokBJFO4
 BcmLIYU52TiXoJYd7kfHIQGVK0g7I/o1k2Af2Yfrb9VTXGv/xJ1/w5zm5xdXk4HA6Jk=
X-Gm-Gg: ATEYQzwPtM3KkZ4QtSgFe580BPVeKvG6JKTQ7s4nl1xxrWL+52GwP8LJA+1KYlWSpPS
 yPpGOlEgOEdcDjwRGoOEhLTIbJEqOsWGoKoNhyV/LkvmXYeEydcbppgRLV74X/+Ec82A1rB9RbE
 x+rGeffJ1KOXMcQ+ICcrDRsQFTdkZJUunyCTdUi5Sp1o4BsIijnzCZ+1lftU9RJdAWkOsm8+Aho
 t9w3l6rbgVaJvQD+bBMhM/qz2DJ9XMEkallhVTOSPOyuuj6ewK8tCRg3CpteOCX7rkFqakZ6xg8
 pYc3AM6LbDrVsV/oho9p/tqj76CJhCt41OUgi7uvYbgzuchNEEzeFixovVi5WwxSI6Yk7gydM8S
 W7EHf+vifw6vQukl2yu/dJVq11dKwFVAHatFGutbCdONX/nB4Cz4oTa8xHWjgSCVIHSUN7Q7xn5
 wbzRTEejWxyfdiPmGghHq1Gm9zQGHbhJx1tw==
X-Received: by 2002:a05:6402:1446:b0:659:3d99:4bf4 with SMTP id
 4fb4d7f45d1cf-65fa476ebefmr2361406a12.4.1772102014612; 
 Thu, 26 Feb 2026 02:33:34 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac07c09fsm352199a12.32.2026.02.26.02.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 02:33:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 464F05F7C6;
 Thu, 26 Feb 2026 10:33:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 3/4] target/arm: pass rd directly to wfit helper
In-Reply-To: <CAFEAcA8km4H10ZseUd=D6KWTpHQptUaL0D3dSrg3-LGWY1bcgg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 26 Feb 2026 10:29:24 +0000")
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-4-alex.bennee@linaro.org>
 <CAFEAcA8km4H10ZseUd=D6KWTpHQptUaL0D3dSrg3-LGWY1bcgg@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 26 Feb 2026 10:33:32 +0000
Message-ID: <87qzq7ztdv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x541.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> If we generate an exception for WFIT we could also fill out the rv/rn
>> fields of the ISS. To facilitate this pass the register number
>> directly and read the timeout value in the helper itself.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/tcg/helper-defs.h   | 2 +-
>>  target/arm/tcg/op_helper.c     | 4 +++-
>>  target/arm/tcg/translate-a64.c | 2 +-
>>  3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
>> index 5a10a9fba3b..a9a062cf777 100644
>> --- a/target/arm/tcg/helper-defs.h
>> +++ b/target/arm/tcg/helper-defs.h
>> @@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, va=
ddr)
>>  DEF_HELPER_1(setend, void, env)
>>  DEF_HELPER_2(wfi, void, env, i32)
>>  DEF_HELPER_1(wfe, void, env)
>> -DEF_HELPER_2(wfit, void, env, i64)
>> +DEF_HELPER_FLAGS_2(wfit, TCG_CALL_NO_WG, void, env, i32)
>
> Why the change to NO_WG ? The code change doesn't remove any
> writes to globals...

I thought that was the right way round - it doesn't write to any
globals, but it does read so the helper needs to ensure globals are
synced before the callback.

>
>>  DEF_HELPER_1(yield, void, env)
>>  DEF_HELPER_1(pre_hvc, void, env)
>>  DEF_HELPER_2(pre_smc, void, env, i32)
>> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
>> index aa14f15eb62..28a1c7243ad 100644
>> --- a/target/arm/tcg/op_helper.c
>> +++ b/target/arm/tcg/op_helper.c
>> @@ -409,7 +409,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
>>  #endif
>>  }
>>
>> -void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>> +void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>>  {
>>  #ifdef CONFIG_USER_ONLY
>>      /*
>> @@ -428,6 +428,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>>      int target_el =3D check_wfx_trap(env, false, &excp);
>>      /* The WFIT should time out when CNTVCT_EL0 >=3D the specified valu=
e. */
>>      uint64_t cntval =3D gt_get_countervalue(env);
>> +    uint64_t timeout =3D env->xregs[rd];
>> +
>>      /*
>>       * We want the value that we would get if we read CNTVCT_EL0 from
>>       * the current exception level, so the direct_access offset, not
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a=
64.c
>> index 5d261a5e32b..073454b9195 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -2064,7 +2064,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *=
a)
>>      }
>>
>>      gen_a64_update_pc(s, 4);
>> -    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
>> +    gen_helper_wfit(tcg_env, tcg_constant_i32(a->rd));
>>      /* Go back to the main loop to check for interrupts */
>>      s->base.is_jmp =3D DISAS_EXIT;
>>      return true;
>
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> You might squash this in to patch 4 if you like.
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

