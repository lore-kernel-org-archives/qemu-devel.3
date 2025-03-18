Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADAEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 05:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuPHS-0005LJ-4T; Tue, 18 Mar 2025 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tuPHP-0005L1-Vp
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 01:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tuPHO-000745-4J
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 01:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742274854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixK7rD3KwzZFHvG4onnglx79KE7J7zWrFe5lhDOLO+o=;
 b=aGP+AMNz3fYiqtF1nyPbMwVZ1x78sqJvE6XXoyNmjXheKKOZNk5t1DDIlG4D5nK8B/ofcY
 lYgrw+vA6AyvpEfMc71ZxbRabuAIiYaA1NAW4NClSMkM7eATMFViPktZKnFyjTfzMWMWBz
 WoC6tYb6P20jBTLb7B3gr7yOG9Wje4M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-kjv37jx8Pbqse4ANuUdZwA-1; Tue, 18 Mar 2025 01:14:12 -0400
X-MC-Unique: kjv37jx8Pbqse4ANuUdZwA-1
X-Mimecast-MFC-AGG-ID: kjv37jx8Pbqse4ANuUdZwA_1742274851
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so579157766b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 22:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742274851; x=1742879651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixK7rD3KwzZFHvG4onnglx79KE7J7zWrFe5lhDOLO+o=;
 b=Bt6DgOMStfDbpnWq+DzzIJDcY3OSXp9QhzkDHxuWp1+Hsvn6iuIAwJvfjiOu56PpHn
 6Yarzrp0oad4woRGzQBfU+BXgu8p1lLS1M4/21CY5PCO3TXNBOQj+Yga6rZM09+rsLRa
 HxjA2WsN5ionW2/h4XExqtMrCRpnPSLGlx9DEx20WgcdPKXMyjF3C9AUt1CZF+BKjJwb
 V6BaayQPo2REg/xnUBByDA7Til/QYtNaXNszb4N4En+4cKNES6dgh1mUdxanbGQqQkRi
 iqKO6517ADt6UXdv/qHCcaByNmOl28Nykwe1ExmZGocvpG3KZi7Dz5Y/X4ikCtA3DIm5
 P3aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDvsvsMLL8oZPlcFXwXzZid6dnVKu6IuFIUY6wo4+2HOq1sfaqAcMkfYaRvPfv9LmQDE4pK+7OmDc@nongnu.org
X-Gm-Message-State: AOJu0Yx2rEurdocujKTPC9AinQdQKa7qJAbjs3jILUkrjDKqY+uPlGek
 LXlyYJs93zyvaea3myTBCRgpwrNZC6LC+Q4l7lNR2GbE3WSHwrDeogowui1MKeUy0pu6YHtJomP
 wKK1Guo+Z+W2OIHnREIcyIIctoDImn1mwvS4LxX1Hn3yj3RroC/cGgyIjDsMT33wVYKfXb1iBIe
 e0n5KuKBaCS7IUoHVEcN6Iu1RkBWk=
X-Gm-Gg: ASbGncvmP46wh7+Aq/wVhv83QzVDcB3sSty/XlV+cbOxOoPB4dqX1Hrz98+wHOyP1Vo
 F1bCDTQp+szZUXtStulvzPGePsYXfR//SiX6vxfAOfXNDI+/zIpS738ZnaUCCy1QbvOmMFkdcXg
 ==
X-Received: by 2002:a17:906:7316:b0:ac1:fcda:78c1 with SMTP id
 a640c23a62f3a-ac330263c7amr1704778766b.34.1742274851245; 
 Mon, 17 Mar 2025 22:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7/W6xZ0zZzUhl+xQnsdqRbxP1HTCZknIiyX6CQnOLnRNTl02ij4qeVtFkBI1ZbJH6Igp3/qemGFkUZ90Bdug=
X-Received: by 2002:a17:906:7316:b0:ac1:fcda:78c1 with SMTP id
 a640c23a62f3a-ac330263c7amr1704776066b.34.1742274850809; Mon, 17 Mar 2025
 22:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250220065326.312596-1-anisinha@redhat.com>
 <Z7bZBsqO6MxhFKVp@intel.com>
 <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
 <CAK3XEhMbLHKt8-kV=BzKgZpdbtmRDC+qM3bfqz9BYfupR13t2w@mail.gmail.com>
 <20250305134225.GA256646@fedora>
 <CAK3XEhOD2WcEGSRB1LgwX+qN9qPX7HmAk3whddfkD_N-Zwi33g@mail.gmail.com>
In-Reply-To: <CAK3XEhOD2WcEGSRB1LgwX+qN9qPX7HmAk3whddfkD_N-Zwi33g@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 18 Mar 2025 10:43:59 +0530
X-Gm-Features: AQ5f1Jo_radpa9UCOGzLuR1dZCyPx1ZAmPCmCOKB4M-d3sOvZvT0VbNtxy7iu90
Message-ID: <CAK3XEhOG+y_WMHOOOR+wYT1YSQBbZL1WYL7U6YEP8ZkZu-Sbag@mail.gmail.com>
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
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Wed, Mar 5, 2025 at 7:56=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
> On Wed, Mar 5, 2025 at 7:12=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Wed, Mar 05, 2025 at 01:24:25PM +0530, Ani Sinha wrote:
> > > On Sat, Mar 1, 2025 at 9:04=E2=80=AFPM Ani Sinha <anisinha@redhat.com=
> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Zhao Liu <zhao1.liu@intel.=
com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> > > > > > Date: Thu, 20 Feb 2025 12:23:26 +0530
> > > > > > From: Ani Sinha <anisinha@redhat.com>
> > > > > > Subject: [PATCH v2] microvm: do not use the lastest cpu version
> > > > > > X-Mailer: git-send-email 2.45.2
> > > > > >
> > > > > > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be ali=
ases")
> > > > > > introduced 'default_cpu_version' for PCMachineClass. This creat=
ed three
> > > > > > categories of CPU models:
> > > > > >  - Most unversioned CPU models would use version 1 by default.
> > > > > >  - For machines 4.0.1 and older that do not support cpu model a=
liases, a
> > > > > >    special default_cpu_version value of CPU_VERSION_LEGACY is u=
sed.
> > > > > >  - It was thought that future machines would use the latest val=
ue of cpu
> > > > > >    versions corresponding to default_cpu_version value of
> > > > > >    CPU_VERSION_LATEST [1].
> > > > > >
> > > > > > All pc machines still use the default cpu version of 1 for
> > > > > > unversioned cpu models. CPU_VERSION_LATEST is a moving target a=
nd
> > > > > > changes with time. Therefore, if machines use CPU_VERSION_LATES=
T, it would
> > > > > > mean that over a period of time, for the same versioned machine=
 type,
> > > > > > the cpu version would be different depending on what the latest=
 was at that
> > > > > > time. This would break guests even when they use a constant spe=
cific
> > > > > > versioned machine type.
> > > > > > Additionally, microvm machines are not versioned anyway and the=
refore
> > > > > > there is no requirement to use the latest cpu model by default.
> > > > > > Let microvms use the non-versioned cpu model and remove all ref=
erences
> > > > > > to CPU_VERSION_LATEST as there are no other users (nor we antic=
ipate
> > > > > > future consumers of CPU_VERSION_LATEST).
> > > > > >
> > > > > > Those users who need spefific cpu versions can use explicit ver=
sion in
> > > > > > the QEMU command line to select the specific cpu version desire=
d.
> > > > > >
> > > > > > CI pipline does not break with this change.
> > > > > >
> > > > > > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU mod=
els")
> > > > > >
> > > > > > CC: imammedo@redhat.com
> > > > > > CC: zhao1.liu@intel.com
> > > > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > > > Reviewed-by: Sergio Lopez <slp@redhat.com>
> > > > > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > > > > ---
> > > > > >  hw/i386/microvm.c |  2 +-
> > > > > >  target/i386/cpu.c | 15 ---------------
> > > > > >  target/i386/cpu.h |  4 ----
> > > > > >  3 files changed, 1 insertion(+), 20 deletions(-)
> > > > > >
> > > > > > changelog:
> > > > > > v2: tags added, more explanation in the commit log.
> > > > >
> > > > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > > >
> > > >
> > > > Who is picking this up?
> > >
> > > I sent a pull request for this and a couple other reviewed patches
> > > myself. Two reasons:
> > > - wanted to see this in the upstream sooner as some other bits of the
> > > work is pending on it.
> > > - I never sent a pull request before and wanted to go through the
> > > process to learn how to do it in case I needed it in the future.
> > >
> > > i hope the PR is ok. If not, I can resend after corrections. I used
> > > Peter's script https://git.linaro.org/people/peter.maydell/misc-scrip=
ts.git/plain/make-pullreq
> >
> > This should go via Paolo's tree. I have pinged him to remind him of you=
r
> > patches.
> >
> > Please only send pull requests for subsystems where you are listed as
> > the maintainer in the MAINTAINERS file.
> >
> > It doesn't scale when people send me PRs directly because I need to do =
a
> > bunch of extra sanity checking and helping people get their one-off PRs
> > properly signed and formatted. I also don't like to bypass
> > sub-maintainers because I'm less qualified to do the final review than
> > the sub-maintainers themselves.
>
> Fair enough! I hope the three patches get merged soon.

This has still not merged! Unfortunate.


