Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC719F4369D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDixt-000107-4B; Fri, 17 Apr 2026 09:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDixa-0000tv-Co
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:10:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDixY-0004W7-Ru
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:10:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so572850f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776431411; x=1777036211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fE6cmIgEX/iCBz9+S+LNj8O9wv7bHj0X353rhMnTYrw=;
 b=VvJL4fQpCvPJe6AalYIimgWdYbUcKPnxIs6+ACXanKiRtQPCUH4kEJIKf0ZK4Mxds+
 iOWTl9iUDPnvt+MU0utk2IH0Q4g26+CB+Yu0bh29eTp2r6XHAY4t/CwPXGxTeL5ETn+4
 +Qg1rNuCd5isw5+6r2SVTPkupMmFaBv6S9d+2mVJywVVaDe9aeFFw67DVB9SVlP7D1Sz
 HPKBSE8orBk1s3lzpJE4y7d0di6M/j7AYPmqQ5J+2q/k5Fl+a/LMpJfMHRkJxF76jysf
 MIuPQUAf0UghAvUByhemdFQc8iOxieRsP2Zhh7gPV5PZgdeRt5r7+d4ou1MgI9twboZy
 g1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776431411; x=1777036211;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fE6cmIgEX/iCBz9+S+LNj8O9wv7bHj0X353rhMnTYrw=;
 b=qvgqaTGck241pZEfz3zJD7Mqvj+bS6Xk/+Afiv6aU6nZVLUhvoKIK/wAv6bEt3vTD9
 BePpVYhvhnkHqAK9lvHp8zWUERYijeAIsEk5VJ0zGyJ5hPasDmn4dD5E/eUzHuyx0EjJ
 rwWvNDq2Y+wCSXNGnszw3k5eSjJDCbNvP3Uro6ADeLW1s93JOqgahoNSjtIV80gii8Mf
 pafweGrUn0++aJPigm/Jxav9AlniPWFccofw7aNn+25nU1M42Uls+lJcW6SmeQyFirel
 LDEn24PYVdWTacPAxLQhdK/AOATP+CPtIKKGwfbzkH/86hC4PsladqXX9kovtsDNefwE
 UbKQ==
X-Gm-Message-State: AOJu0YyryFd/8v+aupd4pqlsXv8YT7e66tfuyX7lm/tr6Z0gfU4vncwl
 ahftCbeYjcV9/80yTJ/nadivXkGhNl/wQJ7R2p2jGT8FVTtnwpz/CU5TyOxnXmQyKmg=
X-Gm-Gg: AeBDieuK1tv65jIlNBDhyWkIzPPPQb5eNIAHmhNRHcbg/rd/Nj12tqLY7do4RsJaGq3
 I3kC8xdvZy4gC5z+Z8Tzb0jW8Dv82ZRRadd5b/jCAlU6P2sctCNRQAieEepcYrZjAaV1qYLKoRu
 HYfYOlNAMItRiyXjUGDiJgOO569PadheIikwMOhl68RGP/W0QdxW2GXzzGqrxrWqgYkP3/LfhiX
 dcrw1OZygXHf9S1nFCJXNCPDAaH7WrQzLPiP10gRn5zPYT4Fum+j9kmfVZfRuTvAeiNOzJw+5+T
 emoRourfdbcgTXVqCCeTdYhSW88LB/oUG2IpaBONz0s5X2gcSkIODJTk306Y22Cm114RYdHdGmN
 tWiTyLqooW/uFXtMBkZMKwdJOofdhpYBh0EFZSRQC/LQf3vsL48wHClAxz9f4jttUmKP/MNJMue
 qGSStSt4nyYJh72m7JD1inOxCvYe0AQ1R4mw==
X-Received: by 2002:a05:6000:381:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-43fe3dd4ce6mr4296173f8f.20.1776431411149; 
 Fri, 17 Apr 2026 06:10:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm4536601f8f.12.2026.04.17.06.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:10:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA6445F94F;
 Fri, 17 Apr 2026 14:10:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] virtio-snd: check rx buffer descriptor size
In-Reply-To: <20260416-virtio-fixups-v1-1-ec14e2de0852@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 16 Apr 2026 08:48:09 +0300")
References: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
 <20260416-virtio-fixups-v1-1-ec14e2de0852@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 14:10:09 +0100
Message-ID: <87h5p9ravi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> It must be at least sizeof(virtio_snd_pcm_status).
>
> I haven't verified if it's possible to get an underflow, but coverity
> points it out so add a check.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/audio/virtio-snd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index fb5cff386606d03e5cfce88f79e404e510bbcde7..93fbcfb43f7fdcfd5c164b496=
015da743822f5eb 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -970,12 +970,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
>          }
>=20=20
>          stream =3D vsnd->pcm.streams[stream_id];
> -        if (stream =3D=3D NULL || stream->info.direction !=3D VIRTIO_SND=
_D_INPUT) {
> +        size =3D iov_size(elem->in_sg, elem->in_num);
> +        if (stream =3D=3D NULL
> +            || stream->info.direction !=3D VIRTIO_SND_D_INPUT
> +            || size < sizeof(virtio_snd_pcm_status)) {
>              goto rx_err;
>          }
> +        size -=3D sizeof(virtio_snd_pcm_status);
>          WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            size =3D iov_size(elem->in_sg, elem->in_num) -
> -                sizeof(virtio_snd_pcm_status);
>              buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>              buffer->elem =3D elem;
>              buffer->vq =3D vq;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

