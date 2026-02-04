Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB417E9D416
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngHT-00049e-C6; Wed, 04 Feb 2026 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vngHN-000467-TS
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vngHM-0007UF-5i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770224578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIRXNObdqh0jutQEC1Bl7M7EZOW0POLeaMNO3sPxpSo=;
 b=S9W0GzBfISbl72Uu5FpBOgMfsxIp+qQiabJ/3Z14jUTD3eZ/79KdDT5ZQZyguM+Rpmn9ME
 wr1JDvKgYwIe0jzXK/R4tOvuiRoWuB2q0Ird8Qe/1eRnfK50eCy2IZmdjXF/J0y26ymdYR
 RsFxOBrKix+QeQVqPGlk6nt0WPm6RoE=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-kIjVJIs9PN-ADirFF1SgIg-1; Wed, 04 Feb 2026 12:02:37 -0500
X-MC-Unique: kIjVJIs9PN-ADirFF1SgIg-1
X-Mimecast-MFC-AGG-ID: kIjVJIs9PN-ADirFF1SgIg_1770224556
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-649b2db7b8fso148455d50.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 09:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770224556; cv=none;
 d=google.com; s=arc-20240605;
 b=ITTYLcNlqoOJaSD9C/7sMrs90z3isX9HpifMns80Ux1ctibp6j1IOMrg1kmDdxvWSb
 ocOaPNiELksdaiUE3cVX8AFIgaoh6n9NJczozw5XmmlsEwJU8MSlMMW3EOsFn09kAk0V
 yQK6RgzWqNerKnLUcdd5/k8Oc5YyNGUUUMK177ng3zGieO0XV236MUWdjHb2gS743iHr
 OmwVzAIriO0DUGNZcJJTa971HArZTifZ5530PJ3CvsUslNe2f/4HVN3DeVAiga/Emqyc
 CyBbvuPZA/b1rlMvPmRkRdFiuKu4roYYgR/T53XTSPrkpexXALHLCCdDdQZaqWnINliZ
 +FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZIRXNObdqh0jutQEC1Bl7M7EZOW0POLeaMNO3sPxpSo=;
 fh=v/epxvmm3ueG+eAhMMiJ15y4jUAJn4isqoG/QQ/Vzn0=;
 b=BJckw1jt9cHCyKrQRm1Sjj5HH+q8qPHrfjXDYwD7bhjM50BqwpwjiVZnc9RmCPWw3u
 R0kZm/eef9dS3IWCbVcZERULZ7pYVo4sHV4ah89O9pFHa/As3un9PM7Xu33DpSMvxFVs
 HdfIqkVrVYATzPrJrFP03Uh7OQ89C1TTUlr/+djTVW+QPEfWmyLU6EoaawWpahNCXUcd
 +RMJJqBieWZjnqMHL+VjeZpEB6YbLwaU8IRVMf9mTagApKbpE++Y8iNQ1w5bnEPM/Q7H
 BPQ0QGPA7xvj2zcr0D7Sr/LO75c/IzSSH3FnAi89w5VtWJD+SLOBTH1hJtuMqENk0xf5
 u2HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770224556; x=1770829356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIRXNObdqh0jutQEC1Bl7M7EZOW0POLeaMNO3sPxpSo=;
 b=HY5D7x9+by2P3mhSGNUYN3NzMBbnoTRX/s14xYaLAGRBLTaqfV2FKUv+uybDJ482Yf
 JL7py87VQCdZDuztgbD5mxUcUIJNwLeX0pqfjhuFTa5yEx82pN2GTN4lgNSN75ZLjzhj
 NceB9jSRHeegrps+vR4FNhMF/zOkjDE9gcjiJsLZDm4M/RQd6c47uca86wl+RG9H0C4U
 iHe3s+1hgpCR+wdUSK1U1tHmFwjYKYYlMewAJ0cjIffPAiMca8RBAdiCbo7UdE/NydTR
 Y6zpmR8ZIOEk+JwNpRHV3Uf5u5W6CL/gsgtTP0g+duUrx7H+HHLqUUfXUR3SJLb6SUIq
 bR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770224556; x=1770829356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIRXNObdqh0jutQEC1Bl7M7EZOW0POLeaMNO3sPxpSo=;
 b=QHuho6DSy2h54SSR7ANiA5be5wbWhe4aJY1mtn2SjjA5NwLHG7zCcVcEQdcY/amfEl
 Nn9AE/BPxouEiIgsZDJ89zouqQcklei1+LQGuhvHeuANXQdsNIIeKyxXdDFn8RsRJrcK
 gt+a+tz45SfxBfpZNdZVG1ERVspKhwEwRLZuCU2b4Vkc7ENuZuodqHcr6fi9Fe1dnsY3
 rj9Y900xt6DwQSJJMMgX2QpCdjQ7qyLoM8p4DfCj/VD1iHOIInaGl2tUx04//uyvAOkC
 BLk2fHZz1Os8S/y0QsUTxs96JdFVpk3PQzZq5f2VQDCzLdd3JtKrg6y09FbvET4Tco3e
 KHmQ==
X-Gm-Message-State: AOJu0YzQlTtOBUBh6SzzhotWeT1alv1cZpDIKN6rPH10hzsjLEAeJUHh
 E7AiXyoBdzK5IDDWFwQkhcqvIBa5f9D3D5LMGh3r44TFTAwqf74GqM8H0jQ2ugGnPpmd3d1Ec1J
 XGjnWtvH/ttqHNStJ+sdZmX/8CGo0SSVr3rV4HitXtPUZvtZL+5tfZ4W/AYp6dF/lHUBShTWjjZ
 VkL0c4A5SagZh/V1Mu62wYxKrYBRNR60k=
X-Gm-Gg: AZuq6aLgq5mUyKTDUlyA9uGVqIt8ip60v3JslFs+f8MR12Esd+qiRW4Njz/tcuCDTOA
 B010apdxUwoAIkemzf6WMQd28KBObNnHX+hq2woTf8/1hLx9a7pvM5Yv7rSxqczdrirSX3MUfjK
 iUhME6QEO5gstyF1Z1kUSviCc9ICGqIEar7Xh9gBmml9JxoYq2Pq/G7UCncUpoy83hiRMeU7aZp
 1luD79X/kTeugIvKAM4E1019g==
X-Received: by 2002:a53:b547:0:b0:649:5d59:2a1f with SMTP id
 956f58d0204a3-649db4a542dmr2844140d50.66.1770224555244; 
 Wed, 04 Feb 2026 09:02:35 -0800 (PST)
X-Received: by 2002:a53:b547:0:b0:649:5d59:2a1f with SMTP id
 956f58d0204a3-649db4a542dmr2844063d50.66.1770224554578; Wed, 04 Feb 2026
 09:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
 <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
 <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
In-Reply-To: <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Feb 2026 12:02:23 -0500
X-Gm-Features: AZwV_Qgexri8MmwXqjFr8QIZT1o2tIWNebon2S1YF89JoqDmvAkSN18nl79R_vk
Message-ID: <CAFn=p-aforipvpRhUyLbStYPSRC4Pc0Oadcq8HzT7GzEGL+BnQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000c02b1f064a0285a2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000c02b1f064a0285a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026, 11:55=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

> On Tue, Feb 3, 2026 at 10:28=E2=80=AFPM John Snow <jsnow@redhat.com> wrot=
e:
> >
> > On Tue, Feb 3, 2026 at 4:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om>
> wrote:
> > >
> > >
> > >
> > > Il mar 3 feb 2026, 21:36 John Snow <jsnow@redhat.com> ha scritto:
> > >>
> > >> Add the local python package group into pythondeps.toml for the
> > >> tooling This makes qemu.qmp, qemu.machine and qemu.utils
> > >> packages unconditionally available for tests and scripts.
> > >
> > >
> > > Out of curiosity why not add setuptools and wheel to the group, at
> this point? Can be done on top of course.
> >
> > Hm. If we're operating offline, it would only really serve as a
>
> s/only/also/ :)
>
> > configure check. Online it might actually be a help. I'll do it as a
> > follow up, I just need to figure out which versions meet our needs and
> > do testing to choose the accepted values.
>
> Use whatever is in bookworm or 22.04?
>
> Paolo
>

OpenSUSE Leap 15.6 and 22.04 until April

https://gitlab.com/jsnow/repology-dashboard

44.x

--js

>

--000000000000c02b1f064a0285a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 4, 2026, 11:55=E2=80=
=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Feb =
3, 2026 at 10:28=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Feb 3, 2026 at 4:08=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"ma=
ilto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@red=
hat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Il mar 3 feb 2026, 21:36 John Snow &lt;<a href=3D"mailto:jsnow@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; ha =
scritto:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Add the local python package group into pythondeps.toml for t=
he<br>
&gt; &gt;&gt; tooling This makes qemu.qmp, qemu.machine and qemu.utils<br>
&gt; &gt;&gt; packages unconditionally available for tests and scripts.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Out of curiosity why not add setuptools and wheel to the group, a=
t this point? Can be done on top of course.<br>
&gt;<br>
&gt; Hm. If we&#39;re operating offline, it would only really serve as a<br=
>
<br>
s/only/also/ :)<br>
<br>
&gt; configure check. Online it might actually be a help. I&#39;ll do it as=
 a<br>
&gt; follow up, I just need to figure out which versions meet our needs and=
<br>
&gt; do testing to choose the accepted values.<br>
<br>
Use whatever is in bookworm or 22.04?<br>
<br>
Paolo<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">OpenSUSE Leap 15.6 and 22.04 until April</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><a href=3D"https://gitlab.com/jsnow/repology-dashboar=
d">https://gitlab.com/jsnow/repology-dashboard</a></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">44.x</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">--js</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000c02b1f064a0285a2--


