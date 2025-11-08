Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B2CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 12:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHhdK-0003fA-0b; Sat, 08 Nov 2025 07:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhdI-0003f0-MX
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:01:28 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhdH-0003aQ-3L
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:01:28 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so2600132a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762603286; x=1763208086; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxLlXAeBVR/R0kKVEKmE6yJwRIecnv59s3uY95JfEGI=;
 b=mTJldCPCEZL2WjnjcAbFM4CA0XNxQjSlOngaxnKEjVv3z9327d5Fc8FXdRPAXJtsSF
 NU8EeyJut+gNHvQA8vS4kAyKKRvmmLQup4jTtrzoGPNo12DIxsMrDzhhqjwcm9wX4Gbm
 /uD0LniZP4C6KHuzR4UxXp0r9bY7rX5uzubhYwihOo/fLkXCNW3NGk/n1I6dkAhCtw3w
 1DGp0I9tvoIdxFOtVrzwfJ4V4VC88wmCrWHhRIuT5COV4pg93ij5spr76md+NrzSpBcs
 ZeF4htJMckN6NyZtgQJ7XOWVJcQ95CBgz1H2moK2w08C85qccYQS3mBg7c6FdOZOyqAr
 c60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762603286; x=1763208086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HxLlXAeBVR/R0kKVEKmE6yJwRIecnv59s3uY95JfEGI=;
 b=O2IDtzHl/hfY3bMirdETq9cwPLm5u5TfybGds3CzIBi7LC3Hdp9TANze5ZC9UYrO4x
 TrOylsZoXAiVy5tSdcmmdFNXjaYrAGdSSIHB2FsspEq744SEwXBSAzotdvuqEZ/rlX85
 0nFP8elzTV0g9lcNiWpKStne6ZiJL3FfG+6mDVqWxzByLZKsOPnnsNWCruYx8IByul1R
 CQTsW66LTFYy/8bDIho6IRKpodF+cFMjhtczCcueMHp3feDNXp/e2ndnIFcEJUNWryl1
 AMz4+iBBPkcda5FxvqPjL1g7Fdz1XFE7xSz5BEq801a6BUavp/vD7coPWBvJ1RTbBqVu
 rjzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcKlcaBfFE8SVs0APAEfoVNiihE0fcP+pIE3T9X4/3L3caews9Xmm1LH76x6g3Xyp+T1dXcrFE+a2p@nongnu.org
X-Gm-Message-State: AOJu0Yz1SnKQfHF+D+XZCu2pyL1bXPQZ2YKsS7tAMbMIBxbVzmha7W4q
 SZtAJ5dDd1FAOAI0B7Po0Yk0JOwdDJXmEK4CrPo/HygtUHXE+3PxiieaG3PGI8Lo4Fl/8E+tuUc
 +xnoYF/TaVbYVg3ukc48xszMx+RxMG1E=
X-Gm-Gg: ASbGncvrl36tgEfnOpJeHCUQCv0/Y08YMrsuJ8JrocX2XQuAcaTe+YGWRQWxcv9FaTB
 yiFClF0JGX+egd+B2of9g49wIAeRxkSNAk+93TX0dpziuC20CuXfw+OcwLK2bOxgU75vnSIxGTd
 3CQAfj0sfuXGzhUL+uGreB2O8Eo07+fwrRBT6IyWsAdK58e2HSlG1XA7upE0l1fToC3zjCXDCsD
 vrtH6Kluadojrf+Ol/sNHET5vYYixXef1Y8/chu2gne+swQ0E3/7AcbbE/BpzCuFy9QfYpnYId0
 TRKQFKXrtcye47+C8YzUcW5eworZ
X-Google-Smtp-Source: AGHT+IFNvdiJsqu5xN/9f+VcU71AJAoeBNCkYKgIIiy/GJvrMZeQugqmjTqxbiEuk++A+akbCmpJxqisYrLCNB2kg4g=
X-Received: by 2002:a17:907:86a9:b0:b72:56ad:c9c0 with SMTP id
 a640c23a62f3a-b72e031d60fmr248907166b.17.1762603285583; Sat, 08 Nov 2025
 04:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-10-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-10-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 04:01:30 -0800
X-Gm-Features: AWmQ_bksc4m7yYewYEFCgh6WEmrSK3LxxVysUZire4E3tOwM2lIPuAdRMUJeQHY
Message-ID: <CAJ+hS_iFr5FbRhOvaQTNHweP9Z7_CX5KnJO1ww2RkcMCECfg5w@mail.gmail.com>
Subject: Re: [PATCH v14 09/10] docs/system: virtio-gpu: Update Venus link
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52b.google.com
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
> Change virtio-gpu Venus link, pointing it at the Mesa Venus
> documentation instead of the protocol. The Mesa doc provides more
> information and also has a link to the protocol.
>
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  docs/system/devices/virtio-gpu.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio-gpu.rst
> index f8963c1f13cf..ea3eb052df3c 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -81,7 +81,7 @@ of virtio-gpu host memory window. This is typically bet=
ween 256M and 8G.
>  .. parsed-literal::
>      -device virtio-gpu-gl,hostmem=3D8G,blob=3Dtrue,venus=3Dtrue
>
> -.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
> +.. _venus: https://docs.mesa3d.org/drivers/venus.html
>
>  DRM native context is supported since release of `virglrenderer`_ v1.0.0
>  using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") req=
uires
> --
> 2.51.0
>

Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>

