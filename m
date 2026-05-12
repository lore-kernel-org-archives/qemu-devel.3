Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E0CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuQ7-0001EN-5p; Tue, 12 May 2026 17:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wMuPx-0000ts-7s
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wMuPt-0005Gi-Ks
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778620403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpLcGpSKPYody3ApUKKlUvk3CoPvE0xolSDF3A7efjA=;
 b=KZ6Out5I0VkCyHtMXRhmmuRayqQfBpDrAlr83zpetaBDzOtZ7qKKaLsgqh6IH0++dK5kBg
 Z0IH3dodEm9K9g7VEy6IrXiWMg9pg5jGaD5EdK839lj+EgoaHeeVZn2FL/S1mjniuYsMMW
 PmSeFcK9kF7P6ovNCkVIsQtaTmxenJs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-vjPKrIXIOLKaWG48cbbFog-1; Tue, 12 May 2026 17:13:21 -0400
X-MC-Unique: vjPKrIXIOLKaWG48cbbFog-1
X-Mimecast-MFC-AGG-ID: vjPKrIXIOLKaWG48cbbFog_1778620401
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7bd6f72e5aeso95679057b3.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 14:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620401; cv=none;
 d=google.com; s=arc-20240605;
 b=M+eXslL9LpNURUE6u3YklOExleLZ0l0slG26f0/vN+IYGWibRZykGrLKTRbGxEZDY+
 fnf5yac4G1V68ZQHOoIy7XeX0shWKsK6LrTdJeQKlfqy4RdawCdKsphSKUdVCKcAQcOo
 83YgC/BNxGNpYIS6ZSMWOc74zuBhulv8qUL5Lb+v3tXQWUZs4vaYZSEgKET4Z/VALrrL
 r6W5AJfoyXvhzhddy+yz474+tnwNzUP5hl+ISIanXfQT4qGgQ99LASHXYDkxvZctnEOj
 52iR4TeDKIxPGd9SEzPNL7QA5l2J39DOp8XXLKDUd74ZkN+ZGMtSAFr7uPlH6rSzrMMu
 gncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CpLcGpSKPYody3ApUKKlUvk3CoPvE0xolSDF3A7efjA=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=hCoqUC4EIDJbdt+sluZiEFPOkEiSLH9CL1TeeXCVcYsEMBBZxR+uHAiHF8jZwpknOX
 0m+C9jjG1MapXurKVMP6AXM5bEX5cEZJazCCq+/8BCrL8QFMfVVMEHtm4ZyxGu3rvf93
 Ym9XNr4SnMQBOSwh4+ebHosNqnPqq3oq/9LNmxbS6WRFv0bUkyglFn5NJgGj9PHqSlnV
 1zhaWOKt6p2ALHm0+gZCrKI+mUReBkYe9L11B574tEdbXcG/TlWaq95uGtS7TsHGOVO8
 v4tSg1SOWf+09j5MflnUmLh9xtOCAtI6b5tOPzwQL7I0xPRy/9E66QxmTxwKymAuoNw9
 voDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778620400; x=1779225200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpLcGpSKPYody3ApUKKlUvk3CoPvE0xolSDF3A7efjA=;
 b=CPrS+soCQoiGuQuOpYeLjqL3DVTr0av+g5EVg/h0tclVXIsnZkk6QSQvJQ6sjYvNQO
 1MeOCyGzZ9SKWjIslo3zEN6CIimzB2BmZaTbryN42vGmkiZzfiMJNYNojW+8U4WcS/OO
 ZcSWZ7YixvqRzdrGGS9ZLDGen2jC72QE3L6WFSW6LHUnUUMlLOHJm6V0HJ/7aOQSeQ4t
 EpuTo7b7Sz9zlOqorfXxJfFbGgyofcT1TQlZfk3og9ztwFqUn8/uVlCD2D43QHklhghN
 +hy3hXDSANNXDb4F6tII88jKd3Yr0FSuyUv+cARlck5+DnXEe2QPDaDuv1/ua0BZ//H/
 ICEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778620400; x=1779225200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CpLcGpSKPYody3ApUKKlUvk3CoPvE0xolSDF3A7efjA=;
 b=i2xPijoQdj4lrW/werVAHSzrgYL8pjCzzAPQrYP7GjnTpgEoKK/OJ2W9luF8jo9+x3
 qI0a/NFOmQYodV1BMRgKJEINIvgpMerKnvcwtXSocAsPHMTgSmH9AWPT2Yc8F5Y9T5DW
 j0ywuEeVxqJ1LqeHQ5Vd9cNv6s1fSILExhSExRWcN4f46KGQJk7uc2l9wINZkaJJ2MtL
 CgfXKiN1mIWApZ+zPzZ8Vml4TryEH1lOX6cQ1gJgUA0aHek9vjbW05GaiPKwyd5w9eDE
 sRJchLOu3j0RrDX9cQrBsakZsMJnv6oWXVmElbNMYXbEEVHR9w/f9G2QdMi+xv7KiybY
 CeGg==
X-Gm-Message-State: AOJu0YxLS+SjHzB7HTYA+t/VZnlN3nl/afbkULMzdK+PiZLzCC9V2EsK
 la7N9tXnFJWzHByi4DFBtozSiZGgZMeuEX70xu2Iizqxeq6MUlRJ6WEicfx2buDgICqgFIJWrH/
 bOLK5UYVmrg3df9Ec7e//fkXobMvtHiwdpLBt7s5XbNEdDmAUl9/ZulqbkevV7rTeL8fuE3/JYJ
 WrqE2iZnwr7YaM/KDaouKP6+SgV6YvulE=
X-Gm-Gg: Acq92OG+tVFBI0Sz3uS4ncuWxxO+MtPAQau961OPNovOKjV2VIn/v9kaOeWvj2oOZno
 qydSlVsg/WDNxbuwPqYrL6nh3fH5qON9xKWKL9ZE99AWPWhe2dMpD3DduE08LzD4h51sHLmGVje
 1wdoRVO1VBDmt/ClJjXnuZaRkQyAdcd5As4IK1vOfybdhm3zCysvt4qsB991J/E0wNg0pU2mAJG
 5WvtP7t57C6sUbb+8g0zrlcygsQpO8YFYasvw==
X-Received: by 2002:a05:690c:6612:b0:7bd:5af9:f0a2 with SMTP id
 00721157ae682-7c6ac0bf789mr6458747b3.14.1778620400549; 
 Tue, 12 May 2026 14:13:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6612:b0:7bd:5af9:f0a2 with SMTP id
 00721157ae682-7c6ac0bf789mr6458337b3.14.1778620399986; Tue, 12 May 2026
 14:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-9-jsnow@redhat.com>
 <871pfr9y8c.fsf@pond.sub.org>
In-Reply-To: <871pfr9y8c.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 May 2026 17:13:09 -0400
X-Gm-Features: AVHnY4KzwgAlwjMebjgb1d7qnGjOqWDkiR3yZruXIwFcPaIv9tkMxz1Ot6VCCh8
Message-ID: <CAFn=p-Z5U8Zy0OiDuM8fpR26xvBHQZ8v=6yCBvU899jOPJYQwQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] qapi/docs: Add rendering for INTRO sections
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 4, 2026 at 8:05=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > The only real difference here is that we need to dedent all but the
> > first line so that it renders correctly. We don't need to do this for
> > members and features because they are always rendered as part of a fiel=
d
> > list directive which expects indented lines - Undecorated plaintext
> > doesn't, so we chop the indent off.
> >
> > This does not reflow the text or mess with the source info in any way,
> > so "blame" for error messages should be unchanged.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 70ab9cdc214..6b8e4ecd76a 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -35,6 +35,7 @@
> >  from pathlib import Path
> >  import re
> >  import sys
> > +import textwrap
> >  from typing import TYPE_CHECKING
> >
> >  from docutils import nodes
> > @@ -150,8 +151,14 @@ def add_lines(
> >          self,
> >          content: str,
> >          info: QAPISourceInfo,
> > +        dedent: bool =3D False,
> >      ) -> None:
> >          lines =3D content.splitlines(True)
> > +
> > +        if dedent:
> > +            txt =3D "".join(lines[1:])
> > +            lines[1:] =3D textwrap.dedent(txt).splitlines(True)
> > +
>
> Sure you want to wrap and not just remove indentation?

"textwrap" is the module, "dedent" is the function. This really is
just removing indentation. It just happens to be bundled with the
"textwrap" stdlib module.

>
> >          for i, line in enumerate(lines):
> >              self.add_line_raw(line, info.fname, info.line + i)
> >
> > @@ -223,13 +230,14 @@ def reformat_arobase(text: str) -> str:
> >
> >      # Transmogrification helpers
> >
> > -    def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> > +    def visit_text(self, section: QAPIDoc.Section) -> None:
>
> This is what gets used for sections of kind PLAIN and INTRO.  Can we
> come up with a better term for these than "text"?  Your turf, so I
> *will* take no for an answer.

"patches welcome" - I was just avoiding the use of "paragraph" for
something that might be multiple paragraphs. Once the literal "PLAIN"
section is removed (in favor of semantic successors INTRO and
DETAILS), we can use "visit_plaintext" to refer to the general
category, but currently it's semantically overloaded.

How about I just do "visit_plaintext" and we suffer with the slight
ambiguity for the interim? not married to "text", "plaintext" or
anything else, just don't have better ideas and naming is one of the
two hard problems in CS.

--js

>
> >          # Squelch empty paragraphs.
> >          if not section.text:
> >              return
> >
> > +        dedent =3D bool(section.kind =3D=3D QAPIDoc.Kind.INTRO)
> >          self.ensure_blank_line()
> > -        self.add_lines(section.text, section.info)
> > +        self.add_lines(section.text, section.info, dedent)
> >          self.ensure_blank_line()
> >
> >      def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> > @@ -367,7 +375,7 @@ def visit_sections(self, ent: QAPISchemaDefinition)=
 -> None:
> >              section.text =3D self.reformat_arobase(section.text)
> >
> >              if section.kind.name in ("PLAIN", "INTRO"):
> > -                self.visit_paragraph(section)
> > +                self.visit_text(section)
> >              elif section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> >                  assert isinstance(section, QAPIDoc.ArgSection)
> >                  if section.name =3D=3D "q_dummy":
>


