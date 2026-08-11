Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF4C5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthgq-0008GT-PI; Tue, 11 Aug 2026 04:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wthgn-0008Fd-9o
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wthgf-0006Dm-Jd
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786436296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=735p+6x93xdXdGaezmkO34/tcdDshLx/IzvhZxop9uY=;
 b=Ks/srZkZfXH60+RrzaNMj1twRKR5bRFZVlryTZbE4FMEYsA4DI6VpJ3bOWNReIJy1UhgtC
 B+0zAucLWVbtVBeXT3V740bi8j0ssm7tnOqXS76BTvZJxOCRpYfFN4JmKsyL52/0Pxs+f5
 LdZ7K/DVFaPHJtPOTyH4N1xwkwOUaRQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-G9l0QBUPNdmeNOisvEd4YA-1; Tue, 11 Aug 2026 04:18:15 -0400
X-MC-Unique: G9l0QBUPNdmeNOisvEd4YA-1
X-Mimecast-MFC-AGG-ID: G9l0QBUPNdmeNOisvEd4YA_1786436294
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb4cdf95b5aso5484599a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786436294; cv=none;
 d=google.com; s=arc-20260327;
 b=svnw+kRt91fuRXLPi6KF3RgN7F8AUWRT5D3Cilq4+3lcJMFAuHOsQrLppxPWrfsvdE
 pTw+4aYp51LWNGSwMsG6KTu3giNcGagvwFpXKURH3s4yHiz6EANcZITYjqrthPC2PzzF
 SnmOsFEypvT6vBT2nQSdStLYQjqnAgBuY/9kacw37TMA/Y9C6lRpQNK3X/O3TuR6tnIv
 iQHVtAnmr+rBEzRdG5mexRMio/kyhk7J90Tb8d8xScxt+0lkgXwKz2bN5hQ7eW1K2zZY
 U6JkNsYsPOzBOrEtWnzkcykjPHViiAt+zDo/sbZ8c5tqElB/4WE2zTCLqTRfm8r5A5aE
 jqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=735p+6x93xdXdGaezmkO34/tcdDshLx/IzvhZxop9uY=;
 fh=clj/N3aH4K/xfvVAs99VTHE3zWNs21ViYr0khAbs26E=;
 b=JYPhpywIPOVx5eFw7mrVGVEGuCgptLxsEpvrcDfj4sFOzZu+GeQGyoll1zJ1moKByw
 hdPlqmHk9qjr1EzKb0441cX04W2AMM/bB5IEWokxthhIUWY9mCxq1R/3uLlSTqs6qD1H
 4uY8WITFWWqv7PH329ZTdqeJy6qp45Qz724E0CZEUlGoM0A2u5y/C0rz5PWv8ZraetJ/
 oDAM2KuRJcqAAnipF5bDvwCI9CGQmE9EEdFyefgnABeRsWcO15SP4DBSnpkRRydxGLfd
 K6EqYicQRVNTDkRq9sWrXUFRwA94gM/2t7znjW3JUt7aypygbp9EyLIP72h7ANKgI6i6
 n3aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786436294; x=1787041094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=735p+6x93xdXdGaezmkO34/tcdDshLx/IzvhZxop9uY=;
 b=eSGzefbgUCAFIaBstZ82dyEp7qpabGdrxrIhI09DeSblUc+urMDggGruCFw+FNvtxQ
 eqE38l3M3Y/mb7mqRPvFd/o1tJRYUvVPY7n0GKyeH3LskRQtjjGkqdly1sQ5bScV0CIJ
 56VBAijKCjLUIWKPPf0s8vJe4R27Myy7eH89VtDTzSeMYXQT8daptNCCQ/dBmuSOK4lE
 iGrYMYoKvcXBRByDt5QHaFzMAjwNjq1w1Yy7Y/7TAzwfGcvUCx0WlWMuqvI44q0qoDhK
 t4ZJ9gvi5GcI+3KNMRbtJTgNix6CY9KwRY3Rzn8eV+q1SlHvsjJXJO6NHGpxinxHyXUh
 4vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786436294; x=1787041094;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=735p+6x93xdXdGaezmkO34/tcdDshLx/IzvhZxop9uY=;
 b=XpcnFZyD52Fp4cTy0bj2CSlgBk4p8r/P+mKZSIbBKxNthUQ3OtF67wQxHgqgIuMh7a
 raHDcT812iZJYqf3EMSkSbNsl9MiQ4QaAipyx1OBzJLsBNHzXBBv1EsF+Z6yIBYiAFJl
 JEiz5eYSJcBb4Zg4oprPA4344HLpKLjAeUMlIDtPBV4+19TwrRaTzKhNRgCz8ijIoATi
 fGs+u5VDHPyiTMRaOeHpDw2eucDn2PltoenOQj0hCsJFgm2lPjwxibHT+CO/89DB9FDH
 YiKRd9d1R81Da2aPSRfc+3wtoUkpAU7SW8QQDe5nuSaAAykKqNNuuZ5DL7/SueuwYIID
 Qg8A==
X-Gm-Message-State: AOJu0YwX8TLww0NzzXEuA4RF3BOY37Npqb97G/mjF4QbRjThh00K38uD
 OBJ8QSZeFtJwsy8YGkA2epOxW7uOLzqJ5XcC0DWVABoY5X/acHTzqHZj3/I/76J5YjnRFV7zD+w
 SO41t7WPFO8TPPp0h9Hpyz4gVmyjFvxDNzXZCVAr+SG0wxhkB8JiFTgLMjoJ3BuCCzgyXMyVlkb
 rVjXO7qwKz5Us0+adwks4U5AFrTrigCEg=
X-Gm-Gg: AR+sD11RyP3bcqhSQpG5vaREaXZna4LWi4cmCpKjEXBMHYaZ5BiHVINDdqjec4xOkEp
 1vY7vYtoWbUaHyEod2QSNr7kgEV2UJZjytkgf2/LRsqvBuUQ2P3DgRBZpHzgyzPscPRZGWzEvh4
 QYQ1axc9GAGUmArV3LGXxor+9UxlCtklLTAm8MskXpvllLcNxUzylG6zGIV3VWsgmOELyi91dNP
 zM/KrFihmQw2GxXpMqdSUBuQHOLtj7Y4O0cvZMUmHqczf72rbRphqLO9QGzB9k8rVW/6U5H8yn0
 lA==
X-Received: by 2002:a05:6a00:390b:b0:846:1698:638b with SMTP id
 d2e1a72fcca58-84fa88648bemr1273609b3a.27.1786436294027; 
 Tue, 11 Aug 2026 01:18:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:390b:b0:846:1698:638b with SMTP id
 d2e1a72fcca58-84fa88648bemr1273579b3a.27.1786436293590; Tue, 11 Aug 2026
 01:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-8-8af31bc54c61@redhat.com>
 <anoO2n0-ekf3EpFY@redhat.com>
In-Reply-To: <anoO2n0-ekf3EpFY@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Aug 2026 12:18:00 +0400
X-Gm-Features: AUfX_mzXTAI4Xcs4Mka98hSFq04He9MLVrndA-Gy4o_lytx5IeBfXwMhDUWfJ7I
Message-ID: <CAMxuvazUkW=zUqJVSRG74pHnrMuqZgc71fin30rg0Hv4CBk9eg@mail.gmail.com>
Subject: Re: [PATCH v2 08/39] system: decouple qmp_inject_nmi() from Monitor
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On Mon, Aug 10, 2026 at 9:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jun 26, 2026 at 01:19:09AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Use first_cpu directly instead of going through monitor_get_cpu_index()=
,
> > as this is HMP-territory. QMP doesn't have a `cpu` command, we should
> > add arguments instead when needed.
> >
> > Update the inject-nmi doc to accurately describe per-architecture NMI
> > delivery.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/machine.json | 5 +++--
> >  system/cpus.c     | 7 +++++--
> >  2 files changed, 8 insertions(+), 4 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I realize the patch is wrong, HMP calls qmp_inject_nmi(), we need to
pass the current cpu or not use QMP.

>
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 685e4e29b87..03461f5f723 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -432,8 +432,9 @@
> >  ##
> >  # @inject-nmi:
> >  #
> > -# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
> > -# all CPUs (ppc64).  The command fails when the guest doesn't support
> > +# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
> > +# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
> > +# (s390).  The command fails when the guest doesn't support
> >  # injecting.
> >  #
> >  # Since: 0.14
>
>
>
> > diff --git a/system/cpus.c b/system/cpus.c
> > index 49f6daec3cd..6e3ef0afeca 100644
> > --- a/system/cpus.c
> > +++ b/system/cpus.c
> > @@ -915,6 +915,9 @@ exit:
> >
> >  void qmp_inject_nmi(Error **errp)
> >  {
> > -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
> > +    int cpu_index =3D UNASSIGNED_CPU_INDEX;
> > +    if (first_cpu) {
> > +        cpu_index =3D first_cpu->cpu_index;
> > +    }
>
> I'm wondering how this "if" logic turns into the behaviour documented
> for x86/hppa/pc64  vs  s390 ? Don't all those arches have 'first_cpu'
> defined, such that this changes semantics to 'first vCPU' instead of
> 'all vCPUs' ?

All the nmi handlers implement cpu_index differently.. I have to review thi=
s.

>
> > +    nmi_monitor_handle(cpu_index, errp);
> >  }
> > -
> >
> > --
> > 2.54.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


