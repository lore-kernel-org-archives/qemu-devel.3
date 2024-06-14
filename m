Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84041C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 23:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIGgg-0004xL-NF; Fri, 14 Jun 2024 19:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1sIGgf-0004x3-4L
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 19:50:29 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1sIGgd-00024O-7D
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 19:50:28 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52bc29c79fdso3775142e87.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718409023; x=1719013823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QuUdE2KUIagi3ugzMGpmNAnlF1FL+1vISuoQqAo7rE=;
 b=NxZK1VuHSYyXAQhxUtFjb/GlRKq6qFvQ/xspv3YX6BgJdZzaTS/Lgscu99iW2XF43+
 QpHgsmye/XAfJbaUqFoXPxt2iuBSw1RjnKIpGYdHfOd2eLF/wvM16utTqnkOJABxvOfw
 Ycy8Rep3iwiRJMOxm2CAFsgQn8AtQ6D0qvVHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718409023; x=1719013823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QuUdE2KUIagi3ugzMGpmNAnlF1FL+1vISuoQqAo7rE=;
 b=FQT5xh4CEWPPV0uQPhv+q+1pjAJNGEjCcqt8DwBtSUZ82e/unpf74R9WsH7tFcwDIW
 UNjsH8rerEE0pNyfhwYlJ+6+abAYG/zHMAuormzr3cRNCU4No53GNcDGRgih2iWvAFPU
 MGppCjezQl0fc2rt/BPwN76IYYN1HlA1s3/bNWUYBkvEkHtGKMCh3TqeQdmzkvabrkrJ
 35HayjQmGPZgbCmTR4Bs0vzD+4+MW1dLcEQ0mkItxXFmpsQt7quw2sgubmUDtY7ngauh
 jGoORoIXz1E1mXQ6uhsrTZXZIYjeMjUVw6999IWrLk5jk8TZ/+fkKe8UI/e/2hUpY/ik
 Jt0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi3jvzrZg3HTSbByhXML8xtzvkitA2/1yoJOL5XpMVmf4up/Owlx8n8Km7ZAadmMEsi1Hq8rmC2Ho2EV/xMDKa0hojjkg=
X-Gm-Message-State: AOJu0YznjjqyiJIzNIp+Mg+Vhid6exIyc8eK5q1G5tXuy2hvn422dBhG
 o7onzRTHifDSF6WiBEmAmiAKLe9jUWMhdqMDIImOfZ34IffidYL+OSqPj/k5pralyaRwNfNXque
 u7g==
X-Google-Smtp-Source: AGHT+IFyyBMo2bKOdStP9g9z6cEJcunyK1+fpFPJdDAuNh8zsX5wqtwjXs+FWqL/GLXhG8LPZPUDBw==
X-Received: by 2002:ac2:44a2:0:b0:52c:a5cc:27e7 with SMTP id
 2adb3069b0e04-52ca6e9dafcmr2956030e87.66.1718409022965; 
 Fri, 14 Jun 2024 16:50:22 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5b3asm234836066b.52.2024.06.14.16.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 16:50:22 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-57a16f4b8bfso5770a12.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 16:50:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmC1l6eUxN426/0RulieGUkxSGn45GqM+yWHfvw8cSi/4Ui0G9Xrb00fYedJ5+2znb57O6QRrbFnvqsEktXAQVGcVjDY=
X-Received: by 2002:a05:6402:40cb:b0:57c:c5bf:e419 with SMTP id
 4fb4d7f45d1cf-57ccc45f950mr32939a12.1.1718409022109; Fri, 14 Jun 2024
 16:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
 <20240605152832.11618-2-weifeng.liu.z@gmail.com>
 <CAJ+F1C+oVSeAGRvbE3pbgyj66JRf0vDbcd9AbRTYZk4+xpuu_g@mail.gmail.com>
In-Reply-To: <CAJ+F1C+oVSeAGRvbE3pbgyj66JRf0vDbcd9AbRTYZk4+xpuu_g@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 14 Jun 2024 16:50:09 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=3hFbgV3Uij+mNcfgbXHyxYCVJN5s=5y1L53ALWm1poA@mail.gmail.com>
Message-ID: <CAAfnVB=3hFbgV3Uij+mNcfgbXHyxYCVJN5s=5y1L53ALWm1poA@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio-gpu: rutabaga: Properly set stride when
 copying resources
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: multipart/alternative; boundary="0000000000005834f7061ae24760"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000005834f7061ae24760
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:44=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Wed, Jun 5, 2024 at 7:30=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.c=
om>
> wrote:
>
>> The stride is not correctly assigned when copying pixel data, causing
>> images being displayed incomplete when using 2d component of rutabaga.
>>
>> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
>> ---
>>  hw/display/virtio-gpu-rutabaga.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-rutabaga.c
>> b/hw/display/virtio-gpu-rutabaga.c
>> index 17bf701a21..2ba6869606 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -53,6 +53,7 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
>> virtio_gpu_scanout *s,
>>      transfer.z =3D 0;
>>      transfer.w =3D res->width;
>>      transfer.h =3D res->height;
>> +    transfer.stride =3D res->width * 4;
>>
>
> ok, stride defined by QEMUCursor layout
>
>
>>      transfer.d =3D 1;
>>
>>      transfer_iovec.iov_base =3D s->current_cursor->data;
>> @@ -273,6 +274,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
>> virtio_gpu_ctrl_command *cmd)
>>      transfer.z =3D 0;
>>      transfer.w =3D res->width;
>>      transfer.h =3D res->height;
>> +    transfer.stride =3D pixman_image_get_stride(res->image);
>>      transfer.d =3D 1;
>>
>
> ok (destination image stride)
>
>
>>      transfer_iovec.iov_base =3D pixman_image_get_data(res->image);
>> @@ -382,6 +384,7 @@ rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>>      transfer.z =3D 0;
>>      transfer.w =3D t2d.r.width;
>>      transfer.h =3D t2d.r.height;
>> +    transfer.stride =3D t2d.r.width * 4;
>>
>
> here however, it's unclear to me what the stride could be, I think it
> could depend on resource format (virgl doesn't set stride either).
>
> Gurchetan?
>

gfxstream does more or less the same thing internally to deal with the lack
of stride.  Since virtio-gpu KMS only supports 4-bpp formats, this is fine,
so r-b for this particular patch.

That said, we actually don't use virtio-gpu-rutabaga for 2D mode or VirGL
mode, preferring to use the other more supported modes in QEMU for those
use cases.  I think there's actually some CI support for those in many
places.  So suggest just waiting until virglrenderer uprev lands in QEMU.



>
>
>
>>      transfer.d =3D 1;
>>
>>      result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
>> t2d.resource_id,
>> --
>> 2.45.0
>>
>>
>>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--0000000000005834f7061ae24760
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 10, 2024 at 12:44=E2=80=
=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.c=
om" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Jun 5, 2024 at 7:30=E2=80=AFPM Weifeng Liu &lt;<a h=
ref=3D"mailto:weifeng.liu.z@gmail.com" target=3D"_blank">weifeng.liu.z@gmai=
l.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">The stride is not correctly assigned when copying pixel data, causing<=
br>
images being displayed incomplete when using 2d component of rutabaga.<br>
<br>
Signed-off-by: Weifeng Liu &lt;<a href=3D"mailto:weifeng.liu.z@gmail.com" t=
arget=3D"_blank">weifeng.liu.z@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-rutabaga.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutab=
aga.c<br>
index 17bf701a21..2ba6869606 100644<br>
--- a/hw/display/virtio-gpu-rutabaga.c<br>
+++ b/hw/display/virtio-gpu-rutabaga.c<br>
@@ -53,6 +53,7 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct vi=
rtio_gpu_scanout *s,<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D res-&gt;width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D res-&gt;width * 4;<br></blockquote><div>=
<br></div><div>ok, stride defined by QEMUCursor layout<br></div><div>=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0transfer_iovec.iov_base =3D s-&gt;current_cursor-&gt;da=
ta;<br>
@@ -273,6 +274,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio=
_gpu_ctrl_command *cmd)<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D res-&gt;width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D pixman_image_get_stride(res-&gt;image);<=
br>
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br></blockquote><div><br></div><div>o=
k (destination image stride)<br></div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0transfer_iovec.iov_base =3D pixman_image_get_data(res-&=
gt;image);<br>
@@ -382,6 +384,7 @@ rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D t2d.r.width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D t2d.r.height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D t2d.r.width * 4;<br></blockquote><div><b=
r></div><div>here however, it&#39;s unclear to me what the stride could be,=
 I think it could depend on resource format (virgl doesn&#39;t set stride e=
ither).</div><div><br></div><div>Gurchetan?<br></div></div></div></blockquo=
te><div><br></div><div>gfxstream does more or less the same thing internall=
y to deal with the lack of stride.=C2=A0 Since virtio-gpu KMS only supports=
 4-bpp formats, this is fine, so r-b for this particular patch.</div><div><=
br></div><div>That said, we actually don&#39;t use virtio-gpu-rutabaga=C2=
=A0for 2D mode or VirGL mode, preferring to use the other more supported mo=
des in QEMU for those use cases.=C2=A0 I think there&#39;s actually some CI=
 support for those in many places.=C2=A0 So suggest just waiting until virg=
lrenderer uprev lands in QEMU.=C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>=C2=A0<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
<div class=3D"gmail_quote"><div></div><div><br></div><div>=C2=A0 <br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0result =3D rutabaga_resource_transfer_write(vr-&gt;ruta=
baga, 0, t2d.resource_id,<br>
-- <br>
2.45.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>
</blockquote></div></div>

--0000000000005834f7061ae24760--

