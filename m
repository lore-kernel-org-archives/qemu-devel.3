Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC38C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lOO-0008Tk-1D; Wed, 22 May 2024 08:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9lOK-0008L8-C2
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:48:24 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9lOI-00012R-MC
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:48:24 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51ffff16400so10501053e87.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716382101; x=1716986901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wpymt9Y0fUKa79DEVi6ULRi1cC5HrMhk1eOn00CptPc=;
 b=w5AdLhKjXnv5vhAHLGCuMDiQXNrnfF1mdb2uTikorpiiDXgl/OG0DvRtqgCTc8k2RU
 +v6WXcZMZZNMJTsKUHAJGWy14xIAfbYUGxCJ/S38jmt/gAfApqqsAeU+h3flXs460AsM
 iCeywplT730DQW2myIHgbN4w6fWpTzWYVJBE7hV2epokLlSQk34BxSuDOdr0ccARBCCG
 II6z5wxOtJDDfIcJtsvvu8AvMzeBhe0UcAHzY05v1xZ4+xT5ZsdxFwWqmZRGKEwTfu7Q
 BT2DaJTJOMFweybobteQSCoF1dUIufCCPGih3MI2wI9n90vewPc4ChVq7BRnMRQktN2l
 5PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716382101; x=1716986901;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpymt9Y0fUKa79DEVi6ULRi1cC5HrMhk1eOn00CptPc=;
 b=aC/P1UNFcbViweGpuJSwykWybkJs65UBoQoYtloFwYMIbEwEgkEHUGt1lPkMEdd133
 LPb+Qj47W1UAXmjN4ce3szeLcKsJQ6XaYC/3X8arEZ5nLMxzfo54z+e/Aqf/aZJ8liLP
 nwEidf8IXRb5847ROxm4ljiH/t9cSZG5GuBeBgDVkJBLsmhQxGQlWtPq9BlUx58VVWns
 k8P7yp6OYhseTNToC4Ruf2I++8qqC8X4urNzaVXKs5IpIH9HC9WzrkXUUSx5/cMC6XCy
 kawmAF1ZD+Q4ZuFjkEE+ClOotc4IyrOLib3SSW20NpdnV1vRoPcbX/UDPbizk0CMWYqJ
 fyYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVoVcey5KLRHNqdvsxq1S4w9U+zS/3gugjKnketE2gK87D+TdfqH895jCYO59T6JRxQSrfAedSj7D2oPoIgJl+IBX/w3k=
X-Gm-Message-State: AOJu0YznmbiXkP0WyEdI2UJ5ziuEr1hqqUv0CXP5l254klJAtFfCiMXR
 GMPmRZ0xZguuQt0T4+7qUjoBIiyfzxkBp59aDT/fjhUuBUb3SnuBeo//uDKzPXQ=
X-Google-Smtp-Source: AGHT+IENDINc1YvPsz0y0LI9VmqVeSyQ5+TkgVQOkdoSJsUEDwNye/WRBHkEFBXVpvVaC2bOPmE1rg==
X-Received: by 2002:a05:6512:3e0d:b0:518:9ce1:a5bb with SMTP id
 2adb3069b0e04-526c0b5dc0dmr1490982e87.54.1716382100548; 
 Wed, 22 May 2024 05:48:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm344850366b.210.2024.05.22.05.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:48:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 879FA5F78B;
 Wed, 22 May 2024 13:48:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v12 03/13] virtio-gpu: Use pkgconfig version to decide
 which virgl features are available
In-Reply-To: <20240519212712.2605419-4-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 20 May 2024 00:27:02 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-4-dmitry.osipenko@collabora.com>
Date: Wed, 22 May 2024 13:48:19 +0100
Message-ID: <87r0duggh8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

> New virglrerenderer features were stabilized with release of v1.0.0.
> Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
> with pre-release development versions of libvirglerender. Use virglrender=
er
> version to decide reliably which virgl features are available.

Is the requirement for 087e9a96d13 (venus: make cross-device optional)
on the host or guest side? Because I can't see its in a tagged version.

> --- a/meson.build
> +++ b/meson.build
> @@ -2301,11 +2301,8 @@ config_host_data.set('CONFIG_PNG', png.found())
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
>  endif

If all the host side needs is 1.0.0 then:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

