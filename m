Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC51C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYx1-0007Wb-Ku; Tue, 29 Sep 2026 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYww-0007W3-7O
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYwu-0002W5-1O
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790692610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcIXGcfFVqHz6dkxOMk+HJWX21bJlrifUPqTj6LS33k=;
 b=D1kKMPghwfXq9a0b1cdxlIS1eT1BzynMnRHyRGcn5LvsD48H3RyWhhsvxreT5j19zVLiAD
 9x11H7U0Mv3iVPQNEEqj0G+JYy0lv/pL1fDMQc+YcY7tDFO9Sky/wQVdaPoNeDfRHH22gG
 yPvKrwtugfik9PvF3k6nqPMRRapJUNU=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-ReDibBw9Mcqx-ewRQrCrfA-1; Tue, 29 Sep 2026 10:36:48 -0400
X-MC-Unique: ReDibBw9Mcqx-ewRQrCrfA-1
X-Mimecast-MFC-AGG-ID: ReDibBw9Mcqx-ewRQrCrfA_1790692608
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-675a278243aso56058d50.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790692608; cv=none;
 d=google.com; s=arc-20260327;
 b=Ma1jIeGsPu7LTHuSuKN0KotjyUeBLDpHlTeDOq1mrQdDmjHyMO3MXQVNT9BHiVXax2
 7NAdaIWwSqXcwxaqkVDCVRrCjnNCrcaq+i9TOkzd+BuTzMcvKmq/NgNLMnJFhoxEjXfl
 4i1H6LY64L0217vkcgm61uHvcbzIb5Ev+3iNzL+/1q4V15XRUWz+FQxPC0q1cgLo2ZfJ
 CSLpo2UJiKH5ZaPp43BpuuhS9qSBpuggm0Wdlq2KL6hYLWJV7SLgEvOCgaDYKmjE4quH
 S3yZJTKZorfU93TwTanrJw4RpQX5lyglToGUbVGmr/naNaJDBeFmWyIYKGD0BoqMarAZ
 hcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZcIXGcfFVqHz6dkxOMk+HJWX21bJlrifUPqTj6LS33k=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=bsZD1V+lA3r8JbZkFPg4ckgY/TUrQKZEcoLJGQDmc9rkFQkteYFNZlTu/WP3u86SgF
 al0mTL0QWX7U+cE8Z1nDCSqliQdnivdGiq7cRJoAh8Q+v4JmXy194W3yQejNbm5NeDKd
 MmFQSEseqgSHukfjQKdC49VgOUMtfEFMAVDPrvqAIXsFKww8kJvE3hfekvxQ0pcXZ8fN
 GU2r80EjYlgI3tk/9NYWbmyXhnmC5QLjMOBi+Oej7wa5YLkggOuFVbSldLorhoof6r4E
 UeF4Tbsz1uAdvhG1gOMAkzdi5SZ+lH26g7XSMhx25sYv8GXq72piSuV0JBxoUOE3mYSI
 wzxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790692608; x=1791297408; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZcIXGcfFVqHz6dkxOMk+HJWX21bJlrifUPqTj6LS33k=;
 b=j9chhZV1P1iVJkDEKnRst7dwBFESrGKKvc4SLiwT1GRfnhiDCf3x/SrC9HcMMFIuf8
 k0wbgswXSaGuhrejM5duoEetHNPmkPiA+vzFrj8ceBzopShdjZ4AWMJLNPqhfnNNGNjf
 1sEDyC7JTRR/p6Iap+P+aBN3i/R1Aq0V8We6sqXW+tkfN/dTLmn/Gt2Xts6X87M2mSE3
 nosPDwsb13O8Sri3hzX+MKkr/v1axG7yCQSp+k1lvd4v9XsRB5XUHlatnYVxY5poyqCf
 IZPLXZHWnPa6DyKRDh/xoCdDHuGAUoKclCPOVvg22JuOoAelIxqinDWbtZ8bN3eAm3ZM
 qQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790692608; x=1791297408;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZcIXGcfFVqHz6dkxOMk+HJWX21bJlrifUPqTj6LS33k=;
 b=W0gu9pciNNpsM+WNGTgxKJWKQjgropEKQesHPCDi7C83u4nW7COJPvq7ProiJ1Qrm4
 Dj3kc9dIRhsj1yeTxUfZhBAn12oGK/MFam5dX5ukyewjfGJbhTH+ydnOIXw1CI55/V9+
 HLORWZcYnJ64ZMxhSXRZDeuq4XUawfNb3Kcj41Ph3Eedz/5nnh/dk3WBeWz3pDFMsNl1
 OAG9QozO3E9ktkIM9XbLGkrkHcizoB4743Lu37hGrxSweu/18z07uI3b9xcltouVEDru
 /gsDZBsEA4GrVVucPkqPHABaWASIpEa5L/atWRMHLkKJTMhwTZaYLwH90MobuKTjMm5x
 Y1PA==
X-Gm-Message-State: AFq9FYJfu7LbxQIF7kqFc8c8wDrtz0TDPUJjksCju0rKZXfpMDF+GSnr
 p9DPPeZj5fdPelBJuooDu7YPcCZgp6y3CYdBlokM7bRFegnBBaeeaYETALQa7LjCFA01T2PeEFT
 lTspyNK7Y6IPSVI9SAeXhpAXmt94uVYXp353sWynpaYcGCAkVKwCkTSa5tuBYeyfkozQjkxKDxl
 GieUtO+Yrj1sgEOONkW/vec0rL0lwvYD0=
X-Gm-Gg: AYBFou3Kw8XsuPlZCGRnvCJ+ZJW9N4AcUQNUvexHOw8TOwfs58sRZjaICI65mNIuZvA
 cUO12M12wMlMrW5/0NxyPhm+f/Dnb6hIC5rJ0heAQ1CO3Bharlxptku/TS7UO2t1A6DWiMWAYlh
 5L3grA8LbJHSqQndd0i31Z7pLLuisiErvdzz0i3xU37QbSDt06Vy1Z0t6w1KxJRsUYCe/VCYVY5
 ryxnaxfcIwu21U=
X-Received: by 2002:a05:690e:1349:b0:675:710f:73ab with SMTP id
 956f58d0204a3-675710f77e1mr280388d50.14.1790692607729; 
 Tue, 29 Sep 2026 07:36:47 -0700 (PDT)
X-Received: by 2002:a05:690e:1349:b0:675:710f:73ab with SMTP id
 956f58d0204a3-675710f77e1mr280342d50.14.1790692606964; Tue, 29 Sep 2026
 07:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-2-jsnow@redhat.com>
 <87y0ckxooz.fsf@pond.sub.org>
In-Reply-To: <87y0ckxooz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:36:35 -0400
X-Gm-Features: AclHuK_Xxx1a6dZxiYfirQOZp3zvq4DRcRLdq_mg6sUby2m3aXrqciN7940owPA
Message-ID: <CAFn=p-YQnaeG+xJf7OERJDzsa05XW3gYvx3szVuYhUnRm1MOng@mail.gmail.com>
Subject: Re: [PATCH 01/14] qapi: rename "plain" sections to "details"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex@shazbot.org>, Kashyap Chamarthy <kchamart@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bd95ff065ca01cf0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000bd95ff065ca01cf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 7:49=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > With this change, we no longer have "plaintext" sections at all: they
> > are all now either "Intro" or "Details". This patch does not enforce
> > where those details sections must occur; that change occurs in a later
> > patch.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py         |  2 +-
> >  scripts/qapi/parser.py         | 18 +++++++++++-------
> >  tests/qapi-schema/doc-good.out | 18 +++++++++---------
> >  3 files changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 54a32e45f7e..ae57056a393 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -383,7 +383,7 @@ def visit_sections(self, ent: QAPISchemaDefinition)
> -> None:
> >          for section in sections:
> >              section.text =3D self.reformat_arobase(section.text)
> >
> > -            if section.kind.name in ("PLAIN", "INTRO"):
> > +            if section.kind.name in ("INTRO", "DETAILS"):
> >                  self.visit_plaintext(section)
> >              elif section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> >                  assert isinstance(section, QAPIDoc.ArgSection)
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index dcc04b2663e..fe284a3f866 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -674,7 +674,7 @@ class QAPIDoc:
> >      """
> >
> >      class Kind(enum.Enum):
> > -        PLAIN =3D 0
> > +        DETAILS =3D 0
> >          MEMBER =3D 1
> >          FEATURE =3D 2
> >          RETURNS =3D 3
>
> I'd like the order of enum values to match the order of sections
> eventually.
>

I've got a treat for you from the future!


> > @@ -747,12 +747,16 @@ def has_features(self) -> bool:
> >      def end(self) -> None:
> >          for section in self.all_sections:
> >              section.text =3D section.text.strip('\n')
> > -            if not (section.kind.name in ("INTRO", "PLAIN") or
> section.text):
> > +            if (
> > +                    section.kind not in (
> > +                        QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS
> > +                    ) and section.text =3D=3D ''
> > +            ):
>
> This isn't just rename.
>
> The old conditional is a bit "uh, why bother with enums if we do strings
> anyway".  The conditional is ugly.
>
> Are empty DETAILS even possible?  Got a reproducer?
>

Mmm.... I'm afraid of dragons. I can investigate, ...


> If not, you could use
>
>                if section.text =3D=3D '' and section.kind !=3D
> QAPIDoc.Kind.INTRO:
>
> >                  raise QAPISemError(
> >                      section.info, "text required after '%s:'" %
> section.kind)
> >
> >      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> > -        kind =3D QAPIDoc.Kind.PLAIN
> > +        kind =3D QAPIDoc.Kind.DETAILS
> >
> >          if self.all_sections and self.all_sections[-1].kind =3D=3D kin=
d:
> >              # extend current section
> > @@ -837,8 +841,8 @@ def _insert_after_intro(
> >          """
> >          Insert a section immediately after the intro section.
> >
> > -        While we convert PLAIN sections to INTRO sections, all
> > -        contiguous INTRO/PLAIN sections at the start of a QAPIDoc
> > +        While we convert DETAILS sections to INTRO sections, all
> > +        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
> >          section list are treated as "the intro".
> >
> >          Once INTRO conversion is complete, this helper will no longer =
be
>
> This goes away in PATCH 9.  I'd be tempted to delay the rename until
> after that.  Up to you.
>

I'll look.


> > @@ -855,7 +859,7 @@ def _insert_after_intro(
> >
> >          index =3D 0
> >          for index, ref_section in enumerate(self.all_sections):
> > -            if ref_section.kind.name in ("PLAIN", "INTRO"):
> > +            if ref_section.kind.name in ("INTRO", "DETAILS"):
> >                  continue
> >              break
> >          else:
> > @@ -871,7 +875,7 @@ def append_member_stub(self, stub:
> 'QAPIDoc.Section') -> None:
> >          if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
> >              return
> >
> > -        # No MEMBER sections present. Insert after INTRO/PLAIN section=
s.
> > +        # No MEMBER sections present. Insert after INTRO/DETAILS
> sections.
> >          self._insert_after_intro(stub)
> >
> >      def connect_member(self, member: 'QAPISchemaMember') -> None:
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index eaaf119dea8..1d4fbd3762a 100644
>
> [...]
>
>

--000000000000bd95ff065ca01cf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 7:49=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; With this change, we no longer have &quot;plaintext&quot; sections at =
all: they<br>
&gt; are all now either &quot;Intro&quot; or &quot;Details&quot;. This patc=
h does not enforce<br>
&gt; where those details sections must occur; that change occurs in a later=
<br>
&gt; patch.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 +++=
++++++++-------<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out | 18 +++++++++---------<br>
&gt;=C2=A0 3 files changed, 21 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 54a32e45f7e..ae57056a393 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -383,7 +383,7 @@ def visit_sections(self, ent: QAPISchemaDefinition=
) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in sections:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D self.=
reformat_arobase(section.text)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://sectio=
n.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">section.kind.n=
ame</a> in (&quot;PLAIN&quot;, &quot;INTRO&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://sectio=
n.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">section.kind.n=
ame</a> in (&quot;INTRO&quot;, &quot;DETAILS&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vis=
it_plaintext(section)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=
=3D QAPIDoc.Kind.MEMBER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert i=
sinstance(section, QAPIDoc.ArgSection)<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index dcc04b2663e..fe284a3f866 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -674,7 +674,7 @@ class QAPIDoc:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 class Kind(enum.Enum):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 PLAIN =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DETAILS =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMBER =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FEATURE =3D 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RETURNS =3D 3<br>
<br>
I&#39;d like the order of enum values to match the order of sections<br>
eventually.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">I&#39;ve got a treat for you from the future!</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
&gt; @@ -747,12 +747,16 @@ def has_features(self) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def end(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in self.all_sections:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D secti=
on.text.strip(&#39;\n&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not (<a href=3D"http://s=
ection.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">section.k=
ind.name</a> in (&quot;INTRO&quot;, &quot;PLAIN&quot;) or section.text):<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 section.kind not in (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ) and section.text =3D=3D &#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
<br>
This isn&#39;t just rename.<br>
<br>
The old conditional is a bit &quot;uh, why bother with enums if we do strin=
gs<br>
anyway&quot;.=C2=A0 The conditional is ugly.<br>
<br>
Are empty DETAILS even possible?=C2=A0 Got a reproducer?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Mmm.... I&#39;m afr=
aid of dragons. I can investigate, ...</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<br>
If not, you could use<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if section.text =3D=
=3D &#39;&#39; and section.kind !=3D QAPIDoc.Kind.INTRO:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://section.info" rel=3D"noreferrer noreferrer" target=
=3D"_blank">section.info</a>, &quot;text required after &#39;%s:&#39;&quot;=
 % section.kind)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def ensure_untagged_section(self, info: QAPISource=
Info) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind =3D QAPIDoc.Kind.PLAIN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind =3D QAPIDoc.Kind.DETAILS<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and self.all_se=
ctions[-1].kind =3D=3D kind:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend current secti=
on<br>
&gt; @@ -837,8 +841,8 @@ def _insert_after_intro(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Insert a section immediately after t=
he intro section.<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 While we convert PLAIN sections to INTRO =
sections, all<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 contiguous INTRO/PLAIN sections at the st=
art of a QAPIDoc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 While we convert DETAILS sections to INTR=
O sections, all<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 contiguous INTRO/DETAILS sections at the =
start of a QAPIDoc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section list are treated as &quot;th=
e intro&quot;.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Once INTRO conversion is complete, t=
his helper will no longer be<br>
<br>
This goes away in PATCH 9.=C2=A0 I&#39;d be tempted to delay the rename unt=
il<br>
after that.=C2=A0 Up to you.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">I&#39;ll look.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
&gt; @@ -855,7 +859,7 @@ def _insert_after_intro(<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for index, ref_section in enumerate(=
self.all_sections):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://ref_se=
ction.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">ref_sectio=
n.kind.name</a> in (&quot;PLAIN&quot;, &quot;INTRO&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://ref_se=
ction.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">ref_sectio=
n.kind.name</a> in (&quot;INTRO&quot;, &quot;DETAILS&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; @@ -871,7 +875,7 @@ def append_member_stub(self, stub: &#39;QAPIDoc.Se=
ction&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._insert_near_kind(QAPIDoc.Ki=
nd.MEMBER, stub, True):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # No MEMBER sections present. Insert afte=
r INTRO/PLAIN sections.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # No MEMBER sections present. Insert afte=
r INTRO/DETAILS sections.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._insert_after_intro(stub)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def connect_member(self, member: &#39;QAPISchemaMe=
mber&#39;) -&gt; None:<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index eaaf119dea8..1d4fbd3762a 100644<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000bd95ff065ca01cf0--


