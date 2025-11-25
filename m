Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0A0CFD370
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrj7-0006Zw-1i; Tue, 25 Nov 2025 07:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrip-0006Xk-RR
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:00:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrif-00029B-Di
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:00:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so41633015e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764072018; x=1764676818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecypEMEzP73TRq5On9WN7Q9wTXhEMaUh4K+vF8OjU5Y=;
 b=vu5/fvpFIw/GI7WIrQ+U7tKdB9m3htwFnQTNU1pMUESF8HziwvmA86kIjEH8sIOWtC
 UhNb8zYFX6sOvF0ZF0+YmK3QkBOxQW6kPMKpkZQChIyhqbiwiU8paMZ2RXgGWl0XCBge
 8VNjlTxGvDJJN8UlBZYSmXsMea3hXYGwIhNDQKjknQE8SNxKQ+c5RItX4zpfrKwwL2qC
 OJnuTqOkMbQOExbyjTgjhlrsEmwg6u8bT2r5phQ592ow/tpJtFbX/T/+AwLixRNA2WK7
 e07ajdUjrXdmVJOG9jUtPilu9TIUgoH1y/11Yuw132hEL8tbdNNl0gXXfVZRC/CPTju5
 1BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764072018; x=1764676818;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ecypEMEzP73TRq5On9WN7Q9wTXhEMaUh4K+vF8OjU5Y=;
 b=aPiE5tTfdcn6Z1CX1nFjpuKjjgUcpfANFrTy6dgwRgT6U+NeIOxu5+iGpNcu4SAhoa
 SntMWXojSGDqEYE9vMWfUjBpQ8Vq1dT+3+n7YmmmLkhv6HCYIC5nLWTR5kzmGfIbhVY/
 NYk+1fTyOv8V6rkG5H8FFEaaNpIz+i9MHDmIDNXOyexfNjb+aTc4H98e/gL5VAkrHXLs
 ibtI4hOs/cuDVI7ttKBG6DjRc08mHkCalYWyV2y7ZtApr49G2H6gwxxGlNyHOOCA9wHt
 KeCXbtm8vmq5DxGR+e/olVMrwnFqQh7GWFgyK8ySFUnn9Yoty3+5iXZO0FXkBh/NDwJf
 DitA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6OwHyRh22BjWsRvj1Hvv1Xr+AyDYPiHMbKvKhNyHqooaqdXWtRzO7e18AlVynaeV/TqNAQkPPqpec@nongnu.org
X-Gm-Message-State: AOJu0YxR3KoI1wQmw7BMKYpis7LMxhMZJWRZhD7qlecS9z/+hR/tn4/6
 RwAJ2ntfWTH7dah3lTS8pHM7xsOp9bCK62RJ1ZJnuT2fjYc7SFacn56Vj2Pgu2SYbyo=
X-Gm-Gg: ASbGncsE3y88xPKqzQUQJt2JGc3JMSWyTvvflUS2mlyO/GRao6m5HopaoNf0/VUtgSd
 8stoF4hD5blTc6PZ99Y4EvlVHls9FKncjb0SDs51t2paeV7I5p6ATmOt0yk9GpSVpkJE9u8BOAl
 DytJcqJZhlqK/Ttff44BuR0Ywd65o+28HS6qm3vUx+ZqA80NIewYJkgb97xHFargN+aNLiLaAhm
 QA6xsSO/oygowhU/wWBorMz9Btli4jh/1UvYoCcUVuyHqo93wtawploALCGxnaDhvWcHoVJg6Po
 0fBZlRS06ypcPz8XGfofWbNWVW6gFvL0XRG/NbyiRRY9L3iTxqYFBeFBLBfefPyS7OLGhMpn9vN
 ZFUXDvsHW2WhFzxrv5UNqC1/T+NT+fqNlbfmdVateOJzJVJQMzx7lyyAY3wM/1Pgqg0qBVKxpob
 pYcJmrLI4E8yM=
X-Google-Smtp-Source: AGHT+IGnTDekjuEhUIJKSl/3EuPc0l/h2oLMDCE7HZx43kcKIH/f6nzIPbw+oRHeM185v5V+6HMf2A==
X-Received: by 2002:a05:600c:1994:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-477c0176437mr159902955e9.4.1764072018404; 
 Tue, 25 Nov 2025 04:00:18 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa41d2sm34010951f8f.22.2025.11.25.04.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 04:00:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA2035F7EF;
 Tue, 25 Nov 2025 12:00:16 +0000 (GMT)
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
Subject: Re: [RFC PATCH v4 3/7] virtio-gpu: Improve
 virgl_cmd_resource_map_blob() error handling
In-Reply-To: <20251125023517.177714-4-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 25 Nov 2025 05:35:13 +0300")
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-4-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 12:00:16 +0000
Message-ID: <87wm3e725r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> Make virgl_cmd_resource_map_blob() return -1 for errors originated from
> external virglrenderer library and respond to guest with most appropriate
> error message.
>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> # guest err msg
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 2224f59cf5d7..edcdad0af232 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -138,7 +138,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      if (ret) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource=
: %s\n",
>                        __func__, strerror(-ret));
> -        return ret;
> +        return -1;

If we are using errno's lets use the defines rather than -1, should this
be -EPERM?

>      }
>=20=20
>      vmr =3D g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
> @@ -789,7 +789,16 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>      }
>=20=20
>      ret =3D virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
> -    if (ret) {
> +
> +    switch (ret) {
> +    case 0:
> +        break;
> +
> +    case -EINVAL:
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;

which isn't what can come here. I see EOPNOTSUPP not being handled either.

> +
> +    default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

