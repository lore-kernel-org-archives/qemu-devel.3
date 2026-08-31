Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF1FC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wQs-0002HT-F3; Mon, 31 Aug 2026 03:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0wQr-0002HK-40
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:27:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0wQp-0000is-5J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:27:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so3615222a12.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788161269; cv=none;
 d=google.com; s=arc-20260327;
 b=lhvwiAwPNabfxQ6yrGurUtE4lFHi3YBrwnyPtvPPpCELdF1kpx+rH0ILaRgTmb8XzZ
 MpE/N6WScuJWrZ9A18kiCO2SxV9FCc7+GqQ4rM2upk0o42m6xB1KrTVjA1OlScooRgSK
 rYaAA7b+5Q+YbpB0LCq2c3yonO/NXEz9YLiScA7SuG8QaBgEQujt/Ax3MK2kzljdcfAF
 bJ7TL/gPzavea21+TKO8BC0ECxkuv6TUxxl4b6Zz6/X5+IRzjxpez0oPt8aTRNHfrS4T
 t8gmwUCb7q1+VskPVmvD0WvyRwm9fN+sRqHztyXrVCg3oP1o39Obet3SOx/wnt9XJHv7
 q6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T7rKNGBwdvwvWp9YW1y/5jQzwneeIH/s3ou5EEXuGZQ=;
 fh=9/qUX1jjhSnjc33du+OdU1DRve1ZCTa8IpMrb1kkEgE=;
 b=cmKSwi0F8xTVVCLjFbhVl8ybz+fkbO6J3gwc1Ixa3TRDFSH4qq4hIbD8kXz1BlmLDp
 Tp0njZohN94tByMe6fvAwI2Q9sGOX8ei3Rhntv68hobLPYLiGilaUjiKWKLmIcGsoyNv
 ghZoPjkqO2L/jSdl8+w/QtvUfpdnjtJbSWCR2I5W3MnDHpFKZzM3koHdUX9lJAU9FxYf
 2ZWlIux9VNnTPdUirOdSOHya3iPKYXOpxsDHkjc8DZTAdu3JsWfOYvbOSayehrNWU64F
 IpSS39Mn3ynD7VTt0GZ5ttYKD+J8J57YClqdUkZ7N2iE0+mMXw/AL6I9fY8NPQP+Gcpj
 EG3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788161269; x=1788766069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T7rKNGBwdvwvWp9YW1y/5jQzwneeIH/s3ou5EEXuGZQ=;
 b=Zmd1DRbYDeREvDqq4gnV/TcfEfQJE5na0kU+/W05p9JPsNw51LPe0meNk9HvwmVx+N
 Vq9tFKPJhNZ2ZiPJv6qa1aCHF1DHC7s1tarsRX4rOhaUselnkRM0G2JKissvOLf3Ik4x
 DyU3ZMCOhALVy3XQ6gWfeQWlf7xof+HHUg1Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788161269; x=1788766069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7rKNGBwdvwvWp9YW1y/5jQzwneeIH/s3ou5EEXuGZQ=;
 b=LxrkUAHpYeQwi+mlkDiQdQJ8CSSw061yxizyGXSIkTz+TwMF1HjMNMlRi+8j9k9IH2
 Chz+WaeARJClr/McPaHg3lBMK0T5qjCBubfQfg/LDi1eqHsv93/pk6EmmM/jIBiHhemE
 hYAcEf4S6Ze5T3ch5Djz8rLKMiE7yu3Mrf4bEalXhGKlGJZikBChiirJD6f9V6ApfFRm
 L/9wcpTJxRibh1i8rDarwpMCjnnfa7zzRTG/kGfhR23SsHGxglz2i6a6s5a1cAXcA8M2
 NLlpKnDwq/2Bdc9j++nZ4ROgDxZBvYxMmaSB24cW+xiI+dlKpNf3lHnB/S+Sql2NsYRa
 URbA==
X-Gm-Message-State: AFuF++ndGGzMspTApkpDrJrGQ488uoDS4ZhOChDmCNF12/rIB/+Bk+lq
 VN0Me/8ha/YdEGxUm2YUGBRdJGrrXPqRdRmO/moMfx42FiF8uGtvZqyWhESHtA5VWNJ/KT9MKfD
 8tcRGWQ6eq7mnFKqoqkgnwQh/0Ss3czWoAc+HaOuibEJMUlQ05aoD
X-Gm-Gg: AYBFou3qN5E/Y2d3mEijCjMLziVY+i4iCjxAG2MrKP+W6CtNuxP0XZ5mxdbxWbY75mU
 mxXeQjsESuDXYvvbnW+PtK1LKURiwMg9n9hS2XRSQz1VSakMDpP3PjJcAmUc+G/suGTA01xzbJp
 2nVyRTNHYsGEfIoicGcgWrtqEmRMLgF0yVR37CFctgKWNA7Rs5TEZBigkAKPhachU1qnxoSs1Uk
 YUdhnGcbEApc24BPYk6skIf5zG9a4yaXskAeOhafGM3wTkXU8t+8DedaOD2U4dxvB454WqbB9aU
 n5vELAxprvXsUP2mwAkj1vkNJ7GPpwEYH1mUob5n9webZqInpu+SNMlx3BjU6sRyxHFMBIAmPm8
 I
X-Received: by 2002:a05:6402:13c5:b0:6a5:d8eb:da01 with SMTP id
 4fb4d7f45d1cf-6a65e4d580emr761537a12.0.1788161266162; Mon, 31 Aug 2026
 00:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 31 Aug 2026 09:27:34 +0200
X-Gm-Features: AcwNN1XEfKCjqO-0D9ghb7w7YQCjKak5Lga0C2HoZfv17DB7dNFrIPI1aytVsD8
Message-ID: <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
To: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52f.google.com
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

Am Mo., 3. Aug. 2026 um 10:12 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Dear friends,
>
> This patchset is aimed to support virtio-sound live migration and based o=
n
> pre-existing Volker R=C3=BCmelin's patches from qemu-devel lists [1]. I t=
ried
> to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a=
335fc53569.camel@mihalicyn.com/)
> if Volker is going to continue his work on this, but received no reply so=
 I
> just decided to go forward: take his patches, rebase and resend. Of cours=
e,
> I kept all authorship/tags so I hope that it is fine.
>
> Testing.
>
> I manually validated this with Ubuntu 24.04 Desktop VM and found no issue=
s.
> Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/pipel=
ines/2626702088).
>
> Original patchset:
> https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t=
-online.de [1]
>
> Git tree:
> https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
>
> Changelog for version 5:
> - rebased
> - added RWB tags
>
> Changelog for version 4:
> - addressed review feedback from Marc-Andr=C3=A9 Lureau
> - and from Manos Pitsidianakis
> *there is a detailed changelog under each commit message*
>
> Changelog for version 3:
> - addressed review feedback from Marc-Andr=C3=A9 Lureau:
>         - drop VirtIOSoundPCMStream's id field (unused)
>         - resurrected error_report(..) in virtio_snd_pcm_start_stop()
>         - fixes in "hw/audio/virtio-sound: add stream state variable"
>           [ please, look in commit message for details ]
>         - added "hw/audio/virtio-sound: remove channel positions field
>           from VirtIOSoundPCMStream"
>         - fixes in "hw/audio/virtio-sound: add missing vmstate fields"
>           [ details in commit message ]
>
> Changelog for version 2:
> - no code changes (only commit messages)
>   followed suggestions from Daniel P. Berrang=C3=A9 (thanks, Daniel!)
>   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
>   and added some extra details about what I did with the original
>   patches during rebase (for some of them it was simpler and less error
>   prone to just drop changes and reimplement them by following the idea
>   of the patch, cause base code has changed significantly).
>
> Changelog relative to the original Volker R=C3=BCmelin's submission:
> - rebased:
>         - "hw/audio/virtio-sound: return correct command response size"
>                 was dropped as it was already merged
>         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer ha=
ndler"
>                 was dropped as it seems to be replaced with another fix
>                 https://github.com/qemu/qemu/commit/731655f87f319fd06f272=
82c6cafbc2467ac8045
>         - I had to drop all pre-existing Reviewed-by tags cause it was 2 =
years since
>           this patchset was sent and reviewed and I did a quite significa=
nt code changes
>           during rebase
>
> Kind regards,
> Alex
>
> Alexander Mikhalitsyn (2):
>   hw/audio/virtio-sound: remove channel positions field from
>     VirtIOSoundPCMStream
>   hw/audio/virtio-sound: drop unused struct
>     VirtIOSoundPCMStream.flushing field
>
> Volker R=C3=BCmelin (8):
>   hw/audio/virtio-sound: remove command and stream mutexes
>   hw/audio/virtio-sound: allocate an array of streams
>   hw/audio/virtio-sound: free all stream buffers on reset
>   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
>   hw/audio/virtio-sound: add stream state variable
>   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
>   hw/audio/virtio-sound: introduce virtio_snd_set_active()
>   hw/audio/virtio-sound: add missing vmstate fields
>
>  hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++--------------
>  include/hw/audio/virtio-snd.h |  26 +-
>  2 files changed, 414 insertions(+), 308 deletions(-)
>
> --
> 2.47.3
>

Gentle ping.

