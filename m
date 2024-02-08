Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC402C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 01:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXsoJ-0004S9-BW; Wed, 07 Feb 2024 20:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsoI-0004S0-19
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 20:02:38 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsoF-0001NU-EA
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 20:02:37 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-560037b6975so1377673a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707354151; x=1707958951; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2C8J8jqy81cRwkM/sh5cnz0K+C6l7aoUMWFBmUOrak=;
 b=NxF39CzufKMXAc5av20q7PRYXA+gc66C4ZXWBKKm4ZXEgTrzUrnBY1J6K6r5n4T6i8
 EGC1RpjjsCzitZzzj8V4+sdsMK3F2afe0dqe8J8Jqx+d0pZsZjHjIRzPJnj87F8qGhTu
 QSYFdwt1PgAOhRKXeUunWHik9VFcFgXezrumPdVDIsF6EFUbJcN70EEBJv07Ije11qt0
 iKQSeHGxxptqIAb/bQmtzVEeo0waiIWrQAWtZXXkjJ8XSVctAekN1Kj4NydVppnGJJOP
 esWGkvCe8//3WDlulzHE+/DEEDfekx2tuV1/xbeeQA8+hx7GPgUYDzq1nsbJcHyuZxE1
 O3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707354151; x=1707958951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2C8J8jqy81cRwkM/sh5cnz0K+C6l7aoUMWFBmUOrak=;
 b=LowCHP9ZHiiKeLOiqxfUyYn1mjp+zEScr1AsPAg4MNUpwrEX5I24K/fzoJYPXniapL
 kCX2aVcyLUuSepaGX1D2eOkMFlD0bqY559K4c8rPzYCLjChMNEr/XAgflouxupFUs1Tl
 caYT0cAgg4m1sO1DjTPRf5JrhrATrmVgMkJ2XrpTdhgUBE5ZGvETI9RcnQK4PtN66uw0
 pLUgklc4E9b9p0bZ5dHI8de4bGLFieCkeaqTXIk6imqsFb8QanWnkX81JIDVNw7BDuXj
 h9/qiNwqEAQl2x/Pn6JMIT/qfjgOJ5W0FbCetYpNQbw5VullLADh+Cj/Ff9A12W3t9G7
 dM3g==
X-Gm-Message-State: AOJu0YyE7ikvOQ1Law98a6h8N8+CdSMvlzTIgnVcIjsFH35BZX/EOQc+
 UtDV1mBFeTck8ide1H0XdN6J1HB84B+125VxaEbHJumxq31nussXkDyP9IPcEQEWSJBkIC+GNVL
 LG9/TQQ6slJiCMK0Hni1fJ7V26IX2+zSd2ak+XQ==
X-Google-Smtp-Source: AGHT+IEwUbyfq4Je+jq1bjvycYaD1BoHp5K4wuAEWNN7kc9U7BdGyh6u6dOKotMm8NLqXZ9Wuskq6JMnrxOnxKe0WMQ=
X-Received: by 2002:a05:6402:202f:b0:560:ecd5:968b with SMTP id
 ay15-20020a056402202f00b00560ecd5968bmr1604050edb.23.1707354151381; Wed, 07
 Feb 2024 17:02:31 -0800 (PST)
MIME-Version: 1.0
References: <ZcM6TIWkyCRsk6wn@x1n> <ZcM68L8PaoD6qtLp@x1n>
 <PH7PR11MB5941E6CB97EA7BA10AAE3C1EA3452@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB5941E6CB97EA7BA10AAE3C1EA3452@PH7PR11MB5941.namprd11.prod.outlook.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 7 Feb 2024 17:02:20 -0800
Message-ID: <CAAYibXjTURNe75Bvxrsy9HmHB7Ri52pL6FOxLS0qhyejOVx6Qg@mail.gmail.com>
Subject: Re: [External] RE: Regarding to the recent Intel IAA/DSA/QAT support
 on migration
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Peter Xu <peterx@redhat.com>, Bryan Zhang <bryan.zhang@bytedance.com>, 
 Fabiano Rosas <farosas@suse.de>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 7, 2024 at 12:38=E2=80=AFAM Liu, Yuan1 <yuan1.liu@intel.com> wr=
ote:
>
> Thank you very much for your reminder and the rapid updates to the
> multifd function. I will incorporate your suggestions into the next
> version (IAA Accelerated Live Migration solution).
>
> Regarding the QAT and DSA optimization, my colleagues and I have
> already started reviewing and testing them, and it seems like a
> promising optimization direction. I am more than willing to contribute
> further efforts to the long-term maintenance of Intel accelerators in
> live migration.
>
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, February 7, 2024 4:10 PM
> > To: Bryan Zhang <bryan.zhang@bytedance.com>; Hao Xiang
> > <hao.xiang@bytedance.com>; Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Fabiano Rosas <farosas@suse.de>; QEMU Devel Mailing List <qemu-
> > devel@nongnu.org>
> > Subject: Regarding to the recent Intel IAA/DSA/QAT support on migration
> >
> > Copy qemu-devel.
> >
> > On Wed, Feb 07, 2024 at 04:07:40PM +0800, Peter Xu wrote:
> > > Hi,
> > >
> > > I'm sending this email just to leave a generic comment to the recent
> > > migration efforts to enable these new Intel technologies.
> > >
> > > The relevant patchsets (latest version so far) we're discussing are:
> > >
> > >   [PATCH v3 0/4] Live Migration Acceleration with IAA Compression
> > >
> > > https://lore.kernel.org/r/20240103112851.908082-1-yuan1.liu@intel.com
> > >
> > >   [PATCH v3 00/20] Use Intel DSA accelerator to offload zero page
> > checking in multifd live migration.
> > >
> > > https://lore.kernel.org/r/20240104004452.324068-1-hao.xiang@bytedance=
.
> > > com
> > >
> > >   [PATCH 0/5] *** Implement using Intel QAT to offload ZLIB
> > >
> > > https://lore.kernel.org/r/20231231205804.2366509-1-bryan.zhang@byteda=
n
> > > ce.com
> > >
> > > I want to comment in a generic way since this should apply to all
> > > these
> > > series:
> > >
> > >   - A heads-up that multifd code is rapidly changing recently, I
> > apologize
> > >     that you'll need a rebase.  It's just that it's probably much bet=
ter
> > to
> > >     do this before anything lands there.
> > >
> > >     IIUC the good thing is we found that send_prepare() doesn't need =
to
> > be
> > >     changed that much, however there's still some change; please refe=
r
> > to
> > >     the new code (I'll prepare a pull tomorrow to include most of the
> > >     changes, and we should have a major thread race fixed too with
> > Fabiano
> > >     & Avihai's help). I hope this will also provide some kind of
> > isolation
> > >     to e.g. other works that may touch other areas.  E.g., I hope fix=
ed-
> > ram
> > >     won't need to conflict much with any of the above series now.

Thanks for the update. The rebase shouldn't be that bad so no worries.

> > >
> > >   - When posting the new patchset (if there is a plan..), please make
> > sure
> > >     we have:
> > >
> > >     - Proper unit tests for the new code (probably mostly software
> > >       fallbacks to be tested on the new libraries being introduced; j=
ust
> > to
> > >       make sure the new library code paths can get some torture pleas=
e).
> > >
> > >     - Proper documentation for the new code.  Please feel free to sta=
rt
> > >       creating your own .rst file under docs/devel/migration/, we can
> > try
> > >       to merge them later.  It should help avoid conflictions.  Pleas=
e
> > also
> > >       link the new file into index.rst there.
> > >
> > >       IMHO the document can contain many things, the important ones
> > could
> > >       start from: who should enable such feature; what one can get fr=
om
> > >       having it enabled; what is the HW requirement to enable it; how
> > >       should one tune the new parameters, and so on... some links to =
the
> > >       technology behinds it would be nice too to be referenced.
> > >
> > >     - Try to add new code (especially HW/library based) into new file=
.
> > >       I see that QPL & QAT already proposed its own files (multifd-
> > pql.c,
> > >       multifd-qatzip.c) which is great.
> > >
> > >       Xiang, please also consider doing so for the DSA based zero pag=
e
> > >       detection.  It can be called multifd-zero-page.c, for example, =
and
> > >       you can create it when working on the
> > >       offload-zero-page-detect-to-multifd patchset already.

Sounds good.

> > >
> > >     - Please provide someone who can potentially maintain this code i=
f
> > ever
> > >       possible.  Pushing these code upstream is great, but maintainin=
g
> > will
> > >       also take effort.  It might be impractical this keeps growing f=
or
> > >       migration maintainers (currently Fabiano and myself), so we may
> > like
> > >       to have people covering these areas, especially when the new co=
des
> > >       are not directly relevant to migration framework.
> > >
> > >       I'd suggest for each of the project we can add an entry in
> > >       MAINTAINERS below "Migration" section, adding relevant files (a=
nd
> > >       these files should exist in both the new section and "Migration=
").
> > I
> > >       am not sure whether Bytedance would be able to cover this, or w=
e
> > >       should try to find someone from Intel?  If you're willing to ad=
d
> > >       yourself to maintain such codes, please attach the maintainers
> > file
> > >       change together with the series.  It will be very much
> > appreciated.

I will add myself to maintain this. In addition, I will talk to Intel
about adding someone from Intel (hopefully Yuan or someone from his
team?) as well to maintain the DSA work.

> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> >
> > --
> > Peter Xu
>

