Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A85AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKw0a-00040e-FG; Tue, 10 Dec 2024 03:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKw0Z-00040H-G3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKw0X-0004Ji-13
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733820854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXfSS8zHEJoRmBQrQPPXmbh8ou8W5Z4vg2tUAj7+7Ew=;
 b=WI65+ojUyqD9upJXWkJAScEkgAbVHvbRwN2DV8yq6oH/xkvgdKu6DYE331boOIO9UlOQaq
 msmPPoM5/dlpj331ZyOjQ2jiTqLCsoa4VNZlJlaoUAOijiCD4N3YLCmJD1WSw+H8XWNmni
 OoE7HGx4X2tZFlPuJKlrCYNcEuZsMAo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-su02VAHUMxOfbH-ISzQbIg-1; Tue, 10 Dec 2024 03:54:12 -0500
X-MC-Unique: su02VAHUMxOfbH-ISzQbIg-1
X-Mimecast-MFC-AGG-ID: su02VAHUMxOfbH-ISzQbIg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8b3173b5bso84199296d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820851; x=1734425651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXfSS8zHEJoRmBQrQPPXmbh8ou8W5Z4vg2tUAj7+7Ew=;
 b=hOUWwdrx3aEfgiJ1Na6iTtoj0aF1SI8UpcCu2YamffmuuQtph1VGbTBvLeiD0+Bypf
 k/RY71WGxaT0k/YNzmVpYUGKkS2CCevaQJrZakuJkubfn4287gmVXSgCJNjgjY/vDUti
 pPun3snp54CqS0NOghEA+4qU6lUCB/HaIKGsbeC3+Ga54zrusVJQYiPnAqUQ/PuKYMQI
 ZuE7OhM7kQWzPEt6Gzk12cAjaIgQbrgSIBDqzZegmVZEbppwQv6bVthmL6c0+lsAnf8j
 6lUHz3UCyk9bfD2bMxwbTEaCD+m4S8fHax9grDIN8hsyt2j7W4DWwt+4/zMiA+ANgBKq
 VYqw==
X-Gm-Message-State: AOJu0YzrOR52uXCaSutfeRiJcS2CkTPoAZt7pHPLDh9pyr1XJV9IeV/7
 10YRTqyJnoXZxQWl09FQCbPhrd55yHVIXHqvK535fOlQpdITfW0zOlxil7tunPWclgve9UMIXKm
 0CK3g97XEffo0R/gXUIAm5gA9jySnkrQrn31R04e8tmd6H1qlLI12TmiVkVAzHzCVbPSBX0NsQn
 k6cmk4BUjclMDmuJ2kTFBgCM54PHwaS8WzCuSEGA==
X-Gm-Gg: ASbGncu2UMFoxKoGmqFEPh2QaHzyhe9bxhszxFYBPEDuCSSAbuB8o1U7Snoa0S78iPv
 C55AeRqZU1vV42nvMcQAjkyYKSwHV7A/Cy+RFOA==
X-Received: by 2002:a05:6214:2aa7:b0:6ce:2357:8a2e with SMTP id
 6a1803df08f44-6d91e411d20mr60194976d6.37.1733820851528; 
 Tue, 10 Dec 2024 00:54:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8bjDgEBpHp4t/9Aedgfo64CXs0F7twh+JOUYm4PT+O4B1X65RawIbn0+I1hylWUq2vbmL6SWjNgzB89/5sXQ=
X-Received: by 2002:a05:6214:2aa7:b0:6ce:2357:8a2e with SMTP id
 6a1803df08f44-6d91e411d20mr60194806d6.37.1733820851272; Tue, 10 Dec 2024
 00:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20241210054616.260386-1-demeng@redhat.com>
 <Z1f4HB1o-XmyzagE@redhat.com>
In-Reply-To: <Z1f4HB1o-XmyzagE@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 10 Dec 2024 10:54:00 +0200
Message-ID: <CAPMcbCokcPcfCn8HnsTg4GPFnyBJyRTRRdr+hq59L6TsqsqUpA@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga-win: Fix a typo error
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000f1d0fe0628e69f0a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f1d0fe0628e69f0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

Best Regards,
Konstantin Kostiuk.


On Tue, Dec 10, 2024 at 10:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Tue, Dec 10, 2024 at 01:46:16PM +0800, Dehan Meng wrote:
> > There is a typo error for api 'guest-get-osinfo',
> > the win2025's version in WIN_10_0_SERVER_VERSION_MATRIX
> > should be adjusted.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-win32.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000f1d0fe0628e69f0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Reviewed-by: Konstantin Kostiuk &lt;=
<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.co=
m</a>&gt;</div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div><=
/div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 10, 2024 at 10:13=E2=
=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Tue, Dec 10, 2024 at 01:46:16PM +0800, Dehan Meng wr=
ote:<br>
&gt; There is a typo error for api &#39;guest-get-osinfo&#39;,<br>
&gt; the win2025&#39;s version in WIN_10_0_SERVER_VERSION_MATRIX<br>
&gt; should be adjusted.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-win32.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--000000000000f1d0fe0628e69f0a--


