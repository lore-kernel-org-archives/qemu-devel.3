Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186B4CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 12:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHhd4-0003ah-2D; Sat, 08 Nov 2025 07:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhcq-0003Qn-5x
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:01:00 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhcn-0003V4-3f
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:00:59 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so288427766b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 04:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762603254; x=1763208054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpVrbZEnX82NBOxqZe4YJ85tlDw01p0dL/YVnF/lX3c=;
 b=dIvWZ2MYsE28e95n/7twZzGuxHaXTX4eFRxfUN5vG4KzekvcIsgt1kA950UOoaCUPS
 fOWRb3E37tg7cMsJgVGrdUCjD3GAfRVRMbwIzlEdkmL3g9Ygc5uU+9yoYT5G85FahhP0
 KGiNN+fwj5uU5/bC/j1xxdeyfoCmAVg/5CQquP4+3SJadoK0cH/2A2V0lJFbtYwkBFIZ
 /G15dYNzFOpd72kthESVzbaiJFBsOWZPzGeVSPy9IqyjoemhaNtnvsYLNKJOI6Fp36Ds
 5p76Nf5kfOlZLK/N09Js5vIVDV7fN+7eB1/iy1T73aWOQh7biHS6wg9ijt/1pIrFpO+V
 pbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762603254; x=1763208054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JpVrbZEnX82NBOxqZe4YJ85tlDw01p0dL/YVnF/lX3c=;
 b=oskZvN6FsZMxZ758Q088JxDcUs8rFqwVg+7K2EL1i6OBRbYFUV2KN0tH3XcXy3LL9Z
 +N3crmmpqcw660vcFJjRhTqq/VoddHccl5GeqA7z/1S444MxjRmTx6Q448QJeUjCMaef
 wv31bVNVTabF0Xzo4RLVET8IKk15pu7ddo14j0u5bgpSeMyPrm1U68pnh9c4NHkn9k2F
 g+T6Ms/znGlEJzQ6Q/z8O/tjizaTQ4CJw3nOlX8WDXi/lvOX2kTQOodl42iJp4dbJzcJ
 8WwgIJ6luAJ/Y7yPnh1pmdIcjgimu5F+dQlbSPEWhfqphDZQ8ESioz0Y8kzRYqfwQJ0M
 i0FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUowW30KcUoJBfXwW2kokiny9q+Qj4zJgtRdgZtScg7IDJ6K2AJTq5QY3bqriv6b3S91BkEgI2XyxcF@nongnu.org
X-Gm-Message-State: AOJu0YxbUOSRadcshY0dlydtQXEnfumstTkGP0mujuWdo0HY8r5ei7Ok
 NnG87bm6Uc1UDdIdy6lbpH7w8bnkaqWvJpDqGnrAmkwFLVseCztzPo1mYzhFfppTGWQJNCYs0df
 XQBavXrfG2XeUj+BGN+JMqPeayfPl5JQ=
X-Gm-Gg: ASbGncvYsW9U97yCC23MAE9PH7cTnL3AqUdbNVs1K1CxyUk0UDXx6boWbbZfRH3Z3y3
 +F23KlZsz5j7xoXK4sVfFN9jRLAf50Y8XHRSFu/8s6pHPIKvrpOmxxcXemMnPpfjtlfb/IXHoYI
 WfzwqSkTtbDyqSeCfZtrghdY/0kKeiDjtSu/nv74+zDXKR+fA1ojmgWmDjADqqey439zIEP2+c0
 RFOnVs7eQDKAJh65NAjhhy+XB+4roAka7ZLU/Yu8inNOKDqNhgYBZrWUISfg9wGYHt79ew3WyJp
 UUmozoikBsOCbTNTSHryavZBV2sJ
X-Google-Smtp-Source: AGHT+IEajwkekfk8+YHXgFdrhSUsX2gybPaJYXaq5eUqY8tjM+hl/2V92Jsmm0wpDkBes5k4wh1vp65kB6Gox5e5BSw=
X-Received: by 2002:a17:907:db16:b0:b72:d577:11cc with SMTP id
 a640c23a62f3a-b72df98c024mr256577066b.12.1762603253750; Sat, 08 Nov 2025
 04:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-9-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-9-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 04:00:58 -0800
X-Gm-Features: AWmQ_bloqyaEYrVxqeOD_hl3TC_MU2TxU9k5UJ_WQmpgHv1y_CHluXrsotE5xJ4
Message-ID: <CAJ+hS_i11mP_FoEzw=40xq1noW4DHWwySWFOWtWD-crru0Vh7A@mail.gmail.com>
Subject: Re: [PATCH v14 08/10] docs/system: virtio-gpu: Add link to Mesa VirGL
 doc
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Oct 20, 2025 at 4:43=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Extend virtio-gpu documentation with a link to the Mesa VirGL
> documentation.
>
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  docs/system/devices/virtio-gpu.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio-gpu.rst
> index f20c60016376..f8963c1f13cf 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -59,7 +59,7 @@ on typical modern Linux distributions.
>  virtio-gpu virglrenderer
>  ------------------------
>
> -When using virgl accelerated graphics mode in the guest, OpenGL API call=
s
> +When using `virgl`_ accelerated graphics mode in the guest, OpenGL API c=
alls
>  are translated into an intermediate representation (see `Gallium3D`_). T=
he
>  intermediate representation is communicated to the host and the
>  `virglrenderer`_ library on the host translates the intermediate
> @@ -68,6 +68,7 @@ representation back to OpenGL API calls.
>  .. parsed-literal::
>      -device virtio-gpu-gl
>
> +.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>  .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
>  .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
>
> --
> 2.51.0
>

Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>

