Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA342EC01A4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ar0-0001iR-C9; Mon, 23 Mar 2026 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4aqw-0001hv-Jm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4aqu-0001SP-KA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774255295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dInh74RKH2R7GVqdZJNtAKBl/+b9GNgs14cnwP2dXc=;
 b=Ii8Aq72QyaEDsznM7nXApPJFlkK3o2DB/g4syvbAKI7CNWcDhvL3jtPN4J2FWoNb5YVMMg
 +jOdcbWW7qSmRQlEjND5DRsof7uveMeZB4E+FE86xn0/w1V3ZgLzgIZUe/H5yrRT3cuVAI
 AIHMuyRresI3xlYkc+qm23RtUknHDQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-t4ZNKKTxM6ak0G4E3sLr_w-1; Mon,
 23 Mar 2026 04:41:31 -0400
X-MC-Unique: t4ZNKKTxM6ak0G4E3sLr_w-1
X-Mimecast-MFC-AGG-ID: t4ZNKKTxM6ak0G4E3sLr_w_1774255289
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0549E1944F12; Mon, 23 Mar 2026 08:41:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53957300019F; Mon, 23 Mar 2026 08:41:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B70D21E6937; Mon, 23 Mar 2026 09:41:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jason Wang <jasowang@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 2/8] qapi: prohibit 'details' sections between tagged
 sections
In-Reply-To: <CAFn=p-bU08juAbYaXPheforOU+4se-MZY9PK4Hr7NSVLdAYt2A@mail.gmail.com>
 (John Snow's message of "Fri, 20 Mar 2026 13:40:48 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-3-jsnow@redhat.com>
 <87h5qa7joo.fsf@pond.sub.org>
 <CAFn=p-bU08juAbYaXPheforOU+4se-MZY9PK4Hr7NSVLdAYt2A@mail.gmail.com>
Date: Mon, 23 Mar 2026 09:41:23 +0100
Message-ID: <87se9rym30.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Fri, Mar 20, 2026, 8:46=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch prohibits plain documentation sections from appearing betwe=
en
>> > "tagged" sections. The two existing uses of this pattern are patched
>> > out.
>>
>> One real use, and one just for test coverage.
>>
>> > This is being done primarily to ensure consistency between the source
>> > documents and the final, rendered HTML output. Because
>> > member/feature/returns/error sections will always appear in a visually
>> > grouped element in the HTML output, prohibiting plain paragraphs betwe=
en
>> > those sections ensures ordering consistency between source and the fin=
al
>> > render.
>>
>> Is consistency an actual problem being fixed, or a future problem being
>> avoided?  I'm guessing the latter, based on my review of qom.json below.
>>
>
> With just one actual use, it's *mostly* avoiding future problems. It does
> correct one instance in the rendered HTML of a plain text paragraph
> interrupting the tabular fields, which is not a "bug" per se but a visual
> inconsistency I wish to eliminate.

A visual blemish you wish to eliminate is not an inconsistency between
doc source and rendered doc.

It would become one if you made the generator move the PLAIN section out
to fix the blemish, but that's not the plan.

Instead, you fix the blemish by making doc writers move their PLAIN
sections out.

> The problem is minimal now, but intensifies when considering inlining.

Would inlining make it necessary for the generator to move PLAIN
sections around?  Why?

If yes, this patch eliminates a visual blemish now *and* avoids
inconsistency later.

> Prohibiting the insertion of any section into the "tabular region" helps
> ensure consistent, good looking HTML manual output.
>
> A goal is for source order to match rendered order. Rendered order looks
> best with all tabular elements grouped together without root-level
> paragraphs interrupting them.
>
> Thus, the desire to restrict source order.
>
> (i.e. we allow only one intro section and only one details section.)

I'm not opposed to that, I just want a clearer commit message :)

>> > Additionally, prohibiting such "middle" text paragraphs allows us to
>> > classify all plain text sections as either "intro" or "details" sectio=
ns,
>> > because these sections must either appear before structured/tagged
>> > sections ("intro") or afterwards ("details").
>>
>> Huh?
>>
>> The previous patch already classified all plain text sections as either
>> INTRO or DETAILS.
>>
>> I think the paragraph would make sense if this patch came before the
>> previous one.
>>
>
> Mmm.
>
> The previous patch is confusingly worded and I didn't do better here.
>
> Previous patch categorizes all plaintext sections as intro or details, but
> technically allows multiple details sections.
>
> This patch enforces that we only have one.
>
> (...I think. Currently not clear on how TODO and Since behave with this
> logic. Maybe we end up with multiple details sections interrupted only by
> non-rendered sections... Edit: yes, you find such a case below.)
>
>
>> > This keeps the inlining algorithm simpler with fewer "splice" points
>> > when merging multiple documentation blocks.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/qom.json                   |  4 ++--
>> >  scripts/qapi/parser.py          | 17 +++++++++++++++++
>> >  tests/qapi-schema/doc-good.json |  4 ++--
>> >  tests/qapi-schema/doc-good.out  |  4 ++--
>> >  tests/qapi-schema/doc-good.txt  |  8 ++++----
>> >  5 files changed, 27 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index c653248f85d..1b47abd44e9 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -243,12 +243,12 @@
>> >  #
>> >  # @typename: the type name of an object
>> >  #
>> > +# Returns: a list describing object properties
>> > +#
>> >  # .. note:: Objects can create properties at runtime, for example to
>> >  #    describe links between different devices and/or objects.  These
>> >  #    properties are not included in the output of this command.
>> >  #
>> > -# Returns: a list describing object properties
>> > -#
>> >  # Since: 2.12
>> >  ##
>> >  { 'command': 'qom-list-properties',
>>
>> Rendered documentation before the patch:
>>
>>     Command qom-list-properties (Since: 2.12)
>>
>>        List properties associated with a QOM object.
>>
>>        Arguments:
>>           * typename (string) -- the type name of an object
>>
>>        Note:
>>
>>          Objects can create properties at runtime, for example to descri=
be
>>          links between different devices and/or objects.  These properti=
es
>>          are not included in the output of this command.
>>
>>        Return:
>>           [ObjectPropertyInfo] -- a list describing object properties
>>
>> Afterwards:
>>
>>     Command qom-list-properties (Since: 2.12)
>>
>>        List properties associated with a QOM object.
>>
>>        Arguments:
>>           * typename (string) -- the type name of an object
>>
>>        Return:
>>           [ObjectPropertyInfo] -- a list describing object properties
>>
>>        Note:
>>
>>          Objects can create properties at runtime, for example to descri=
be
>>          links between different devices and/or objects.  These properti=
es
>>          are not included in the output of this command.
>>
>> Fine.
>>
>> [Skipping the Python code in my first pass...]
>>
>> > diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json
>> > index fac13425b72..9103fed472e 100644
>> > --- a/tests/qapi-schema/doc-good.json
>> > +++ b/tests/qapi-schema/doc-good.json
>> > @@ -165,12 +165,12 @@
>> >  # @cmd-feat1: a feature
>> >  # @cmd-feat2: another feature
>> >  #
>> > -# .. note:: @arg3 is undocumented
>> > -#
>> >  # Returns: @Object
>> >  #
>> >  # Errors: some
>> >  #
>> > +# .. note:: @arg3 is undocumented
>> > +#
>> >  # TODO: frobnicate
>> >  #
>> >  # .. admonition:: Notes
>> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out
>> > index 04e29e8d50f..6a0167ad580 100644
>> > --- a/tests/qapi-schema/doc-good.out
>> > +++ b/tests/qapi-schema/doc-good.out
>> > @@ -175,12 +175,12 @@ description starts on the same line
>> >  a feature
>> >      feature=3Dcmd-feat2
>> >  another feature
>> > -    section=3DDetails
>> > -.. note:: @arg3 is undocumented
>> >      section=3DReturns
>> >  @Object
>> >      section=3DErrors
>> >  some
>> > +    section=3DDetails
>> > +.. note:: @arg3 is undocumented
>> >      section=3DTodo
>> >  frobnicate
>> >      section=3DDetails
>>
>> The Details section is still between tagged sections.  The code
>> prohibiting it must have a hole :)
>>
>
> Well, there's the answer to my above self-musing on Since/TODO...
> After reading my replies, is it clear what I am concerned with
> accomplishing?
>
> If not, the goal for *rendered output* is this:
>
> 1. Intro (literally and truly only ever one section, both in the QAPIDoc
> sense and in the rendered HTML output sense)
>
> 2. All tabular sections (members, returns, Errors, features)
>
> 3. Details
>
> You'll notice I didn't bother specifying Since and TODO here. TODO is
> removed from rendered output, so I don't actually care where it goes in t=
he
> QAPIDoc source list.
>
> Since is also removed from the flow in the HTML output, so I also don't
> care about it. (However, you requested that it specifically go last, so I
> do address that in this series and later prohibit any details sections fr=
om
> appearing after a Since marker.)

Understood.

> The true "semantic" goals here are two things:
>
> (1) Prohibiting free text from appearing within the tabular section region
>
> (2) Delineating free text that appears before the tabular region from free
> text that appears after it.
>
> I apologize for conflating "section order" with "rendered section order".
>
> You are right to point out that these sections i do not care about may, in
> the source, impact the classification of other sections and the total
> number thereof.
>
> (i.e. TODO is enough to terminate the intro without an explicit details
> marker, and Since/TODO can create multiple details sections after the
> tabular region. They are merged visually but not in the QAPIDoc sections
> list. I don't consider this a bug per se, but it is the source of a lot of
> confusion here in this series when I am eliding that technicality.)

A commit message needs to explain why and how the patch is useful.  When
details distract from the core argument too much, it can be beneficial
to gloss over them.

Glossing over is not the same as not mentioning.

Commit message readers use it to build a mental model of things.  A good
model simplifies reality.  A bad model misleads about reality.

If the commit message completely elides details that matter, readers end
up with bad models and unwarranted confidence in them.  They'll then
struggle with the patch.

If the commit message at least hints at the details elided, readers may
still end up with bad models, but they'll hopefully understand their
limitations, treat them as incomplete, and fill in the details from the
patch.

[...]


