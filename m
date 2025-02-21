Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D2AC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 18:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXRx-0006RK-LL; Fri, 21 Feb 2025 13:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tlXRv-0006Qx-DU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tlXRs-0004UO-Ie
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740161306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ADBYFikQt863PC4d6YHBTn0dvcMx7pnQUrFKjyIZlI=;
 b=IbVz5i5ZKtU4oYW/qmx2f4KAKKGJfuKdSu/NwjvWGBreVWgTolSS4uNfrbmSti4diBT4jn
 GGz+PFUNBoyTAX9yodV2kpEFk4sDZpJmBvg/QVhjLcqUQwellVYz/qPi0Mw+J++ij7X2ut
 PVito76uAfAU68IJoE5TwP5fK76GIiU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-bN-hJeYdNJ-cbFdPYu5oXA-1; Fri, 21 Feb 2025 13:08:24 -0500
X-MC-Unique: bN-hJeYdNJ-cbFdPYu5oXA-1
X-Mimecast-MFC-AGG-ID: bN-hJeYdNJ-cbFdPYu5oXA_1740161304
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc1a70935fso5390516a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 10:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740161303; x=1740766103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ADBYFikQt863PC4d6YHBTn0dvcMx7pnQUrFKjyIZlI=;
 b=OOz+lifA04WYX+p9aZighAm8gK0JjOfasEMn3pJu+1/y7XfaCE9NpFHR9dLlfHPPIT
 Zsq5SC4okThr4k9+xPNPvewHNwVLqRkgYqMIFFWBEJ1yVMAUAMpvVICrj9xpBSBzxWNe
 H+irKbkIchjPP4N7u7BFwvGql04eR6TOnFfw3z070hABJywT6UMg6GxPXW87kLLdNh0q
 TScGgQ0OE63i6f38Nz6p1zXGqMvjbq2esadsGazlc61MGjexEM8Ubi2PsDuzhz0C/lQN
 fsHIc6u2o7N3qBUS1oJBfJ/FeXo2NFLG+QlGMaPUFslApVa3357fg3LcEMacDgvaKO0C
 VkZg==
X-Gm-Message-State: AOJu0YzNb7Lw9zInbCxcyk7klQlz8keFCFGnreqpkXul3mJgZVXL+ATc
 ZvoKsZdcbkvYVrILh/MpVtXH1uzQ011f+31/qg3qOStpo5a67a9Apx5O/0IS3MNUaWrH0SiPKr9
 odzLgDYT9xNK6GaHG547gvJweQzSzy+I1/U1bloJM6kiweIdrgBwyp3Y7qg6Ls3UPOHV41FswZ8
 48YB1Y1GH/MtGgz+UBuiiNgP5gd60=
X-Gm-Gg: ASbGncthToXhWUVDnB35LOQshCLFKgw8D5T53FhFLYZgcq+Qs3ePCZJCOgBUskKxSwQ
 pSBQYjHuG4Mn+lBAyvVBB/cmJKawDMT9+aFTwI8KYczqCma4aRpY4g/t9xy/KeOLwyo35ey1KYL
 P26DiDFo3WDGYsuItiYFEnq3fYUwF3
X-Received: by 2002:a17:90b:4c8e:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fce78aeaeamr6579951a91.8.1740161303518; 
 Fri, 21 Feb 2025 10:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX5l1XO/W7tNFhvSXjyrOsrogTYm9yj6XQsOpF8u9HljIY1GJ+4s9mIkXvJMe/XsFcDBmFGXbIiRYTTI1DsNo=
X-Received: by 2002:a17:90b:4c8e:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fce78aeaeamr6579827a91.8.1740161302173; Fri, 21 Feb 2025
 10:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <87wmds4tpk.fsf@pond.sub.org>
 <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
 <874j0q2hof.fsf@pond.sub.org>
 <CAFn=p-aXKtaiq8LAgTCDRNHU78yv8mBfsbuCkP8Smp=TWDn6jw@mail.gmail.com>
 <87o6yvn6iy.fsf@pond.sub.org>
In-Reply-To: <87o6yvn6iy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Feb 2025 13:08:10 -0500
X-Gm-Features: AWEUYZnD3VeZQjdcqF25NsMpOVJU5ih0qZEBwHwgIUyZjRQng-tsYkmN3n93jvw
Message-ID: <CAFn=p-aG38tqxue2ZvHP_9LEyWXXxawd=SCuOJNptNKOihONUg@mail.gmail.com>
Subject: Re: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000044b778062eaae07a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000044b778062eaae07a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:42=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Feb 19, 2025 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > "The text handler you add looks just like the existing latex handler=
.
> Does
> >> > LaTeX output lack "little headings", too?"
> >> >
> >> > Yes, almost certainly. Can you let me know which output formats we
> actually
> >> > "care about"? I'll have to test them all.
> >>
> >> As far as I can tell, our build system runs sphinx-build -b html and -=
b
> >> man.
> >>
> >> I run it with -b text manually all the time to hunt for and review
> >> changes in output.  I'd prefer to keep it working if practical.
> >>
> >> For what it's worth, there is a bit of LaTeX configuration in
> >> docs/conf.py.
> >>
> >> >                                           In the meantime, I upgrade=
d
> my
> >> > patch so that the text translator properly handles branches with
> headings
> >> > that delineate the different branches so that the text output is ful=
ly
> >> > reasonable. I will need to do the same for any format we care about.
> >> >
> >> > I've re-pushed as of "about 30 minutes before I wrote this email" --
> >> > https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2
> >> >
> >> > This branch includes the text generator fixes (which technically
> belong
> >> > with the predecessor series we skipped, but I'll refactor that later=
.)
> >> > it also includes fixes to the branch inliner, generated return
> statements,
> >> > and generated out-of-band feature sections.
> >>
> >> I'll fetch it, thanks!
> >>
> >> > (Long story short: inserting new sections in certain spots was broke=
n
> >> > because of cache. Oops. We can discuss more why I wrote that part of
> the
> >> > code like I did in review for the patch that introduced that problem=
.
> It's
> >> > the "basic inliner" patch.)
> >> >
> >> > Below, I'm going to try a new communication approach where I
> explicitly say
> >> > if I have added something to my tasklist or not so that it's clear t=
o
> you
> >> > what I believe is actionable (and what I am agreeing to change) and
> what I
> >> > believe needs stronger input from you before I do anything. Apologie=
s
> if it
> >> > seems a little robotic, just trying new things O:-)
> >> >
> >> > On that note: not added to tasklist: do we need the LaTeX handler? D=
o
> we
> >> > need any others? Please confirm O:-)
> >>
> >> See above.
> >>
> >
> > I've got html and text working, text wasn't hard. I will give it a good
> > college try on the LaTeX and man formats. Might be easy. The issue here
> is
> > the custom node I introduced for the collapsible details sections which
> has
> > no default handler in the generators. I'll have to learn more about tha=
t
> > part of the API, I haven't interfaced with it much yet.
>
> Understand.
>
> Have you considered cutting the series in half before the inliner?
> First part emits "The members of ..." like the old doc generator.
> Second part replaces that with inlined material.
>
> We could totally release with just the first half!  Inlining is great,
> but even without it, your work looks so much better and is so much more
> usable.
>

I may indeed just do that... though we still need to solve "where to put
the ifcond data?" question. The documentation culling also must be held
back in this case too, which I am fine with.

Let me fork my work (again) and see how complicated an inlinerless version
would be... maybe that's a great way to flush the queue. maybe.


>
> >> > On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com>
> wrote:
> >> >
> >> >> I started to eyeball old and new generated output side by side.
> >> >>
> >> >> New table of contents shows one level, old two.  No objection; the
> >> >> navigation thingie on the left is more useful anyway.
> >> >>
> >> >
> >> > Unintentional, but if you like it, it's fine by me. Nothing added to
> my
> >> > tasklist.
> >>
> >> Mention in a commit message.
> >>
> >
> > Sure. I... just need to figure out which commit to mention it in. Added
> to
> > my list, anyway.
>

It turns out this happens in the "example" doc patch, it's just a setting
in index.rst. I didn't even intend to commit that patch anyway. So this is
a nothing-burger.


> >
> >
> >>
> >> >> The new generator elides unreferenced types.  Generally good, but t=
wo
> >> >> observations:
> >> >>
> >> >> * QapiErrorClass is unreferenced, but its members are mentioned in
> >> >>   Errors sections.  QapiErrorClass serves as better than nothing
> error
> >> >>   code documentation, but it's gone in the new doc.  So this is a
> minor
> >> >>   regression.  We can figure out what to do about it later.
> >> >>
> >> >
> >> > Right. I debated making the members references to that class, but
> recalled
> >> > that you disliked this class and figured you'd not like such a
> change, so I
> >> > just left it alone. I do not have cross-references for individual
> members
> >> > of objects at all yet anyway, so this is definitely more work
> regardless.
> >> >
> >> > We could always create a pragma of some sort (or just hardcode a
> list) of
> >> > items that must be documented regardless of if they're referenced or
> not.
> >> > Please let me know your preference and I will add a "ticket" on my
> personal
> >> > tasklist for this project to handle that at /some point/. Nothing
> added to
> >> > my tasklist just yet.
> >>
> >> Suggest to add something like "compensate for the loss of QapiErrorCla=
ss
> >> documentation in the QEMU QMP Reference Manual".
> >>
> >
> > Got it. Possibly a "for later" task but not much later. It can always
> come
> > after this first series, but before we "turn on" the new generator, if
> that
> > makes sense. Just so we reach a quiescent point and flush the
> staggeringly
> > large queue.
>
> I think we could even do it after "turn on".  Yes, it's a small
> regression, but I believe the improvements are big enough to outweigh
> small regressions like this one.
>

OK.


>
> > I guess what I mean is: "Let's make sure what I've got here so far is
> good
> > first, and then I'll start adding stuff."
>
> [...]
>
> >> >> The new doc's headings use "Struct" or "Union" where the old one us=
es
> >> >> just "Object".  Let's keep "Object", please.
> >> >>
> >> >
> >> > I was afraid you'd ask for this. OK, I think it's an easy change. Ca=
n
> I
> >> > keep the index page segmented by object type still, though?
> >> >
> >> > I do find knowing the *type* of object to be helpful as a developer,
> >>
> >> Can you explain why and how struct vs. union matters to you as a
> >> developer?
> >>
> >
> > I suppose it's just internal details that I like to know, but tend to
> find
> > the HTML reference easier to work with than grepping through the qapi
> > files. I'm gonna change it for you anyway because I agree it's not
> > consistent with the philosophy of "end user QMP reference". Just feels
> like
> > a tiny shame somehow.
> >
> >
> >>
> >> > though
> >> > I understand that from the point of view of a QMP user, they're all
> just
> >> > objects, so your request makes sense.
> >>
> >> I'd prefer a single index.
> >>
> >
> > So ... structs, unions, alternates all condensed down to "Object", is
> that
> > right? We get to keep command/enum/event separate, I assume.
>
> No, only structs and unions are "Object", alternates are "Alternate".
>
> For me, the separation between struct and union is an unfortunate
> remnant of somewhat winding development history.
>
> A union is has common members, one of them is the tag, and for each tag
> value, it may have variant members.
>
> A struct is a degenerate union: no variants.
>
> This is as old as the hills: Pascal records are just like this.
>
> QMP introspection doesn't show structs and unions, just objects, which
> may or may not have variants.
>
> The schema language syntax, however, is still rooted (stuck?) in a past
> when unions could not have common members other than the tag.
>

OK, I can combine these two easily then. I see why you feel it isn't worth
knowing the difference for developers either under this view.


>
> [...]
>
> >> >> The new doc doesn't show non-definition conditionals, as mentioned =
in
> >> >> the cover letter.  It shows definition conditionals twice.  Once
> should
> >> >> suffice.
> >> >>
> >> >
> >> > Known/intentional issue. I couldn't decide where I wanted it, so I
> put it
> >> > in both places. If you have a strong opinion right now, please let m=
e
> know
> >> > what it is and I'll take care of it, it's easy - but it's code in th=
e
> >> > predecessor series and nothing to do with qapidoc, so please put it
> out of
> >> > mind for now.
> >> >
> >> > If you don't have strong feelings, or you feel that the answer may
> depend
> >> > on how we solve other glaring issues (non-definition conditionals),
> let's
> >> > wait a little bit before making a decision.
> >> >
> >> > Added to tasklist: "Remove the duplication of definition
> conditionals";
> >> > left unspecified is how or in what direction :)
> >>
> >> ACK
> >>
> >> I'll try to make up my mind :)
> >>
> >
> > I should also point out, this is an issue in the domain and not the
> > generator; the generated rst document doesn't have this duplication. So
> > it's kind of a no-op while we look and consider this specific series, b=
ut
> > it's still on my list when we go to look at the predecessor series.
>
> Understood.
>
> [...]
>
>

--00000000000044b778062eaae07a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 21,=
 2025 at 1:42=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Feb 19, 2025 at 8:22=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; &quot;The text handler you add looks just like the existing l=
atex handler. Does<br>
&gt;&gt; &gt; LaTeX output lack &quot;little headings&quot;, too?&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, almost certainly. Can you let me know which output forma=
ts we actually<br>
&gt;&gt; &gt; &quot;care about&quot;? I&#39;ll have to test them all.<br>
&gt;&gt;<br>
&gt;&gt; As far as I can tell, our build system runs sphinx-build -b html a=
nd -b<br>
&gt;&gt; man.<br>
&gt;&gt;<br>
&gt;&gt; I run it with -b text manually all the time to hunt for and review=
<br>
&gt;&gt; changes in output.=C2=A0 I&#39;d prefer to keep it working if prac=
tical.<br>
&gt;&gt;<br>
&gt;&gt; For what it&#39;s worth, there is a bit of LaTeX configuration in<=
br>
&gt;&gt; docs/conf.py.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0In the meantime, I upgraded my<br>
&gt;&gt; &gt; patch so that the text translator properly handles branches w=
ith headings<br>
&gt;&gt; &gt; that delineate the different branches so that the text output=
 is fully<br>
&gt;&gt; &gt; reasonable. I will need to do the same for any format we care=
 about.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;ve re-pushed as of &quot;about 30 minutes before I wrot=
e this email&quot; --<br>
&gt;&gt; &gt; <a href=3D"https://gitlab.com/jsnow/qemu/-/commits/sphinx-dom=
ain-blergh2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsnow/=
qemu/-/commits/sphinx-domain-blergh2</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This branch includes the text generator fixes (which technica=
lly belong<br>
&gt;&gt; &gt; with the predecessor series we skipped, but I&#39;ll refactor=
 that later.)<br>
&gt;&gt; &gt; it also includes fixes to the branch inliner, generated retur=
n statements,<br>
&gt;&gt; &gt; and generated out-of-band feature sections.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll fetch it, thanks!<br>
&gt;&gt;<br>
&gt;&gt; &gt; (Long story short: inserting new sections in certain spots wa=
s broken<br>
&gt;&gt; &gt; because of cache. Oops. We can discuss more why I wrote that =
part of the<br>
&gt;&gt; &gt; code like I did in review for the patch that introduced that =
problem. It&#39;s<br>
&gt;&gt; &gt; the &quot;basic inliner&quot; patch.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Below, I&#39;m going to try a new communication approach wher=
e I explicitly say<br>
&gt;&gt; &gt; if I have added something to my tasklist or not so that it&#3=
9;s clear to you<br>
&gt;&gt; &gt; what I believe is actionable (and what I am agreeing to chang=
e) and what I<br>
&gt;&gt; &gt; believe needs stronger input from you before I do anything. A=
pologies if it<br>
&gt;&gt; &gt; seems a little robotic, just trying new things O:-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On that note: not added to tasklist: do we need the LaTeX han=
dler? Do we<br>
&gt;&gt; &gt; need any others? Please confirm O:-)<br>
&gt;&gt;<br>
&gt;&gt; See above.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I&#39;ve got html and text working, text wasn&#39;t hard. I will give =
it a good<br>
&gt; college try on the LaTeX and man formats. Might be easy. The issue her=
e is<br>
&gt; the custom node I introduced for the collapsible details sections whic=
h has<br>
&gt; no default handler in the generators. I&#39;ll have to learn more abou=
t that<br>
&gt; part of the API, I haven&#39;t interfaced with it much yet.<br>
<br>
Understand.<br>
<br>
Have you considered cutting the series in half before the inliner?<br>
First part emits &quot;The members of ...&quot; like the old doc generator.=
<br>
Second part replaces that with inlined material.<br>
<br>
We could totally release with just the first half!=C2=A0 Inlining is great,=
<br>
but even without it, your work looks so much better and is so much more<br>
usable.<br></blockquote><div><br></div><div>I may indeed just do that... th=
ough we still need to solve &quot;where to put the ifcond data?&quot; quest=
ion. The documentation culling also must be held back in this case too, whi=
ch I am fine with.</div><div><br></div><div>Let me fork my work (again) and=
 see how complicated an inlinerless version would be... maybe that&#39;s a =
great way to flush the queue. maybe.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; &gt; On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</=
a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; I started to eyeball old and new generated output side by=
 side.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; New table of contents shows one level, old two.=C2=A0 No =
objection; the<br>
&gt;&gt; &gt;&gt; navigation thingie on the left is more useful anyway.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Unintentional, but if you like it, it&#39;s fine by me. Nothi=
ng added to my<br>
&gt;&gt; &gt; tasklist.<br>
&gt;&gt;<br>
&gt;&gt; Mention in a commit message.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Sure. I... just need to figure out which commit to mention it in. Adde=
d to<br>
&gt; my list, anyway.<br></blockquote><div><br></div><div>It turns out this=
 happens in the &quot;example&quot; doc patch, it&#39;s just a setting in i=
ndex.rst. I didn&#39;t even intend to commit that patch anyway. So this is =
a nothing-burger.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; The new generator elides unreferenced types.=C2=A0 Genera=
lly good, but two<br>
&gt;&gt; &gt;&gt; observations:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; * QapiErrorClass is unreferenced, but its members are men=
tioned in<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0Errors sections.=C2=A0 QapiErrorClass serves =
as better than nothing error<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0code documentation, but it&#39;s gone in the =
new doc.=C2=A0 So this is a minor<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0regression.=C2=A0 We can figure out what to d=
o about it later.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Right. I debated making the members references to that class,=
 but recalled<br>
&gt;&gt; &gt; that you disliked this class and figured you&#39;d not like s=
uch a change, so I<br>
&gt;&gt; &gt; just left it alone. I do not have cross-references for indivi=
dual members<br>
&gt;&gt; &gt; of objects at all yet anyway, so this is definitely more work=
 regardless.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We could always create a pragma of some sort (or just hardcod=
e a list) of<br>
&gt;&gt; &gt; items that must be documented regardless of if they&#39;re re=
ferenced or not.<br>
&gt;&gt; &gt; Please let me know your preference and I will add a &quot;tic=
ket&quot; on my personal<br>
&gt;&gt; &gt; tasklist for this project to handle that at /some point/. Not=
hing added to<br>
&gt;&gt; &gt; my tasklist just yet.<br>
&gt;&gt;<br>
&gt;&gt; Suggest to add something like &quot;compensate for the loss of Qap=
iErrorClass<br>
&gt;&gt; documentation in the QEMU QMP Reference Manual&quot;.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Got it. Possibly a &quot;for later&quot; task but not much later. It c=
an always come<br>
&gt; after this first series, but before we &quot;turn on&quot; the new gen=
erator, if that<br>
&gt; makes sense. Just so we reach a quiescent point and flush the staggeri=
ngly<br>
&gt; large queue.<br>
<br>
I think we could even do it after &quot;turn on&quot;.=C2=A0 Yes, it&#39;s =
a small<br>
regression, but I believe the improvements are big enough to outweigh<br>
small regressions like this one.<br></blockquote><div><br></div><div>OK.</d=
iv><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I guess what I mean is: &quot;Let&#39;s make sure what I&#39;ve got he=
re so far is good<br>
&gt; first, and then I&#39;ll start adding stuff.&quot;<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt;&gt; The new doc&#39;s headings use &quot;Struct&quot; or &quo=
t;Union&quot; where the old one uses<br>
&gt;&gt; &gt;&gt; just &quot;Object&quot;.=C2=A0 Let&#39;s keep &quot;Objec=
t&quot;, please.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I was afraid you&#39;d ask for this. OK, I think it&#39;s an =
easy change. Can I<br>
&gt;&gt; &gt; keep the index page segmented by object type still, though?<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I do find knowing the *type* of object to be helpful as a dev=
eloper,<br>
&gt;&gt;<br>
&gt;&gt; Can you explain why and how struct vs. union matters to you as a<b=
r>
&gt;&gt; developer?<br>
&gt;&gt;<br>
&gt;<br>
&gt; I suppose it&#39;s just internal details that I like to know, but tend=
 to find<br>
&gt; the HTML reference easier to work with than grepping through the qapi<=
br>
&gt; files. I&#39;m gonna change it for you anyway because I agree it&#39;s=
 not<br>
&gt; consistent with the philosophy of &quot;end user QMP reference&quot;. =
Just feels like<br>
&gt; a tiny shame somehow.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; though<br>
&gt;&gt; &gt; I understand that from the point of view of a QMP user, they&=
#39;re all just<br>
&gt;&gt; &gt; objects, so your request makes sense.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;d prefer a single index.<br>
&gt;&gt;<br>
&gt;<br>
&gt; So ... structs, unions, alternates all condensed down to &quot;Object&=
quot;, is that<br>
&gt; right? We get to keep command/enum/event separate, I assume.<br>
<br>
No, only structs and unions are &quot;Object&quot;, alternates are &quot;Al=
ternate&quot;.<br>
<br>
For me, the separation between struct and union is an unfortunate<br>
remnant of somewhat winding development history.<br>
<br>
A union is has common members, one of them is the tag, and for each tag<br>
value, it may have variant members.<br>
<br>
A struct is a degenerate union: no variants.<br>
<br>
This is as old as the hills: Pascal records are just like this.<br>
<br>
QMP introspection doesn&#39;t show structs and unions, just objects, which<=
br>
may or may not have variants.<br>
<br>
The schema language syntax, however, is still rooted (stuck?) in a past<br>
when unions could not have common members other than the tag.<br></blockquo=
te><div><br></div><div>OK, I can combine these two easily then. I see why y=
ou feel it isn&#39;t worth knowing the difference for developers either und=
er this view.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
[...]<br>
<br>
&gt;&gt; &gt;&gt; The new doc doesn&#39;t show non-definition conditionals,=
 as mentioned in<br>
&gt;&gt; &gt;&gt; the cover letter.=C2=A0 It shows definition conditionals =
twice.=C2=A0 Once should<br>
&gt;&gt; &gt;&gt; suffice.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Known/intentional issue. I couldn&#39;t decide where I wanted=
 it, so I put it<br>
&gt;&gt; &gt; in both places. If you have a strong opinion right now, pleas=
e let me know<br>
&gt;&gt; &gt; what it is and I&#39;ll take care of it, it&#39;s easy - but =
it&#39;s code in the<br>
&gt;&gt; &gt; predecessor series and nothing to do with qapidoc, so please =
put it out of<br>
&gt;&gt; &gt; mind for now.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If you don&#39;t have strong feelings, or you feel that the a=
nswer may depend<br>
&gt;&gt; &gt; on how we solve other glaring issues (non-definition conditio=
nals), let&#39;s<br>
&gt;&gt; &gt; wait a little bit before making a decision.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Added to tasklist: &quot;Remove the duplication of definition=
 conditionals&quot;;<br>
&gt;&gt; &gt; left unspecified is how or in what direction :)<br>
&gt;&gt;<br>
&gt;&gt; ACK<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll try to make up my mind :)<br>
&gt;&gt;<br>
&gt;<br>
&gt; I should also point out, this is an issue in the domain and not the<br=
>
&gt; generator; the generated rst document doesn&#39;t have this duplicatio=
n. So<br>
&gt; it&#39;s kind of a no-op while we look and consider this specific seri=
es, but<br>
&gt; it&#39;s still on my list when we go to look at the predecessor series=
.<br>
<br>
Understood.<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--00000000000044b778062eaae07a--


