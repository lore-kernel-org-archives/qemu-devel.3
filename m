Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F50CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCoe-0003wv-9q; Mon, 30 Sep 2024 05:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svCod-0003st-6M; Mon, 30 Sep 2024 05:35:39 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svCob-0007mk-31; Mon, 30 Sep 2024 05:35:38 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45832b2784bso34364911cf.3; 
 Mon, 30 Sep 2024 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727688935; x=1728293735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CLZOndBYguupyMCtRpcMGT6av+LVhgdkjZCSsnz975A=;
 b=iWme7WG+0aPGUesYr9012r0q1tXr7Zj+LoBrq7d8OU75NKHhxKaS1o6eOC4H7KQ4qo
 yzLfEUp4y+npOSTWeIdBBeGAxspNTgTTY9WnBfvlbYDK023kSVHrhFCtR2gwY1tL/7O4
 vB91I2bVeqXTv7zslIzsflqQ8Dedm6edGlXca2AqplPXm9QxEJwEDPPyrvHOQQ++9DXM
 33eo6RdLQeF/u368llAvZsFmJfYacfW/ehUKaN0120dFLtjZ0HgZdj0Xi9ccfb0H38UK
 wqAGG/i6MjuJPqk21F8RZMqeSIcLAFYkGLkPJ4WGErQoWjF3/LiR8+f7gEmuVR3TFMJP
 l9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727688935; x=1728293735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CLZOndBYguupyMCtRpcMGT6av+LVhgdkjZCSsnz975A=;
 b=Zz0bEtxPd5z6IQ8DEy9aOKKYQDLD0tR67TGYkB55e7UZgEe6SjirZaJHXBejzQhKjo
 EU0s3u0HQXc3m4boCt0vqCICKI2+FJEMjuzYV7Whr3b2n9USbm3MzWANZDMDA7h2AYbG
 48zjAXe+13SpSQx+p9Py4slqlB09hBOScS0pgVcU3mYhtSCYri9meGBKjbQs6y8m/nVr
 abMHBgHbXfdVGopSkiBoIWAc8jj6dJ8gUKQiApbn4/flnGp1qZmp6Gkqqt42Ix4D+SgK
 5GKKV82aw3pbqkpz1FRX3FfwHRJKVA+CwDXjR4LNV5cvrGtyTNTyW186iVD/x5hSp/vU
 /CxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXDFam6LU5pedDxMKHHcgXm06BuaRAVvOgL+bLlj6xxhoTBnfkjabJD7/NMs4RkXL8RDJjspvrgMSC@nongnu.org
X-Gm-Message-State: AOJu0YzhQ9OWZxuTO3u9G5nsC9Nn2Z8gstfJT7AN6LUYtbzQd6ZmGiHE
 7wExY0Nvfoc50GQMnZeN72eHnsqrcpk1bc/VlgMNOGl0XzdLM8cP1QxVXwXF4lz36BT+l5L4YEg
 T9OBKx5+txfMDujOmhLulDVynIIE=
X-Google-Smtp-Source: AGHT+IETKuWKQi8ddr5Ss48rC1F7DwDhZdnEQanGNZh82fkwAnODh5WSPaoMl8CoIeyJ/0ZzG51nY3kV3+kUhiyI0uY=
X-Received: by 2002:a05:622a:343:b0:458:27a7:ad66 with SMTP id
 d75a77b69052e-45c9f247590mr188388841cf.34.1727688934968; Mon, 30 Sep 2024
 02:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-23-marcandre.lureau@redhat.com>
 <2542220.oxJn2mPQ6z@silver>
In-Reply-To: <2542220.oxJn2mPQ6z@silver>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Sep 2024 13:35:23 +0400
Message-ID: <CAJ+F1CJfhHNWWZbi27GRuRtkkECrmE2od2m40PJWDsoCiesELA@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] fsdep/9p: fix -Werror=maybe-uninitialized
 false-positive
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: multipart/alternative; boundary="0000000000004059ad062352ed05"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--0000000000004059ad062352ed05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian

On Mon, Sep 30, 2024 at 1:27=E2=80=AFPM Christian Schoenebeck via <
qemu-devel@nongnu.org> wrote:

> On Monday, September 30, 2024 10:14:57 AM CEST Marc-Andr=C3=A9 Lureau wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../fsdev/9p-iov-marshal.c:93:23: error: =E2=80=98val=E2=80=99 may be us=
ed uninitialized
> [-Werror=3Dmaybe-uninitialized]
> > and similar
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  fsdev/9p-iov-marshal.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
> > index a1c9beddd2..75fb87a490 100644
> > --- a/fsdev/9p-iov-marshal.c
> > +++ b/fsdev/9p-iov-marshal.c
> > @@ -84,7 +84,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int
> out_num, size_t offset,
> >              break;
> >          }
> >          case 'w': {
> > -            uint16_t val, *valp;
> > +            uint16_t val =3D 0, *valp;
> >              valp =3D va_arg(ap, uint16_t *);
> >              copied =3D v9fs_unpack(&val, out_sg, out_num, offset,
> sizeof(val));
>
> Another option would be inserting here:
>
>         if (copied <=3D 0) break;
>
> Same below. But I leave it up to you:
>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>
>
Ok, done

thanks


> /Christian
>
> >              if (bswap) {
> > @@ -95,7 +95,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int
> out_num, size_t offset,
> >              break;
> >          }
> >          case 'd': {
> > -            uint32_t val, *valp;
> > +            uint32_t val =3D 0, *valp;
> >              valp =3D va_arg(ap, uint32_t *);
> >              copied =3D v9fs_unpack(&val, out_sg, out_num, offset,
> sizeof(val));
> >              if (bswap) {
> > @@ -106,7 +106,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg,
> int out_num, size_t offset,
> >              break;
> >          }
> >          case 'q': {
> > -            uint64_t val, *valp;
> > +            uint64_t val =3D 0, *valp;
> >              valp =3D va_arg(ap, uint64_t *);
> >              copied =3D v9fs_unpack(&val, out_sg, out_num, offset,
> sizeof(val));
> >              if (bswap) {
> >
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000004059ad062352ed05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Christian<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2024 at 1=
:27=E2=80=AFPM Christian Schoenebeck via &lt;<a href=3D"mailto:qemu-devel@n=
ongnu.org">qemu-devel@nongnu.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Monday, September 30, 2024 10:14:57 AM =
CEST Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; ../fsdev/9p-iov-marshal.c:93:23: error: =E2=80=98val=E2=80=99 may be u=
sed uninitialized [-Werror=3Dmaybe-uninitialized]<br>
&gt; and similar<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 fsdev/9p-iov-marshal.c | 6 +++---<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c<br>
&gt; index a1c9beddd2..75fb87a490 100644<br>
&gt; --- a/fsdev/9p-iov-marshal.c<br>
&gt; +++ b/fsdev/9p-iov-marshal.c<br>
&gt; @@ -84,7 +84,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, in=
t out_num, size_t offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;w&#39;: {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t val, *valp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t val =3D 0, *valp;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 valp =3D va_arg(ap, ui=
nt16_t *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 copied =3D v9fs_unpack=
(&amp;val, out_sg, out_num, offset, sizeof(val));<br>
<br>
Another option would be inserting here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copied &lt;=3D 0) break;<br>
<br>
Same below. But I leave it up to you:<br>
<br>
Reviewed-by: Christian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@crudebyte=
.com" target=3D"_blank">qemu_oss@crudebyte.com</a>&gt;<br>
<br></blockquote><div><br></div><div>Ok, done</div><div><br></div><div>than=
ks</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
/Christian<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bswap) {<br>
&gt; @@ -95,7 +95,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, in=
t out_num, size_t offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;d&#39;: {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t val, *valp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t val =3D 0, *valp;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 valp =3D va_arg(ap, ui=
nt32_t *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 copied =3D v9fs_unpack=
(&amp;val, out_sg, out_num, offset, sizeof(val));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bswap) {<br>
&gt; @@ -106,7 +106,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, =
int out_num, size_t offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;q&#39;: {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, *valp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val =3D 0, *valp;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 valp =3D va_arg(ap, ui=
nt64_t *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 copied =3D v9fs_unpack=
(&amp;val, out_sg, out_num, offset, sizeof(val));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bswap) {<br>
&gt; <br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000004059ad062352ed05--

