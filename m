Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347A9E77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOIQ-00031f-2f; Thu, 05 Dec 2024 21:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJOIK-000316-Ps
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJOIF-00030m-KQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733452929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KtfpmZTRaWFpMtwXi0PScY9tgDL2plvqXtUHEkxeRo=;
 b=hknSnLuyj3Uf6Ab7NiNHQxuwq8tIFFXD75Hp1FLwmO+iILEgWSY/L1Gwvfrzh/OvlpBYty
 x8elPuSRrNq+wB7ecgq/BIKUP1Dd/B7KdpUDBYK4krVIXRKXY6E/EuEjpNI8AoIiWTXfty
 7s8kSbDr6HB4sdbZV6zw+UHYp4tkwRo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-jDwHstO9Py-t6bV-H8vSjw-1; Thu, 05 Dec 2024 21:42:07 -0500
X-MC-Unique: jDwHstO9Py-t6bV-H8vSjw-1
X-Mimecast-MFC-AGG-ID: jDwHstO9Py-t6bV-H8vSjw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385f0829430so1041198f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 18:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452926; x=1734057726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KtfpmZTRaWFpMtwXi0PScY9tgDL2plvqXtUHEkxeRo=;
 b=vKEs3DpNhgtXBybmMqzGTkSvnSRuU369npP14xjyHenOnZ1hwvZ7tmWQ16hzlQq1hJ
 dQVzfSxq4y2swyB8ZMHFasd13UnKbJPn6ivAilvovPtAJzeHc/9jImvzFd+vmWkQUAAY
 KlsMmzSOhfob6rEeihLIuUjLEXuBoOLLepI+weI+sTnVJl3am2pfrVVSlEcfptdU8aeF
 xytzXzA2tIQrU3MN7kkE+DYdKpdo6Fj0nU+6tt/TefkDbuPXStP9VGGJWNYXyLltDEln
 4SFlmcnn+7o9aXAsIayeggScg2mFefu6+NMQUiw7u7NwVw3UTJug3lsPbpwx7W6l6C9M
 ZiOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxdyKcjxMgtvbOjicv4K98W4FBQdfDZlLWz2xdsk9G3CzxHVui30n5fOG0VaDT0M3ZPZvP8sLN1yUb@nongnu.org
X-Gm-Message-State: AOJu0Yw8Qk8LCF5vn2Aea0lSfBmCnPZbuAj7PvGJCdGI6fr7UcnWPZIb
 vs7eqTNcWFxAB8AmpSAzRVYjkjbSIS0TRR+ngKfjDL1hK5oRhh31o5x2qeEn0FYrGlRzFa6Y5r0
 kzLTJ45cQCVPNb5s4TygeqysT927lpo2UL7IN7rW1LyJy3WKmsZfKXeusH5ZM1JmqaQ1vEwKSBw
 0iYLnAAJFg91zNVNC57o2BTSYOyjk=
X-Gm-Gg: ASbGncs4rVuTtc0XI/fkvfez0Wzy86rfDPl2kzoqaFVz6owpBw6DwUIH+CpDO+bQrw+
 Y5uazQL+fd5rusOw5IId043QwJYlNQp4z
X-Received: by 2002:a05:6000:470c:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-3862b3ce0e8mr775286f8f.38.1733452926116; 
 Thu, 05 Dec 2024 18:42:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx4fyFk2Py74YvljdyTly2HXrlepVGiovHPslhUrvhoXDhA0qnTm42kUOZEtYJhemw5xuA4r6vRSAarqvfW4s=
X-Received: by 2002:a05:6000:470c:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-3862b3ce0e8mr775279f8f.38.1733452925790; Thu, 05 Dec 2024
 18:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20241120075321.27143-1-r.peniaev@gmail.com>
 <aaaf219b-dbfc-459c-a531-02b5c494c65f@redhat.com>
 <CACZ9PQX5EMoWG8A29Jy5kUvEm65R68EcOAU++9t+DsGgf7_gFQ@mail.gmail.com>
In-Reply-To: <CACZ9PQX5EMoWG8A29Jy5kUvEm65R68EcOAU++9t+DsGgf7_gFQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Dec 2024 20:09:19 -0500
Message-ID: <CABgObfb+rGFK+WXOpNP6i8XoTxBjrSX8AU-e3SCfs1=jVG-j2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] chardev/char-mux: tweak mux bitset operations
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e08828062890f54a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000e08828062890f54a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 25 nov 2024, 08:46 Roman Penyaev <r.peniaev@gmail.com> ha scritto:

> Hi Paolo,
>
> Do I need to resend the fixed version, or if it is queued to what
> exact repo or branch? I'm a bit confused. Thanks.
>

Hi, sorry for the late reply=E2=80=94I was not sending it out for inclusion=
 because
we're in release freeze, but there was no need to resend.

Paolo

--
> Roman
>
> On Wed, Nov 20, 2024 at 3:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > Queued, with just one change:
> >
> > > Also add a static compile check that MAX_MUX never bigger than
> > > `sizeof(d->mux_bitset)`.
> >
> > This needs to be multiplied by CHAR_BIT.
> >
> > Paolo
> >
> > On 11/20/24 08:53, Roman Penyaev wrote:
> > > Patchset tweaks bitset operations by changing a constant to unsigned
> > > long, introduces a static compile check and simplifies bitset
> operations.
> > >
> > > v1..v2:
> > >
> > > Rebase on latest master, incorporate review tags.
> > >
> > > Roman Penyaev (2):
> > >    chardev/char-mux: shift unsigned long to avoid 32-bit overflow
> > >    chardev/char-mux: make boolean bit check instead of find_next_bit(=
)
> > >
> > >   chardev/char-mux.c | 15 +++++++--------
> > >   1 file changed, 7 insertions(+), 8 deletions(-)
> > >
> > >
> > > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > > Reviewed-by: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Reviewed-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden=
.com>
> > > Cc: qemu-devel@nongnu.org
> > >
> > >
> >
>
>

--000000000000e08828062890f54a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 25 nov 2024, 08:46 Roman Penyaev &lt;<a href=3D=
"mailto:r.peniaev@gmail.com">r.peniaev@gmail.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Paolo,<br>
<br>
Do I need to resend the fixed version, or if it is queued to what<br>
exact repo or branch? I&#39;m a bit confused. Thanks.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Hi, sorry for the late=
 reply=E2=80=94I was not sending it out for inclusion because we&#39;re in =
release freeze, but there was no need to resend.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
--<br>
Roman<br>
<br>
On Wed, Nov 20, 2024 at 3:44=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto=
:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; Queued, with just one change:<br>
&gt;<br>
&gt; &gt; Also add a static compile check that MAX_MUX never bigger than<br=
>
&gt; &gt; `sizeof(d-&gt;mux_bitset)`.<br>
&gt;<br>
&gt; This needs to be multiplied by CHAR_BIT.<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; On 11/20/24 08:53, Roman Penyaev wrote:<br>
&gt; &gt; Patchset tweaks bitset operations by changing a constant to unsig=
ned<br>
&gt; &gt; long, introduces a static compile check and simplifies bitset ope=
rations.<br>
&gt; &gt;<br>
&gt; &gt; v1..v2:<br>
&gt; &gt;<br>
&gt; &gt; Rebase on latest master, incorporate review tags.<br>
&gt; &gt;<br>
&gt; &gt; Roman Penyaev (2):<br>
&gt; &gt;=C2=A0 =C2=A0 chardev/char-mux: shift unsigned long to avoid 32-bi=
t overflow<br>
&gt; &gt;=C2=A0 =C2=A0 chardev/char-mux: make boolean bit check instead of =
find_next_bit()<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0chardev/char-mux.c | 15 +++++++--------<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 7 insertions(+), 8 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">r.peniaev@gmail.com</a>&gt;<br>
&gt; &gt; Reviewed-by: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marc=
andre.lureau@redhat.com</a>&gt;<br>
&gt; &gt; Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org"=
 target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
&gt; &gt; Reviewed-by: Cl=C3=A9ment Mathieu--Drif &lt;<a href=3D"mailto:cle=
ment.mathieu--drif@eviden.com" target=3D"_blank" rel=3D"noreferrer">clement=
.mathieu--drif@eviden.com</a>&gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" re=
l=3D"noreferrer">qemu-devel@nongnu.org</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000e08828062890f54a--


