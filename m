Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BDDFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxVu-00076M-Dx; Mon, 04 May 2026 13:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJxVr-000763-Hg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJxVo-0002B1-HR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777917317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTaRhNxQeZRVfgFeaX9elyZLC4F3pLE9lQgm4YZfaSk=;
 b=dOgQ+IFWD0GGomGGjxdKKjOG/AWKPB6NQQ4sjusXC4zRLB62YU0Av7OyIuZnocs/A5vjhR
 xrTGlJsquMcm8yAx4RU0qLVGB4qO1xsJbOqZ+6BMi9DFPEnYd94o5KNznY9WDhoMthHxVp
 lvXEE4dDS3icZp1YL6Se/6Lp0uLNSdc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-CfUKY3h0NMKCY6rOM14jfQ-1; Mon, 04 May 2026 13:55:16 -0400
X-MC-Unique: CfUKY3h0NMKCY6rOM14jfQ-1
X-Mimecast-MFC-AGG-ID: CfUKY3h0NMKCY6rOM14jfQ_1777917316
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7bd5c582c4bso101625787b3.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777917316; cv=none;
 d=google.com; s=arc-20240605;
 b=fa1iqbHlM+p6HgEKXpjkHW249hXXxpX7q8D49Vlw5XytkoFccfcCL4wBNOgWpUe0Aw
 6/ebsckbZIeZSQoYOi3C/kzU6yZ56HrkafgRdfGsxVdJPBQZFqLjxV50bvH225vFpUwI
 H6QIr/+3n++96BrvKMQ7U5TJNqC+GDF9frhtjltzoBmVZTwNyB7WiUAEIMp8VIidP9se
 cc/GHVQe37YVryPxcmNHwk2yHpleCC0sptifCi/g9N3VGeQNpRnLF5rb8KRHOlcF6uNk
 7pQAAyorcZIjZtAM4XFwPN9awRlZ1hZ7Jk6BWYUnQnFk/JqLDBZyqBsG0CfNgCMKuDGq
 acDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PTaRhNxQeZRVfgFeaX9elyZLC4F3pLE9lQgm4YZfaSk=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=TOadNTg1qRk+Gca1lD8p/WaPR8djsnyn2j9aRAMd/KjTRC8BcyTWmr1kWBSQh/n0Pf
 VvHtZMl3RxhJosgBoIuUrCHsnvgiboukSx1+10JpQ7dR1SrjN4P4AJprCCuwdvSAwyFx
 BGxvMEg9TD9yTs6FAI1JORtXUqubvr2/42tOwwT7W7mQ1RySsbVKvNt5T6LryNa+Djpw
 LrOgejIqsttdnDc0cXXhihq0asniKwv3yxPJwbOHtIpS5xCiWJFAL5CjI8Vd17WYu92C
 zeVzXkXZ8NINZNVmVrQ3PmtFFbG8Kph93TrtkV2UlLGbJRbWLYjN2ggLFYXmAyFbURSr
 YNuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777917316; x=1778522116; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTaRhNxQeZRVfgFeaX9elyZLC4F3pLE9lQgm4YZfaSk=;
 b=EFnl770fOEbP7+cf9HAPy4DWUrltTKS4jbW3cUnL1wmNZmiFQVe7iuE25kzca2CKdo
 pDxO808F1eGJga6WYGqtyX7aTByox/q4kXyYNhKQImpe+HyIbES8OTDSBey1SrY3ndgz
 7cMv+O+xIYsic82OGGuKK3fzTFQJIAnhutN7MTJQCoaL9xlwj1ioUSoyPGWh6pVDZIux
 Q6hbbUoi4EQzgfNboUBl+jYU05Eag5jPDyWpsEiun8/ouCicEKIYO1L3fJO0Q6VoSsL9
 L7O8lVuzTgL8SSWfKLIKlWbYhNIwfKGqR1tK1ewmOAm2F/RYK4zFwxjGgpshq77NxtEq
 Letw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777917316; x=1778522116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PTaRhNxQeZRVfgFeaX9elyZLC4F3pLE9lQgm4YZfaSk=;
 b=TMIcypgAzPn6GWnCYtY/ELbTMj6t/PMx3a9SJWHIv8NUOSBGt0KCabfekH4TzHpTZb
 SNAvU2fo1RFTt9G49Hxzg+5/DACtnZP1rCBo+ONOC1QaPxOFjnmVGJ9mjkfryQWnXdjt
 AzqGxuaK9EHmyjmrfwCbquciOl5KWYY2HhKHrHdvEGo3iNkzaiJINFiBzKmWTqyRTeAi
 1acmqyGMD6rDIxubFKsoZh37EH+sGJUqwEuN3ZcqGm4eo6YYgG7SwmC6GBBqU83JnnEC
 chbgqHkWUe/JK+u+BAQKOsXh3bmk06cSSmP/AwrDgpZefGYmcvKjrhz+Vss5wcJgbYST
 i2pg==
X-Gm-Message-State: AOJu0Yw2yChQ4gj62VcuRXNhbkEHXI8FdA/gW6Se7sgQYXtLNuVkrlsH
 BHkEd9K64NCs0VPWSZcNmvxp1iUQpjOE0Vw0L55ccRpwkLwysTUjF7l8wROX0qq0sPYNgGTZViA
 HNn3UwxteX4geeKiI/CifEjXPdcARD2PGu24SXqRlT2krMIORnFGRDGnFwbEbM/0J78A5FeUR95
 /jK7JvHwEiN3mYnCBUoF/uWujW/G6xSHg=
X-Gm-Gg: AeBDieslhVq8N6WK1dluYXq1k6GGXmrnD4xY+IP7pTqxxta8hW+y+DeBmdsQMKPPlHf
 NpOaT7+TdxpP//BKwmzG4IHmsNTNrH2bHak/1anj79ORf37j05+9X8MSwI2TTgGGoNqvIIkJkWs
 BXWcViU5axQrBCeJiw91jo28Qim9EYtuuq1VCO1KkftDSqH9Q07967Yq1KXt15lziXFTA55WrMa
 subSUGd8YlNmFcWa6tW4fboodHdAEKSBKvsFDUvit0k3gvz
X-Received: by 2002:a05:690c:39c:b0:7bd:a4dc:c23b with SMTP id
 00721157ae682-7bda4dccb78mr17214507b3.49.1777917315667; 
 Mon, 04 May 2026 10:55:15 -0700 (PDT)
X-Received: by 2002:a05:690c:39c:b0:7bd:a4dc:c23b with SMTP id
 00721157ae682-7bda4dccb78mr17214007b3.49.1777917315048; Mon, 04 May 2026
 10:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-2-jsnow@redhat.com>
 <87lddzbj17.fsf@pond.sub.org>
In-Reply-To: <87lddzbj17.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 4 May 2026 13:55:04 -0400
X-Gm-Features: AVHnY4KijCbfO1myr0EQxOw3S8sAp6PpYOi4E3Oww_juu2Hp6sONF72FP_VjG2c
Message-ID: <CAFn=p-Y==Yf9DQs9LEgE366ujHFADFnLzMYrCjgk8RQa_N-kow@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] tests/qapi: generate output in source order
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 4, 2026 at 5:50=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Rewrite the test doc generator to produce output in source order instea=
d
> > of arbitrarily by section name.
>
> Yes, please!  Looks like leftovers from commit 8d789c8cdb8 (docs/sphinx:
> remove legacy QAPI manual generator).
> >
> > This patch removes our last use of the "body" field, which has an effec=
t
> > on how the first plaintext section of each test documented is printed:
>
> What do you mean by "test documented"?  The sentence makes sense to me
> if I drop "documented".

Thinko. Probably meant "each test documentation section" and short-circuite=
d.

>
> > we now print "section=3DPlain" followed by the section text instead of
> > "body=3D[...]".
> >
> > This patch is motivated by a desire to move the QAPIDoc API away from
> > named fields for specific sections in a bid to force all users to simpl=
y
> > iterate through all_sections in order, instead - and to remove the name=
d
> > subsections.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qapi-schema/doc-good.out | 26 +++++++++++++-------------
> >  tests/qapi-schema/test-qapi.py | 15 ++++++++-------
> >  2 files changed, 21 insertions(+), 20 deletions(-)
> >
> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
> > index 04a55072646..e2be6f96bbf 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -54,15 +54,15 @@ event EVT_BOXED Object
> >      boxed=3DTrue
> >      feature feat3
> >  doc freeform
> > -    body=3D
> > +    section=3DPlain
> >  *******
> >  Section
> >  *******
> >  doc freeform
> > -    body=3D
> > +    section=3DPlain
> >  Just text, no heading.
> >  doc freeform
> > -    body=3D
> > +    section=3DPlain
> >  Subsection
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -106,7 +106,7 @@ Examples:
> >  - *verbatim*
> >  - {braces}
> >  doc symbol=3DEnum
> > -    body=3D
> > +    section=3DPlain
> >
> >      arg=3Done
> >  The _one_ {and only}, description on the same line
> > @@ -119,13 +119,13 @@ a member feature
> >      section=3DPlain
> >  @two is undocumented
> >  doc symbol=3DBase
> > -    body=3D
> > +    section=3DPlain
> >
> >      arg=3Dbase1
> >   description starts on a new line,
> >   minimally indented
> >  doc symbol=3DVariant1
> > -    body=3D
> > +    section=3DPlain
> >  A paragraph
> >
> >  Another paragraph
> > @@ -138,15 +138,15 @@ a feature
> >      feature=3Dmember-feat
> >  a member feature
> >  doc symbol=3DVariant2
> > -    body=3D
> > +    section=3DPlain
> >
> >  doc symbol=3DObject
> > -    body=3D
> > +    section=3DPlain
> >
> >      feature=3Dunion-feat1
> >  a feature
> >  doc symbol=3DAlternate
> > -    body=3D
> > +    section=3DPlain
> >
> >      arg=3Di
> >  description starts on the same line
> > @@ -157,11 +157,11 @@ description starts on the same line
> >      feature=3Dalt-feat
> >  a feature
> >  doc freeform
> > -    body=3D
> > +    section=3DPlain
> >  Another subsection
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  doc symbol=3Dcmd
> > -    body=3D
> > +    section=3DPlain
> >
> >      arg=3Darg1
> >      description starts on a new line,
> > @@ -210,7 +210,7 @@ Note::
> >      section=3DSince
> >  2.10
> >  doc symbol=3Dcmd-boxed
> > -    body=3D
> > +    section=3DPlain
> >  If you're bored enough to read this, go see a video of boxed cats
> >      feature=3Dcmd-feat1
> >  a feature
> > @@ -223,7 +223,7 @@ another feature
> >
> >     <- ... has no title ...
> >  doc symbol=3DEVT_BOXED
> > -    body=3D
> > +    section=3DPlain
> >
> >      feature=3Dfeat3
> >  a feature
> > diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qa=
pi.py
> > index cf7fb8a6df5..27885147b4d 100755
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -19,6 +19,7 @@
> >  from io import StringIO
> >
> >  from qapi.error import QAPIError
> > +from qapi.parser import QAPIDoc
> >  from qapi.schema import QAPISchema, QAPISchemaVisitor
> >
> >
> > @@ -116,13 +117,13 @@ def test_frontend(fname):
> >              print('doc symbol=3D%s' % doc.symbol)
> >          else:
> >              print('doc freeform')
> > -        print('    body=3D\n%s' % doc.body.text)
> > -        for arg, section in doc.args.items():
> > -            print('    arg=3D%s\n%s' % (arg, section.text))
> > -        for feat, section in doc.features.items():
> > -            print('    feature=3D%s\n%s' % (feat, section.text))
> > -        for section in doc.sections:
> > -            print('    section=3D%s\n%s' % (section.kind, section.text=
))
> > +        for section in doc.all_sections:
> > +            if section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> > +                print('    arg=3D%s\n%s' % (section.name, section.text=
))
> > +            elif section.kind =3D=3D QAPIDoc.Kind.FEATURE:
> > +                print('    feature=3D%s\n%s' % (section.name, section.=
text))
> > +            else:
> > +                print('    section=3D%s\n%s' % (section.kind, section.=
text))
> >
> >
> >  def open_test_result(dir_name, file_name, update):
>
> The loop body could be dumbed down further:
>
>                if isinstance(section, QAPIDoc.ArgSection):
>                    print('    %s=3D%s' % (section.kind, section.name))
>                else:
>                    print('    %s' % section.kind)
>                print(section.text)
>
> Expected output changes a bit more then.  I don't mind.

Sure, why not. Got other changes to make anyway, ...


