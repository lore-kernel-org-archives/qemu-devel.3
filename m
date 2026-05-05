Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277EEFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFqu-0002rB-Mr; Tue, 05 May 2026 09:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKFqu-0002r3-2x
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKFqr-0000fP-I3
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777987816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38AQ+gxkBoeRGotrb26DJOkMBLTF1LI+A63B1aESr88=;
 b=i2mBAjI2MgR4p60PAAQimWNF6MOt4ZBUgBN9oZ/Qqi2oAYB1CR0MPdzO68JqOdcE93DQxC
 veSLY61uumbkEMXFeFtVQFKhrIoGM8j1SxafZX22DXnhXQIDRjIucoUupl5wCZeIMWxI5e
 l4MHWOwcN0BSE9g+2l944aQmL3bAc7M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-lxoU-BGANuCpZGpZ9fzVVQ-1; Tue,
 05 May 2026 09:30:14 -0400
X-MC-Unique: lxoU-BGANuCpZGpZ9fzVVQ-1
X-Mimecast-MFC-AGG-ID: lxoU-BGANuCpZGpZ9fzVVQ_1777987812
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3E81955EB2; Tue,  5 May 2026 13:30:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9138F1800480; Tue,  5 May 2026 13:30:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46EA021E6A01; Tue, 05 May 2026 15:30:09 +0200 (CEST)
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
Subject: Re: [PATCH v2 07/13] qapi/docs: add "Intro" section parsing
In-Reply-To: <CAFn=p-avRmOXQ8UXm5Ot82Q7kHx=ai3fnpw-DDydvWw6XDZ29g@mail.gmail.com>
 (John Snow's message of "Mon, 4 May 2026 14:44:00 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-8-jsnow@redhat.com>
 <875x539yla.fsf@pond.sub.org>
 <CAFn=p-avRmOXQ8UXm5Ot82Q7kHx=ai3fnpw-DDydvWw6XDZ29g@mail.gmail.com>
Date: Tue, 05 May 2026 15:30:09 +0200
Message-ID: <87y0hy2dcu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Mon, May 4, 2026 at 7:57=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Add parsing for explicit Intro section syntax.
>> >
>> > A side effect of this patch is that we will always create an empty Int=
ro
>> > section, similar to how we used to have an empty Plain section. The
>> > tests are adjusted accordingly, rendered document output does not chan=
ge
>> > at all.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.rst            | 17 +++++----
>> >  scripts/qapi/parser.py                  | 47 ++++++++++++++++++-------
>> >  tests/qapi-schema/doc-good.out          | 18 ++++++++++
>> >  tests/qapi-schema/doc-missing-colon.err |  2 +-
>> >  4 files changed, 64 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st
>> > index 3a632b4a648..a8175934d52 100644
>> > --- a/docs/devel/qapi-code-gen.rst
>> > +++ b/docs/devel/qapi-code-gen.rst
>> > @@ -862,7 +862,7 @@ documentation comment.
>> >  If the documentation comment starts like ::
>> >
>> >      ##
>> > -    # @SYMBOL:
>> > +    # @SYMBOL: [...]
>> >
>> >  it documents the definition of SYMBOL, else it's free-form
>> >  documentation.
>> > @@ -984,11 +984,11 @@ definition it documents.
>> >  When documentation is required (see pragma_ 'doc-required'), every
>> >  definition must have documentation.
>> >
>> > -Definition documentation starts with a line naming the definition,
>> > -followed by an optional overview, a description of each argument (for
>> > -commands and events), member (for structs and unions), branch (for
>> > -alternates), or value (for enums), a description of each feature (if
>> > -any), and finally optional tagged sections.
>> > +Definition documentation starts with a description naming the definit=
ion
>> > +with an optional overview, a description of each argument (for comman=
ds
>> > +and events), member (for structs and unions), branch (for alternates),
>> > +or value (for enums), a description of each feature (if any), and
>> > +finally optional tagged sections.
>> >
>> >  Descriptions start with '\@name:'.  The description text must be
>> >  indented like this::
>> > @@ -996,6 +996,11 @@ indented like this::
>> >   # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
>> >   #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
>> >
>> > +Definition descriptions are special: the optional introductory overvi=
ew
>> > +describing the definition will not be inlined when referenced by other
>> > +definitions (such as when using 'base' to include members from another
>> > +definition), while other descriptions and tagged sections will be.
>> > +
>>
>> Isn't this premature?  We're not inlining anything just yet.
>
> It is, but I felt compelled to justify it holistically instead of
> playing "dumb" with the documentation and pretending it didn't exist.
> Feel free to suggest better phrasing/rationale here...

I think we have two reasons for clearly delineated "intro":

1. The existing one: we need to know where to insert synthesized stuff.
   Unclear when there is only a "plain" section.  We abuse TODO to mark
   the spot then.  Your "qapi: enforce section ordering" series makes
   this worse.

   We synthesize missing member documentation, references to base and
   branch types, and omitted "Returns".  docs/devel/qapi-code-gen.rst
   mostly fails to document this, but that's not this patch's fault.

2. The future one: we need to know what not to inline.  This is actually
   exactly the text up to the point where we would insert synthesized
   stuff if we had any.  So any solution for 1. will also solve 2.

I think 1. is sufficient rationale for this patch.

In the commit message, you can mention both if you like.  Just be clear
that 2. is about the future.

If you want rationale in qapi-code-gen.rst: best to stick to 1 there to
avoid confusion.

>> >  .. FIXME The parser accepts these things in almost any order.
>> >
>> >  .. FIXME union branches should be described, too.
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 6612f471bb8..c23fd26aaa7 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -24,6 +24,7 @@
>> >      Match,
>> >      Optional,
>> >      Set,
>> > +    Tuple,
>> >      Union,
>> >  )
>> >
>> > @@ -524,6 +525,30 @@ def get_doc_paragraph(self, doc: 'QAPIDoc') -> Op=
tional[str]:
>> >                  return line
>> >              doc.append_line(line)
>> >
>> > +    def _get_doc_intro(
>> > +        self,
>> > +        line: str,
>> > +        info: QAPISourceInfo
>> > +    ) -> Tuple['QAPIDoc', Optional[str]]:
>> > +        match =3D self._match_at_name_colon(line)
>> > +        if not match:
>> > +            raise QAPIParseError(self, "@name must end with ':'")
>> > +
>> > +        # Invalid names are not checked here, but the name
>> > +        # provided *must* match the following definition,
>> > +        # which *is* validated in expr.py.
>> > +        symbol =3D match.group(1)
>> > +        if not symbol:
>> > +            raise QAPIParseError(self, "name required after '@'")
>> > +        doc =3D QAPIDoc(info, symbol)
>> > +
>>
>> Drop the blank line.  For what it's worth, you do it already in PATCH
>> 13.
>>
>> > +        doc.ensure_untagged_section(info, QAPIDoc.Kind.INTRO)
>>
>> Hmm.
>>
>> .ensure_untagged_section() extends the current section if we have one
>> and it is of kind .INTRO, else creates a new one of kind .INTRO.
>>
>> But there is no current section here!  Why not simply create one?
>
> Leftover. I originally wanted to create this conditionally, but ran
> into troubles doing so and gave up and made it unconditional, but
> still using the conditional constructor.
>
>>
>> > +        text =3D line[match.end():]
>> > +        if text:
>> > +            doc.append_line(text)
>> > +
>> > +        return doc, self.get_doc_indented(doc)
>> > +
>> >      def get_doc(self) -> 'QAPIDoc':
>> >          if self.val !=3D '##':
>> >              raise QAPIParseError(
>> > @@ -532,18 +557,9 @@ def get_doc(self) -> 'QAPIDoc':
>> >          self.accept(False)
>> >          line =3D self.get_doc_line()
>> >          if line is not None and line.startswith('@'):
>> > +
>>
>> Drop the blank line, please.
>>
>> >              # Definition documentation
>> > -            if not line.endswith(':'):
>> > -                raise QAPIParseError(self, "line should end with ':'")
>> > -            # Invalid names are not checked here, but the name
>> > -            # provided *must* match the following definition,
>> > -            # which *is* validated in expr.py.
>> > -            symbol =3D line[1:-1]
>> > -            if not symbol:
>> > -                raise QAPIParseError(self, "name required after '@'")
>> > -            doc =3D QAPIDoc(info, symbol)
>> > -            self.accept(False)
>> > -            line =3D self.get_doc_line()
>> > +            doc, line =3D self._get_doc_intro(line, info)
>> >              no_more_args =3D False
>> >
>> >              while line is not None:
>> > @@ -751,8 +767,13 @@ def end(self) -> None:
>> >                  raise QAPISemError(
>> >                      section.info, "text required after '%s:'" % secti=
on.kind)
>> >
>> > -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>> > -        kind =3D QAPIDoc.Kind.PLAIN
>> > +    def ensure_untagged_section(
>> > +        self,
>> > +        info: QAPISourceInfo,
>> > +        kind: Optional['QAPIDoc.Kind'] =3D None,
>>
>> Why not =3D QAPIDoc.Kind.PLAIN here, so ...
>>
>> > +    ) -> None:
>> > +        if kind is None:
>> > +            kind =3D QAPIDoc.Kind.PLAIN
>>
>> ... you don't need this?
>
> Because at the time this function definition is parsed, that
> definition does not exist yet :)

Are you telling me that kind =3D QAPIDoc.Kind.Plain works as assignment in
the function body, but not as default in the argument list?

Aisde: I'm quite unhappy about the entanglement between QAPISchemaParser
and QAPIDoc.  The latter should be in its own .py.

>
>>
>> >
>> >          if self.all_sections and self.all_sections[-1].kind =3D=3D ki=
nd:
>> >              # extend current section
>>
>> Hmm.
>>
>> QAPIDoc.ensure_untagged_section() extends the current section if we have
>> one and it's "untagged", else creates a new "untagged" section.
>>
>> In the beginning, there was just one kind of "untagged" section.  Its
>> encoding eventually became "Section.kind is QAPIDoc.Kind.PLAIN".  So
>> what the function does was clear enough.
>>
>> This patch adds a second kind: QAPIDoc.Kind.INTRO.
>> .ensure_untagged_section() now takes a kind argument.  It ensures *that*
>> kind of section.
>>
>> I think the function name becomes misleading.  It can now ensure *any*
>> kind of section, not just "untagged".
>>
>> Rename to ensure_section() and make the @kind argument mandatory?
>
> Sure. I agree "untagged" has kind of long since lost its meaning, and
> I'm kind of mumbly-brained about what these terms mean anyway, so I
> was somewhat hesitant to rename it and wanted to see if I could get
> away with not sweeping that corner of the room.
>
> No such luck. Rats.

No rest for the wicked!  ;)

>> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out
>> > index 6fcc8175cfe..bc89853765f 100644
>> > --- a/tests/qapi-schema/doc-good.out
>> > +++ b/tests/qapi-schema/doc-good.out
>> > @@ -106,6 +106,8 @@ Examples:
>> >  - *verbatim*
>> >  - {braces}
>> >  doc symbol=3DEnum
>> > +    section=3DIntro
>> > +
>> >      arg=3Done
>> >  The _one_ {and only}, description on the same line
>> >      arg=3Dtwo
>> > @@ -117,10 +119,14 @@ a member feature
>> >      section=3DPlain
>> >  @two is undocumented
>> >  doc symbol=3DBase
>> > +    section=3DIntro
>> > +
>> >      arg=3Dbase1
>> >   description starts on a new line,
>> >   minimally indented
>> >  doc symbol=3DVariant1
>> > +    section=3DIntro
>> > +
>> >      section=3DPlain
>> >  A paragraph
>> >
>> > @@ -134,10 +140,16 @@ a feature
>> >      feature=3Dmember-feat
>> >  a member feature
>> >  doc symbol=3DVariant2
>> > +    section=3DIntro
>> > +
>> >  doc symbol=3DObject
>> > +    section=3DIntro
>> > +
>> >      feature=3Dunion-feat1
>> >  a feature
>> >  doc symbol=3DAlternate
>> > +    section=3DIntro
>> > +
>> >      arg=3Di
>> >  description starts on the same line
>> >      remainder indented the same
>> > @@ -151,6 +163,8 @@ doc freeform
>> >  Another subsection
>> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >  doc symbol=3Dcmd
>> > +    section=3DIntro
>> > +
>> >      arg=3Darg1
>> >      description starts on a new line,
>> >      indented
>> > @@ -198,6 +212,8 @@ Note::
>> >      section=3DSince
>> >  2.10
>> >  doc symbol=3Dcmd-boxed
>> > +    section=3DIntro
>> > +
>> >      section=3DPlain
>> >  If you're bored enough to read this, go see a video of boxed cats
>> >      feature=3Dcmd-feat1
>> > @@ -211,5 +227,7 @@ another feature
>> >
>> >     <- ... has no title ...
>> >  doc symbol=3DEVT_BOXED
>> > +    section=3DIntro
>> > +
>> >      feature=3Dfeat3
>> >  a feature
>> > diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-sche=
ma/doc-missing-colon.err
>> > index cbcea007153..bd5862b30f3 100644
>> > --- a/tests/qapi-schema/doc-missing-colon.err
>> > +++ b/tests/qapi-schema/doc-missing-colon.err
>> > @@ -1 +1 @@
>> > -doc-missing-colon.json:4:1: line should end with ':'
>> > +doc-missing-colon.json:4:1: @name must end with ':'
>>
>> Let's not change this error message in this patch.  For what it's worth,
>> PATCH 13 changes it right back.
>
> That one is an RFC! This patch was my original proposal and 13 is
> "Here's the what-if you asked for."
>
> I will definitely merge the PATCH 13 changes to their proper positions
> if we conclude that's the direction we are going in, but that was not
> clear to me when I sent this series. I wanted to highlight to you that
> making the newline "optional" was actually proactive code changes and
> not that the reverse was true; i.e. we already forbid the @name: line
> from having anything else present on it.
>
> So before getting to your review of later patches, it still isn't
> clear to me if you want patch 13 or not, so I can't squash things for
> consistency yet as we haven't made a choice.

Understood.

You offer two styles for definition descriptions.  Let me show them both
together with a member description:

    ##
    # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
    #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    #
    # @member1: Ut enim ad minim veniam, quis nostrud exercitation ullamco
    #     laboris nisi ut aliquip ex ea commodo consequat.

or

    ##
    # @name:
    #     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
    #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    #
    # @member1: Ut enim ad minim veniam, quis nostrud exercitation ullamco
    #     laboris nisi ut aliquip ex ea commodo consequat.

The latter makes the defined name (here: "name") stand out a bit more.

It also makes the definition description (@name: ...) differ from member
descriptions (@member: ...).  This could be viewed as a feature or as a
pointless complication.

I lean towards feature.  The lack of visual distinction between
definition description and member descriptions bothers me more in the
first style than in the second style.

I think this is something we should discuss in a 1:1.


