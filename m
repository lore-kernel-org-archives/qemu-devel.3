Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4209FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxiT-0000Nn-3P; Mon, 04 May 2026 14:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJxiN-0000NG-II
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJxiL-0004fZ-Ep
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777918095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ab7l9Ri7dt201+GRhfi/+Cr0Wm7dDMiaocNySR9RzHM=;
 b=RPN3Yu1N2+QAnq9d5Pik9rpT9kuagvirCmciyId7uMzdinSB0UVevL/XXk4VEau8u0O83I
 SRtOTwRQOqztfsOOiPTyNJvjjWevthQ7SlPpea4YwrvuIXa+IaJ9FbV1bATrJpmSbZaL5T
 iuZ6Nbf7iSZOcesVUALl6BQNrtAKkTM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-IH4ldJLVOOGUFHFgzr-g0Q-1; Mon, 04 May 2026 14:08:11 -0400
X-MC-Unique: IH4ldJLVOOGUFHFgzr-g0Q-1
X-Mimecast-MFC-AGG-ID: IH4ldJLVOOGUFHFgzr-g0Q_1777918091
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7985951fa83so108463707b3.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777918091; cv=none;
 d=google.com; s=arc-20240605;
 b=XCl1jjkSA+UsKqawAy1xYviida0C0TfBPxTM4SK1raB+f5P8ffXpC+Qgb7i04aWjDu
 05jyaOwKPJMKnOfFdwfJzAKl52/wYpV9MJhJ48I6GIEn24ftB3WORnadMa/zcWMoAdUp
 ztxswUOIHMyiu0UNSea/MmNz3iCwf8WOB25kSclQELPao+j9tRLMYmQmMz6U8DYjH1tt
 G8zt9/wIWO3XleNll58g7AS02R4hbjQS+BGelmBcaV/GyL4qRB7Kq2BMk/aFEb9aQQYt
 dG6PIJRUILaJhSHG75jvpNxz0TTzkh6dZQsOv0QcG+n8TgxQ1D90Vm235RVGSRDtujI/
 Mfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ab7l9Ri7dt201+GRhfi/+Cr0Wm7dDMiaocNySR9RzHM=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=b2S7SS2itqDf3cJcDmS1HN/xXQ7GqYUaMbuKjF/AEqBYO/3/T16Gr2fzjwPKF6aXNY
 LqH2e/r8kB914eVDJ0YNa2IWJWJNY9f1sDDnu08/AZwYb4aQc2rJ9aRexNplFJ21tnGF
 oqAdZ/SK59IEVsXz0kHLhED6/JGJCI8HaP9JK+Pv4+MeB1CCBiHDoX1iygKSQgEqYS9g
 2dL6sP1YkUpVmdGB4ehJmZwc9Ii79gcqtrE3vIIEfYm8oTya0ac7sM+r+ZU703OFHiGC
 phWXvWP1oqT4LoU8I995OXck1m7L+7nErMdbTQALiCbZ+WUtqHpoROZd81Jlru5375aM
 uA1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777918091; x=1778522891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab7l9Ri7dt201+GRhfi/+Cr0Wm7dDMiaocNySR9RzHM=;
 b=t41po6uDeFDKJY3NW/YDh1PYuKtfqU6IA6zs8H96arE4/RuvDAIFfPefzoWEamrKqj
 9uEOc+YXWQweS6hmOUw94niO/TujlQ3eml5EjtNzLPIHd3vpgHoLYeXkJlTVG2uqrZsr
 kDqWM0dJcXPZJ17+HN/0WKfRlH/YeJ6BW2XsL8t31V5g1dhPSfKPQfQ8Yw8C1C5Fs6N0
 Bt0mSoPL89AuZTZafLgE9e+8YWGlP9m/Pyt734/alDOGtiIAlo9B42rPDbYPsHGL0JSt
 wcD5Up7GLWa2TrtyQJ9zbQI7TTot+iGcxPrxRY2lN/N2052PcUwio6OKWyshhXu35k4n
 G3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777918091; x=1778522891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ab7l9Ri7dt201+GRhfi/+Cr0Wm7dDMiaocNySR9RzHM=;
 b=k7fv5VeBjUVxDWYlPelZHpBm+pz3MISNNpZrguT2nFkScQsLuiXSC0yzqNoAffYI79
 rGZ3ns++jcKojHTCeJkWaFMJH82ICmtiICRh0BjXYzmXBbk3fNpiyu19VTt+MYZH0fgk
 xf7PlpbP1nSvjQSXdjL3EKrYbkCDFkhErzMdc1yn3kZM8+Qd2OG+fgRs3JspfKgorGf+
 W8wJhv716W0J1q6ZOBZFN99SMZ9OVzAIL6AaWaVcYFC48TX0PM8YFw4Cin3lyjIf56OD
 brNtZAe56B5k03DPvvsOouwqumYidbwJwO8Sm8CS7s8l4vZxEzcFApmBhkQ1U+tS4n4e
 MiDQ==
X-Gm-Message-State: AOJu0YykdK0Xct4biEgOcYxtxBQOPDevO8yH9jaGUJ2TnU9C6fZ3xP3G
 GR3lb49ei0Vm+qXjUEedCPKcBn5NKTVNa+FXQvZs6EYKTc1BAH4hoNaEYTWuygymHZQ9IkdGC8x
 dcYItgeuvcGtbBS7ORypq0WbiztXwxjf23rmGwANGIXfqmif5LWDtiFiosoFVmHt6MKghWP16OJ
 QJWJGBag34gQ40PpKe9MnRroFvKJcNaY0=
X-Gm-Gg: AeBDiet4HibcfxAKAVJZQsw5rvLITUvnC27G8bve4c0LcO/ZRruK6JERCguP/ka76wM
 tTutvA8x0Sw7f047b+j/e4jkpn3u3mjhSWL3psinfuZur7V/j9i9BPqHOQYXdyyRjVh0xxTm/ju
 Crt+jwWplv5rED9N+FWYBUgAtFNlDtipKZAMlIQZh+MzxsyAn+Ya+GhtjSFFwQsqYzGZThmklND
 ULbIwLc7+Zoh4+a4dhzRHatNxqaGgyU00fMTz2biogQCvKx
X-Received: by 2002:a05:690c:6d83:b0:7bd:9899:f916 with SMTP id
 00721157ae682-7bd9899fdaamr40965537b3.49.1777918091032; 
 Mon, 04 May 2026 11:08:11 -0700 (PDT)
X-Received: by 2002:a05:690c:6d83:b0:7bd:9899:f916 with SMTP id
 00721157ae682-7bd9899fdaamr40965057b3.49.1777918090511; Mon, 04 May 2026
 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-4-jsnow@redhat.com>
 <87cxzbbitv.fsf@pond.sub.org>
In-Reply-To: <87cxzbbitv.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 4 May 2026 14:07:59 -0400
X-Gm-Features: AVHnY4I1f8ntl8PQXW_5VwnZm8wpbhdU38z39y4if77s2ANrQ7TVXVhffons-00
Message-ID: <CAFn=p-bAHebSLQqWSOprj=Zah1WbQFFWoC2viBUrX=G1jjrhLg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] qapi/docs: make remaining subsection members
 "private"
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
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Mon, May 4, 2026 at 5:54=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > These fields are used to provide error checking and internal logistics
> > and should not be used by a user of the library to directly access
> > documentation sections, so make them private.
> >
> > The "since" field alone is left public, as the qapidoc generator does
> > use this field to pull that section out of the regular flow of the
> > document.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 54 +++++++++++++++++++++++-------------------
> >  1 file changed, 29 insertions(+), 25 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index b33edbba74f..da4756a7424 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -555,7 +555,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                      break
> >                  # Non-blank line, first of a section
> >                  if line =3D=3D 'Features:':
> > -                    if doc.features:
> > +                    if doc.has_features:
> >                          raise QAPIParseError(
> >                              self, "duplicated 'Features:' line")
> >                      self.accept(False)
> > @@ -570,7 +570,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                          if text:
> >                              doc.append_line(text)
> >                          line =3D self.get_doc_indented(doc)
> > -                    if not doc.features:
> > +                    if not doc.has_features:
> >                          raise QAPIParseError(
> >                              self, 'feature descriptions expected')
> >                      no_more_args =3D True
>
> These two hunks along with the one adding .has_features() below make the
> patch not purely mechanical.  Separate patch, please.

And here I thought I already split this all to the Nth degree. :)

>
> Have you considered using a local bool variable instead?

I prefer having less state and more logic, to avoid having to keep
related state synchronized.

>
> > @@ -733,14 +733,18 @@ def __init__(self, info: QAPISourceInfo, symbol: =
Optional[str] =3D None):
> >              QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
> >          ]
> >          # dicts mapping parameter/feature names to their description
> > -        self.args: Dict[str, QAPIDoc.ArgSection] =3D {}
> > -        self.features: Dict[str, QAPIDoc.ArgSection] =3D {}
> > +        self._args: Dict[str, QAPIDoc.ArgSection] =3D {}
> > +        self._features: Dict[str, QAPIDoc.ArgSection] =3D {}
> >          # a command's "Returns" and "Errors" section
> > -        self.returns: Optional[QAPIDoc.Section] =3D None
> > -        self.errors: Optional[QAPIDoc.Section] =3D None
> > +        self._returns: Optional[QAPIDoc.Section] =3D None
> > +        self._errors: Optional[QAPIDoc.Section] =3D None
> >          # "Since" section
> >          self.since: Optional[QAPIDoc.Section] =3D None
> >
> > +    @property
> > +    def has_features(self) -> bool:
> > +        return bool(self._features)
> > +
> >      def end(self) -> None:
> >          for section in self.all_sections:
> >              section.text =3D section.text.strip('\n')
> > @@ -771,15 +775,15 @@ def new_tagged_section(
> >      ) -> None:
> >          section =3D self.Section(info, kind)
> >          if kind =3D=3D QAPIDoc.Kind.RETURNS:
> > -            if self.returns:
> > +            if self._returns:
> >                  raise QAPISemError(
> >                      info, "duplicated '%s' section" % kind)
> > -            self.returns =3D section
> > +            self._returns =3D section
> >          elif kind =3D=3D QAPIDoc.Kind.ERRORS:
> > -            if self.errors:
> > +            if self._errors:
> >                  raise QAPISemError(
> >                      info, "duplicated '%s' section" % kind)
> > -            self.errors =3D section
> > +            self._errors =3D section
> >          elif kind =3D=3D QAPIDoc.Kind.SINCE:
> >              if self.since:
> >                  raise QAPISemError(
> > @@ -803,16 +807,16 @@ def _new_description(
> >          desc[name] =3D section
> >
> >      def new_argument(self, info: QAPISourceInfo, name: str) -> None:
> > -        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self.ar=
gs)
> > +        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self._a=
rgs)
> >
> >      def new_feature(self, info: QAPISourceInfo, name: str) -> None:
> > -        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self.f=
eatures)
> > +        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self._=
features)
> >
> >      def append_line(self, line: str) -> None:
> >          self.all_sections[-1].append_line(line)
> >
> >      def connect_member(self, member: 'QAPISchemaMember') -> None:
> > -        if member.name not in self.args:
> > +        if member.name not in self._args:
> >              assert member.info
> >              if self.symbol not in member.info.pragma.documentation_exc=
eptions:
> >                  raise QAPISemError(member.info,
> > @@ -823,7 +827,7 @@ def connect_member(self, member: 'QAPISchemaMember'=
) -> None:
> >
> >              section =3D QAPIDoc.ArgSection(
> >                  self.info, QAPIDoc.Kind.MEMBER, member.name)
> > -            self.args[member.name] =3D section
> > +            self._args[member.name] =3D section
> >
> >              # Determine where to insert stub doc - it should go at the
> >              # end of the members section(s), if any. Note that index 0
> > @@ -835,14 +839,14 @@ def connect_member(self, member: 'QAPISchemaMembe=
r') -> None:
> >                      index +=3D 1
> >              self.all_sections.insert(index, section)
> >
> > -        self.args[member.name].connect(member)
> > +        self._args[member.name].connect(member)
> >
> >      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
> > -        if feature.name not in self.features:
> > +        if feature.name not in self._features:
> >              raise QAPISemError(feature.info,
> >                                 "feature '%s' lacks documentation"
> >                                 % feature.name)
> > -        self.features[feature.name].connect(feature)
> > +        self._features[feature.name].connect(feature)
> >
> >      def ensure_returns(self, info: QAPISourceInfo) -> None:
> >
> > @@ -883,18 +887,18 @@ def _insert_near_kind(
> >
> >      def check_expr(self, expr: QAPIExpression) -> None:
> >          if 'command' in expr:
> > -            if self.returns and 'returns' not in expr:
> > +            if self._returns and 'returns' not in expr:
> >                  raise QAPISemError(
> > -                    self.returns.info,
> > +                    self._returns.info,
> >                      "'Returns' section, but command doesn't return any=
thing")
> >          else:
> > -            if self.returns:
> > +            if self._returns:
> >                  raise QAPISemError(
> > -                    self.returns.info,
> > +                    self._returns.info,
> >                      "'Returns' section is only valid for commands")
> > -            if self.errors:
> > +            if self._errors:
> >                  raise QAPISemError(
> > -                    self.errors.info,
> > +                    self._errors.info,
> >                      "'Errors' section is only valid for commands")
> >
> >      def check(self) -> None:
> > @@ -914,5 +918,5 @@ def check_args_section(
> >                          "do" if len(bogus) > 1 else "does"
> >                      ))
> >
> > -        check_args_section(self.args, 'member')
> > -        check_args_section(self.features, 'feature')
> > +        check_args_section(self._args, 'member')
> > +        check_args_section(self._features, 'feature')
>


