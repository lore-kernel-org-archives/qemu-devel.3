Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BA11099B32
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3drw-0000kP-JF; Fri, 20 Mar 2026 13:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3dro-0000j0-Fy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3drm-0000to-Jd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774028553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6LpmRMnokrt9ytBUqRfTakvE1ixY9QQRCDHdvB/G/0=;
 b=OlED0odST4BsKMHWjgMFaHDHN7Z0f1eTG/twkEWNRwnn0fJvX8Sazuxe7KnsVhle0/cB17
 rQcvDl6/IGhR/+RhlGOodm4j/3zWCM2wsblzzo+2Vnil8vWeSnSi5Xftj2VSGxy80iiMP6
 EcuxtRXp5cArN7yGdWHTbJ1JSlHCu54=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ESXulsyqMu21ia1uCTQmvg-1; Fri, 20 Mar 2026 13:42:32 -0400
X-MC-Unique: ESXulsyqMu21ia1uCTQmvg-1
X-Mimecast-MFC-AGG-ID: ESXulsyqMu21ia1uCTQmvg_1774028551
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8954803bd74so26165696d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 10:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028551; cv=none;
 d=google.com; s=arc-20240605;
 b=Qg1HTh5hhX5rYS4afQXV4DCiG/eKSdq7RNyPajwREkk2iehpodiLJxXQ6efGL/Vqvb
 V544Qio2iMttBILCeJKXmR09UphVXSp+FZCHyOqOGI3kk7qR2JaCbzGD1+mKm3s6L4ab
 FNXJeArzrpNGj8G+v4ypygfcyAMJOqxfcAOuAIimL+ktIk6WMX7acR851VIt5iITTNWx
 cvdb1/rl/z5x1cczoWc83F7PbRlopyyZWHwwZpqS0hfCftrzCg5kQrHM1dnrtQlxuKcD
 S6c79O3DRTMKr0+m+aH9wsnJRR9Joefr+qHLMPIzHYGznEJxS1X+HtyeVh7hATq/n2P8
 Gc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m6LpmRMnokrt9ytBUqRfTakvE1ixY9QQRCDHdvB/G/0=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=kB7iagnY2tpHp0jdBae03cmcR3Rnx2ZEMj6YB4UA5Kah/aJr9sqv3d1b91iNHDI47N
 /JEZ3W7Ztbv1V3QDIl+B/MoTrOF2OS0A44Fr9L5jUY3z2rHjeu4QD/fy+SX2TYro/10S
 G7Fxj+ea/m8SRXltdEIVNIJU9TjPcTFIUKvFR7B67qzb7MkXaLLofMgH7De6/A3OH7EE
 prhvDxydGae4Y2GuMSxwhQLxVEiR1ycy3TWuc2nqAprgflk9f5kw3gWB7reLMQucF9aD
 8+OXP+Wi10PShu96YQk7oLL/fRz08G6pPpll7okSOX3VuCm0BvSahHFFdLu7iWIhxaoD
 iAfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774028551; x=1774633351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m6LpmRMnokrt9ytBUqRfTakvE1ixY9QQRCDHdvB/G/0=;
 b=rSQvjkXyosFm9uiKZP6unzaopJpTAtQX87Tx7hd3sqOgkeHwpQZe2nqtUaN9nrFRqB
 zcrOV7pwSzTTuDJ5NCgfTd6xdTG3iTjZTymfm+HRF/pq1O0wxUZbHUGFod8tYPPHIkJK
 UPbKhMwJhUb4nVth26V2yg1pqTHERM1BOrt/xeaPtVfVebCUBzozZDExdFifyc5IAwK4
 QdlMzh9J6sg5zLxWQZAqiogRrRMt5QxlzBcftPvoPdXTIXn3HERZEZYgF9w5XjSWILA2
 7a2tuPctny32bCZBcTei+ocZfsVc/L1Gs7G8mFGBQLsDZnLTm/3nxWWatczm7RJ12lul
 RTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028551; x=1774633351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6LpmRMnokrt9ytBUqRfTakvE1ixY9QQRCDHdvB/G/0=;
 b=dPVtuJcqcNF/1lTWF6zBjp68srF7YtIkU1qoJy4TTeSNMgsQCzsa13mSj/LFBKUzTi
 iIZV5PHFrt2iAbq97qeLQMOl4WR7kqcWTP9DUWw82WMklftyjz1dYgEXPNvlmCyrFjIq
 tuaJzwl7Dyl1PRVVFn9RRktwnfBpabXTIDXRsXM6lfKJeKgN1JTTFMJgs07u0ODoe2b+
 I4gXasRjT0c4mEuEDnwyXKzFSMkQ+oc+K/Gm6aUogQPgbRICBAkKXUWaJvT2bE1SHf9i
 BES+gnzhR/b+ccBKgZ6unLd1JL6UdO4drAwUX3Upxzq6stosYg2WSwZRtI6f6AWXZfCp
 t9yQ==
X-Gm-Message-State: AOJu0Yza81KXMkFRko8AZLkQ3f4zvReVi+SbSBkNy/m8bMZw1+zyS9OC
 G5wxCs6vQJKgRKh0M4EarvrHuywdrQ89IXkMt8AAs+sASDcNKh3U8arCTv77CbJCSIC348NqVeJ
 kSy0+Tw7D9nl3RV3fHmHJL+PfvCvc7xQBFuxJXTGqrl0zFcnCC/W9pdobgh/OQJMRYunW3ddkyd
 CAKznJHu/01SfLoG6TTFgHZWBkmYPxiYvjD1Numwk=
X-Gm-Gg: ATEYQzxs99EExz1YjVt5I0wMdnK/ffD1qGCZk5sgcFC0BRAl53MDpeLsZ9LM3k35hFm
 ynFBrhzJq0xDeenKLumKd1A+RAeF6i8LTDOuOkj2k1VqYqFWOYjBD4eRLKeB1T/vazKDN0DTsb1
 e57f3syN/jsxxwWSr/eEHoxhO4TyuZ6nBeJKFkb/BV+pmCWMk8mFYFtjbj0npcdvo76OcwQTJXM
 Y2UYHmBFNSNKJujLR2nmLGdOwwQLxPcAa1N9g==
X-Received: by 2002:a05:6214:2a89:b0:89c:5921:1791 with SMTP id
 6a1803df08f44-89c859f9837mr59009656d6.6.1774028551173; 
 Fri, 20 Mar 2026 10:42:31 -0700 (PDT)
X-Received: by 2002:a05:6214:2a89:b0:89c:5921:1791 with SMTP id
 6a1803df08f44-89c859f9837mr59008916d6.6.1774028550625; Fri, 20 Mar 2026
 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-3-jsnow@redhat.com>
 <87pl4y62bc.fsf@pond.sub.org>
In-Reply-To: <87pl4y62bc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 13:42:18 -0400
X-Gm-Features: AaiRm50A6m6Xh08x_vPZg4YajaYfcUtpj5aq-EEKx9UBiu_8yIaWYZ4v77R2Plk
Message-ID: <CAFn=p-aKNcWSrt0z4bCXV3W4aVMBqKMfpbk6GFQYao4MsbNG8A@mail.gmail.com>
Subject: Re: [PATCH 2/8] qapi: prohibit 'details' sections between tagged
 sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000094fee0064d7835f5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

--00000000000094fee0064d7835f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 9:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch prohibits plain documentation sections from appearing betwee=
n
> > "tagged" sections. The two existing uses of this pattern are patched
> > out.
> >
> > This is being done primarily to ensure consistency between the source
> > documents and the final, rendered HTML output. Because
> > member/feature/returns/error sections will always appear in a visually
> > grouped element in the HTML output, prohibiting plain paragraphs betwee=
n
> > those sections ensures ordering consistency between source and the fina=
l
> > render.
> >
> > Additionally, prohibiting such "middle" text paragraphs allows us to
> > classify all plain text sections as either "intro" or "details" section=
s,
> > because these sections must either appear before structured/tagged
> > sections ("intro") or afterwards ("details").
> >
> > This keeps the inlining algorithm simpler with fewer "splice" points
> > when merging multiple documentation blocks.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/qom.json                   |  4 ++--
> >  scripts/qapi/parser.py          | 17 +++++++++++++++++
> >  tests/qapi-schema/doc-good.json |  4 ++--
> >  tests/qapi-schema/doc-good.out  |  4 ++--
> >  tests/qapi-schema/doc-good.txt  |  8 ++++----
> >  5 files changed, 27 insertions(+), 10 deletions(-)
>
> Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
> FIXME, so we don't forget.
>

I will add a FIXME.


> Missing: negative test case for the new error.
>

I will add a FIXME here as well and implement the test once we agree on the
approach, implementation, and wording.

>

--00000000000094fee0064d7835f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 9:47=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch prohibits plain documentation sections from appearing betwe=
en<br>
&gt; &quot;tagged&quot; sections. The two existing uses of this pattern are=
 patched<br>
&gt; out.<br>
&gt;<br>
&gt; This is being done primarily to ensure consistency between the source<=
br>
&gt; documents and the final, rendered HTML output. Because<br>
&gt; member/feature/returns/error sections will always appear in a visually=
<br>
&gt; grouped element in the HTML output, prohibiting plain paragraphs betwe=
en<br>
&gt; those sections ensures ordering consistency between source and the fin=
al<br>
&gt; render.<br>
&gt;<br>
&gt; Additionally, prohibiting such &quot;middle&quot; text paragraphs allo=
ws us to<br>
&gt; classify all plain text sections as either &quot;intro&quot; or &quot;=
details&quot; sections,<br>
&gt; because these sections must either appear before structured/tagged<br>
&gt; sections (&quot;intro&quot;) or afterwards (&quot;details&quot;).<br>
&gt;<br>
&gt; This keeps the inlining algorithm simpler with fewer &quot;splice&quot=
; points<br>
&gt; when merging multiple documentation blocks.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 ++=
+++++++++++++++<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 |=C2=A0 8 ++++----<br>
&gt;=C2=A0 5 files changed, 27 insertions(+), 10 deletions(-)<br>
<br>
Missing: update to docs/devel/qapi-code-gen.rst.=C2=A0 Suggest to put in a<=
br>
FIXME, so we don&#39;t forget.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I will add a FIXME.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Missing: negative test case for the new error.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I will add a FIXME here as we=
ll and implement the test once we agree on the approach, implementation, an=
d wording.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000094fee0064d7835f5--


