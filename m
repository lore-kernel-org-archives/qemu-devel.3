Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B257103E302
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0q8r-0002p3-Kn; Thu, 12 Mar 2026 20:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0q8p-0002jH-1D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:12:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0q8l-0007Vk-NZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:12:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so7371625ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 17:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773360749; cv=none;
 d=google.com; s=arc-20240605;
 b=j7QoaTymKZuv//mI7W2K0KFRof+cgEhcRTdQGq7tgzVnDuo6zT7TtaCIopCBlJTmYy
 wCvyhSlbfOVqq1fNUCLkMFf+vG6mbwdShOL/wI17OCOZkG68jMQFJUPrgSJk8WrjvqKC
 7HfTZiuukbAwiFPbOyaE86usWnXzPYRkCZQtpkyTJVOxYKVxMZ0yUfc0RIGc0B5rKqjT
 39AUlPL1AC0Hpof5/gVOx7S7/SsKac9pKwVzWq6HiRAx+pX0qWfkv6jEiQ+vvZ1l0Isv
 9Eru07X56ng7LgqZRYR3BEnX7mFrsx/WI48BvkHSNbUVp3Z6KMveoEV6IvvorC2RXwgD
 /GiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OjBm+2G6HffmDMl10bimeRJI9K+fHlO2xib3SH/tjIY=;
 fh=uZjA6eME2UYXWQGU+EK8sRcWyZEOpV51D9lL83dayHw=;
 b=hH8aJHoZqtBWIFoQUeJb+zPODlfq8D3xkuwTVd870BSlrAlDN3AqwAmWyUHy+iEARh
 HYWQTtES701pSJDiFeN83cZdyiGRS+CXzEj6+UuYoVx1nvU1VT+4cGepDdO+AhxS6xoT
 iD2H1Qz7E2MuBDqA0FTa5++02fA8jivYgkG48PXi6q3CwE+gmKIz1cgO15H8VRXbZfBN
 C9l+aMPjIoIebNJBxLGOkt5HOwNfLCTs02O3mU6rze4HdE9FA57m13IxaF3mMDFOpwok
 TiEfcEs84DMq3x3M3x/DMgdUlWMUGEESBcYe5kC3AU1VGs5GsvCkFtwduyJfvA4roUmW
 CpjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773360749; x=1773965549;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OjBm+2G6HffmDMl10bimeRJI9K+fHlO2xib3SH/tjIY=;
 b=lv6wMw8Lzh2wPKcaCwRTiL6AuQujEFH3xHlmn5ZJTKsYveZhdQLAnhYiO4B/8UA3vx
 87/FesovHM+gxAect64XVlgxU9ykkPklfLDIDl0RmEc0aHUVNMYj8vNGxPjQQ0t5AGJR
 TLdqFrBzFtDw0nL6ov7rNy/SLHeWE3amW0hXWfNswaCkmKrtYto4VN9PwYmratsPVEPN
 RYSPtI+AQ3tsJZTWg/WdY3tZXezljq5Cvu0tQze1o19WYZXgrD2qWovoP4B8s2pWO0fk
 hynj1eojISBMV+HuxMvJKIIKw4yWSTGnrmz0oc8+KNxKhtsVu7nH4ycxuuRJKD9ptaPs
 4M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773360749; x=1773965549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjBm+2G6HffmDMl10bimeRJI9K+fHlO2xib3SH/tjIY=;
 b=g41TWkwFdOjzZY664r9GxPxqVnbNAWMcsmUeDtVR51k6Q7E/dNkyHm4d3yA3KlyOVq
 1/snOouzgC0uQhnYaxnvrd6MpvCcEqJwW7h7huk7lFvU3s3wIv6XRt4vOUdlvKPRkd0G
 uve715Y4CCOTNZWKv5JiumH0kwVAHoKfW2XCH2IpbE2jA/75mf0qDIBT34lx7zf45TOp
 h7ZxZdMEwsDNaIqC9j9jWecSKmcaA1VxS5KkBIWQvWtrKRG8IQxukEeiZ6WTplH75iyf
 2Wr2vdnzHWbAxCXYONZbbEj8dfGFIxa29tgT1sFgrUm6pzo7QuC1wlRT6o3lJisb8RqJ
 Ktrg==
X-Gm-Message-State: AOJu0YxfTFg4TDE9KMBz7cnbj0uJl3K3au2if1UcUuDplp5wfQfp6NK+
 +h6zUvr4WRnHtRGIb5huseSHF4bet3765Hg8kFVoESJj2enBBUzizbDBnuYBAgo9T5dFLX2Cr6B
 VgRjZJHwZHQNRlH3/U5O9f7xhiSaJiimDiFh5HzZReg==
X-Gm-Gg: ATEYQzyFC4XlT5PsP4uOw3EDuTt19n/E4VMKHWOMcmG/pEEzjn4tG+LtJyIeCwih5S8
 vuAv49SiJnkTEI4ccium3Lrkl6A20rLdmtdYayABJ3AF41+KxQrbksWVtYi071THRdS/IQosyk3
 9+EHZfFvfaMsrfgPe3DDOsNVmp2zG01fgn9NXVsu/1gHZt83O2ARubDarTIfHuA3TVlJgi0PNcU
 5wdIZBGd8RZItZn5LNAI0X89prh/CopsPPg72Yt5venqyyU6jBYb27lmsRQnhfpeI8x4ReG4WxX
 jC+Q7eY=
X-Received: by 2002:a17:903:2b06:b0:2ae:c001:834b with SMTP id
 d9443c01a7336-2aecac3e7bdmr11482945ad.39.1773360749054; Thu, 12 Mar 2026
 17:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
 <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
 <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
 <68903178-92ef-4956-b815-dc4c4533507d@linaro.org>
 <CANCZdfqCu13nJysw3Rwhe7GJWzdSkstKCKkQAR7u0cJFOJaY-g@mail.gmail.com>
 <8dae5368-4584-40d6-a460-51b90b2491eb@linaro.org>
In-Reply-To: <8dae5368-4584-40d6-a460-51b90b2491eb@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 12 Mar 2026 18:12:18 -0600
X-Gm-Features: AaiRm50Jw_vwfhez6obYw4qz7lZUayonPOFwV8uRyk3_YtXiujrMybWwHXcJf_I
Message-ID: <CANCZdfoAXX6mkgU+TR8gmNg1uBn33SfMdYs97dkHHg3b6-w-Nw@mail.gmail.com>
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000819d65064cdcb91b"
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x635.google.com
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

--000000000000819d65064cdcb91b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 5:50=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 3/12/26 4:17 PM, Warner Losh wrote:
> >
> >
> > On Thu, Mar 12, 2026 at 4:36=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>>
> wrote:
> >
> >     On 3/12/26 1:19 PM, Warner Losh wrote:
> >      >
> >      >
> >      > On Thu, Mar 12, 2026 at 11:52=E2=80=AFAM Pierrick Bouvier
> >      > <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org=
>
> >     <mailto:pierrick.bouvier@linaro.org
> >     <mailto:pierrick.bouvier@linaro.org>>> wrote:
> >      >
> >      >     On 3/12/26 6:10 AM, Warner Losh wrote:
> >      >      > thunk.c is the same between linux-user and bsd-user (out
> >     of tree),
> >      >      > so share it between the two.
> >      >      >
> >      >      > Signed-off-by: Warner Losh <imp@bsdimp.com
> >     <mailto:imp@bsdimp.com> <mailto:imp@bsdimp.com <mailto:
> imp@bsdimp.com>>>
> >      >      > ---
> >      >      > As part of upstream blitz bsd-user, I've discovered that
> >     bsd-user and
> >      >      > linux-user have the same thunk.c file. Rather than copy
> >     it, put
> >      >     it into
> >      >      > the common-user directory and share it. It has to be
> compiled
> >      >      > per-target, unlike the rest of common-user, so modify
> >     linux-user and
> >      >      > bsd-user to grab it from there.
> >      >      > ---
> >      >      >   bsd-user/meson.build                | 1 +
> >      >      >   {linux-user =3D> common-user}/thunk.c | 0
> >      >      >   linux-user/meson.build              | 2 +-
> >      >      >   3 files changed, 2 insertions(+), 1 deletion(-)
> >      >      >
> >      >
> >      >     Indeed, thunk.c seems to be highly target specific.
> >      >     A good solution would be to move common functions to
> common-user/
> >      >     thunk.c
> >      >     and the rest in include/user/thunk.h. It may be cleaner than
> >     doing the
> >      >     meson hack. Or leave it duplicated for now, except if you
> plan on
> >      >     modifying it.
> >      >
> >      >
> >      > My concern with leaving it duplicated is the process. I create a
> >     patch
> >      > to create
> >      > bsd-user/thunk.c that's a verbatim copy of linux-user/thunk.c.
> >     Despite
> >      > putting in
> >      > my cover that this is copied code, if past is prologue, then I'l=
l
> be
> >      > asked to fix the
> >      > copyright and style, plus lots of suggestions to improve the
> >     code. But
> >      > it's just a
> >      > verbatim copy, so that's a lot of hassle just to copy it.
> >      >
> >
> >     I understand, and it's a good intention to want to remove this
> >     duplication. However, I'm not convinced a build system hack is bett=
er
> >     than a duplication.
> >
> >
> > Yup, if it were frictionless to duplicated, I'd just do that. But
> > there's always
> > some hassle or another that comes from it. And it's a dependency on doi=
ng
> > the ioctl round of upstreaming.
> >
> >      > Moving like this, though, is almost 0 friction. A small tweak to
> >     meson
> >      > is all that's
> >      > needed. I suppose I could do the #include "../linux-user/trunk.c=
"
> >     trick
> >      > to make it
> >      > less ugly in the build system, but then it's not clear it's
> >     shared, etc
> >      > and more ugly
> >      > in the code, imho.
> >      >
> >
> >     Yes, it's a hack, that's what it's for, "quick and that works but
> not a
> >     proper solution".
> >
> >      > I tried to move this stuff into thunk.h as much as possible so w=
e
> >     could
> >      > have one
> >      > compilation, and that didn't work. It really assumes that it can
> >     include
> >      > qemu.h for
> >      > the tswap, etc macros. So it's impossible to just build once.
> >      >
> >
> >     Yes, not all functions can be compiled once because they have targe=
t
> >     dependencies. That's why I invited you to simply extract common
> >     functions to common-user/thunk.c and leave the target specific bits
> in
> >     thunk.h (with static inline functions), or in a thunk-target.h
> >     header if
> >     you really want to do it cleanly. That's the proper solution here.
> >
> >     Build systems and preprocessor are not a shortcut to proper softwar=
e
> >     architecture, even though QEMU abused both of them to this end.
> >
> >
> > Yea. I'm looking for a reasonable tradeoff. I'm open to suggestions, an=
d
> am
> > even willing to split things up: "now the hack, I'll remove it within a
> > year" sort
> > of thing just to get this years-long process of upstreaming done.
> >
>
> As mentioned, I think that extracting common part in a file and put the
> rest in thunk-target.h is the best approach here.
>
> If creating a new file creates too much frustration, I would be happy to
> give you a reviewed-by on simply moving all functions as static inline
> ones in thunk-target.h.
>
> And if even this is still too complicated, I would be happy to give a
> reviewed-by on any copyright change for this file.
>
> You have now 3 solutions without any hack :)
>

Great! I'll give it another run. My earlier attempts were in the inbetween
spaces of my day.

Moving to a new file isn't so bad. That seems to be fine to regularize the
copyright stuff. I'll give that a try and see if I can find the right way
to refactor that's not obnoxious.... and doesn't break anything...


> >      > Now looking at the code, a lot of it would be a lot simpler with
> >      > 'Generic', but that's
> >      > a battle for another day. As is the notion of just generating
> >     this data
> >      > from the .h files
> >      > rather than hard-coding it here, but that too is a battle for
> >     another
> >      > day. I'd like to
> >      > get this upstreamed so I'm spending my time on these sorts of
> >     battle.s
> >      >
> >
> >     I totally get it, and we have been dealing with a lot of things lik=
e
> >     this for the single-binary topic, trying to find the good compromis=
es
> >     between refactoring APIs and doing limited changes.
> >
> >     If extracting the common and target part looks like too much work,
> just
> >     leave it and simply change the copyright header, it's not a big
> >     thing to
> >     do, and you can modify both in the same series, no one will yell at
> you
> >     for changing comments in one file in linux-user.
> >
> >
> > Yea. You should have seen the pushback I got from changing the copyrigh=
t
> > header when I had the permissions to do it....  If I copy the file, it'=
s
> > a full copy, verbatim, no changes. It's not my code, so I can't change
> > things.  I have a similar issue from some code I plan on copying from
> > FreeBSD to avoid having to chase the strace.list stuff. Since I can
> > easily hack upstream FreeBSD to be what I need for qemu, I'll evolve
> > things there (ideally, just making it a private library I can hook into
> > the bsd-user build for tracing so qemu gets whatever FreeBSD does in
> > truss for free...
> >
>
> I indeed read this thread, which was pointed to me by other people who
> read it also. Our general opinion was that it's totally unfair to push
> all this on you, and that idealism on license comments is absolutely not
> worth all the hassle, especially for someone trying to help on his free
> time. Even for someone paid to do it, it would not be worth.
>

Yea. I'm mostly happy to follow the rules, if I know what they are and they
don't cause too much extra work that sidetrack me. I think I have them now,
and pre-did all the copyright header fuzziness that I had permission to do
in bsd-user so the next round shouldn't be so weird.


> I ran as well into issues of pragmatism vs idealism with the concerned
> person on this thread, and there is alas no proper solution to end this
> behavior. The simplest way to deal with it is to stick to rationale
> arguments, not let it go and don't apologize for saying "No, it's
> unreasonable to ask for this".
> If enough people do this, it might end up triggering a positive change
> in the community, instead of implicitely validating this behavior
> blocking contributions.
>
> For concerned bsd-user files, and using a rationale approach, I would
> simply suggest to contact past contributors of those files to collect a
> OK, or ideally ask them to answer on this thread and mention "I'm ok".
> If they don't answer after one week, consider it's an implicit ok. Then
> move on, and pull the changes. No one will come sue you or QEMU for a
> copyright comment.
>

Yea. Sounds fair. I'll have another blast of about 100 patches, and that
should get us down to ioctls and truss needing to be merged, which I hope
to find a novel solution for... Better to merge the stuff w/o known hassles
then do the hassle-ful stuff.  Once I get it all in, my time can go to
making things better again...

Thanks for the help and listening to my concerns.

Warner


> > But maybe the next round is all but the ioclts and see if some other
> > solution can be found in the interim.
> >
> > Or maybe I'll find the right people that can sign off on 'just copy it'
> > so I can get on with things :)
> >
> >     As you said, pick up the right battles and ignore the rest.
> >
> >
> > Yea. Maybe the next round will just be the simple stuff w/o battles....
> >
> >      > Warner
> >
> >     Regards,
> >     Pierrick
> >
>
> Thanks for all the work you're doing on bsd side, this part really needs
> some love, and it's really good to see someone giving it.
>
> Regards,
> Pierrick
>

--000000000000819d65064cdcb91b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 5:50=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 3/12/26 4:17 PM, Warner Los=
h wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Mar 12, 2026 at 4:36=E2=80=AFPM Pierrick Bouvier <br>
&gt; &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org" target=3D"_blank">p=
ierrick.bouvier@linaro.org</a> &lt;mailto:<a href=3D"mailto:pierrick.bouvie=
r@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 3/12/26 1:19 PM, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Mar 12, 2026 at 11:52=E2=80=AFAM Pier=
rick Bouvier<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a> &lt;mailto:<a href=
=3D"mailto:pierrick.bouvier@linaro.org" target=3D"_blank">pierrick.bouvier@=
linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pierrick.bouvier@linar=
o.org" target=3D"_blank">pierrick.bouvier@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pierrick.bouvier@linar=
o.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;&gt;&gt; wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 3/12/26 6:10 AM, Warner=
 Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; thunk.c is the same =
between linux-user and bsd-user (out<br>
&gt;=C2=A0 =C2=A0 =C2=A0of tree),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; so share it between =
the two.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Warne=
r Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt; &lt;mailto:<a href=3D"mailto:imp@bsdimp.=
com" target=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=3D"mailto:imp@=
bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; As part of upstream =
blitz bsd-user, I&#39;ve discovered that<br>
&gt;=C2=A0 =C2=A0 =C2=A0bsd-user and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; linux-user have the =
same thunk.c file. Rather than copy<br>
&gt;=C2=A0 =C2=A0 =C2=A0it, put<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0it into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; the common-user dire=
ctory and share it. It has to be compiled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; per-target, unlike t=
he rest of common-user, so modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0linux-user and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; bsd-user to grab it =
from there.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0bsd-user=
/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{linux-u=
ser =3D&gt; common-user}/thunk.c | 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0linux-us=
er/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files =
changed, 2 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Indeed, thunk.c seems to b=
e highly target specific.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0A good solution would be t=
o move common functions to common-user/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0thunk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and the rest in include/us=
er/thunk.h. It may be cleaner than<br>
&gt;=C2=A0 =C2=A0 =C2=A0doing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0meson hack. Or leave it du=
plicated for now, except if you plan on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0modifying it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; My concern with leaving it duplicated is the =
process. I create a<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to create<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; bsd-user/thunk.c that&#39;s a verbatim copy o=
f linux-user/thunk.c.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Despite<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; putting in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; my cover that this is copied code, if past is=
 prologue, then I&#39;ll be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; asked to fix the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; copyright and style, plus lots of suggestions=
 to improve the<br>
&gt;=C2=A0 =C2=A0 =C2=A0code. But<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; it&#39;s just a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; verbatim copy, so that&#39;s a lot of hassle =
just to copy it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I understand, and it&#39;s a good intention to want=
 to remove this<br>
&gt;=C2=A0 =C2=A0 =C2=A0duplication. However, I&#39;m not convinced a build=
 system hack is better<br>
&gt;=C2=A0 =C2=A0 =C2=A0than a duplication.<br>
&gt; <br>
&gt; <br>
&gt; Yup, if it were frictionless to duplicated, I&#39;d just do that. But =
<br>
&gt; there&#39;s always<br>
&gt; some hassle or another that comes from it. And it&#39;s a dependency o=
n doing<br>
&gt; the ioctl round of upstreaming.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Moving like this, though, is almost 0 frictio=
n. A small tweak to<br>
&gt;=C2=A0 =C2=A0 =C2=A0meson<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; is all that&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; needed.=C2=A0I suppose I could do the #includ=
e &quot;../linux-user/trunk.c&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0trick<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to make it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; less ugly in the build system, but=C2=A0then =
it&#39;s not clear it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0shared, etc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and more ugly<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; in the code, imho.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, it&#39;s a hack, that&#39;s what it&#39;s for,=
 &quot;quick and that works but not a<br>
&gt;=C2=A0 =C2=A0 =C2=A0proper solution&quot;.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I tried to move this stuff into thunk.h as mu=
ch as possible so we<br>
&gt;=C2=A0 =C2=A0 =C2=A0could<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; have one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; compilation, and that didn&#39;t work. It rea=
lly assumes that it can<br>
&gt;=C2=A0 =C2=A0 =C2=A0include<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; qemu.h for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the tswap, etc macros. So it&#39;s impossible=
 to just build once.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, not all functions can be compiled once because=
 they have target<br>
&gt;=C2=A0 =C2=A0 =C2=A0dependencies. That&#39;s why I invited you to simpl=
y extract common<br>
&gt;=C2=A0 =C2=A0 =C2=A0functions to common-user/thunk.c and leave the targ=
et specific bits in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thunk.h (with static inline functions), or in a thu=
nk-target.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0header if<br>
&gt;=C2=A0 =C2=A0 =C2=A0you really want to do it cleanly. That&#39;s the pr=
oper solution here.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Build systems and preprocessor are not a shortcut t=
o proper software<br>
&gt;=C2=A0 =C2=A0 =C2=A0architecture, even though QEMU abused both of them =
to this end.<br>
&gt; <br>
&gt; <br>
&gt; Yea. I&#39;m looking for a reasonable tradeoff. I&#39;m open to sugges=
tions, and am<br>
&gt; even willing to split things up: &quot;now the hack, I&#39;ll remove i=
t within a <br>
&gt; year&quot; sort<br>
&gt; of thing just to get this years-long process of upstreaming done.<br>
&gt;<br>
<br>
As mentioned, I think that extracting common part in a file and put the <br=
>
rest in thunk-target.h is the best approach here.<br>
<br>
If creating a new file creates too much frustration, I would be happy to <b=
r>
give you a reviewed-by on simply moving all functions as static inline <br>
ones in thunk-target.h.<br>
<br>
And if even this is still too complicated, I would be happy to give a <br>
reviewed-by on any copyright change for this file.<br>
<br>
You have now 3 solutions without any hack :)<br></blockquote><div><br></div=
><div>Great! I&#39;ll give it another run. My earlier attempts were in the =
inbetween spaces of my day.</div><div><br></div><div>Moving to a new file i=
sn&#39;t so bad. That seems to be fine to regularize the copyright stuff. I=
&#39;ll give that a try and see if I can find the right way to refactor tha=
t&#39;s not obnoxious.... and doesn&#39;t break anything...</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Now looking at the code, a lot of it would be=
 a lot simpler with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;Generic&#39;, but that&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; a battle for another day. As is the notion of=
 just generating<br>
&gt;=C2=A0 =C2=A0 =C2=A0this data<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; from the .h files<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; rather than hard-coding it here, but that too=
 is a battle for<br>
&gt;=C2=A0 =C2=A0 =C2=A0another<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; day. I&#39;d like to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; get this upstreamed so I&#39;m spending my ti=
me on these sorts of<br>
&gt;=C2=A0 =C2=A0 =C2=A0battle.s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I totally get it, and we have been dealing with a l=
ot of things like<br>
&gt;=C2=A0 =C2=A0 =C2=A0this for the single-binary topic, trying to find th=
e good compromises<br>
&gt;=C2=A0 =C2=A0 =C2=A0between refactoring APIs and doing limited changes.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If extracting the common and target part looks like=
 too much work, just<br>
&gt;=C2=A0 =C2=A0 =C2=A0leave it and simply change the copyright header, it=
&#39;s not a big<br>
&gt;=C2=A0 =C2=A0 =C2=A0thing to<br>
&gt;=C2=A0 =C2=A0 =C2=A0do, and you can modify both in the same series, no =
one will yell at you<br>
&gt;=C2=A0 =C2=A0 =C2=A0for changing comments in one file in linux-user.<br=
>
&gt; <br>
&gt; <br>
&gt; Yea. You should have seen the pushback I got from changing the copyrig=
ht <br>
&gt; header when I had the permissions to do it....=C2=A0 If I copy the fil=
e, it&#39;s <br>
&gt; a full copy, verbatim, no changes. It&#39;s not my code, so I can&#39;=
t change <br>
&gt; things.=C2=A0 I have a similar issue from some code I plan on copying =
from <br>
&gt; FreeBSD to avoid having to chase the strace.list stuff.=C2=A0Since I c=
an <br>
&gt; easily hack upstream FreeBSD to be what I need for qemu, I&#39;ll evol=
ve <br>
&gt; things there (ideally, just making it a private library I can hook int=
o <br>
&gt; the bsd-user build for tracing so qemu gets whatever FreeBSD does in <=
br>
&gt; truss for free...<br>
&gt;<br>
<br>
I indeed read this thread, which was pointed to me by other people who <br>
read it also. Our general opinion was that it&#39;s totally unfair to push =
<br>
all this on you, and that idealism on license comments is absolutely not <b=
r>
worth all the hassle, especially for someone trying to help on his free <br=
>
time. Even for someone paid to do it, it would not be worth.<br></blockquot=
e><div><br></div><div>Yea. I&#39;m mostly happy to follow the rules, if I k=
now what they are and they don&#39;t cause too much extra work that sidetra=
ck me. I think I have them now, and pre-did all the copyright header fuzzin=
ess that I had permission to do in bsd-user so the next round shouldn&#39;t=
 be so weird.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
I ran as well into issues of pragmatism vs idealism with the concerned <br>
person on this thread, and there is alas no proper solution to end this <br=
>
behavior. The simplest way to deal with it is to stick to rationale <br>
arguments, not let it go and don&#39;t apologize for saying &quot;No, it&#3=
9;s <br>
unreasonable to ask for this&quot;.<br>
If enough people do this, it might end up triggering a positive change <br>
in the community, instead of implicitely validating this behavior <br>
blocking contributions.<br>
<br>
For concerned bsd-user files, and using a rationale approach, I would <br>
simply suggest to contact past contributors of those files to collect a <br=
>
OK, or ideally ask them to answer on this thread and mention &quot;I&#39;m =
ok&quot;. <br>
If they don&#39;t answer after one week, consider it&#39;s an implicit ok. =
Then <br>
move on, and pull the changes. No one will come sue you or QEMU for a <br>
copyright comment.<br></blockquote><div><br></div><div>Yea. Sounds fair. I&=
#39;ll have another blast of about 100 patches, and that should get us down=
 to ioctls and truss needing to be merged, which I hope to find a novel sol=
ution for... Better to merge the stuff w/o known hassles then do the hassle=
-ful stuff.=C2=A0 Once I get it all in, my time can go to making things bet=
ter again...</div><div><br></div><div>Thanks for the help and listening to =
my concerns.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; But maybe the next round is all but the ioclts and see if some other <=
br>
&gt; solution can be found in the interim.<br>
&gt; <br>
&gt; Or maybe I&#39;ll find the right people that can sign off on &#39;just=
 copy it&#39; <br>
&gt; so I can get on with things :)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0As you said, pick up the right battles and ignore t=
he rest.<br>
&gt; <br>
&gt; <br>
&gt; Yea. Maybe the next round will just be the simple stuff w/o battles...=
.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Warner<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Pierrick<br>
&gt; <br>
<br>
Thanks for all the work you&#39;re doing on bsd side, this part really need=
s <br>
some love, and it&#39;s really good to see someone giving it.<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--000000000000819d65064cdcb91b--

