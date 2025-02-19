Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C80C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 01:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkYwI-0008Ci-3e; Tue, 18 Feb 2025 20:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkYw8-0008C0-NL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 20:31:41 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkYw5-0000HY-Dw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 20:31:40 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5fcd811d939so233297eaf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739928693; x=1740533493;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AtdOmxmHBFl5MVl+L+qPTnk4oqE6pGx0TFmxIaTK/Fs=;
 b=nLwuSNLgjBMw1S5QE08dml88u2ntQp17DXxZD26/SYyIgydBBvZRidwJocvLyPHAfX
 h1cXY0yMru2lUXrviCdkVjb/ZuvsjXTVprLzW6C59e1wg40QK/pRx96fHT1zlei2lhCR
 3kNmeSKVClUIm4njvG9cFom6HlW6dstJAE1YoBNUT695GYQZ97K187HY5J6GYxfBHqyU
 qU4SGdhKa2T5HESoHnduzkzycw0dcXgWnl2/eTYXLEdyxJ0VhZ0UAKFzRkqphVV1VkTp
 Xzv0UbZnp9uxNr/kQt9S11UgNSkuchm9ADmb0a4QeZSk6fgKKhrh+4S6xS7ml0Ef0XNH
 zmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739928693; x=1740533493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtdOmxmHBFl5MVl+L+qPTnk4oqE6pGx0TFmxIaTK/Fs=;
 b=bvyfQPZVssyGDzrd9pzBRwzAnK1nx3jFpNV4TBCSVLawxB6o6wtcJt0H4GhBFIMaw5
 su8zRrJDUbcZMi8JdUlIwyZS/Z7KW0yj0H/g4UHr/wLyN4D7KkaTbCYL6xWKbDRMS4IP
 rkQkfcfkO7IR7tpoP5K9mfvoaf9PPboioQKUSe8v3jOseHS+e8xW7wR2tmBHQbXjLvRl
 2c8TLhlrG9V36IcZ8q7tnahPE+trihoblkyjyVD5UE7CU7A9WRpprKkNEUUjsaIuIQET
 i9/EuR6W+y6m8woKVa03g7Wm1AldvR5O/ZISHcEq/nog622uFMv4ZEd9poP8KY6Y4bOM
 rsiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIFyVD1SXZ4Fwi94kz2HZTn438PjWsx1AGBSgGRj+bjOPwri/CAJ5HMOWrsXlUxtF4o6x6plGsGQZ@nongnu.org
X-Gm-Message-State: AOJu0YytaZXqf1mYsqKW/E640AXSWLi/dH8oocvJgLtKfuf1r5vculB+
 mCWnC3cqBRIT+u9/aMY0rBfXZ/dusYjkPT1JmUlhbdFTOH2WSEBahHQ+VA+7yovT+7eAX0D5lrE
 VFdVlOEkhcw0z3Jm7KtGNQ2A3qPnzfq8hn+fNpQ==
X-Gm-Gg: ASbGncuJIfcX9kHljTs+PqoVjtNtz1WZpfhjButruOGUXe2XdYKhOMZ1oVSpJzXVQlm
 QNmTcQelwwaCjW9WO+baAfXuXPfgFgM4ofk71E+yhYxRe9ryKdJgB0RIk1QH7OUoKMFa/Z+xx8m
 4=
X-Google-Smtp-Source: AGHT+IENSWJnz3YRqcWbLv3oh/a8qrOSznvVZNVUQhZ1U02/KmBb3qfS1z/+q/SoeDAxaU7sf5w8uUd7icLmwXAFJU0=
X-Received: by 2002:a05:6808:3996:b0:3f4:bc5:d47a with SMTP id
 5614622812f47-3f40ef52b0fmr1799565b6e.13.1739928693117; Tue, 18 Feb 2025
 17:31:33 -0800 (PST)
MIME-Version: 1.0
References: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
 <Z7TOXfn6BQBhS5uG@x1.local> <87jz9n9hyg.fsf@pond.sub.org>
In-Reply-To: <87jz9n9hyg.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 19 Feb 2025 09:31:17 +0800
X-Gm-Features: AWEUYZl2xXvVfHTjSkD_oz_yio6HrqGsvFKQlC-b-2H6lup_WN1wnFhCNpW8fcg
Message-ID: <CAK9dgmZkgfa4fv3grNijb0p5pDFyYPeNh=m3+B8US9zCEcFjgg@mail.gmail.com>
Subject: Re: [RFC] migration: Introduce migration throttle event
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b02c32062e74b719"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc29.google.com
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

--000000000000b02c32062e74b719
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:24=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Peter Xu <peterx@redhat.com> writes:
>
> > On Tue, Feb 18, 2025 at 10:39:55AM +0800, yong.huang@smartx.com wrote:
> >> From: Hyman Huang <yong.huang@smartx.com>
> >>
> >> When the developer is examining the time distribution of
> >> the migration, it is useful to record the migration throttle
> >> timestamp. Consequently, include the migration throttle event.
> >
> > Would trace_cpu_throttle_set() work too?  That can provide a timestamp
> and
> > also the new percentage of throttle.
> >
> > I don't feel strongly that we must not introduce qmp events for
> debugging,
> > but allowing that to happen means we can get tons of events at last.. a=
s
> > people can start requesting many more events, and we'll need one way to
> > justify them at last.
> >
> > One way to justify events can be that it could be consumed by mgmt.  On
> > that, this one I'm not yet sure.. so ideally tracepoints could work
> already.
>
> Good point.
>
>
Ack
--=20
Best regards

--000000000000b02c32062e74b719
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Feb 19, 2025 at 4:24=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padd=
ing-left:1ex">Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_=
blank">peterx@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Feb 18, 2025 at 10:39:55AM +0800, <a href=3D"mailto:yong.huang=
@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt;&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; <br>
&gt;&gt; When the developer is examining the time distribution of<br>
&gt;&gt; the migration, it is useful to record the migration throttle<br>
&gt;&gt; timestamp. Consequently, include the migration throttle event.<br>
&gt;<br>
&gt; Would trace_cpu_throttle_set() work too?=C2=A0 That can provide a time=
stamp and<br>
&gt; also the new percentage of throttle.<br>
&gt;<br>
&gt; I don&#39;t feel strongly that we must not introduce qmp events for de=
bugging,<br>
&gt; but allowing that to happen means we can get tons of events at last.. =
as<br>
&gt; people can start requesting many more events, and we&#39;ll need one w=
ay to<br>
&gt; justify them at last.<br>
&gt;<br>
&gt; One way to justify events can be that it could be consumed by mgmt.=C2=
=A0 On<br>
&gt; that, this one I&#39;m not yet sure.. so ideally tracepoints could wor=
k already.<br>
<br>
Good point.<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><span class=3D"gmail_d=
efault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ack</spa=
n><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic san=
s ms, sans-serif">Best regards</font></div></div></div>

--000000000000b02c32062e74b719--

