Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D62D74940
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5teK-0007wV-Gs; Tue, 29 Oct 2024 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5teI-0007vf-6o
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:21:10 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5teF-0008Bl-6Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:21:09 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84fe06fbdc6so1670426241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730236865; x=1730841665;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vM4TwgSByAwjE/8uPmOkWGdQzOQ04DQhkwgOetgVghY=;
 b=uHdCXItDEJtAx3UWcaiDiAzh6jNgSh4Gk8F9c5TFr3a1O+jhN9sz4tylbV76Wv+ycZ
 +6xyAb9Q8MUzptQUu/YMx8qnBaFRdIdwlQUpWLbGAAWmcfCr40mMXefSo76LdMyM9DIe
 0qDQJxzWGBC5zOw/V7ZKDrCj8zgpMKpznSkKms9Cm1vCyCo6t62guMDJmGvnV0dfFOyf
 fzpBnayW/vXFB2AVSrtzk/o6c8aVPPlnQsA950uyj5uqQp152hKyyfYQNmsZf3C/M3//
 gOM+K/4X1l9NsQaot925fKSodjHUn6AQCZc3R0EPpJ1VVho04Tyte/qBaQUW8cxoF/74
 zCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236865; x=1730841665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vM4TwgSByAwjE/8uPmOkWGdQzOQ04DQhkwgOetgVghY=;
 b=Jc0/4fQgazOQWVUAxyPn+EXGxYHxg9Oqt572HZaTl3Lo0poR91/H3T4Ii/kJjvJeYu
 rbzEXdMtsRlbn/0JTLA2/1SQtnD6I1zmABwEESb1AHFSYkz2nEmUrKt0B4BtlV5ezaJJ
 XYImi7TBkg5r5S0tv8KrtoR6nbxjMnEAoJYfxM9/FIAG+9eo2CSvVuBmnS9DG1GDUpKz
 m4G+0or22vzBXxnUKIqQKqoWUrTPLbgVWN6yPrt7GQjDYxQkxz9GoC+t5eEogKLXMSZ9
 rWro4LyFMX4qUsSqVbcIsqxOsV0ZdPJO0BG/eQCXRyEUnL2FiErSPx7RTQEfterDbOwa
 b9ow==
X-Gm-Message-State: AOJu0Yx2UlL/r9qEkW3H79c3MG55eusxXzDHpelraQ9MNNYRR9f663is
 5MjioSDbdGrHuGhyAPd9dJVZDRkuoqskgrpa/qmp00oOkTzPJ/o0DQ6kVlQkgjxky5sff5+OzuF
 jn6T6THB8cE3gcWuiv240DKYynJXxI8/U/s80
X-Google-Smtp-Source: AGHT+IFCZUDVtQPvXMT+DM7TUBuVOxKbphCii00tVwzsU2yHo08+YD7nTKeDPcXYYXsva8aRFM6sBzrlzGHvK2Njfoo=
X-Received: by 2002:a05:6102:f13:b0:4a4:9194:d2c1 with SMTP id
 ada2fe7eead31-4a8cfd72365mr11581446137.27.1730236864115; Tue, 29 Oct 2024
 14:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <871q0xmwzb.fsf@draig.linaro.org>
In-Reply-To: <871q0xmwzb.fsf@draig.linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 29 Oct 2024 22:20:53 +0100
Message-ID: <CAAibmn0wc6a-BM+kC6MJDTAFJoaAR4cVnVd6dr1G6eC8Lt_QBw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] macOS PV Graphics and new vmapple machine type
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, akihiko.odaki@daynix.com, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a9d1580625a42988"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92a;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000a9d1580625a42988
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 10:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

>
> > There are currently a few limitations to this which aren't intrinsic,
> > just imperfect emulation of the VZF, but it's good enough to be just
> > about usable for some purposes:
> >
> >  * macOS 12 guests only. Versions 13+ currently fail during early boot.
> >  * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some difference=
s
> >    between Apple M series CPUs and TCG's aarch64 implementation? macOS
> >    hosts only because ParavirtualizedGraphics.framework is a black box
> >    implementing most of the logic behind the apple-gfx device.)
>
> We don't currently have TCG CPU models for the Apple Silicon processors.
> They are not too hard to add (basically setting the correct ID register
> bits, c.f. aarch64_neoverse_n1_initfn for an example). However that
> would only cover Aarch64 architectural features. We do no modelling of
> the extra instructions that Apple added (although in theory that should
> only be run in Apples own ML libraries).
>

This really isn't my area of expertise, and I don't see myself attempting
to make it work with TCG. Given that the OS only boots with the PV graphics
device, you can only really use this machine type on a macOS host, so there
aren't many reasons to use TCG over HVF. I suppose it might make debugging
the myriad other rough edges easier!

--000000000000a9d1580625a42988
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 3 Oct 2024 at 10:06, Alex Ben=
n=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
&gt; There are currently a few limitations to this which aren&#39;t intrins=
ic,<br>
&gt; just imperfect emulation of the VZF, but it&#39;s good enough to be ju=
st<br>
&gt; about usable for some purposes:<br>
&gt;<br>
&gt;=C2=A0 * macOS 12 guests only. Versions 13+ currently fail during early=
 boot.<br>
&gt;=C2=A0 * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some diff=
erences<br>
&gt;=C2=A0 =C2=A0 between Apple M series CPUs and TCG&#39;s aarch64 impleme=
ntation? macOS<br>
&gt;=C2=A0 =C2=A0 hosts only because ParavirtualizedGraphics.framework is a=
 black box<br>
&gt;=C2=A0 =C2=A0 implementing most of the logic behind the apple-gfx devic=
e.)<br>
<br>
We don&#39;t currently have TCG CPU models for the Apple Silicon processors=
.<br>
They are not too hard to add (basically setting the correct ID register<br>
bits, c.f. aarch64_neoverse_n1_initfn for an example). However that<br>
would only cover Aarch64 architectural features. We do no modelling of<br>
the extra instructions that Apple added (although in theory that should<br>
only be run in Apples own ML libraries).<br></blockquote><div><br></div><di=
v>This really isn&#39;t my area of expertise, and I don&#39;t see myself at=
tempting to make it work with TCG. Given that the OS only boots with the PV=
 graphics device, you can only really use this machine type on a macOS host=
, so there aren&#39;t many reasons to use TCG over HVF. I suppose it might =
make debugging the myriad other rough edges easier!</div><div><br></div><di=
v><br></div></div></div>

--000000000000a9d1580625a42988--

