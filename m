Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B805BC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzACi-0005sY-2G; Wed, 26 Aug 2026 05:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzACg-0005sI-4g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzACe-0004wp-G9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787737551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlUHdXH61ncwf5GH6+xG/yQWCuGPjcYaS/N6DUomxlE=;
 b=XHIc/SwDEjgfb1EGvt79DvRVO9d1ItTvGB7olDsg2f+3gdCABLdcmuf8aiIXCYovlxPW9Z
 U1l7BGm9e3rCVQEezBPaCRFME0DS58iavUyrnTbVoEyaNP21D4LGfsoJw+vlRFnXSjnN58
 Am8CNoepvN7GgZ5GW/0VfCA2TLdsH8c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-PAbW-yCLNPaFSANS8K0eHg-1; Wed, 26 Aug 2026 05:45:48 -0400
X-MC-Unique: PAbW-yCLNPaFSANS8K0eHg-1
X-Mimecast-MFC-AGG-ID: PAbW-yCLNPaFSANS8K0eHg_1787737548
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso1035459a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 02:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737548; cv=none;
 d=google.com; s=arc-20260327;
 b=pDqKCX3PcSdSfmLqBSaLg/kRBCB9ziKoQSTOa2RgDfQCbGct87Lx9xD9HDKllRoI3d
 GVXo/O14ysfu+ytnItAymBI7ilsBl/a696jThj6LyuoS1Tg19BL6E8/CiOvecA5WU/cb
 vhJFAslMATBcBwZhIjJ3v14jd3jnwEbdnZ3aXznyDllI0ybhMRizySVC/xESnZ/tlKMU
 0CmJ49YvJWI3Io9EJu77ws1aepevDsOnT6z3gNR/bAc8KddPBT1chlwZygCNNU5AIjYY
 bavOl1XFjpJ6P32fKRwTiBn7+RZyps64JHuk5VyAwCLKOPRmA+14hox2CiJrsXaHdVlj
 tCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vlUHdXH61ncwf5GH6+xG/yQWCuGPjcYaS/N6DUomxlE=;
 fh=Og1TQmVLtMvUTWWOKmFKDb9FeJ/3Zt1NhSWtwzUTl8w=;
 b=OvRZXzG4yaGJucbIvkTejMn2kIHs++NIolKlHrIdw33Mka4iDcHmonXVQFBJ5BJDFa
 VlOWKmzWqs1sAzEqEJ97bh/sJN3IDwWocItrrgSlHgGCbv9MB9zuz6VcCWELuhTi7gnE
 iDXwu15eTL0dVJ1vXv7W76VYx8OCSJphl4jMAn5yn3J0FaStkVs3ZA7+Kg3Kl6dr14ly
 oFlsWoc1EqTgGwIDy5DdFDv8AyAiZGjA3X6BYUfy5rjtiMEY0RpUSmpQv8kFLvwDj26m
 vNAqK30HwrkUOD3Ql/0Ol8+MzjCrtHDspalSmTodXLaomf7/aQrBQGP+XSmw87SJjReX
 pqDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787737548; x=1788342348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vlUHdXH61ncwf5GH6+xG/yQWCuGPjcYaS/N6DUomxlE=;
 b=btghiv0fcHiZkEt+pLj9anp2pa4VdFEYbbrq/xPIydczjXyq6Zzn+In6eMtB4rSQYR
 ONcSNapbGkfMKLs1KWhikL+v7P0VGWkTYf14c4/hgZ10j02Gm2Fb92+GRm/5XKsJ+4xT
 hyOC21Sk6hcnY0+S7TKO5jBjiWSwPPrxwZB+H/3NI+MLJBaNaFd9x1M0Ifk8ETreuFMv
 ZXllJgl4/krYyt0Ruk7gcqRnWTTL55plcYjkZ6PBPSwQWLNNcKO6KhhnGoPQojt+T9vq
 aLdxbVAXs5Qjgvv58IIzf+Ls3a11ldjYCEFiuza2GadS3OsKR7jWlSTH7SEBleYbvSCv
 eX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787737548; x=1788342348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vlUHdXH61ncwf5GH6+xG/yQWCuGPjcYaS/N6DUomxlE=;
 b=kmeVT03+WHZRF8GhLoR0v6r66d1XHLXjaH6TJ4bQreCZXNQNInSEXncgARkLrkkz4v
 2aZOO37VF6zWad5jPKmogiZwM77VMNAZcHaazYpUEUyZBoUJr5EMVJfO43z86vO5wUT1
 wvMLual3mG7Ay7JQqx4rnYdBBx7jirC16xhQ9kpyEHZJzZ9RDgpiFhVlyDv5GT1hhHGE
 PztInMtXIi++jdGRmElVNXDhGmJgdlnKWkdHkGRWAr0ujeSiEoNrKHH2BkKccsI+w25a
 uol4ws73FpuvPdtgksezR9fUjhTBcYypgPJe2t3T0IERH2YvJp+wiVIPLp+74ksy4086
 dfYQ==
X-Gm-Message-State: AFuF++lCV+0rnztuFqoPwEtiHe7xfaP0oMGbPtmOREXg/osqmh9iCRfO
 ska9WN28mXb0FJS7kWM6XOLGOByBNgxYjJFBMIaBhF/T85pDyoGDloz+cUfDVwg+aTegz84e+I0
 pwb6B1WFXwjvRQcCAHhvGV1T42fLaDgu4xn78POfvMvazLy/qjm/nDYb+T+kowJZy65yDmchAzW
 o9756+/QtXof8G082KOogMxTBckfOdu1g=
X-Gm-Gg: AR+sD10Rm372tH6ZyqmQGPPJan61HCBBUoVj/nR1QGwNgg8XIP1vQhXfUtkjR9gw6xm
 IcoRHm0YQ0JpRjh4oZ2jV8CkRqS/uL949Hb02IWg51EWMpqqEaHGqEG1+C45yfckTYtEIlWvd7Y
 7wOMJEXTYSruk7hZwiEiPerY6jen/Ml/AcJaoi/soJ1rbevarPgnGt4+MI2VCothu+D6rZM0uS8
 QZjat04OfqoP6SlkHRC2wEk+RxLui6MLBiHf4RM88XIwO33u/boE0CSJJll4Yz2B/FKs302oJ5F
 +g==
X-Received: by 2002:a05:6a20:3ca5:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3cf786ca774mr8824002637.8.1787737547750; 
 Wed, 26 Aug 2026 02:45:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca5:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3cf786ca774mr8823936637.8.1787737547353; Wed, 26 Aug 2026
 02:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-39-af60857c2fbe@redhat.com>
 <ao6rvUMqwEGdW_v3@redhat.com>
In-Reply-To: <ao6rvUMqwEGdW_v3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 13:45:35 +0400
X-Gm-Features: AcwNN1UgH1mUi6a-c6uZ53EjSr0uVyyGE75kYlQVFXzTRNJXZtJsi902UZmSdBg
Message-ID: <CAMxuvaxPBUOJt9EYZ=58yBBEw5fjv8G3YG_mN+xyeycok4dYUg@mail.gmail.com>
Subject: Re: [PATCH v4 39/49] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Aug 26, 2026 at 1:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Aug 25, 2026 at 11:09:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Make the 'readline' value of MonitorMode and the
> > 'human-monitor-command' command conditional on CONFIG_HMP, so
> > they are only available when HMP support is compiled in.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor/monitor.c  | 8 +++++++-
> >  monitor/qmp-cmds.c | 2 ++
> >  qapi/control.json  | 4 +++-
> >  qapi/misc.json     | 3 ++-
> >  4 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index da76e6e4ac19..da0c8eda86b0 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -740,13 +740,18 @@ int monitor_new(MonitorOptions *opts, bool allow_=
hmp, Error **errp)
> >      ERRP_GUARD();
> >
> >      if (!opts->has_mode) {
> > -        opts->mode =3D allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MOD=
E_CONTROL;
> > +        opts->mode =3D
> > +#ifdef CONFIG_HMP
> > +            allow_hmp ? MONITOR_MODE_READLINE :
> > +#endif
> > +            MONITOR_MODE_CONTROL;
> >      }
>
> This introduces a public facing semantic change.
>
> Currently
>
>   qemu-system-x86_64 -chardev stdio,id=3Dfoo  -mon chardev=3Dfoo
>
> will always result in an HMP monitor.
>
> With the new code, this may result in either an HMP or a QMP
> monitor, depending on whether QEMU was built with CONFIG_HMP
> set or not. This is bad semantics as HMP/QMP are completely
> different things to talk to and not transparently replaceable
> with each other.
>
> IMHO  it needs to be:
>
>    if (!opts->has_mode) {
> #ifdef CONFIG_HMP
>      if (allow_hmp) {
>         error_setg(errp, "HMP support is not built in this QEMU");
>         return -1;
>      }
>      opts->mode =3D MONITOR_MODE_CONTROL;
> #else
>      opts->mode =3D allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONT=
ROL;
> #endif
>   }
>

Agree, thanks

>
> >      switch (opts->mode) {
> >      case MONITOR_MODE_CONTROL:
> >          monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
> >          break;
> > +#ifdef CONFIG_HMP
> >      case MONITOR_MODE_READLINE:
> >          if (!allow_hmp) {
> >              error_setg(errp, "Only QMP is supported");
> > @@ -758,6 +763,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hm=
p, Error **errp)
> >          }
> >          monitor_new_hmp(opts->id, opts->chardev, true, errp);
> >          break;
> > +#endif /* CONFIG_HMP */
> >      default:
> >          g_assert_not_reached();
> >      }
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


