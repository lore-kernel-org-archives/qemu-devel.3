Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474B3C02195
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 06:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tepbe-0008CP-A9; Mon, 03 Feb 2025 01:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepb9-000894-5g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:06:21 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepb6-00027O-92
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:06:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2166651f752so75966405ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 22:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738562774; x=1739167574;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnMl1M5wNXF5ZrFlpPquQyUKDLC5VeTh3y/GGEQe7aE=;
 b=mNN+8lJFE9VYnv4o78pFEuNwXeetvVpcO6A5V2me33m82bedzmh73T3Z3Sbu2DOsBL
 B5bFU18h+wf0zr/+36Pc6gfeIWEaBQlpLuJVkPsuxl7xLQh3fNwnILp6swQ+xh8qV6XD
 9LKkOjkTTlQbJPRBzuC4w0DaaNRWez4mRL218hGn9NiHOr7P7YtYwIQlVWCbdRU7srA5
 EztldFe3LmLP0kAp4djxQFCmuJKWV4I1Sj5n06Y/nIgHoj2zq8aNo3pfHiOuXCypiLPi
 1EAkj0tt7ikfd0VTW3vMfP+RXzzTmIqTVDwcU7w/ImUAxw2bSO+4hWqlqKCtZsIl5mox
 e2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738562774; x=1739167574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnMl1M5wNXF5ZrFlpPquQyUKDLC5VeTh3y/GGEQe7aE=;
 b=LnCI/68iEgfk2TeRtjDTbtwdUC0o8t5RfLrCH5w5KDWPjmpjy6ppSLbQntoQlCOKv6
 HdMCYBtc8e689ZfzmurreBwHZAbqospiSZXHAloQBifVDQA+wMpktS4vNHT+QB0tLkN3
 MwJQZKdUBdpAf1DMwdX6HOjdZv4GMGTsFkMwGn4OFJzSxoiUxMIBD4vcNcxggrK4cYB9
 Q45A0hQ1R1RFUrQbcAFwC8vskNO0HaTvmTm00jGczLy/fli1/dLpqcd4ULSGFRSZEb41
 03M8Q4srIdz6wEveNB3MfibxR4vgDtr8StHcJ/lsf0+YVeHABU1n7X190gsYvBNbkJQq
 t/Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmV4EvU3JdMem614cN/x9cBGimYAWztfVKAr9A9+PHqhHo/ZRj9HlZR2r5MPQdhUKEpTz7E5Y0Yty0@nongnu.org
X-Gm-Message-State: AOJu0Yz3CCnWlzf/aZ6y2eo58MvFD3uEBpIjY8EBE3PUsWqltcPenncP
 FcmMI/u61Q9BH7RPxDcyuNKeICn5/btA3dPY62tcbQmPVe5OU1ORkhiIuGS/sTg=
X-Gm-Gg: ASbGncuLME5SSZey6IKxApyxvKOtklRxBXakvDfpKMwaQ4b2pr7Zc1YHbskCLuTxpGw
 XMx5m/wEjaKcYFfED6tJWZBp/c8Av7UqRBKvS6DWYxZ0H3t/+0XtRIEFBUSxv5QCNUILY++XJT3
 IQ7satujXu2BWMRaKJy0noKpx5z0YPe0CLAgqfsnb4YsdTeM6RkJRZGfrsKb/nd2L8sTGR+LxpV
 VR/2z59h2S+SvCDCaVRt8odDK+DaGSyV5+iz351SU7AZfao84/2FY7UHl2PTqD9hexz/wVpC3K9
 vsR4q8hwsevQN+/qN4vJkxZpWGzN
X-Google-Smtp-Source: AGHT+IE8bZmwO75cLOYbzv4k9Yh8vfI/RcFGEfOplGP7+GCii8epVe4dj0Vgd/Ur18A5DHlnwn/oKg==
X-Received: by 2002:a17:903:98f:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21dd7dff8c1mr384009705ad.44.1738562774548; 
 Sun, 02 Feb 2025 22:06:14 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eba6fsm66936845ad.107.2025.02.02.22.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 22:06:14 -0800 (PST)
Message-ID: <9b81ef95-6dec-43cc-9adb-8878ced90c07@daynix.com>
Date: Mon, 3 Feb 2025 15:06:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] docs/system: virtio-gpu: Add link to Mesa VirGL
 doc
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
 <20250202232136.919342-9-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250202232136.919342-9-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/03 8:21, Dmitry Osipenko wrote:
> Extend virtio-gpu documentation with a link to the Mesa VirGL
> documentation.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   docs/system/devices/virtio-gpu.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index f20c60016376..f8963c1f13cf 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -59,7 +59,7 @@ on typical modern Linux distributions.
>   virtio-gpu virglrenderer
>   ------------------------
>   
> -When using virgl accelerated graphics mode in the guest, OpenGL API calls
> +When using `virgl`_ accelerated graphics mode in the guest, OpenGL API calls
>   are translated into an intermediate representation (see `Gallium3D`_). The
>   intermediate representation is communicated to the host and the
>   `virglrenderer`_ library on the host translates the intermediate
> @@ -68,6 +68,7 @@ representation back to OpenGL API calls.
>   .. parsed-literal::
>       -device virtio-gpu-gl
>   
> +.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>   .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
>   .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
>   

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

