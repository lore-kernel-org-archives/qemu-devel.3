Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE77CD6E57
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2mb-0006U3-8r; Mon, 01 Jun 2026 09:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU2mW-0006Po-Mt
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:34:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU2mV-0004Ec-2x
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:34:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso7896695e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780320853; x=1780925653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1grSF8bd++Olxy/MzFG+qeC9sLshDoOV1UVAth0MbA4=;
 b=oVp0J6PHLvVtsD7mSixY3Jh6CQPQz67gtwAWynuxxRRfXarHPRPaF/8MBpc7g02scZ
 Z6N+cRRqwjbBWR8j67gzNz5TARYWIouLvgfBk6me08XP8WialiFnKzfCwkDvx5f/PZZh
 t+ocB5aP6kGaD++/XYA/q3p/XOaSA4mxeehmHbKkVq/QZuNqMcT6hKNtDiLTjM1ft7pm
 OcjSfgSyOIBqA+putd+OH36gf1kkV7Zo6A5M+gESh5jizzErQBV9gSNCikfZgbsFY7J3
 QgIaqZCUnWWjUVojKgJx/LM2da3S51oimvu+aJyMETED1MVzO3i0Nd4jwuu3jETlQorv
 LoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320853; x=1780925653;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1grSF8bd++Olxy/MzFG+qeC9sLshDoOV1UVAth0MbA4=;
 b=gh/r4Y5kflgtlZnbuW92khnqIyChN3o0zlulTYvxESqOaK6HM21IFrsx6XwAnJS+LU
 rl2ecSc8U6c9qLurNbrKJYbAkHNJrm8r3rqKGLh8ye0RpCfPFVVfuYry8wR3rOpFtA89
 zWgc3o65qLX/PsZgtwmtx2ihilg0b9OZ/N9yOy13ujU4uXkJQjoKR8e6jhalLCgDOIVD
 zgeO3u0j12i8iDotU7KoOMDrBecTPyQzDww3UoHRwtwEjIBwK/HmFwQNETu+FBs83pnO
 HQvFJixOLVxCFYpfNtRaiLQ8AgCqNb/7dUSq03UzkKQUhTekuFJglVaK7A8zc+BO7t2M
 Ltqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B3m/GWpE8y9rsKwbtcGrGq5OJqJs5h8kSZFlwAvG/iUbdWZ2LRnnKnf1I1dTri1flwE4vzIy4xMkG@nongnu.org
X-Gm-Message-State: AOJu0Yw0dCv8riBvmnA/B3wB6IhvKM+VJteHNQlDCDjQJLLBk10LL+wP
 qtUnCFWFu/nsjJ9fxKdr2CkKwFZtSgR875qc2axx6teo/5yK8OIF4c9Cq7IEZeT7Zx8i/onKNRT
 BSzAJ
X-Gm-Gg: Acq92OEHmKaf37CPig95gSOZ9PmPDdWOdCsu1+A1FlO8i5zjjhNfae9Oq808tKAnb2e
 v/P7YezTKvEG45BM+DtQA6RGDhXBGVZeWzaK4F/g5QRtu6f6geUzikoNfXrQ6fzkeaA4nV0TFqW
 OSbw6eDVSieDlHtPgF0sZLRVx2LRgkhv/guai1TBpPUYpLMCtExpw5k3+HS2vBa+KFQ29950x9A
 6RuN5U9bhZcZZOfn9qVfW6gfNnwpd/Ut4mWEW5JSmoE+FgG2uOlM3jGNzb0hZUJV/bpn1nNuYLQ
 XhmWJbeJ/p7gfIdPnElwg4yy4Xjuz5Kr9Kxiks9Vv3KLUn06A5sqQig8rSQZdrSw/TDaSH9UVSj
 RJpQwjvfhDbZlacrwyumJRYlUrStDj3LJ46OqguRcImW53oa6ntsVClc09ffeOAhysmws4bTM4w
 JAHq7Nftz+APv8953zmQ47WcmfkFKu3EKwC+afuH18PyX4
X-Received: by 2002:a05:600c:8508:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-490a2915bc8mr218355225e9.10.1780320852521; 
 Mon, 01 Jun 2026 06:34:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c053029sm77350155e9.0.2026.06.01.06.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:34:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DFD15F7C7;
 Mon, 01 Jun 2026 14:34:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>,  qemu-devel@nongnu.org,  Song Gao
 <gaosong@loongson.cn>
Subject: Re: [PATCH] target/loongarch: clear the registers when cpu is reset
In-Reply-To: <9ede8d17-2a2c-ce1a-16e8-80fc3e984451@loongson.cn> (Bibo Mao's
 message of "Mon, 1 Jun 2026 10:02:33 +0800")
References: <20260529063858.3437928-1-lixianglai@loongson.cn>
 <9ede8d17-2a2c-ce1a-16e8-80fc3e984451@loongson.cn>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 01 Jun 2026 14:34:10 +0100
Message-ID: <87h5nmxu3x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Bibo Mao <maobibo@loongson.cn> writes:

> On 2026/5/29 =E4=B8=8B=E5=8D=882:38, Xianglai Li wrote:
>> Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
>> reset state when the CPU is reset.
> Hi Xianglai,
>
> Thanks for the patch.
>
> Could you add some description how do you find this issue? such as by
> code reviewing or there is a real problem.

Also Loongarch seems to be one of the few that doesn't just do:

  memset(env, 0, offsetof(CPUFooState, end_reset_fields));

in the reset function.

>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>>   target/loongarch/cpu-csr.h |  7 +++++++
>>   target/loongarch/cpu.c     | 19 ++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index d860417af2..d936af8e57 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -211,6 +211,13 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
>>   #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
>>   #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
>>   +FIELD(CSR_PERFCTRL, EV, 0, 10)
>> +FIELD(CSR_PERFCTRL, PLV0, 16, 1)
>> +FIELD(CSR_PERFCTRL, PLV1, 17, 1)
>> +FIELD(CSR_PERFCTRL, PLV2, 18, 1)
>> +FIELD(CSR_PERFCTRL, PLV3, 19, 1)
>> +FIELD(CSR_PERFCTRL, PMIE, 20, 1)
>> +
>>   /* Debug CSRs */
>>   #define LOONGARCH_CSR_DBG            0x500 /* debug config */
>>   FIELD(CSR_DBG, DST, 0, 1)
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 8f277f7696..7f82c4c46c 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -622,6 +622,7 @@ static void loongarch_cpu_reset_hold(Object *obj, Re=
setType type)
>>       env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
>>       env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 0);
>>       env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 0);
>> +    env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, WE, 0);
>>         env->CSR_EUEN =3D FIELD_DP64(env->CSR_EUEN, CSR_EUEN, FPE, 0);
>>       env->CSR_EUEN =3D FIELD_DP64(env->CSR_EUEN, CSR_EUEN, SXE, 0);
>> @@ -633,7 +634,7 @@ static void loongarch_cpu_reset_hold(Object *obj, Re=
setType type)
>>       env->CSR_ECFG =3D FIELD_DP64(env->CSR_ECFG, CSR_ECFG, VS, 0);
>>       env->CSR_ECFG =3D FIELD_DP64(env->CSR_ECFG, CSR_ECFG, LIE, 0);
>>   -    env->CSR_ESTAT =3D env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>> +    env->CSR_ESTAT =3D 0;
>>       env->CSR_RVACFG =3D FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS,=
 0);
>>       env->CSR_CPUID =3D cs->cpu_index;
>>       env->CSR_TCFG =3D FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
>> @@ -641,6 +642,22 @@ static void loongarch_cpu_reset_hold(Object *obj, R=
esetType type)
>>       env->CSR_TLBRERA =3D FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, IST=
LBR, 0);
>>       env->CSR_MERRCTL =3D FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISM=
ERR, 0);
>>       env->CSR_TID =3D cs->cpu_index;
>> +
>> +    memset(env->CSR_MSGIS, 0, sizeof(env->CSR_MSGIS));
>> +    env->CSR_DBG =3D FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 0);
>> +    for (n =3D 0; n < MAX_PERF_EVENTS; n++) {
> how about for (n =3D 0; n < env.perf_event_num; n++) {  ?
>
> Regards
> Bibo Mao
>> +        env->CSR_PERFCTRL[n] =3D FIELD_DP64(env->CSR_PERFCTRL[n], CSR_P=
ERFCTRL,
>> +                                          PLV0, 0);
>> +        env->CSR_PERFCTRL[n] =3D FIELD_DP64(env->CSR_PERFCTRL[n], CSR_P=
ERFCTRL,
>> +                                          PLV1, 0);
>> +        env->CSR_PERFCTRL[n] =3D FIELD_DP64(env->CSR_PERFCTRL[n], CSR_P=
ERFCTRL,
>> +                                          PLV2, 0);
>> +        env->CSR_PERFCTRL[n] =3D FIELD_DP64(env->CSR_PERFCTRL[n], CSR_P=
ERFCTRL,
>> +                                          PLV3, 0);
>> +        env->CSR_PERFCTRL[n] =3D FIELD_DP64(env->CSR_PERFCTRL[n], CSR_P=
ERFCTRL,
>> +                                          PMIE, 0);
>> +    }
>> +
>>       /*
>>        * Workaround for edk2-stable202408, CSR PGD register is set only =
if
>>        * its value is equal to zero for boot cpu, it causes reboot issue.
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

