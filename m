Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84BFC037D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwIh-0005yl-Q5; Thu, 23 Apr 2026 11:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wFwIf-0005yP-U6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:49:09 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wFwId-0000qy-KM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:49:09 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so7191804e87.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776959345; cv=none;
 d=google.com; s=arc-20240605;
 b=kkWPsGw/qqu3d1stgadn/8RCCVX8m9tyncV1bCz4t1NRljIOQkGV/+2DUlpwEq264V
 KZYEyan2snq64eu0NhdGnWXyjZrnja4zcgjw04Sew57pXg5lFOwV/c1uChLKvABZIv8z
 wycP0cfM8ax3Xo96+ttu0VI1+30QJw7FVxjB+Bcp+HKWGT3jr4PvQFXW5OWBKwpiLubj
 joDrhbhiC4g65i0jk2lwDREkb0SjZR+xX0szLsYxU9qTitzfIAI4/Tvv734X5mvd9aKt
 Fy0/mgmAdaqBg13ndc3rjc+BvPSyGQL65sVm2uUQk6FVf1iF/ZEzZuNOANVRhh2ZV5no
 cURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TGW2IDUhE+ABrUpa9VgNBxHuTQxSfnLSg36cSkFMeRM=;
 fh=aZZu/7uX9TLQ5xVddPt3S8mleR5KauIDQutAfdEvHb0=;
 b=SIaf8LLUge0Bb1OxwP630ZxOKjdjwkTdToFO0TAUIenbuOah8f0FbWMuOYYGVHqyF2
 Yaa5jSLfrxSluhk7NRjIfHy11G0g1EWvzfN0KRMPA6NDCpij9knebKBxonsU2uI79qlE
 bYGvQTxC/E/RjZvsuTCs//WeY2f05fv4P/uVbfM/mnH1M/y1N5/OuU6e+/vFgwbX/8pp
 Lphs6PBx8q/B5jvZD0HUtOF8sfOF0wsc/ZLPd1Tm7z1DGWMy5rnPCsk0t1f0ZCf4pKUH
 imtqNql7vOUtELUMmLHa2/kMvMwmY8VmFz9vJpWb0GfFzdMWBMbxIg53ZvtI+6CoGwa4
 8omg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776959345; x=1777564145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGW2IDUhE+ABrUpa9VgNBxHuTQxSfnLSg36cSkFMeRM=;
 b=IIH/fNCsQslMNmSCemhubXrn7J+991s5EaF0C8TcG5Tc/dyS6u8osoADDXaMnPnAUc
 LPQ4lCDNBNt/rDvTqToj+pWOOrHEjAAgnuqvkuCUDjq/gZHiAfQVlvkss1/Sj6yKjTz4
 XJNii1BbLFMj+izJMC1GhPEXCky9vH+t2A8Ss2/3EkJbCNR6cRrUcSjZldH3iHfbVOqR
 kLqP/YxbPstNhjT54Xsz6TcG8z6jvQNDu+aUDzZJviScAhIZoO+VC45tWG2LlJMTEUR5
 0DjyhQ1fDmmXFMDqGC57wDRUu8aFMBrfJGHOL6cWdN1U5nf4/Ip4MmbCAHVPa+yfkGWW
 Lgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776959345; x=1777564145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGW2IDUhE+ABrUpa9VgNBxHuTQxSfnLSg36cSkFMeRM=;
 b=VPT7lDrwkR0Imo/0lKKRMQZ4Vw7XQrRvF1nP6NyBFBrWQIczzE5ygxPQEtUJGM9gvW
 rWDkGoDiI1o0lDdTvPVLK40Y+dL1BBO5lsYx1sLXbuq7AUbxHa8COaGu5XxvFtmmRdUl
 SHbZVcBZRMREj8/3kK/pQ7Z3pc2/htCT0Pi+Erp4Gfk78hqvH8jGA/+5aLlxaNq5qOkR
 dmQ/+ihS909shmyilG9n8sm7r5xUe8PR/3c51NwTFzcP2XhPJOpZvng+aRnlCBXTK409
 84D4hLtW2wz1tGoIlEklWSFmN5jQpmUw0CZrf//xGpyR/a0nZ5HSjEB243R4cQ+TEe/S
 6sww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hdDON69UlCL7J0yQt7H8gKEKzGE2asc2PmrGV3yALCHFvsLc8bEdNM4EK1CH1kP9KXyz/SBmeNags@nongnu.org
X-Gm-Message-State: AOJu0YwYIwoPbHlnlb75x7vcrdnBvDJ0LAXt1whh1v211jVjQmx2FOxR
 wwjNTIKuSS9piY9KabiGg1UQ/cymfCbgxQXvjIwpHuPXTKTu0m3c8PQ7XRcCzXwfbxySPyWh5wj
 hQ4rHgY5d9YUJAN0n8LbjXkIJe88Jrmk=
X-Gm-Gg: AeBDieuvyw2+ARYsOKGuLLVim2oVw1/NISyD1TOQP178YXUzXxQIGS8jQqAzlTCDnuN
 HwDD78YXjGXjajv4wMqGNl6geCp8sz90VvpJD3QuKS8LhcLo3yS61gVRBO/dp9RzsAChabV8qwZ
 lkLLV2JsKcrd+dd/xfCFFDdoZM7XwfAJxg6VzHvlfdq/yeGDf6aXgyNaGCbTXepS3e1r8WhN7sF
 p1nbeIlHyMocVKMMkuBMMHOpLY4K54X0pFaZrKaLVf6lcaNiQG4ee3ZXHhAw6FZ4WONO5UDwTqC
 di6E2OnI5bZjLZXYIHQO
X-Received: by 2002:a05:6512:114f:b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a4172dc757mr10192493e87.20.1776959345037; Thu, 23 Apr 2026
 08:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <20260416182527.3862296-1-mattst88@gmail.com>
 <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
 <CAEdQ38Feg8HE-1t-tgDWsvM4LqJvdcm2JMB75SGXVwTwPe-5iw@mail.gmail.com>
 <CAEdQ38Gq4gQE5LGRbAJzMATa_SCJO95-uMdvPNK2NW3=aW1BEA@mail.gmail.com>
 <3fe78350-3ca3-4bef-a1b1-ad5523295145@gmx.de>
In-Reply-To: <3fe78350-3ca3-4bef-a1b1-ad5523295145@gmx.de>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 23 Apr 2026 11:48:53 -0400
X-Gm-Features: AQROBzA8GT5KdRQHIdqncZAiPU7tJRaMaJFIUq6xKJ-FNjMMuE6-4cVCcKey3CM
Message-ID: <CAEdQ38Fr5=cXu1R=B=SEqi0P3atVcSXGH+BOFsRVTmmFwqOcGA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 23, 2026 at 10:54=E2=80=AFAM Helge Deller <deller@gmx.de> wrote=
:
>
> Hi Matt,
>
> On 4/23/26 14:02, Matt Turner wrote:
> > On Mon, Apr 20, 2026 at 4:59=E2=80=AFPM Matt Turner <mattst88@gmail.com=
> wrote:
> >>
> >> On Fri, Apr 17, 2026 at 4:41=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> >>>
> >>> On Thu, 16 Apr 2026 at 19:25, Matt Turner <mattst88@gmail.com> wrote:
> >>>>
> >>>> The kernel's 64-bit signal delivery (signal_64.c) uses:
> >>>>
> >>>>      newsp =3D frame - __SIGNAL_FRAMESIZE
> >>>>
> >>>> while the 32-bit path (signal_32.c) uses:
> >>>>
> >>>>      newsp =3D frame - (__SIGNAL_FRAMESIZE + 16)
> >>>>
> >>>> The extra 16 bytes in the 32-bit case is to place siginfo and uconte=
xt
> >>>> at the same offsets as older kernels (see the comment in signal_32.c=
).
> >>>> The 64-bit rt_sigframe starts with ucontext directly and does not ne=
ed
> >>>> this adjustment.
> >>>>
> >>>> QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
> >>>> for both 32-bit and 64-bit, placing the handler's SP 16 bytes too lo=
w
> >>>> on ppc64. Signal delivery and return still worked because do_rt_sigr=
eturn
> >>>> had the matching wrong offset, but the vDSO DWARF unwind info encode=
s
> >>>> the correct kernel offset. This caused any DWARF unwinder (libunwind=
,
> >>>> libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
> >>>> register values from the signal frame.
> >>>>
> >>>> Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in bo=
th
> >>>> setup_rt_frame and do_rt_sigreturn to match the kernel.
> >>>>
> >>>> This was verified by A/B testing with libunwind's test suite:
> >>>>
> >>>>    ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
> >>>>             and Ltest-sig-context all change from FAIL to PASS.
> >>>>    ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
> >>>>             from FAIL to PASS.
> >>>>
> >>>> Signed-off-by: Matt Turner <mattst88@gmail.com>
> >>>> ---
> >>>>   linux-user/ppc/signal.c | 16 ++++++++++++++--
> >>>>   1 file changed, 14 insertions(+), 2 deletions(-)
> >>>>
> >>>
> >>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> Thanks!
> >>
> >> I sent this to Laurent Vivier <laurent@vivier.eu> since that's what
> >> `get_maintainer.pl` said, but I see that he hasn't committed this
> >> year. Should I wait on him, or can you see that this gets in?
> >>
> >> Also, I think this is probably worth including in the stable
> >> branch(es), so I've cc'd qemu-devel@nongnu.org.
> >>
> >> Matt
> >
> > Sorry to ping. Just trying to get clarity on what I need to do.
>
> I've picked it up into my linux-user-next git tree and will push then
> soon:
>
> https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dhead=
s
>
> Helge

Awesome, thanks Helge!

