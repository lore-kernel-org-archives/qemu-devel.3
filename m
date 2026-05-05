Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29D1FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGF4-0000Do-4C; Tue, 05 May 2026 09:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKGEk-0000Bt-Ju
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKGEi-0000Um-GV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777989294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwYZ7isk5BhtuugdO7owTHkcWIj49lXDVxvetLvii58=;
 b=dCHKwPUVwEMkrxQC53roGuBeZGvLFGG5fqvCwqv0qjS1ppAem0215w6o+v8gShmo58Jqd6
 b6o/7vGfm3ZPU5SKtQeSO1oJC0w9QD51bWe8AE05HF4JesLKe8Xgi1o/v5f7Q5MWLKtWhi
 HI/xp8I9V0HGse4qQb2Nymi3lVbMSrs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-ig86TiRIPT6Ocl8SgPKAjQ-1; Tue,
 05 May 2026 09:54:51 -0400
X-MC-Unique: ig86TiRIPT6Ocl8SgPKAjQ-1
X-Mimecast-MFC-AGG-ID: ig86TiRIPT6Ocl8SgPKAjQ_1777989289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A13DF1956096; Tue,  5 May 2026 13:54:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36431944CED; Tue,  5 May 2026 13:54:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8505D21E6A01; Tue, 05 May 2026 15:54:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 05/13] qapi/docs: adjust stub member insertion algorithm
In-Reply-To: <CAFn=p-btJTG9NPzRi3ai+Ac1v1bMqeiYX0HZKKGGX8m3wo+cUg@mail.gmail.com>
 (John Snow's message of "Mon, 4 May 2026 14:30:10 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-6-jsnow@redhat.com>
 <87o6iva0a7.fsf@pond.sub.org>
 <CAFn=p-btJTG9NPzRi3ai+Ac1v1bMqeiYX0HZKKGGX8m3wo+cUg@mail.gmail.com>
Date: Tue, 05 May 2026 15:54:46 +0200
Message-ID: <87o6iu2c7t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Mon, May 4, 2026 at 7:20=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> I'm feeling dense again.  Please be patient with me.
>
> It's okay, this is a complex one. This is part of the reason for
> pursuing strict ordering to begin with: the insertion algorithm is
> complex and ugly.
>
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > A forthcoming patch removes the implicit PLAIN section that always
>> > starts a QAPIDoc section list. Further future changes begin converting
>> > "PLAIN" sections to "INTRO" sections. To accommodate this, the inserti=
on
>> > algorithm that places stub and dummy members must be adjusted to cope.
>>
>> What are the stub and dummy members?
>
> "stub" - undocumented members.
> "dummy" - placeholder section named q_dummy that causes "The members
> of ..." references to be printed in the rendered documentation.

Got it, thanks.

I figure synthesized "Returns:" can also be effected.

>> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at the
>> > beginning of a QAPIDoc object.
>>
>> The revised algorithm, I presume.
>>
>> What's the structure of its valid input before and after this patch?
>
> Before: Plain EverythingElse?
> After: (Plain* | Intro*) EverythingElse?
>
> Where EverythingElse may never start with "Intro", and may contain
> "Plain" but not as the first token when following a Plain section from
> the prior production. (Because contiguous plain sections are merged by
> the parser into one section.)
>
> This is to allow a gradual conversion. Once everything is fully
> converted, and especially after "details" is introduced and the strict
> ordering is enforced, this is tightened down considerably to: Intro?
> EverythingElse?
>
> where EverythingElse may no longer contain Plain (It is removed), may
> never contain Intro, and may only contain one Details section in the
> appropriate position (Near the end, before Since.)
>
> More or less: this patch removes the assumption that every QAPIDoc
> starts with exactly one Plain section and allows it to cope with any
> number of Intro/Plain sections at the beginning, but makes no change
> to what the parser actually produces or accepts. In effect, we go
> from:
>
> Plain EverythingElse
>
> to, in the next patch:
>
> Plain? EverythingElse
>
> then as the conversion continues, one of these two:
>
> Intro Plain? EverythingElse? (Without converted intro)
> Intro EverythingElse? (With converted intro)
>
> ... This entire insertion algorithm gets to be removed once we enforce
> strict ordering, because we can insert directly to the correct
> position in the list thereafter. So, it is only a temporary complexity
> that exists for the sake of gradual conversion and piecemeal list
> review of each QAPI module.

Would working this into the commit message make sense?

>> > Since we have three places that need to insert stub members, take the
>> > opportunity to unify and deduplicate this code.
>>
>> Three?  I can only see two: Transmogrifier.visit_sections() and
>> QAPIDoc.connect_member().
>
> Bad wording on my part again. ensure_returns also inserts stub
> *sections*, not "members", sorry.
>
>>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py | 36 ++++++++---------
>> >  scripts/qapi/parser.py | 90 +++++++++++++++++++++++++++---------------
>> >  2 files changed, 75 insertions(+), 51 deletions(-)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index 1f7c15b7075..70ab9cdc214 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -349,30 +349,32 @@ def _get_target(
>> >                  )
>> >
>> >      def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>> > +        # Generate a placeholder right after the member section(s) wh=
ich
>> > +        # will be used to generate documentation for "The members of.=
.."
>> > +        # pointers in the rendered document.
>> > +        # This is a temporary hack until the inliner is merged.
>> > +        if ent.doc:
>> > +            ent.doc.append_member_stub(
>> > +                QAPIDoc.ArgSection(
>> > +                    ent.doc.info, QAPIDoc.Kind.MEMBER, "q_dummy"
>> > +                )
>> > +            )
>> > +
>>
>> This hack is of the nastier sort: passing a QAPISchema to the doc
>> generator modifies it.
>>
>> Would it be possible to add this dummy always in QAPISchema?  Any
>> drawbacks?
>
> Well...
>
> I didn't like the idea of generating "q_dummy" stubs inside the
> parser, as it is an implementation detail of qapidoc. Though as you
> note, this leaks it back out anyway.
>
> Here's my argument: the entire "q_dummy" thing goes away with the
> inliner anyway, which is what I am actively working towards, and this
> ugliness goes away entirely either way: we do not need q_dummy, we do
> not need member pointer stubs, we will not need to modify the caller's
> section list.
>
> I found this easier to do, despite the ugliness. Also consider that in
> this case, we are building an isolated schema directly inside of the
> Sphinx process anyway, so we are spiritually already "modifying our
> own copy" - i.e. there's no chance that this stuff leaks out into
> other users of the Schema. I think that's actually quite appropriate
> and unlikely to cause unintended consequences.

I think this is really a QAPIDoc defect.

The doc parser knows where the (empty) arguments are.

QAPIDoc also knows, but makes it hard to retrieve.

The old code searches QAPIDoc.all_sections to rediscover the spot.
Moderately ugly, relies on the well-known possible sequence of sections
in all_sections.

Your patch factors out the search, runs it once, and hacks up
.all_sections to store the result.

If we want the result stored in .all_sections (or anywhere in QAPIDoc,
really), why not simply store it when we know it?

Sometimes I wish QAPIDoc had a structure more useful than flat list of
sections...

>> [Remainder left for later...]
>>


