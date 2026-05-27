Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC0FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHqr-0006kW-J0; Wed, 27 May 2026 13:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHqo-0006k8-HB
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:15:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHqd-0003m1-PW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:15:18 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b458ca2296so90118595ad.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779902114; cv=none;
 d=google.com; s=arc-20240605;
 b=h9UXWoljchkwbCjnleFBLRBkZzxs5kBULEq4taRZjw89UapgQXusw9IcU5I6QX4EVV
 4EY4UTYSi6fIuDGo6Dgp++EGi+pWpF4doXrI1wKHStMPZJPFb43cFtSX0bQaWNplxUU9
 wqWvOsYUa2ySMkR9Ox7m5acqhudpvbLM3b5+TPzhahIEYO+i0Gv5cQrj38RMRDQSGyJb
 TCVLkdgwBf0PH8Th85HNCGnip7ybkkdEc+uXDqNj9X6kBde9yIJdN7onpvQdQXbiGww0
 qZXtQsM7kXbQPYWmOI4Yxwor/EU2qODwoNq1yNf/2k+aYlcQIzC2aoJ17NafXm16ed/i
 SrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jgy67p0ITUo1OZVAWHrgOKttAvnm+ewWOh3a3RXLNd4=;
 fh=FRWEELF+eTUGfZQVkAjSb6CD5wgsMWqxkZKu5jTQ4ZE=;
 b=d/Zsz81DFaTuW2MZruSqFMS84MzIef0A60u8CN35fWErOg/QeJ4xOOTarOcN31LI4Q
 pf0v8VhB7xRG+rBJX4OEHcZDgIMvoL3Qs8sbYR8Um8/uJw7VpqO0a+1Gitfie65R0ZHa
 Z/LiotacvnubfS56fxx1FgzytQuUH7F9/JafTtty/0XxaZvXwQHo7HVdqny6qsl9zYjC
 nCwQhyJ2nq4K/JPr9q6scUO+jw4i1dhxF39GsB6iMUatNbV+A0EvcuhDypb2qXH7K3Ks
 5fKBAcM20AGFcZPE/ZhR6Q2+ahkr+ZG7BhFqT+/0+L0e4FbPTK2wrE2dVEZvwQLig5Mn
 t/wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779902114; x=1780506914;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jgy67p0ITUo1OZVAWHrgOKttAvnm+ewWOh3a3RXLNd4=;
 b=aORsTP7Yn/SUAybBcjXyPPkLMNKGuoixc6ulgqU/sUwhXugI1jCKN2gvSWcmpRxAXw
 9eUu7G0ErkgAP37f/DFjP18S0dq7sg6whgxfiTAFDsKQGtF+yzeCUpZBuAbOHGVvkcPE
 sg9m6dbOcQQqwHs9eVSqc2t+cMe2Tq7MQa/kDvoGvx6Mz5cfDcA4SJpdOMcDktni2oiB
 FrRtk4z/DjVvfEN4OdxJjnsRgRgMTJl4Webzj9v94QhjH8r9CTxgymU65Qrtj/tCSoTD
 B1eQFmtVT+QTpFoRchU6vUsv4S14pw7IqkvWAz3wdq3eengm+HX4dHpuk7ZJKtAOhHJ8
 C6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779902114; x=1780506914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgy67p0ITUo1OZVAWHrgOKttAvnm+ewWOh3a3RXLNd4=;
 b=IZ/VLl7Ev3v91ZjICcyAjhYQUrXAp+dJHOOCWt2KaTGkzQMOD2nqD31gT820R94FYZ
 CyiyqQ8r22QTkLZntCcQgW9IZEmbKQWQfwIwq1Dj/2Qg1zzu8I8ErwlQdRIgCyPvZasM
 DRlqn3hHupqPGphgPbKLr39vSw9WZsSKpev5RWPiXxIZGtpKVLTZWLksZn5GLNJBVGaw
 7vNE3M5UNbWDaVDYaYU96Yx6AMx/L/Hiescu0MmjwhZ36sGH92mSD9LvxOLrJUMk6/9j
 bEPeqLBD0JqwNhNRni2QiegCk6RbcRxI4zak6o1fYZCyym3smUbEoqtu2crY8DZgaK84
 QOZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dHA5aCRF3ZIAh3m5W6KesreSudR6Mj2q9R7Cx8Tib6R9qgqLmmtLpqBMiA2dALGjX9GoxeqzsEjeS@nongnu.org
X-Gm-Message-State: AOJu0YxOU9NeqYmadsWgrcpGp4KRfKf3yaVHNnH1G3H0fF6peJjzNvXA
 oKRkdNTBnKkijOn8gLHT177+Dd2BnCLnyavyVnEUtFeMCrnZyjecWAGJyrh23VPoJZcZ2l2c08L
 9uqs6n6OK+5ElptwsHH/hebRv69KXhJTHaHrFKlYE1Q==
X-Gm-Gg: Acq92OFZDoY4fUEgMQNjDjMTSEVQmCtC1KycawGB5aLUmCwGWSB1m5LPAPYXSgpmE+X
 J14iZ8s/rovETaqShKX9Jrle2gAK9riDpjS5SiovyX+k96bVPPvc3MdVbIwkA6HP3Dev/lIDtzM
 Qc3VjSWDmZy9M3g092UCe2S/cihSjJ9aVSbF3CKi5/hU7gdFyvxtqHj4ZPCZqXPnsNi7+SSsPvS
 0wYZDIW8W0hIDV6cJoptkThupXH459Xsiv1o/uOhLgJFkGJG1eYtBJM/fsTyRLPm/vn/FplN+pW
 mWaeyG8JnoXFk4iVJA==
X-Received: by 2002:a17:902:cecc:b0:2b9:86ca:5bf2 with SMTP id
 d9443c01a7336-2beb06732c3mr266296145ad.30.1779902113584; Wed, 27 May 2026
 10:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com> <20260527123942-mutt-send-email-mst@kernel.org>
 <ahcgxpvXFoPE0C-X@redhat.com> <20260527130518-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260527130518-mutt-send-email-mst@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 27 May 2026 11:15:02 -0600
X-Gm-Features: AVHnY4KE6muFIxI2QE-r-ElobAxW4MilgI_vwDCaLBE62QzhZtJYCK-XonbjH44
Message-ID: <CANCZdfqnEVuf+mJ9B7_C-bmiKvFg5a3uCorufxkTUZiXdXQ3qg@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000372cdd0652cfc12b"
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000372cdd0652cfc12b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:06=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:

> On Wed, May 27, 2026 at 06:50:14PM +0200, Kevin Wolf wrote:
> > Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:
> > > On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> > > > Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > > > > On Wed, May 27, 2026 at 4:01=E2=80=AFAM Paolo Bonzini <pbonzini@r=
edhat.com>
> wrote:
> > > > > > Commit messages for AI-assisted changes
> > > > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > >
> > > > > > When AI/LLM tools produce or substantively shape your patch, ad=
d
> an
> > > > > > ``AI-used-for:`` trailer.  The text of the trailer could be one
> or more
> > > > > > of ``code``, ``tests``, ``docs``, ``research``, possibly
> followed by an
> > > > > > explanation in parentheses::
> > > > > >
> > > > > >      AI-used-for: tests, docs
> > > > > >      AI-used-for: code
> > > > > >      AI-used-for: code (refactoring)
> > > > > >      AI-used-for: code (prototype)
> > > > > >      AI-used-for: research
> > > > > >
> > > > > > The trailer is intended as a clarification of your DCO
> obligations as
> > > > > > well as to guide reviewers.  It is not intended for minimal
> presence
> > > > > > such as autocomplete or asking for a pre-review of the patch,
> and it
> > > > > > does not remove your responsibility to understand the changes
> that you
> > > > > > are submitting.
> > > > >
> > > > > Why invent something new here when Assisted-by: is used elsewhere
> > > > > and is likely more familiar to other users.
> > > >
> > > > Because Assisted-by: gives different information, which at least to
> me
> > > > isn't really interesting at all. It's much more interesting to me i=
f
> the
> > > > code I'm looking at is generated, or if you only generated the test=
s.
> > >
> > > I personally am interested to know which models work better than
> others.
> > > Contributions are about reputation not just code.  I'll learn which
> > > models produce better output, just like I learn to trust specific
> > > contributors better.
> >
> > You don't see how well the model worked. What you see is filtered by th=
e
> > submitter, and the policy we're discussing is specifically made to make
> > sure that bad results never reach the list.
> >
> > Even for things that do reach the list, Assisted-by: doesn't tell you
> > how much of the submission is AI-generated and it also doesn't tell you
> > if it's "I used model X and a simple prompt gave me the perfect result
> > in the first attempt" or "I used model X and it took me two days of bac=
k
> > and forth and eventually I just rewrote most of it, but there are a few
> > AI-generated lines left".
>
> I am capable of observing trends over multiple contributions from
> multiple people.
>

As the primary person landing commits on the FreeBSD github experiment,
I can say that I have observed trends over multiple committer and can
spot the ones using Claude + Opus 4.5 or 4.6.

Warner

--000000000000372cdd0652cfc12b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 11:06=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redh=
at.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Wed, May 27, 2026 at 06:50:14PM +0200, Kevin Wolf =
wrote:<br>
&gt; Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:<br>
&gt; &gt; On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:<br>
&gt; &gt; &gt; Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:<br>
&gt; &gt; &gt; &gt; On Wed, May 27, 2026 at 4:01=E2=80=AFAM Paolo Bonzini &=
lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat=
.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; Commit messages for AI-assisted changes<br>
&gt; &gt; &gt; &gt; &gt; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; When AI/LLM tools produce or substantively shape y=
our patch, add an<br>
&gt; &gt; &gt; &gt; &gt; ``AI-used-for:`` trailer.=C2=A0 The text of the tr=
ailer could be one or more<br>
&gt; &gt; &gt; &gt; &gt; of ``code``, ``tests``, ``docs``, ``research``, po=
ssibly followed by an<br>
&gt; &gt; &gt; &gt; &gt; explanation in parentheses::<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: tests, docs<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (refactoring=
)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (prototype)<=
br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: research<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The trailer is intended as a clarification of your=
 DCO obligations as<br>
&gt; &gt; &gt; &gt; &gt; well as to guide reviewers.=C2=A0 It is not intend=
ed for minimal presence<br>
&gt; &gt; &gt; &gt; &gt; such as autocomplete or asking for a pre-review of=
 the patch, and it<br>
&gt; &gt; &gt; &gt; &gt; does not remove your responsibility to understand =
the changes that you<br>
&gt; &gt; &gt; &gt; &gt; are submitting.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Why invent something new here when Assisted-by: is used=
 elsewhere<br>
&gt; &gt; &gt; &gt; and is likely more familiar to other users.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Because Assisted-by: gives different information, which at l=
east to me<br>
&gt; &gt; &gt; isn&#39;t really interesting at all. It&#39;s much more inte=
resting to me if the<br>
&gt; &gt; &gt; code I&#39;m looking at is generated, or if you only generat=
ed the tests.<br>
&gt; &gt; <br>
&gt; &gt; I personally am interested to know which models work better than =
others.<br>
&gt; &gt; Contributions are about reputation not just code.=C2=A0 I&#39;ll =
learn which<br>
&gt; &gt; models produce better output, just like I learn to trust specific=
<br>
&gt; &gt; contributors better.<br>
&gt; <br>
&gt; You don&#39;t see how well the model worked. What you see is filtered =
by the<br>
&gt; submitter, and the policy we&#39;re discussing is specifically made to=
 make<br>
&gt; sure that bad results never reach the list.<br>
&gt; <br>
&gt; Even for things that do reach the list, Assisted-by: doesn&#39;t tell =
you<br>
&gt; how much of the submission is AI-generated and it also doesn&#39;t tel=
l you<br>
&gt; if it&#39;s &quot;I used model X and a simple prompt gave me the perfe=
ct result<br>
&gt; in the first attempt&quot; or &quot;I used model X and it took me two =
days of back<br>
&gt; and forth and eventually I just rewrote most of it, but there are a fe=
w<br>
&gt; AI-generated lines left&quot;.<br>
<br>
I am capable of observing trends over multiple contributions from<br>
multiple people.<br></blockquote><div><br></div><div>As the primary person =
landing commits on the FreeBSD github experiment,</div><div>I can say that =
I have observed trends over multiple committer=C2=A0and can</div><div>spot =
the ones using Claude=C2=A0+ Opus 4.5 or 4.6.</div><div><br></div><div>Warn=
er</div></div></div>

--000000000000372cdd0652cfc12b--

