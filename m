Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF40C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Mat-0004TA-51; Tue, 07 May 2024 11:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4Mar-0004RR-Oc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:19:01 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4Maq-0004fz-1i
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:19:01 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-79291262dc0so226931585a.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715095139; x=1715699939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+h4zAQqUI4H2deth/ON0PNsxHuLEyaZc4P2MWDUBLg=;
 b=PWq31TV7graZ5Qmh9mn9IyNQgjjIvTaRRBOuQrovHmmHMaVsA9YvWNgr/U39whKfLo
 s7ZmsiXaWqphQHAJvnoZ+uXKaDMGts09hNDp3IwDBRQI9AEWyOGqyaNn07DQtcWjgTtQ
 RRoIdSoyH69gXl5PEaBHZ/A3d3RxcM3BqGt4Fk2kmBluatpKLxtyLf8ct36QzZ5+zopC
 u6OlZghYepcdaG+WrcHBGU6uldw487LIQ3NaMPotrCBlwYfo62m6Ajw4DriPNvinD2vi
 uV2Ga0iBD0YQOSZcSvke9E12yOeHxUYSyCmdXcBrmMSQINm8dzvrwvSyVqjhP8in51b/
 QS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715095139; x=1715699939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+h4zAQqUI4H2deth/ON0PNsxHuLEyaZc4P2MWDUBLg=;
 b=ADYLrkUr+Oztj3EaPKhG+NAwqcT3nT1gnDbJLpGOHNMUh2TsqpMGGfliXyEr0v2rJW
 aMx84g1909NA3V4/bi9WaEOO4fzhS4fzkzrch3d5gslRckdfBxI7UbNKE3NxSQc+ThlY
 bwRiBG9lGsTqwPY9SeCT1rJFv9wogplB06QUC1w6Kxx5nofzxBOdwCAfLAc0dbD2beCK
 /g9Vr18wmbbBEe3UmFGLT2bpfycrS8cW1qVi3W5/8v6/TAVZFne5QdWLvt0Oi6ls4mLo
 r5ggxSuwAKslrvIN/UxJB8RbL9y+enl4P61OveSu0SvYgSP9Y/hWvLSyqdPt6CbTcUBp
 a49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPA1kejJtis60T+ImXGjx/j/fR8Uy4xXfj665f2WGxUay6avtkFsdAVCK6Yft4tlznDrVdu36SKyQJDVNIH1+McEMuJ2c=
X-Gm-Message-State: AOJu0YymVWKaXGmaP/uYjNrvdx+0cUFmhZuAOzmOIoLX6eAH6WTUKgTl
 XW2p1okYuWz1LjRIm24fwcj5a2UGm0ea7yB6+uhc1KWbAZ4xIlkndVFummxF9m3FLl2gNKFcPTl
 Y7HbTKjqLfPGKlAOeF4+G00VP6gI=
X-Google-Smtp-Source: AGHT+IGCxsIXrLQP57mG9WbGV/2k3TGJ/8TrymFMOXyAWqsNUUs2OM6AcYMJQ78yrygEHfeQdWgPxq7q749k+bSkaeQ=
X-Received: by 2002:a05:622a:10e:b0:43a:9cd3:7fed with SMTP id
 u14-20020a05622a010e00b0043a9cd37fedmr15759739qtw.17.1715095138676; Tue, 07
 May 2024 08:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-3-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-3-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 19:18:47 +0400
Message-ID: <CAJ+F1CLkZjZ5b_wbVYFtr65UFjnxMR236=_=+mUZBYMO73jr6g@mail.gmail.com>
Subject: Re: [PATCH v10 02/10] virtio-gpu: Use pkgconfig version to decide
 which virgl features are available
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x729.google.com
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

Hi

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> New virglrerenderer features were stabilized with release of v1.0.0.
> Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibilit=
y
> with pre-release development versions of libvirglerender. Use virglrender=
er
> version to decide reliably which virgl features are available.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  meson.build | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 5db2dbc12ec7..f4a4d71c1978 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2286,11 +2286,8 @@ config_host_data.set('CONFIG_PNG', png.found())
>  config_host_data.set('CONFIG_VNC', vnc.found())
>  config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
>  config_host_data.set('CONFIG_VNC_SASL', sasl.found())
> -if virgl.found()
> -  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
> -                       cc.has_member('struct virgl_renderer_resource_inf=
o_ext', 'd3d_tex2d',
> -                                     prefix: '#include <virglrenderer.h>=
',
> -                                     dependencies: virgl))
> +if virgl.version().version_compare('>=3D1.0.0')
> +  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)

If it checks for version >=3D1.0, we may as well depend on >=3D1.0.1 imho,
and then simply use VIRGL_CHECK_VERSION in the code.

>  endif
>  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>  config_host_data.set('CONFIG_VTE', vte.found())
> --
> 2.44.0
>


--=20
Marc-Andr=C3=A9 Lureau

