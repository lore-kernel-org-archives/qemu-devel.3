Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0312AD0BB4E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 02:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3nFu-00058C-5m; Wed, 23 Oct 2024 22:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3nFq-00057i-VB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:07:15 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3nFn-0007zp-P5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:07:14 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ebc1af8e91so188135eaf.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729735629; x=1730340429;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c0WUy4in+bHU0hw3OC0v2mLjEjuWrdxL13BRwLDDGS4=;
 b=WJbl9M5Ug1yFrQHoydiwa3rJT0AygMHvPzoFdHKZL5aXVy8kqqMNJXi/zqcusEGhAT
 qz9c4W+Ii5Yi8SlVqWh8XsxnXv6L74MysPcQllK7qwDGdI+cfy3j+pWYJJVZs4li5DcQ
 M3qJDI3NtNIiPuBnRW+eK4FdUFizneD6myc0ttC/tqljEYthRPdA6GaO0aoo3gSuYfio
 pijvIR7myz28KLDs1xIW5a1hU2iEGMMJzu51lxBy7olMvUSgSh/t35D9RejcMex+xFXI
 6VkpJyrMBLvjWe7jep7+aAJZadY8SJNVShg2uZ9UnTYjqEvGc35Y4GjR5aJGhJiIZWNU
 CXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729735629; x=1730340429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c0WUy4in+bHU0hw3OC0v2mLjEjuWrdxL13BRwLDDGS4=;
 b=rFE3gnByEQ3OoEt4f5RMrs7WTTMhaMdY5g9IAjVGm0re6tOJHHbcFb1lbNqeg7eLzK
 zUoPoHyj6ruOUUXvYmVxVFyQAF/uWmvTXHFGUArMSV8C6UM1QwyPMCf0t3DzNOM5wxVw
 D+oR+lL4UVrWdWoUwnGC0ICBtL4YzoveKf11ZU7qxL1iXYfaPGyEa25mGJkvyJjUXrR/
 eomwcaeouaSaP347n9aIrEdq26yTx2CxUYt+sdzyNqKDpd1MgxHfpnIdNW2PZJtSymye
 qepFdvUZoWNnVP0iDGc+qW4tZoKLfLfS6X/KMpsb5+hnSO7A6b6ki6/LYHAmqzwSljt+
 7mtQ==
X-Gm-Message-State: AOJu0YwhTpCp6leQ3Ev+s1E0reT8OaY6fGVqgrnmlhqSrJOZBDtDpZls
 Ca++ibmFT0oL5YTflFySJ8V3IPmyjCwgYNdCyEMYhhTqydKmnp31TqO4mgqxQo20Q9EQgcOdhWv
 RZhXBwNTWdmUPBwbkiyTCsyw0ZPGP9UungYYPoA==
X-Google-Smtp-Source: AGHT+IG0cXXr/PD2areYmCVD12rBrzLuNzsCSrTAl6OVMa8d1plsGuD8bTxWN83OJu5hGG/EEDsZuNbj7EeEApVCKgM=
X-Received: by 2002:a05:6870:3509:b0:270:7a7:eaa5 with SMTP id
 586e51a60fabf-28ced134b05mr361759fac.10.1729735628174; Wed, 23 Oct 2024
 19:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
In-Reply-To: <87sesmdfl4.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 24 Oct 2024 10:06:51 +0800
Message-ID: <CAK9dgmZU+KuJmvqXYjcyFPOQkcH3v-ZfdZEQ6YobTJW7MkPyfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ac505406252f7506"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000ac505406252f7506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wr=
ote:

> yong.huang@smartx.com writes:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > v3:
> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by
> Daniel
> >
> > Please review, thanks
> > Yong
> >
> > v2:
> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
> > 2. Ensure the dependencies when build the initrd-stress.img suggested b=
y
> Daniel
> > 3. Fix some bugs
> >
> > v1:
> > The previous patchset:
> >
> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx=
.com/
> > does not made the necessary changes and tests for the upstream version.
> >
> > This patchset works for that:
> > 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
> > 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
> > 3. Make the necessary changes to adapt the latest multifd behavior
> > 4. A nitpick for multifd migration
> > 5. Support multifd compression option
> >
> > Hyman Huang (5):
> >   tests/migration: Move the guestperf tool to scripts directory
> >   tests/migration: Make initrd-stress.img built by default
> >   guestperf: Support deferred migration for multifd
> >   guestperf: Nitpick the inconsistent parameters
> >   guestperf: Introduce multifd compression option
> >
> >  MAINTAINERS                                   |  5 +++
> >  .../migration/guestperf-batch.py              |  0
> >  .../migration/guestperf-plot.py               |  0
> >  {tests =3D> scripts}/migration/guestperf.py     |  0
> >  .../migration/guestperf/__init__.py           |  0
> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
> >  .../migration/guestperf/engine.py             | 33 ++++++++++++++++---
> >  .../migration/guestperf/hardware.py           |  0
> >  .../migration/guestperf/plot.py               |  0
> >  .../migration/guestperf/progress.py           |  0
> >  .../migration/guestperf/report.py             |  0
> >  .../migration/guestperf/scenario.py           |  7 ++--
> >  .../migration/guestperf/shell.py              |  3 ++
> >  .../migration/guestperf/timings.py            |  0
> >  tests/migration/meson.build                   | 30 +++++++++--------
> >  15 files changed, 73 insertions(+), 20 deletions(-)
> >  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%)
> >  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
> >  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
> >  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
> >  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
>
> Thinking out loud a little bit, it's still somewhat obscure from which

directory this script should be called. None of these invocations work:
>

Indeed, we could document how to build and use the guestperf,
refining it to be more convenient to use.


> $ ./scripts/migration/guestperf.py
>
> $ ./build/scripts/migration/guestperf.py
>
> $ cd scripts/migration
> $ ./guestperf.py
>
> $ cd build/scripts/migration
> $ ./guestperf.py
>
> Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D: =
open() failed:
> No such file or directory
>
> This is the only one that works:
> $ cd build
> $ ./scripts/migration/guestperf.py
>
> Maybe we could improve that somehow in the future.
>
>

--=20
Best regards

--000000000000ac505406252f7506
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 23, 20=
24 at 11:06=E2=80=AFPM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de"=
>farosas@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;border-left-color:rgb(204,204,204);padding-left:1ex"><a href=3D"mailto=
:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> writes:=
<br>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; v3:<br>
&gt; 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by=
 Daniel <br>
&gt;<br>
&gt; Please review, thanks<br>
&gt; Yong<br>
&gt;<br>
&gt; v2:<br>
&gt; 1. Update the MAINTAINERS section suggested by Fabiano Rosas <br>
&gt; 2. Ensure the dependencies when build the initrd-stress.img suggested =
by Daniel<br>
&gt; 3. Fix some bugs<br>
&gt;<br>
&gt; v1:<br>
&gt; The previous patchset:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/cover.1722957352.git.yon=
g.huang@smartx.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/</a><br>
&gt; does not made the necessary changes and tests for the upstream version=
.<br>
&gt;<br>
&gt; This patchset works for that:<br>
&gt; 1. Move the guestperf to scripts directory suggested by Fabiano Rosas<=
br>
&gt; 2. Make initrd-stress.img built by default suggested by Fabiano Rosas<=
br>
&gt; 3. Make the necessary changes to adapt the latest multifd behavior<br>
&gt; 4. A nitpick for multifd migration<br>
&gt; 5. Support multifd compression option<br>
&gt;<br>
&gt; Hyman Huang (5):<br>
&gt;=C2=A0 =C2=A0tests/migration: Move the guestperf tool to scripts direct=
ory<br>
&gt;=C2=A0 =C2=A0tests/migration: Make initrd-stress.img built by default<b=
r>
&gt;=C2=A0 =C2=A0guestperf: Support deferred migration for multifd<br>
&gt;=C2=A0 =C2=A0guestperf: Nitpick the inconsistent parameters<br>
&gt;=C2=A0 =C2=A0guestperf: Introduce multifd compression option<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 5 +++<br>
&gt;=C2=A0 .../migration/guestperf-batch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf-plot.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 {tests =3D&gt; scripts}/migration/guestperf.py=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/comparison.py=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 15 ++++++++-<br>
&gt;=C2=A0 .../migration/guestperf/engine.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 33 ++++++++++++++++---<br>
&gt;=C2=A0 .../migration/guestperf/hardware.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/plot.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/progress.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/report.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/scenario.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 7 ++--<br>
&gt;=C2=A0 .../migration/guestperf/shell.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<br>
&gt;=C2=A0 .../migration/guestperf/timings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 tests/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++++--------<br>
&gt;=C2=A0 15 files changed, 73 insertions(+), 20 deletions(-)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-batch.py (100=
%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-plot.py (100%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf.py (100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/__init__.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/comparison.py=
 (89%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/engine.py (93=
%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/hardware.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/plot.py (100%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/progress.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/report.py (10=
0%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/scenario.py (=
93%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/shell.py (98%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/timings.py (1=
00%)<br>
<br>
Reviewed-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D=
"_blank">farosas@suse.de</a>&gt;<br>
<br>
<br>
Thinking out loud a little bit, it&#39;s still somewhat obscure from which=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
directory this script should be called. None of these invocations work:<br>=
</blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default">Indeed, we could document how=
 to build and use the guestperf,=C2=A0</div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">refining it to be =
more convenient to use.</div></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
$ ./scripts/migration/guestperf.py<br>
<br>
$ ./build/scripts/migration/guestperf.py<br>
<br>
$ cd scripts/migration<br>
$ ./guestperf.py<br>
<br>
$ cd build/scripts/migration<br>
$ ./guestperf.py<br>
<br>
Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D: op=
en() failed:<br>
No such file or directory<br>
<br>
This is the only one that works:<br>
$ cd build<br>
$ ./scripts/migration/guestperf.py<br>
<br>
Maybe we could improve that somehow in the future.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000ac505406252f7506--

