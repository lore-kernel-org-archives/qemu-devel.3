Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3459CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVjx-0006H4-Vx; Tue, 02 Sep 2025 14:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVjs-0006DX-Gg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:28:18 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVjo-0001Wm-Gg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:28:15 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b0449b1b56eso219803666b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756837688; x=1757442488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG5FNp1RElQvH6JG9ZDM1JzhgZOsdpynvAe/KLRt/3g=;
 b=o1aUgyr3/j5ksHaxfdGKZT2yZEalUPj6e7QpRmRqPgFcqCMl7ucwgnw7vvU7h721w4
 gYVMrAS1cH7WNCZ7/GbndSla7rzoosMb9ZcHEUstIkJddTl24+tF6J1cRKjjZ4jk7e+5
 rEB2CLUD90IvJnAkeGl4sirFYXZ0eI4yooC0+0JmAb/7KKPr2qyC6wRK5q1uo3c9LD46
 uqMBBUROU80mhBEoVcnTKogrtcuHnlZ6Fae0iKXDR/CzjuRXWgGAeIqIM1GQLSiHbOeu
 JhplEbUB+HhN4TIvqxg1F7KFjbdr8iBiCnCMY0togD0XW7aI/3nBFunGdyiipQn89MPD
 egjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756837688; x=1757442488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cG5FNp1RElQvH6JG9ZDM1JzhgZOsdpynvAe/KLRt/3g=;
 b=FEDsrt6RxJpVYg8NuuFzZFEQfuqcpKmR23G6yCXlwnqHPpTE+a5SH8S/aVrxPoirbh
 34HwKLsh8Oi2+j9GxRIfcOdNU4nUiuELAYEZJHCeCDoCAo6nTXUpvDfW2onf/i4YRUdX
 LRA4fr6UyrEE/9vVj1ENVXnodC4M1y9bhITmju1/7LXUIY8iEkIMtRB2/yuD4Q5Jb/kp
 2UdNhU7+lWDOpbFTU/apDP7+bmK7zL8DjsJ2haqg8ew4z128bhMz8JVeITqhuIg3F8mF
 BY0hRItWIE6t4QVdE6mRuiWZOQcMx+gaH4R68zb6D6/iZ60Rutfv8F/udvJuF39xLABR
 SRkQ==
X-Gm-Message-State: AOJu0YwohJQIDwwfLtmVY6GcLeIQjs5gbe3GZGU68gWmCFRfTKoXVKAO
 Qnn7NcUAvolD8no7oT0NtghfoO4Z54efx+A2qNdt7afP/m84ExQ3t2iYFVxjG5vXJ7PYEb1MGmz
 HhWb0tDxAMXcKAKM30slMW9F1dh9PmFUjv37xp87FUA==
X-Gm-Gg: ASbGncvvVEveImECe49mo0V6jPcJ6s/eNFYfpstmWzLmhTdYEPc9iEH+WcBJhbMJO5m
 JzkaiCAthOqJFyWAA8NUMn/9iiU+Bc+Gi0g8uJsKP45KFP/bTwKblyITaJJzo4+VehRuyyWv2pr
 eAkptDqVZuonzhjEZesbm2Z7Y+MvZq2OUzeFMkl+dO0Tnuaj8RZc2wwMAPHju8g0v3bqoAFoIXh
 aJ1YdaJ
X-Google-Smtp-Source: AGHT+IF//hcDPScfBsCRIkxqmUcShiNxhfeZ0MfO2UZBNYcK4EatXow9RcZVurgqDOzghNiXS1uotMFqU/ZOYqowBk4=
X-Received: by 2002:a17:906:c10e:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b042b283383mr926437866b.20.1756837688384; Tue, 02 Sep 2025
 11:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-3-alex.bennee@linaro.org>
In-Reply-To: <20250902165048.1653323-3-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 2 Sep 2025 21:27:42 +0300
X-Gm-Features: Ac12FXxR3l3tSvUo5-Nb9B5wpA8bwUGCvkUJqw5y3sWoL641I0opKioBFX2CsaA
Message-ID: <CAAjaMXZbMry1B4zUcQFy8RgqYvxmT-NW_OhEmzuPRFBQ22kzWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs/system: unify the naming style for VirtIO devices
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Alex,

On Tue, Sep 2, 2025 at 7:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> This makes the index look a little neater.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

The spec uses VIRTIO/Virtio/virtio but not VirtIO. A unified look is a
nice cleanup. Maybe we could use Virtio?

>  docs/system/devices/virtio/virtio-gpu.rst  | 2 +-
>  docs/system/devices/virtio/virtio-pmem.rst | 6 ++----
>  docs/system/devices/virtio/virtio-snd.rst  | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devi=
ces/virtio/virtio-gpu.rst
> index b7eb0fc0e72..39d2fd2d21c 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -1,7 +1,7 @@
>  ..
>     SPDX-License-Identifier: GPL-2.0-or-later
>
> -virtio-gpu
> +VirtIO GPU
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  This document explains the setup and usage of the virtio-gpu device.
> diff --git a/docs/system/devices/virtio/virtio-pmem.rst b/docs/system/dev=
ices/virtio/virtio-pmem.rst
> index c82ac067315..0c24de83ec7 100644
> --- a/docs/system/devices/virtio/virtio-pmem.rst
> +++ b/docs/system/devices/virtio/virtio-pmem.rst
> @@ -1,7 +1,5 @@
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -virtio pmem
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +VirtIO Persistent Memory
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  This document explains the setup and usage of the virtio pmem device.
>  The virtio pmem device is a paravirtualized persistent memory device
> diff --git a/docs/system/devices/virtio/virtio-snd.rst b/docs/system/devi=
ces/virtio/virtio-snd.rst
> index 2a9187fd701..3c797f66e03 100644
> --- a/docs/system/devices/virtio/virtio-snd.rst
> +++ b/docs/system/devices/virtio/virtio-snd.rst
> @@ -1,4 +1,4 @@
> -virtio sound
> +VirtIO Sound
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  This document explains the setup and usage of the Virtio sound device.
> --
> 2.47.2
>
>

