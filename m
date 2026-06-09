Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AB8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1YH-00047l-FZ; Tue, 09 Jun 2026 14:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1Xs-0003q5-C8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1Xm-0005Mw-Hf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781031080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCswAtT263a0ZsmKD8XqrLbqUhP/Fhx/nYqIniWGmk0=;
 b=Ex5IN1wYI+TzaJZbv5LhG4uemoUu1omG4D1BKl4v0POGD3sfXLuJlw8Fq7bhHdaxJ19Rn1
 ybGYSMfpuEnzJGOC7fIkUSxadYgpuo4HDGSQWfXSTO436GWPa3hHkPAruwqOJiG3cuKuTR
 rvqQeUVgAQg1rJ0oefKDIveuO2l81Og=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-CJwhc6UcPva4NURBkgIF1Q-1; Tue, 09 Jun 2026 14:51:19 -0400
X-MC-Unique: CJwhc6UcPva4NURBkgIF1Q-1
X-Mimecast-MFC-AGG-ID: CJwhc6UcPva4NURBkgIF1Q_1781031079
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5176d949c58so147434671cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031079; cv=none;
 d=google.com; s=arc-20240605;
 b=ffWGzyY5VmYqgzayc+FVSXyKHDF00tvEpS2MrZxA65UldeauRa3QsYEQ5L+BIx6pZL
 ppSmjxDONgscpwDWnfUvBgAG1LxiEQTFt6w+pxy46apEMiVknR/ipa7zwUYglNQb/Lrv
 pqHOyP1Y9feg/iwoaTA426o7yjdVwqO7Vp2OyfjhNA3oNdn9uv57Oplf2BMVF132HeSA
 m074YKygGU/Aguz3pnVIOZBQX8ekln/0WnbIGWxsTpA8NLvBJncS3Fv6y26Wr9rZdXdV
 ucV3ttOuAmdaL/QlAOt+RoKQpieOIF2ccJokJUdhrCIqtbAp/1amW0T+sqfFV5/KnIuU
 Lh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yCswAtT263a0ZsmKD8XqrLbqUhP/Fhx/nYqIniWGmk0=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=Dg0/3n5I83ggDlOQbglqp4lRRzPmgQlz47zjC3gG/TILYkLOerTGqi3tCU2bFxrP7O
 qLqT4QXl7EjrMPlulkN/HcA4+avipjM305syQrbJW/kzVd3wtgAaRF1oKQH6KGj3Ko+r
 l6Qsl8E7y8lO2ii09TuiFG/1zb0iMcLNWeffwxeRR+7Qd6TuISKeBpg5OFrtzf2caMM0
 HZpHQ+b0gT4PQjgtUz/5AQc9DhdwlReI+pmwTNBjSTXTUw77nuhTEwcJ+KvKVkK1trN2
 3OwePN4mt6RLhX3W4QFYPKabvuek6qyM7rxC9Z0dLKJkHoHET8Pa2w1w6fwirwnDgpHr
 H7AQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781031079; x=1781635879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCswAtT263a0ZsmKD8XqrLbqUhP/Fhx/nYqIniWGmk0=;
 b=FJJGAuEuBEJ5Yi/DKLvKgRWMwL0vtJFjlzVsjOEj+pOsNO3yWDF7cp+RRqnvcMkvvI
 lqRkqaWp+9vDW1JSxvm8AAnO3AQi49xriI8mcgLMon6LB7vwWxcCVRDUKOu4JdIat49L
 qSNGwIYlpF/KG0yB/5Ac2kf7D9FG0C/MPhEb1ViBA6DB6gIjzr6fQr0ZCLjfP9DpfJVf
 P4qKysY1lvhe3leq05jmBUIcDzFJu/xWuE+6EVqwJkhq23ctAmMjMyoJdFERi2yRyrzs
 FBpJvpZXbnRxIrPmwQqsC9b11CRPVEccpoyLXAS1FEIDnznFgyuGCCM6FmrJj0DAwxhq
 zWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031079; x=1781635879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCswAtT263a0ZsmKD8XqrLbqUhP/Fhx/nYqIniWGmk0=;
 b=FksRSMWmGG3n3utjCAnsFQi32A49YZwP1KiLcTcaVEcJjlHIT9yReTjNra2PYN3SC8
 DVbWB8gqrd7Wsq3D6RRCElHyyKTu4rKongP4TqtiRczUu0PoCCp3N7VzK1etGJZHnlSj
 bg+zl4zozQ2Za9jwjC/sI2iusWEQGjRlLcR7mmPUHTa71D+apvnRkjjuY/XaipejMQ0f
 X/EuFSlSxhQ1ruH6OFsDJMIrU9krfQtyiAzt2OdSkqpwLH1zmklPKhUmGFr0wOSnVkHZ
 vaAanXw4ie6r9i+3cgqPdTwVXpuk0LjBRJEhYjRFztcQ8w7im5WaEksJ251DBNjweFQT
 7lCA==
X-Gm-Message-State: AOJu0YyGD398bX+0oTdqahSnHsUEWnKws7MAcOamdUuQdvbakkTK+31d
 /0o1yzvJwWyVrOHHPaxky1MXkVtIz/xLA/CpVueKPD46ON2HiYYvjKn4frjwyDQJfvimN8jeyTn
 VUZ9LroHMzACWjrJgeWE7AT/N+lk9KaBj2QO5O9AS1m38cIPyR1Jm00nsnk31/NNjYkeAIcUuD+
 lVHxg7GWUNmrOEhckUsvD1QjXMj90wpLw=
X-Gm-Gg: Acq92OEgf4AGcXKCN+zR0gZolSlYBldQ/H/WrvRTs3/ea7saImmovKwmfxgldn/EFKs
 FRnZ8+qsvlGfVO8O6ZkJFNUJcl6WD3ByrAnKiffYXF+DNmr9OOxfIqhBLvfX27vrq+QTN+6w0U4
 IU7njtxoDa1uy5l1Geea70n//Ej5XxWsWiMYTjIhsKCAOF/Qhudf1y10SF47WVLTA8v05DfbrBM
 dB0HQIbNeBw8uHDmKVwIDgNn/go3OJibqTTn/vW99iQslFm
X-Received: by 2002:a05:622a:6096:b0:517:7217:6737 with SMTP id
 d75a77b69052e-51795afe9e0mr307724531cf.33.1781031078392; 
 Tue, 09 Jun 2026 11:51:18 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:517:7217:6737 with SMTP id
 d75a77b69052e-51795afe9e0mr307723751cf.33.1781031077803; Tue, 09 Jun 2026
 11:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-12-jsnow@redhat.com>
 <87a4t3omy2.fsf@pond.sub.org>
In-Reply-To: <87a4t3omy2.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jun 2026 14:51:05 -0400
X-Gm-Features: AVVi8Cekfstri9M4uf9Wmwd1cxxjiqdixi3lsUKi-o1jhUQn8neRmG3mjwm1vJ8
Message-ID: <CAFn=p-Y6h6uXN9Hf0TjtdE-ZJ2zOGiauqX=kg-Q1p=kCaeg3KA@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] qapi/docs: add rendering for INTRO sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 9, 2026 at 9:36=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Amend the qapidoc generator to handle and render INTRO sections.
> >
> > The only real difference here from other sections is that we need to
> > dedent the text so it renders correctly. Members and Features are also
> > indented, but do not require a dedent() because they are always used
> > in tandem with an rST construct that forms the start of a new indented
> > block; there is coincidental harmony.
> >
> > Plaintext sections, however, do not start their own block and thus
> > need to be dedented to prevent accidentally rendering them as a
> > blockquote or a syntax error.
> >
> > This dedent transformation on the text does not reflow the text, so
> > source line information remains accurate, and the "blame" chain of
> > custody for sphinx rST parsing error messages continues to be correct
> > even through this transformation.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 16ad15fe94f..317dc44b1b8 100644
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
> > @@ -150,8 +151,15 @@ def add_lines(
> >          self,
> >          content: str,
> >          info: QAPISourceInfo,
> > +        dedent: bool =3D False,
> >      ) -> None:
> >          lines =3D content.splitlines(True)
> > +
> > +        if dedent:
> > +            lines =3D textwrap.dedent(content).splitlines(True)
> > +        else:
> > +            lines =3D content.splitlines(True)
> > +
> >          for i, line in enumerate(lines):
> >              self.add_line_raw(line, info.fname, info.line + i)
> >
> > @@ -223,13 +231,14 @@ def reformat_arobase(text: str) -> str:
> >
> >      # Transmogrification helpers
> >
> > -    def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> > +    def visit_plaintext(self, section: QAPIDoc.Section) -> None:
> >          # Squelch empty paragraphs.
> >          if not section.text:
> >              return
> >
> > +        dedent =3D bool(section.kind =3D=3D QAPIDoc.Kind.INTRO)
>
> Could use a comment explaining why INTRO needs to be dedented.

# Please see commit message

(Joking, I added a comment.)

>
> >          self.ensure_blank_line()
> > -        self.add_lines(section.text, section.info)
> > +        self.add_lines(section.text, section.info, dedent)
> >          self.ensure_blank_line()
> >
> >      def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> > @@ -373,7 +382,7 @@ def visit_sections(self, ent: QAPISchemaDefinition)=
 -> None:
> >              section.text =3D self.reformat_arobase(section.text)
> >
> >              if section.kind.name in ("PLAIN", "INTRO"):
> > -                self.visit_paragraph(section)
> > +                self.visit_plaintext(section)
> >              elif section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> >                  assert isinstance(section, QAPIDoc.ArgSection)
> >                  if section.name =3D=3D "q_dummy":
>


