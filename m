Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C145C28B22
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpphx-0006U6-60; Wed, 05 Mar 2025 09:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpphr-0006Sv-J4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpphp-0006KS-IH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741184800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toBKDjsLPBvRznVpOTLBbLmgVA22EeviMNlxdJ0UoEI=;
 b=e+hwsO6pxBzfziP2ybrkXijp489Xo8DWuVjSxBkd8rgQYdOkqcQkG9x8yEqsq63ts5/kN8
 QgVufAFytwSrYoFr3C0ecC7gAmTsesbBl7PCbDG2hzJXdpg+pXzju9QnRj9E9hfLJXm1xw
 yT77kl2O0xv9TVg9o56M1TAmlSzVdJk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-ZxUaOVZoOKe3zUq_EGBltg-1; Wed, 05 Mar 2025 09:26:30 -0500
X-MC-Unique: ZxUaOVZoOKe3zUq_EGBltg-1
X-Mimecast-MFC-AGG-ID: ZxUaOVZoOKe3zUq_EGBltg_1741184786
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac20d538688so97713666b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 06:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184786; x=1741789586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toBKDjsLPBvRznVpOTLBbLmgVA22EeviMNlxdJ0UoEI=;
 b=ES2vmi33VnEVk0iaQPFcuEqvkHFYTQeAuTCxHZSdSq3LEUU9Zm5Qgpgsl9N/iYXZtd
 AziUgejwLA7XonRRROCgc95KH1Kb6slQgJ57B+tvzuIlVSGAOsFYraiCNzjumhWjiWDj
 8gPcs1DP3GmBj7utMQffXA1zVyX6SG07LvSDwnr3Hv7iP8b7UPGyB9xjUxrqoXKHXkY0
 hTdRr17aiGRozVHd5cWmKirHNkNVX/CRi1j/IpfvI1MX267aYVvyIjhtJ9OcSsvOOFWJ
 Jd445SzWFIKKPbrD1U8M75H+eFHLkO+feDcJH6HUZKvr8UEuuJMohg88euGk/gG4RvjU
 CDXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqlRYRo3gZmwFiplIhVWSO2GzYQPH01MZsAsC9x1istZK1O6MBbBsdH9oRIq+DU9Sx+PkZ6jxWecVD@nongnu.org
X-Gm-Message-State: AOJu0YzJnoPya+Vvh5TLzUf+kOcEDvtcr0MiWwCbgynFugsaqvOHnA4a
 +bJteOyjtF8EBozBDsgtQNiNQowuv8H1WeKadkOs+lUHa/rVNfbcfEFowrkWfxygb7E2L1L1TAN
 Mfob8E5TDs4xyOqjR9iWE8P1plC8Pjf2+YUeCsYyrXIY4WYB34zx/YYrrg7ekpA3jxBmACVzDTp
 aI9eBYJCBX/EPouF0ktx6RzICwKQ0=
X-Gm-Gg: ASbGncvwVJ8NLWnQIsF5jJfJO13/hpBJRNbO+RzfbxyN4VmqoQspe7gwcX4+1Rt+V7M
 NuV3BUQDjNC5yGWPFc3zR7+hPdaqMYQssxVt+pfIOCVDmF18l6eTQtLw3DOFyL/2z5emg9an/
X-Received: by 2002:a17:907:9707:b0:abf:769a:d3b7 with SMTP id
 a640c23a62f3a-ac20db01f6cmr414790766b.57.1741184786097; 
 Wed, 05 Mar 2025 06:26:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwJJW02+qbiXCFfWHJ7fEhPV/tEkVnXhS1VUSlK+c/5bZynDqO0NffQI+qI5SXkLqcHNv3hlPKM4BdaOPo0+w=
X-Received: by 2002:a17:907:9707:b0:abf:769a:d3b7 with SMTP id
 a640c23a62f3a-ac20db01f6cmr414787266b.57.1741184785716; Wed, 05 Mar 2025
 06:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20250220065326.312596-1-anisinha@redhat.com>
 <Z7bZBsqO6MxhFKVp@intel.com>
 <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
 <CAK3XEhMbLHKt8-kV=BzKgZpdbtmRDC+qM3bfqz9BYfupR13t2w@mail.gmail.com>
 <20250305134225.GA256646@fedora>
In-Reply-To: <20250305134225.GA256646@fedora>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 5 Mar 2025 19:56:13 +0530
X-Gm-Features: AQ5f1JqZ1iY88mPKE4BaHPBn0bcBKnZ9fk_Ol6RsmmanD1BhbNL3mkBj7lueXfQ
Message-ID: <CAK3XEhOD2WcEGSRB1LgwX+qN9qPX7HmAk3whddfkD_N-Zwi33g@mail.gmail.com>
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Sergio Lopez <slp@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 5, 2025 at 7:12=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Wed, Mar 05, 2025 at 01:24:25PM +0530, Ani Sinha wrote:
> > On Sat, Mar 1, 2025 at 9:04=E2=80=AFPM Ani Sinha <anisinha@redhat.com> =
wrote:
> > >
> > > On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Zhao Liu <zhao1.liu@intel.co=
m> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> > > > > Date: Thu, 20 Feb 2025 12:23:26 +0530
> > > > > From: Ani Sinha <anisinha@redhat.com>
> > > > > Subject: [PATCH v2] microvm: do not use the lastest cpu version
> > > > > X-Mailer: git-send-email 2.45.2
> > > > >
> > > > > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be alias=
es")
> > > > > introduced 'default_cpu_version' for PCMachineClass. This created=
 three
> > > > > categories of CPU models:
> > > > >  - Most unversioned CPU models would use version 1 by default.
> > > > >  - For machines 4.0.1 and older that do not support cpu model ali=
ases, a
> > > > >    special default_cpu_version value of CPU_VERSION_LEGACY is use=
d.
> > > > >  - It was thought that future machines would use the latest value=
 of cpu
> > > > >    versions corresponding to default_cpu_version value of
> > > > >    CPU_VERSION_LATEST [1].
> > > > >
> > > > > All pc machines still use the default cpu version of 1 for
> > > > > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > > > > changes with time. Therefore, if machines use CPU_VERSION_LATEST,=
 it would
> > > > > mean that over a period of time, for the same versioned machine t=
ype,
> > > > > the cpu version would be different depending on what the latest w=
as at that
> > > > > time. This would break guests even when they use a constant speci=
fic
> > > > > versioned machine type.
> > > > > Additionally, microvm machines are not versioned anyway and there=
fore
> > > > > there is no requirement to use the latest cpu model by default.
> > > > > Let microvms use the non-versioned cpu model and remove all refer=
ences
> > > > > to CPU_VERSION_LATEST as there are no other users (nor we anticip=
ate
> > > > > future consumers of CPU_VERSION_LATEST).
> > > > >
> > > > > Those users who need spefific cpu versions can use explicit versi=
on in
> > > > > the QEMU command line to select the specific cpu version desired.
> > > > >
> > > > > CI pipline does not break with this change.
> > > > >
> > > > > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU model=
s")
> > > > >
> > > > > CC: imammedo@redhat.com
> > > > > CC: zhao1.liu@intel.com
> > > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Reviewed-by: Sergio Lopez <slp@redhat.com>
> > > > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > > > ---
> > > > >  hw/i386/microvm.c |  2 +-
> > > > >  target/i386/cpu.c | 15 ---------------
> > > > >  target/i386/cpu.h |  4 ----
> > > > >  3 files changed, 1 insertion(+), 20 deletions(-)
> > > > >
> > > > > changelog:
> > > > > v2: tags added, more explanation in the commit log.
> > > >
> > > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > >
> > >
> > > Who is picking this up?
> >
> > I sent a pull request for this and a couple other reviewed patches
> > myself. Two reasons:
> > - wanted to see this in the upstream sooner as some other bits of the
> > work is pending on it.
> > - I never sent a pull request before and wanted to go through the
> > process to learn how to do it in case I needed it in the future.
> >
> > i hope the PR is ok. If not, I can resend after corrections. I used
> > Peter's script https://git.linaro.org/people/peter.maydell/misc-scripts=
.git/plain/make-pullreq
>
> This should go via Paolo's tree. I have pinged him to remind him of your
> patches.
>
> Please only send pull requests for subsystems where you are listed as
> the maintainer in the MAINTAINERS file.
>
> It doesn't scale when people send me PRs directly because I need to do a
> bunch of extra sanity checking and helping people get their one-off PRs
> properly signed and formatted. I also don't like to bypass
> sub-maintainers because I'm less qualified to do the final review than
> the sub-maintainers themselves.

Fair enough! I hope the three patches get merged soon.


