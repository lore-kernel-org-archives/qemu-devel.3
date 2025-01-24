Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC66DC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLOp-00046O-CP; Fri, 24 Jan 2025 10:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbLOn-00044v-BT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:15:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbLOl-0001ML-AZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:15:09 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso3883543a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737731704; x=1738336504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Br+dfmWkeYi1cTYXhfYxHSCHFOIQBZwP42rNnX2KAik=;
 b=a0O0Dgp3hEmQx5XgX5AFQxFVJ4rGvELiaVtUt4EvcLhnfAO7YQHIFHNcuAhPX3uOFD
 PenyzZWPz1BQ8OvUKSc6krF4ejaMqf6IEvqBihFolF921OofXm4FWhip+E4V91WsZfBw
 j76/GhEsDmkPfDg0fQ3oLaLixeF97KPQSpLF9bA2IXiOBa+qP9Gtv6wt3hVyuaFh+MtD
 8B9bGK6AQEdcxwHEnx6LTmQvkJ4360J7rJY/JTm+YgYW1NyoRE+ljCiFin9CH3nMOmD9
 RZip6WUF2flEw4j7qGZ5Mr4xrI/23wTGEa0dxcr3JkQLKTTP1Z7MDctWObURRTZaCImD
 99wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737731704; x=1738336504;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Br+dfmWkeYi1cTYXhfYxHSCHFOIQBZwP42rNnX2KAik=;
 b=jSu4HpCRlvqNlBvQ+BctgjXpKFpFLMSAe+06iCdJ6pBCxRrsd2eiMGlbgFu7YbQlxB
 ZHpIG5YLz4VKp3/Enxfg18hAeICUpUx3KPBZnx6nsRzMfMXEdOec/Hvq4N/6M32Zrv8E
 h12AbcpfpvKCUimz7sDMsjgV9+/x18ceg9yjNEBBVaPPqrLGe1DwsCTfl2TGQRhT0rs8
 wn09N6cTJfx1tumcNAH2Lk15RdTHPg4vp77lpwG4zyGE0rh+YV4uIltdAQW9Lx9LsLKI
 R6q0evV6OBTPUq8UkiGvWEY6Gybia3ENer3vgQ853EcGpH6pi+dassRmrO/D4jLFhm5e
 uxig==
X-Gm-Message-State: AOJu0YyLbEzWjTdKPvnDbx5JoxnM/tIisklXDccCVsMHvyYyIWDQUPnl
 1yB1krTe74wcNHXZvmFJQdxLm56bmWaWk9RJVMTVIBB7nm1+D2f3QOHHp91pA+g=
X-Gm-Gg: ASbGnctA9diMqro5YXt2elBpNcGeAAQZ37qeKuO/OE2vHrvMpNMifjhSMDi+tiflE5A
 xzWFUzwyfsHfhrLB4EX+WvxkVbweV/winj9/q6x1zTT66XkMHG3ecuRhu3cmxsr+WgylQwKzoog
 E3FaBMJoI055YPxoQPAY+F1uQFeMSpcv2srHM2W/Q4g8gkW+bP38ABfqYTcBkPSlII/yl9IFgCz
 Uvc8y4I5lwx6dOzhccUVwcj/VAq0tQZGQ6ZxSzshXSHk65wimaq/o1LK4uIb7yUGKJ3nO/3eW/7
 Cs4=
X-Google-Smtp-Source: AGHT+IEyetAZOcII0pEGXIs+6ObpOQILQFjcTHtTPc7PPGj8V/l46+foN9YmnroJRxb7ymf2Z7ch3w==
X-Received: by 2002:a05:6402:84c:b0:5da:a97:ad73 with SMTP id
 4fb4d7f45d1cf-5db7d2f8825mr23940092a12.13.1737731704631; 
 Fri, 24 Jan 2025 07:15:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc186d8b2csm1295407a12.76.2025.01.24.07.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:15:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C41CD5F8C7;
 Fri, 24 Jan 2025 15:15:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  npiggin@gmail.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
In-Reply-To: <20250124152148.706e88c2@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Fri, 24 Jan 2025 15:21:48 +0100")
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
 <20250124152148.706e88c2@imammedo.users.ipa.redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 24 Jan 2025 15:15:01 +0000
Message-ID: <87wmeki6q2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 23 Jan 2025 12:23:43 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>
>> On Thu, 23 Jan 2025 10:52:15 +0000
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>=20
>> > Igor Mammedov <imammedo@redhat.com> writes:
>> >=20=20=20
>> > > QEMU will crash with following debug enabled
>> > >   # define DEBUG_TLB_GATE 1
>> > >   # define DEBUG_TLB_LOG_GATE 1
>> > > due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_a=
sync_work]
>> > > functions are called not only from vcpu thread but also from reset h=
andler
>> > > that is called from main thread at cpu realize time when vcpu is alr=
eady
>> > > created
>> > >   x86_cpu_new -> ... ->
>> > >       x86_cpu_realizefn -> cpu_reset -> ... ->
>> > >           tcg_cpu_reset_hold
>> > >
>> > > drop assert to fix crash.=20=20=20=20
>> >=20
>> > Hmm the assert is there for a good reason because we do not want to be
>> > flushing another CPUs state. However the assert itself:
>> >=20
>> >   g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
>> >=20
>> > was trying to account for pre-initialised vCPUs. What has changed?
>> >=20
>> > cpu_thread_signal_created(cpu) is called just before we start running
>> > the main loop in mttcg_cpu_thread_fn. So any other thread messing with
>> > the CPUs TLB can potentially mess things up.=20=20
>>=20
>> it reproduces on current master, so yes it likely has changed over time.
>> I've just stumbled on it when attempting to get rid of cpu->created usag=
e.
>>=20
>>=20
>> > > 1)
>> > > Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
>
> bisection points to (so above fixes was a wrong one):
>   30933c4fb4f3d tcg/cputlb: remove other-cpu capability from TLB flushing
> which has replaced a check with assert:
>
> -    if (cpu->created && !qemu_cpu_is_self(cpu)) {
> -        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
> -                         RUN_ON_CPU_HOST_INT(idxmap));
> -    } else {
> -        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> -    }
> +    assert_cpu_is_self(cpu);
>
> should we revert that instead?
>
> perhaps also drop 'cpu->created' check in  assert_cpu_is_self as it
> obviously doesn't work.

That's because the asserts only check when built with debug due to
concerns about the hot path. I think in the case of cputlb we should
probably use tcg_debug_assert() which at least gets enabled for
--enable-debug builds without needing to manually patch the define for
DEBUG_TLB.

Converting the custom TLB log implementation to using tracepoints would
also be nice.

>
>
>> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > > ---
>> > >  accel/tcg/cputlb.c | 4 ----
>> > >  1 file changed, 4 deletions(-)
>> > >
>> > > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > > index b26c0e088f..2da803103c 100644
>> > > --- a/accel/tcg/cputlb.c
>> > > +++ b/accel/tcg/cputlb.c
>> > > @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUSt=
ate *cpu, run_on_cpu_data data)
>> > >      uint16_t all_dirty, work, to_clean;
>> > >      int64_t now =3D get_clock_realtime();
>> > >=20=20
>> > > -    assert_cpu_is_self(cpu);
>> > > -
>> > >      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
>> > >=20=20
>> > >      qemu_spin_lock(&cpu->neg.tlb.c.lock);
>> > > @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t=
 idxmap)
>> > >  {
>> > >      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>> > >=20=20
>> > > -    assert_cpu_is_self(cpu);
>> > > -
>> > >      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap)=
);
>> > >  }=20=20=20=20
>> >=20=20=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

