Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12396C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 10:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taup3-0001i2-AR; Thu, 23 Jan 2025 05:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tauoy-0001cz-Fw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 05:52:24 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tauot-0004uj-EQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 05:52:21 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso1445856a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 02:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737629537; x=1738234337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdf3ivMFYUkopEpERsIZVXLaALob6m/J2M5Y5WsBCZ8=;
 b=SsZZ9NA6zr6sB7kyRH/cPJZLJdhDtZOfv2jXeidsfx6lCGgFJjN77P2VW6fd/ofpAt
 EvUVgKJQrFPFhrhVX2Gg1whyxfiGvPdEGB+tpHNW9RSolP1Kf9H5MJo7XzJro5N3gRy9
 MJ92vsTFULDo1fkczusQFVc+pRvJjbKcvPGzncChQmOILlxlkgOGxpio8pcU6ksYJfu6
 o03qGNfk6JlvIUa0y1zrayoTGfyYzcVrndBjod2H6PIZPiJCRrbmIFtahZtJeTJeysqt
 Hd2RqqI3HMJ4wkUFHIKkCuQBXHyw8Daahy3triWg+Aem8B5+cgt+5HPiOBMVr98MFXXc
 wGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737629537; x=1738234337;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qdf3ivMFYUkopEpERsIZVXLaALob6m/J2M5Y5WsBCZ8=;
 b=GeosH+5NvoqGyoXfSg6X+dCWWmaOyuLxL13JFnAOK/98M8nkRrL0xtJxTuUBGi994n
 XYBXRwJxSmMN8o7wEwmLKf4gJl2e8XHJ49D+iXU3bmHRk61y+LTEsKmR1OLIkW7+B3YJ
 JPjhMoRKVRQNlRwMbsDFwbBvtz5wMyn/GeylUSx6wdTw9uGEiwcxUTj6M0yY5CdwEot3
 eMxg1j5JB56XhwQ5TcOxYch+9CwqLmlOzOa5MvVlhDsVC1f4qRgDyGmQzyEev1ZxZOZk
 wkhw/yh0SW3JPWQfrdhYLu2AtDiOzq6jMSlxbsOz0AtBC/Z6bNPqUupNYexJtpU8N5OI
 p4Hw==
X-Gm-Message-State: AOJu0YzB3JSwY4RN0G5dSx5KDk/KDTa3fTjKApjMUj/q6VyOwuReF0xU
 X4gGUfTCfCi9e0HBfLfxIxX7Duc5Y1bxCJakEyMtrTgK47I0kC+joVXI9O8dK5/qDw/gg6E4UOl
 eanA=
X-Gm-Gg: ASbGnctqRT5AJWUWStHNi20il/Dxwc55Jl7teijRZZcscHs+6nNa90w1vhARBHaj/9F
 u7JiIAuYWm6sfKLiAwMBQQkiyLPwbiNGeBjUpmYlqPYZQTfZVrOB1zO91t9L94scbNO5qX0h8pm
 ID4kSuznDgxfcz+7+A6gwZ9RBr+AJSIyLBqljR40JCiETwXwT8KfyxyuOFQOAtncvcNo75BwjVE
 WqWAhAygAZepNP12axg6NoMzlqOYuYOmsTbz768BR1w+pgvykyntg6//wg8kfteqpc1stexE4WD
 M/cwePeEL0COog==
X-Google-Smtp-Source: AGHT+IFqLlET3oOQ8qbdGqMCNppzCIPwMv+3KTiO+HUxtnmR5vGY8OKHSddx5Z/Pj+4NnS4JdS1Mzw==
X-Received: by 2002:a17:907:1c21:b0:ab6:58bc:715b with SMTP id
 a640c23a62f3a-ab658bc791cmr430074966b.55.1737629536953; 
 Thu, 23 Jan 2025 02:52:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f2303csm1049095566b.100.2025.01.23.02.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 02:52:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 804A95FAA0;
 Thu, 23 Jan 2025 10:52:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
In-Reply-To: <20250123094511.156324-1-imammedo@redhat.com> (Igor Mammedov's
 message of "Thu, 23 Jan 2025 10:45:11 +0100")
References: <20250123094511.156324-1-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 23 Jan 2025 10:52:15 +0000
Message-ID: <87frl9ls4g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

> QEMU will crash with following debug enabled
>   # define DEBUG_TLB_GATE 1
>   # define DEBUG_TLB_LOG_GATE 1
> due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_async_=
work]
> functions are called not only from vcpu thread but also from reset handler
> that is called from main thread at cpu realize time when vcpu is already
> created
>   x86_cpu_new -> ... ->
>       x86_cpu_realizefn -> cpu_reset -> ... ->
>           tcg_cpu_reset_hold
>
> drop assert to fix crash.

Hmm the assert is there for a good reason because we do not want to be
flushing another CPUs state. However the assert itself:

  g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));

was trying to account for pre-initialised vCPUs. What has changed?

cpu_thread_signal_created(cpu) is called just before we start running
the main loop in mttcg_cpu_thread_fn. So any other thread messing with
the CPUs TLB can potentially mess things up.

>
> 1)
> Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  accel/tcg/cputlb.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b26c0e088f..2da803103c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>      uint16_t all_dirty, work, to_clean;
>      int64_t now =3D get_clock_realtime();
>=20=20
> -    assert_cpu_is_self(cpu);
> -
>      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
>=20=20
>      qemu_spin_lock(&cpu->neg.tlb.c.lock);
> @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxm=
ap)
>  {
>      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>=20=20
> -    assert_cpu_is_self(cpu);
> -
>      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

