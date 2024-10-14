Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5438D18158
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Toj-0004du-8U; Mon, 14 Oct 2024 18:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t0Toc-0004dH-N6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:45:28 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t0ToZ-0003Ak-ME
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:45:26 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso2977977a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1728945921; x=1729550721;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o0G+fHGmlxGZknduHykTBG/2v1aDLLDLXHsEXf5hswU=;
 b=eB3Hh6kPuM60uOKm0uTa9J+OjtpW7ZcDG7YLWpUdtrkjnfKig3YHUahtBzHZTPxjgF
 e7Eu3eBh26XwIzxzQf5T6ZMTfqTcYoTRuibqwholpCt+7KVy7lBjyQKirj9KGv2cjoJB
 cqcBYpakOff1T+ElygrfYONJWIAryjgksa4WPFMxCH/MQkVjpKSRsUuB4ojCxHhChZl2
 +FkX5rHNq0E5Jt3yp8292EJLK4Jr0JYMcDrkKUiFAaqNsCsHsle4nRoE5G2ctW6F5WZB
 EJZTeS8kcTqb0PWBXVvUVxDnG3lJy3evKQTPBeQNUxWelzHHyE+jhRO2ntI8aVK1cA/8
 rv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945921; x=1729550721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0G+fHGmlxGZknduHykTBG/2v1aDLLDLXHsEXf5hswU=;
 b=aH/j++YMCPYwpq97N3VBWhNvAK6whMs744b5QRk4mu4He4erNQWfQHIFxReEMTTTuD
 0IefM6RvB/SnFqDt+j/2DqljpSOmFZdACdA0K0GWQWbrzoFyIp6IvFITFcG+M+B70Zwq
 HYVf7Yknbc7cL4iwRkDpvzIQauN4p+5zDtaIlBv3RXkJdi0jV9ixFMvJITQI3LX0aTMx
 c0TnrgSO+oPGQx53jjYcUpVOm2w7JpdNEG75GoQYm6y0YCTcB0clEFGERUAaq/C9BoKG
 I3lQ6FF9u2s7JFBMpaRY9JoXT+l1nmxcCzJU+TPc2C2OTIBfnv3wUPBMEQgP53ESLE0u
 ckIg==
X-Gm-Message-State: AOJu0Yx8SPJMnuXBVK7WQXFUNFG5M6Ed02KH+QAoM3+qrJsS7T5bG8Tw
 zogss6K5z2yqHypNT4VMR8EvlS5g3kZWVIHMuyzsDgxTXy/COiofk23XwGm+EchpTWYlP1g8jNH
 rX+Q208yTpdnhrlROTAQHN2FkCuUlvom6n+QBCA==
X-Google-Smtp-Source: AGHT+IFGHi+CZbvmEWhSEjs85Wvh2/3NbNXm0txiiRskSSZrwJRfvw7WLUlLKRk1PIluvkmvI5b26SvC3cNjDDCA39s=
X-Received: by 2002:a05:6a21:2d09:b0:1d5:377c:2244 with SMTP id
 adf61e73a8af0-1d8bc993b0cmr22033999637.20.1728945921153; Mon, 14 Oct 2024
 15:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
 <CANCZdfpWN+nYGLBtMb5xdpFW+=iGZ473UhknLN0vW6PyHSQScQ@mail.gmail.com>
 <87v7y9ldbu.fsf@draig.linaro.org>
In-Reply-To: <87v7y9ldbu.fsf@draig.linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 14 Oct 2024 16:45:10 -0600
Message-ID: <CANCZdfq85yJTkTR3TZQ=XmaeLmfxrQCQj6g-0viFaCidsOKwWQ@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org, bofh@freebsd.org, 
 emulation@freebsd.org, virtualization@gentoo.org, dilfridge@gentoo.org, 
 hi@alyssa.is, edolstra+nixpkgs@gmail.com, brad@comstyle.com, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000777a2806247797b3"
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x531.google.com
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

--000000000000777a2806247797b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[[ sorry for the lag $LIFE has been over-full lately ]]

On Thu, Oct 3, 2024 at 3:56=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Warner Losh <imp@bsdimp.com> writes:
>
> > On Thu, Oct 3, 2024 at 2:53=E2=80=AFAM Warner Losh <imp@bsdimp.com> wro=
te:
> >
> >  On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@=
linaro.org>
> wrote:
> >
> >  One output from this discussion should be a clear statement that we ar=
e
> >  going forward with this work and the road map. A rough roadmap might
> >  look like:
> >
> >    - 9.2   --enable-rust is available and developers can build with it.
> >            rust devices have -x-device or -rust-device CLI flags for
> >            runtime selection.
> >
> >    - 10.x  rust devices feature complete and migration compatible,
> enabled
> >            by default when rust compiler detected. No CLI selection
> >            required as legacy portions won't be built. Any partial
> >            conversions should be behind --enable-prototype-rust configu=
re
> >            flag.
> >
> >    - 11.x  distros have enough infrastructure to build on supported
> >            platforms. Rust becomes a mandatory dependency, old C versio=
ns
> >            of converted code removed from build.
> >
> >    - xx.y  QEMU becomes a pure native rust program and all C is expunge=
d.
> >            We may never get to this point.
> >
> >  We should publish the intention and the road map prominently although =
it
> >  was unclear if a blog post would be the best place vs expanding a
> >  section in the developers manual. Perhaps both make sense with a blog
> >  post for the statement of intent and rough timeline and the developer
> >  manual being expanded with any new rules and standards to follow?
> >
> >  FreeBSD is Tier 1 in rust only for amd64 (x86_64). It's Tier 2 for i38=
6
> (which
> >  admittedly is going away) and Tier 3 for everything else.
> >
> > oops, I should have said it's Tier 2 with hosts for amd64, Tier 2 w/o
> hosts and
> > tier 3 for aarch64 (and everything else). In FreeBSD, amd64 and aarch64
> are
> > tier 1 supported platforms and I got those confused. It is an important
> difference
> > and later in my email I refer to it, so I thought a correction was in
> > order.
>
> Are there any other big projects coming down the line that have
> indicated a need for rust support?


There's a few things that may happen to help drive rust. People
have written a few things in rust that they hope to make default
once FreeBSD finishes its transition to pkgbase (though that's some
time in the future). There's also a desire to experiment with rust drivers
in the kernel for more fringe features to see if that helps us get done
faster.


> Obviously you don't have to worry
> about the Linux kernel but I wonder how much rust userspace you
> currently have packaged? Do you have the rust-vmm vhost-device binaries
> for example?
>

Yes. I believe we build those today.

I expect it to mostly work, most of the time, to be honest on FreeBSD. I
also
expect there to be more breakage than we see with llvm/clang...

So the bottom line should be that we'll be able to make it work, but there
is likely going to be more work since rust is less mature than C. However,
it's not clear if this is an occasional minor thing, or if it becomes major
and
frequent. And the only way to know that is to take the plunge, so don't
let this stop your plans.

Warner

--000000000000777a2806247797b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">[[ sorry=C2=A0for the lag $LIFE has been =
over-full lately ]]</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Oct 3, 2024 at 3:56=E2=80=AFAM Alex Benn=C3=A9e =
&lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Warner =
Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com=
</a>&gt; writes:<br>
<br>
&gt; On Thu, Oct 3, 2024 at 2:53=E2=80=AFAM Warner Losh &lt;<a href=3D"mail=
to:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e &lt;<a =
href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro=
.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 One output from this discussion should be a clear statement that=
 we are<br>
&gt;=C2=A0 going forward with this work and the road map. A rough roadmap m=
ight<br>
&gt;=C2=A0 look like:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - 9.2=C2=A0 =C2=A0--enable-rust is available and develope=
rs can build with it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rust devices have -x-device o=
r -rust-device CLI flags for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runtime selection.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - 10.x=C2=A0 rust devices feature complete and migration =
compatible, enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 by default when rust compiler=
 detected. No CLI selection<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required as legacy portions w=
on&#39;t be built. Any partial<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversions should be behind =
--enable-prototype-rust configure<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - 11.x=C2=A0 distros have enough infrastructure to build =
on supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 platforms. Rust becomes a man=
datory dependency, old C versions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of converted code removed fro=
m build.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - xx.y=C2=A0 QEMU becomes a pure native rust program and =
all C is expunged.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 We may never get to this poin=
t.<br>
&gt;<br>
&gt;=C2=A0 We should publish the intention and the road map prominently alt=
hough it<br>
&gt;=C2=A0 was unclear if a blog post would be the best place vs expanding =
a<br>
&gt;=C2=A0 section in the developers manual. Perhaps both make sense with a=
 blog<br>
&gt;=C2=A0 post for the statement of intent and rough timeline and the deve=
loper<br>
&gt;=C2=A0 manual being expanded with any new rules and standards to follow=
?<br>
&gt;<br>
&gt;=C2=A0 FreeBSD is Tier 1 in rust only for amd64 (x86_64). It&#39;s Tier=
 2 for i386 (which<br>
&gt;=C2=A0 admittedly is going away) and Tier 3 for everything else.<br>
&gt;<br>
&gt; oops, I should have said it&#39;s Tier 2 with hosts for amd64, Tier 2 =
w/o hosts and<br>
&gt; tier 3 for aarch64 (and everything else). In FreeBSD, amd64 and aarch6=
4 are<br>
&gt; tier 1 supported platforms and I got those confused. It is an importan=
t difference<br>
&gt; and later in my email I refer to it, so I thought a correction was in<=
br>
&gt; order.<br>
<br>
Are there any other big projects coming down the line that have<br>
indicated a need for rust support?</blockquote><div><br></div><div>There&#3=
9;s a few things that may happen to help drive rust. People</div><div>have =
written a few things in rust that they hope to make default</div><div>once =
FreeBSD finishes its transition to pkgbase (though that&#39;s some</div><di=
v>time in the future). There&#39;s also a desire to experiment with rust dr=
ivers</div><div>in the kernel for more fringe features to see if that helps=
 us get done</div><div>faster.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Obviously you don&#39;t have to worry<br>
about the Linux kernel but I wonder how much rust userspace you<br>
currently have packaged? Do you have the rust-vmm vhost-device binaries<br>
for example?<br></blockquote><div><br></div><div>Yes. I believe we build th=
ose today.</div><div><br></div><div>I expect it to mostly work, most of the=
 time, to be honest on FreeBSD. I also</div><div>expect there to be more br=
eakage than we see with llvm/clang...</div><div><br></div><div>So the botto=
m line should be that we&#39;ll be able to make it work, but there</div><di=
v>is likely going to be more work since rust is less mature than C. However=
,</div><div>it&#39;s not clear if this is an occasional minor thing, or if =
it becomes major and</div><div>frequent. And the only way to know that is t=
o take the plunge, so don&#39;t</div><div>let this stop your plans.</div><d=
iv><br></div><div>Warner</div></div></div>

--000000000000777a2806247797b3--

