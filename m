Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9A0CFD370
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrtI-0006Lc-JF; Tue, 25 Nov 2025 07:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrtH-0006It-0L
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:11:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrtF-0005Dg-De
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:11:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so52034065e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764072682; x=1764677482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNtTu+SW6onzqTeI/5cYkedGbHB1Sfk/uwOZENkWvRU=;
 b=wJV6L+5ba0r0VFph5Glmii5AZkvSTDuiT4q1eP8m1dDrs/cMPHMZk9np8Cfb2sla+G
 p8sPuUMOU82OsfhScy99Fv5oQh30rj1gFypn9hbFVE5WMAqQ8PglfrrVhntDXeDtqGcz
 UBLexzaOaWHsvMAhCMFstwQJJtsx+aglJrw9xUrPUIQltCjxB3hCdbar0fGcRe4jwnVb
 1xtkxXbpzpWMSm99a68rQ4k0YJPbZx6zX6r+apkiGexYtozuyQrbSTd5W+coCgmGLHMN
 rdYb25xiAVPA5yq3pa/z+zCX6uoEW0R4v24p3TV0e5plaM+NCXUDmXve41JFkLmpCvtE
 lgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764072682; x=1764677482;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNtTu+SW6onzqTeI/5cYkedGbHB1Sfk/uwOZENkWvRU=;
 b=hoGmR+VAevriQP9vfUIOT7n5RqNDMToRbOYVWPiPki6Uqu9uZqy5dZnsJ2zWu0nef3
 KliFPrbr7WdkIiAbWWoSH021SD5rBPwsyQbtFlMJ1kK+EUAilAaQ022bVI08q6A9wsK2
 mh7FhxtC9eWALtb+ngJxds+4ldAfH3vmtdrR9MrD/btzf3koMiLIN63TDBUTx1x1D4tc
 oa8Orf0F+cktfQQFs4FXJ0hpqeBcC6ABj/AvDoHFvR65uPeGlEYev0hz9svmVUVfr0TB
 WBONepeSn93zg/0cCfgi1TBAI/DGMoPI3gPskNd59C/ynFs4+Z0/dTbRba/VYYu5FLVR
 3d0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWybccK7VJFWZt5ai7U6+Zq5zloNijyOv2uOIuY/9FoRsTCoYDEbqhkyXP7+jHZWaEXnDqOeycXNiMw@nongnu.org
X-Gm-Message-State: AOJu0YwBhWW6Ip5+QMUKI08EagsCuCJ/tF7To9aUhYRmIDwZBtjk65hC
 zDj+YEPmqlmOlK6wFuwOb4ai5hTnIu47Ofcb0EfCSEELWzFYMelg0kVfn0YtGw+8a70=
X-Gm-Gg: ASbGncve/fKmt55KArgFwoCT6WxFxXMDKIkSKYDrP6g+BEcP2/PH7VimON1ly4SrZT8
 xQBZkzCunYWEjTq9yE66tgu5DNs17n6tTP7K+xhNoMaDV031MiSPXexyWgrpTEIrs8dYShmrtqV
 kRYcYSxHk8aSzX0q/RoT/lRsRoBVcATYG0KdeooE+FaC45+sluUPKAaKzXC14/jaInpDYTTdFnp
 vSHUbKaaa+qMgDDtDI1bfAdjMb/JJbdUFWzklw92L9wCb7oFN3TVnZe6bYm/PPBNchjFXRZ8DZ0
 0sa3wbaSJQflJL/KUpiRlsPokdfEMeEulGuMihxQJ0cg/fww63zU3xcggeBoJhbj6MbJNXs98vZ
 KU5wEwE7nAebFE8NDlITIZ5T60ZSDxX4oojZSmmk1Eo921jsu4YleLKkcwo2C2/mygQAElLgCba
 UUV/ZEcO43ROE=
X-Google-Smtp-Source: AGHT+IEoCYGoBDu3aFoZppn2/qFo584uenEpwxxNFqCo1Fiq9WtXU8OzSHrg5yItelBv00leZ3MoVQ==
X-Received: by 2002:a05:600c:c492:b0:477:8985:4039 with SMTP id
 5b1f17b1804b1-477c1143024mr146880775e9.17.1764072681935; 
 Tue, 25 Nov 2025 04:11:21 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e872esm247569025e9.5.2025.11.25.04.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 04:11:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94CAE5F7EF;
 Tue, 25 Nov 2025 12:11:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [RFC PATCH v4 6/7] virtio-gpu: Make virtio_gpu_virgl_init()
 return -1 on error
In-Reply-To: <20251125023517.177714-7-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 25 Nov 2025 05:35:16 +0300")
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-7-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 12:11:20 +0000
Message-ID: <87ldju71nb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Make virtio_gpu_virgl_init() return -1 on error to make it consistent
> with virtio_gpu_virgl_reset() in regards to error handling codding style,
> adhering to QEMU's devel/style recommendations.

See previous comment on other -1 returns.

>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c    | 2 +-
>  hw/display/virtio-gpu-virgl.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index bca7d489c1e3..d65da4863923 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -78,7 +78,7 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vde=
v, VirtQueue *vq)
>          }
>          /* fallthrough */
>      case RS_START:
> -        if (virtio_gpu_virgl_init(g)) {
> +        if (virtio_gpu_virgl_init(g) < 0) {
>              gl->renderer_state =3D RS_INIT_FAILED;
>              return;
>          }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 91951c3ffb0a..9b36b378c2fd 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1371,7 +1371,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>               * Async-fence was bugged in virglrenderer versions <=3D 1.1=
.1.
>               */
>              error_report("drm requires egl display and virglrenderer >=
=3D 1.2.0");
> -            return -EINVAL;
> +            return -1;
>          }
>      }
>  #endif
> @@ -1379,7 +1379,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>      if (ret !=3D 0) {
>          error_report("virgl could not be initialized: %d", ret);
> -        return ret;
> +        return -1;
>      }
>=20=20
>      gl->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

