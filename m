Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BBBFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyHI-0000lV-Tc; Mon, 04 May 2026 14:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJyHF-0000jW-BU
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJyHC-0000Oj-UD
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777920256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/7kH93ZAXLkBFFWzg8wYCJu0I3lJ4ODBRhhokhT1oU=;
 b=RNKLhsLdFWM6hpVeVRsN7jmEXfyZ5MwOC0fTvEmcjnRlqZj8TLkDVFQneU/JsbaTAnuzbA
 skdcK50HzedYPeT0CnRhH4pC1vg/34Db12nGMsq9vL95XmxiVN74YLJEnFB0Zh7esYYYOa
 t80aR5Zw9Jjoh2JENoMt5AFOd2Yd/Cs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-jvAk4Z2XNZiVzV8eA8fOzQ-1; Mon, 04 May 2026 14:44:12 -0400
X-MC-Unique: jvAk4Z2XNZiVzV8eA8fOzQ-1
X-Mimecast-MFC-AGG-ID: jvAk4Z2XNZiVzV8eA8fOzQ_1777920252
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7bd8cb253aaso17493987b3.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777920252; cv=none;
 d=google.com; s=arc-20240605;
 b=ghBnyNgSIktBnAuGHhQaWfirvjoSIoOugulVS0z4X7oS7Ltl745elx9U+O1Wc2CV+w
 BEAEC5xtk711M6FBm6qin3wuKGcWpMPDYc8ZtQBLZQAaH+mbYpPZk2nW86oycQeWIp39
 rGbvVWJuN9IHelGdEVtVh8WQZVGlvNc8UgGFZrgYWGDQyHwNdq2B0+XiGk1wIxqbNjll
 euM/oeU7aJ/5ZBue6UvnpCc2StBE0NpjPQ/je9shKjrnPkrFEIOv1JY0l/glOgIA66qL
 g9w8XmmnFjU9ROT/vOOlOso3egAOrd65V4EPVM3Y7cDU8CsRHI+7RfO6m/J9IhBR0pRx
 Htcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c/7kH93ZAXLkBFFWzg8wYCJu0I3lJ4ODBRhhokhT1oU=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=UPbyvEmVCPDyQeBGZpwJwU3ZFj/mSexXIYOH9JcvWAdZysiXB6KTa8UK4/iGhx5oCG
 dekdKBwtqnw6W0FDLkG6FQmL34GXiscdwZ4/33xAKryit7uveqIi6OwvNeDmuTb7uP88
 5ZEEZoh9/OjVrTmFlpNMtVgM+A0MSUZpv+AJA9UpGwhtQSa8UaLhxBUNzXQWH+Kozdfv
 zBe2TtUaOrakPTCgBvsCtk8NXC6FJU+BHUU5AU0dI6fGVI5uTT5kAKHC/PfsCjcHtW54
 ZXCZXnDIrjBeQTL1taIdRl6DMy3ie9Lxim9AtDpWbPO/hSglvR8m4LzKcRFIWeFWGUa8
 gU8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777920252; x=1778525052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/7kH93ZAXLkBFFWzg8wYCJu0I3lJ4ODBRhhokhT1oU=;
 b=H6TZTNII2StJOdDZQwcflFpVZXNzWQ0+VYZ24hAuNEKKz5Ws6q5Q1PF25rnKtrmBaP
 KZGc6gf/TS5sso0K/3upnkJ4rBzI72hwrF8JPlze/JkKZwWX4GZmWR8+TKcoDpiYqSV+
 9g1ZQnel7U3FluckB50vNWo+oJSnatV1wbcHX8BDu08YKlkK99y2AvIlMa5Gxh6Qycml
 qmlQIRg3azGS09/zJVz/5uNODQEpQNYEQn/xSWOkVcGm94ZYoBtha87EmOi1crmqoz4j
 DuY869oUYHx0eVzqnzx5u0udMu28yOturn33sjkcyvZQWl086huNV+6eReF0B+ac6dZz
 wt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777920252; x=1778525052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c/7kH93ZAXLkBFFWzg8wYCJu0I3lJ4ODBRhhokhT1oU=;
 b=GPgrFzcVHp2oyWjd0bgUIfiBlZtqo/hFvGzgNfc9p0Xk1EqpjZxciqSaR0iGqU6dnm
 BIyfrcgPl8cspcnaaRFLrZPv2qffbVENJBWRt1+hxrjaV7PdHIXXGxicjrMCbwZNAiOQ
 aps4jNn1uZFO0A/8ov6LBuOvxsDapX9gPolhWNMq239IkcZaftD9Mecu5g7TQL7tcxgx
 w1FTcsMKK1YqdCmG9TNPOiwqyT6s6yJ1+sMzhgvzoSWtT/x58eM1eb24MgNlLj+ZDwlq
 +G98ubtwuZv7MztrLrd3Rcx/VDKEtSAtpHnLQqd74ttM7Jo+SgxP1nxN4Ow9QuBGPtEr
 2MsQ==
X-Gm-Message-State: AOJu0YwZ9WxH4PmHvnbsPHmeqsFj+NG7yzAJWAndT6Dw1Opp5x/H5XyE
 9sdVFcLSi/N9lKxw/qfMcdPC3gH+evfJCTQjKPuXe/K61QfFQickdsCkdonZ/IBcNI3UXPXCz2q
 drlZAcP7OZ7dOcdx57RpLhYIjCBRLFeNihklpUggYpqLQLgapu8Fvop5BTid+9GLKfSGJV2l1NA
 4mPxFqmgatpHKcT4blwo8rnSadbrm3g6I=
X-Gm-Gg: AeBDiesKqCT8MQT+l0XUMo8BJeIZBndMmpq8fTIPJngq80ts8LPQWoDeNUDTPen1SB2
 OWN/VOSRPdK+1rfFAGuemYSdf/ldWpRyjJgWYqWz0rqQxVNjqMLT6tFwTgsJ1liS7FsRAmVC+lw
 kENhRwocyt/jA40xc4GMI5Hez0EwBOlrT6Lv9pSVBtmyK0KE54S8m04Y19vFDCyq83NF+Kt3m/F
 Gb9sL3NfB75n0e5sNtlHCkLieGBvlM+UMTfoMbswZ7Xl4lJ
X-Received: by 2002:a05:690c:c4e9:b0:7bd:7b55:ebdb with SMTP id
 00721157ae682-7bd7b55efdemr96345967b3.5.1777920252040; 
 Mon, 04 May 2026 11:44:12 -0700 (PDT)
X-Received: by 2002:a05:690c:c4e9:b0:7bd:7b55:ebdb with SMTP id
 00721157ae682-7bd7b55efdemr96345487b3.5.1777920251270; Mon, 04 May 2026
 11:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-8-jsnow@redhat.com>
 <875x539yla.fsf@pond.sub.org>
In-Reply-To: <875x539yla.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 4 May 2026 14:44:00 -0400
X-Gm-Features: AVHnY4JEy8nkNfo-BcGaB9G8L_5uCaB5ZUXF2zSOPzXAjeiHhA_pGwo8zS9O_sI
Message-ID: <CAFn=p-avRmOXQ8UXm5Ot82Q7kHx=ai3fnpw-DDydvWw6XDZ29g@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] qapi/docs: add "Intro" section parsing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 4, 2026 at 7:57=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Add parsing for explicit Intro section syntax.
> >
> > A side effect of this patch is that we will always create an empty Intr=
o
> > section, similar to how we used to have an empty Plain section. The
> > tests are adjusted accordingly, rendered document output does not chang=
e
> > at all.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst            | 17 +++++----
> >  scripts/qapi/parser.py                  | 47 ++++++++++++++++++-------
> >  tests/qapi-schema/doc-good.out          | 18 ++++++++++
> >  tests/qapi-schema/doc-missing-colon.err |  2 +-
> >  4 files changed, 64 insertions(+), 20 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index 3a632b4a648..a8175934d52 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -862,7 +862,7 @@ documentation comment.
> >  If the documentation comment starts like ::
> >
> >      ##
> > -    # @SYMBOL:
> > +    # @SYMBOL: [...]
> >
> >  it documents the definition of SYMBOL, else it's free-form
> >  documentation.
> > @@ -984,11 +984,11 @@ definition it documents.
> >  When documentation is required (see pragma_ 'doc-required'), every
> >  definition must have documentation.
> >
> > -Definition documentation starts with a line naming the definition,
> > -followed by an optional overview, a description of each argument (for
> > -commands and events), member (for structs and unions), branch (for
> > -alternates), or value (for enums), a description of each feature (if
> > -any), and finally optional tagged sections.
> > +Definition documentation starts with a description naming the definiti=
on
> > +with an optional overview, a description of each argument (for command=
s
> > +and events), member (for structs and unions), branch (for alternates),
> > +or value (for enums), a description of each feature (if any), and
> > +finally optional tagged sections.
> >
> >  Descriptions start with '\@name:'.  The description text must be
> >  indented like this::
> > @@ -996,6 +996,11 @@ indented like this::
> >   # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
> >   #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
> >
> > +Definition descriptions are special: the optional introductory overvie=
w
> > +describing the definition will not be inlined when referenced by other
> > +definitions (such as when using 'base' to include members from another
> > +definition), while other descriptions and tagged sections will be.
> > +
>
> Isn't this premature?  We're not inlining anything just yet.

It is, but I felt compelled to justify it holistically instead of
playing "dumb" with the documentation and pretending it didn't exist.
Feel free to suggest better phrasing/rationale here...

>
> >  .. FIXME The parser accepts these things in almost any order.
> >
> >  .. FIXME union branches should be described, too.
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 6612f471bb8..c23fd26aaa7 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -24,6 +24,7 @@
> >      Match,
> >      Optional,
> >      Set,
> > +    Tuple,
> >      Union,
> >  )
> >
> > @@ -524,6 +525,30 @@ def get_doc_paragraph(self, doc: 'QAPIDoc') -> Opt=
ional[str]:
> >                  return line
> >              doc.append_line(line)
> >
> > +    def _get_doc_intro(
> > +        self,
> > +        line: str,
> > +        info: QAPISourceInfo
> > +    ) -> Tuple['QAPIDoc', Optional[str]]:
> > +        match =3D self._match_at_name_colon(line)
> > +        if not match:
> > +            raise QAPIParseError(self, "@name must end with ':'")
> > +
> > +        # Invalid names are not checked here, but the name
> > +        # provided *must* match the following definition,
> > +        # which *is* validated in expr.py.
> > +        symbol =3D match.group(1)
> > +        if not symbol:
> > +            raise QAPIParseError(self, "name required after '@'")
> > +        doc =3D QAPIDoc(info, symbol)
> > +
>
> Drop the blank line.  For what it's worth, you do it already in PATCH
> 13.
>
> > +        doc.ensure_untagged_section(info, QAPIDoc.Kind.INTRO)
>
> Hmm.
>
> .ensure_untagged_section() extends the current section if we have one
> and it is of kind .INTRO, else creates a new one of kind .INTRO.
>
> But there is no current section here!  Why not simply create one?

Leftover. I originally wanted to create this conditionally, but ran
into troubles doing so and gave up and made it unconditional, but
still using the conditional constructor.

>
> > +        text =3D line[match.end():]
> > +        if text:
> > +            doc.append_line(text)
> > +
> > +        return doc, self.get_doc_indented(doc)
> > +
> >      def get_doc(self) -> 'QAPIDoc':
> >          if self.val !=3D '##':
> >              raise QAPIParseError(
> > @@ -532,18 +557,9 @@ def get_doc(self) -> 'QAPIDoc':
> >          self.accept(False)
> >          line =3D self.get_doc_line()
> >          if line is not None and line.startswith('@'):
> > +
>
> Drop the blank line, please.
>
> >              # Definition documentation
> > -            if not line.endswith(':'):
> > -                raise QAPIParseError(self, "line should end with ':'")
> > -            # Invalid names are not checked here, but the name
> > -            # provided *must* match the following definition,
> > -            # which *is* validated in expr.py.
> > -            symbol =3D line[1:-1]
> > -            if not symbol:
> > -                raise QAPIParseError(self, "name required after '@'")
> > -            doc =3D QAPIDoc(info, symbol)
> > -            self.accept(False)
> > -            line =3D self.get_doc_line()
> > +            doc, line =3D self._get_doc_intro(line, info)
> >              no_more_args =3D False
> >
> >              while line is not None:
> > @@ -751,8 +767,13 @@ def end(self) -> None:
> >                  raise QAPISemError(
> >                      section.info, "text required after '%s:'" % sectio=
n.kind)
> >
> > -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> > -        kind =3D QAPIDoc.Kind.PLAIN
> > +    def ensure_untagged_section(
> > +        self,
> > +        info: QAPISourceInfo,
> > +        kind: Optional['QAPIDoc.Kind'] =3D None,
>
> Why not =3D QAPIDoc.Kind.PLAIN here, so ...
>
> > +    ) -> None:
> > +        if kind is None:
> > +            kind =3D QAPIDoc.Kind.PLAIN
>
> ... you don't need this?

Because at the time this function definition is parsed, that
definition does not exist yet :)

>
> >
> >          if self.all_sections and self.all_sections[-1].kind =3D=3D kin=
d:
> >              # extend current section
>
> Hmm.
>
> QAPIDoc.ensure_untagged_section() extends the current section if we have
> one and it's "untagged", else creates a new "untagged" section.
>
> In the beginning, there was just one kind of "untagged" section.  Its
> encoding eventually became "Section.kind is QAPIDoc.Kind.PLAIN".  So
> what the function does was clear enough.
>
> This patch adds a second kind: QAPIDoc.Kind.INTRO.
> .ensure_untagged_section() now takes a kind argument.  It ensures *that*
> kind of section.
>
> I think the function name becomes misleading.  It can now ensure *any*
> kind of section, not just "untagged".
>
> Rename to ensure_section() and make the @kind argument mandatory?

Sure. I agree "untagged" has kind of long since lost its meaning, and
I'm kind of mumbly-brained about what these terms mean anyway, so I
was somewhat hesitant to rename it and wanted to see if I could get
away with not sweeping that corner of the room.

No such luck. Rats.

>
> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
> > index 6fcc8175cfe..bc89853765f 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -106,6 +106,8 @@ Examples:
> >  - *verbatim*
> >  - {braces}
> >  doc symbol=3DEnum
> > +    section=3DIntro
> > +
> >      arg=3Done
> >  The _one_ {and only}, description on the same line
> >      arg=3Dtwo
> > @@ -117,10 +119,14 @@ a member feature
> >      section=3DPlain
> >  @two is undocumented
> >  doc symbol=3DBase
> > +    section=3DIntro
> > +
> >      arg=3Dbase1
> >   description starts on a new line,
> >   minimally indented
> >  doc symbol=3DVariant1
> > +    section=3DIntro
> > +
> >      section=3DPlain
> >  A paragraph
> >
> > @@ -134,10 +140,16 @@ a feature
> >      feature=3Dmember-feat
> >  a member feature
> >  doc symbol=3DVariant2
> > +    section=3DIntro
> > +
> >  doc symbol=3DObject
> > +    section=3DIntro
> > +
> >      feature=3Dunion-feat1
> >  a feature
> >  doc symbol=3DAlternate
> > +    section=3DIntro
> > +
> >      arg=3Di
> >  description starts on the same line
> >      remainder indented the same
> > @@ -151,6 +163,8 @@ doc freeform
> >  Another subsection
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  doc symbol=3Dcmd
> > +    section=3DIntro
> > +
> >      arg=3Darg1
> >      description starts on a new line,
> >      indented
> > @@ -198,6 +212,8 @@ Note::
> >      section=3DSince
> >  2.10
> >  doc symbol=3Dcmd-boxed
> > +    section=3DIntro
> > +
> >      section=3DPlain
> >  If you're bored enough to read this, go see a video of boxed cats
> >      feature=3Dcmd-feat1
> > @@ -211,5 +227,7 @@ another feature
> >
> >     <- ... has no title ...
> >  doc symbol=3DEVT_BOXED
> > +    section=3DIntro
> > +
> >      feature=3Dfeat3
> >  a feature
> > diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schem=
a/doc-missing-colon.err
> > index cbcea007153..bd5862b30f3 100644
> > --- a/tests/qapi-schema/doc-missing-colon.err
> > +++ b/tests/qapi-schema/doc-missing-colon.err
> > @@ -1 +1 @@
> > -doc-missing-colon.json:4:1: line should end with ':'
> > +doc-missing-colon.json:4:1: @name must end with ':'
>
> Let's not change this error message in this patch.  For what it's worth,
> PATCH 13 changes it right back.

That one is an RFC! This patch was my original proposal and 13 is
"Here's the what-if you asked for."

I will definitely merge the PATCH 13 changes to their proper positions
if we conclude that's the direction we are going in, but that was not
clear to me when I sent this series. I wanted to highlight to you that
making the newline "optional" was actually proactive code changes and
not that the reverse was true; i.e. we already forbid the @name: line
from having anything else present on it.

So before getting to your review of later patches, it still isn't
clear to me if you want patch 13 or not, so I can't squash things for
consistency yet as we haven't made a choice.

--js


