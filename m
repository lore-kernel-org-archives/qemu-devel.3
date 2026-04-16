Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0182F8E489
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVLV-0007ib-GD; Thu, 16 Apr 2026 18:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wDRPx-0001cX-6l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:26:21 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wDRPv-00055F-4z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:26:20 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-38e12c67a6fso80366541fa.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776363976; cv=none;
 d=google.com; s=arc-20240605;
 b=KC1maOGqk0ulpyDZzz9xLKOUY39wXO2UsZr88RlyPy0m0x5K08KRet3VHZHWyy9V+x
 nLUtbyqgvFY5BgfqmUv7CKIcQLNJe5GN7d31eaOcfJ1y+SyRWplSgN2OwgBo/uccROxj
 gbG31twB5qvSfMptGX1EssthmUGPqjaTz8Q+fdDefUWyiadxHQ9GsGe/b4UA4zx2/O0+
 rk4aG+46tM4NmoVMWH9pdJ1DC3VGhABHzZFdFPq8bjRSssDvWLM5iUTbGu2w290CzVks
 kORDZsY/VCqyjCISsQqQCSQF4UEQ6FWUIs6IWG8zKhVO4Plm+n0FyrU0DzDt+OtGbJPT
 CAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c1qnHnDC21rc2qnRNXpbQnsnHAND2NNX5H+qjiZpkUI=;
 fh=ol/Wi41AR/5Vq4MHPw05npUxk4Ch5gj+/0nYmuILowI=;
 b=A1DR5xlqmCKlLMPOH3deu6q+FQwUPitqpK1aLi7aSG4/mdNAT6X+KmsrynWYNn/cSq
 9FLUdpyGqckMJyKIs5tSAD3g4lvGxCvoN92LGIwhNf2wr3ItTk6ke2EEpwVw5mnwz97H
 XgXxHlD6AJAyRkQxknF8/tv17+HnVnwgJDKCKXxpjf1TC59Ta45KdXXHCxyjmoq5eQlG
 m35gN6PsCSoQhd/httbFMfcGFkhBWp7DMQ3Xn2XaGrb4D/XB0x/A0418C5U6cSQbTaUb
 WXwDZ0WiwnoT+9HFyea8l9B/+BtJmmfSSaK1n3V1yX9Qf7O5kXgttSF3+kNNIoXExwni
 Ji3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776363976; x=1776968776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1qnHnDC21rc2qnRNXpbQnsnHAND2NNX5H+qjiZpkUI=;
 b=Ah68nYeRoaCnPtnTY1HpfJHPb9w1vCFRWrkXpH7vC/k071CPTscz5RxwsirKAJ0HLR
 dhaWbABd6B1NY88v966T/b5wFX8EgSOS3H2HdjixS4Fulnjyiyzv2NbZBzSwaWT97Jt3
 yVQC+Bi8lYma99prcXtUhWsZQdv/8FDcPF/MEDFupTeSZUce89DR+RZY4Q0wRYF2HpGv
 juCr2ln91JdHMdGUtBMMBnvC0a4XrC+KIQ1xM7jS2Px8CFF9iHpqlPCwei4vGxQG3z3u
 DEpl7eOCFY5A3TN0lqLROEPxk5jyLgjArPYd3SrBiDZoTdBcqujvnknADSE1F40a/2sD
 JtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363976; x=1776968776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c1qnHnDC21rc2qnRNXpbQnsnHAND2NNX5H+qjiZpkUI=;
 b=NYYNh1AAVW+QwVSBMlyhRMSGzlbF/yrYwPleeJmZlhDZT/cebsEnW54mSmVIPEPv5H
 2nWjTPAi+BdCW+sM69jxNUqVO7CFdj+MhyrLZZZyCzW8rIa2QuYkmVEZJtbB7OIImk/N
 2oxVJAp03Y/3cYvy8ItonMNNZl4Tvg4Y/+xMDIrebMEaEkn9re4RMtGBJTxfoNMkuhGU
 Tg+vFxuzrawxBmDRl4SBoeOcrS14kF26wSTnAV1n+3Qw7C7l8Ehd1S/yp5QElCS8He/5
 9/H2H6IcOeZdVsHWG0o24Mc90gd0x1jC2uc6yaR0pq+Okp+WxnCciSvCYzbXodD+4GSg
 gH5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XgqZa8sS8HHAzgnjebUgBYA2S/ZOeeRAGNRjaW09JzXQ+0hIzXb8tD1bMS37MiKJUXt9/rUI1b0kQ@nongnu.org
X-Gm-Message-State: AOJu0Yzfojh3qEiwwBDnTI9FxIFAQenT/eEGYteaelJJpFZt6AjrLYEN
 t77o267yxM+xPWG6cZ0bpOW0JmWM3ZRFRKL4LRr/A/1KmHLGg2eJmKhD0kkpuk0BcDE1FJwzSMH
 aH8CC+J7ziiO2jtPZcjESPozqqmKhcy0=
X-Gm-Gg: AeBDies/iaQ/zBqF2SiKlNQckrmJH0FCGQDVIbHQT0aBZiVi/oODHe7z2TMJesPXa2R
 PTby35hKXKgu/k1qtyXumeLP9Mt+NUXYa/AJpRYQjnl9UAoHx/Gh0q5jfcQRGWhT47rIdkwqSa7
 33LW+73hnkBd/FkyzM82mYXxWRDfqiD3WnBNTlS6gqjtwCPAfYf2H9AcssNGfrMiCJ94f3JGL8O
 LAvq3aZLDZv3h09srCSzP7cey/QfqM6oTLfhgMAp6bjfQ29RKoF2N+cPe5wP6QS9fJhSv40+FnN
 YW1B9vU7lWs2tCk=
X-Received: by 2002:a2e:a994:0:b0:38e:ae31:f0ae with SMTP id
 38308e7fff4ca-38ec530d74bmr502741fa.0.1776363976046; Thu, 16 Apr 2026
 11:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <CAFEAcA_PZ2RWNNrBoM0nzOrDZZ36p2sMOviT_NeRXWdab=6T+Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_PZ2RWNNrBoM0nzOrDZZ36p2sMOviT_NeRXWdab=6T+Q@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 16 Apr 2026 14:26:04 -0400
X-Gm-Features: AQROBzDrlK588kunGkzaTLgd6gXff6-gLp6dQQ74oztKK0dGfrcqIreooFssO2A
Message-ID: <CAEdQ38Gc0ov68Lkvm-Mzk=71yGkBv_FEOM5sfV7urLfCWp1t7g@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 18:37:54 -0400
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

On Thu, Apr 16, 2026 at 10:19=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Tue, 14 Apr 2026 at 18:27, Matt Turner <mattst88@gmail.com> wrote:
> >
> > The kernel's 64-bit signal delivery (signal_64.c) uses:
> >
> >     newsp =3D frame - __SIGNAL_FRAMESIZE
> >
> > while the 32-bit path (signal_32.c) uses:
> >
> >     newsp =3D frame - (__SIGNAL_FRAMESIZE + 16)
> >
> > The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
> > at the same offsets as older kernels (see the comment in signal_32.c).
> > The 64-bit rt_sigframe starts with ucontext directly and does not need
> > this adjustment.
> >
> > QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
> > for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
> > on ppc64. Signal delivery and return still worked because do_rt_sigretu=
rn
> > had the matching wrong offset, but the vDSO DWARF unwind info encodes
> > the correct kernel offset. This caused any DWARF unwinder (libunwind,
> > libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
> > register values from the signal frame.
> >
> > Guard the +16 with #if !defined(TARGET_PPC64) in both setup_rt_frame
> > and do_rt_sigreturn to match the kernel.
> >
> > This was verified by A/B testing with libunwind's test suite:
> >
> >   ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
> >            and Ltest-sig-context all change from FAIL to PASS.
> >   ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
> >            from FAIL to PASS.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  linux-user/ppc/signal.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
> > index 24e5a02a78..b21aa2430e 100644
> > --- ./linux-user/ppc/signal.c
> > +++ ./linux-user/ppc/signal.c
> > @@ -525,7 +525,15 @@ void setup_rt_frame(int sig, struct target_sigacti=
on *ka,
> >      env->fpscr =3D 0;
> >
> >      /* Create a stack frame for the caller of the handler.  */
> > +#if defined(TARGET_PPC64)
> > +    newsp =3D rt_sf_addr - SIGNAL_FRAMESIZE;
> > +#else
> > +    /*
> > +     * The +16 is to get the siginfo and ucontext in the same position=
s
> > +     * as in older kernels. See Linux's arch/powerpc/kernel/signal_32.=
c.
> > +     */
> >      newsp =3D rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
> > +#endif
> >      err |=3D put_user(env->gpr[1], newsp, target_ulong);
> >
> >      if (err)
> > @@ -641,7 +649,11 @@ long do_rt_sigreturn(CPUPPCState *env)
> >      struct target_rt_sigframe *rt_sf =3D NULL;
> >      target_ulong rt_sf_addr;
> >
> > +#if defined(TARGET_PPC64)
> > +    rt_sf_addr =3D env->gpr[1] + SIGNAL_FRAMESIZE;
> > +#else
> >      rt_sf_addr =3D env->gpr[1] + SIGNAL_FRAMESIZE + 16;
> > +#endif
> >      if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
> >          goto sigsegv;
>
> Thanks for this patch; comparing against the kernel code QEMU is
> definitely wrong here.
>
>
> I think I would prefer it if we avoided the in-code ifdefs
> and instead had something like this defined at the top of
> the file, e.g. below the target_rt_sigframe definition:
>
> #ifdef TARGET_PPC64
> #define RT_SIGFRAME_ADJUST 0
> #else
> /*
>  * For 32-bit rt sigframes we have an extra 16 bytes of gap
>  * on top of __SIGNAL_FRAMESIZE; this is to get the siginfo
>  * and ucontext in the same positions as in older kernels.
>  * See Linux's arch/powerpc/kernel/signal_32.c.
>  */
> #define RT_SIGFRAME_ADJUST 16
> #endif
>
> Then we can have the code unconditionally do
>    newsp =3D rt_sf_addr - (SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST);
> etc.
>
> thanks
> -- PMM

Thanks Peter! That is definitely a lot cleaner. I've sent a revised patch.

