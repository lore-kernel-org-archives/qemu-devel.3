Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10E9C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIYL-0008Ev-Ry; Tue, 06 May 2025 09:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIYI-00089Y-Cz
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIYF-0001sE-48
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746538896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHDIHWX7qWxNZZRJ62NLU5+TztQ2fwErQTRDLh+XmsU=;
 b=XPRYR1g2LyuMhMhyj1ka2N1ys7D2+gUPyZW/kPBJvqC6Gk61X5NBy5HzF/0ql6kxV9uMD8
 b6gRFA/FyX5u6ZJ+/we8RDkVdLPKTsFC+RT2lqbt+pgovk4u+GzKhegL7VBAvrNtywood/
 887gSSuwQHg3jVof3UHrJNBnaS6w4VM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-UcWBcIDoPE2JrP_hHn6Eog-1; Tue, 06 May 2025 09:41:35 -0400
X-MC-Unique: UcWBcIDoPE2JrP_hHn6Eog-1
X-Mimecast-MFC-AGG-ID: UcWBcIDoPE2JrP_hHn6Eog_1746538894
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so41806835e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746538894; x=1747143694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FHDIHWX7qWxNZZRJ62NLU5+TztQ2fwErQTRDLh+XmsU=;
 b=DXEGizVmlkSDoVKu6t8memfdoXxshDkq+Vla7y0uw/DRN3Qz5fD789sC6bZGa6FfHt
 lg80+nEMgQbNMdZMsyNHKJPWM9Y8UEwye6aHRaayK7WzAV/GEMHptVxVGBeOLhVeLgbR
 sqhD+Fdjq98Wrkmmqgs6BATvPv/FsvzKaZ1fzHCyVUsawdfZEAiQYMs9J3Bwd4Byun2q
 q1hSgem27A0XwwofWIVnvPQLnZJq1RlXUmTgYVMuxKn5l4tT0D6qCstQPIQE+snBmVfF
 AXxMRLm2/KGBFIkj2RJh2uUCs07yJ1KzoBr7LkayfRWTKvKm6p5UJBHzH4V2h5oGbJSZ
 NW+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6AyCdh9ISWMitEuIcVFv92G/PyKsdcI0ECHzumJvs6Ne2j1m0iOMEnzuQNCX/gH1SVTUwuE369/z@nongnu.org
X-Gm-Message-State: AOJu0Yys6qiGfNJtcskL0o752QIT2/BMD0OI0kJ87iKVX9koN1npMAXK
 ea31TmUosHkvrZTdPqeLKaPrZe8j/xRJply5/W7GQRp14vtLEVLfJBomCmg+l068MCKWGzFLtms
 qCE6O4pCfI5tTl6vewdt9sKbMX8nd/O2s4MRdS4ajVWn9DZNcFc5q+tGY74hST/6vKqKN00pMbC
 tF72DMFX2DKXKkZREuIA/lt9h8NBEvDnhKqzE=
X-Gm-Gg: ASbGncuiulyMxyFCn+oyzx1uwKVFpeC1Nkdqwctj7OoAuPlwg7R+OPuSXAYfTMfOL6o
 lZwANC7tYwZerDhiby7m3z1gvTwkLkk2Gia5H/6R2ofpf8sr7+CIxigPqh4gcJWBSrya0
X-Received: by 2002:a05:600c:358b:b0:441:b5cb:4f94 with SMTP id
 5b1f17b1804b1-441d0fbd5cfmr23923145e9.5.1746538893750; 
 Tue, 06 May 2025 06:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwRLbwDozgOB4fOj8x/xSznUIREQnBbWzL8zQtMBphNbMhMbaprIOYgq0ZHsywSZPXxD3iaEZTWJBn6bUmZ/Y=
X-Received: by 2002:a05:600c:358b:b0:441:b5cb:4f94 with SMTP id
 5b1f17b1804b1-441d0fbd5cfmr23922815e9.5.1746538893301; Tue, 06 May 2025
 06:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
 <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
 <aBnVtNgdjQ9DlugK@intel.com> <aBnbC4-hov9gY3MF@redhat.com>
 <CABgObfbzWDnntjLcshsBPfdEdbx-6iqxd6FxUDbQa--VOqan=A@mail.gmail.com>
 <aBn36Qx8zd7cM1SW@redhat.com>
In-Reply-To: <aBn36Qx8zd7cM1SW@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 15:41:21 +0200
X-Gm-Features: ATxdqUEzjs-A-lTpWVfSIdzVZYI46xVfDIzyTVpRYkPDhMX6Q9oJBKjfSUdnvm4
Message-ID: <CABgObfYsDb_J01MH8nWQygRNVBUM9vJb=z6HSOmiwT50iZ6r+g@mail.gmail.com>
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000526b5f063477c658"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000526b5f063477c658
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 6 mag 2025, 13:52 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > On the other hand, this series shows that it's hard to have a baseline
> > version earlier than 1.83.  The bindings got pretty far while
> > supporting older versions, and the few hacks needed were nice testbeds
> > for the build system and the procedural macro infrastructure, but the
> > improvements that const_refs_to_static provides for reflection are
> > just too big.
>
> Admittedly I'm not actively working on the QEMU Rust code, but to
> me to feels the opposite - we've shown it is possible to write useful
> Rust code with the older version baseline. It may not be the ideal
> way we want the code to look, but that's a tradeoff we can make.
>

Yes it did go pretty far. But VMState is where you hit the barrier for a
very specific reason: the thing that you want to produce (structs with
pointers to other structs) isn't supported by compile time execution until
that version, so you're stuck writing C-style code for migration. These
structs have been very central to how QEMU does reflection, for more than
15 years, and there's no real workaround for that.

It's certainly possible to delay fully safe VMState some more, but perhaps
not 2-3 years.

We've had the same situation with Meson where we initially set a
> temporary newer baseline to get some critical features we could
> not do without, and now have ended up in a situation where we
> are continually pushing newer & newer versions, because there is
> always something attractive in the new release.
>

Most of the updates to Meson were done in the first year after switching,
because of new features in Meson that were contributed specifically for use
in QEMU. For example, "meson test" was improved to include all the features
of the preexisting "make check" (and many more), which benefited all users
of Meson. Since then we have only had one bleeding edge update in 2023,
when Apple messed up their linker's --version and we had to update in order
to help our macOS users (issue 1939).

Rust support does require more frequent updates to Meson because QEMU is
actually quite an early adopter among large C projects. Apart from
juggernauts like Firefox or Linux, I can only think of three: librsvg,
GStreamer and Mesa. Even Chromium (which builds with GN) only uses it for
some vendored third party libraries, with C++ bindings to Rust code. But I
can make these updates optional for people that don't --enable-rust; at the
same time I have no interest in building a pile of workarounds for those
that do.

Anyhow while I am contributing Rust-related improvements to Meson, I have
no plans, time or ability to contribute to Rust. :)

> Now, it's certainly not the only possibility:
> >
> > 1) If someone contributes devices that are written in Rust then we
> > could just drop the PL011 and/or HPET sample device. That's a pity but
> > they would survive in git history and could be resurrected later.
>
> IMHO for Rust in QEMU we should be targetting both new features
> and existing feature ports - excluding existing feature ports
> would be tieing one of our hands behind our back limiting the
> potential benefits we can see.
>

I agree.

Yes, this increasing defeats the benefit of defining our distro
> target. We wanted to set a clear baseline that we could unambiguously
> target, to give clarity to both users & contributors on when we could/
> would impose new version requirements.
>
> We've made exceptions for python, and then meson, and now Rust.


We've never made exceptions for Python in the sense of requiring a custom
Python interpreter. The interpreters we require have always been available
in all supported distros. What we did is not using the distro's *sphinx* on
enterprise distros whose default Python interpreter was way past EOL. (IMHO
shipping in /usr/bin anything that can run user Python code is a mistake,
because it conflicts with the idea that /usr/libexec/platform-python is
invisible to the user).

That came a few years *after* Meson and it happened because it's harder and
harder to support both very new and very old versions of Python, especially
after EOL. Our desires in that respect conflict very much with how the
Python community operates, unfortunately.

We can rationalize it is as "users only need to do x, y & z to get newer
> stuff",
> but as we make more & more exceptions, this is a game of death by a 1000
> cuts.
>

I agree. But the Python change is mostly water under the bridge, and the
bleeding edge Meson requirements could be made optional for those that
don't use Rust, so I don't think it's too bad.

For Rust, this submission shows exactly what the benefit would be and the
current status of the code shows how far you get without it. I don't want
to sneak in anything, I have posted it for transparency and it's up to the
community to discuss how to proceed. We can do so at the community call or
wait until KVM Forum.

Thanks,

Paolo


> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000526b5f063477c658
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 6 mag 2025, 13:52 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" rel=3D"noreferrer noreferrer noreferr=
er noreferrer noreferrer noreferrer noreferrer noreferrer" target=3D"_blank=
">berrange@redhat.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt; On the other hand, this series shows that it&#39;s hard to have a base=
line<br>
&gt; version earlier than 1.83.=C2=A0 The bindings got pretty far while<br>
&gt; supporting older versions, and the few hacks needed were nice testbeds=
<br>
&gt; for the build system and the procedural macro infrastructure, but the<=
br>
&gt; improvements that const_refs_to_static provides for reflection are<br>
&gt; just too big.<br>
<br>
Admittedly I&#39;m not actively working on the QEMU Rust code, but to<br>
me to feels the opposite - we&#39;ve shown it is possible to write useful<b=
r>
Rust code with the older version baseline. It may not be the ideal<br>
way we want the code to look, but that&#39;s a tradeoff we can make.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes it =
did go pretty far. But VMState is where you hit the barrier for a very spec=
ific reason: the thing that you want to produce (structs with pointers to o=
ther structs) isn&#39;t supported by compile time execution until that vers=
ion, so you&#39;re stuck writing C-style code for migration. These structs =
have been very central to how QEMU does reflection, for more than 15 years,=
 and there&#39;s no real workaround for that.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">It&#39;s certainly possible to delay fully safe VMSta=
te some more, but perhaps not 2-3 years.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">We&#39;ve had the same situation with Meson where we ini=
tially set a<br>
temporary newer baseline to get some critical features we could<br>
not do without, and now have ended up in a situation where we<br>
are continually pushing newer &amp; newer versions, because there is<br>
always something attractive in the new release.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Most of the updates to Meson=
 were done in the first year after switching, because of new features in Me=
son that were contributed specifically for use in QEMU. For example, &quot;=
meson test&quot; was improved to include all the features of the preexistin=
g &quot;make check&quot; (and many more), which benefited all users of Meso=
n. Since then we have only had one bleeding edge update in 2023, when Apple=
 messed up their linker&#39;s --version and we had to update in order to he=
lp our macOS users (issue 1939).</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Rust support does require more frequent updates to Meson because =
QEMU is actually quite an early adopter among large C projects. Apart from =
juggernauts like Firefox or Linux, I can only think of three: librsvg, GStr=
eamer and Mesa. Even Chromium (which builds with GN) only uses it for some =
vendored third party libraries, with C++ bindings to Rust code. But I can m=
ake these updates optional for people that don&#39;t --enable-rust; at the =
same time I have no interest in building a pile of workarounds for those th=
at do.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Anyhow while I am=
 contributing Rust-related improvements to Meson, I have no plans, time or =
ability to contribute to Rust. :)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; Now, it&#39;s certainly not the only possibility:<br>
&gt; <br>
&gt; 1) If someone contributes devices that are written in Rust then we<br>
&gt; could just drop the PL011 and/or HPET sample device. That&#39;s a pity=
 but<br>
&gt; they would survive in git history and could be resurrected later.<br>
<br>
IMHO for Rust in QEMU we should be targetting both new features<br>
and existing feature ports - excluding existing feature ports<br>
would be tieing one of our hands behind our back limiting the<br>
potential benefits we can see.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I agree.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Yes, this increasing defeats the benefit of defining our d=
istro<br>
target. We wanted to set a clear baseline that we could unambiguously<br>
target, to give clarity to both users &amp; contributors on when we could/<=
br>
would impose new version requirements. <br>
<br>
We&#39;ve made exceptions for python, and then meson, and now Rust.</blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">We&#39;ve ne=
ver made exceptions for Python in the sense of requiring a custom Python in=
terpreter. The interpreters we require have always been available in all su=
pported distros. What we did is not using the distro&#39;s *sphinx* on ente=
rprise distros whose default Python interpreter was way past EOL. (IMHO shi=
pping in /usr/bin anything that can run user Python code is a mistake, beca=
use it conflicts with the idea that /usr/libexec/platform-python is invisib=
le to the user).</div><div dir=3D"auto"><br></div><div dir=3D"auto">That ca=
me a few years *after* Meson and it happened because it&#39;s harder and ha=
rder to support both very new and very old versions of Python, especially a=
fter EOL. Our desires in that respect conflict very much with how the Pytho=
n community operates, unfortunately.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">We can rationalize it is as &quot;users only need to do x, y=
 &amp; z to get newer stuff&quot;,<br>
but as we make more &amp; more exceptions, this is a game of death by a 100=
0<br>
cuts.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I agree. But the Python change is mostly water under the bridge, and t=
he bleeding edge Meson requirements could be made optional for those that d=
on&#39;t use Rust, so I don&#39;t think it&#39;s too bad.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">For Rust, this submission shows exactly w=
hat the benefit would be and the current status of the code shows how far y=
ou get without it. I don&#39;t want to sneak in anything, I have posted it =
for transparency and it&#39;s up to the community to discuss how to proceed=
. We can do so at the community call or wait until KVM Forum.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
 noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer noreferr=
er" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=
=A0 =C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"noref=
errer noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer nor=
eferrer noreferrer noreferrer" target=3D"_blank">https://www.flickr.com/pho=
tos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer =
noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer noreferre=
r" target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138=
.berrange.com" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferre=
r noreferrer noreferrer noreferrer noreferrer noreferrer" target=3D"_blank"=
>https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer no=
referrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=
=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=3D"norefe=
rrer noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer nore=
ferrer noreferrer noreferrer" target=3D"_blank">https://www.instagram.com/d=
berrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000526b5f063477c658--


