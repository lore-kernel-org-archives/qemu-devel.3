Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC48C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaExp-00026Q-Vh; Fri, 11 Jul 2025 10:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uaElL-00072i-BX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uaElI-0002GN-B9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752244201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nig9lcgc8UkVvTZy2u8ZAJBEMc1hJziJi7IZqLE91pk=;
 b=V8aLvasup3BraZ19F38a8GvkUWI06CFD+2WGjHleFGcWODXEP+B4pXwdpqPwowEWDBbzPE
 HFEYf20GsTdjychpBgLdMbC5Evwk1ELNMJbvF5wWvJ4Eqdi12086f4Ke3ra/dFI4mgFTsG
 nLkwmFEPAiyHvfbEyn9gwpTdsZa+DCE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-v4np4779N9GklXqFlJr0KQ-1; Fri, 11 Jul 2025 10:30:00 -0400
X-MC-Unique: v4np4779N9GklXqFlJr0KQ-1
X-Mimecast-MFC-AGG-ID: v4np4779N9GklXqFlJr0KQ_1752244199
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b3ba7659210so1636783a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244199; x=1752848999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nig9lcgc8UkVvTZy2u8ZAJBEMc1hJziJi7IZqLE91pk=;
 b=Qy9sZ+dht4yD7sA9rx0cgv61HRWrx4io9DktbK7V366MK8jOJpt9u2cfohE8jyVJdU
 W3k8ibB3ZNi3jV8Vv0/snEhmws6K+OoorhaIk6YSPapGIfxEiRBGEzS3uUoxuq2g5UX/
 oCMSkvNWxd6xYxZTdr47ptsDY9ur8lV2nUBb6g2sIdIDMkgFs2B8199AhbSAptuu1e8Q
 dwTzCKSvTL2R7fkjTXJG8nsLBb2dvqLOdUeIMdeYkRVFuMkP5N6d0fwZqFHZ+sTHts5r
 Hf+RlQKvDTohEmfmuB4jyEf+SqSjEHlLGf9fgnr1h6gxM+HaBiQUUny+GZnB6oGR6357
 MUkQ==
X-Gm-Message-State: AOJu0YxUn0s2K5/YsLWvD+6I9+ovDEeL0TJrsljOLZ1clZRPHTfH1qvw
 b2vTgVaIYOk+0YsNYN95FuuGAkBFKo1F837jPz3qpWzYbp78cFr+mX7DZ6lOcWLw9LeLIER8ENW
 GI6mF49I47MrLO7ifZGyIqRmRhypn9bNh/7KeEAlHT7bnVIbcV/3eLsGTIq7/oJUWeRn2L3P9Y4
 e5Nm+Qsv3r9lAOJPHcm9EwYN7hMpSi4LJTQJhWM7I=
X-Gm-Gg: ASbGncuDjZR1FHUiJYo881PmUpDtnICxAOTPX9+7fhngPVZb3NVrErWmhK25S2VCosP
 YjwVIV+j/aBi7wBXFi4RgdeFjj+5w5CH/yef7fcUVeB56nGbuSRXJCeVwejo+N69N1jEOjGnjoG
 NGOl+TGar7vNnPuTTRA2dylK4Y4dNlTen5bhalIs73nFnmS3J1xpV9
X-Received: by 2002:a17:90b:1d84:b0:312:def0:e2dc with SMTP id
 98e67ed59e1d1-31c4f49ea8amr3840179a91.7.1752244198356; 
 Fri, 11 Jul 2025 07:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ4AiAU/s1SV9m68Z2C+9OtF0plC+lKTFxw/GsixB8vh/AsaSzsnpK3VXXY3N/3dGsRGTezUYcu43V5ggo4CM=
X-Received: by 2002:a17:90b:1d84:b0:312:def0:e2dc with SMTP id
 98e67ed59e1d1-31c4f49ea8amr3840112a91.7.1752244197706; Fri, 11 Jul 2025
 07:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250711054005.60969-1-jsnow@redhat.com>
 <20250711054005.60969-9-jsnow@redhat.com>
 <87cya785t8.fsf@pond.sub.org>
In-Reply-To: <87cya785t8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 Jul 2025 10:29:45 -0400
X-Gm-Features: Ac12FXwYiJcawdhyFXzIfq10UAwbG4QuP7ouwuWjxJWifn1cZYo1NrfJMo1sWV0
Message-ID: <CAFn=p-bfBtoCJnLA9TL3RpDjmnsykfNtOybXgHKMR3oi3rCSUw@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] qapi: add cross-references to migration.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Lukas Straub <lukasstraub2@web.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000f6f5540639a8245e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f6f5540639a8245e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, 4:55=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/migration.json | 68 ++++++++++++++++++++++-----------------------
> >  1 file changed, 34 insertions(+), 34 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 59a213aeb6c..eda27c18102 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
>
> [...]
>
> > @@ -1735,8 +1735,8 @@
> >  #     list connected to a destination interface endpoint.
> >  #
> >  # @exit-on-error: Exit on incoming migration failure.  Default true.
> > -#     When set to false, the failure triggers a MIGRATION event, and
> > -#     error details could be retrieved with query-migrate.
> > +#     When set to false, the failure triggers a :qapi:event:`MIGRATION=
`
> > +#     event, and error details could be retrieved with `query-migrate`=
.
> >  #     (since 9.1)
>
> Suggest to have the the commit message note why we need :qapi:event:.
> Perhaps like this:
>
>   Note that a reference to MIGRATION needs to be disambiguated with a
>   :qapi:event: prefix.  Without this, Sphinx complains
>
>       more than one target found for 'any' cross-reference 'MIGRATION':
> could be :std:ref:`Migration framework` or
> :qapi:event:`QMP:migration.MIGRATION`
>

OK


> Aside: this fuzzy matching of references feels too clever by half.
>

That's the perils of the `any` syntax. In exchange for something very
terse, you have to contend with multiple domains of possible match targets.

On the whole, I think it's nice that you can reference `something` without
needing to know the precise geospatial coordinates of where that thing is.
Downside is that the matches may occasionally be fuzzier than you'd prefer.

The QAPI domain only ever matches in a case sensitive way, but other
domains in Sphinx aren't as strict, and I don't control those!


> >  #
> >  # Since: 2.3
>
> [...]
>
>

--000000000000f6f5540639a8245e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 11, 2025, 4:55=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/migration.json | 68 ++++++++++++++++++++++-----------------=
------<br>
&gt;=C2=A0 1 file changed, 34 insertions(+), 34 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 59a213aeb6c..eda27c18102 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
<br>
[...]<br>
<br>
&gt; @@ -1735,8 +1735,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0list connected to a destination interface e=
ndpoint.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @exit-on-error: Exit on incoming migration failure.=C2=A0 Defa=
ult true.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0When set to false, the failure triggers a MIGRAT=
ION event, and<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0error details could be retrieved with query-migr=
ate.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0When set to false, the failure triggers a :qapi:=
event:`MIGRATION`<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0event, and error details could be retrieved with=
 `query-migrate`.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(since 9.1)<br>
<br>
Suggest to have the the commit message note why we need :qapi:event:.<br>
Perhaps like this:<br>
<br>
=C2=A0 Note that a reference to MIGRATION needs to be disambiguated with a<=
br>
=C2=A0 :qapi:event: prefix.=C2=A0 Without this, Sphinx complains<br>
<br>
=C2=A0 =C2=A0 =C2=A0 more than one target found for &#39;any&#39; cross-ref=
erence &#39;MIGRATION&#39;: could be :std:ref:`Migration framework` or :qap=
i:event:`QMP:migration.MIGRATION`<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">OK</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
Aside: this fuzzy matching of references feels too clever by half.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;=
s the perils of the `any` syntax. In exchange for something very terse, you=
 have to contend with multiple domains of possible match targets.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">On the whole, I think it&#39;s ni=
ce that you can reference `something` without needing to know the precise g=
eospatial coordinates of where that thing is. Downside is that the matches =
may occasionally be fuzzier than you&#39;d prefer.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">The QAPI domain only ever matches in a case sens=
itive way, but other domains in Sphinx aren&#39;t as strict, and I don&#39;=
t control those!</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.3<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000f6f5540639a8245e--


