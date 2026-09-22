Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D992C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94JH-0005G6-61; Tue, 22 Sep 2026 13:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94J9-0005Ah-F7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94J5-0006Ma-Cc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790098166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZkmkyZLtQRZlbDdg5kxl0/7JqUe3aN6Dowu+4nYfRo=;
 b=bx1C5XVSEDGaHVaTef0fCjRLmFam2MVb5aSLiXDCyM6sf/sEvsYlw5JH2Xa4xDlP//AFiV
 IrTNovKAW4x1yZ9NQP9NrmIhrQcskijXBw5W4/c1p9OCBMlBCJzcirBY8oBWAx+NAVTnoB
 o7KBnsgululz8eedPEmANQuL3M+3apw=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-KMml0JBtOgCrrwEcbVXZjA-1; Tue, 22 Sep 2026 13:29:25 -0400
X-MC-Unique: KMml0JBtOgCrrwEcbVXZjA-1
X-Mimecast-MFC-AGG-ID: KMml0JBtOgCrrwEcbVXZjA_1790098164
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6714db09f55so70737d50.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790098164; cv=none;
 d=google.com; s=arc-20260327;
 b=aDe/EeOvOs0oX476vaeAjvVXFFzn13bQdloO76F+qDGFIDPUYz1gmkTFEwuPcwsTQx
 fAF/vGO2DlzQ4boSmW4THpBaN51tXVhVQvrwUGTmo7VVVbOcUG5OheoJarpbsHx52bio
 x9BieEN3S47UByOTFuSuLW2e8xQ2RNQqev2nFO9lN80t16v+/codlL/8epOfA6thnNpl
 P+xrDo8nXBh9FstzXIqJ3jKtG4Kf+6P3N0OS75XsQ20w/6a1YqS1mYKKOkDLx2zdZMSq
 JGVHojS7/HuNubmDIltSFQXZZuZ9ysDvczj2oN1RuZU6HvdTD+GLhL+N+D+2hS92Yaan
 t7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IZkmkyZLtQRZlbDdg5kxl0/7JqUe3aN6Dowu+4nYfRo=;
 fh=4SpBrKxBueTKlh2nVNOI1f4PgGJNaXa+zdI/ORe/sas=;
 b=NdXWQzKCHmRCu4si2+cU3RO9NQm1oljwx/1nQDvoS6e1iKlS1XLd/gklfyaC9NPBr3
 CYGhP9MGwEEo3Scz8DudJ5b3r/VNHLDJzJpWkbsqnCWSUypGwERxXs6ltc0maePxh8cB
 MtxFHN+Yqi4sSWH/QvO4TEoMSH60J6k1HvYDHzHCdYDV9Mo0YA+Poct4yHm4B1TJ0XdI
 bfQXKQKMC0jFBcoP2xHZOnbtVeq1ad91gqfHewpcjnwRNNLe1mfXXSlojBKNvYbotrVV
 6hqLGaB54EStc+7E7VdGt4LItRxA+o69V2fHZesMBIyPWeEVKEZgRmvf7+YBp9w0iiAt
 5frQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790098164; x=1790702964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IZkmkyZLtQRZlbDdg5kxl0/7JqUe3aN6Dowu+4nYfRo=;
 b=bv7QIlMZ5f8Rp1zNa1bmME9SV1HXbDuYz6fHVNanXWkWVKVx1G1zWozyJLHu19SpCF
 tkMZlm21Y8Phc997vzChEXOCoGXJMRpFfBpUKinxj9ZmSrfYKbTLOQGf4Ac/kP7zVTzL
 RR39lG8TgSpuoQYs8x/RphsmFa6LpPVmip083hds427mjIakgB0kCaHZ9qgzu3vuNebB
 FkelYmwhceaV+O/Ox6y/KIrr5NPPwh2w8M21pBndwXWpxvRZTVi1OTJm/teamZGN1pie
 aR/8GyqA6kMNvbHSRJnaTaDpI8DS+v8VIp4gKDON+Zl9TwnMh8tvkdBWhXqxu2/3ZZ0B
 Zqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098164; x=1790702964;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IZkmkyZLtQRZlbDdg5kxl0/7JqUe3aN6Dowu+4nYfRo=;
 b=Xft+J4QPtaaFiBFI2RgLM5Ylm3YM2fV6Hi91auK8gGCdCbDuFkssKslNv6joXHEOZB
 Km0JJ452gNMbBWMfoBRAmNf9whUUaEdXRmLvxgVq+T0fVa/m0iChLHYQ88aL6YTWNXs/
 hlyEUN4O/NOiQiE9lj+zYvSmdtWgxWC4kS/7fRm6hCYqgEArQB+w8wyhgpBUxBeTUXYh
 o5bPs5zr54FwLhcq5HMweZorKHlsx3ctn741+/+GJiZoPLGgiFA31vVpHKvYq/Bed3RR
 X8yKFdTy0+Jtker/S/xNjrw4GrJaeErimoMNE1uf9S2xbr6EoqLOi6Q9SpPYA1y61W2f
 jJ5A==
X-Gm-Message-State: AFuF++l2fdjDCCFz1Wt0RhiNqhqD2Pdk+ivdjVoaQhsXSwwvU9rf8AGi
 pyvanayTnMHn5we/AMfPDeTeTOIozC5gfcnwzqwrjZIqz/VpMo2IWc8AAJ3mapUQNFYInI7C1AK
 JzrDtkzW/9OE4Myhu8nHKoil+A4Mb9Y2PQUbJinjXfeUDq1KxnpTMNNCWleIkI6DjlBF7WCXVoL
 hzj6UrNk17Mq/YrtC5TW9cSb8VNscQpD8=
X-Gm-Gg: AYBFou2X0zyElLivaKDna2Cr7j26Zg1siHNmdl89kFyziWHLHdZieU6JBPFp2sNvKGQ
 wELItdNS+jFg1/hHaWD89Wa0HvbTEuVS3p+Jykn1TMnwIEcOltdY8l5RqDk1h1Io52wkUP/hJmq
 NFEiD+oiZkYg8Y/Cvc8cnrgY3a1mBwbZx81uCsyuxyqxZFIm+1G9cdWAq294dAUSyjHiRAvlVb2
 4d7HUuLUUMAz6BT
X-Received: by 2002:a05:690e:4507:20b0:671:54f1:b92a with SMTP id
 956f58d0204a3-672d574c0a5mr113528d50.29.1790098164362; 
 Tue, 22 Sep 2026 10:29:24 -0700 (PDT)
X-Received: by 2002:a05:690e:4507:20b0:671:54f1:b92a with SMTP id
 956f58d0204a3-672d574c0a5mr113517d50.29.1790098163925; Tue, 22 Sep 2026
 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-3-jsnow@redhat.com>
 <87a4p92p3k.fsf@pond.sub.org>
In-Reply-To: <87a4p92p3k.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 13:29:12 -0400
X-Gm-Features: AcwNN1Wiej_-uzE2D_vQBun2VWaKSLsrzpoAyOm58lRnA9ICEqhMf263Bw9m4AY
Message-ID: <CAFn=p-Z1gTHSk1=G_eU=MRCT93j7kpcnub=O2o1vXL95kD9B=g@mail.gmail.com>
Subject: Re: [PATCH 2/9] qapi: convert intro sections for unit tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 22, 2026 at 1:06=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qapi-schema/doc-good.json                | 10 +++++-----
> >  tests/qapi-schema/doc-good.out                 | 13 +++++--------
> >  tests/qapi-schema/doc-interleaved-section.err  |  2 +-
> >  tests/qapi-schema/doc-interleaved-section.json |  3 +--
> >  4 files changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-go=
od.json
> > index fac13425b72..00721d5c522 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -94,12 +94,11 @@
> >
> >  ##
> >  # @Variant1:
> > +#     A paragraph
> >  #
> > -# A paragraph
> > +#     Another paragraph
> >  #
> > -# Another paragraph
> > -#
> > -# @var1 is undocumented
> > +#     @var1 is undocumented
>
> Let's keep '@var1 is undocumented' plain.  That way, it stays close to
> "author forgot the colon after the member name", which I find useful.

OK, but it will very soon be disallowed in that position; it will have
to be moved below Features et al, eventually. Making this change, but
heads up that it necessitates another patch in the order enforcement
series.

>
> >  #
> >  # Features:
> >  # @variant1-feat: a feature
> > @@ -206,7 +205,8 @@
> >
> >  ##
> >  # @cmd-boxed:
> > -# If you're bored enough to read this, go see a video of boxed cats
> > +#     If you're bored enough to read this, go see a video of boxed
> > +#     cats
> >  #
> >  # Features:
> >  # @cmd-feat1: a feature
> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
> > index 371dd25ffc7..8c0818a3f0d 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -126,13 +126,11 @@ doc symbol=3DBase
> >   minimally indented
> >  doc symbol=3DVariant1
> >      Intro
> > +    A paragraph
> >
> > -    Plain
> > -A paragraph
> > +    Another paragraph
> >
> > -Another paragraph
> > -
> > -@var1 is undocumented
> > +    @var1 is undocumented
> >      Member=3Dvar1
> >
> >      Feature=3Dvariant1-feat
> > @@ -213,9 +211,8 @@ Note::
> >  2.10
> >  doc symbol=3Dcmd-boxed
> >      Intro
> > -
> > -    Plain
> > -If you're bored enough to read this, go see a video of boxed cats
> > +    If you're bored enough to read this, go see a video of boxed
> > +    cats
> >      Feature=3Dcmd-feat1
> >  a feature
> >      Feature=3Dcmd-feat2
>
> I'm mildly surprised that the intro's indentation isn't stripped.  Maybe
> we discussed that already, and I forgot.  Anyway, it works, and changing
> it is way out of scope right now.

*searching resident databanks*

I think I was striving for minimal processing of the text prior to
handoff to sphinx for reasons of preserving accurate source
information.

qapidoc.py has this code:
```
    def visit_plaintext(self, section: QAPIDoc.Section) -> None:
        # Squelch empty paragraphs.
        if not section.text:
            return

        # Intro sections, which are indented in QAPI source, need to
        # be dedented to avoid accidental block quotes in ReST syntax.
        dedent =3D bool(section.kind =3D=3D QAPIDoc.Kind.INTRO)
        self.ensure_blank_line()
        self.add_lines(section.text, section.info, dedent)
        self.ensure_blank_line()
```

As a result, the unit test plaintext versions retain that indentation.
This actually matches how we treat indentation for member text, which
is also preserved and represented in the plaintext test output!

Granted, now that I have excised the backwards compatibility demon
from qapidoc, it is possible we can conduct another audit on source
information preservation and some things might be able to be
simplified, but I think this is fine and good for now.

>
> > diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi=
-schema/doc-interleaved-section.err
> > index e5d1ef54c1b..85f01fa57a7 100644
> > --- a/tests/qapi-schema/doc-interleaved-section.err
> > +++ b/tests/qapi-schema/doc-interleaved-section.err
> > @@ -1 +1 @@
> > -doc-interleaved-section.json:15:1: description of '@foobar:' follows a=
 section
> > +doc-interleaved-section.json:14:1: description of '@foobar:' follows a=
 section
> > diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qap=
i-schema/doc-interleaved-section.json
> > index eec01ed5650..bc0937b8601 100644
> > --- a/tests/qapi-schema/doc-interleaved-section.json
> > +++ b/tests/qapi-schema/doc-interleaved-section.json
> > @@ -2,8 +2,7 @@
> >
> >  ##
> >  # @TestStruct:
> > -#
> > -# body
> > +#     body
> >  #
> >  # @integer: foo
> >  #           blah
>


