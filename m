Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F002CC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYgk-0002ry-Tz; Tue, 29 Sep 2026 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYgf-0002rO-CW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYgd-0000PV-0n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790691602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MRyJgwnKHEK2bXHpc2ps6Aq24aeCIjsnKBaaMCnXjoc=;
 b=NbNE9qSQ3rr+QUnp6/x5K2xHgogGVBPIqDUoEgHm+e+tympHVhyl/9lkhR02+Pn159rJvx
 m3kx/qGJJfaaz6ipHFjpOuGnHse7tXtRiGIJinBwb5mB7MohHtoYQoFffUvTLoAtUVnbPt
 /nZSicjCwgay9T5j+CsDdL8SaIrhHys=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-2RsmPABlME2kXM9oi8WnLA-1; Tue, 29 Sep 2026 10:19:58 -0400
X-MC-Unique: 2RsmPABlME2kXM9oi8WnLA-1
X-Mimecast-MFC-AGG-ID: 2RsmPABlME2kXM9oi8WnLA_1790691597
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-673263bc7e1so1161243d50.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691597; cv=none;
 d=google.com; s=arc-20260327;
 b=No4X4MKrKJ8WCPqv3LfUpQmw5m6mPp78q53yNKWBjINlNEXBuSD0yFY4JmNIlQrK0w
 Uubi9DdZq7nKvsggkteG2LsN0natHFwgxoRIbv27UvQVF8soZWkgQSUw2JuVoN2fTZm+
 5S9r+4w4In9iMquIHe7H7sfBMo4KatZxcWdSWcUcmdIfTA3qio1s49vgF3liL53nyLM6
 2VVX0b6rcKOXklW2Dnug/DBGC1IWjFh1sPnZtlGEpZ67wPbtZ6tPgRSg9lq9xqXCJtbi
 OiDUhUiErmEpIIohSjClPUMg1ii4F+ROVM8rprm2WQi2couwWVO/s3/mNFEncLZdaemm
 cjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MRyJgwnKHEK2bXHpc2ps6Aq24aeCIjsnKBaaMCnXjoc=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=ondvZxmnHQJvdQOwxAl2Tb0AGAW5Z+yzNYWFNt2TOx6AWN5EA522CjBgwnW2/h/Ps/
 qLpL1LCZ9Fxe9OBdA7LjPax57aDu+v3A45NO/17vlY5NrankYp9HsXnR3POSEUXupREY
 Oa2ZFdIEoniXxE1kg8Ay05CLDQMu/XZHbnKaLc/IyPHcg9lxFStxsvtlwJwpiuu+dDVv
 GePjp7Cc+3Jp9ZHCqLGGVZHLx/tiyDX2XPY4wQknHK/dGvh6H+tFPmKhZ03adcm0MCto
 YjnbTed07RVmph60D2Xm8jBRqD0Lurh8i0TRLfR1nT/bC46g3bWgbF9Ecln29NIeD4Ua
 WBIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790691597; x=1791296397; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MRyJgwnKHEK2bXHpc2ps6Aq24aeCIjsnKBaaMCnXjoc=;
 b=agS0vteYoUJiBYoR1vtJQAkeDyjr0Tx8TMBPIJ48WNvs6kC5vHJOKaDJsZO3RaKI7K
 R07IUSGiN83WbdIwL99z/XCUDp41Jr8UxQbVv9Dkd4BFAyXr81pmKIlf8r1/ra3mp56Y
 97czNZCrEP5mOZjRe5jiTOHJF9Tj8xybSCj5DA9uXQpAZSSKFw1hgW7KJdaGoc/Mjyh7
 3wOq4203VW/pweDpUvm9ZUtNkhMfONRtMEQJ490k7RpAiZuaCA84TofRAPIWGTFJK00G
 fOAtyK5TkdHURONtD7UOjQYny9rVO7bwEnMDg0aLD0rnZDuIrxcp79wW/bZWFdacN19G
 fZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691597; x=1791296397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MRyJgwnKHEK2bXHpc2ps6Aq24aeCIjsnKBaaMCnXjoc=;
 b=uGFET8Hw8zfO5UhYuKIPEYqssI8km5KodR9lAJLtQcRiwKUpLwxuSGjV1ciFiYxFDD
 BDGpWkMQ92lBUF2bY4cpG+gESVh3xMw5VpQubB2e26WesgGBMnO0Cb6yJ1Tv3LT1BjVb
 BBdxA6nKTCdHBqFwcHcP0lWoSNA1RzoEwhV/J+GWAuHaOW9dvCpErUbu39w5e2URUduQ
 oE1w6hrrZ5WFfnwC3WFVUXRd200SPmDbNT7wspslHZn+nIREbZGOgQlKs5RoD50BKt1e
 /EhlLxckaLbqpcbKQUl4cKLaHsT8tkafcB4HOoOMSULwht4LwRVADtahySA4v5kKc0PU
 mUTA==
X-Gm-Message-State: AFuF++nbVgVdZmqyCYmZIZMmbAuQqvZcKMI6VFZV14LM37ZvijF+hOV9
 9NFIidx7/erbKW00tBPtXzkPo+rd/oSBsLYSGnH+SrywKV94tgZzfLHKgh3QSFTNLP4Bam7tySt
 B9B+4o5a47QvxusME6WlPdkQRgYsemvsBHCvBnkVfMBjyaenAs8mnOzEt5wLLHXC0tTxDhR7QdL
 MwVxlEFV/cpN1MLY93t+oLLS2YCzvBMCI=
X-Gm-Gg: AYBFou1J3o0DOe62Vv3e6nr9T8yk03iWnfFo/i4M6PfrXgU17kdLK6I9CzBo4XI0aoh
 sjegCM3JfUmi8s42Z8/GNkEa/26Uuh8lehvHMcOp/kZHWTubY4z6kupZk1QZQhsRI4NYcbVloHF
 gao77ABqp4VzWBWezmfegY53zMEWZilRyk8AGsy10mIXEhQ4jVTKO3fnAPE90i2jyNaUujeV13N
 ag/rJTYC2ebm00=
X-Received: by 2002:a05:690e:d52:b0:674:153e:c7c7 with SMTP id
 956f58d0204a3-67560c33bbcmr1014711d50.39.1790691597161; 
 Tue, 29 Sep 2026 07:19:57 -0700 (PDT)
X-Received: by 2002:a05:690e:d52:b0:674:153e:c7c7 with SMTP id
 956f58d0204a3-67560c33bbcmr1014684d50.39.1790691596576; Tue, 29 Sep 2026
 07:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-10-jsnow@redhat.com>
 <87v77ow6et.fsf@pond.sub.org>
In-Reply-To: <87v77ow6et.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:19:45 -0400
X-Gm-Features: AclHuK8cz9EFuUdPKWfi_CgbsXirmOhNaEK4shU35iTvSFO7p-r14UbPlqNFtrY
Message-ID: <CAFn=p-Z_uyj_JHyXfPqq-7QGqzsjrDj6=_ObBG4S5U62CQu03Q@mail.gmail.com>
Subject: Re: [PATCH 09/14] qapi/parser: remove _insert_after_intro() helper
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
Content-Type: multipart/alternative; boundary="00000000000084807a065c9fe03e"
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

--00000000000084807a065c9fe03e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 9:09=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > I promised I'd remove this.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 49 ++++++------------------------------------
> >  1 file changed, 7 insertions(+), 42 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index c14bff2cbc3..5fc9c18c81d 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -862,49 +862,15 @@ def _insert_near_kind(
> >                  return True
> >          return False
> >
> > -    def _insert_after_intro(
> > -        self,
> > -        section: 'QAPIDoc.Section',
> > -    ) -> None:
> > -        """
> > -        Insert a section immediately after the intro section.
> > -
> > -        While we convert DETAILS sections to INTRO sections, all
> > -        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
> > -        section list are treated as "the intro".
> > -
> > -        Once INTRO conversion is complete, this helper will no longer =
be
> > -        needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
> > -        be sufficient.
> > -        """
> > -        first =3D self.all_sections[0]
> > -        if first.text and first.kind =3D=3D QAPIDoc.Kind.INTRO:
> > -            # First section is introduction and is non-empty: insert
> here.
> > -            # Rest assured all of this ugliness will very soon go away=
.
> > -            # Pinkie-swear.
> > -            self.all_sections.insert(1, section)
> > -            return
> > -
> > -        index =3D 0
> > -        for index, ref_section in enumerate(self.all_sections):
> > -            if ref_section.kind.name in ("INTRO", "DETAILS"):
> > -                continue
> > -            break
> > -        else:
> > -            index +=3D 1
> > -
> > -        self.all_sections.insert(index, section)
> > -
> >      def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
> > -
> >          """
> >          Append a stub section after any Member sections.
> >          """
> >          if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
> >              return
> >
> > -        # No MEMBER sections present. Insert after INTRO/DETAILS
> sections.
> > -        self._insert_after_intro(stub)
> > +        # No MEMBER sections present. Insert after INTRO section.
> > +        self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=3DTrue)
>
> There can only be one INTRO section, and it must be first.  So this must
> be equivalent to
>
>            self.all_sections.(1, stub)
>
> Correct?
>
> The argument for using the more complex ._insert_near_kind() is of
> course symmetry with the other case.  Okay.
>

Yep, largely symmetry and opting to not write new logic as much as I can
get away with in this patch. There's a compelling reason for not wasting
much time writing new, cleaner logic...


> We have three ._insert_near_kind() calls:
>
>         if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
>
>         self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=3DTrue)
>
>         if any(self._insert_near_kind(kind, stub, after) for kind, after
> in (
>                 [...]
>         )):
>
> None of them omit the optional last argument.  Two pass it positionally,
> one as a keyword argument.  Let's dumb this down to mandatory argument.
>

I'll do you one better, that entire method goes away by the end of this
series and we don't have to worry about it.

No sense putting lipstick on the pig enroute to the slaughterhouse.


> >
> >      def connect_member(self, member: 'QAPISchemaMember') -> None:
> >          if member.name not in self._args:
> > @@ -932,10 +898,10 @@ def connect_feature(self, feature:
> 'QAPISchemaFeature') -> None:
> >      def ensure_returns(self, info: QAPISourceInfo) -> None:
> >          # This is more complicated than it ought to be.  The doc
> >          # parser should already know where a generated RETURNS section
> > -        # should go.  It currently doesn't, mostly because it accepts
> > -        # tagged sections in any order.
> > +        # should go.  It currently doesn't.
> >          #
> > -        # TODO: Tighten doc syntax and simplify.
> > +        # TODO: Take advantage of the new strict section ordering and
> > +        # simplify this algorithm.
> >
> >          if any(s.kind =3D=3D QAPIDoc.Kind.RETURNS for s in
> self.all_sections):
> >              return
> > @@ -950,12 +916,11 @@ def ensure_returns(self, info: QAPISourceInfo) ->
> None:
> >                  (QAPIDoc.Kind.ERRORS, False),
> >                  # 3. Elif features, right *before* those.
> >                  (QAPIDoc.Kind.FEATURE, False),
> > +                # 4. Else, right *after* the intro.
> > +                (QAPIDoc.Kind.INTRO, True),
> >          )):
> >              return
> >
> > -        # Otherwise, it should go right after the intro.
> > -        self._insert_after_intro(stub)
> > -
>
> We now have
>
>            if any(call for ...)
>                return
>            [implicit return at end of function]
>
> Please simplify to
>
>            any(call for ...)
>
> or maybe even
>
>            for ...:
>                if call:
>                    break
>
> >      def check_expr(self, expr: QAPIExpression) -> None:
> >          if 'command' in expr:
> >              if self._returns and 'returns' not in expr:
>
>

--00000000000084807a065c9fe03e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 9:09=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; I promised I&#39;d remove this.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 49 ++++++------------------------------=
------<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 42 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index c14bff2cbc3..5fc9c18c81d 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -862,49 +862,15 @@ def _insert_near_kind(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return T=
rue<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def _insert_after_intro(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section: &#39;QAPIDoc.Section&#39;,<br>
&gt; -=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 Insert a section immediately after the in=
tro section.<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 While we convert DETAILS sections to INTR=
O sections, all<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 contiguous INTRO/DETAILS sections at the =
start of a QAPIDoc<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section list are treated as &quot;the int=
ro&quot;.<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 Once INTRO conversion is complete, this h=
elper will no longer be<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 needed and ``_insert_near_kind(QAPIDoc.Ki=
nd.INTRO, ...)`` will<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 be sufficient.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 first =3D self.all_sections[0]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if first.text and first.kind =3D=3D QAPID=
oc.Kind.INTRO:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # First section is introduc=
tion and is non-empty: insert here.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Rest assured all of this =
ugliness will very soon go away.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Pinkie-swear.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.insert(1,=
 section)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D 0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for index, ref_section in enumerate(self.=
all_sections):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://ref_se=
ction.kind.name" rel=3D"noreferrer noreferrer" target=3D"_blank">ref_sectio=
n.kind.name</a> in (&quot;INTRO&quot;, &quot;DETAILS&quot;):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index +=3D 1<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.insert(index, section)<=
br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def append_member_stub(self, stub: &#39;QAPIDoc.Se=
ction&#39;) -&gt; None:<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Append a stub section after any Memb=
er sections.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._insert_near_kind(QAPIDoc.Ki=
nd.MEMBER, stub, True):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # No MEMBER sections present. Insert afte=
r INTRO/DETAILS sections.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._insert_after_intro(stub)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # No MEMBER sections present. Insert afte=
r INTRO section.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._insert_near_kind(QAPIDoc.Kind.INTRO=
, stub, after=3DTrue)<br>
<br>
There can only be one INTRO section, and it must be first.=C2=A0 So this mu=
st<br>
be equivalent to<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.all_sections.(1, stub)<br>
<br>
Correct?<br>
<br>
The argument for using the more complex ._insert_near_kind() is of<br>
course symmetry with the other case.=C2=A0 Okay.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Yep, largely symmetry and o=
pting to not write new logic as much as I can get away with in this patch. =
There&#39;s a compelling reason for not wasting much time writing new, clea=
ner logic...</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
We have three ._insert_near_kind() calls:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._insert_near_kind(QAPIDoc.Kind.MEMBER, =
stub, True):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._insert_near_kind(QAPIDoc.Kind.INTRO, stub=
, after=3DTrue)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if any(self._insert_near_kind(kind, stub, after=
) for kind, after in (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 )):<br>
<br>
None of them omit the optional last argument.=C2=A0 Two pass it positionall=
y,<br>
one as a keyword argument.=C2=A0 Let&#39;s dumb this down to mandatory argu=
ment.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I&#39;ll do you one better, that entire method goes away by the end of=
 this series and we don&#39;t have to worry about it.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">No sense putting lipstick on the pig enroute =
to the slaughterhouse.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def connect_member(self, member: &#39;QAPISchemaMe=
mber&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://member.name" re=
l=3D"noreferrer noreferrer" target=3D"_blank">member.name</a> not in self._=
args:<br>
&gt; @@ -932,10 +898,10 @@ def connect_feature(self, feature: &#39;QAPISche=
maFeature&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def ensure_returns(self, info: QAPISourceInfo) -&g=
t; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is more complicated than it o=
ught to be.=C2=A0 The doc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # parser should already know where a=
 generated RETURNS section<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # should go.=C2=A0 It currently doesn&#39=
;t, mostly because it accepts<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # tagged sections in any order.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # should go.=C2=A0 It currently doesn&#39=
;t.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: Tighten doc syntax and simplify.<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: Take advantage of the new strict =
section ordering and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # simplify this algorithm.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if any(s.kind =3D=3D QAPIDoc.Kind.RE=
TURNS for s in self.all_sections):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; @@ -950,12 +916,11 @@ def ensure_returns(self, info: QAPISourceInfo) -=
&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (QAPIDoc=
.Kind.ERRORS, False),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 3. Eli=
f features, right *before* those.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (QAPIDoc=
.Kind.FEATURE, False),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 4. Else, ri=
ght *after* the intro.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (QAPIDoc.Kind=
.INTRO, True),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Otherwise, it should go right after the=
 intro.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._insert_after_intro(stub)<br>
&gt; -<br>
<br>
We now have<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if any(call for ...)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[implicit return at end of functio=
n]<br>
<br>
Please simplify to<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0any(call for ...)<br>
<br>
or maybe even<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for ...:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if call:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<=
br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check_expr(self, expr: QAPIExpression) -&gt; N=
one:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;command&#39; in expr:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._returns and &=
#39;returns&#39; not in expr:<br>
<br>
</blockquote></div></div></div>

--00000000000084807a065c9fe03e--


