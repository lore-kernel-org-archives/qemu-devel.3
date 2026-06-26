Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd27Z-0007i5-Mr; Fri, 26 Jun 2026 04:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd27Z-0007hx-3J
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:41:09 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd27X-0005Kb-GS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:41:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c07ea058c0cso111786266b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 01:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782463265; cv=none;
 d=google.com; s=arc-20260327;
 b=C1K2SOe7lpPNM4lPZnuyFan4iGjN7Q6qq1ayvAB12hpeocP7be5w+bPoqnBySIBOYu
 P6ZJHjOsE9POpfwTIpvFpwTGVXFyaoDLpAXXtDwcxUV+ht0Wy4MtlCAqDs1gkJKY5C48
 jEsDlPGPMfA67M4/v1ww0LsPdhaSYz9+Yk/qHDeBnWnPsAgpVkjQkg3MmXhnnrx2/eq2
 QP1DfED0Ze17TcNtmN/qSDXYJncY8V4kWSIRsgLgcs+20TUByF0PB5fjrQ12ao4qvUhv
 2j9cc/YEbREPivztSUdzl4C/aEgnMQn1+Y+iZ6oMpExOoyeEtJoMGLmZoDCOXqls8H17
 ERdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=luTFG+/x9VlReiv8BKDbxRBuU5wUb+8+JUzGvzZ6v18=;
 fh=WTMaVroxeFO+odfNo/HlSXKoRZAjtoqL4+bW6Ec/xOQ=;
 b=h+dQ+P0N3yadh/xWNIfaRddWHQLSXpAhyfpgWm9Nf5VLta1IeQVaP2CGtNq59vWrCd
 BYUcwoR/cMIp55QrvRj9Qcf4alruHBMZ/SDB9970B+FU5GlqDXD0VNa2nXX4UxxFKJgy
 2popEacIzl84AyguxR2mYQkVehJkarMideWLinsIw+IdUUuPfY3q0zX47Jh1d1y/L8cx
 H4xM3kAz30bzpijxS12gqU8nvGLmHQ+K/0zx5mp3gxUI9mDmZlJwG5aJ7Tm50hjpgNf4
 lOMBmauR7VeUy+Kewd9vVrp5NK0gy2O/Ji5zG0xSMivrGIR6VH4ODFX8/Ho0/swRODDp
 2SuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782463265; x=1783068065; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luTFG+/x9VlReiv8BKDbxRBuU5wUb+8+JUzGvzZ6v18=;
 b=R7ALsTYeF1eZ1cTEdllBuf9SPzW10quJLheR3TKyam/llXcfQ6qRs0lxx6QdmPHn1q
 cVl/2aetGNr7r2tK5Wv/NP+uMBCsUo9rFdhgB/3lcUqgUo1l8spiyeJDsVQDSxDjZ5Ff
 wuOjutzyJ7rDQbCK6ePcqd4puXzgZZg1TrFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782463265; x=1783068065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=luTFG+/x9VlReiv8BKDbxRBuU5wUb+8+JUzGvzZ6v18=;
 b=J4i6fX6VilefrYeEcPuvElrxNW6DxMwGdsHnYsACE4nlzak2pcN6cioHurmwyVxLVZ
 tZ5q8hTjyPavrNZKDyew58vdtfQ2E6C1O9i7IIRFLrCjNRiGl/zZhGJBzhg1kt0lVEcp
 QJRY2YxY2jlj2B0KRk4i1u3t4IwIYGn9r+ljP9cl/kJpip6/vSbd19C+SNSWxcketaG6
 /jxro2iw3AADPbE7sKDA/oTB4i0V67Kb4sQOurbNc6CzIAsVPS0DzyNuQZAQNuRnEp9e
 FVxm+Gs+0DKRwGUKtgNsYxG7EMnqMxMaE8SDA5VhITnXVrbWjV3TiBIm8xg1FfzGpZx9
 mZ7A==
X-Gm-Message-State: AOJu0YyhRfzRsUlGDzok1UAnNGaCb7pwVkMeshpgziUR5+bZ2lh1Pyp3
 m9cvUr39PhNncUYNmiVo2huOddwo4yrfMHagcePjxgjNw8jZdsgiUEmWcTe7zVqgDT+1w1KIfdd
 0ARgw7FBW6/fOnkfI/e6mMGw8wvpU5IDmXWfE55W5vQ==
X-Gm-Gg: AfdE7cnQNMdlHQTZQDEGPWTKdqTnb2LFoGL73t6NCdsKrmFe4lGk1BzDpAp79LpnTxj
 heZ9GNSOf04Ug1/MCjKwSl12/bHDcwFsK25DBDDURwUyW5gXtR9mHR7i+HeA2ti/ENDNZI/B917
 swqU/wjd6Bm8k/SbVGHYEP7auk24EaJ0CJ2YAYs065UBRdez+AWAkjphB2tqsd/NxMyXpDna5ol
 Pp1x+RxWFMgNcnM+wcf+b3Qxbh7ZtrFrNTjJzYkCEg7MVRICllifDaUAAEeyDYEwdW9+swnw3Ye
 UkEavS5Hyn3T81IDV9hToU02oYez7YZea+c88hU=
X-Received: by 2002:a17:907:c445:b0:c09:2c22:16ac with SMTP id
 a640c23a62f3a-c1205f20228mr408209966b.48.1782463264943; Fri, 26 Jun 2026
 01:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-5-alexander@mihalicyn.com>
 <178239957438.405566.18000078298745754945.b4-review@b4>
In-Reply-To: <178239957438.405566.18000078298745754945.b4-review@b4>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 10:40:53 +0200
X-Gm-Features: AVVi8Cc9BwK5orvgk4VKlQNyfgfKt0F5M6zypZwy44SH0VO9_5Ojx8a6HqEyR70
Message-ID: <CAJqdLrrD+s5DuLP0iV4=DD=Br+qdgRJ=R6JDX=e122W407eP8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x629.google.com
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

Am Do., 25. Juni 2026 um 17:00 Uhr schrieb <marcandre.lureau@redhat.com>:
>
> > Split out virtio_snd_pcm_start_stop(). This is a preparation
> > for the next patch so that it doesn't become too big.
> >
> > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
> >      and then reimplemented the patch idea
> > /AM]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > Message-ID: <20260625095250.65073-5-alexander@mihalicyn.com>
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 7687261192d..80dc13318af 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -521,7 +521,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSo=
und *s,
> >  }
> >
> >  /*
> > - * Handles VIRTIO_SND_R_PCM_START.
> > + * Starts/Stops a VirtIOSound card stream.
> > + * Returns the response status code. (VIRTIO_SND_S_*).
> > + *
> > + * @s: VirtIOSound device
> > + * @stream_id: stream id
> > + * @start: whether to start or stop the stream
> > + */
> > +static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
> > +                                          uint32_t stream_id,
> > +                                          bool start)
> > +{
> > +    VirtIOSoundPCMStream *stream;
> > +
> > +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> > +    if (!stream) {

Dear Marc-Andr=C3=A9,

>
> I think we should keep the error report here. Or rather make it a
> qemu_log_mask(LOG_GUEST_ERROR, ..)
>
> other than that:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thank you! I've resurrected the error report, so it will be in the
next patchset version.

Kind regards,
Alex

>
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

