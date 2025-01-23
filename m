Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC90CC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taw2E-0007GU-Ha; Thu, 23 Jan 2025 07:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taw29-0007G1-Ux
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:10:06 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taw28-0002zq-4z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:10:05 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso188788666b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737634201; x=1738239001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxCgSPJAN7mq8o9NmFTdWyzHJ9BG/HA7IBPW2uBdUcQ=;
 b=hqIQnMtbAolNIoHwYPbyDFtPoLnnv0OL7UYeKV8JPp4rHdCw2M80Pt9uYd4vYWiN+W
 oo1/8884tmAVgXm6ZaprKHKxI/XSxRYQ8IlUBqllqv29R8eWKrdDbWX08hzJf6BPjQ3t
 bn605g7V+++PRCI2MfwW0ewy90jG7hYKqArKa5FUR9Xrp9imkmdDyRgfBAm2UJI3eFZY
 WpyqTZnxS0aWXN9gzYvPHSPpNL3qKKLRNmh12TVLi1eas9Hz74lnbByfw/8pSmKJKqmB
 4Ph9fXI7Xr4TMMHI4/N26HR+Wzkez5pE8wLjBFFUH/g2VHu/8emSnlHT/ct96MnlRGXu
 4Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737634201; x=1738239001;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KxCgSPJAN7mq8o9NmFTdWyzHJ9BG/HA7IBPW2uBdUcQ=;
 b=DCMaZtweDSKEk1PpVb6DWqKuP/6LCuB2ndVtea3yXsQxlQQTiFBVcA7Y+urJiJlmC2
 lc7XtoP+YcdFXC/t5GwoKYMAJbIioXacBE+MSrsRZs1vHau0KpjH9126J/FkqMqgWQOv
 3GInlQy/PrpvJXiKxRkN9JGkTBIIU48A9GEVyb5i36aINTANVSbW6aVSvdAvgJvq2flI
 218nVu37mY/Ki8WFJCDMAz4Eubr3h1T2cHDJriE1+90MGaW+FZUsvUrfYac5b+XW6/Bx
 tXavRIgWp43CWHr4VssPkpTO+nf+RnbGRoJSVIQiVSvO9UqNa/MyQ7y7hgZRM53yiNHC
 LymA==
X-Gm-Message-State: AOJu0YxZcWSWncNUEzqcqImROlRbXAyPVzfivIUaS7I8A/SENC704reu
 pQ6TRTWFlN2PReKORXuNKl4TDK/FHaw3JHNl6an+W7i1k9Fy5eozT3b2WfUA7SRnldFAhvNCKzl
 lNEA=
X-Gm-Gg: ASbGncubUk7JjElx78AWu2RWj1qjcM0JkWXqJp+iJmWCjYn0AHBn/nR9k8DNWrpqzX6
 M+U8f7Vy9dXX5c8S5+zOPc3NZot3lVNmzecVsjo6q7ybywPq5wkg9/4/HQTxw2iy9myjJSRv7AF
 XhFOhulS/dRl9Ozjy8D6b3+iyjqBqEGv1oilRkpnkQFhL9WYbrtDKvXYQlX8do6ea3zcIzMNlM5
 7S9/uxjhEC383aODbIYcEIbeo/JXAmr4BHciDUJ6UbrKCF6k/GzX/YSLeJfFpOeXnguinUjDblX
 zeI=
X-Google-Smtp-Source: AGHT+IGYIFLgt8jZg+10PcwaoMAnESrQoa8CZ8v6JhxPYlBqRUtIA4qOuMR3RvCg4wl3FQebLi3YEw==
X-Received: by 2002:a17:907:7faa:b0:ab3:30c5:f6d3 with SMTP id
 a640c23a62f3a-ab38b0b7f5amr2270214166b.9.1737634201340; 
 Thu, 23 Jan 2025 04:10:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce213esm1065730266b.63.2025.01.23.04.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 04:10:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 096C25FAA0;
 Thu, 23 Jan 2025 12:10:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
In-Reply-To: <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Thu, 23 Jan 2025 12:23:43 +0100")
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 23 Jan 2025 12:09:59 +0000
Message-ID: <87y0z1k9yg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 23 Jan 2025 10:52:15 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Igor Mammedov <imammedo@redhat.com> writes:
>>=20
>> > QEMU will crash with following debug enabled
>> >   # define DEBUG_TLB_GATE 1
>> >   # define DEBUG_TLB_LOG_GATE 1
>> > due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_asy=
nc_work]
>> > functions are called not only from vcpu thread but also from reset han=
dler
>> > that is called from main thread at cpu realize time when vcpu is alrea=
dy
>> > created
>> >   x86_cpu_new -> ... ->
>> >       x86_cpu_realizefn -> cpu_reset -> ... ->
>> >           tcg_cpu_reset_hold
>> >
>> > drop assert to fix crash.=20=20
>>=20
>> Hmm the assert is there for a good reason because we do not want to be
>> flushing another CPUs state. However the assert itself:
>>=20
>>   g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
>>=20
>> was trying to account for pre-initialised vCPUs. What has changed?
>>=20
>> cpu_thread_signal_created(cpu) is called just before we start running
>> the main loop in mttcg_cpu_thread_fn. So any other thread messing with
>> the CPUs TLB can potentially mess things up.
>
> it reproduces on current master, so yes it likely has changed over time.
> I've just stumbled on it when attempting to get rid of cpu->created
> usage.

Why the drive to get rid of cpu->created?

I guess we could assert:

  g_assert(!current_cpu || qemu_cpu_is_self(cpu);

as current_cpu should only be set as we go into the main thread. However
there is a sketchy setting of current_cpu in cpu_exec() that I'm not
sure should be there. Also do_run_on_cpu() messes with current_cpu in a
way I don't fully understand either.

>
>
>> > 1)
>> > Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > ---
>> >  accel/tcg/cputlb.c | 4 ----
>> >  1 file changed, 4 deletions(-)
>> >
>> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > index b26c0e088f..2da803103c 100644
>> > --- a/accel/tcg/cputlb.c
>> > +++ b/accel/tcg/cputlb.c
>> > @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUStat=
e *cpu, run_on_cpu_data data)
>> >      uint16_t all_dirty, work, to_clean;
>> >      int64_t now =3D get_clock_realtime();
>> >=20=20
>> > -    assert_cpu_is_self(cpu);
>> > -
>> >      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
>> >=20=20
>> >      qemu_spin_lock(&cpu->neg.tlb.c.lock);
>> > @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t i=
dxmap)
>> >  {
>> >      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>> >=20=20
>> > -    assert_cpu_is_self(cpu);
>> > -
>> >      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
>> >  }=20=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

