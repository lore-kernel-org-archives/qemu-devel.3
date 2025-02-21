Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE17C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMjo-0000Ey-2y; Fri, 21 Feb 2025 01:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tlMjm-0000ES-R0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tlMjk-0004bA-C6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740120128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5xrOKTk/iOIzT5yHTkP6mDWeIJ2wo1OMbmZiYJPfGs=;
 b=QS3SFmfI/uHAy1DGwbwQSKCFkN5Iu/3kdE2PZcI/dTjugTK7IH2uJcZbfCA1A6IXR81vD3
 BcvlHPa8N2p+LAMA4EjNC/Ew4S87erpJmfqM7GrIcYD5r18smC4lOCgyVwY3GF1TC6Ylnv
 UF0Sp0MIPLu0cXTBrpkkkm8FNfXQqU4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-R5_ihLPBPzykIQ-bOLWlEQ-1; Fri,
 21 Feb 2025 01:42:05 -0500
X-MC-Unique: R5_ihLPBPzykIQ-bOLWlEQ-1
X-Mimecast-MFC-AGG-ID: R5_ihLPBPzykIQ-bOLWlEQ_1740120123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C35A19373DC; Fri, 21 Feb 2025 06:42:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 987951955BCB; Fri, 21 Feb 2025 06:42:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF96D21E6A28; Fri, 21 Feb 2025 07:41:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
In-Reply-To: <CAFn=p-aXKtaiq8LAgTCDRNHU78yv8mBfsbuCkP8Smp=TWDn6jw@mail.gmail.com>
 (John Snow's message of "Thu, 20 Feb 2025 15:32:10 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <87wmds4tpk.fsf@pond.sub.org>
 <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
 <874j0q2hof.fsf@pond.sub.org>
 <CAFn=p-aXKtaiq8LAgTCDRNHU78yv8mBfsbuCkP8Smp=TWDn6jw@mail.gmail.com>
Date: Fri, 21 Feb 2025 07:41:57 +0100
Message-ID: <87o6yvn6iy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Feb 19, 2025 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > "The text handler you add looks just like the existing latex handler. =
Does
>> > LaTeX output lack "little headings", too?"
>> >
>> > Yes, almost certainly. Can you let me know which output formats we act=
ually
>> > "care about"? I'll have to test them all.
>>
>> As far as I can tell, our build system runs sphinx-build -b html and -b
>> man.
>>
>> I run it with -b text manually all the time to hunt for and review
>> changes in output.  I'd prefer to keep it working if practical.
>>
>> For what it's worth, there is a bit of LaTeX configuration in
>> docs/conf.py.
>>
>> >                                           In the meantime, I upgraded =
my
>> > patch so that the text translator properly handles branches with headi=
ngs
>> > that delineate the different branches so that the text output is fully
>> > reasonable. I will need to do the same for any format we care about.
>> >
>> > I've re-pushed as of "about 30 minutes before I wrote this email" --
>> > https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2
>> >
>> > This branch includes the text generator fixes (which technically belong
>> > with the predecessor series we skipped, but I'll refactor that later.)
>> > it also includes fixes to the branch inliner, generated return stateme=
nts,
>> > and generated out-of-band feature sections.
>>
>> I'll fetch it, thanks!
>>
>> > (Long story short: inserting new sections in certain spots was broken
>> > because of cache. Oops. We can discuss more why I wrote that part of t=
he
>> > code like I did in review for the patch that introduced that problem. =
It's
>> > the "basic inliner" patch.)
>> >
>> > Below, I'm going to try a new communication approach where I explicitl=
y say
>> > if I have added something to my tasklist or not so that it's clear to =
you
>> > what I believe is actionable (and what I am agreeing to change) and wh=
at I
>> > believe needs stronger input from you before I do anything. Apologies =
if it
>> > seems a little robotic, just trying new things O:-)
>> >
>> > On that note: not added to tasklist: do we need the LaTeX handler? Do =
we
>> > need any others? Please confirm O:-)
>>
>> See above.
>>
>
> I've got html and text working, text wasn't hard. I will give it a good
> college try on the LaTeX and man formats. Might be easy. The issue here is
> the custom node I introduced for the collapsible details sections which h=
as
> no default handler in the generators. I'll have to learn more about that
> part of the API, I haven't interfaced with it much yet.

Understand.

Have you considered cutting the series in half before the inliner?
First part emits "The members of ..." like the old doc generator.
Second part replaces that with inlined material.

We could totally release with just the first half!  Inlining is great,
but even without it, your work looks so much better and is so much more
usable.

>> > On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >
>> >> I started to eyeball old and new generated output side by side.
>> >>
>> >> New table of contents shows one level, old two.  No objection; the
>> >> navigation thingie on the left is more useful anyway.
>> >>
>> >
>> > Unintentional, but if you like it, it's fine by me. Nothing added to my
>> > tasklist.
>>
>> Mention in a commit message.
>>
>
> Sure. I... just need to figure out which commit to mention it in. Added to
> my list, anyway.
>
>
>>
>> >> The new generator elides unreferenced types.  Generally good, but two
>> >> observations:
>> >>
>> >> * QapiErrorClass is unreferenced, but its members are mentioned in
>> >>   Errors sections.  QapiErrorClass serves as better than nothing error
>> >>   code documentation, but it's gone in the new doc.  So this is a min=
or
>> >>   regression.  We can figure out what to do about it later.
>> >>
>> >
>> > Right. I debated making the members references to that class, but reca=
lled
>> > that you disliked this class and figured you'd not like such a change,=
 so I
>> > just left it alone. I do not have cross-references for individual memb=
ers
>> > of objects at all yet anyway, so this is definitely more work regardle=
ss.
>> >
>> > We could always create a pragma of some sort (or just hardcode a list)=
 of
>> > items that must be documented regardless of if they're referenced or n=
ot.
>> > Please let me know your preference and I will add a "ticket" on my per=
sonal
>> > tasklist for this project to handle that at /some point/. Nothing adde=
d to
>> > my tasklist just yet.
>>
>> Suggest to add something like "compensate for the loss of QapiErrorClass
>> documentation in the QEMU QMP Reference Manual".
>>
>
> Got it. Possibly a "for later" task but not much later. It can always come
> after this first series, but before we "turn on" the new generator, if th=
at
> makes sense. Just so we reach a quiescent point and flush the staggeringly
> large queue.

I think we could even do it after "turn on".  Yes, it's a small
regression, but I believe the improvements are big enough to outweigh
small regressions like this one.

> I guess what I mean is: "Let's make sure what I've got here so far is good
> first, and then I'll start adding stuff."

[...]

>> >> The new doc's headings use "Struct" or "Union" where the old one uses
>> >> just "Object".  Let's keep "Object", please.
>> >>
>> >
>> > I was afraid you'd ask for this. OK, I think it's an easy change. Can I
>> > keep the index page segmented by object type still, though?
>> >
>> > I do find knowing the *type* of object to be helpful as a developer,
>>
>> Can you explain why and how struct vs. union matters to you as a
>> developer?
>>
>
> I suppose it's just internal details that I like to know, but tend to find
> the HTML reference easier to work with than grepping through the qapi
> files. I'm gonna change it for you anyway because I agree it's not
> consistent with the philosophy of "end user QMP reference". Just feels li=
ke
> a tiny shame somehow.
>
>
>>
>> > though
>> > I understand that from the point of view of a QMP user, they're all ju=
st
>> > objects, so your request makes sense.
>>
>> I'd prefer a single index.
>>
>
> So ... structs, unions, alternates all condensed down to "Object", is that
> right? We get to keep command/enum/event separate, I assume.

No, only structs and unions are "Object", alternates are "Alternate".

For me, the separation between struct and union is an unfortunate
remnant of somewhat winding development history.

A union is has common members, one of them is the tag, and for each tag
value, it may have variant members.

A struct is a degenerate union: no variants.

This is as old as the hills: Pascal records are just like this.

QMP introspection doesn't show structs and unions, just objects, which
may or may not have variants.

The schema language syntax, however, is still rooted (stuck?) in a past
when unions could not have common members other than the tag.

[...]

>> >> The new doc doesn't show non-definition conditionals, as mentioned in
>> >> the cover letter.  It shows definition conditionals twice.  Once shou=
ld
>> >> suffice.
>> >>
>> >
>> > Known/intentional issue. I couldn't decide where I wanted it, so I put=
 it
>> > in both places. If you have a strong opinion right now, please let me =
know
>> > what it is and I'll take care of it, it's easy - but it's code in the
>> > predecessor series and nothing to do with qapidoc, so please put it ou=
t of
>> > mind for now.
>> >
>> > If you don't have strong feelings, or you feel that the answer may dep=
end
>> > on how we solve other glaring issues (non-definition conditionals), le=
t's
>> > wait a little bit before making a decision.
>> >
>> > Added to tasklist: "Remove the duplication of definition conditionals";
>> > left unspecified is how or in what direction :)
>>
>> ACK
>>
>> I'll try to make up my mind :)
>>
>
> I should also point out, this is an issue in the domain and not the
> generator; the generated rst document doesn't have this duplication. So
> it's kind of a no-op while we look and consider this specific series, but
> it's still on my list when we go to look at the predecessor series.

Understood.

[...]


