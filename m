Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B86C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Jr-0005yr-EF; Mon, 19 May 2025 12:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3Jp-0005yE-27
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:26:25 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3Jn-0004YM-AT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:26:24 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70b4e497d96so41773697b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747671981; x=1748276781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDePMuaeX4+id5gfLnVYD0IxFWe/H7JpIkSEbEkpsMk=;
 b=eADzZl1dbMuOHoahsVh4/iX31eKLsLiWEdVYnSF1MDn5MeAlSAWsGtFQE1V/elqIpY
 D/KmOnXKpMlNPQ9tqyPSe6XIwoTaU5TFDO9BtVJfodMqopjWDtwUu6+oQ6NnA1wrR1IX
 5XvxdNaiGn0YcVB89YTGvqKJhcHpnTSbmpbRp3mbSCE2oF3kr8HxwSG8vN/Qtb/XMair
 qlP4M6GkGLWO64JJAFWh+6jr3psy/UEytlMSgU02m1+E8sEKuh4Uzc+T5JCYuzcLRPl0
 1SRrddLeHWhFJGyU8TOfy5Kv14ny9N2YzGPRwTEJKFiHSHh5jSIpBVpK2Jb1pHeOoyRO
 aBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747671981; x=1748276781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDePMuaeX4+id5gfLnVYD0IxFWe/H7JpIkSEbEkpsMk=;
 b=I3rKZ35jGeVBCgZY84YoX4i9SOG8OiQ4wkoFLr9QQOLVRe9ZZPc5bfqr36/fi4iEVV
 wM3iaep2NbkxibRoQBrPwTGCghDgrlOzPn5LNNX8pQW9Ssj4oY7XF0/BKwD8ZCjz7Ebh
 vu+7oNrzpvRL6dyrLmIhn+2PLCPnBPBFdelZqLLw3yVedjWnvsRxsYqW1fS+1F/U8d/o
 1QqK9tFxKkZ9N8pXBA2se+WX7iAqSua/BQ4V9RVMv5STUvQuo07nDm1I6dG62CXv2plt
 /nL7a6C0+FvUjm4GD92quT1cbTuN8wejP7kd0k4MnmT7SCPK8cvUXe3vAnkUscNG4tyA
 lISA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+CX9T5+TU0VUXQPdoqEvyBG8MnRWbBIq6Bug/5BjD8ZHpavjV9dkTyO97F1CD1w+QEuSanY80sAE1@nongnu.org
X-Gm-Message-State: AOJu0YxajVV4S8Rym5PZnkRS1y3+wISVVv9G+IcevUFxvYwebSe/nMZN
 chbESzFpsnahjSfp+J8OPcKYu/9oGu/yM2auyLYesMfIvSalY1LcsRsHtzpNLaRZT0ztsv2i1jV
 hgPBOK/9bUfv0aWvJkwCa2zWFcH2WA27daz4TeC+RBw==
X-Gm-Gg: ASbGnctC/hoX/j2V0rhIIsDOjmKh5xp/nyzJ/6zOYma1wCX8BaK+8G76i5EFGQZSy+a
 Ho58F17mDH7vUaq5ObVTU85d/h3zXJJPqHWgCTTpYYR/1LSdN5voLU/CI+t6Q1XtY9lTmiHReIZ
 OUKGQ4DuBgAgHILhrWCn8Oykz5bMh67zS0dQ==
X-Google-Smtp-Source: AGHT+IEwz9eM41PrR+pmfWklFY3e4/RYh6vJkrNMA3PbLF/fp+uhKc/AMzZZOdAogpOjeemc67zKIHU/y8njNOblBWY=
X-Received: by 2002:a05:690c:3390:b0:70c:9364:2c61 with SMTP id
 00721157ae682-70ca79bf741mr174331697b3.9.1747671981113; Mon, 19 May 2025
 09:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-3-chigot@adacore.com>
 <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
In-Reply-To: <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 17:26:08 +0100
X-Gm-Features: AX0GCFtb0YoNJ4ovClBRheo8kqJ0UEZ0YFVobJTpDtekqjz9Q9HFD0BRYODcNHs
Message-ID: <CAFEAcA8vKNkfKgp_Yymo9NA1=E2XJYXAMTgO3z6q6DHgqkAwRw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org, edgar.iglesias@gmail.com, alistair@alistair23.me, 
 Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 13 May 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 13/5/25 16:14, Cl=C3=A9ment Chigot wrote:
> > From: Frederic Konrad <konrad.frederic@yahoo.fr>
> >
> > This introduces a first-cpu-index property to the arm-gic, as some SOCs
> > could have two separate GIC (ie: the zynqmp).
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/intc/arm_gic.c                | 2 +-
> >   hw/intc/arm_gic_common.c         | 1 +
> >   include/hw/intc/arm_gic_common.h | 2 ++
> >   3 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> > index d18bef40fc..899f133363 100644
> > --- a/hw/intc/arm_gic.c
> > +++ b/hw/intc/arm_gic.c
> > @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] =3D {
> >   static inline int gic_get_current_cpu(GICState *s)
> >   {
> >       if (!qtest_enabled() && s->num_cpu > 1) {
> > -        return current_cpu->cpu_index;
> > +        return current_cpu->cpu_index - s->first_cpu_index;
>
> Note, CPUState::cpu_index is meant for accelerators code and shouldn't
> be used in hw/ (in particular because it vary when using hotplug).

Mmm. I think my ideal solution for that would be that we
put the CPU index into the MemTxAttrs (requester_id, perhaps
with some extra flag that it's not a PCI requester ID).
Then every device that's looking at current_cpu to figure
out which CPU actually called it would be able to stop
doing that. We'd still have the "OK, so what number does
the GIC think this CPU is?" question, though.

For telling the GIC which CPUs it has connected to it, my
instinct is to say that ideally we'd have the GIC have
something like an array of link properties, and the board
or SoC code passes the GIC a pointer to each CPU in the
order it wants them to be.

But that would be quite a bit of fiddling around to achieve,
so I think I'm OK with the approach in this patch, especially
since the GICv2 is pretty well obsolete at this point.

(GICv3 also assumes "starting from zero", in several places
where it loops from 0 to s->num_cpu calling qemu_get_cpu().
Link properties is probably what I'm going to end up doing with
the GICv5 design.)

One note: if you add a new property to the GIC, please
also add documentation of it to the "QEMU interface" comment
in include/hw/intc/arm_gic.h.

thanks
-- PMM

