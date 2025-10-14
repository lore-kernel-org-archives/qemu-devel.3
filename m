Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1EACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cbE-0001ed-KL; Tue, 14 Oct 2025 06:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v8cbC-0001e0-Vn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:49:47 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v8cb9-0004Ep-8O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:49:46 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19AD43F47E
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760438978;
 bh=cmLXq84V85obNFty3nlrHEJGMpWdA5cAmw8Q0zRZVJU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ZOQ7GdgIw8aGIIMtFV4Ca23pnUt5DatfcMYyBCf9pJcWtAOXb2ASc1kfrWBnp4pJx
 y6GDNqpfCJWrTs5I3BjxEmXhwPF/I+3KyzaM1K/jfp7hdtU7OAJ/0/X364FvOU8/dN
 F51UrqSxU2Pam/xdkm+FawXjQKfeg5XHIJ1qhqkWkU8xoIhlTkf703qdk4AbR/OddN
 2miXfOn4TouQ7nglhbidkbecpXMpOu2V6RZj+O7ikrvHL65TDe9hkbxz/meS2AuiNb
 pyOyLXDun+eNyH8J0BLd4mgSjwx157p081IdO8yN+nm5mZvHBq7AA4O9TZiEaHyaJ2
 DR8En+YfyQOirFjxUB8l1kqqNwe+f+r5J7CBphWljNNaZq1nkZusp7Dun/JfB9/sbO
 OJqob6hknd2/o8hQO1KCcRn+t+CTUnS0HMpJosfEtZ8mTf9OA1tq8HMcnd50bMV3wd
 gGsLl22HhVd7OC6AZwgKzMlSIP6P72P6QgNKxUUfPCfuYrVRGsiFzZjn0obMQnSig2
 CRRJ4HT6KcO3Z3QXrXDL5oHy64RKVVXVnHE+pFV8x4MipEN1pORpjsJj9OwuDFSDrx
 4PGZlaCsK7cMo5gVwlLicbZWxN5yZy3vepFdkYGhll81wf5UCO5FAogY3Lom/xRVoT
 6SGMLChRx/xlHJhp5oi/5mXA=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6344e493258so6028024a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438977; x=1761043777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmLXq84V85obNFty3nlrHEJGMpWdA5cAmw8Q0zRZVJU=;
 b=ro/omDINeWTNQ7fJEPgur89B4VtiRyLWQ6/0V7OQykgIGXMgl/foWKWtwLZu53MZCf
 +pVC0/ag7LrEzM2fID0AK+G3D07IRyHafxYazexUHv5WZFrXvn/L5i2kY2o41kD3e2u2
 BHyox1uWqXF73PJg99S/5WYq0aQUlNGJqsWW3dmpUKvnILgrDEZ5/TepVvl1VdMFVA3r
 wscm5RueMdpfyOd55w6vmYWml7qT46FqV1M+WDVhYuQltSHuQPpbysrcAd6FgGgBNuMG
 4aCjW4cGCexT8jZ8tvMX3a+yhLDf9YfLbPctcuMqmALIt4q+/xvyWrqwPiAP9UmwL0ZR
 1DPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7G5xuAqmnR6Ubk+LPlJZpUhsDni6jmJoP70CmgwADF8qKXGMYRhFCcIF384q3/ZY3rCy+XonrradA@nongnu.org
X-Gm-Message-State: AOJu0YxfI2lYX3v/Ne2ANpj/x/oRUlUouYcGl87tcDdQHp8e3Jf/Hpn4
 QoYRgjKk+5O1M06irqOfNzmom0xpmjjfQskcpfGNBvTJUI8PRfTtqtIM0sN+7MkOcC0+3oUOxvP
 OiGRbIzPAkQXRIUuH1/eMrGIlrzSBp//Q1Y1VYMK+sQXbHHa8uV/QLmdnJW/AjjbPVGY0m/KRde
 /wSl7pnqVYkkgZHE8xL3CIKIyrWoz374ZXQAbRQ4GlVcjloEk=
X-Gm-Gg: ASbGncsxp6lG9ay1XpM2/Ly8q7/cTdEryH2mrHRLQoHv5I0EaykVTiqmFdiGmJwN1xy
 6XzXv4AiqcAOF1SCndE+fJ1SmxAD/x0jLFgpoQyUUAuQ+61lgnO3Iu4QW0bCzQ66PPWizQ4oS+k
 c+IchaBh2qdBgqAWOusNd3H0rgCIZLdSCgZGq917ptq+hP6PAbAqSCo4+e8uoeHzneR4GmPJW2
X-Received: by 2002:a05:6402:42c6:b0:639:ef26:a015 with SMTP id
 4fb4d7f45d1cf-639ef26a351mr20281265a12.23.1760438977455; 
 Tue, 14 Oct 2025 03:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeaRrYDfVW8HTdUiidE1YH5tE4KpfgmvT1iDDkwTlP5u38JXSZowhGj1HNeUx6g2zfDAUIsUe9wD+k7Qnfmmw=
X-Received: by 2002:a05:6402:42c6:b0:639:ef26:a015 with SMTP id
 4fb4d7f45d1cf-639ef26a351mr20281231a12.23.1760438976945; Tue, 14 Oct 2025
 03:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <aNVrAkx+ahn7ZRns@intel.com>
 <8a754d6c-1d8c-43d7-b3f8-a4b3e194d30e@tls.msk.ru> <aOyouIh//WY+EkKb@intel.com>
 <d2cf0acc-7ba2-43fd-9d1b-3fcfbb8f7dc7@tls.msk.ru>
In-Reply-To: <d2cf0acc-7ba2-43fd-9d1b-3fcfbb8f7dc7@tls.msk.ru>
From: Hector Cao <hector.cao@canonical.com>
Date: Tue, 14 Oct 2025 12:49:25 +0200
X-Gm-Features: AS18NWDQmZj38KRMoiCwgsU4NCc6CsGw8haksHFBfvGImhHWTt1qk66-9qWY58o
Message-ID: <CABjvBV60PX6OLzkFTfkPDXYUtR_WMVNbm9DQZwjaa_YuBAcfkg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 lk@c--e.de, berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000deb73406411c235c"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--000000000000deb73406411c235c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:22=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 10/13/25 10:22, Zhao Liu wrote:
> > On Fri, Oct 10, 2025 at 08:40:56PM +0300, Michael Tokarev wrote:
> ..>>> I found the previous 2 fixes were merged into stable 10.0:
> >>>
> >>> 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
> >>> 3d26cb65c27190e57637644ecf6c96b8c3d246a3
> >>>
> >>> Should stable 10.0 revert these 2 fixes, to ensure migration
> >>> compatibility?
> >
> > Sorry for late...just return from vacation.
>
> I returned from vacation today too :)
>
> >> Now when I think about it.
> >>
> >> There were at least 2 point releases of 10.0.x (10.0.4 & 10.0.5)
> >> with these 2 patches already.
> >
> > EMM, it seems 10.0.x (x < 4) can't migrate to 10.0.y (4 <=3D y <=3D 5),
> > right? If so, could we treat this behavior as a regression?
>
> It is a regression in 10.0.4 indeed.  But it already lasted for
> 2 stable releases (10.0.4 & 10.0.5).  So by reverting the above
> mentioned two changes in 10.0.6, we'll make yet another regression,
> now when migrating from 10.0.[45] to 10.0.6. This is why I thought
> it might be an idea to keep just one regression in 10.0.x, so to
> say.  Especially since these changes already fixes issues with
> existing guests, so by reverting them, we'll bring them back to
> 10.0.x.
>
> It is an either-or combination.  It is not bad either way, I'm just
> thinking what is best currently.
>
> And with my limited understanding of the migration issue in the context
> (for which I asked for clarification some 5 or 6 times already), it
> feels to me like "pretending" these above 2 mentioned above patches has
> always been part of 10.0.x, - declare that migration wont work from
> 10.0.[1-3] (or [1-5]?) to subsequent versions, and be done with it.
>
> And modify the 2 properties introduced by:
>
> 6529f31e0d target/i386: add compatibility property for pdcm feature
> e9efa4a771 target/i386: add compatibility property for arch_capabilities
>
> to be part of pc_compat_9_2 machine, not 10.0..


> Hopefully it's understandable what I mean.
>
>
Hello Michael,

IIUC, there is no perfect solution that makes migration work for all
combinations
of versions as you already pointed out.
Reverting the two faulty commits in 10.0.x will reduce the scope of
migration failures (10.0.x -> 10.0.y / 10.1.z)

You seem to propose to backport the migration fixes (with compatibility
properties) back to 10.0.y
but I don't know if it is possible since only 10.0 machine type is
available.

Apply these compatibility properties only in 9.2 (and older) might make
sense IMHO since 10.0.y behaves the same way than 10.1

>> Reverting them in 10.0 will make
> >> 10.0 to be non-migratable with itself (10.0.5 can't be migrated
> >> to 10.0.6 if we'll release 10.0.6 with these 2 patches reverted).
> >>
> >> Also, as far as I can see (and I asked about this some 5 times
> >> already, with no one answering - is it that difficult?) - we
> >> should pick this series (pdcm, arch-capabilities) to 10.1.x stable
> >> series too, since we can't migrate from previous versions to 10.1
> >> which has the two changes mentioned above.
> >
> > I think so. in this series, Paolo added compat options in pc_compat_10_=
0
> > so it should be picked to stable v10.1.
>
> Again, I asked about this some 5 times already, with no single
> answer.
>
> >> It looks to me - since the breakage is already done, and both 10.0
> >> and 10.1 is broken, we should declare the current situation as a
> >> status quo, and do the following:
> >>
> >> 1. keep the above mentioned 24778b1c7ee7a and 3d26cb65c27190e5 in
> >>     10.0.x (instead of reverting them);
> >>
> >> 2. pick up this 2 patches (fix cross migration issue with missing
> >>     pdcm, arch-capabilities) to 10.1.x (it should be done either way,
> >>     I think);
> >
> > IIUC, if we picked current compat options to stable v10.1, then stable
> > v10.1 requires previous v10.0 sets the pdcm & arch-cap bits (i.e., do
> > not apply the fixes or revert the previous fix).
>
> Ugh.  Confusion++ :)  As you wrote yourself right above, "Paolo added
> compat options in pc_compat_10_0, so it should be picked up to stable
> 10.1".  This point "2" is exactly this case I'm talking about.  Two
> commits:
>
> 6529f31e0d target/i386: add compatibility property for pdcm feature
> e9efa4a771 target/i386: add compatibility property for arch_capabilities
>
> should be picked up for 10.1.x.
>
> This "2" point is not (yet) about 10.0.x.
>
>
> > So it seems the reverts are unavoidable on v10.0?
> >
> > (Let's see what Paolo and the other maintainers think.)
>
> For 10.0, there are 2 either-or options: either we revert, or we
> pretend these has always been in 10.0.x and compensate, like I described
> in my previous email in this thread (to which you're replying) and
> re-describing now.
>
> >> 3. on top of these 2 "missing features: pdcm, arch-capabilities",
> >>     make the crossing line for before-10.0, not for before-10.1 series=
,
> -
> >>     ie, consider 10.0 *also* has these properties, but 9.2 and before
> >>     are not.
>
> > This issue is indeed quite tricky. Sometimes people (including myself)
> > assume that backporting fixes to the stable branch can avoid adding a
> > compat option. Now it seems the compat option is the better choice, as
> > users need to ensure migration rather than downtime before upgrading to
> > the stable version :-(.
> It's a good (hopefully) lesson for me myself, - I blindly picked up
> a change which felt like an innocent (I even mentioned that in a commit
> - it's a "cleanup patch") - just so a subsequent change in this area
> applies cleanly.  But it wasn't a cleanup, and it wasn't trivial at
> all.  So I must be much more careful the next time.  I'm talking about
> 3d26cb65c2 "Move adjustment of CPUID_EXT_PDCM..".
>
> Speaking of the other change - it fixed a real bug which I hit myself,
> and I had no idea it's tricky - actually no one had this idea until
> e9efa4a771 "property for arch_capabilities".  So yes, this is a "sh*t
> happens" case :)
>
>
> Ok.
>
> So, back to the situation and the plan (two of them).
>
>
> 1. It looks like we agree we should pick
>
> 6529f31e0d target/i386: add compatibility property for pdcm feature
> e9efa4a771 target/i386: add compatibility property for arch_capabilities
>
> to 10.1.x, to make migration from older versions to 10.1.x work.
>
>
> 2.  For 10.0.x, we've two options:
>
>   2.a.  Revert
>      e9efa4a771 "do not expose ARCH_CAPABILITIES"
>      3d26cb65c2 "Move adjustment of CPUID_EXT_PDCM"
>    as you initially suggested and already reviewed.
>
>    This will make 10.0.[45] "bad" wrt migration, and will re-create the
>    issues these 2 commits fixed, but will make next 10.0.x as good as
>    initial 10.0.0 wrt migration.
>
>   2.b.  Instead of reverting these two which are already in 10.0.[45],
>    pretend 10.0 always had these 2 commits, and adjust subsequent
>    qemu versions just like we did with 2 "add compatibility property"
>    changes, but make it to be 9.2-compat property, not 10.0-compat
>    property.
>
>    This - as far as I can see - will make 10.0.[0-3] to be "bad" wrt
>    migration, but not subsequent 10.0.x ones.  And will keep the bugs
>    fixed in 10.0.x too.
>
> But again, I don't understand the migration logic well, so don't know
> if it even makes sense.  2.b, if deemed to be good, will be the first
> in history (I think) to introduce compat properties for past machine
> types.
>
> Please excuse me for so much text :)
>
> Thank you!
>
> /mjt
>


--=20
Hector CAO
Software Engineer =E2=80=93 Server Team / Virtualization
hector.cao@canonical.com
https://launc <https://launchpad.net/~hectorcao>hpad.net/~hectorcao
<https://launchpad.net/~hectorcao>

<https://launchpad.net/~hectorcao>

--000000000000deb73406411c235c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 13,=
 2025 at 7:22=E2=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.=
ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 10/13/25 10:22, Zhao Liu wrote:<br>
&gt; On Fri, Oct 10, 2025 at 08:40:56PM +0300, Michael Tokarev wrote:<br>
..&gt;&gt;&gt; I found the previous 2 fixes were merged into stable 10.0:<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 24778b1c7ee7aca9721ed4757b0e0df0c16390f7<br>
&gt;&gt;&gt; 3d26cb65c27190e57637644ecf6c96b8c3d246a3<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Should stable 10.0 revert these 2 fixes, to ensure migration<b=
r>
&gt;&gt;&gt; compatibility?<br>
&gt; <br>
&gt; Sorry for late...just return from vacation.<br>
<br>
I returned from vacation today too :)<br>
<br>
&gt;&gt; Now when I think about it.<br>
&gt;&gt;<br>
&gt;&gt; There were at least 2 point releases of 10.0.x (10.0.4 &amp; 10.0.=
5)<br>
&gt;&gt; with these 2 patches already.<br>
&gt; <br>
&gt; EMM, it seems 10.0.x (x &lt; 4) can&#39;t migrate to 10.0.y (4 &lt;=3D=
 y &lt;=3D 5),<br>
&gt; right? If so, could we treat this behavior as a regression?<br>
<br>
It is a regression in 10.0.4 indeed.=C2=A0 But it already lasted for<br>
2 stable releases (10.0.4 &amp; 10.0.5).=C2=A0 So by reverting the above<br=
>
mentioned two changes in 10.0.6, we&#39;ll make yet another regression,<br>
now when migrating from 10.0.[45] to 10.0.6. This is why I thought<br>
it might be an idea to keep just one regression in 10.0.x, so to<br>
say.=C2=A0 Especially since these changes already fixes issues with<br>
existing guests, so by reverting them, we&#39;ll bring them back to<br>
10.0.x.<br>
<br>
It is an either-or combination.=C2=A0 It is not bad either way, I&#39;m jus=
t<br>
thinking what is best currently.<br>
<br>
And with my limited understanding of the migration issue in the context<br>
(for which I asked for clarification some 5 or 6 times already), it<br>
feels to me like &quot;pretending&quot; these above 2 mentioned above patch=
es has<br>
always been part of 10.0.x, - declare that migration wont work from<br>
10.0.[1-3] (or [1-5]?) to subsequent versions, and be done with it.<br>
<br>
And modify the 2 properties introduced by:<br>
<br>
6529f31e0d target/i386: add compatibility property for pdcm feature<br>
e9efa4a771 target/i386: add compatibility property for arch_capabilities<br=
>
<br>
to be part of pc_compat_9_2 machine, not 10.0..</blockquote><div></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Hopefully it&#39;s understandable what I mean.<br>
<br></blockquote><div><br></div><div>Hello Michael,</div><div><br></div><di=
v>IIUC, there is no perfect solution that makes migration work for all comb=
inations</div><div>of versions as you already pointed out.</div><div>Revert=
ing the two faulty commits in 10.0.x will reduce the scope of migration fai=
lures (10.0.x -&gt; 10.0.y / 10.1.z)</div><div><br></div><div>You seem to p=
ropose to backport the migration fixes (with compatibility properties) back=
 to 10.0.y</div><div>but I don&#39;t know if it is possible since only 10.0=
 machine type is available.=C2=A0</div><div><br></div><div>Apply these comp=
atibility properties only in 9.2 (and older) might make sense IMHO since 10=
.0.y behaves the same way than 10.1</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt;&gt; Reverting them in 10.0 will make<br>
&gt;&gt; 10.0 to be non-migratable with itself (10.0.5 can&#39;t be migrate=
d<br>
&gt;&gt; to 10.0.6 if we&#39;ll release 10.0.6 with these 2 patches reverte=
d).<br>
&gt;&gt;<br>
&gt;&gt; Also, as far as I can see (and I asked about this some 5 times<br>
&gt;&gt; already, with no one answering - is it that difficult?) - we<br>
&gt;&gt; should pick this series (pdcm, arch-capabilities) to 10.1.x stable=
<br>
&gt;&gt; series too, since we can&#39;t migrate from previous versions to 1=
0.1<br>
&gt;&gt; which has the two changes mentioned above.<br>
&gt; <br>
&gt; I think so. in this series, Paolo added compat options in pc_compat_10=
_0<br>
&gt; so it should be picked to stable v10.1.<br>
<br>
Again, I asked about this some 5 times already, with no single<br>
answer.<br>
<br>
&gt;&gt; It looks to me - since the breakage is already done, and both 10.0=
<br>
&gt;&gt; and 10.1 is broken, we should declare the current situation as a<b=
r>
&gt;&gt; status quo, and do the following:<br>
&gt;&gt;<br>
&gt;&gt; 1. keep the above mentioned 24778b1c7ee7a and 3d26cb65c27190e5 in<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A010.0.x (instead of reverting them);<br>
&gt;&gt;<br>
&gt;&gt; 2. pick up this 2 patches (fix cross migration issue with missing<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0pdcm, arch-capabilities) to 10.1.x (it should b=
e done either way,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0I think);<br>
&gt; <br>
&gt; IIUC, if we picked current compat options to stable v10.1, then stable=
<br>
&gt; v10.1 requires previous v10.0 sets the pdcm &amp; arch-cap bits (i.e.,=
 do<br>
&gt; not apply the fixes or revert the previous fix).<br>
<br>
Ugh.=C2=A0 Confusion++ :)=C2=A0 As you wrote yourself right above, &quot;Pa=
olo added<br>
compat options in pc_compat_10_0, so it should be picked up to stable<br>
10.1&quot;.=C2=A0 This point &quot;2&quot; is exactly this case I&#39;m tal=
king about.=C2=A0 Two<br>
commits:<br>
<br>
6529f31e0d target/i386: add compatibility property for pdcm feature<br>
e9efa4a771 target/i386: add compatibility property for arch_capabilities<br=
>
<br>
should be picked up for 10.1.x.<br>
<br>
This &quot;2&quot; point is not (yet) about 10.0.x.<br>
<br>
<br>
&gt; So it seems the reverts are unavoidable on v10.0?<br>
&gt; <br>
&gt; (Let&#39;s see what Paolo and the other maintainers think.)<br>
<br>
For 10.0, there are 2 either-or options: either we revert, or we<br>
pretend these has always been in 10.0.x and compensate, like I described<br=
>
in my previous email in this thread (to which you&#39;re replying) and<br>
re-describing now.<br>
<br>
&gt;&gt; 3. on top of these 2 &quot;missing features: pdcm, arch-capabiliti=
es&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0make the crossing line for before-10.0, not for=
 before-10.1 series, -<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0ie, consider 10.0 *also* has these properties, =
but 9.2 and before<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0are not.<br>
<br>
&gt; This issue is indeed quite tricky. Sometimes people (including myself)=
<br>
&gt; assume that backporting fixes to the stable branch can avoid adding a<=
br>
&gt; compat option. Now it seems the compat option is the better choice, as=
<br>
&gt; users need to ensure migration rather than downtime before upgrading t=
o<br>
&gt; the stable version :-(.<br>
It&#39;s a good (hopefully) lesson for me myself, - I blindly picked up<br>
a change which felt like an innocent (I even mentioned that in a commit<br>
- it&#39;s a &quot;cleanup patch&quot;) - just so a subsequent change in th=
is area<br>
applies cleanly.=C2=A0 But it wasn&#39;t a cleanup, and it wasn&#39;t trivi=
al at<br>
all.=C2=A0 So I must be much more careful the next time.=C2=A0 I&#39;m talk=
ing about<br>
3d26cb65c2 &quot;Move adjustment of CPUID_EXT_PDCM..&quot;.<br>
<br>
Speaking of the other change - it fixed a real bug which I hit myself,<br>
and I had no idea it&#39;s tricky - actually no one had this idea until<br>
e9efa4a771 &quot;property for arch_capabilities&quot;.=C2=A0 So yes, this i=
s a &quot;sh*t<br>
happens&quot; case :)<br>
<br>
<br>
Ok.<br>
<br>
So, back to the situation and the plan (two of them).<br>
<br>
<br>
1. It looks like we agree we should pick<br>
<br>
6529f31e0d target/i386: add compatibility property for pdcm feature<br>
e9efa4a771 target/i386: add compatibility property for arch_capabilities<br=
>
<br>
to 10.1.x, to make migration from older versions to 10.1.x work.<br>
<br>
<br>
2.=C2=A0 For 10.0.x, we&#39;ve two options:<br>
<br>
=C2=A0 2.a.=C2=A0 Revert<br>
=C2=A0 =C2=A0 =C2=A0e9efa4a771 &quot;do not expose ARCH_CAPABILITIES&quot;<=
br>
=C2=A0 =C2=A0 =C2=A03d26cb65c2 &quot;Move adjustment of CPUID_EXT_PDCM&quot=
;<br>
=C2=A0 =C2=A0as you initially suggested and already reviewed.<br>
<br>
=C2=A0 =C2=A0This will make 10.0.[45] &quot;bad&quot; wrt migration, and wi=
ll re-create the<br>
=C2=A0 =C2=A0issues these 2 commits fixed, but will make next 10.0.x as goo=
d as<br>
=C2=A0 =C2=A0initial 10.0.0 wrt migration.<br>
<br>
=C2=A0 2.b.=C2=A0 Instead of reverting these two which are already in 10.0.=
[45],<br>
=C2=A0 =C2=A0pretend 10.0 always had these 2 commits, and adjust subsequent=
<br>
=C2=A0 =C2=A0qemu versions just like we did with 2 &quot;add compatibility =
property&quot;<br>
=C2=A0 =C2=A0changes, but make it to be 9.2-compat property, not 10.0-compa=
t<br>
=C2=A0 =C2=A0property.<br>
<br>
=C2=A0 =C2=A0This - as far as I can see - will make 10.0.[0-3] to be &quot;=
bad&quot; wrt<br>
=C2=A0 =C2=A0migration, but not subsequent 10.0.x ones.=C2=A0 And will keep=
 the bugs<br>
=C2=A0 =C2=A0fixed in 10.0.x too.<br>
<br>
But again, I don&#39;t understand the migration logic well, so don&#39;t kn=
ow<br>
if it even makes sense.=C2=A0 2.b, if deemed to be good, will be the first<=
br>
in history (I think) to introduce compat properties for past machine<br>
types.<br>
<br>
Please excuse me for so much text :)<br>
<br>
Thank you!<br>
<br>
/mjt<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div style=3D"text-align:left"></div><div style=
=3D"text-align:left">Hector CAO<br></div><div style=3D"text-align:left">Sof=
tware Engineer =E2=80=93 Server Team / Virtualization</div><div style=3D"te=
xt-align:left"><a href=3D"mailto:hector.cao@canonical.com" target=3D"_blank=
">hector.cao@canonical.com</a></div><div style=3D"text-align:left"><a href=
=3D"https://launchpad.net/~hectorcao" target=3D"_blank">https://launc</a><a=
 href=3D"https://launchpad.net/~hectorcao" target=3D"_blank">hpad.net/~hect=
orcao</a></div><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div></div>

--000000000000deb73406411c235c--

