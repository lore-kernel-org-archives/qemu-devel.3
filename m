Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFECBC369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LO2-0004nE-40; Thu, 17 Apr 2025 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LO0-0004mj-1l; Thu, 17 Apr 2025 05:18:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LNy-0003RS-0z; Thu, 17 Apr 2025 05:18:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so434991a12.3; 
 Thu, 17 Apr 2025 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744881495; x=1745486295; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1WLBjPWfsO4BXL0OvQ1i5sHakJ1+UaHlRH3KudpiBG4=;
 b=kcT+zhCyaS91vmnac6UbHZuuzvu5zufaMhD0KG/NthFu9WMuqDEVwtAgnZwKcwhFnt
 LtzYEAtxhyFhcjTbuVi1njfuhcFixZckLYwundq3zIXCCPHgZ+ImA30gOtvAU55U61eH
 iJNnX8GUbZHrJGDkD1My35ooZc9UoEGl0S5kfdld3CCxs9CE16PiRv//pbf0AumYh9FW
 T6irEpDEos0DSOK0UDBSKrAI9sP8JjmHTHDUj3yl5XlLil4012sFdSeaQQtqLAHrcp4p
 2/BLwD0FtF6AUlLUo+66BNl5WH1YRRyOi3B1m7bxQJH2eypIleJl7q1tL9rSTjK4EeLz
 4CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881495; x=1745486295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1WLBjPWfsO4BXL0OvQ1i5sHakJ1+UaHlRH3KudpiBG4=;
 b=eoZ1Wk6B3yI2ZABY9ieOraLXuS3ogWtoaawaneaaCI0EC/U9x2QPstBASHItUXmYn4
 X37UPJO+BpkCWmz/j8IJ7Cqgy4MWgkOSGt8RiBFxemf+0VFEU3qZnu+JDmdswv7erEOw
 Gz1bn34Vn7vEMnHBtxeoUWOMYRVhW1vsBRQtpL/6z0sOLi947lMscVPn3Enf+j4XqxHn
 P2qZRBWf5lW0AR3/be1vFf2oYiiYqeVQ8o+lzoZGtR+h9KQ8rG+RhTN1ihfeO9vBFOcX
 B0b5grcLzpIovYlSuLr24d4MAvOvZNBVZqX5LxXh+0Gy0Dv94Wk0mDJIpPSPtMXwxtSX
 8r9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPN8sv37u/lmmTSI/u/2HPSEs3PBAV7LJb+DHvM8wkrRSvKSRaWiAmLRkdpm7/mwv31FucWOVivQ==@nongnu.org,
 AJvYcCUSMtLGPf2GOkfckbX454b2HXtC1RDW/G9P6xUApjWsoIrT2V/xuYYmghaJKauvlpG/5A/lLs03sHtx6Q==@nongnu.org,
 AJvYcCVVF/yBKfY0RkqEjEIy1C1/rD3hYZV2/cea0nrASycO+wg8klBv9yLe+tLlsimYfbYlG8cd5LKuo2O/5A==@nongnu.org,
 AJvYcCX/lBZJmDbPuvuHsaavAy66yyvFGrxvMJc0fAsx3RZHMUi9z/1WgQ3Uuaa/IRbmDvheTLzjDXwLo7g=@nongnu.org,
 AJvYcCXrT+hCq5XQox2AadmNcjyEd2stifOa/HqzbSXJgsnlZbRZWw55xWOQgHOXLD96A+0hmyqfGqVLvl5sHw==@nongnu.org
X-Gm-Message-State: AOJu0YwZDZ4gtlp/kRhZZddGiMS7NlpoQiQXqSVVRgTVqjV158lG7aNm
 t8hUCeuYj5yYU6okQpfmB+16c+Gi2f39zRQBkfVQbeK0wvmy/JXqw2U1wRcmMMQd71r8NwME4iu
 vaOWR7KvVMUUcpCLeZxBrmEWHqEo=
X-Gm-Gg: ASbGncvURTWPcOZlKRki9NRMXyudjPxk03sB/O9TlV/UKuo4ncCHSY9c7HHA7WI0ib9
 82CwO36BWgvVkYcUJEqsCp5+fZeH05ECZjdPlrdizJQrvNivQTcsTjXVMT42q2rVWGPYecOTCxb
 GAKlD+oyuWu2sBk/I45hz151f9QgPSSoQba+7HaTs2dzkd/8Rbmmqc
X-Google-Smtp-Source: AGHT+IF4Rj1T9/KMNZqxohi5RwAbiBoQGmz+hSuqGgEUXQj0HsnRboEYQra1EsTT3emQLFpOZXah8k1AtyHzy5DAlg8=
X-Received: by 2002:a17:90a:e70b:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-30863c54ae3mr8816800a91.0.1744881494943; Thu, 17 Apr 2025
 02:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
 <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
 <Z_90aqNE74sonn8O@redhat.com>
 <CABgObfaNAEsRQrr8O8fpuGGoQHq14Q_niBnQf1Yj4iD33a0LVA@mail.gmail.com>
In-Reply-To: <CABgObfaNAEsRQrr8O8fpuGGoQHq14Q_niBnQf1Yj4iD33a0LVA@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:18:03 +0900
X-Gm-Features: ATxdqUHgp2h8Pj8TyRxXfyhh8WPCb-zjOPqcUlZcrXo0tsUUQI1ADOBE82KIVwY
Message-ID: <CAEDrbUb0G=12Gt50sV+mM3gw_MbXpKwy-F0pXs1rAzdUoU3qKg@mail.gmail.com>
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ae74880632f5e1d2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ae74880632f5e1d2
Content-Type: text/plain; charset="UTF-8"

Hi Daniel, Paolo and Thomas,

> > > I suggested this solution to Kohei because it's easy to check that
we're
> > > converting all users and not introducing new ones in the future (see
> > > poisoning in patch 10).
> >
> > It is easy to check this /one/ example, but this pattern of bad casts
> > is typical in glib with likely many more examples, so avoidance in this
> > way does not feel like a sustainable long term strategy to me.
>
> If you refer to the general case of function casting then yes, I agree
that there could be other problems in the future but that would have to be
solved in glib.
>
> However QEMU's use of glib is overall relatively limited and for now this
seems to be the only case we hit. What this patch is doing is both
effective at solving the immediate issue, and future proof.

The current patch addresses the cases we've encountered so far, and the
poisoning will help catch the usage of them in future development.

That said, it's worth continuing to explore a more robust solution. I've
submitted an issue to the GLib repository to investigate a long-term fix[1].

[1] https://gitlab.gnome.org/GNOME/glib/-/issues/3670

--000000000000ae74880632f5e1d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel, Paolo and Thomas,<br><br>&gt; &gt; &gt; I sugge=
sted this solution to Kohei because it&#39;s easy to check that we&#39;re<b=
r>&gt; &gt; &gt; converting all users and not introducing new ones in the f=
uture (see<br>&gt; &gt; &gt; poisoning in patch 10).<br>&gt; &gt; <br>&gt; =
&gt; It is easy to check this /one/ example, but this pattern of bad casts<=
br>&gt; &gt; is typical in glib with likely many more examples, so avoidanc=
e in this<br>&gt; &gt; way does not feel like a sustainable long term strat=
egy to me.<br>&gt; <br>&gt; If you refer to the general case of function ca=
sting then yes, I agree that there could be other problems in the future bu=
t that would have to be solved in glib.<br>&gt; <br>&gt; However QEMU&#39;s=
 use of glib is overall relatively limited and for now this seems to be the=
 only case we hit. What this patch is doing is both effective at solving th=
e immediate issue, and future proof.<br><br>The current patch addresses the=
 cases we&#39;ve encountered so far, and the<br>poisoning will help catch t=
he usage of them in future development.<br><br>That said, it&#39;s worth co=
ntinuing to explore a more robust solution. I&#39;ve<br>submitted an issue =
to the GLib repository to investigate a long-term fix[1].<br><br>[1] <a hre=
f=3D"https://gitlab.gnome.org/GNOME/glib/-/issues/3670">https://gitlab.gnom=
e.org/GNOME/glib/-/issues/3670</a><br><br><br></div>

--000000000000ae74880632f5e1d2--

