Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA797C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QcF-0005SP-2U; Wed, 23 Sep 2026 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qbb-0004yA-0h
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9QbY-00027o-T2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790183878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnVGbdJFRNsIzpT51J8U87RxPVZBnAnsPpNNjUAZhOg=;
 b=Aj7MS23Bt2Pqp/G4Uw0la95N2UVi3tdEwBmrK20C4ht168zBwnbbPEPKL/KPJ7b5fcDoXX
 PxvDpM3Np2wncttzxu7PvvQR9wxXnoIYKNooMvBDzQMtkfJE/WS2GP1Ch36PGvtTToOkXv
 EKO/RU6LGJaISppXHBKZ+GGoqNMoX8Q=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-L5AkOdWmMBOKsxEOsyriAg-1; Wed, 23 Sep 2026 13:17:57 -0400
X-MC-Unique: L5AkOdWmMBOKsxEOsyriAg-1
X-Mimecast-MFC-AGG-ID: L5AkOdWmMBOKsxEOsyriAg_1790183877
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6711a336db0so1517826d50.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790183877; cv=none;
 d=google.com; s=arc-20260327;
 b=SkzhVWps4heumZrt//0WJjlv+cEJxMTI3I+okqyTK6wZNMUfqf0mbDLBosWq4uSYYO
 naNqt9yPVhSn3LgjojjvzhUWaQapbbdDewRnbsPqrQ7j9qqrmegvAoyrQfZxqXlTNEj1
 6iYgTFyJCmmiwh0ltkFSQyzApATKEGN87c8iAQHfYVFCMN4Gl7YexOer+JzMl+FOy4UK
 jycYSWB30ZX8vpXOUI9xw0VcpGbDhSr1uOu89h6A6/SMpG9+OLs2PjgMcpmcHRmPGG5j
 GSVWSiIgAiIg/JUPWB17OF6p/p4FV4OGVQHPvdiziolVZwyEqcU3xltxRAVCT51ZFWi0
 jA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NnVGbdJFRNsIzpT51J8U87RxPVZBnAnsPpNNjUAZhOg=;
 fh=nv4lR2rH1aVW77dMNATQm0dxGI+JibghZG8DLCFB2GM=;
 b=Xs/fD6JG7w9UdtNXGA+SeHmVLOybro6Gx3LLxibp+kmPcZpS24PoQV+oSl3lcWfnE6
 kNiDy9d0kzOPo/tiHPhoZTHyxLQ5nO9uGq72n+hetqFfR1IJ16wVTphuC+IGfLCHJSbF
 wrpLCChXQqawndSZ33TYOuECjwT00s4pHf8U/UephF12NnazXu2vy8TOpa3gmVKmS+MA
 cZziznNG3eT0Q4h005j9hr2F7vD9TEWnOqet27VyQ+xpE8JMLhRM6+ClMnU0BXXO8/Xi
 dly3tcwKyure+jWlw0l8cdLZMLCbjpbH+P2R4zcRbDtSfEfvjpgQU7JU6BL7aO9I48Eh
 d9HQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790183877; x=1790788677; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NnVGbdJFRNsIzpT51J8U87RxPVZBnAnsPpNNjUAZhOg=;
 b=O8I8caTX8VqRUlxmywTwT58MwyBs13OJM2zSAWqCsYgoyFp3CvMSuroFcfdt09owrm
 1vu7qIbKix7StoaT5W4KcIQNRhS5G8ZVebXaYtCTSUe3yE0dtV0AEjy8B86ueTHKeI03
 zpIeML6r1KgU4S/VWVV0+zlSVUTFYmjvpDDf02MzUKXTo/h84EHqw6Rxz4UExBKA9Xhq
 ANrzEjAUj7KSZvDFB65KnaWKJWTQ1fjT7TtCWKbTRBDnbV4Of1OQw9PH4XysSXcZFvlQ
 sIaEouJqheF9CHxfhMgnT+YOJr5QbUmcsbQeIuBJkhvxUllLdYAk3IGuYUqjowFiwA30
 PeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183877; x=1790788677;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NnVGbdJFRNsIzpT51J8U87RxPVZBnAnsPpNNjUAZhOg=;
 b=sHZbc0s7Pvk1z3At7yiaUdaspMeAfMkt9uIyVZypz4G0v99UF8u/OFgDMhGhM8NST0
 2lNjR9O6dhl/Qe0GeAkwFubhTkzL5b1PbYFdjBlSna04gnojjTLw4Jd7icxbegJgTTEO
 2SRqSxLJA/q4XzM9yWhTdqQslJCEzH+EIA/gCOHNv+dbutwE6c49AgHTmeqkIcecu49i
 lSfg16MSkjvM/7qixuqFm17McYNl4Wbivlxj9z9pOIhsPVrsQH8P53n+pK1TKt35bO/A
 x4uq6oeJxKz98cIPla8YBNdAKKhdF7q4al0727fg6/GZ6ckkSK+Ey85uYMG5zI8D2801
 1+5w==
X-Gm-Message-State: AFuF++lAbonzKlAmujFyRwiJi00CTs3He1qgYrs76EBQgScq6Tle9JPT
 lgtTKd8oBvao2izripXa1z5GBtyriGNWz0nBwWk77zwyxPh7q9ysnaL+HEkk1IolzC5Xi0yb3Xc
 hKUYY0W3ZmvtHxX9OnD+tGfrM/urJFdoEGda7Ng0+s2i2Z4xAsg4PlsH21Ewq6O/TH6/ozsuo1D
 2iP+n7yDqU5MeoT5nB7sd3ILuFcpqNZ/E=
X-Gm-Gg: AYBFou0cmqz5IKOmOO3C+MRdZ1ywTUljnEiXugPhXfoOEX1LINtPQg5wfV7tSAXju3k
 nTUumUP1BDCJ2uYHSWbtLp7HMp4B4TpQys86ar4Mh7hWyZ4KD4LMN0qf3JLGEr1pZOp63r3zidn
 xKvQZRkErp5EykUwou4lMDqUgb3JzXcN7OgJJmsM4KU10yViNgvuc2CNq2/Ri0mo9ZB1qDG/V6A
 OLi0M0OKtsaxVst
X-Received: by 2002:a53:d88c:0:b0:671:3b1b:997d with SMTP id
 956f58d0204a3-672d591ad75mr1362647d50.88.1790183876742; 
 Wed, 23 Sep 2026 10:17:56 -0700 (PDT)
X-Received: by 2002:a53:d88c:0:b0:671:3b1b:997d with SMTP id
 956f58d0204a3-672d591ad75mr1362615d50.88.1790183876201; Wed, 23 Sep 2026
 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260922205605.501602-1-jsnow@redhat.com>
 <20260922205605.501602-3-jsnow@redhat.com>
 <87ld8szejb.fsf@pond.sub.org>
In-Reply-To: <87ld8szejb.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 13:17:45 -0400
X-Gm-Features: AcwNN1WDT9Q9xOW5TYsqq5_ZiWp72fYt1__M5_1gmx4Yldz5hvx04PYHYAKMq3Q
Message-ID: <CAFn=p-ZKVsdkNbuxqnzhqUn4vSkJw1J9QqMB13LdjoMPYo9PJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] qapi: convert intro sections for unit tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Wed, Sep 23, 2026 at 2:07=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qapi-schema/doc-good.json                |  8 ++++----
> >  tests/qapi-schema/doc-good.out                 | 15 ++++++---------
> >  tests/qapi-schema/doc-interleaved-section.err  |  2 +-
> >  tests/qapi-schema/doc-interleaved-section.json |  3 +--
> >  4 files changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-go=
od.json
> > index fac13425b72..d9a84ccd729 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -94,10 +94,9 @@
> >
> >  ##
> >  # @Variant1:
> > +#     A paragraph
> >  #
> > -# A paragraph
> > -#
> > -# Another paragraph
> > +#     Another paragraph
> >  #
> >  # @var1 is undocumented
> >  #
>
> This creates a split.  doc-good.out and doc-good.txt need an update.
> You got the former and missed the latter (appended) Happy to fix up in
> my tree.

Yes, please. I think I updated the wrong file (build system copy and
not the source file) and didn't notice.

>
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
> > index 371dd25ffc7..eaaf119dea8 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -126,15 +126,13 @@ doc symbol=3DBase
> >   minimally indented
> >  doc symbol=3DVariant1
> >      Intro
> > +    A paragraph
> >
> > -    Plain
> > -A paragraph
> > -
> > -Another paragraph
> > -
> > -@var1 is undocumented
> > +    Another paragraph
> >      Member=3Dvar1
> >
> > +    Plain
> > +@var1 is undocumented
> >      Feature=3Dvariant1-feat
> >  a feature
> >      Feature=3Dmember-feat
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
> diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.=
txt
> index 74b73681d3..ba089a7f94 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -65,11 +65,11 @@ Object Variant1
>
>     Another paragraph
>
> -   "var1" is undocumented
> -
>     Members:
>        * **var1** ("string") -- Not documented
>
> +   "var1" is undocumented
> +
>     Features:
>        * **variant1-feat** -- a feature
>
>


