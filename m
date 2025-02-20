Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C019C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 20:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlDDm-0005uD-1F; Thu, 20 Feb 2025 15:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tlDDk-0005u4-6m
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tlDDh-0004RP-0i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740083546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vKcM+4NvCkK6STHAx91r4oubhTtuaRUlMV1lB4DySKk=;
 b=cy4fLg24kPFhGlXzcwLTEHUpNucBsbKQWnTKLaVNj4TpyfFtGrqRFYquVWJ2y6L0mFmy/Y
 Zl0V/AZH1ApEGfFquaiaSTyrZ9GwkfcxSVGl9mhlE9xD1unW41YduLYfkioo9d912+neKz
 axAPA0Pjyp4OzVyoSVF5jeZUk3NWV2Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-3TzEcqUyPYWd1QHXnmvHaw-1; Thu, 20 Feb 2025 15:32:25 -0500
X-MC-Unique: 3TzEcqUyPYWd1QHXnmvHaw-1
X-Mimecast-MFC-AGG-ID: 3TzEcqUyPYWd1QHXnmvHaw_1740083544
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc2f22f959so4932573a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 12:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740083544; x=1740688344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKcM+4NvCkK6STHAx91r4oubhTtuaRUlMV1lB4DySKk=;
 b=R/0Qqda+M1tr3NrnndG16BWIElOiGzs9lcUjJD1ESHzOnn4naVpr0gA7nJp3Xd1IGh
 48RrMfQJsSUb6H9xK+XtsneXSRJ95AvOQTmuE9FOfpF4Xieisu++GPXNI/A686mlXTxg
 19ZjgV5rKYCFPn4GWRYlct9uDXuy1NZCWpW9dvjr1Kk0uPSLTuR+x3ubCM8ykGZN5McB
 D7vi9k/y2ec61p+Fn72nHNYqBUOZJXOsdrpms5Cut04n6A2RHXPG8aszS/ciUT1MnaTf
 L6U3xmlvxzjhXTNSH+lYZEk73++ZqMs/RkMunYLfyiPry773fdiarHsVS1eH5w56n5Ip
 CXAw==
X-Gm-Message-State: AOJu0Yy9Q+O25X6yX06Qqj4Ms4p0eLFBAJyFTwb7XDxB97JaMtciekrq
 H/bMGgCrLAfv0vCDZiO0a6Rv+vmiEoOpe0WBxlHy6864QH/S4KQwyXvkcEAtDnuvR4dh9hMt4mR
 E8af5VJJd5jF2dBiZJ2i0TgAYALK2Ln+Iwfz+D+GBVC1idr9JF/KPI4y3NommDepiXzVefapAUL
 cFC/YgF5ucbqeRdFD/Dxm2NUlNTd0=
X-Gm-Gg: ASbGncuyPhl5BJFkJZ6v/EiYBz2XMc8oaC4zrdbhlQRnHyomSE7JM/sGScJVmCVKdQX
 ciyQKhpBY8OIIgxpE7vEMQER3Qq/yQ8Xwmcs6Kez7qfXtYM2SvMD709s/+0pfORc5TJ0lmkjKhj
 qeMRl6/gkifxrVNSUmYA==
X-Received: by 2002:a17:90b:2e44:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-2fccc13898emr7449879a91.9.1740083544047; 
 Thu, 20 Feb 2025 12:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhoryST7+zU7JWvX1C6BgMn+ZX/gmFyCpmy9xbN8IazhfavxR+va737bfhzPw/JoNPfSK7onw46MX38woV4Eo=
X-Received: by 2002:a17:90b:2e44:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-2fccc13898emr7449827a91.9.1740083543647; Thu, 20 Feb 2025
 12:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <87wmds4tpk.fsf@pond.sub.org>
 <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
 <874j0q2hof.fsf@pond.sub.org>
In-Reply-To: <874j0q2hof.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Feb 2025 15:32:10 -0500
X-Gm-Features: AWEUYZlss9HbiIa0xAedalReHsKpHsDQsP8wUitl3GTEQEuzuAJLUCkZ0KgPxg4
Message-ID: <CAFn=p-aXKtaiq8LAgTCDRNHU78yv8mBfsbuCkP8Smp=TWDn6jw@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000007fc14c062e98c5ca"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--0000000000007fc14c062e98c5ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > "The text handler you add looks just like the existing latex handler.
> Does
> > LaTeX output lack "little headings", too?"
> >
> > Yes, almost certainly. Can you let me know which output formats we
> actually
> > "care about"? I'll have to test them all.
>
> As far as I can tell, our build system runs sphinx-build -b html and -b
> man.
>
> I run it with -b text manually all the time to hunt for and review
> changes in output.  I'd prefer to keep it working if practical.
>
> For what it's worth, there is a bit of LaTeX configuration in
> docs/conf.py.
>
> >                                           In the meantime, I upgraded m=
y
> > patch so that the text translator properly handles branches with headin=
gs
> > that delineate the different branches so that the text output is fully
> > reasonable. I will need to do the same for any format we care about.
> >
> > I've re-pushed as of "about 30 minutes before I wrote this email" --
> > https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2
> >
> > This branch includes the text generator fixes (which technically belong
> > with the predecessor series we skipped, but I'll refactor that later.)
> > it also includes fixes to the branch inliner, generated return
> statements,
> > and generated out-of-band feature sections.
>
> I'll fetch it, thanks!
>
> > (Long story short: inserting new sections in certain spots was broken
> > because of cache. Oops. We can discuss more why I wrote that part of th=
e
> > code like I did in review for the patch that introduced that problem.
> It's
> > the "basic inliner" patch.)
> >
> > Below, I'm going to try a new communication approach where I explicitly
> say
> > if I have added something to my tasklist or not so that it's clear to y=
ou
> > what I believe is actionable (and what I am agreeing to change) and wha=
t
> I
> > believe needs stronger input from you before I do anything. Apologies i=
f
> it
> > seems a little robotic, just trying new things O:-)
> >
> > On that note: not added to tasklist: do we need the LaTeX handler? Do w=
e
> > need any others? Please confirm O:-)
>
> See above.
>

I've got html and text working, text wasn't hard. I will give it a good
college try on the LaTeX and man formats. Might be easy. The issue here is
the custom node I introduced for the collapsible details sections which has
no default handler in the generators. I'll have to learn more about that
part of the API, I haven't interfaced with it much yet.


>
> > On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> I started to eyeball old and new generated output side by side.
> >>
> >> New table of contents shows one level, old two.  No objection; the
> >> navigation thingie on the left is more useful anyway.
> >>
> >
> > Unintentional, but if you like it, it's fine by me. Nothing added to my
> > tasklist.
>
> Mention in a commit message.
>

Sure. I... just need to figure out which commit to mention it in. Added to
my list, anyway.


>
> >> The new generator elides unreferenced types.  Generally good, but two
> >> observations:
> >>
> >> * QapiErrorClass is unreferenced, but its members are mentioned in
> >>   Errors sections.  QapiErrorClass serves as better than nothing error
> >>   code documentation, but it's gone in the new doc.  So this is a mino=
r
> >>   regression.  We can figure out what to do about it later.
> >>
> >
> > Right. I debated making the members references to that class, but
> recalled
> > that you disliked this class and figured you'd not like such a change,
> so I
> > just left it alone. I do not have cross-references for individual membe=
rs
> > of objects at all yet anyway, so this is definitely more work regardles=
s.
> >
> > We could always create a pragma of some sort (or just hardcode a list) =
of
> > items that must be documented regardless of if they're referenced or no=
t.
> > Please let me know your preference and I will add a "ticket" on my
> personal
> > tasklist for this project to handle that at /some point/. Nothing added
> to
> > my tasklist just yet.
>
> Suggest to add something like "compensate for the loss of QapiErrorClass
> documentation in the QEMU QMP Reference Manual".
>

Got it. Possibly a "for later" task but not much later. It can always come
after this first series, but before we "turn on" the new generator, if that
makes sense. Just so we reach a quiescent point and flush the staggeringly
large queue.

I guess what I mean is: "Let's make sure what I've got here so far is good
first, and then I'll start adding stuff."


>
> >> * Section "QMP errors" is empty in the new doc, because its entire
> >>   contents is elided.  I guess we should elide the section as well, bu=
t
> >>   it's fine to leave that for later.
> >>
> >
> > Adding to tasklist to elide empty modules, but "for later".
>
> ACK
>
> >> Old doc shows a definition's since information like any other section.
> >> New doc has it in the heading box.  Looks prettier and uses much less
> >> space.  Not sure the heading box is the best place, but it'll do for
> >> now, we can always move it around later.
> >>
> >
> > Agree, it's a strict improvement - there may be further improvements, b=
ut
> > that is always true anyway. When we tackle "autogenerated since
> > information" we can tackle the since display issues more meticulously. =
Or
> > maybe we'll need do sooner because of conflicting info in branches or
> > whatever else. I dunno, I'll burn that bridge when I get to it. Nothing
> > added to tasklist.
>
> ACK
>
> >> The new doc's headings use "Struct" or "Union" where the old one uses
> >> just "Object".  Let's keep "Object", please.
> >>
> >
> > I was afraid you'd ask for this. OK, I think it's an easy change. Can I
> > keep the index page segmented by object type still, though?
> >
> > I do find knowing the *type* of object to be helpful as a developer,
>
> Can you explain why and how struct vs. union matters to you as a
> developer?
>

I suppose it's just internal details that I like to know, but tend to find
the HTML reference easier to work with than grepping through the qapi
files. I'm gonna change it for you anyway because I agree it's not
consistent with the philosophy of "end user QMP reference". Just feels like
a tiny shame somehow.


>
> >
> though
> > I understand that from the point of view of a QMP user, they're all jus=
t
> > objects, so your request makes sense.
>
> I'd prefer a single index.
>

So ... structs, unions, alternates all condensed down to "Object", is that
right? We get to keep command/enum/event separate, I assume.


>
> > Replace JSON object type headers with "Object" instead of QAPI data typ=
es
> > added to tasklist.
>
> ACK
>
> >> In the new doc, some member references are no longer rendered as such,
> >> e.g. @on-source-error and @on-target-error in BackupCommon's note.
> >> Another small regression.
> >>
> >
> > Ah, I actually knew this one. I didn't implement special formatting for
> > these yet. I do not have cross-references for individual members, so
> > there's nothing to transform these *into* yet. If you'd like special
> > rendering for them (fixed width, no link?) that's easy to accomplish. I
> am
> > not yet sure where I will do that conversion.
>
> Suggest the render them the same as before.
>
> Have a look at BackupCommon's "Note" box in the old docs: the member
> names appear to use a fixed-width font.
>
> Peeking at old qapidoc.py...  it seems to rewrite @foo to ``foo``.
>

OK.


>
> > Reminder/Note that in my KVM Forum branch, I did actually replace all
> > @references that pointed to something actually cross-referenceable with
> an
> > actual sphinx cross-reference, leaving only @member references behind.
> >
> > Nothing added to tasklist just yet.
> >
> >
> >>
> >> Union branches are busted in the new generator's output.  I know they
> >> used to work, so I'm not worried about it.
> >>
> >
> > Fixed in new push, sorry! An embarrassing mistake that took me aeons to
> > spot.
> >
> >
> >>
> >> The new doc shows the return type, the old doc doesn't.  Showing it is
> >> definitely an improvement, but we need to adjust the doc text to avoid
> >> silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".
> >>
> >
> > My KVM Forum branch actually corrected the QAPI documentation to remove
> > pointless returns. I didn't include that with this series yet, it was
> long
> > enough. This issue will be addressed solely through source documentatio=
n
> > edits, of which I believe I already have a comprehensive patch for.
> >
> > Added to my tasklist: "Submit source documentation patches to remove
> > pointless return documentation"
>
> ACK
>
> > It was my intent to submit those patches *afterwards*, but we can alway=
s
> do
> > it before if you'd like. Let me know. (I don't know offhand how easy th=
ey
> > are to extricate from my KVM Forum branch. I reserve the right to chang=
e
> my
> > mind on being flexible depending on the answer there :p)
>
> No need to decide or extricate right now.  Tasklist is good enough for
> me.
>
> >> The new doc shows Arguments / Members, Returns, and Errors in two-colu=
mn
> >> format.  Looks nice.  But for some reason, the two columns don't align
> >> horizontally for Errors like they do for the others.  Certainly not a
> >> blocker of anything, but we should try to fix it at some point.
> >>
> >
> > Known issue. The reason is because we do not mandate a source
> documentation
> > format for errors - by convention, it is a list. There is (or was?) one
> > occurrence where it wasn't a list and I wrote a patch to change that. I
> > don't recall right now if we merged that or not. The misalignment is a
> > result of nesting a list inside of a list.
>
> Commit b32a6b62a82 (qapi: nail down convention that Errors sections are
> lists)
>
> > If we *mandate* the source format, I gain the ability to "peel off the
> > nesting", which will fix the alignment.
>
> "Mandate" means changing "should be formatted as an rST list" into "must
> be", plus enforcement.  Works for me.
>
> > Added to tasklist: "Address vertical misalignment in Errors formatting"
>
> ACK, low priority.
>
> > Not added: how? need more input from you, please.
> >
> >
> >>
> >> The new doc doesn't show non-definition conditionals, as mentioned in
> >> the cover letter.  It shows definition conditionals twice.  Once shoul=
d
> >> suffice.
> >>
> >
> > Known/intentional issue. I couldn't decide where I wanted it, so I put =
it
> > in both places. If you have a strong opinion right now, please let me
> know
> > what it is and I'll take care of it, it's easy - but it's code in the
> > predecessor series and nothing to do with qapidoc, so please put it out
> of
> > mind for now.
> >
> > If you don't have strong feelings, or you feel that the answer may depe=
nd
> > on how we solve other glaring issues (non-definition conditionals), let=
's
> > wait a little bit before making a decision.
> >
> > Added to tasklist: "Remove the duplication of definition conditionals";
> > left unspecified is how or in what direction :)
>
> ACK
>
> I'll try to make up my mind :)
>

I should also point out, this is an issue in the domain and not the
generator; the generated rst document doesn't have this duplication. So
it's kind of a no-op while we look and consider this specific series, but
it's still on my list when we go to look at the predecessor series.


>
> >> There's probably more, but this is it for now.
> >>
> >>
> >
> > Tasklist:
> >
> >  For the qapi-domain (prequel!) series:
> >   - Remove the duplication of definition conditionals
> >
> > For this (qapidoc) series:
> >   - Display all JSON object types as "Object" and not as their QAPI dat=
a
> > type.
> >
> > For later:
> >   - Elide empty modules
> >   - Submit source documentation patches to remove pointless return
> > documentation
> >   - Address vertical misalignment in Errors formatting
>
>

--0000000000007fc14c062e98c5ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 19, 2025=
 at 8:22=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsno=
w@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; &quot;The text handler you add looks just like the existing latex hand=
ler. Does<br>
&gt; LaTeX output lack &quot;little headings&quot;, too?&quot;<br>
&gt;<br>
&gt; Yes, almost certainly. Can you let me know which output formats we act=
ually<br>
&gt; &quot;care about&quot;? I&#39;ll have to test them all.<br>
<br>
As far as I can tell, our build system runs sphinx-build -b html and -b<br>
man.<br>
<br>
I run it with -b text manually all the time to hunt for and review<br>
changes in output.=C2=A0 I&#39;d prefer to keep it working if practical.<br=
>
<br>
For what it&#39;s worth, there is a bit of LaTeX configuration in<br>
docs/conf.py.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0In the meantime, I upgraded my<br>
&gt; patch so that the text translator properly handles branches with headi=
ngs<br>
&gt; that delineate the different branches so that the text output is fully=
<br>
&gt; reasonable. I will need to do the same for any format we care about.<b=
r>
&gt;<br>
&gt; I&#39;ve re-pushed as of &quot;about 30 minutes before I wrote this em=
ail&quot; --<br>
&gt; <a href=3D"https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blerg=
h2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu/-/co=
mmits/sphinx-domain-blergh2</a><br>
&gt;<br>
&gt; This branch includes the text generator fixes (which technically belon=
g<br>
&gt; with the predecessor series we skipped, but I&#39;ll refactor that lat=
er.)<br>
&gt; it also includes fixes to the branch inliner, generated return stateme=
nts,<br>
&gt; and generated out-of-band feature sections.<br>
<br>
I&#39;ll fetch it, thanks!<br>
<br>
&gt; (Long story short: inserting new sections in certain spots was broken<=
br>
&gt; because of cache. Oops. We can discuss more why I wrote that part of t=
he<br>
&gt; code like I did in review for the patch that introduced that problem. =
It&#39;s<br>
&gt; the &quot;basic inliner&quot; patch.)<br>
&gt;<br>
&gt; Below, I&#39;m going to try a new communication approach where I expli=
citly say<br>
&gt; if I have added something to my tasklist or not so that it&#39;s clear=
 to you<br>
&gt; what I believe is actionable (and what I am agreeing to change) and wh=
at I<br>
&gt; believe needs stronger input from you before I do anything. Apologies =
if it<br>
&gt; seems a little robotic, just trying new things O:-)<br>
&gt;<br>
&gt; On that note: not added to tasklist: do we need the LaTeX handler? Do =
we<br>
&gt; need any others? Please confirm O:-)<br>
<br>
See above.<br></blockquote><div><br></div><div>I&#39;ve got html and text w=
orking, text wasn&#39;t hard. I will give it a good college try on the LaTe=
X and man formats. Might be easy. The issue here is the custom node I intro=
duced for the collapsible details sections which has no default handler in =
the generators. I&#39;ll have to learn more about that part of the API, I h=
aven&#39;t interfaced with it much yet.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; I started to eyeball old and new generated output side by side.<br=
>
&gt;&gt;<br>
&gt;&gt; New table of contents shows one level, old two.=C2=A0 No objection=
; the<br>
&gt;&gt; navigation thingie on the left is more useful anyway.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Unintentional, but if you like it, it&#39;s fine by me. Nothing added =
to my<br>
&gt; tasklist.<br>
<br>
Mention in a commit message.<br></blockquote><div><br></div><div>Sure. I...=
 just need to figure out which commit to mention it in. Added to my list, a=
nyway.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt;&gt; The new generator elides unreferenced types.=C2=A0 Generally good,=
 but two<br>
&gt;&gt; observations:<br>
&gt;&gt;<br>
&gt;&gt; * QapiErrorClass is unreferenced, but its members are mentioned in=
<br>
&gt;&gt;=C2=A0 =C2=A0Errors sections.=C2=A0 QapiErrorClass serves as better=
 than nothing error<br>
&gt;&gt;=C2=A0 =C2=A0code documentation, but it&#39;s gone in the new doc.=
=C2=A0 So this is a minor<br>
&gt;&gt;=C2=A0 =C2=A0regression.=C2=A0 We can figure out what to do about i=
t later.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Right. I debated making the members references to that class, but reca=
lled<br>
&gt; that you disliked this class and figured you&#39;d not like such a cha=
nge, so I<br>
&gt; just left it alone. I do not have cross-references for individual memb=
ers<br>
&gt; of objects at all yet anyway, so this is definitely more work regardle=
ss.<br>
&gt;<br>
&gt; We could always create a pragma of some sort (or just hardcode a list)=
 of<br>
&gt; items that must be documented regardless of if they&#39;re referenced =
or not.<br>
&gt; Please let me know your preference and I will add a &quot;ticket&quot;=
 on my personal<br>
&gt; tasklist for this project to handle that at /some point/. Nothing adde=
d to<br>
&gt; my tasklist just yet.<br>
<br>
Suggest to add something like &quot;compensate for the loss of QapiErrorCla=
ss<br>
documentation in the QEMU QMP Reference Manual&quot;.<br></blockquote><div>=
<br></div><div>Got it. Possibly a &quot;for later&quot; task but not much l=
ater. It can always come after this first series, but before we &quot;turn =
on&quot; the new generator, if that makes sense. Just so we reach a quiesce=
nt point and flush the staggeringly large queue.</div><div><br></div><div>I=
 guess what I mean is: &quot;Let&#39;s make sure what I&#39;ve got here so =
far is good first, and then I&#39;ll start adding stuff.&quot;</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; * Section &quot;QMP errors&quot; is empty in the new doc, because =
its entire<br>
&gt;&gt;=C2=A0 =C2=A0contents is elided.=C2=A0 I guess we should elide the =
section as well, but<br>
&gt;&gt;=C2=A0 =C2=A0it&#39;s fine to leave that for later.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Adding to tasklist to elide empty modules, but &quot;for later&quot;.<=
br>
<br>
ACK<br>
<br>
&gt;&gt; Old doc shows a definition&#39;s since information like any other =
section.<br>
&gt;&gt; New doc has it in the heading box.=C2=A0 Looks prettier and uses m=
uch less<br>
&gt;&gt; space.=C2=A0 Not sure the heading box is the best place, but it&#3=
9;ll do for<br>
&gt;&gt; now, we can always move it around later.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Agree, it&#39;s a strict improvement - there may be further improvemen=
ts, but<br>
&gt; that is always true anyway. When we tackle &quot;autogenerated since<b=
r>
&gt; information&quot; we can tackle the since display issues more meticulo=
usly. Or<br>
&gt; maybe we&#39;ll need do sooner because of conflicting info in branches=
 or<br>
&gt; whatever else. I dunno, I&#39;ll burn that bridge when I get to it. No=
thing<br>
&gt; added to tasklist.<br>
<br>
ACK<br>
<br>
&gt;&gt; The new doc&#39;s headings use &quot;Struct&quot; or &quot;Union&q=
uot; where the old one uses<br>
&gt;&gt; just &quot;Object&quot;.=C2=A0 Let&#39;s keep &quot;Object&quot;, =
please.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I was afraid you&#39;d ask for this. OK, I think it&#39;s an easy chan=
ge. Can I<br>
&gt; keep the index page segmented by object type still, though?<br>
&gt;<br>
&gt; I do find knowing the *type* of object to be helpful as a developer,<b=
r>
<br>
Can you explain why and how struct vs. union matters to you as a<br>
developer?<br></blockquote><div><br></div><div>I suppose it&#39;s just inte=
rnal details that I like to know, but tend to find the HTML reference easie=
r to work with than grepping through the qapi files. I&#39;m gonna change i=
t for you anyway because I agree it&#39;s not consistent with the philosoph=
y of &quot;end user QMP reference&quot;. Just feels like a tiny shame someh=
ow.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 though<br>
&gt; I understand that from the point of view of a QMP user, they&#39;re al=
l just<br>
&gt; objects, so your request makes sense.<br>
<br>
I&#39;d prefer a single index.<br></blockquote><div><br></div>So ... struct=
s, unions, alternates all condensed down to &quot;Object&quot;, is that rig=
ht? We get to keep command/enum/event separate, I assume.<div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Replace JSON object type headers with &quot;Object&quot; instead of QA=
PI data types<br>
&gt; added to tasklist.<br>
<br>
ACK<br>
<br>
&gt;&gt; In the new doc, some member references are no longer rendered as s=
uch,<br>
&gt;&gt; e.g. @on-source-error and @on-target-error in BackupCommon&#39;s n=
ote.<br>
&gt;&gt; Another small regression.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Ah, I actually knew this one. I didn&#39;t implement special formattin=
g for<br>
&gt; these yet. I do not have cross-references for individual members, so<b=
r>
&gt; there&#39;s nothing to transform these *into* yet. If you&#39;d like s=
pecial<br>
&gt; rendering for them (fixed width, no link?) that&#39;s easy to accompli=
sh. I am<br>
&gt; not yet sure where I will do that conversion.<br>
<br>
Suggest the render them the same as before.<br>
<br>
Have a look at BackupCommon&#39;s &quot;Note&quot; box in the old docs: the=
 member<br>
names appear to use a fixed-width font.<br>
<br>
Peeking at old qapidoc.py...=C2=A0 it seems to rewrite @foo to ``foo``.<br>=
</blockquote><div><br></div><div>OK.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; Reminder/Note that in my KVM Forum branch, I did actually replace all<=
br>
&gt; @references that pointed to something actually cross-referenceable wit=
h an<br>
&gt; actual sphinx cross-reference, leaving only @member references behind.=
<br>
&gt;<br>
&gt; Nothing added to tasklist just yet.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Union branches are busted in the new generator&#39;s output.=C2=A0=
 I know they<br>
&gt;&gt; used to work, so I&#39;m not worried about it.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Fixed in new push, sorry! An embarrassing mistake that took me aeons t=
o<br>
&gt; spot.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; The new doc shows the return type, the old doc doesn&#39;t.=C2=A0 =
Showing it is<br>
&gt;&gt; definitely an improvement, but we need to adjust the doc text to a=
void<br>
&gt;&gt; silliness like &quot;Returns: SnapshotInfo =E2=80=93 SnapshotInfo&=
quot;.<br>
&gt;&gt;<br>
&gt;<br>
&gt; My KVM Forum branch actually corrected the QAPI documentation to remov=
e<br>
&gt; pointless returns. I didn&#39;t include that with this series yet, it =
was long<br>
&gt; enough. This issue will be addressed solely through source documentati=
on<br>
&gt; edits, of which I believe I already have a comprehensive patch for.<br=
>
&gt;<br>
&gt; Added to my tasklist: &quot;Submit source documentation patches to rem=
ove<br>
&gt; pointless return documentation&quot;<br>
<br>
ACK<br>
<br>
&gt; It was my intent to submit those patches *afterwards*, but we can alwa=
ys do<br>
&gt; it before if you&#39;d like. Let me know. (I don&#39;t know offhand ho=
w easy they<br>
&gt; are to extricate from my KVM Forum branch. I reserve the right to chan=
ge my<br>
&gt; mind on being flexible depending on the answer there :p)<br>
<br>
No need to decide or extricate right now.=C2=A0 Tasklist is good enough for=
<br>
me.<br>
<br>
&gt;&gt; The new doc shows Arguments / Members, Returns, and Errors in two-=
column<br>
&gt;&gt; format.=C2=A0 Looks nice.=C2=A0 But for some reason, the two colum=
ns don&#39;t align<br>
&gt;&gt; horizontally for Errors like they do for the others.=C2=A0 Certain=
ly not a<br>
&gt;&gt; blocker of anything, but we should try to fix it at some point.<br=
>
&gt;&gt;<br>
&gt;<br>
&gt; Known issue. The reason is because we do not mandate a source document=
ation<br>
&gt; format for errors - by convention, it is a list. There is (or was?) on=
e<br>
&gt; occurrence where it wasn&#39;t a list and I wrote a patch to change th=
at. I<br>
&gt; don&#39;t recall right now if we merged that or not. The misalignment =
is a<br>
&gt; result of nesting a list inside of a list.<br>
<br>
Commit b32a6b62a82 (qapi: nail down convention that Errors sections are<br>
lists)<br>
<br>
&gt; If we *mandate* the source format, I gain the ability to &quot;peel of=
f the<br>
&gt; nesting&quot;, which will fix the alignment.<br>
<br>
&quot;Mandate&quot; means changing &quot;should be formatted as an rST list=
&quot; into &quot;must<br>
be&quot;, plus enforcement.=C2=A0 Works for me.<br>
<br>
&gt; Added to tasklist: &quot;Address vertical misalignment in Errors forma=
tting&quot;<br>
<br>
ACK, low priority.<br>
<br>
&gt; Not added: how? need more input from you, please.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; The new doc doesn&#39;t show non-definition conditionals, as menti=
oned in<br>
&gt;&gt; the cover letter.=C2=A0 It shows definition conditionals twice.=C2=
=A0 Once should<br>
&gt;&gt; suffice.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Known/intentional issue. I couldn&#39;t decide where I wanted it, so I=
 put it<br>
&gt; in both places. If you have a strong opinion right now, please let me =
know<br>
&gt; what it is and I&#39;ll take care of it, it&#39;s easy - but it&#39;s =
code in the<br>
&gt; predecessor series and nothing to do with qapidoc, so please put it ou=
t of<br>
&gt; mind for now.<br>
&gt;<br>
&gt; If you don&#39;t have strong feelings, or you feel that the answer may=
 depend<br>
&gt; on how we solve other glaring issues (non-definition conditionals), le=
t&#39;s<br>
&gt; wait a little bit before making a decision.<br>
&gt;<br>
&gt; Added to tasklist: &quot;Remove the duplication of definition conditio=
nals&quot;;<br>
&gt; left unspecified is how or in what direction :)<br>
<br>
ACK<br>
<br>
I&#39;ll try to make up my mind :)<br></blockquote><div><br></div><div>I sh=
ould also point out, this is an issue in the domain and not the generator; =
the generated rst document doesn&#39;t have this duplication. So it&#39;s k=
ind of a no-op while we look and consider this specific series, but it&#39;=
s still on my list when we go to look at the predecessor series.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; There&#39;s probably more, but this is it for now.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Tasklist:<br>
&gt;<br>
&gt;=C2=A0 For the qapi-domain (prequel!) series:<br>
&gt;=C2=A0 =C2=A0- Remove the duplication of definition conditionals<br>
&gt;<br>
&gt; For this (qapidoc) series:<br>
&gt;=C2=A0 =C2=A0- Display all JSON object types as &quot;Object&quot; and =
not as their QAPI data<br>
&gt; type.<br>
&gt;<br>
&gt; For later:<br>
&gt;=C2=A0 =C2=A0- Elide empty modules<br>
&gt;=C2=A0 =C2=A0- Submit source documentation patches to remove pointless =
return<br>
&gt; documentation<br>
&gt;=C2=A0 =C2=A0- Address vertical misalignment in Errors formatting<br>
<br>
</blockquote></div></div>
</div>

--0000000000007fc14c062e98c5ca--


