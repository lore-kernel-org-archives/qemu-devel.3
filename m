Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A20D43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92Ge-0007FH-22; Thu, 07 Nov 2024 08:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t92Gc-0007Eh-T3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:09:42 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t92Gb-0008Mj-2v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:09:42 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6e9ed5e57a7so7459017b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730984979; x=1731589779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPc/MAs6E/bZJz9LcygnOiZXSNgBI032PG+AUE6p8TE=;
 b=CW42y3D3tPqOw9Sxo7Z4c0QOkBXqdyQi8ayCmdAOMkvsKt4fhhW8zO95WVdxZF149l
 DGcmeUjgMGIjk1nLorSLjnVJwKSqKzz0b7+0Ekut1b5A4bpdDBdloUBW5X1nYjYCkciO
 U8Vo69spHfy2MBxQggrVPyHlV+1xH9nZwjHywBzAxQbev8HS7Uk5/AOxwSAI8ehng11p
 1UXf0PoY/X9eukF+U1ur4HOOMpMhk5q69MBl9+dnobllFTXUwxaal5hdEnR7xZHTx2rV
 38s74AprZJqsKJLvGkYw+tiIR0wU1KTUX1IGSjHCvs+veDgC8JnmT8EzauBTBZNgK76k
 Zz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730984979; x=1731589779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPc/MAs6E/bZJz9LcygnOiZXSNgBI032PG+AUE6p8TE=;
 b=wiRE4CTS2/XbTF+E083RgLTDxwZCwsYNpESe/xBfaGn6y50jPp5EwsrYoJPdkYmEjx
 gwcgEuEGtih2GV7mpGxi7SezLliGtRL9vfz3K/9MdsofesLAidXL2jVztBTknb12YBIR
 CAVDqVYbxbX2nnB/YzEjFP9/JwvDk9goW6qVW1VuA8GiaxY1AlYF5D4nU2MpTO52QCbf
 wN8zXEPE7he4WApTLHN3AhxTD1Q9ya3Lkso9gAIYwQk7odcZ3m+taneqhYF4zT9ClzDk
 0o4SsECANs/16eFU0A+8qQX0U7+bIVC50qdI8CGQBbczOYCNKDzs71rr2AiWHWbgqN3w
 AEGg==
X-Gm-Message-State: AOJu0YwphnEBzorpKDf3fa+Krytp91yBkPlf02RGSwGJ1imqV2anMSTx
 WyH5di52/W8BF7yFoPesed28MAQA9mVjBlUoP/Kt620CpO+WIPLZ9bH2sbiYvClic+ZzfQu37La
 wb1TQQ+B/1W41SrMZfEq+oK1m4/Y=
X-Google-Smtp-Source: AGHT+IHMxVEdSfDrb6vjJvT4WfDo7UDBEpAOCnFHHcX8Us5DogoUnwWL8VwqBJ4UZbLJRKwnTt+Ww10O99UyxiM3e/8=
X-Received: by 2002:a05:690c:648a:b0:6e2:2600:ed50 with SMTP id
 00721157ae682-6ead5fc3f5bmr12739387b3.21.1730984979601; Thu, 07 Nov 2024
 05:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20241007070013.3350752-1-dbassey@redhat.com>
In-Reply-To: <20241007070013.3350752-1-dbassey@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Nov 2024 17:09:28 +0400
Message-ID: <CAJ+F1C+xoof_ZWkyi1Qrx4=9NsAq_v8tLrV0PHpwWapprkA2ng@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: Add definition for resource_uuid feature
To: Dorinda Bassey <dbassey@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d2225b06265258ad"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d2225b06265258ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael, Alex,

Any of you could take this in the next virtio-related PR?

thanks

On Mon, Oct 7, 2024 at 11:01=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com>=
 wrote:

> Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
> of resources UUIDs for export to other virtio devices.
>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/display/vhost-user-gpu.c    | 4 ++++
>  hw/display/virtio-gpu-base.c   | 3 +++
>  include/hw/virtio/virtio-gpu.h | 3 +++
>  3 files changed, 10 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 14548f1a57..aa6c6416fa 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev,
> Error **errp)
>          error_report("EDID requested but the backend doesn't support
> it.");
>          g->parent_obj.conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLE=
D);
>      }
> +    if (virtio_has_feature(g->vhost->dev.features,
> +        VIRTIO_GPU_F_RESOURCE_UUID)) {
> +        g->parent_obj.conf.flags |=3D 1 <<
> VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
> +    }
>
>      if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>          return;
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4fc7ef8896..7827536ac4 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev,
> uint64_t features,
>      if (virtio_gpu_context_init_enabled(g->conf)) {
>          features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>      }
> +    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
> +        features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);
> +    }
>
>      return features;
>  }
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index 7a59379f5a..f12869376c 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
>      VIRTIO_GPU_FLAG_BLOB_ENABLED,
>      VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>      VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> +    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
>  };
>
>  #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
>  #define virtio_gpu_rutabaga_enabled(_cfg) \
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> +#define virtio_gpu_resource_uuid_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED))
>  #define virtio_gpu_hostmem_enabled(_cfg) \
>      (_cfg.hostmem > 0)
>
> --
> 2.46.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d2225b06265258ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michael, Alex,</div><div><br></div><div>Any of you=
 could take this in the next virtio-related PR?</div><div><br></div><div>th=
anks<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Oct 7, 2024 at 11:01=E2=80=AFAM Dorinda Bassey &lt;=
<a href=3D"mailto:dbassey@redhat.com">dbassey@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Add the VIRTIO_GPU_=
F_RESOURCE_UUID feature to enable the assignment<br>
of resources UUIDs for export to other virtio devices.<br>
<br>
Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com" tar=
get=3D"_blank">dbassey@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 | 4 ++++<br>
=C2=A0hw/display/virtio-gpu-base.c=C2=A0 =C2=A0| 3 +++<br>
=C2=A0include/hw/virtio/virtio-gpu.h | 3 +++<br>
=C2=A03 files changed, 10 insertions(+)<br>
<br>
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c<br>
index 14548f1a57..aa6c6416fa 100644<br>
--- a/hw/display/vhost-user-gpu.c<br>
+++ b/hw/display/vhost-user-gpu.c<br>
@@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;EDID requested but the=
 backend doesn&#39;t support it.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;parent_obj.conf.flags &amp;=3D ~(1 =
&lt;&lt; VIRTIO_GPU_FLAG_EDID_ENABLED);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (virtio_has_feature(g-&gt;vhost-&gt;dev.features,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_F_RESOURCE_UUID)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;parent_obj.conf.flags |=3D 1 &lt;&lt; VI=
RTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, e=
rrp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c<br=
>
index 4fc7ef8896..7827536ac4 100644<br>
--- a/hw/display/virtio-gpu-base.c<br>
+++ b/hw/display/virtio-gpu-base.c<br>
@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64=
_t features,<br>
=C2=A0 =C2=A0 =C2=A0if (virtio_gpu_context_init_enabled(g-&gt;conf)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features |=3D (1 &lt;&lt; VIRTIO_GPU_F_CO=
NTEXT_INIT);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (virtio_gpu_resource_uuid_enabled(g-&gt;conf)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 features |=3D (1 &lt;&lt; VIRTIO_GPU_F_RESOURC=
E_UUID);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return features;<br>
=C2=A0}<br>
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.=
h<br>
index 7a59379f5a..f12869376c 100644<br>
--- a/include/hw/virtio/virtio-gpu.h<br>
+++ b/include/hw/virtio/virtio-gpu.h<br>
@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_BLOB_ENABLED,<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,<br>
=C2=A0};<br>
<br>
=C2=A0#define virtio_gpu_virgl_enabled(_cfg) \<br>
@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {<br>
=C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_CONTEXT_I=
NIT_ENABLED))<br>
=C2=A0#define virtio_gpu_rutabaga_enabled(_cfg) \<br>
=C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_RUTABAGA_=
ENABLED))<br>
+#define virtio_gpu_resource_uuid_enabled(_cfg) \<br>
+=C2=A0 =C2=A0 (_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_RESOURCE_UUID_=
ENABLED))<br>
=C2=A0#define virtio_gpu_hostmem_enabled(_cfg) \<br>
=C2=A0 =C2=A0 =C2=A0(_cfg.hostmem &gt; 0)<br>
<br>
-- <br>
2.46.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div>

--000000000000d2225b06265258ad--

