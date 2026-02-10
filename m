Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D814EB2705
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 19:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vptMr-0000jw-4s; Tue, 10 Feb 2026 14:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vptMf-0000jB-9Z
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:25:37 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vptMd-0003Xt-Fx
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:25:36 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-505d3baf1a7so48391cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 11:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770751533; cv=none;
 d=google.com; s=arc-20240605;
 b=HLH0db+wQvR+2+b3JbXaPyzPzfL3aJW8711q0eDuLA9ZXcREYqNY8Z1Esqmy/goMKf
 fApQE2PC5+3zqOGjmdrueHwvNdncyFGStSLFRNBBIGlpM5He+BPqNgb85gpd+em+ofgK
 h3iSBBYzGhu8os4GP0DEPZNQpDUgJT2GD6HcCwejoMPQybM+QcYPKLIdgigdrcpNmuYj
 ucUiTthvhzquBYV/slQiFBS2xtu5DSMwd6SDolJN3LZlTz9MxsiDmuFUtQj7MBgbJ9Ph
 syEIa78UdcC0jxFc8qT2oYfDxqGzCG2HdXofOwNi597PZg9/yM6jLkkJ0gh+BAFYEIz1
 MZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IYXaxxlBgc8Kqkh4DZ+jrMOV88/UOIu8btwWCvjGJBs=;
 fh=P3Dm9LZuEo0LHY52zz8EmUqeQRAXmTXFgTurHEaky60=;
 b=R06jguas4PblLaE0f+IrSjfKAEuh42itzLW35Q/fi79o0kIxV9puww+YU+uN1Xxf/K
 HARaj4X6UD8UhyP+Rr4n2VwYgG3tXqRRfSBe5NLwPnJGeWdVH+xpKP82uTQ4m/SNj6I+
 Dyldoz+eM2TIr8wBgMF3tLpGYLnxXZJOTTibxid0kDzdusklx4rq0XfNwVwlGpEpC4q0
 r5RM3KLKmelu3+vA2CFmUDVdVBRxx3Tl2f0kfcIisAxyDXVQv565E6rmq4vBHU6hmilG
 WR7AXaHO/DwAaBV7BBWXSchDlX3upONg3vydekRKPdNgS4hVYd4qwmFqWSkfhwV4lLLK
 Xgrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1770751533; x=1771356333; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYXaxxlBgc8Kqkh4DZ+jrMOV88/UOIu8btwWCvjGJBs=;
 b=t28JaZymDK/yIzfrCNQhM0QeRbwOcDsSwhbwSz+LVh5keZY3GojcqvvEHKndwbAdC4
 gRbsoGulWm0uQ1heUJ+2xLXqkKpTOvxHNonau8BucMPKq0inhQonvXtWoJu02DyZU5u0
 v6cRqOTjtrI0JiSb2yG23hyhd+yWuz6B6GgTAINmRSvRdG12DN3xypMsW46K5pJjfmZi
 vEr3HUsX/nRHDgdN0e4VEhk/dWVAAqt1qpAVDDTNgHgD9B7oE8M2yEp+aDTXpqAcdKIX
 oLxH9FuNpEUb/Ae8Ig0iSyyRUgggSda0wwtHfuugfk4ARxlhdZZXA6g73o+f34HLOhLy
 OpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770751533; x=1771356333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYXaxxlBgc8Kqkh4DZ+jrMOV88/UOIu8btwWCvjGJBs=;
 b=iPNxVLq/fXSBCu2lxG0lp5woTqX4s63WDQMenL1EiOppuKXL11EEeolZ/We+oBHkX4
 cvqXzCyHZkfA8lEu0nnskLXdykzix1sq0gaEQSCXWg5z45Ed52rEHAMucOJYPehxPT6y
 hE9e5+5gYb2ZgarZFb8HbqmsFq5OFw1qirzd5SJaETZWeN4cSAbs+kA2IjKn0Kytv1SP
 vbSogWt3dwwUdxYMhQAV4LaTnrbuuUNzHo4fKTENY1irkFSkkLgd+MJoYJ8DxIWYwgMF
 o2kADszPt/PKfEpwZuuvEoyLCMYDWFX3KsJilb1ELhRhAtrZpnubseEt31lmSR9UZw//
 BxOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyvx+qOaGNgBaJu1RLMyDtLJuKRii6BbxaapsYSPQg3DLFs2Ui1kQdrGvGP9FuIdUklMFyim+UHIpj@nongnu.org
X-Gm-Message-State: AOJu0YwBthprn7ELAwa7LrR2oBWayFFdx0VQJoezh2FHub+K8JpXyvCh
 /WOoo8jUKj+0jRNa2Zz/MYptunB9QkAxhjBrtwROFjppedQRuuAhcpkZDoB7KGRJswstGUgMM47
 Xv3pYwI5XWsso5mfn5DjqfhRN0SdtXqiuCd7AAwbI
X-Gm-Gg: AZuq6aL+qNiKOphlJpxSx9cSVX7ehKPGY4YkkHr0otOMQSlWBnzCTpJ2QFOoyzvn7nK
 aM+GTvQ6yMWs8YbwsNSps+pHihnMgKQ3mtejrrQOUll89x6bjMHmBSPk6qL6vinF5pV/ecX8M54
 35z0mTZn/ZFmG5V790iUS6+B5pHSwTfr9IoG9pzaj3lJLfRVerH/5d7wZVtY5gcXQ8FhZ52e5uo
 S+ZT8Ae3VI8AypF3SNaPYYzCzD5v7LeXAe5IGOvuyd0Y8CgkeFjC65BTX8B5NTIPjAWr7gRI40K
 gLcykm/WclNKBD/+ohyn8oJ6htljFObBLadfpSVr6EHx1AoE5JeO2Ga+R2DzOJvGUAAy5O2w784
 oPVr40YZ7MO/2uAQyA1on4xLZkYc/Kgz+nh6z
X-Received: by 2002:a05:622a:181e:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-50681698b91mr1199401cf.9.1770751532817; Tue, 10 Feb 2026
 11:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
 <20260210051008.355149-4-jamin_lin@aspeedtech.com>
 <209dc94c-080b-49fa-afd0-d89d43b318e6@kaod.org>
In-Reply-To: <209dc94c-080b-49fa-afd0-d89d43b318e6@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Tue, 10 Feb 2026 11:25:21 -0800
X-Gm-Features: AZwV_QiXX0lIrUovR96uGyKhGgKuHxyY0dsqY6eriDCvxKbghRyk07xLJ9lR-Ng
Message-ID: <CA+QoejU4FBKwUEK2FCVmdLydjBcCKvtGdLq=1GxBHXOEAGYSVQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 9, 2026 at 11:14=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 2/10/26 06:10, Jamin Lin wrote:
> > AST2700 A2 is functionally identical to AST2700 A1.
> > There are no changes to the IRQ layout, memory map, or peripheral
> > configuration. The only difference is the silicon revision.
> >
> > This commit introduces a dedicated AST2700 A2 SoC type by reusing
> > the existing AST2700 A1 implementation and setting the A2 silicon
> > revision accordingly.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >   hw/arm/aspeed_ast27x0.c | 36 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> >
> > diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> > index 61790ea1cc..87dcb82e1b 100644
> > --- a/hw/arm/aspeed_ast27x0.c
> > +++ b/hw/arm/aspeed_ast27x0.c
> > @@ -1166,6 +1166,36 @@ static void aspeed_soc_ast2700a1_class_init(Obje=
ctClass *oc, const void *data)
> >       sc->memmap       =3D aspeed_soc_ast2700_memmap;
> >   }
> >
> > +static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const voi=
d *data)
> > +{
> > +    static const char * const valid_cpu_types[] =3D {
> > +        ARM_CPU_TYPE_NAME("cortex-a35"),
> > +        NULL
> > +    };
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);
> > +
> > +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> > +    dc->user_creatable =3D false;
> > +    dc->realize      =3D aspeed_soc_ast2700_realize;
> > +
> > +    sc->valid_cpu_types =3D valid_cpu_types;
> > +    sc->silicon_rev  =3D AST2700_A2_SILICON_REV;
> > +    sc->sram_size    =3D 0x20000;
> > +    sc->pcie_num     =3D 3;
> > +    sc->spis_num     =3D 3;
> > +    sc->sgpio_num    =3D 2;
> > +    sc->ehcis_num    =3D 4;
> > +    sc->wdts_num     =3D 8;
> > +    sc->macs_num     =3D 3;
> > +    sc->uarts_num    =3D 13;
> > +    sc->num_cpus     =3D 4;
> > +    sc->ioexp_num    =3D 2;
> > +    sc->uarts_base   =3D ASPEED_DEV_UART0;
> > +    sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;
> > +    sc->memmap       =3D aspeed_soc_ast2700_memmap;
> > +}
> > +
> >   static const TypeInfo aspeed_soc_ast27x0_types[] =3D {
> >       {
> >           .name           =3D TYPE_ASPEED27X0_SOC,
> > @@ -1179,6 +1209,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[]=
 =3D {
> >           .instance_init  =3D aspeed_soc_ast2700_init,
> >           .class_init     =3D aspeed_soc_ast2700a1_class_init,
> >       },
> > +    {
> > +        .name           =3D "ast2700-a2",
> > +        .parent         =3D TYPE_ASPEED27X0_SOC,
> > +        .instance_init  =3D aspeed_soc_ast2700_init,
> > +        .class_init     =3D aspeed_soc_ast2700a2_class_init,
> > +    },
> >   };
> >
> >   DEFINE_TYPES(aspeed_soc_ast27x0_types)
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
Technically applies to the whole patchset, but specifically pointing
our internal machines to use this SoC so sending it to the relevant
patch.
Machines boot and work as intended once the SoC is updated, thank you Jamin=
!

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

