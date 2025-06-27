Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518CFC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 16:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVCC5-0000KV-Kc; Fri, 27 Jun 2025 12:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uVCC1-0000Js-9I
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uVCBz-0008Tu-H8
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751042686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4as6/ltz8TD2p+c8QRn0nMKDRRrk20hJ6WmHo+miXLE=;
 b=ZeOKIxz3H5X6Hcwz8oNCEhhDYapRQ35c9E5GHzLvkb1cdu5MPzgodz9112cOEA7IEIragE
 pNZeT8V33CPUXMOiLah0cXtQpQYqG545RTqSikp8lcChoIY3flYIi6gE9etlUTEsXsy90y
 5Im39l/jMR5ytQ2ykGLjCgAOK1/U/N8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-3cZqaXwBPb2F9mbNMM-Ceg-1; Fri, 27 Jun 2025 12:44:45 -0400
X-MC-Unique: 3cZqaXwBPb2F9mbNMM-Ceg-1
X-Mimecast-MFC-AGG-ID: 3cZqaXwBPb2F9mbNMM-Ceg_1751042684
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b34b810fdcaso49884a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 09:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042684; x=1751647484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4as6/ltz8TD2p+c8QRn0nMKDRRrk20hJ6WmHo+miXLE=;
 b=dd8yFBIFeCXGv/JkultITk7aORfE+5R6+xyjncnfj81IwdW5wpGtjb+fIR6h859kGu
 A9kuwkd/u1z9I83rwhfuT9HtqUL7y+QianYsFGdwxqbx6qpoj8ZdrI9F0RewQ7FF6Eff
 H0bNC9Itco11+LGvj3p8PUunkQtrFeMXlQegKMbEyy6ox4UuJerflsPlx8zI5I4ajcm4
 0TQtbcmOCZFKW5ygPljpZtedduPSn2bQKDlbRi1aeq7oGBBFfzGhNRCipygPXoD1abp5
 2DgZJ2qrYDT1z03vB2s/e3v/styswZqhNFlEpijlrD2/oKpLUxjl+ESdpOEw+T2Yp3+4
 Zqxg==
X-Gm-Message-State: AOJu0YzSoQbKwXfmyTsAb9vml3fxNg3gmFj2uGQzqCT13dlNWIRyeHzY
 lP1m2F3+oG6vo/dtxZ+OXPXXW6hTFK39T4BZHpMefh5YeG2+5QhRsQF1tAaNxbehFCoLGNq6h0X
 ecT2SSo9eM+nta7UZA/J9BaalFU2UMDAAuWivZPv/4Wwqnf/AYrjh3h2PjciUkREIXZf4gT597/
 CcIHxK2Hk0dSb7gn8pglsAw+pnoMGx4zc=
X-Gm-Gg: ASbGncvkM72tIxgV2+lwDDNkH2nSwsZopUuJJ1vLfO9tvWbMfFCBZvw1Uzsa3zsANJv
 PNdUP87GqQAXYV27w480QVK/wuYp1EMovUnFv4OPMQf2zBVyNgWBpP5IUathQ5/tzJP90VYhD+m
 d2uKCMY+mN3AWD8zotaMx4sz4Rp3dJ9WELYWg=
X-Received: by 2002:a17:90b:43:b0:311:9c9a:58c5 with SMTP id
 98e67ed59e1d1-318c8ee9a31mr7047306a91.12.1751042684076; 
 Fri, 27 Jun 2025 09:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOAspCPSH58ahvwq+XapRuhvTO0RjA22fbYzJH8Ft6dsT/mPgkVV3V79tYXGW6RCaSk+LqTpgyypOoToHMBZ0=
X-Received: by 2002:a17:90b:43:b0:311:9c9a:58c5 with SMTP id
 98e67ed59e1d1-318c8ee9a31mr7047262a91.12.1751042683674; Fri, 27 Jun 2025
 09:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-5-jsnow@redhat.com>
 <874iw1o6jt.fsf@pond.sub.org>
In-Reply-To: <874iw1o6jt.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 27 Jun 2025 12:44:31 -0400
X-Gm-Features: Ac12FXwZocAUotqw-prP0rbfjXnGGy-E7uG39Fitel3685w2uIdkZfFqByaTgX0
Message-ID: <CAFn=p-bxeTg2FSaRTky1xEPu9KkiXTb-8w6+mvgdf6+RbTHXvw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] docs/sphinx: remove special parsing for freeform
 sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jiri Pirko <jiri@resnulli.us>,
 Fan Ni <fan.ni@samsung.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Kashyap Chamarthy <kchamart@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Content-Type: multipart/alternative; boundary="00000000000025c6d10638906575"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000025c6d10638906575
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025, 5:52=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This change removes special parsing for freeform sections and allows
> > them to simply be unmodified rST syntax. The existing headings in the
> > QAPI schema are adjusted to reflect the new paradigm.
>
> "Allows them to" suggests the patch enables use of rST headings.  Is
> this the case?  Or do they just work, and this patch just switches
> schema code to use them, and drops now unnecessary generator code?
> >
> > Tests and documentation are updated to match.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index 231cc0fecf7..dfdbeac5a5a 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -876,25 +876,35 @@ structuring content.
>    Documentation comments
>    ----------------------
>
>    A multi-line comment that starts and ends with a ``##`` line is a
>    documentation comment.
>
>    If the documentation comment starts like ::
>
>        ##
>        # @SYMBOL:
>
>    it documents the definition of SYMBOL, else it's free-form
>    documentation.
>
>    See below for more on `Definition documentation`_.
>
>    Free-form documentation may be used to provide additional text and
>    structuring content.
>
>
> >  Headings and subheadings
> >  ~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -A free-form documentation comment containing a line which starts with
> > -some ``=3D`` symbols and then a space defines a section heading::
> > +Free-form documentation does not start with ``@SYMBOL`` and can contai=
n
> > +arbitrary rST markup. Headings can be marked up using the standard rST
> > +syntax::
>
> Nothing stops you from using such markup in definition documentation.
> It's probably a bad idea, though.
>
> I think it's easiest not to talk about the two kinds of doc blocks here
> at all.  Scratch the first sentence?
>

Sure.


> >
> >      ##
> > -    # =3D This is a top level heading
> > +    # *************************
> > +    # This is a level 2 heading
> > +    # *************************
> >      #
> >      # This is a free-form comment which will go under the
> >      # top level heading.
> >      ##
> >
> >      ##
> > -    # =3D=3D This is a second level heading
> > +    # This is a third level heading
> > +    # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +    #
> > +    # Level 4
> > +    # _______
> > +    #
> > +    # Level 5
> > +    # ^^^^^^^
> > +    #
> > +    # Level 6
> > +    # """""""
> >      ##
> >
> > -A heading line must be the first line of the documentation
> > -comment block.
> > -
> > -Section headings must always be correctly nested, so you can only
> > -define a third-level heading inside a second-level heading, and so on.
> > +Level 1 headings are reserved for use by the generated documentation
> > +page itself, leaving level 2 as the highest level that should be used.
> >
> >
> >  Documentation markup
>
> [...]
>
>

--00000000000025c6d10638906575
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27, 2025, 5:52=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This change removes special parsing for freeform sections and allows<b=
r>
&gt; them to simply be unmodified rST syntax. The existing headings in the<=
br>
&gt; QAPI schema are adjusted to reflect the new paradigm.<br>
<br>
&quot;Allows them to&quot; suggests the patch enables use of rST headings.=
=C2=A0 Is<br>
this the case?=C2=A0 Or do they just work, and this patch just switches<br>
schema code to use them, and drops now unnecessary generator code?<br>
&gt;<br>
&gt; Tests and documentation are updated to match.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st<br>
&gt; index 231cc0fecf7..dfdbeac5a5a 100644<br>
&gt; --- a/docs/devel/qapi-code-gen.rst<br>
&gt; +++ b/docs/devel/qapi-code-gen.rst<br>
&gt; @@ -876,25 +876,35 @@ structuring content.<br>
=C2=A0 =C2=A0Documentation comments<br>
=C2=A0 =C2=A0----------------------<br>
<br>
=C2=A0 =C2=A0A multi-line comment that starts and ends with a ``##`` line i=
s a<br>
=C2=A0 =C2=A0documentation comment.<br>
<br>
=C2=A0 =C2=A0If the documentation comment starts like ::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# @SYMBOL:<br>
<br>
=C2=A0 =C2=A0it documents the definition of SYMBOL, else it&#39;s free-form=
<br>
=C2=A0 =C2=A0documentation.<br>
<br>
=C2=A0 =C2=A0See below for more on `Definition documentation`_.<br>
<br>
=C2=A0 =C2=A0Free-form documentation may be used to provide additional text=
 and<br>
=C2=A0 =C2=A0structuring content.<br>
<br>
<br>
&gt;=C2=A0 Headings and subheadings<br>
&gt;=C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt;=C2=A0 <br>
&gt; -A free-form documentation comment containing a line which starts with=
<br>
&gt; -some ``=3D`` symbols and then a space defines a section heading::<br>
&gt; +Free-form documentation does not start with ``@SYMBOL`` and can conta=
in<br>
&gt; +arbitrary rST markup. Headings can be marked up using the standard rS=
T<br>
&gt; +syntax::<br>
<br>
Nothing stops you from using such markup in definition documentation.<br>
It&#39;s probably a bad idea, though.<br>
<br>
I think it&#39;s easiest not to talk about the two kinds of doc blocks here=
<br>
at all.=C2=A0 Scratch the first sentence?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Sure.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -=C2=A0 =C2=A0 # =3D This is a top level heading<br>
&gt; +=C2=A0 =C2=A0 # *************************<br>
&gt; +=C2=A0 =C2=A0 # This is a level 2 heading<br>
&gt; +=C2=A0 =C2=A0 # *************************<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # This is a free-form comment which will go under =
the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # top level heading.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -=C2=A0 =C2=A0 # =3D=3D This is a second level heading<br>
&gt; +=C2=A0 =C2=A0 # This is a third level heading<br>
&gt; +=C2=A0 =C2=A0 # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +=C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 # Level 4<br>
&gt; +=C2=A0 =C2=A0 # _______<br>
&gt; +=C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 # Level 5<br>
&gt; +=C2=A0 =C2=A0 # ^^^^^^^<br>
&gt; +=C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 # Level 6<br>
&gt; +=C2=A0 =C2=A0 # &quot;&quot;&quot;&quot;&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt;=C2=A0 <br>
&gt; -A heading line must be the first line of the documentation<br>
&gt; -comment block.<br>
&gt; -<br>
&gt; -Section headings must always be correctly nested, so you can only<br>
&gt; -define a third-level heading inside a second-level heading, and so on=
.<br>
&gt; +Level 1 headings are reserved for use by the generated documentation<=
br>
&gt; +page itself, leaving level 2 as the highest level that should be used=
.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Documentation markup<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--00000000000025c6d10638906575--


