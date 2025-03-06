Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063E8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2Sp-0002Vq-Eu; Wed, 05 Mar 2025 23:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq2Sm-0002Uk-Kx
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 23:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq2Sh-0006Ps-RY
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 23:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741233832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yomA8dkBuU/zl2/2Si2KpYrHafQTVHRbEc6uc2XweHM=;
 b=M8zDGTU3DSSwQEibr3lnPSBn4oNa9SsogO12PgpH8ZAtCZZ7qitc4TikQDDTDrHwk93SLZ
 Wqlu4QvVZOh6ce/K5H0iTOC8TWJVLcV+Zft16wOzkygk0vtDkb5ojzH2RnsEOQE52XPnAf
 mWa4ZTCMC3Ft0nW/hP+f+8NKytryL1I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-tPpSwzScMfmmPp2b7q7U6g-1; Wed, 05 Mar 2025 23:03:50 -0500
X-MC-Unique: tPpSwzScMfmmPp2b7q7U6g-1
X-Mimecast-MFC-AGG-ID: tPpSwzScMfmmPp2b7q7U6g_1741233829
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff581215a0so947758a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 20:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741233829; x=1741838629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yomA8dkBuU/zl2/2Si2KpYrHafQTVHRbEc6uc2XweHM=;
 b=htwZX3fMLIYietae63E2i962bof2qjUvf4lZMG0p28MHbh5mmHvTVL43rDBbAL7uNA
 hNUZQ56pZCyU+gBRCyQByH52cksUdHgRTjdIv8rC7e+As6csVsKLQioUDrW6dPJhEXYN
 lHpJmBLHSVqwQWhngjqB6WwPekeC4ie5aTWVTr7Qp4dQbLzGx8sihe0+mpWUfEDEfcIC
 KaM0rxWZxMAtvPIxE4ZTjpr4w5oClmfhetY8DblLWEB9441aF7zNZgtKLloLGm5kP6vt
 S+JZafQBmH8XLRwsIuOpuZ607Yj+RB34Dy59Gd9wKTVfZS8ftMy/PnJANF6tOMdcKw0I
 r+vw==
X-Gm-Message-State: AOJu0YwEYqkqjktybbOkKz5YeGZeoWXVnSohD7+ZjBI2UDKP6OnVFtjx
 h5pFJDz2CEl0KAPjFY+eZvs3Nhl6xf8bo84YKWtkrU/474PL4EVE7Ry342/+Q3mx+dFOq3mwSeT
 2ds8to0dtza2kSMJwOhhu43k9gu0L4G712lZ5MQet62seOXQY9957sFKYJFnyoLqS5k4yx/T0tj
 Ax6It9mAzk4e63HgupiVVW+iP89RQ=
X-Gm-Gg: ASbGncuB02K/0zsbnPu0+31Y/ZZ8vs61QUw6L22M5+n1I3M7yxD2ptHJeI3SCwXijTI
 rQkEbjCqn9gu7iilfqVMDDsZGjw+AkxaDyh6rbJwJkHUZXI9UJgM7QlyTPfwN4xoNN/vEney0Rh
 hVMquDo1vqIpidCEUzX9R+bb47DsK1
X-Received: by 2002:a17:90b:4a10:b0:2ff:6af3:b5fa with SMTP id
 98e67ed59e1d1-2ff6af3b6b6mr376325a91.22.1741233510619; 
 Wed, 05 Mar 2025 19:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAZpkl8tcL7i+MwSgehiztK204eKoxpTICN/j/B7H51JBsfIbcU5nlfSVQ7gp94wD3gYWNA07gwI3ixbfp+So=
X-Received: by 2002:a17:90b:4a10:b0:2ff:6af3:b5fa with SMTP id
 98e67ed59e1d1-2ff6af3b6b6mr376244a91.22.1741233509072; Wed, 05 Mar 2025
 19:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-32-jsnow@redhat.com>
 <875xknok8w.fsf@pond.sub.org>
In-Reply-To: <875xknok8w.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 22:58:14 -0500
X-Gm-Features: AQ5f1JpbRweRf6G7wh3fMofIEJpBxJxkf4jtCt_r6kHJ6PYhrvbyZEaywpam05w
Message-ID: <CAFn=p-bUtzo1dByK0k6kevNDqghcc15L1N8WFWNB_nm9kXvCbQ@mail.gmail.com>
Subject: Re: [PATCH 31/57] qapi: expand tags to all doc sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c7a377062fa4845d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000c7a377062fa4845d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:16=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Replaying review of a previous posting for your convenience...
>
> John Snow <jsnow@redhat.com> writes:
>
> > This patch adds an explicit section "kind" to all QAPIDoc
> > sections. Members/Features are now explicitly marked as such, with the
> > name now being stored in a dedicated "name" field (which qapidoc.py was
> > not actually using anyway.)
>
> I'm not sure what the parenthesis is trying to convey.
>

The old qapidoc.py doesn't actually use the name field, so there's nothing
to adjust for old callers.


>
> Before the patch, we have:
>
>               type        tag
>     untagged  Section     None
>     @foo:     ArgSection  'foo'
>     Returns:  Section     'Returns'
>     Errors:   Section     'Errors'
>     Since:    Section     'Since'
>     TODO:     Section     'TODO'
>
> Afterwards, I believe:
>
>               type         kind     name
>     untagged  Section      PLAIN
>     @foo:     ArgSection   MEMBER   'foo'   if member or argument
>               ArgSection   FEATURE  'foo'   if feature
>     Returns:  Section      RETURNS
>     Errors:   Section      ERRORS
>     Since:    Section      SINCE
>     TODO:     Section      TODO
>
> So, .tag is replaced by .kind and .name, member vs. feature vs. other
> tags is now obvious from .kind alone, i.e. there's no need to account
> for context or type.
>
> Fine print: why do we need to account for type before the patch?
> Consider @Since: ...
>

I'm not sure I follow...


>
> > The qapi-schema tests are updated to account for the new section names;
> > mostly "TODO" becomes "Todo" and `None` becomes "Plain".
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py         |   7 ++-
> >  scripts/qapi/parser.py         | 109 ++++++++++++++++++++++++---------
> >  tests/qapi-schema/doc-good.out |  10 +--
> >  tests/qapi-schema/test-qapi.py |   2 +-
> >  4 files changed, 90 insertions(+), 38 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 61997fd21af..d622398f1da 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -35,6 +35,7 @@
> >  from docutils.statemachine import ViewList
> >  from qapi.error import QAPIError, QAPISemError
> >  from qapi.gen import QAPISchemaVisitor
> > +from qapi.parser import QAPIDoc
> >  from qapi.schema import QAPISchema
> >
> >  from sphinx import addnodes
> > @@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):
> >          """Return list of doctree nodes for additional sections"""
> >          nodelist =3D []
> >          for section in doc.sections:
> > -            if section.tag and section.tag =3D=3D 'TODO':
> > +            if section.kind =3D=3D QAPIDoc.Kind.TODO:
> >                  # Hide TODO: sections
> >                  continue
> >
> > -            if not section.tag:
> > +            if section.kind =3D=3D QAPIDoc.Kind.PLAIN:
> >                  # Sphinx cannot handle sectionless titles;
> >                  # Instead, just append the results to the prior sectio=
n.
> >                  container =3D nodes.container()
> > @@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):
> >                  nodelist +=3D container.children
> >                  continue
> >
> > -            snode =3D self._make_section(section.tag)
> > +            snode =3D self._make_section(section.kind.name.title())
> >              self._parse_text_into_node(dedent(section.text), snode)
> >              nodelist.append(snode)
> >          return nodelist
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 36cb64a677a..c3004aa70c6 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -15,6 +15,7 @@
> >  # See the COPYING file in the top-level directory.
> >
> >  from collections import OrderedDict
> > +import enum
> >  import os
> >  import re
> >  from typing import (
> > @@ -575,7 +576,10 @@ def get_doc(self) -> 'QAPIDoc':
> >                          )
> >                          raise QAPIParseError(self, emsg)
> >
> > -                    doc.new_tagged_section(self.info, match.group(1))
> > +                    doc.new_tagged_section(
> > +                        self.info,
> > +                        QAPIDoc.Kind.from_string(match.group(1))
> > +                    )
> >                      text =3D line[match.end():]
> >                      if text:
> >                          doc.append_line(text)
> > @@ -586,7 +590,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                          self,
> >                          "unexpected '=3D' markup in definition
> documentation")
> >                  else:
> > -                    # tag-less paragraph
> > +                    # plain paragraph(s)
>
> We're parsing a single pargraph here.  The plain section we add it to
> may have any number of paragraphs.  But for me, the comment is about
> what's being parsed.  Mind to drop (s)?
>

Anguish. I can't keep this straight in my head. OK. It wasn't obvious at a
glance where the break is if we get an empty newline ...


>
> >                      doc.ensure_untagged_section(self.info)
> >                      doc.append_line(line)
> >                      line =3D self.get_doc_paragraph(doc)
> > @@ -635,14 +639,37 @@ class QAPIDoc:
> >      Free-form documentation blocks consist only of a body section.
> >      """
> >
> > +    class Kind(enum.Enum):
> > +        PLAIN =3D 0
> > +        MEMBER =3D 1
> > +        FEATURE =3D 2
> > +        RETURNS =3D 3
> > +        ERRORS =3D 4
> > +        SINCE =3D 5
> > +        TODO =3D 6
> > +
> > +        @staticmethod
> > +        def from_string(kind: str) -> 'QAPIDoc.Kind':
>
> Remind me, why do we need to quote the type here?
>

It doesn't exist yet; it's a forward reference, basically. While we are in
the context of defining the class, we don't have access to variables scoped
within the class :)


>
> > +            return QAPIDoc.Kind[kind.upper()]
> > +
> > +        def text_required(self) -> bool:
> > +            # Only "plain" sections can be empty
> > +            return self.value not in (0,)
>
> Rather roundabout way to check for PLAIN, isn't it?
>

Vestigial from intro/details split. It can be removed here for now.


>
> There's just one caller (see below).  I doubt the method is worth its
> keep.
>

Vestigial again. Whether it's worth it once there are multiple such
sections, who knows. I thought it made the code read nicer in context. We
don't need it right now anyway...


>
> > +
> > +        def __str__(self) -> str:
> > +            return self.name.title()
> > +
>
> I wonder whether a simple StrEnum without methods would do.  Oh, StrEnum
> is new in 3.11.  Nevermind.
>
> Hmm.
>
>     >>> Kind =3D Enum('Kind', [('PLAIN', 'Plain'), ('TODO, 'TODO)])
>     >>> kind=3DKind('Plain')
>     >>> kind.value
>     'Plain'
>
> What do you think?
>

Maybe, lemme play with it and see if it makes something else worse, I don't
know right away.


>
> >      class Section:
> >          # pylint: disable=3Dtoo-few-public-methods
> > -        def __init__(self, info: QAPISourceInfo,
> > -                     tag: Optional[str] =3D None):
> > +        def __init__(
> > +            self,
> > +            info: QAPISourceInfo,
> > +            kind: 'QAPIDoc.Kind',
> > +        ):
> >              # section source info, i.e. where it begins
> >              self.info =3D info
> > -            # section tag, if any ('Returns', '@name', ...)
> > -            self.tag =3D tag
> > +            # section kind
> > +            self.kind =3D kind
> >              # section text without tag
> >              self.text =3D ''
> >
> > @@ -650,8 +677,14 @@ def append_line(self, line: str) -> None:
> >              self.text +=3D line + '\n'
> >
> >      class ArgSection(Section):
> > -        def __init__(self, info: QAPISourceInfo, tag: str):
> > -            super().__init__(info, tag)
> > +        def __init__(
> > +            self,
> > +            info: QAPISourceInfo,
> > +            kind: 'QAPIDoc.Kind',
> > +            name: str
> > +        ):
> > +            super().__init__(info, kind)
> > +            self.name =3D name
> >              self.member: Optional['QAPISchemaMember'] =3D None
>
> Before the patch, use of a separate type for members, arguments and
> features was necessary to distinguish between '@TAG:' and 'TAG:' for the
> various TAGs.  This is no longer the case.  Fold ArgSection into
> Section?  Not sure.  If yes, separate patch to keep this one as
> mechanical as possible.
>

Possibly the case. I'll play with it. Do you want it in this series? (It's
pretty long as is...!)


>
> >
> >          def connect(self, member: 'QAPISchemaMember') -> None:
> > @@ -663,7 +696,9 @@ def __init__(self, info: QAPISourceInfo, symbol:
> Optional[str] =3D None):
> >          # definition doc's symbol, None for free-form doc
> >          self.symbol: Optional[str] =3D symbol
> >          # the sections in textual order
> > -        self.all_sections: List[QAPIDoc.Section] =3D
> [QAPIDoc.Section(info)]
> > +        self.all_sections: List[QAPIDoc.Section] =3D [
> > +            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
> > +        ]
> >          # the body section
> >          self.body: Optional[QAPIDoc.Section] =3D self.all_sections[0]
> >          # dicts mapping parameter/feature names to their description
> > @@ -680,12 +715,17 @@ def __init__(self, info: QAPISourceInfo, symbol:
> Optional[str] =3D None):
> >      def end(self) -> None:
> >          for section in self.all_sections:
> >              section.text =3D section.text.strip('\n')
> > -            if section.tag is not None and section.text =3D=3D '':
> > +            if section.kind.text_required() and section.text =3D=3D ''=
:
>
> This is the only use of .text_required().  I believe checking for PLAIN
> would be clearer.
>
> >                  raise QAPISemError(
> > -                    section.info, "text required after '%s:'" %
> section.tag)
> > +                    section.info, "text required after '%s:'" %
> section.kind)
> >
> > -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> > -        if self.all_sections and not self.all_sections[-1].tag:
> > +    def ensure_untagged_section(
> > +        self,
> > +        info: QAPISourceInfo,
> > +    ) -> None:
>
> Accidental line breaking?
>

Something something something black autoformatter. I wonder why it did
this, though... I'll see if I can undo it.


>
> > +        kind =3D QAPIDoc.Kind.PLAIN
> > +
> > +        if self.all_sections and self.all_sections[-1].kind =3D=3D kin=
d:
>
> I'd prefer not to hide PLAIN behind a variable, but I'd also prefer
> the condition to fit on a line.  Hmm.
>

Also somewhat vestigial from when I had intro/details. When that split
comes, kind =3D becomes a conditional ternary.


>
> >              # extend current section
> >              section =3D self.all_sections[-1]
> >              if not section.text:
>
> Maybe
>
>            section =3D self.all_sections[-1] if self.all_sections else No=
ne
>
>            if second and section.kind =3D QAPIDoc.Kind.Plain:
>                # extend current section
>                if not section.text:
>

Could, but it's going to get rewritten when the inliner comes anyway, ...


>
> > @@ -693,46 +733,56 @@ def ensure_untagged_section(self, info:
> QAPISourceInfo) -> None:
> >                  section.info =3D info
> >              section.text +=3D '\n'
> >              return
> > +
> >          # start new section
> > -        section =3D self.Section(info)
> > +        section =3D self.Section(info, kind)
> >          self.sections.append(section)
> >          self.all_sections.append(section)
> >
> > -    def new_tagged_section(self, info: QAPISourceInfo, tag: str) ->
> None:
> > -        section =3D self.Section(info, tag)
> > -        if tag =3D=3D 'Returns':
> > +    def new_tagged_section(
> > +        self,
> > +        info: QAPISourceInfo,
> > +        kind: 'QAPIDoc.Kind',
> > +    ) -> None:
> > +        section =3D self.Section(info, kind)
> > +        if kind =3D=3D QAPIDoc.Kind.RETURNS:
> >              if self.returns:
> >                  raise QAPISemError(
> > -                    info, "duplicated '%s' section" % tag)
> > +                    info, "duplicated '%s' section" % kind)
> >              self.returns =3D section
> > -        elif tag =3D=3D 'Errors':
> > +        elif kind =3D=3D QAPIDoc.Kind.ERRORS:
> >              if self.errors:
> >                  raise QAPISemError(
> > -                    info, "duplicated '%s' section" % tag)
> > +                    info, "duplicated '%s' section" % kind)
> >              self.errors =3D section
> > -        elif tag =3D=3D 'Since':
> > +        elif kind =3D=3D QAPIDoc.Kind.SINCE:
> >              if self.since:
> >                  raise QAPISemError(
> > -                    info, "duplicated '%s' section" % tag)
> > +                    info, "duplicated '%s' section" % kind)
> >              self.since =3D section
> >          self.sections.append(section)
> >          self.all_sections.append(section)
> >
> > -    def _new_description(self, info: QAPISourceInfo, name: str,
> > -                         desc: Dict[str, ArgSection]) -> None:
> > +    def _new_description(
> > +        self,
> > +        info: QAPISourceInfo,
> > +        name: str,
> > +        kind: 'QAPIDoc.Kind',
> > +        desc: Dict[str, ArgSection]
> > +    ) -> None:
> >          if not name:
> >              raise QAPISemError(info, "invalid parameter name")
> >          if name in desc:
> >              raise QAPISemError(info, "'%s' parameter name duplicated" =
%
> name)
> > -        section =3D self.ArgSection(info, '@' + name)
> > +        section =3D self.ArgSection(info, kind, name)
> >          self.all_sections.append(section)
> >          desc[name] =3D section
> >
> >      def new_argument(self, info: QAPISourceInfo, name: str) -> None:
> > -        self._new_description(info, name, self.args)
> > +        self._new_description(info, name, QAPIDoc.Kind.MEMBER,
> self.args)
> >
> >      def new_feature(self, info: QAPISourceInfo, name: str) -> None:
> > -        self._new_description(info, name, self.features)
> > +        self._new_description(info, name, QAPIDoc.Kind.FEATURE,
> self.features)
>
> QAPIDoc.Kind.FOO is a mouthful, and it tends to result in long lines,
> like here.  Can't see an easy and clean way to reduce the verbosity.
>

Yeah...


>
> >
> >      def append_line(self, line: str) -> None:
> >          self.all_sections[-1].append_line(line)
> > @@ -744,8 +794,9 @@ def connect_member(self, member: 'QAPISchemaMember'=
)
> -> None:
> >                  raise QAPISemError(member.info,
> >                                     "%s '%s' lacks documentation"
> >                                     % (member.role, member.name))
> > -            self.args[member.name] =3D QAPIDoc.ArgSection(
> > -                self.info, '@' + member.name)
> > +            section =3D QAPIDoc.ArgSection(
> > +                self.info, QAPIDoc.Kind.MEMBER, member.name)
> > +            self.args[member.name] =3D section
>
> Why the extra variable?
>

Wish I remembered. I can undo it and see if anything barks.


>
> >          self.args[member.name].connect(member)
> >
> >      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 0a9da3efdeb..5773f1dd6d6 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -113,7 +113,7 @@ The _one_ {and only}, description on the same line
> >  Also _one_ {and only}
> >      feature=3Denum-member-feat
> >  a member feature
> > -    section=3DNone
> > +    section=3DPlain
> >  @two is undocumented
> >  doc symbol=3DBase
> >      body=3D
> > @@ -171,15 +171,15 @@ description starts on the same line
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DNone
> > +    section=3DPlain
> >  .. note:: @arg3 is undocumented
> >      section=3DReturns
> >  @Object
> >      section=3DErrors
> >  some
> > -    section=3DTODO
> > +    section=3DTodo
>
> With the method-less Enum I suggested, this hunk would go away.  Not
> that it matters :)
>
> >  frobnicate
> > -    section=3DNone
> > +    section=3DPlain
> >  .. admonition:: Notes
> >
> >   - Lorem ipsum dolor sit amet
> > @@ -212,7 +212,7 @@ If you're bored enough to read this, go see a video
> of boxed cats
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DNone
> > +    section=3DPlain
> >  .. qmp-example::
> >
> >     -> "this example"
> > diff --git a/tests/qapi-schema/test-qapi.py
> b/tests/qapi-schema/test-qapi.py
> > index 7e3f9f4aa1f..bca924309be 100755
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -131,7 +131,7 @@ def test_frontend(fname):
> >          for feat, section in doc.features.items():
> >              print('    feature=3D%s\n%s' % (feat, section.text))
> >          for section in doc.sections:
> > -            print('    section=3D%s\n%s' % (section.tag, section.text)=
)
> > +            print('    section=3D%s\n%s' % (section.kind, section.text=
))
> >
> >
> >  def open_test_result(dir_name, file_name, update):
>
>

--000000000000c7a377062fa4845d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, =
2025 at 5:16=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Replaying review of a previous posting for your co=
nvenience...<br>
<br>
John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; This patch adds an explicit section &quot;kind&quot; to all QAPIDoc<br=
>
&gt; sections. Members/Features are now explicitly marked as such, with the=
<br>
&gt; name now being stored in a dedicated &quot;name&quot; field (which qap=
idoc.py was<br>
&gt; not actually using anyway.)<br>
<br>
I&#39;m not sure what the parenthesis is trying to convey.<br></blockquote>=
<div><br></div><div>The old qapidoc.py doesn&#39;t actually use the name fi=
eld, so there&#39;s nothing to adjust for old callers.</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Before the patch, we have:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tag<br>
=C2=A0 =C2=A0 untagged=C2=A0 Section=C2=A0 =C2=A0 =C2=A0None<br>
=C2=A0 =C2=A0 @foo:=C2=A0 =C2=A0 =C2=A0ArgSection=C2=A0 &#39;foo&#39;<br>
=C2=A0 =C2=A0 Returns:=C2=A0 Section=C2=A0 =C2=A0 =C2=A0&#39;Returns&#39;<b=
r>
=C2=A0 =C2=A0 Errors:=C2=A0 =C2=A0Section=C2=A0 =C2=A0 =C2=A0&#39;Errors&#3=
9;<br>
=C2=A0 =C2=A0 Since:=C2=A0 =C2=A0 Section=C2=A0 =C2=A0 =C2=A0&#39;Since&#39=
;<br>
=C2=A0 =C2=A0 TODO:=C2=A0 =C2=A0 =C2=A0Section=C2=A0 =C2=A0 =C2=A0&#39;TODO=
&#39;<br>
<br>
Afterwards, I believe:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0kind=C2=A0 =C2=A0 =C2=A0name<br>
=C2=A0 =C2=A0 untagged=C2=A0 Section=C2=A0 =C2=A0 =C2=A0 PLAIN<br>
=C2=A0 =C2=A0 @foo:=C2=A0 =C2=A0 =C2=A0ArgSection=C2=A0 =C2=A0MEMBER=C2=A0 =
=C2=A0&#39;foo&#39;=C2=A0 =C2=A0if member or argument<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ArgSection=C2=A0 =C2=A0FEA=
TURE=C2=A0 &#39;foo&#39;=C2=A0 =C2=A0if feature<br>
=C2=A0 =C2=A0 Returns:=C2=A0 Section=C2=A0 =C2=A0 =C2=A0 RETURNS<br>
=C2=A0 =C2=A0 Errors:=C2=A0 =C2=A0Section=C2=A0 =C2=A0 =C2=A0 ERRORS<br>
=C2=A0 =C2=A0 Since:=C2=A0 =C2=A0 Section=C2=A0 =C2=A0 =C2=A0 SINCE<br>
=C2=A0 =C2=A0 TODO:=C2=A0 =C2=A0 =C2=A0Section=C2=A0 =C2=A0 =C2=A0 TODO<br>
<br>
So, .tag is replaced by .kind and .name, member vs. feature vs. other<br>
tags is now obvious from .kind alone, i.e. there&#39;s no need to account<b=
r>
for context or type.<br>
<br>
Fine print: why do we need to account for type before the patch?<br>
Consider @Since: ...<br></blockquote><div><br></div><div>I&#39;m not sure I=
 follow...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt; The qapi-schema tests are updated to account for the new section names=
;<br>
&gt; mostly &quot;TODO&quot; becomes &quot;Todo&quot; and `None` becomes &q=
uot;Plain&quot;.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A07 ++-<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 109 ++=
++++++++++++++++++++++---------<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out |=C2=A0 10 +--<br>
&gt;=C2=A0 tests/qapi-schema/test-qapi.py |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 4 files changed, 90 insertions(+), 38 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 61997fd21af..d622398f1da 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -35,6 +35,7 @@<br>
&gt;=C2=A0 from docutils.statemachine import ViewList<br>
&gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt;=C2=A0 from qapi.gen import QAPISchemaVisitor<br>
&gt; +from qapi.parser import QAPIDoc<br>
&gt;=C2=A0 from qapi.schema import QAPISchema<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from sphinx import addnodes<br>
&gt; @@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Return list of doc=
tree nodes for additional sections&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in doc.sections:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag and section.=
tag =3D=3D &#39;TODO&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind =3D=3D QAPI=
Doc.Kind.TODO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hide T=
ODO: sections<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.tag:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind =3D=3D QAPI=
Doc.Kind.PLAIN:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sphinx=
 cannot handle sectionless titles;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Instea=
d, just append the results to the prior section.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 containe=
r =3D nodes.container()<br>
&gt; @@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist=
 +=3D container.children<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode =3D self._make_sectio=
n(section.tag)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode =3D self._make_sectio=
n(section.kind.name.title())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_text_into_=
node(dedent(section.text), snode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist.append(snode)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nodelist<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 36cb64a677a..c3004aa70c6 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt;=C2=A0 # See the COPYING file in the top-level directory.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from collections import OrderedDict<br>
&gt; +import enum<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import re<br>
&gt;=C2=A0 from typing import (<br>
&gt; @@ -575,7 +576,10 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 doc.new_tagged_section(<a href=3D"http://self.info" rel=3D"noreferrer" tar=
get=3D"_blank">self.info</a>, match.group(1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 doc.new_tagged_section(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer" target=3D"_b=
lank">self.info</a>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 QAPIDoc.Kind.from_string(match.group(1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 text =3D line[match.end():]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if text:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 doc.append_line(text)<br>
&gt; @@ -586,7 +590,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;unexpected &#39;=3D&#39; markup in definition do=
cumentation&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # tag-less paragraph<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # plain paragraph(s)<br>
<br>
We&#39;re parsing a single pargraph here.=C2=A0 The plain section we add it=
 to<br>
may have any number of paragraphs.=C2=A0 But for me, the comment is about<b=
r>
what&#39;s being parsed.=C2=A0 Mind to drop (s)?<br></blockquote><div><br><=
/div><div>Anguish. I can&#39;t keep this straight in my head. OK. It wasn&#=
39;t obvious at a glance where the break is if we get an empty newline ...<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.ensure_untagged_section(<a href=3D"http://self.info" rel=3D"nore=
ferrer" target=3D"_blank">self.info</a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.append_line(line)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_paragraph(doc)<br>
&gt; @@ -635,14 +639,37 @@ class QAPIDoc:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Free-form documentation blocks consist only of a b=
ody section.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 class Kind(enum.Enum):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PLAIN =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMBER =3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 FEATURE =3D 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RETURNS =3D 3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERRORS =3D 4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SINCE =3D 5<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TODO =3D 6<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 @staticmethod<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def from_string(kind: str) -&gt; &#39;QAP=
IDoc.Kind&#39;:<br>
<br>
Remind me, why do we need to quote the type here?<br></blockquote><div><br>=
</div><div>It doesn&#39;t exist yet; it&#39;s a forward reference, basicall=
y. While we are in the context of defining the class, we don&#39;t have acc=
ess to variables scoped within the class :)</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return QAPIDoc.Kind[kind.up=
per()]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def text_required(self) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Only &quot;plain&quot; se=
ctions can be empty<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.value not in (0=
,)<br>
<br>
Rather roundabout way to check for PLAIN, isn&#39;t it?<br></blockquote><di=
v><br></div><div>Vestigial from intro/details split. It can be removed here=
 for now.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
There&#39;s just one caller (see below).=C2=A0 I doubt the method is worth =
its<br>
keep.<br></blockquote><div><br></div><div>Vestigial again. Whether it&#39;s=
 worth it once there are multiple such sections, who knows. I thought it ma=
de the code read nicer in context. We don&#39;t need it right now anyway...=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.name.title()<br=
>
&gt; +<br>
<br>
I wonder whether a simple StrEnum without methods would do.=C2=A0 Oh, StrEn=
um<br>
is new in 3.11.=C2=A0 Nevermind.<br>
<br>
Hmm.<br>
<br>
=C2=A0 =C2=A0 &gt;&gt;&gt; Kind =3D Enum(&#39;Kind&#39;, [(&#39;PLAIN&#39;,=
 &#39;Plain&#39;), (&#39;TODO, &#39;TODO)])<br>
=C2=A0 =C2=A0 &gt;&gt;&gt; kind=3DKind(&#39;Plain&#39;)<br>
=C2=A0 =C2=A0 &gt;&gt;&gt; kind.value<br>
=C2=A0 =C2=A0 &#39;Plain&#39;<br>
<br>
What do you think?<br></blockquote><div><br></div><div>Maybe, lemme play wi=
th it and see if it makes something else worse, I don&#39;t know right away=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 class Section:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dtoo-few-public-m=
ethods<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tag: Optional[str] =3D None):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: &#39;QAPIDoc.Kind&#39=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section source info,=
 i.e. where it begins<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self=
.info" rel=3D"noreferrer" target=3D"_blank">self.info</a> =3D info<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section tag, if any (&#39=
;Returns&#39;, &#39;@name&#39;, ...)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tag =3D tag<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section kind<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kind =3D kind<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section text without=
 tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D &#39;&#3=
9;<br>
&gt;=C2=A0 <br>
&gt; @@ -650,8 +677,14 @@ def append_line(self, line: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text +=3D line + =
&#39;\n&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 class ArgSection(Section):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo, =
tag: str):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info, tag)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: &#39;QAPIDoc.Kind&#39=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info, kind=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name=
" rel=3D"noreferrer" target=3D"_blank">self.name</a> =3D name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.member: Optional[=
&#39;QAPISchemaMember&#39;] =3D None<br>
<br>
Before the patch, use of a separate type for members, arguments and<br>
features was necessary to distinguish between &#39;@TAG:&#39; and &#39;TAG:=
&#39; for the<br>
various TAGs.=C2=A0 This is no longer the case.=C2=A0 Fold ArgSection into<=
br>
Section?=C2=A0 Not sure.=C2=A0 If yes, separate patch to keep this one as<b=
r>
mechanical as possible.<br></blockquote><div><br></div><div>Possibly the ca=
se. I&#39;ll play with it. Do you want it in this series? (It&#39;s pretty =
long as is...!)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def connect(self, member: &#39;QAPIS=
chemaMember&#39;) -&gt; None:<br>
&gt; @@ -663,7 +696,9 @@ def __init__(self, info: QAPISourceInfo, symbol: O=
ptional[str] =3D None):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # definition doc&#39;s symbol, None =
for free-form doc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.symbol: Optional[str] =3D symbo=
l<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the sections in textual order<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections: List[QAPIDoc.Section] =
=3D [QAPIDoc.Section(info)]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections: List[QAPIDoc.Section] =
=3D [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPIDoc.Section(info, QAPID=
oc.Kind.PLAIN)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the body section<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.body: Optional[QAPIDoc.Section]=
 =3D self.all_sections[0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # dicts mapping parameter/feature na=
mes to their description<br>
&gt; @@ -680,12 +715,17 @@ def __init__(self, info: QAPISourceInfo, symbol:=
 Optional[str] =3D None):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def end(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in self.all_sections:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D secti=
on.text.strip(&#39;\n&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag is not None =
and section.text =3D=3D &#39;&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind.text_requir=
ed() and section.text =3D=3D &#39;&#39;:<br>
<br>
This is the only use of .text_required().=C2=A0 I believe checking for PLAI=
N<br>
would be clearer.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <a href=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">secti=
on.info</a>, &quot;text required after &#39;%s:&#39;&quot; % section.tag)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <a href=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">secti=
on.info</a>, &quot;text required after &#39;%s:&#39;&quot; % section.kind)<=
br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def ensure_untagged_section(self, info: QAPISourceInfo)=
 -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and not self.all_sec=
tions[-1].tag:<br>
&gt; +=C2=A0 =C2=A0 def ensure_untagged_section(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
<br>
Accidental line breaking?<br></blockquote><div><br></div><div>Something som=
ething something black autoformatter. I wonder why it did this, though... I=
&#39;ll see if I can undo it.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind =3D QAPIDoc.Kind.PLAIN<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and self.all_section=
s[-1].kind =3D=3D kind:<br>
<br>
I&#39;d prefer not to hide PLAIN behind a variable, but I&#39;d also prefer=
<br>
the condition to fit on a line.=C2=A0 Hmm.<br></blockquote><div><br></div><=
div>Also somewhat vestigial from when I had intro/details. When that split =
comes, kind =3D becomes a conditional ternary.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend current secti=
on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.all_s=
ections[-1]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.text:<b=
r>
<br>
Maybe<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section =3D self.all_sections[-1] =
if self.all_sections else None<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if second and section.kind =3D QAP=
IDoc.Kind.Plain:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# extend current sec=
tion<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not section.text:=
<br></blockquote><div><br></div><div>Could, but it&#39;s going to get rewri=
tten when the inliner comes anyway, ...</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; @@ -693,46 +733,56 @@ def ensure_untagged_section(self, info: QAPISour=
ceInfo) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=
=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.info<=
/a> =3D info<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text +=3D &#39=
;\n&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, kind)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sections.append(section)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br=
>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def new_tagged_section(self, info: QAPISourceInfo, tag:=
 str) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, tag)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tag =3D=3D &#39;Returns&#39;:<br>
&gt; +=C2=A0 =C2=A0 def new_tagged_section(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: &#39;QAPIDoc.Kind&#39;,<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, kind)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if kind =3D=3D QAPIDoc.Kind.RETURNS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.returns:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % tag)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.returns =3D secti=
on<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif tag =3D=3D &#39;Errors&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif kind =3D=3D QAPIDoc.Kind.ERRORS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.errors:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % tag)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.errors =3D sectio=
n<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif tag =3D=3D &#39;Since&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif kind =3D=3D QAPIDoc.Kind.SINCE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.since:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % tag)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.since =3D section=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sections.append(section)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br=
>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def _new_description(self, info: QAPISourceInfo, name: =
str,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0desc: Dict[str, ArgSection]) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 def _new_description(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: &#39;QAPIDoc.Kind&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc: Dict[str, ArgSection]<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not name:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(inf=
o, &quot;invalid parameter name&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name in desc:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(inf=
o, &quot;&#39;%s&#39; parameter name duplicated&quot; % name)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.ArgSection(info, &#39;@&=
#39; + name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.ArgSection(info, kind, n=
ame)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc[name] =3D section<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def new_argument(self, info: QAPISourceInfo, name:=
 str) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._new_description(info, name, self.ar=
gs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._new_description(info, name, QAPIDoc=
.Kind.MEMBER, self.args)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def new_feature(self, info: QAPISourceInfo, name: =
str) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._new_description(info, name, self.fe=
atures)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._new_description(info, name, QAPIDoc=
.Kind.FEATURE, self.features)<br>
<br>
QAPIDoc.Kind.FOO is a mouthful, and it tends to result in long lines,<br>
like here.=C2=A0 Can&#39;t see an easy and clean way to reduce the verbosit=
y.<br></blockquote><div><br></div><div>Yeah...</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def append_line(self, line: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections[-1].append_line(li=
ne)<br>
&gt; @@ -744,8 +794,9 @@ def connect_member(self, member: &#39;QAPISchemaMe=
mber&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<a href=3D"http://member.info" rel=3D"noreferrer" target=3D"_bla=
nk">member.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s &#39=
;%s&#39; lacks documentation&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (member.rol=
e, <a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">memb=
er.name</a>))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http:/=
/member.name" rel=3D"noreferrer" target=3D"_blank">member.name</a>] =3D QAP=
IDoc.ArgSection(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a>, &#39;@&=
#39; + <a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">=
member.name</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D QAPIDoc.ArgSect=
ion(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a>, QAPIDoc=
.Kind.MEMBER, <a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_=
blank">member.name</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http:/=
/member.name" rel=3D"noreferrer" target=3D"_blank">member.name</a>] =3D sec=
tion<br>
<br>
Why the extra variable?<br></blockquote><div><br></div><div>Wish I remember=
ed. I can undo it and see if anything barks.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http://member.n=
ame" rel=3D"noreferrer" target=3D"_blank">member.name</a>].connect(member)<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def connect_feature(self, feature: &#39;QAPISchema=
Feature&#39;) -&gt; None:<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 0a9da3efdeb..5773f1dd6d6 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -113,7 +113,7 @@ The _one_ {and only}, description on the same line=
<br>
&gt;=C2=A0 Also _one_ {and only}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Denum-member-feat<br>
&gt;=C2=A0 a member feature<br>
&gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt; +=C2=A0 =C2=A0 section=3DPlain<br>
&gt;=C2=A0 @two is undocumented<br>
&gt;=C2=A0 doc symbol=3DBase<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt; @@ -171,15 +171,15 @@ description starts on the same line<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt; +=C2=A0 =C2=A0 section=3DPlain<br>
&gt;=C2=A0 .. note:: @arg3 is undocumented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DReturns<br>
&gt;=C2=A0 @Object<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DErrors<br>
&gt;=C2=A0 some<br>
&gt; -=C2=A0 =C2=A0 section=3DTODO<br>
&gt; +=C2=A0 =C2=A0 section=3DTodo<br>
<br>
With the method-less Enum I suggested, this hunk would go away.=C2=A0 Not<b=
r>
that it matters :)<br>
<br>
&gt;=C2=A0 frobnicate<br>
&gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt; +=C2=A0 =C2=A0 section=3DPlain<br>
&gt;=C2=A0 .. admonition:: Notes<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0- Lorem ipsum dolor sit amet<br>
&gt; @@ -212,7 +212,7 @@ If you&#39;re bored enough to read this, go see a =
video of boxed cats<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt; +=C2=A0 =C2=A0 section=3DPlain<br>
&gt;=C2=A0 .. qmp-example::<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
&gt; diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-q=
api.py<br>
&gt; index 7e3f9f4aa1f..bca924309be 100755<br>
&gt; --- a/tests/qapi-schema/test-qapi.py<br>
&gt; +++ b/tests/qapi-schema/test-qapi.py<br>
&gt; @@ -131,7 +131,7 @@ def test_frontend(fname):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat, section in doc.features.it=
ems():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;=C2=A0 =C2=
=A0 feature=3D%s\n%s&#39; % (feat, section.text))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in doc.sections:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;=C2=A0 =C2=A0 se=
ction=3D%s\n%s&#39; % (section.tag, section.text))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;=C2=A0 =C2=A0 se=
ction=3D%s\n%s&#39; % (section.kind, section.text))<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def open_test_result(dir_name, file_name, update):<br>
<br>
</blockquote></div></div>

--000000000000c7a377062fa4845d--


