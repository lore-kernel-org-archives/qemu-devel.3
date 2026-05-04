Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253CCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJy3x-0004T2-K2; Mon, 04 May 2026 14:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJy3p-0004RC-Eh
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJy3n-0003VD-8T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777919425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8y7HmG+cmF1c8RHDJAONtqFT3pnAhd5skUVrkMgctQ=;
 b=EhgGK4Ug7pXoo7PFDs9RBYaMH/tYPmAOVL5B1KDFo4tJjACfQLqCUJUe/0ZSefTv8fblGD
 f0Z3NT4jBbN7lzw/PwUVhSH8CFX+9N2vDMl3E4IhOjp6LSjsWo5k2iz1imbFmYhEEaA83r
 W20iHILzchgHX6XARw1+NUFKBUoekl4=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ouefQpFtNj-0ZDaPSTuXPA-1; Mon, 04 May 2026 14:30:23 -0400
X-MC-Unique: ouefQpFtNj-0ZDaPSTuXPA-1
X-Mimecast-MFC-AGG-ID: ouefQpFtNj-0ZDaPSTuXPA_1777919422
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-649deef077eso6654699d50.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777919422; cv=none;
 d=google.com; s=arc-20240605;
 b=T4rfBbdbLmhU1/YIyvC/ZedeZWwU3IhvHlpEWar5zxKzfM3ktIP0IBLqoh/PCMJw91
 Vgp+KrX5y9lkw45qbeSKwZhO2r4ap8rNuonG7CcMu0AOzBPxeXDdaxNzEt90bEQKMgme
 X1KJG9h5j1eeXNGwHUqbTYjbob/9esHiTwyRela9j8pgrHVSLHKSGemwV1O+a9kOzdy1
 aMtVcb2urzBQJDV2WxRIcg+VTOfAYhmUgeqAVPABdMxh9VugXE3RcPnD7CYg6gmBJfrK
 AXgUAY6fC0SJepSyeZUxDdv0FGEIKyss1sHmk8Njad4po5ldoIItPohuO2OlZV+63N3H
 dydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y8y7HmG+cmF1c8RHDJAONtqFT3pnAhd5skUVrkMgctQ=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=fsCEgorePqE6xT4He9lxcyMX4az5uCUyQpe6GuB0yt5gmvJwq4cDod9zjymw3XIRoA
 6RqpUJPez5JPTjm2+ynMGVyKlzt8GkJNcXp+rfELz4iUFoEgPVWjP2W/6I2zLYX/2HL3
 Mrp5klBIz4m8P1BQTOcuxpVR9Oot7GFMy0HPagiAF6KLRbtFeyWGGRmw4g9Q6VbL6Y2y
 DDjCIH3c39QiFFZzq6g5stp/M1JIaNOFpR5rMNa4a8s0O2KxhgzIE0ZFzyCnldcNmy2O
 jMwdm9NiF7eWOlR4srXQfdHhtJGJnESTr/aCfqLPl4G6fiCRDFGTgTVGFlr7jPeT5G2p
 aorw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777919422; x=1778524222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8y7HmG+cmF1c8RHDJAONtqFT3pnAhd5skUVrkMgctQ=;
 b=ACN738t7JPVX9nRVi7+NHHvAdEpHu++sF4wrZTqdi79Vv3sQYgq6RvQmebpU8R1k04
 fDWcduKAEiGWoVzi9BfbTbrDHDUbOEUmRZUYMR8Pp4IHhoXX9ptsHVM3l61I1PsrMDbA
 VUDAZwLWW81oqiTo5L2g60g99/Iz05WIUxhrebi7gScjC/A6m0Y5zBZDIeoiLfouapff
 8AlNOD6XHAcOvsebGmQG5hldzGqYr7KX6SiJ2gpPKnxU8PLBmXbZjvYq+OArs/Yraebb
 2OSWIGv6rKRnKrSjbShVaz52N2a+loPl6El/Z0QbnH3BMri3HCDSkYtrzhY6wA8URA6x
 Nx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777919422; x=1778524222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y8y7HmG+cmF1c8RHDJAONtqFT3pnAhd5skUVrkMgctQ=;
 b=P5ZhSEjvZPrsDItJ/rP6RPS8Jbno5PFaB6AfO8+qgep4IVVaBuJ0D/6fNYgaRlNLjj
 xobkHJmy2xSH3LBgWN9z8Vt5p0Lnez0XUTx6wbZgfTGu+uAhO9Jqvey41+dh+QhApb5b
 c6RvlwGSD8KcgK1DXo50ZrfMr71UIywRN2nEAxDimN0cuPjlN99f7hXFtkBr9HIkZE+r
 UVsER6wzr00hQVjxoHbE2/OWz9LX++ZSF7XPw1vrTPoG8qrCN+nateMp1Sch4jQFO4A6
 zBftn4Hx4+QtGke+lIEEjyXNGnWl6ZK3knhbYzS0+8agnvt4MFp3AD3FBdXPCgseXafB
 SYow==
X-Gm-Message-State: AOJu0Yzj1eFboi/paQnGYqduDj3zVAzlbGAfMeRGnzdebFinaxHhwdRz
 aVIi3rh0NZ1qj9Lwv2qB+KYQPNt+g1QQWuvyVV0WaLn+EONbZt8YAL+l8RlXkIr9UZLZjGFzlE+
 W/uV4yctKFLwRvO4NjhE4LpiQsU2RkHt2aRkvLsvBI8j9fK84UJdf2I6XxGzjvtX3e9v+Wa1GWv
 ToeKwjzWUsPLICrUSWY08ZQSP0KVzmX3o=
X-Gm-Gg: AeBDievMqn4vqTDQb20THE2QfVJ0AHu/rBrj0rDlBG2Vin2tl1JOJalgrKcPkoIW3aR
 09KzCqXaKzNHz8VktQA96XTH55PmL4ONJlTIA1XV0/2pTiLcw8/hErkwkcfYL1Uoc/YoTGagO6Y
 4ZyYiSIR7nGqLgFZRTHhJTd7Z73AV0Nrdcqy42leR6R/tGfAeWRrqzkpJ8oPoUt+S3Bcw87ToUq
 0LZmWUg2/f749LJ7CAE1UEuJQTp9iBsMQjv/+h0Ed2yQBC0
X-Received: by 2002:a53:d016:0:b0:65c:654d:3d1b with SMTP id
 956f58d0204a3-65c654d5789mr1521237d50.50.1777919422112; 
 Mon, 04 May 2026 11:30:22 -0700 (PDT)
X-Received: by 2002:a53:d016:0:b0:65c:654d:3d1b with SMTP id
 956f58d0204a3-65c654d5789mr1521206d50.50.1777919421649; Mon, 04 May 2026
 11:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-6-jsnow@redhat.com>
 <87o6iva0a7.fsf@pond.sub.org>
In-Reply-To: <87o6iva0a7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 4 May 2026 14:30:10 -0400
X-Gm-Features: AVHnY4JOXROHIWUFdI-8wK5VbeT8L6rIfZ98upNVYxCelrq5BJNhJ_VqhxoZOPE
Message-ID: <CAFn=p-btJTG9NPzRi3ai+Ac1v1bMqeiYX0HZKKGGX8m3wo+cUg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] qapi/docs: adjust stub member insertion algorithm
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
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, May 4, 2026 at 7:20=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> I'm feeling dense again.  Please be patient with me.

It's okay, this is a complex one. This is part of the reason for
pursuing strict ordering to begin with: the insertion algorithm is
complex and ugly.

>
> John Snow <jsnow@redhat.com> writes:
>
> > A forthcoming patch removes the implicit PLAIN section that always
> > starts a QAPIDoc section list. Further future changes begin converting
> > "PLAIN" sections to "INTRO" sections. To accommodate this, the insertio=
n
> > algorithm that places stub and dummy members must be adjusted to cope.
>
> What are the stub and dummy members?

"stub" - undocumented members.
"dummy" - placeholder section named q_dummy that causes "The members
of ..." references to be printed in the rendered documentation.

>
> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at the
> > beginning of a QAPIDoc object.
>
> The revised algorithm, I presume.
>
> What's the structure of its valid input before and after this patch?

Before: Plain EverythingElse?
After: (Plain* | Intro*) EverythingElse?

Where EverythingElse may never start with "Intro", and may contain
"Plain" but not as the first token when following a Plain section from
the prior production. (Because contiguous plain sections are merged by
the parser into one section.)

This is to allow a gradual conversion. Once everything is fully
converted, and especially after "details" is introduced and the strict
ordering is enforced, this is tightened down considerably to: Intro?
EverythingElse?

where EverythingElse may no longer contain Plain (It is removed), may
never contain Intro, and may only contain one Details section in the
appropriate position (Near the end, before Since.)

More or less: this patch removes the assumption that every QAPIDoc
starts with exactly one Plain section and allows it to cope with any
number of Intro/Plain sections at the beginning, but makes no change
to what the parser actually produces or accepts. In effect, we go
from:

Plain EverythingElse

to, in the next patch:

Plain? EverythingElse

then as the conversion continues, one of these two:

Intro Plain? EverythingElse? (Without converted intro)
Intro EverythingElse? (With converted intro)

... This entire insertion algorithm gets to be removed once we enforce
strict ordering, because we can insert directly to the correct
position in the list thereafter. So, it is only a temporary complexity
that exists for the sake of gradual conversion and piecemeal list
review of each QAPI module.

>
> > Since we have three places that need to insert stub members, take the
> > opportunity to unify and deduplicate this code.
>
> Three?  I can only see two: Transmogrifier.visit_sections() and
> QAPIDoc.connect_member().

Bad wording on my part again. ensure_returns also inserts stub
*sections*, not "members", sorry.

>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 36 ++++++++---------
> >  scripts/qapi/parser.py | 90 +++++++++++++++++++++++++++---------------
> >  2 files changed, 75 insertions(+), 51 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 1f7c15b7075..70ab9cdc214 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -349,30 +349,32 @@ def _get_target(
> >                  )
> >
> >      def visit_sections(self, ent: QAPISchemaDefinition) -> None:
> > +        # Generate a placeholder right after the member section(s) whi=
ch
> > +        # will be used to generate documentation for "The members of..=
."
> > +        # pointers in the rendered document.
> > +        # This is a temporary hack until the inliner is merged.
> > +        if ent.doc:
> > +            ent.doc.append_member_stub(
> > +                QAPIDoc.ArgSection(
> > +                    ent.doc.info, QAPIDoc.Kind.MEMBER, "q_dummy"
> > +                )
> > +            )
> > +
>
> This hack is of the nastier sort: passing a QAPISchema to the doc
> generator modifies it.
>
> Would it be possible to add this dummy always in QAPISchema?  Any
> drawbacks?

Well...

I didn't like the idea of generating "q_dummy" stubs inside the
parser, as it is an implementation detail of qapidoc. Though as you
note, this leaks it back out anyway.

Here's my argument: the entire "q_dummy" thing goes away with the
inliner anyway, which is what I am actively working towards, and this
ugliness goes away entirely either way: we do not need q_dummy, we do
not need member pointer stubs, we will not need to modify the caller's
section list.

I found this easier to do, despite the ugliness. Also consider that in
this case, we are building an isolated schema directly inside of the
Sphinx process anyway, so we are spiritually already "modifying our
own copy" - i.e. there's no chance that this stuff leaks out into
other users of the Schema. I think that's actually quite appropriate
and unlikely to cause unintended consequences.

>
> [Remainder left for later...]
>


