Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2847E68972
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 10:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6SIi-0000mx-QO; Thu, 31 Oct 2024 06:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6SIh-0000mk-2E
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:21:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6SIf-0005aq-4D
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:21:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so424344f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730370067; x=1730974867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=989LZbxRnF6UzNiAW06QVm9ckKJdqwqMEsNulAnO9AE=;
 b=OsAz59BAKqwiQ9CTupPu/oMpX27P16z9ujLbu0dbla4OB1TjiulKxuDOjWKK5az3B+
 hApkVXShcENt2hHSiSiCFE1eMbMLtDZaaurGzTFFapT6kQEZvuwrKVSmbxwK7aWuiZBv
 /Ukyg5st9bgPajBujewvZj0CcA5r1Qo+xOamNDqm2SfS/uRbunnorNh4840dQ0uFpyps
 xyWj1QAn8uzUSiJchy8pDr34GDfYZdHI/evwc3ArOLPBnlhCyyM4MaVCxVBo3zy4eZas
 IfkJp5XqqYxwh9BDQhkJtzwht6wtUutbwZ8g55QDTvdO2mVaaoDzbLc7fZi0/jpDHP3a
 07BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730370067; x=1730974867;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=989LZbxRnF6UzNiAW06QVm9ckKJdqwqMEsNulAnO9AE=;
 b=Ll54ALaECWVdbQA6XNIC2FE8diGgDtxTIuCVe4/yiEdtz646q2//tvuT0nRNLVgzxy
 NW7jFSKBwdbVPUxGQ6qfiNoN25gz06VUFVCbkt69bdckXrk0bQvCc+V9/O0/7Z9h1Cgu
 /9i9L2YjF/lYgWyhzk3jivSrHvCsjwNN4FnHQn+DqbCH28HCiMCRobpp/iSidLw7rVPF
 CixoUa2L3hXmbMsSS7MyZqGi6C+fteidK96G2OHYA6to+ZOruJE3AWcBHuqAUFeNM+g2
 vJuUMw4Ut/Zf+DtkTWKnZ3E+kRIHPjnANVLU1ncGnk7/8TzM3wr2pSQI9gzsPTIEgHCN
 F0pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8GJdhtacX/tgGbNfs1baQsI0YdWuigY/QrDyfmhBZKiQSL06jxHjWIXzsQSrKTG59h60d6dBaozwE@nongnu.org
X-Gm-Message-State: AOJu0YxziLg+eFekWCdimUyeUJ3WxVhuA0bWhvEKNSpDxZSR8EyZVbxr
 MwJ6gIq4iira4b6bytuCY8TRUlkZuR9Vh7NCCr1SzY4wqMkOVjM7+/36AD92Ekw=
X-Google-Smtp-Source: AGHT+IEC7u7mGwV94xtXApMUkNnNBweDtMbxV7hPBAtJaZ9fVvpS/66OGW9PsYhgSoSxaKp7hRKMJw==
X-Received: by 2002:a05:6000:144e:b0:37d:4330:c87a with SMTP id
 ffacd0b85a97d-381c13072e8mr1643674f8f.4.1730370066915; 
 Thu, 31 Oct 2024 03:21:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e51csm1687666f8f.79.2024.10.31.03.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 03:21:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AA285F780;
 Thu, 31 Oct 2024 10:21:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v3 4/6] virtio-gpu: Handle virgl fence creation errors
In-Reply-To: <20241024233355.136867-5-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Fri, 25 Oct 2024 02:33:52 +0300")
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-5-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 31 Oct 2024 10:21:05 +0000
Message-ID: <871pzwk1ym.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> Print out error messages when virgl fence creation fails to aid debugging
> of the fence-related bugs.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index eedae7357f1a..3c564683820b 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -892,6 +892,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
>      bool cmd_suspended =3D false;
> +    int ret;
>=20=20
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>=20=20
> @@ -990,7 +991,16 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      }
>=20=20
>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
> -    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
> +
> +    /*
> +     * Unlike other virglrenderer functions, this one returns a positive
> +     * error code.
> +     */
> +    ret =3D virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> +    if (ret)
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: virgl_renderer_create_fence error: %s",
> +                      __func__, strerror(ret));

braces please. Also if ret is only used for the if leg you might as well
combine it:

  if (virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0) !=3D 0) {
    qemu_log_mask(...)=20
  }

>  }
>=20=20
>  static void virgl_write_fence(void *opaque, uint32_t fence)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

