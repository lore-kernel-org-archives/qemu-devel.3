Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFBBCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0qW-0000hg-5t; Tue, 09 Jun 2026 14:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX0qN-0000fU-HE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX0qL-00037o-73
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781028384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuccWviCqF3gc4kByg4lj4eR1OAjDvjkjt3M9KaoiEA=;
 b=NzeYhId/K5Oc+jpSdJ0OCpVVhRvlrEIqSI3c5l/6X5gb9mSmglfohS7R9gC33xaF1Em/3s
 sACR22FHayA/BuDjelsXvNf2NYZwf2vM6QT6XTLipBJDWkDn0Qy+0ytrp+t9vMLxsUSU62
 9R4g2bQcLYlseasU2jr08Z3F8R/D4OA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-vVB3TmXbNW6Ba95dY9DLxg-1; Tue, 09 Jun 2026 14:06:20 -0400
X-MC-Unique: vVB3TmXbNW6Ba95dY9DLxg-1
X-Mimecast-MFC-AGG-ID: vVB3TmXbNW6Ba95dY9DLxg_1781028380
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91578c374easo1203300985a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781028380; cv=none;
 d=google.com; s=arc-20240605;
 b=bGTlur657Tbv04kCUMPAgFrYbQaz3riJUZQ+xm5WUo33LkH86faxOYr8ai8kR9NkLT
 jMAT1GkRwGPEPKpvbY6qKiwKC1JV5Cpe7xaA/zeCZShbaR5SXyFmVMBrFhVt+s3adA63
 TaS1sI1LwBGwtAU77o4ipE7hkuCBKPJF4CimtMVXy3sNve56XkOxe60bk12gJFNc7zN2
 OgeWz0AR+B4jndBfq85SA9pQhANuncadItssYNnJEDYytSqAH9d2Yysh+dAqgp1POxzK
 jzSxcTPEXr92cPHpAHiLRQiovg2/20UwhEeD11PpRkG1U3cjZ/BpuyibzaysLNtkWGTk
 aPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NuccWviCqF3gc4kByg4lj4eR1OAjDvjkjt3M9KaoiEA=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=YYq5mInFZ1BCStyBpDsXm/ai6CZhFHwmhMvI7Fsyk9uhI7cdDYzfJXXiiYPHwDP60r
 CyvlydiB92wN7UtWvaG8vbmPI7yglpIvRgUwV3Hnbnr0c5M9uhuPUyYpy5fK5ns62031
 zbU8USXalnBcso3yi8703aZ5nidAuP6nXjQRVAwrfu9K52xe73Hwsvx7YpFvzUGoH2yj
 vUk9JCfGWWfb9gHZyo3nG8+gciEJ0k1eOj6S4Zvrgl8+gvdoPPq63crIVkB4GSVlBUPJ
 5oUceV3exJQ3G/uTjsZEtHAIl5dQG4/2ImY76D5AxFN8hG9qzBJwU7UKJcWxDArYi9ER
 o+eQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781028380; x=1781633180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuccWviCqF3gc4kByg4lj4eR1OAjDvjkjt3M9KaoiEA=;
 b=BO1iDbfvTH7xNNeYVP/70P4lkiyq5iWQB/5feNMqqEEmRg7KtfPLStnybqgzTpucZY
 C+io1muSmMkgwM/OrVcA5DjcFc7GBosaD5MeCP/E0oivSHOcG2QhClDJWcosxPDJL11u
 oskmZYfQ4vO0TmpSqGinb6sIX3xvrlYLN2Xo29pzI+4SN7ShUq3KL5B/fhlBXxUq4pPY
 8Zr7hJkZmvZfjYsOxfv4yGtpY75fyO6uh7m49pYhbVwruG1Z3ZXUBb7yzpAu5gk4b1Kb
 T0gC3XJI+V4OOgW0m+HiyUSWYTl3GMp7Hl0h1r9XMK9s2CNzt1rU/VMtYWxa28jQcAs5
 PGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781028380; x=1781633180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NuccWviCqF3gc4kByg4lj4eR1OAjDvjkjt3M9KaoiEA=;
 b=hy4j0aUrUaqnsprm3M9AoFkdQllT3huj/FChsskF8TMjCvYJINM5clNkMIBY/gMcGP
 bMQ2j1FWFX7SSMirgfXK5QZbMbCh7wVf6b3hecZ7igTb6yX1jvYfv3ujgoH0eZX/yEaJ
 19rVWAGZMJyapjKzI9zmD/UuAcCrj+Oc94wm5E+KEPsI+P0ndmbd+tiSMgn8E2n2ULhp
 qTluL+MQwoQjP1XcmWXHqV8Y22ICU0WuJV+2EL+VqotX2jp8K/EEDpSYSwQWWH11XO2b
 TrPif8YTvtNJ4ZuJvB36+PNXcb0ScwHezCx9eW9TofcFRAlPObX6zLfVotkf4ukLtz1m
 36MQ==
X-Gm-Message-State: AOJu0Yzugnv6SbAmKYXPaLOpsL5gDnBuJguLfOXFce3a4A9ajWYSw2nj
 6CinCjn5Ed5ydMFV9GUYmnwMLzWmgFO83b04Ay//SYVLs+albzxmLCNEFglsI/GhZYI/779y3v3
 OUre54oCffq0WLBIYHskqmZPGkQl53sMQWE2zGLMy/Ks6ZrxtEcbni9yMpGN9LFXMqWkcCkCndG
 F7scmw/uwdc+gvk7prpfSYpz4GJERdH44=
X-Gm-Gg: Acq92OFOH8BcTcrjDugmd3zvZBW5wTC7V1vK9SqidO3afIswO0CCSD4vVQ8i82WsS4q
 iIoiBLV0eN+KjRF4svqi1X/cK/N+Y331tG1bAHEsNXClWR2XG9ZTts0KQ4P1DKsTjRjY75uSv6c
 +WQxql6dceWZFXl5GOuGzznkZlxBMXSRTumfZ806v6YC2WC4BE0gq1a8EW8Hx79wgEIggECGq5p
 b27uDOEVuUvOlrxSjv8hRZDqRRv174zFHww6J6A91iJChx+
X-Received: by 2002:a05:620a:371c:b0:915:c4de:7ab7 with SMTP id
 af79cd13be357-915c4de848fmr2187987985a.35.1781028379642; 
 Tue, 09 Jun 2026 11:06:19 -0700 (PDT)
X-Received: by 2002:a05:620a:371c:b0:915:c4de:7ab7 with SMTP id
 af79cd13be357-915c4de848fmr2187979285a.35.1781028379107; Tue, 09 Jun 2026
 11:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-8-jsnow@redhat.com>
 <87tsrcou8f.fsf@pond.sub.org>
In-Reply-To: <87tsrcou8f.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jun 2026 14:06:07 -0400
X-Gm-Features: AVVi8CdGs4OrHPKjAfP53q3RBlJSXhZAiY3Vh7vq6DyRAALHZKTcBb555JiIBxY
Message-ID: <CAFn=p-bJS7M9FV=Pa8JgpTi=jmSx24-J6uyFCWKvxwEsx4rM6w@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] qapi/docs: add "Intro" section
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

On Tue, Jun 9, 2026 at 6:59=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > This patch adds an "Intro" doc section, intended to eventually replace
> > the "Plain" doc section alongside a forthcoming "Details" section.
> >
> > For now, this section is not actually instantiated or used, but
> > subsequent patches will slowly convert the leading introductory section=
s
> > of QAPIDoc documentation to use this new section.
> >
> > A main motivation of this series of changes is to more explicitly
> > delineate the "Introductory" documentation for each QAPI definition for
> > the sake of the inliner. When inlining members, examples, and details
> > from multiple QAPIDoc sections, we will want to omit the "Introductory"
> > text from inlined definitions while keeping notes, caution boxes,
> > examples, and so on. This new section facilitates that.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 2 +-
> >  scripts/qapi/parser.py | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index c2f09bac16c..1f7c15b7075 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -368,7 +368,7 @@ def visit_sections(self, ent: QAPISchemaDefinition)=
 -> None:
> >          for i, section in enumerate(sections):
> >              section.text =3D self.reformat_arobase(section.text)
> >
> > -            if section.kind =3D=3D QAPIDoc.Kind.PLAIN:
> > +            if section.kind.name in ("PLAIN", "INTRO"):
>
> Is the change from QAPIDoc.Kind.FOO to "FOO" just for brevity, or is
> something going on I don't understand?

Just brevity, honestly. I'm using the .name attribute and checking
against strings. Otherwise it didn't fit on a single line.
Inconsistent style, but I guess I chose what I disliked least.

>
> >                  self.visit_paragraph(section)
> >              elif section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> >                  assert isinstance(section, QAPIDoc.ArgSection)
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index d8068bb1bf6..97e7dacb0fd 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -681,6 +681,7 @@ class Kind(enum.Enum):
> >          ERRORS =3D 4
> >          SINCE =3D 5
> >          TODO =3D 6
> > +        INTRO =3D 7
> >
> >          @staticmethod
> >          def from_string(kind: str) -> 'QAPIDoc.Kind':
> > @@ -748,7 +749,7 @@ def has_features(self) -> bool:
> >      def end(self) -> None:
> >          for section in self.all_sections:
> >              section.text =3D section.text.strip('\n')
> > -            if section.kind !=3D QAPIDoc.Kind.PLAIN and section.text =
=3D=3D '':
> > +            if not (section.kind.name in ("INTRO", "PLAIN") or section=
.text):
> >                  raise QAPISemError(
> >                      section.info, "text required after '%s:'" % sectio=
n.kind)
>


