Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7FACF8573
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:16:40 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swIiv-0006KA-Qo; Thu, 03 Oct 2024 06:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1swIic-0006II-GK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:06:03 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1swIhn-00068Q-IK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:05:49 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e09fe0a878so575154a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1727949853; x=1728554653;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bS63wjoEMbVXK7ob4sdD3zPIgRjCsx+cpkDGNPMQk2E=;
 b=SYvCZjEPSiAWqM07A/I0Hl8RMsRsXFb6rrak48pUePFG1uObt+AvveQzxn/bdFF5ZJ
 DUtNQ/hU2dsvJszpbFzbVLetyjUIqjTnJDzZTvSYfhfGalEWCFhSuod/tgInYuR4gmd2
 hVKo92rRftVPJ+BdFYddvX++VT2N+szjvGV+mjX9ugBLGEXdbxiSjw/YGsF3vuWxTDEE
 3GlBSmlHw35xZXPIqaDJh9JlLkqMuNgY5rhF/damj3ZmmHDxeMvFtrGzQODRTlo+viMu
 ZfdRc1vcTj25HJYaqBdK4rEw1owjoqoXz3//wv/Fe+lxHhWhAGPMz0rnOKyK+r6h1Myx
 fMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727949853; x=1728554653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bS63wjoEMbVXK7ob4sdD3zPIgRjCsx+cpkDGNPMQk2E=;
 b=TIkd5pSmP4V+yAOyfZgDFM6CotfiOmJjrNrUaXE1sYeI/FDKFIsUx+kqrapnmUw05H
 jSt/0zKXXrtHsEYBuX98M2knnrulnRMongXUpUxJveHyIsAld24XxM5uFXC/VzeHpnvw
 OAV3j6IqpRLZ2eMxqeUBze1+KD2i1Xc1ifMmGp88t31MxchhK3MB8rvTQNAA9Uv+d9AO
 SQf3HkU6iCg5lNuX4ibRzvXkVMGbazF0xfaj/pZPGZJa/ndnq1LyEsqeNO9aox5BO5ez
 MeSEzqJ42CbBk1MzF5fMjYO04wTEc7lmh7c49NpEpRZEroqTsAj8AuBt38U+JBhCmhbl
 J2nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6PubzzPd5BoElV40lS4o1fM8l8ZplmX0UMxtXx3ycDO1rQ9jXVJYSgJyTzr/WwdEZ1RbO+A1mUbmi@nongnu.org
X-Gm-Message-State: AOJu0Ywl+ZK5mj6CGBGQcK02I2KlKccq30+vIo+gANvjqEryY2vj2xqa
 ibAD/vj/OfoIDM3uqnjkJwBsclrfGR8xVoNHGeUP36DHD8B2WbS91jmNsxaJl3Hpl6/Ek/5Dpsv
 1XFHYwRng1nI+crAIg2X1QZmUkGEjz2fMWzAtbg==
X-Google-Smtp-Source: AGHT+IEXHljPkXYZfLLMX6mpaRMmnfv3DzjCYumTzMhpilKBidXmRtK9yv1AHwtchQ53Ba+N/nWW9v1RY3GzFvDhGFk=
X-Received: by 2002:a17:90a:fe97:b0:2e0:808f:ef94 with SMTP id
 98e67ed59e1d1-2e1848f9a24mr7872090a91.30.1727949852849; Thu, 03 Oct 2024
 03:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
 <Zv5pgZsHOeXX-3fg@redhat.com>
In-Reply-To: <Zv5pgZsHOeXX-3fg@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 3 Oct 2024 04:04:00 -0600
Message-ID: <CANCZdfq781nzxVbiWxqdq6RZLL+OPSd693SNQPPG5mhTb=emfA@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org, 
 Muhammad Moinur Rahman <bofh@freebsd.org>, emulation@freebsd.org,
 virtualization@gentoo.org, 
 dilfridge@gentoo.org, hi@alyssa.is, edolstra+nixpkgs@gmail.com, 
 Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002b5d0406238fade6"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--0000000000002b5d0406238fade6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024, 3:53=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:

> On Thu, Oct 03, 2024 at 02:53:08AM -0600, Warner Losh wrote:
> > On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> > > One output from this discussion should be a clear statement that we a=
re
> > > going forward with this work and the road map. A rough roadmap might
> > > look like:
> > >
> > >   - 9.2   --enable-rust is available and developers can build with it=
.
> > >           rust devices have -x-device or -rust-device CLI flags for
> > >           runtime selection.
> > >
> > >   - 10.x  rust devices feature complete and migration compatible,
> enabled
> > >           by default when rust compiler detected. No CLI selection
> > >           required as legacy portions won't be built. Any partial
> > >           conversions should be behind --enable-prototype-rust
> configure
> > >           flag.
> > >
> > >   - 11.x  distros have enough infrastructure to build on supported
> > >           platforms. Rust becomes a mandatory dependency, old C
> versions
> > >           of converted code removed from build.
> > >
> > >   - xx.y  QEMU becomes a pure native rust program and all C is
> expunged.
> > >           We may never get to this point.
> > >
> > > We should publish the intention and the road map prominently although
> it
> > > was unclear if a blog post would be the best place vs expanding a
> > > section in the developers manual. Perhaps both make sense with a blog
> > > post for the statement of intent and rough timeline and the developer
> > > manual being expanded with any new rules and standards to follow?
> > >
> >
> > FeeBSD is Tier 1 in rust only for amd64 (x86_64). It's Tier 2 for i386
> > (which
> > admittedly is going away) and Tier 3 for everything else.
> >
> > > There was some concern about the missing gaps in the support matrix
> > > especially as we support a number of "legacy" TCG backends. While
> *-user
> > > support is more insulated from the effects of rust conversions due to
> > > its relatively low set of dependencies it will still be a problem if =
we
> > > convert the core CPU QOM classes to rust.
> > >
> >
> > Indeed. I have great concerns here, though we've already dropped
> > 32-bit host support for bsd-user. The status of aarch64 support and
> rumored
> > difficulty getting that rust support upgraded give me pause for concern
> > because it's a FreeBSD Tier 1 platform. While it basically works, the
> lack
> > of commitment by the Rust community is troubling. Even more troubling
> because
> > rust still uses the old FreeBSD 11 compat syscalls, despite upgraded
> > being available for years at this point (though maybe this info has
> changed
> > in the last month or two, the years long delay in moving off the
> interfaces
> > that the FreeBSD project obsoleted about 8 years ago is troubling on it=
s
> > own).
> > Much of the resistance I'm told (I'm not a big rust person, so I have t=
o
> > reply on others) has been in the rust team because they don't have enou=
gh
> > familiarity
> > with FreeBSD to make any kind of decision so even properly solved issue=
s
> > linger in the official upstream. The FreeBSD project critically depends
> on
> > bsd-user for its release process, though that dependency so far has bee=
n
> > only on x86 and aarch64, both of which work almost all the time, even i=
f
> > they aren't Tier 1 rust platforms.
>
> I don't think we should over-think the upstream Rust support tiers for
> QEMU.
> Rust is one of very few OSS projects that bothers to classify platforms
> they target to this degree of detail. Most OSS projects will test primari=
ly
> on Linux, and x86_64 / aarch64, with most everything else done on an adho=
c
> basis, relying on user feedback & patches. eg If I look at what Rust says
>
>   "Tier 3 targets are those which the Rust codebase has support
>    for, but which the Rust project does not build or test
>    automatically, so they may or may not work."
>
> I would say that describes the status of most non-Linux / non-x86/arm64
> platform combinations, across a very large part of the OSS software
> ecosystem, including a lot of libraries QEMU depends on.
>
> Admittedly, compilers are the area where platform support is taken most
> seriously, given they are the foundation for everything else above, and
> the comparison benchmark in this case is the support matrix offered by
> GCC + CLang combined which is incredibly broad. Above that though, QEMU
> has a mandatory dep on Glib, and its supported & tested platform set
> is massively narrower than this.
>
> I think it is inevitable that a number of QEMU platforms we can build
> on will be classified Tier 2 or even 3 by Rust upstream, as just many
> libraries QEMU depends on today would effectively be "Tier 3" if their
> upstream actually tried to document such details.
>
> What I think is more important than the absolute Tier level, is whether
> Rust has been ported at all to a given OS + arch combination. This is
> where tier 3 guides us - an indication that there's been enough interest
> in Rust for it to have been ported to that target at some point, and thus
> an expectation (or hope) that it can be kept working, if there are
> sufficient people downstream who care about that particular Rust target.
>
> > For -system use, this could limit where qemu runs, though to be honest
> > the only platform I know has users that might be affected running -syst=
em
> > might be RISCV.
> >
> > There's similar issues with other BSDs, but I've heard even less reliab=
le
> > information
> > about them, so I'll just leave it at that.
>
> In terms of QEMU upstream, we actively test FreeBSD on x86_64 in Gitlab
> CI, via Cirrus, and to a slightly lesser extent test OpenBSD/NetBSD on
> x86_64 with our adhoc VM environments. Anything else is delegated to
> downstream users of QEMU to report bugs to us, though we try not to
> take code that would obviously break other platforms even if we can't
> test it ourselves. In Rust, the other BSDs are Tier 3 which is weaker
> than QEMU aims for x86_64, but on a par with QEMU for non-x86
>
>   https://doc.rust-lang.org/rustc/platform-support/netbsd.html
>   https://doc.rust-lang.org/rustc/platform-support/openbsd.html
>
> at least they have a designated developer who presumably aims to keep
> those rust ports working over time.
>
> > So a strawman timeline of 2 years strikes me as unrealistically agressi=
ve
> > for it to be an absolute requirement given the slow rate of change I've
> seen
> > with upstream rust WRT FreeBSD. At the very least, it would put qemu on
> > non-x86/non-aarch64 platforms at risk. While not a huge audience, there
> are
> > some users there. The Tier 2 status for Rust at best for FreeBSD is als=
o
> a
> > bit worrying for elimination of all C or a big reliance on rust in the
> core
> > that can't realistically be avoided. I'm not sure this should gate the
> start
> > of the rust experiment, but I raise it now so as that experiment
> progresses
> > towards production people think to talk to me or others in the FreeBSD
> > community as they progress.
>
> I don't think being "Tier 2" is a problem - that is still a pretty strong
> level of support from upstream Rust
>
>
> https://doc.rust-lang.org/rustc/target-tier-policy.html#tier-2-target-pol=
icy
>
> Beyond that, I don't think any of the upstream Rust tiers are neccessaril=
y
> a constraint for QEMU, even Tier 3.
>
> IMHO what matters more is whether the OS distro in question has managed
> to successfully package Rust + its stdlib in their distro, to the extent
> that QEMU is able to build, using the distro provided packages.
>

Those have been hit or miss for anything not amd64 or aarch64 on FreeBSD.
Sometimes they work, sometimes not. But rust support requires special weird
kernel options to work at all... so the situation on FreeBSD is more wobbly
than you'd otherwise think. We'll see how it evolves, but an 6-8 year lag
in upstream support even though community members contrivuted better
support at least 4 years ago is a clear red flashing light of caution.
Though unlikely, there is a risk that the root cause of this problem causes
things to degrade more. And then FreeBSD would fail the supplied packages
test. Use this info as you will, but don't just dismiss it out of hand.
There is a long history here of unusual friction that rises to the level of
concern I won't be brushed off with assurances you don't think it will be a
problem.

Warner

That is the bar we have for basically every dependency we add to QEMU.
> Distro support is more important that upstream support. The upstream
> support is really more of an indication of how hard a life the distro
> maintainer is going to have keeping it working in their distro, rather
> than whether QEMU should/should not use it.
>
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

--0000000000002b5d0406238fade6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Oct 3, 2024, 3:53=E2=80=AFAM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Oct 03, 2024 at 0=
2:53:08AM -0600, Warner Losh wrote:<br>
&gt; On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">ale=
x.bennee@linaro.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; One output from this discussion should be a clear statement that =
we are<br>
&gt; &gt; going forward with this work and the road map. A rough roadmap mi=
ght<br>
&gt; &gt; look like:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0- 9.2=C2=A0 =C2=A0--enable-rust is available and deve=
lopers can build with it.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rust devices have -x-devi=
ce or -rust-device CLI flags for<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runtime selection.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0- 10.x=C2=A0 rust devices feature complete and migrat=
ion compatible, enabled<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by default when rust comp=
iler detected. No CLI selection<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required as legacy portio=
ns won&#39;t be built. Any partial<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conversions should be beh=
ind --enable-prototype-rust configure<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0- 11.x=C2=A0 distros have enough infrastructure to bu=
ild on supported<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platforms. Rust becomes a=
 mandatory dependency, old C versions<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of converted code removed=
 from build.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0- xx.y=C2=A0 QEMU becomes a pure native rust program =
and all C is expunged.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We may never get to this =
point.<br>
&gt; &gt;<br>
&gt; &gt; We should publish the intention and the road map prominently alth=
ough it<br>
&gt; &gt; was unclear if a blog post would be the best place vs expanding a=
<br>
&gt; &gt; section in the developers manual. Perhaps both make sense with a =
blog<br>
&gt; &gt; post for the statement of intent and rough timeline and the devel=
oper<br>
&gt; &gt; manual being expanded with any new rules and standards to follow?=
<br>
&gt; &gt;<br>
&gt; <br>
&gt; FeeBSD is Tier 1 in rust only for amd64 (x86_64). It&#39;s Tier 2 for =
i386<br>
&gt; (which<br>
&gt; admittedly is going away) and Tier 3 for everything else.<br>
&gt; <br>
&gt; &gt; There was some concern about the missing gaps in the support matr=
ix<br>
&gt; &gt; especially as we support a number of &quot;legacy&quot; TCG backe=
nds. While *-user<br>
&gt; &gt; support is more insulated from the effects of rust conversions du=
e to<br>
&gt; &gt; its relatively low set of dependencies it will still be a problem=
 if we<br>
&gt; &gt; convert the core CPU QOM classes to rust.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Indeed. I have great concerns here, though we&#39;ve already dropped<b=
r>
&gt; 32-bit host support for bsd-user. The status of aarch64 support and ru=
mored<br>
&gt; difficulty getting that rust support upgraded give me pause for concer=
n<br>
&gt; because it&#39;s a FreeBSD Tier 1 platform. While it basically works, =
the lack<br>
&gt; of commitment by the Rust community is troubling. Even more troubling =
because<br>
&gt; rust still uses the old FreeBSD 11 compat syscalls, despite upgraded<b=
r>
&gt; being available for years at this point (though maybe this info has ch=
anged<br>
&gt; in the last month or two, the years long delay in moving off the inter=
faces<br>
&gt; that the FreeBSD project obsoleted about 8 years ago is troubling on i=
ts<br>
&gt; own).<br>
&gt; Much of the resistance I&#39;m told (I&#39;m not a big rust person, so=
 I have to<br>
&gt; reply on others) has been in the rust team because they don&#39;t have=
 enough<br>
&gt; familiarity<br>
&gt; with FreeBSD to make any kind of decision so even properly solved issu=
es<br>
&gt; linger in the official upstream. The FreeBSD project critically depend=
s on<br>
&gt; bsd-user for its release process, though that dependency so far has be=
en<br>
&gt; only on x86 and aarch64, both of which work almost all the time, even =
if<br>
&gt; they aren&#39;t Tier 1 rust platforms.<br>
<br>
I don&#39;t think we should over-think the upstream Rust support tiers for =
QEMU.<br>
Rust is one of very few OSS projects that bothers to classify platforms<br>
they target to this degree of detail. Most OSS projects will test primarily=
<br>
on Linux, and x86_64 / aarch64, with most everything else done on an adhoc<=
br>
basis, relying on user feedback &amp; patches. eg If I look at what Rust sa=
ys<br>
<br>
=C2=A0 &quot;Tier 3 targets are those which the Rust codebase has support<b=
r>
=C2=A0 =C2=A0for, but which the Rust project does not build or test<br>
=C2=A0 =C2=A0automatically, so they may or may not work.&quot;<br>
<br>
I would say that describes the status of most non-Linux / non-x86/arm64<br>
platform combinations, across a very large part of the OSS software<br>
ecosystem, including a lot of libraries QEMU depends on.<br>
<br>
Admittedly, compilers are the area where platform support is taken most<br>
seriously, given they are the foundation for everything else above, and<br>
the comparison benchmark in this case is the support matrix offered by<br>
GCC + CLang combined which is incredibly broad. Above that though, QEMU<br>
has a mandatory dep on Glib, and its supported &amp; tested platform set<br=
>
is massively narrower than this.<br>
<br>
I think it is inevitable that a number of QEMU platforms we can build<br>
on will be classified Tier 2 or even 3 by Rust upstream, as just many<br>
libraries QEMU depends on today would effectively be &quot;Tier 3&quot; if =
their<br>
upstream actually tried to document such details.<br>
<br>
What I think is more important than the absolute Tier level, is whether<br>
Rust has been ported at all to a given OS + arch combination. This is<br>
where tier 3 guides us - an indication that there&#39;s been enough interes=
t<br>
in Rust for it to have been ported to that target at some point, and thus<b=
r>
an expectation (or hope) that it can be kept working, if there are<br>
sufficient people downstream who care about that particular Rust target.<br=
>
<br>
&gt; For -system use, this could limit where qemu runs, though to be honest=
<br>
&gt; the only platform I know has users that might be affected running -sys=
tem<br>
&gt; might be RISCV.<br>
&gt; <br>
&gt; There&#39;s similar issues with other BSDs, but I&#39;ve heard even le=
ss reliable<br>
&gt; information<br>
&gt; about them, so I&#39;ll just leave it at that.<br>
<br>
In terms of QEMU upstream, we actively test FreeBSD on x86_64 in Gitlab<br>
CI, via Cirrus, and to a slightly lesser extent test OpenBSD/NetBSD on<br>
x86_64 with our adhoc VM environments. Anything else is delegated to<br>
downstream users of QEMU to report bugs to us, though we try not to<br>
take code that would obviously break other platforms even if we can&#39;t<b=
r>
test it ourselves. In Rust, the other BSDs are Tier 3 which is weaker<br>
than QEMU aims for x86_64, but on a par with QEMU for non-x86<br>
<br>
=C2=A0 <a href=3D"https://doc.rust-lang.org/rustc/platform-support/netbsd.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://doc.rust-lang.=
org/rustc/platform-support/netbsd.html</a><br>
=C2=A0 <a href=3D"https://doc.rust-lang.org/rustc/platform-support/openbsd.=
html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://doc.rust-lang=
.org/rustc/platform-support/openbsd.html</a><br>
<br>
at least they have a designated developer who presumably aims to keep<br>
those rust ports working over time.<br>
<br>
&gt; So a strawman timeline of 2 years strikes me as unrealistically agress=
ive<br>
&gt; for it to be an absolute requirement given the slow rate of change I&#=
39;ve seen<br>
&gt; with upstream rust WRT FreeBSD. At the very least, it would put qemu o=
n<br>
&gt; non-x86/non-aarch64 platforms at risk. While not a huge audience, ther=
e are<br>
&gt; some users there. The Tier 2 status for Rust at best for FreeBSD is al=
so a<br>
&gt; bit worrying for elimination of all C or a big reliance on rust in the=
 core<br>
&gt; that can&#39;t realistically be avoided. I&#39;m not sure this should =
gate the start<br>
&gt; of the rust experiment, but I raise it now so as that experiment progr=
esses<br>
&gt; towards production people think to talk to me or others in the FreeBSD=
<br>
&gt; community as they progress.<br>
<br>
I don&#39;t think being &quot;Tier 2&quot; is a problem - that is still a p=
retty strong<br>
level of support from upstream Rust<br>
<br>
=C2=A0 <a href=3D"https://doc.rust-lang.org/rustc/target-tier-policy.html#t=
ier-2-target-policy" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//doc.rust-lang.org/rustc/target-tier-policy.html#tier-2-target-policy</a><=
br>
<br>
Beyond that, I don&#39;t think any of the upstream Rust tiers are neccessar=
ily<br>
a constraint for QEMU, even Tier 3.<br>
<br>
IMHO what matters more is whether the OS distro in question has managed<br>
to successfully package Rust + its stdlib in their distro, to the extent<br=
>
that QEMU is able to build, using the distro provided packages.<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Those have b=
een hit or miss for anything not amd64 or aarch64 on FreeBSD. Sometimes the=
y work, sometimes not. But rust support requires special weird kernel optio=
ns to work at all... so the situation on FreeBSD is more wobbly than you&#3=
9;d otherwise think. We&#39;ll see how it evolves, but an 6-8 year lag in u=
pstream support even though community members contrivuted better support at=
 least 4 years ago is a clear red flashing light of caution. Though unlikel=
y, there is a risk that the root cause of this problem causes things to deg=
rade more. And then FreeBSD would fail the supplied packages test. Use this=
 info as you will, but don&#39;t just dismiss it out of hand. There is a lo=
ng history here of unusual friction that rises to the level of concern I wo=
n&#39;t be brushed off with assurances you don&#39;t think it will be a pro=
blem.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Warner=C2=A0</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
That is the bar we have for basically every dependency we add to QEMU.<br>
Distro support is more important that upstream support. The upstream<br>
support is really more of an indication of how hard a life the distro<br>
maintainer is going to have keeping it working in their distro, rather<br>
than whether QEMU should/should not use it.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000002b5d0406238fade6--

