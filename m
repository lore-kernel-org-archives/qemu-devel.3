Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB81CC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GXd-0000w1-QN; Thu, 03 Sep 2026 19:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1x2GXb-0000vl-Kz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:08:19 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1x2GXZ-0003q8-KN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:08:19 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5302b692c8eso5098771cf.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788476896; x=1789081696; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JwgrgTq036FRNKZQmg0CTD2iJdFD3WmAR9Nmcy/gTfc=;
 b=DTKYndksKdl2UvCM+eookkAQ6UzcR/lVxLfD6EnUFWEmVai5j0TOz2rf4Ou+2llqw/
 IEAzE9Cpb7mYpz9E/wG8xWaXtECU1P4dqLZmKQYVgL7F406Bj1UE51XIrWT+hgm/TWn7
 wtsmrrJ2VLIiOu70xLeYaS9VNuV4YYweJBbS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476896; x=1789081696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JwgrgTq036FRNKZQmg0CTD2iJdFD3WmAR9Nmcy/gTfc=;
 b=m5jHWl5dz6gWfFf75z6qHa9GhlTprp4UXll2sQwdFXQeYdlg2xZwyWmjfyBX5lc522
 qqwQ6y3tI/QYNwAXWzlW0WUOvih62izJm9WU//W9R+sLlf0aJ9KFn7p21fDYmL2S90Ml
 4n42nv5/SM6szaJLmayhopcUWoukl6lMotIzQxciW5mx7GWKHM9n5LYeGTAfNO0O6HeH
 gBL1pZvb72lk7DK82DHfdmytG+4Dlcyyg08b2UjNlRpvYm4614iJ3n8Z7OIAuEdUMBzR
 Xq/iozv9cqB2hBdQAd54J56LEHyUYR5+S7K0MITRagMqR7e0gEWS4PuHFySVpHJeorPx
 Rtzw==
X-Gm-Message-State: AFuF++lUHkbjRO+FdyLQ3VPrxK0vBKf/V2A1sqQtsjYVe7bJv88eK10l
 eyEeuxu7zBPPWs5kW1Qg4l1V9xokiuKQTAmmGj04b1YaFeZXJdhaDuJcszb2crjirzJqHCtLuAD
 UlwbKPw==
X-Gm-Gg: AYBFou0f6A0MTDRs5pcu52nnBAoLsM+eHvpCfXh+SgkG1AzSx1WlFhiRlc1B463XqCm
 IcSjiIwQ/yRwvfCvYpJwQr0uXpT01PMVsqgazywyAFqKc/Dolf4vkLVzO2dTKStIDfDMx0Nr1+H
 Mh2ZKDcZ+JsH++6HurAEnLACFbpSLdbyXLe0K59PScZOuUeyxMO56lhdedj3okj75eg8S2EGVPj
 C20jef94EBJpMGNKLucCsO+aoeNSywtyjQW4hVNMuOqWmyGe1CG+fXKVOwlLTWvoG3zN+z+M2lg
 7AoE52nwiNnubecg8O1LPjso//vnkN5XYAjIfPdVYk+/OAr7puZcLgo+heqfjaaghJOZSDX0q03
 c/Wb2OtmyEYkWa8RqI8J7ydrSFY5aVZRdLW061A4Fd5Vs2zaM51hdkjVZTQPfegk3dmKKip4bnI
 IFdVt35iZw0yj+Jh9t7/JmrYa1CRLjxkKEDoR3fBGQUGSooDEmcQ0tHiQ+8xV8Te6nbpCWdd9ZM
 4WItTgSjBDWqT+vHVrQauVbEgE2uH1JEFFzsgc62SHBfxU=
X-Received: by 2002:a05:622a:1489:b0:52f:bc89:4933 with SMTP id
 d75a77b69052e-5305483d9ecmr21898481cf.20.1788476895468; 
 Thu, 03 Sep 2026 16:08:15 -0700 (PDT)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com.
 [74.125.230.204]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530541f28c0sm7243261cf.27.2026.09.03.16.08.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 16:08:14 -0700 (PDT)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-530411c7ee1so36991cf.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:08:13 -0700 (PDT)
X-Received: by 2002:a05:622a:5917:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-53055ac957cmr4581311cf.12.1788476892732; Thu, 03 Sep 2026
 16:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 3 Sep 2026 16:07:58 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmt=vXSnmgJoc9=QT6QCF2vkpzZpFkToG0swgV--37VoA@mail.gmail.com>
X-Gm-Features: AcwNN1VRUJtS7-2pNP8amkw1JXCOJG015npQb-xFu71SUFKPmJjmgo4qn3GFfvY
Message-ID: <CAAfnVBmt=vXSnmgJoc9=QT6QCF2vkpzZpFkToG0swgV--37VoA@mail.gmail.com>
Subject: Re: [PATCH] docs/system: virtio-gpu: Update Rutabaga link
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000e2a537065a9c3910"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e2a537065a9c3910
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:28=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u-toky=
o.ac.jp>
wrote:

> Rutabaga was externalized from crosvm:
>
> https://chromium.googlesource.com/crosvm/crosvm/+/481338d967d5c8b506e17b8=
e335798f5cb89d7ee
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  docs/system/devices/virtio/virtio-gpu.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst
> b/docs/system/devices/virtio/virtio-gpu.rst
> index d05f8cb8e3f9..8ce4da306acd 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -185,8 +185,9 @@ rendering and `Wayland display passthrough`_.  With
> the gfxstream rendering
>  mode, GLES and Vulkan calls are forwarded to the host with minimal
>  modification.
>
> -The crosvm book provides directions on how to build a `gfxstream-enabled
> -rutabaga`_ and launch a `guest Wayland proxy`_.
> +rutabaga_gfx's documentation provides directions on how to build a
> +`gfxstream-enabled rutabaga`_. The crosvm book provides directions on
> +how to launch a `guest Wayland proxy`_.
>
>  This device does require host blob support (``hostmem`` field below). Th=
e
>  ``hostmem`` field specifies the size of virtio-gpu host memory window.
> @@ -214,7 +215,7 @@ Surfaceless is the default if ``wsi`` is not specifie=
d.
>
>  .. _gfxstream:
> https://android.googlesource.com/platform/hardware/google/gfxstream/


nit: gfxstream link is also incorrect:

https://github.com/google/gfxstream

now


>
>  .. _Wayland display passthrough:
> https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
> -.. _gfxstream-enabled rutabaga:
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
> +.. _gfxstream-enabled rutabaga:
> https://github.com/magma-gpu/rutabaga_gfx#rutabaga-c-api
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>
>  .. list-table:: Linux Host Requirements
>
> ---
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
> change-id: 20260801-crosvm-658027011cb5
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>
>

--000000000000e2a537065a9c3910
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 1, =
2026 at 4:28=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.=
u-tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Rutabaga was externalized from c=
rosvm:<br>
<a href=3D"https://chromium.googlesource.com/crosvm/crosvm/+/481338d967d5c8=
b506e17b8e335798f5cb89d7ee" rel=3D"noreferrer" target=3D"_blank">https://ch=
romium.googlesource.com/crosvm/crosvm/+/481338d967d5c8b506e17b8e335798f5cb8=
9d7ee</a><br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.a=
c.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
---<br>
=C2=A0docs/system/devices/virtio/virtio-gpu.rst | 7 ++++---<br>
=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/device=
s/virtio/virtio-gpu.rst<br>
index d05f8cb8e3f9..8ce4da306acd 100644<br>
--- a/docs/system/devices/virtio/virtio-gpu.rst<br>
+++ b/docs/system/devices/virtio/virtio-gpu.rst<br>
@@ -185,8 +185,9 @@ rendering and `Wayland display passthrough`_.=C2=A0 Wit=
h the gfxstream rendering<br>
=C2=A0mode, GLES and Vulkan calls are forwarded to the host with minimal<br=
>
=C2=A0modification.<br>
<br>
-The crosvm book provides directions on how to build a `gfxstream-enabled<b=
r>
-rutabaga`_ and launch a `guest Wayland proxy`_.<br>
+rutabaga_gfx&#39;s documentation provides directions on how to build a<br>
+`gfxstream-enabled rutabaga`_. The crosvm book provides directions on<br>
+how to launch a `guest Wayland proxy`_.<br>
<br>
=C2=A0This device does require host blob support (``hostmem`` field below).=
 The<br>
=C2=A0``hostmem`` field specifies the size of virtio-gpu host memory window=
.<br>
@@ -214,7 +215,7 @@ Surfaceless is the default if ``wsi`` is not specified.=
<br>
<br>
=C2=A0.. _gfxstream: <a href=3D"https://android.googlesource.com/platform/h=
ardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">https://and=
roid.googlesource.com/platform/hardware/google/gfxstream/</a></blockquote><=
div><br></div><div>nit: gfxstream link is also incorrect:</div><div><br></d=
iv><div><a href=3D"https://github.com/google/gfxstream">https://github.com/=
google/gfxstream</a></div><div><br></div><div>now</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br>
=C2=A0.. _Wayland display passthrough: <a href=3D"https://www.youtube.com/w=
atch?v=3DOZJiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.yout=
ube.com/watch?v=3DOZJiHMtIQ2M</a><br>
-.. _gfxstream-enabled rutabaga: <a href=3D"https://crosvm.dev/book/appendi=
x/rutabaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.de=
v/book/appendix/rutabaga_gfx.html</a><br>
+.. _gfxstream-enabled rutabaga: <a href=3D"https://github.com/magma-gpu/ru=
tabaga_gfx#rutabaga-c-api" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/magma-gpu/rutabaga_gfx#rutabaga-c-api</a><br>
=C2=A0.. _guest Wayland proxy: <a href=3D"https://crosvm.dev/book/devices/w=
ayland.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/d=
evices/wayland.html</a><br>
<br>
=C2=A0.. list-table:: Linux Host Requirements<br>
<br>
---<br>
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475<br>
change-id: 20260801-crosvm-658027011cb5<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" target=3D=
"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
<br>
<br>
</blockquote></div></div>

--000000000000e2a537065a9c3910--

