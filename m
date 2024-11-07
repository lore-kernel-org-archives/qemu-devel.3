Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C68D4337D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95qQ-0006bB-W7; Thu, 07 Nov 2024 11:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t95qG-0006Uc-Im
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t95qE-0008IJ-N2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730998719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6VYJCg7GUeNoXOgSQqL+x9ysryUhRg15+Jb+cSLpN0=;
 b=FE2X1KDARTMH2B/rBHhTE4ZNAiT0YWPAvUg19bfomEHRnr/pVllL/VPtv0ixplHEEks9+b
 S+lUdGJcRoz+zQn+55S0EfphkQF0ZtRk0RURtX37mOZX+d3Phr3OpjXjWxijHZNS+Dq3WR
 Qe7hlUdOCkdfAd+WtJ8ikp0/tk63hMo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-qXcbV9YdN9eReoydJ_u9qQ-1; Thu, 07 Nov 2024 11:58:37 -0500
X-MC-Unique: qXcbV9YdN9eReoydJ_u9qQ-1
X-Mimecast-MFC-AGG-ID: qXcbV9YdN9eReoydJ_u9qQ
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7edbbc3a9f2so759227a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730998716; x=1731603516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6VYJCg7GUeNoXOgSQqL+x9ysryUhRg15+Jb+cSLpN0=;
 b=i8GCeko8FDo0zBPYcYKXbE7PIjK1qbG4dLpkaf5Jm3CQDrKDt0I7m/WwAf7aN5GbOo
 pXBYiG2kelTV9b8r4WVLVm7QhWKGIuwgzSOUbXdfetlU1mFhbLSD7US+kzZ/W/JcWSjM
 1dlBV1P5pJ5vErCrqPTSEJzHECACPOymFBaC9iWe07SGOLIwuhO9uf0C7gAjn/dAgxGm
 v4cFz76oFjEAUWdCg703XSGnUBr1uGANAN+76AMt1c+ZzyP8VeVdH4Q44ZxJ1E5UgC4j
 MBI2z33k0kqjpvfrSS3kbH6FAT9UEmT4p+jc8bSU7Ij/nxRBCieAd339gIoiqraAqCL8
 0RAw==
X-Gm-Message-State: AOJu0YxLI5KmwB+6QfamnzI3QG56JkKEcNN2zL9zAN6dWiEf+QAWUx0N
 X8cyC84qFAcj1UvbTbPEEA4vGfiRuwCwCGEiAS/Q4vsYFAwlWYxn7KoBI7wnqaNGKYvnINM6qr2
 EiIqUAh9H+zzMWYZkNnRrjlW0j7mNYs8/9KQcUL86iJHYRq0VhIJHEYDQEdhoVIDEfobmAIbzPB
 PgStSH/gNllSe5VTI0nawG/TmzU9o=
X-Received: by 2002:a17:90a:3485:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2e8f10773cemr43129629a91.17.1730998716339; 
 Thu, 07 Nov 2024 08:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp0hpH+iK9ynGLnEsG6KNyQ3aVdxAkm9Q+ldWb0gPKkFfQTo9PGSkEMk6+WgWa/vNibSQIcgbsRTf4WwQkzgg=
X-Received: by 2002:a17:90a:3485:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2e8f10773cemr43129613a91.17.1730998716000; Thu, 07 Nov 2024
 08:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20241101173700.965776-1-jsnow@redhat.com>
 <Zys9g8akOqlpuMQx@redhat.com>
In-Reply-To: <Zys9g8akOqlpuMQx@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Nov 2024 11:58:22 -0500
Message-ID: <CAFn=p-YwUnxb_iW_9oW5x3rwBOQMFq6ndnD-pD+Z8j5yPLeRdg@mail.gmail.com>
Subject: Re: [PATCH 0/4] python: update linting for new mypy/pylint releases
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000930a2c0626558beb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000930a2c0626558beb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:57=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 01.11.2024 um 18:36 hat John Snow geschrieben:
> > Various python tests in the "check-python-tox" test case on GitLab have
> > begun failing due to newer package versions. This patch set corrects
> > those issues and also improves the reliability of local developer tests
> > which may be using these tooling versions outside of GitLab pinned
> > version tests.
> >
> > There are remaining issues with the "check-dev" test I have yet to
> > rectify, but appear unrelated to linter versions specifically and will
> > be handled separately.
> >
> > As a result of this patch, the optionally-run and may-fail
> > "check-python-tox" test case on GitLab will become green again, and
> > local invocations of "make check-tox" in the python subdirectory will
> > also pass again. "check-python-minreqs" on GitLab and "make
> > check-minreqs" in the local developer environment were/are
> > unaffected. local iotest invocations for test case #297 ought to now
> > begin passing on developer workstations with bleeding-edge python
> > packages.
> >
> > John Snow (4):
> >   iotests: reflow ReproducibleTestRunner arguments
> >   iotests: correct resultclass type in ReproducibleTestRunner
> >   python: disable too-many-positional-arguments warning
> >   python: silence pylint raising-non-exception error
>
> Thanks, applied to the block branch.
>

Thank you!


>
> (Yes, of course I had to wait until I ran into the problem patch 2 fixes
> myself, and after figuring out the fix from the incomprehensible error
> message, I found that this series already contains it.)
>

Sorry O:-)

The only issue remaining I'm aware of (besides the broader problem of
iotests not using pinned versions yet) is that "make check-dev" is failing
due to (maybe?) some changes in bleeding edge setuptools (?) that impact
how editable packages are installed. That test is only ever manually run
and developer-local though, so I think it shouldn't get in anyone's way but
mine.

If there's something else you're noticing, I'm unaware of it atm and you
should definitely let me know about it.


>
> Kevin
>
>

--000000000000930a2c0626558beb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 6, 2024 at 4:57=E2=80=AFA=
M Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 01.=
11.2024 um 18:36 hat John Snow geschrieben:<br>
&gt; Various python tests in the &quot;check-python-tox&quot; test case on =
GitLab have<br>
&gt; begun failing due to newer package versions. This patch set corrects<b=
r>
&gt; those issues and also improves the reliability of local developer test=
s<br>
&gt; which may be using these tooling versions outside of GitLab pinned<br>
&gt; version tests.<br>
&gt; <br>
&gt; There are remaining issues with the &quot;check-dev&quot; test I have =
yet to<br>
&gt; rectify, but appear unrelated to linter versions specifically and will=
<br>
&gt; be handled separately.<br>
&gt; <br>
&gt; As a result of this patch, the optionally-run and may-fail<br>
&gt; &quot;check-python-tox&quot; test case on GitLab will become green aga=
in, and<br>
&gt; local invocations of &quot;make check-tox&quot; in the python subdirec=
tory will<br>
&gt; also pass again. &quot;check-python-minreqs&quot; on GitLab and &quot;=
make<br>
&gt; check-minreqs&quot; in the local developer environment were/are<br>
&gt; unaffected. local iotest invocations for test case #297 ought to now<b=
r>
&gt; begin passing on developer workstations with bleeding-edge python<br>
&gt; packages.<br>
&gt; <br>
&gt; John Snow (4):<br>
&gt;=C2=A0 =C2=A0iotests: reflow ReproducibleTestRunner arguments<br>
&gt;=C2=A0 =C2=A0iotests: correct resultclass type in ReproducibleTestRunne=
r<br>
&gt;=C2=A0 =C2=A0python: disable too-many-positional-arguments warning<br>
&gt;=C2=A0 =C2=A0python: silence pylint raising-non-exception error<br>
<br>
Thanks, applied to the block branch.<br></blockquote><div><br></div><div>Th=
ank you!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
(Yes, of course I had to wait until I ran into the problem patch 2 fixes<br=
>
myself, and after figuring out the fix from the incomprehensible error<br>
message, I found that this series already contains it.)<br></blockquote><di=
v><br></div><div>Sorry O:-)</div><div><br></div><div><div>The only issue re=
maining I&#39;m aware of (besides the broader problem=20
of iotests not using pinned versions yet) is that &quot;make check-dev&quot=
; is=20
failing due to (maybe?) some changes in bleeding edge setuptools (?)=20
that impact how editable packages are installed. That test is only ever=20
manually run and developer-local though, so I think it shouldn&#39;t get in=
=20
anyone&#39;s way but mine.</div><div><br></div><div>If there&#39;s somethin=
g else you&#39;re noticing, I&#39;m unaware of it atm and you should defini=
tely let me know about it.</div></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div>

--000000000000930a2c0626558beb--


