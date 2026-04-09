Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2E4F364B7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvoP-0000QC-7F; Thu, 09 Apr 2026 16:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAvoM-0000Pb-7v
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:17:10 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAvoK-0007CV-9I
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:17:09 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65032e9cf01so1249587d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 13:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775765827; cv=none;
 d=google.com; s=arc-20240605;
 b=eyKING0HUta9zOIy+ITSNBl7Td19t/on50McCAwbLjRe9ZUUjBq0FqR7Mc6Avq6Jpo
 BN0hVmJd5tPBh0KiizZNkEK3yvh9ovaO1TPnctniqjgMAld/jLPCpIHPmIBHlWLZkmT4
 zu7WcrDqnYSIkznuAzAlVaorNKXsEn+5p5k8z0nTeSkKRWmVWq/dBP24FMFs+7ga7GjD
 G1FSgiLVaVINEcvOXDolw4XYXw1Ad0hOxp8dUxvCVeNmbF+2mo9sTgPP4z07L1urrnUV
 OU2qeZt0ytaLOph3ZOTx+2j3DvfptPCFIM4aZWBFBfTXa3N4PYwzVQ4lomsGkAry3M3y
 LCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DZxLqrufXceS85n/R/AvvuBjIY8xZUEjqhJGvgNdNuo=;
 fh=VQTX0KcHLYp0W1xh5qMyMVzUksc/bNzicpit96Uxm2w=;
 b=AyyulJEPemYzuj6unovvrv8t71yIo+h/SkcaM/DAJuCc4RlueHqiyZSwqficzaF2Nx
 iT8kl1Z0KgSgpTmCwRG7BWijxEn5RGcvJv6MYUuku2gaBZVjB6WGC6wqqSV3lShwcf4n
 iRSBsNnEfWudgki+d07MzlakhtokvWUcvP38AzCOTIZIFeacV+DOFxUHNyrcC3QLW6v1
 1UjxzvlFqHohxQ52qVhPT3E23+5FnE6C/lFgATxHg3PJmObSSIiY65ubGG/Y7nBX3z1Q
 hWJKCjcqEOkm0k8l7kUFgBUObmybdaaO613oe4Cv+s2HheVuPvOvtlza8jTaewj64sTV
 2Z2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775765827; x=1776370627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZxLqrufXceS85n/R/AvvuBjIY8xZUEjqhJGvgNdNuo=;
 b=Po4Zh2WxTJqr6Kn7sjFskTz85G1XGOcKQemShLwmA0NLf5t/mZcr9QLZbtTG11a0EX
 TF5lAA97pttGbWSAM+XHVCVmNn5pxivCWmEi0Hh+QI6Fl+sI/ATMPAgME0pimc6yBesW
 mWiYb7Daflnq3RuQ1mnJFnuxU0WUoiCCyHiPSsMvTuYKqoO3I41rGYID+dtBeKyshyjM
 fIvEVjCEn3OtRNDQPD3ct6GwtcpgK94gLHZcKCU1zytvoEvz0hukvcF08Oj2yB7l+HYz
 FYf1z4gL9STUVgYqpyV87ffYRGOccTPfMRUbhrfYpZRIENUqvrPQNnnW+HXLKX/pl0ux
 n7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775765827; x=1776370627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DZxLqrufXceS85n/R/AvvuBjIY8xZUEjqhJGvgNdNuo=;
 b=Malh2zhxvTX0eaoPpb1SEEmlhQaf7vGcqeS/HgkBZ1YsaNvhBNsj8uwfTblYg31N4Z
 C1A4/LbESMI/2GG+JXLxNp5n63ZG42P4pLHDrJFMRe38bQSRLkE3R3tuBwtP1fdthQk2
 cvtGuv50To2t2prXutbi0k3E36f5v6wkLcFOgL87vkiteodP3A4cr+r3vyzjV3DFF/W4
 +UUE0tnQInTIKLRGB0nE1uNjDt6F/6nXnOZWyd5xkGwYdO/O/Zluo29L23F33Gf8jVKI
 fKdo4ID2hz8fQqSMuVzUoVTQMXIzrrQHaq9AKw1zl//7rpacs1AiAI7lAy3yZaWlAI+3
 IO7g==
X-Gm-Message-State: AOJu0Yxjk7ectLFOgKFQAKazoTYeDnJH0bW+ewTrW/ui8A0rTp5005I/
 TllXDoNrMOz57yi1sQWr1dgYQOiJFT7GGAfaLCrF7wlUp9ZtzZ+w8itowUZCrdlObcXxdmMsbF4
 pi1U2BK/71p3kGHvEEDjGSEziEa9F1fj3y0eJs38Xag==
X-Gm-Gg: AeBDiesQGSifxK3yu0t6f4uujJhzn7eFr+ZJquedD8iGhvDpCXYvBSUAdzCFKF4OkE1
 YiO27JkSO2Aan2Kly6easKSihMxWbLkO310sjv6Q2iZ+iysxreT/Lb6aq6KzoMwbnwuOv3cSka0
 BqH/Tdpqlo5fixtsXWkRCCQpeVufYERE50sKycxnsqK2LDk7sf9MPDG6bxblEmUEyY3UgH+ExEv
 Tph/36n/7mULIDgRTNWfwPO/230uclE34fPCRFrYNDw5cXm1QO24KWqz8HEipYHJK4LvpNmqAjE
 nPPErGceJI9ZlxJutkbexlVAwiWQgIBzKTo9/2w2untoJcs6zBtbiP9U2TKRuuqIZD9iHH+CtSz
 v3w==
X-Received: by 2002:a05:690e:400b:b0:64c:9ec3:d710 with SMTP id
 956f58d0204a3-65198b78e0emr398785d50.41.1775765826673; Thu, 09 Apr 2026
 13:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
In-Reply-To: <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 21:16:54 +0100
X-Gm-Features: AQROBzAzdBHRTtfHqI6u6UuWaLqQ2yP-vsiuAXeynE3nlMMQAkYfUJew2bTmmx8
Message-ID: <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: James Hilliard <james.hilliard1@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.com> wro=
te:
>
> On Thu, Apr 9, 2026 at 10:17=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
> > >
> > > MIPS glibc startup expects the thread pointer to be live in both
> > > CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
> > > cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
> > > unchanged.
> > >
> > > A guest can therefore successfully execute set_thread_area() and stil=
l
> > > reach __pthread_initialize_minimal() with k0 =3D=3D 0, faulting on th=
e
> > > first TLS-relative store.
> > >
> > > Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
> > > MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
> > > updates follow the same path.
> >
> > Where does the kernel do this? Looking at the mips set_thread_area()
> > https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/sysca=
ll.c#L87
> > it looks like it sets CP0_UserLocal plus the tp_value field in the
> > thread_info struct; and I can't immediately see anywhere where it
> > would read either CP0_UserLocal or tp_value and put it into k0.
>
> So this seems to be something used by the vendor SDK for Octeon1
> but not Octeon2 and Octeon3 targets, kinda strange/annoying.
>
> I also found this:
> https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html

Ah, nice find.

> It's in the Octeon vendor kernel here looks like:
> https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14/blo=
b/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L94-L=
96

Mmm. We emulate the upstream kernel, not vendor forks, so
we wouldn't want to set k0 here I think.

-- PMM

