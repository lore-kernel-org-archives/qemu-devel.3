Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC96F9937B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFslr-0007WG-9l; Thu, 23 Apr 2026 08:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wFsle-0007Oo-3N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:02:51 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wFslX-0000Zb-Jg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:02:49 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a40d02b58bso5772228e87.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776945760; cv=none;
 d=google.com; s=arc-20240605;
 b=cMX9d1LbcOWmO/CHlpnDv4gBo1eSkAs+e0UKw1yNLgGnlGEC5SPya1h+xwvyb8MRdZ
 R1/1mEvY1gWqllD3VrB6IJlPNJcDgNiOaKnYuIOqErsGGz1wuOA6SCRsxqLzoFagA6BV
 5JVkIsEztvmqHkz/Hezu/lTwExvDRPDsZRO+bqQqKertmk5dw5lPxvopMjKepqos7UMX
 OqYqLHthFx26tBxkHhuL6Xb+sS9ocAyBSBw8KYnysPXQYS06SYDM1ysaXHYwCclRvKA3
 BMBD8W77zfZruCErdhsF0UXjyNGQvHfgt1NvGXmiUtf4R74pTb60qxmLdvFEFSZ4cfnl
 KvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NzVh/cBgjWC9kOU+kix3on+RvApBH0lzD3fytnV1v+A=;
 fh=pEwryevTYCvJExDvFgEAwQ8ak6O4Ws2Czwn20gv/uj0=;
 b=SK8USAJvDQLJI/8tXZRHmbpxUBPD3/AKbP9yP9oaSgF0AI2qfKGRQt/S1BLTnN+U1p
 vKVoyP3M0HbNIAbB/Lqhe0TdRmIt3MF5Iz1yEvH25JXde6J+8U0ClxQhmXEUTIOa2mu8
 YdzLqtVsjTr3CQbIVla9+znAUTlze3o6gaiWlrYUbTDKh2r8MS3TZF54y1If2TrFt5Ne
 riIBy7mCRU3lnCzQaKm3YRkO5QHqQXLWEKx67VG1eKAOQpfH4k6Vh2xMbW69KkPkblH8
 Tsgbi0Qp7X5MulC7+x67W2Zcg2DjyyWPVSxBsq2D8J1xy124uO/FkubAgvO0vlXbEkah
 4LCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776945760; x=1777550560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzVh/cBgjWC9kOU+kix3on+RvApBH0lzD3fytnV1v+A=;
 b=OPOYcdju+aMntgwRu5im9ALhK+7zbPkS2EjPX+a5pSPxmFC2YQJPXeAgbcnhQPgfWq
 42DAXAPJsml0HeRCoKcg7g5eYH8gwCA7gXICQ9t8cSRm6BvtSOf9v6/Lc4IVE6ASlFKq
 xB+O+IAW0Ja6/DGsXosCO/TAte4Z3F/LvV+gKIwRodW2MxW6+wM5gyjOQBdp9LAzrf62
 OguzDlze++i3D9SaAwPooyPXPwRaPiqnOaJjFumdwMigcsd6xM8dksUg8HFZZZHERoWd
 0HhU1Jf24MxlKv+6UbYdTrSS3weJfa+NlqKRqMM3XWnnmcsA9DqqrBRwK2YS7pszP35W
 xRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776945760; x=1777550560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NzVh/cBgjWC9kOU+kix3on+RvApBH0lzD3fytnV1v+A=;
 b=ndgyr3PBMoPNRrq3tpx8YixhrgCpS/4wp8odt3MJzTGWf4X7FyTDVaxEMnhu0LsR3a
 Qbn39nv9j20eQUKjwR/9kiQN3SCyZwJrKbwwwXjRZcQoNLaulFTUVlr/XK0II7vUr+To
 1QF/5tzILKgsBu4WodxQePaOSIZbXF3s0MvWM8zvlUIinbmevqvyEDyrPMIicd4iuHm5
 exi4OiZMsaYnoYrhCUyZnQ17JePhyke84ETMsxO7mfEO8aQMbj1EnIp79jACx9qC0/ZV
 d5iXUbBu1VMvlPYlwMbPWLDXMYvR/MoP4OL73DtJPdbwR6+uR+l5Hnumpa7j7+e6XWCU
 jyAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ThSbuzr8jtljfguLiCV4V0B8Z6bkuY4Og3oewyCCJ4ZJ2TVoIPlXqpIAPbF22vKdtyLurJjThxpR0@nongnu.org
X-Gm-Message-State: AOJu0YwgVd0UUZ6sb/hP66o54y/4CIBSlm1u9dv9u9VeVCiRdpCemmhb
 ovmao8HWvbPzQSrxs1Nz5nxZS+CK7wmVGJuBwLIttiyKZjN9BeWtFMGb0LfyYK3h1OKCjYghBEm
 53qJ+bsPPr5VVihzMC34SbixPuiID5yk=
X-Gm-Gg: AeBDiesV/MKC3xYMIKBlrmNiYKAtHaf3amAZfkYeYSGmy7id/D6egGQnfRljf2FpXdc
 t4cgaIb59SKzNFCgoYpMyU97fDa2ns6OwDNpTuspbL4dXu7McHHV1Lzgm9u6+ngFqepmrDEv0Gn
 pLlcyZziLwDLhqKXAWDEv/K7InA68DOLqhK4ApIM3xX7psbbGqru075MSUzOMyJ36GbcpEwcBz/
 /KGS2W2bPRoZuGAQuiAQfrhvTrr4NT6HruLNaPF3GT7nzWE1ob6kVNrblJ8dImu7LQ2YuJ1/8HF
 tomXjSVuta+RtAg//PF4
X-Received: by 2002:a05:6512:3d20:b0:5a2:b0ba:7169 with SMTP id
 2adb3069b0e04-5a4172e2901mr10031806e87.38.1776945758281; Thu, 23 Apr 2026
 05:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <20260416182527.3862296-1-mattst88@gmail.com>
 <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
 <CAEdQ38Feg8HE-1t-tgDWsvM4LqJvdcm2JMB75SGXVwTwPe-5iw@mail.gmail.com>
In-Reply-To: <CAEdQ38Feg8HE-1t-tgDWsvM4LqJvdcm2JMB75SGXVwTwPe-5iw@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 23 Apr 2026 08:02:26 -0400
X-Gm-Features: AQROBzDFYIowAhaT48rXdZkVGQXwPXnk1kd9tynqs1bWaKNMxXR4VGdWsQnQkKI
Message-ID: <CAEdQ38Gq4gQE5LGRbAJzMATa_SCJO95-uMdvPNK2NW3=aW1BEA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Apr 20, 2026 at 4:59=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Fri, Apr 17, 2026 at 4:41=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 16 Apr 2026 at 19:25, Matt Turner <mattst88@gmail.com> wrote:
> > >
> > > The kernel's 64-bit signal delivery (signal_64.c) uses:
> > >
> > >     newsp =3D frame - __SIGNAL_FRAMESIZE
> > >
> > > while the 32-bit path (signal_32.c) uses:
> > >
> > >     newsp =3D frame - (__SIGNAL_FRAMESIZE + 16)
> > >
> > > The extra 16 bytes in the 32-bit case is to place siginfo and ucontex=
t
> > > at the same offsets as older kernels (see the comment in signal_32.c)=
.
> > > The 64-bit rt_sigframe starts with ucontext directly and does not nee=
d
> > > this adjustment.
> > >
> > > QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
> > > for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
> > > on ppc64. Signal delivery and return still worked because do_rt_sigre=
turn
> > > had the matching wrong offset, but the vDSO DWARF unwind info encodes
> > > the correct kernel offset. This caused any DWARF unwinder (libunwind,
> > > libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
> > > register values from the signal frame.
> > >
> > > Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in bot=
h
> > > setup_rt_frame and do_rt_sigreturn to match the kernel.
> > >
> > > This was verified by A/B testing with libunwind's test suite:
> > >
> > >   ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
> > >            and Ltest-sig-context all change from FAIL to PASS.
> > >   ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
> > >            from FAIL to PASS.
> > >
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > >  linux-user/ppc/signal.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Thanks!
>
> I sent this to Laurent Vivier <laurent@vivier.eu> since that's what
> `get_maintainer.pl` said, but I see that he hasn't committed this
> year. Should I wait on him, or can you see that this gets in?
>
> Also, I think this is probably worth including in the stable
> branch(es), so I've cc'd qemu-devel@nongnu.org.
>
> Matt

Sorry to ping. Just trying to get clarity on what I need to do.

