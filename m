Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C033EC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf6X-00032w-K9; Fri, 17 Jul 2026 05:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf6W-00032Y-Jw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf6V-00036A-12
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHvQ+eybWR+zkxX9WTGnNwFJsFoQUov+J3j3VimhWJs=;
 b=I6YmFRkJWoLvPUrY9qWk+SKK+5xfE8/vhbf5hpeplZYWMAf+lk+hSSkG9dj4Stxwx7DeJe
 lYlBpSbFQpb8STNgqtYE3SrrSmY3WtUH+Cy4Ni+ksaLd5d93Nf5oepyvEj/rJKqENXc6bg
 cIB/pnabL1CNULUToYIkEqEGczOVXT8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-z7GTG6XwOEWQ824TY6OrAA-1; Fri, 17 Jul 2026 05:43:32 -0400
X-MC-Unique: z7GTG6XwOEWQ824TY6OrAA-1
X-Mimecast-MFC-AGG-ID: z7GTG6XwOEWQ824TY6OrAA_1784281412
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4a42c572645so6203315b6e.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784281412; cv=none;
 d=google.com; s=arc-20260327;
 b=X7A2Rfuh8MgGWbRO9zQgv/0AHfJ/xSiCmJ8xSU/3nWDO3BWXkq0uKL/gkyQvnUbZo/
 DCJhlNlvnmbTb7vqtjOAlf25Yv5FwUtUS4JsOMQxD6TBjikVZ8fV3bZUEA0ypNkkzVVU
 toc5CTlwiHZJLzX9885wbwuYY50IoDQ+ucgUy+vt7xNc3VwbWGAThnfNFXh3j4BlBGQ7
 aza7HcgIxeR/w+hguQ8F1Nt/Hv0qhLi9I9Ja0wkUbZWa7kXj3gwdVzZIHqB6XwIBpxJk
 JLjl7ojEGSw4uXyoifR5bxmkpRVK486IiuM4Tj7RxmROI4MF3uNpNboKSUZWUib6RGVi
 SlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iHvQ+eybWR+zkxX9WTGnNwFJsFoQUov+J3j3VimhWJs=;
 fh=41M+sq0/1QRvVKfxRmfaR1+pG/echncbKYJ+zq3K0ic=;
 b=Vy3sowb3uQIWifJnmEJXUs+Cj+yjCc1fwpcwv2Ffrx+HADVrdKYDCSEantVQjFJ9ru
 tk2EPjC7patGvw/8UktVqpc4PH1pugvOF2l8Y/89xJlsNKHB2FkWDQ6hbZOZ0m0TgUZX
 juycoqEI3nU7E+dxF++YJ+jEC6DnvoWC2/e9kX4RypR/PwPO+ScsoMx4j/R4PKT/3Fh1
 moVuNQlyxf6UKSlFjCenzru1XtU0i/VB+a8aJC8niJORoBfJFKJQEvCK1tFSYXZ6TaO4
 NF7OXrkUwqluayocQVUsqV9w88V6rZYa8ZPMQm1IKb+JQjKgEACMATDbj30rPOlzSopL
 nANw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281412; x=1784886212; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iHvQ+eybWR+zkxX9WTGnNwFJsFoQUov+J3j3VimhWJs=;
 b=G2SHKPP1yVcS50b3VPTTZf3J/77hpEHM1i4lpOuE6bKCcbcitQTuEVwRdtTwm44av4
 QPln2TxDf/D7Ib/0ytOOQ73/bxQRH4wnBoMKo+cx61DDSP4DE+nUAzgwtar8qBonYOd3
 ZhPDAZtJ5oPZqDOv24J1tjeP9ZeKhw8WBNEmtdJhhgX1E01Q0TiO9MfCCEM7Fi35Cp6s
 Y8orYJoaWcGYBVwdYVCbgXT+N7QTWq+QI5yZbIJVQw8imqAACGmEw0L3++b5T41LU/OA
 FrrFve9il9bwQdR4iXcRssZDRBlDSoPiTs8P/OSmtEzhLj/1csbaej2W4YR329OyOOyz
 7nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281412; x=1784886212;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iHvQ+eybWR+zkxX9WTGnNwFJsFoQUov+J3j3VimhWJs=;
 b=cr5JVlJszs0/xYxCRNBU70QNN4xawNh1dZxnPt/tI43xd3vUT2fBGxRfa65N9bIY2N
 FaGccwAStz8pySB7m0CX9c8n6vnm35czw45LdHP7BOpb5hOGz/y7SnEXSPPQey5zTVJh
 okW4ToZGa4RcWoVHCg5HeIIX8ehQxPXSygPgxr2Ok6/DzLrMVFNA6tB3PDeIrY8kQ/KA
 EjtNzXnJHlIte9UG33rT+Cwcpfb+IKufHh6fV9UqTz0I9qfIl6jLFVTH/VdnyfI8D/yj
 wuT7f+SsfTH1OUulQEFC8I9S8PNTRlAVOS3wo9H07fqILShl3eXXYIwWQUHAPoiaWAI2
 y6tg==
X-Gm-Message-State: AOJu0Yy/+zaiMdBEz12AYVxKUTJAPR5rNtMHRlxtbvZFsbojuq4wuupf
 RA5y48mIJ6JMzFZ9/lKKmk0pklW5qnvT16DpfdHo8F3Md+DjqUEeUhAGQrEazMbTkCfqOlbYZUe
 OkLdBiTMbWt4kUwC5XFjs/Wkk3Pi++ACxNGClpeO0gefDp2u0mlT/Ll5FPYM0KHimQ5wS1cOcjN
 9ZD0SScjBwRkqR4Th8Rwe3e/K6YkYS9AY=
X-Gm-Gg: AfdE7cnYXdbjEpYP4fUq4BgMZI43rdY5UUwOVJf99PEFE6S+2iabwJsJAmI411qp1uO
 QAXwjomQqHYzcZgukFFy26FiXwJ2RObxeLMOftGZs6K3oMt9KoxcRi8U9NYfiYrKSyK00Yiv5hj
 svpAW9WmcU2mY+4cwYwgWKVhkdxCzIB0yGXFunOlsQuS++Q0a/OxThFT0=
X-Received: by 2002:a05:6808:1981:b0:4a4:68a9:5f06 with SMTP id
 5614622812f47-4a4d05a8d20mr809667b6e.42.1784281411941; 
 Fri, 17 Jul 2026 02:43:31 -0700 (PDT)
X-Received: by 2002:a05:6808:1981:b0:4a4:68a9:5f06 with SMTP id
 5614622812f47-4a4d05a8d20mr809659b6e.42.1784281411513; Fri, 17 Jul 2026
 02:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132359.96785-1-dbassey@redhat.com>
 <20260716132359.96785-2-dbassey@redhat.com>
 <CAAjaMXbcFtfKqHGUkiKWCsf5aOJ3N18KsyTXQmQLahZS4zR=Bw@mail.gmail.com>
In-Reply-To: <CAAjaMXbcFtfKqHGUkiKWCsf5aOJ3N18KsyTXQmQLahZS4zR=Bw@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 11:43:20 +0200
X-Gm-Features: AUfX_mwGDg-i_SqqFBBGkeD0RsnYrH21IBTyPa4Ucf3LYyvZGHA0Ima614iR1ts
Message-ID: <CACzuRyx8EqhbmqBy6dJBCUty=ZDraYH2vgxA4pDn4O6Hr_+OEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vhost-user-gpu: Forward RESOURCE_BLOB and
 CONTEXT_INIT flags
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
 pbonzini@redhat.com, aesteve@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b683b30656cb6348"
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000b683b30656cb6348
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed, Thanks!

On Fri, Jul 17, 2026 at 8:20=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> On Thu, Jul 16, 2026 at 4:25=E2=80=AFPM Dorinda Bassey <dbassey@redhat.co=
m> wrote:
> >
> > From: Matej Hrica <mhrica@redhat.com>
> >
> > Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT
> > received from a vhost backend to expose it to the guest.
> >
> > Use vhost_dev_has_feature() to query the backend features, matching
> > the existing pattern for RESOURCE_UUID.
> >
> > This allows the guest to negotiate blob resource support and context
> > initialization when the backend (e.g., vhost-device-gpu with Venus)
> > advertises these capabilities.
> >
> > Signed-off-by: Matej Hrica <mhrica@redhat.com>
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > ---
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>
> Nit: this patch maybe should logically come after the patch adding
> blob support (simple reordering).
>
>
> >  hw/display/vhost-user-gpu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index 57360898ca0..06549c98e07 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -643,6 +643,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev,
> Error **errp)
> >      if (vhost_dev_has_feature(&g->vhost->dev,
> VIRTIO_GPU_F_RESOURCE_UUID)) {
> >          g->parent_obj.conf.flags |=3D 1 <<
> VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
> >      }
> > +    if (vhost_dev_has_feature(&g->vhost->dev,
> VIRTIO_GPU_F_RESOURCE_BLOB)) {
> > +        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_BLOB_ENABLE=
D;
> > +    }
> > +    if (vhost_dev_has_feature(&g->vhost->dev,
> VIRTIO_GPU_F_CONTEXT_INIT)) {
> > +        g->parent_obj.conf.flags |=3D 1 <<
> VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
> > +    }
> >
> >      if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
> >          return;
> > --
> > 2.52.0
> >
>
>

--000000000000b683b30656cb6348
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fixed, Thanks!</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2026 a=
t 8:20=E2=80=AFAM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidian=
akis@linaro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Jul 16, 2026 at 4:25=
=E2=80=AFPM Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com" target=
=3D"_blank">dbassey@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Matej Hrica &lt;<a href=3D"mailto:mhrica@redhat.com" target=3D"_=
blank">mhrica@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT<br>
&gt; received from a vhost backend to expose it to the guest.<br>
&gt;<br>
&gt; Use vhost_dev_has_feature() to query the backend features, matching<br=
>
&gt; the existing pattern for RESOURCE_UUID.<br>
&gt;<br>
&gt; This allows the guest to negotiate blob resource support and context<b=
r>
&gt; initialization when the backend (e.g., vhost-device-gpu with Venus)<br=
>
&gt; advertises these capabilities.<br>
&gt;<br>
&gt; Signed-off-by: Matej Hrica &lt;<a href=3D"mailto:mhrica@redhat.com" ta=
rget=3D"_blank">mhrica@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; ---<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
<br>
<br>
Nit: this patch maybe should logically come after the patch adding<br>
blob support (simple reordering).<br>
<br>
<br>
&gt;=C2=A0 hw/display/vhost-user-gpu.c | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c=
<br>
&gt; index 57360898ca0..06549c98e07 100644<br>
&gt; --- a/hw/display/vhost-user-gpu.c<br>
&gt; +++ b/hw/display/vhost-user-gpu.c<br>
&gt; @@ -643,6 +643,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (vhost_dev_has_feature(&amp;g-&gt;vhost-&gt;dev=
, VIRTIO_GPU_F_RESOURCE_UUID)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;parent_obj.conf.flags |=3D 1 &=
lt;&lt; VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (vhost_dev_has_feature(&amp;g-&gt;vhost-&gt;dev, VIR=
TIO_GPU_F_RESOURCE_BLOB)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;parent_obj.conf.flags |=3D 1 &lt;&l=
t; VIRTIO_GPU_FLAG_BLOB_ENABLED;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (vhost_dev_has_feature(&amp;g-&gt;vhost-&gt;dev, VIR=
TIO_GPU_F_CONTEXT_INIT)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;parent_obj.conf.flags |=3D 1 &lt;&l=
t; VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!virtio_gpu_base_device_realize(qdev, NULL, NU=
LL, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; --<br>
&gt; 2.52.0<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000b683b30656cb6348--


