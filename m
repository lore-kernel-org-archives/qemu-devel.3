Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD331CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcjxC-0002rC-QU; Thu, 25 Jun 2026 09:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcjws-0002nE-Ht
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:16:55 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcjwo-0000jy-Op
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:16:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso486727566b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 06:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782393405; cv=none;
 d=google.com; s=arc-20260327;
 b=Mxr8l9IKifgAjyi+cJLxTx+bkmW2pCDRSSiSsmwETK+ASNzx38XUzoXP/ftuyLzfBc
 4H2yGLbkq3WjH52xrmOioZ8C6/zc/UZcjO1sZJh57ajyxoVr8hYFzz5fGeWGmMG0fpQ/
 pu3wBUuMGa1lFqg+6i+oKSbkINMnK65dsfx3fmFY8655tCiYWzYpPVZC2SAtG4Se4TOE
 eCPvUgEmxePeqViFnrtuhg6drS68dnoJfdfDtwWJmM4//B84DznE9lH7X2zKOhNVGDJF
 lfW56X+zOIY0J5VeWNEyB7tcjpSZ1m1Nur2kdG3DnrvZj5tYzWEcOBEADjeuw+2wJIAT
 VPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aJhk0/wgZkJARwBT8D1LrlVOSWWW0BQtu1pE/GofGKE=;
 fh=PeFbVosthX3orXrj21AtkAF2HOBB2ebCVbnK8SPgbQA=;
 b=PfgXX7E8i6unjZs3dAewu9shDO7TUlJOLnkoDnDpy5ECAWWrbSMuYGi7JEjdMd8/bP
 VLbNLdX1ckENd7hO2pFWo6flcfmorMhZLMoN50Parg5uEOmXwuOij1l4OCL5DW/+5C/S
 ejQGXFR0sYSUAhQLdjpF2Sze9l73imnMt9a4RNTBOoTcQh6vy5h9Z9A66902qjQIuIyu
 HKTO+tGTMRTgXRP2unxLm2idBZpA1wZw4sQYL8PNkgaEJtyt0mJP+RTkZ5OLqyiqWYgI
 6GkCy0KlnLHwRSUm6PhK+eoQRkZQmmX00I9T5b9UuA7hJFF7IWR8ccfRpplcZw8uiwbV
 SSGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782393405; x=1782998205; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJhk0/wgZkJARwBT8D1LrlVOSWWW0BQtu1pE/GofGKE=;
 b=C05irAYqGNQXH4KnuCNzqqC9/U76fwsAQoGlcpxdO/45x6ai4r4g8VBycPBZGPXvTW
 JA0kh3PKzbLSD3h/UstoJ//rm26IanziAuo0bpnV3XaINoON6DcEe/CN6R/VvYoUgfT3
 KcDh52mQeB2e0OqpyaO1HhsuqZ/WYyj8JDevc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393405; x=1782998205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJhk0/wgZkJARwBT8D1LrlVOSWWW0BQtu1pE/GofGKE=;
 b=COyBhQVopQ9r7VGyDys4lodrgOri2i75csvROHZ0sSV+ktO/WUdTUx35zckQwICBha
 fb3KkIylHwkz2lGQJ9/byv4QeUIZwEhHSOyXPlHCGwlVrDqeD8paBHRtC5Cp/AzX9Bat
 n0E+wXw+evYYxpy5CZ4COo525izUxMMZofEsmV2HC/yYhcdDmeBisO9AU//VTP5M+iDX
 I9E9gMNvFx+RiqfGmk9CwdhbzYcE3/+0+VMHBxYxfBY5zsjg9PuL22yVZDu2tR9sUkxj
 wcdCf3u/z7Jo/qotQJ3vmrhls5W7D9Z5jxLlyFniw9rKefRr7lP0ga9LbYxKrjE9Vs3Q
 yqfQ==
X-Gm-Message-State: AOJu0YyV0W1ZNa9rPk7ugRwO0xtBwM9mMzpooH9fYfj4vJlwElZi9MkK
 V54KQUo2Ucnuf1te23AfyJFEnpZ41rQzkahRPCP0fCO4GdAMj+tjFV4Op57459mPFh1gnlK8Equ
 nsD3QDx49TshVm7us+gj+N3PPDvQG7jxhg3ogrOzc+w==
X-Gm-Gg: AfdE7cnkmxxVK7E4ynvj1jNe362LBzpCsd151oUADqq21BagcLc+ngUs6dJt59H5XeY
 q9Fa7t7hzFhMSmv9db/hpAKtjrNrTJh0tomp8lL4j6Ekl6swF0avn4CzJ54LP4+NkjODkVxtKUh
 fr1XlXnmPqB2imOaJW/gTt/bQWGsGjqwykK48ZPEQGOPTHS6ksbbuaTGid1bkGTVRxRzw/FVtgp
 Gby3rsVab5ofAMO9qsfE3Y7FXKLZp2l0zh5AlbZuBx9bSKUQL8d+8wKX3t6TiyBLZucH1U7H/q3
 mwF44POK/GE2upluf5mtjWELhgqQ
X-Received: by 2002:a17:907:7285:b0:bec:a96b:75b8 with SMTP id
 a640c23a62f3a-c1205ef0cbfmr173024966b.32.1782393404381; Thu, 25 Jun 2026
 06:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260625080910.30569-1-alexander@mihalicyn.com>
 <ajzoxZr4g0Xsr_4p@redhat.com>
In-Reply-To: <ajzoxZr4g0Xsr_4p@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 15:16:32 +0200
X-Gm-Features: AVVi8CdF8WIKGJgCRCjflAtC_3S1dcIaakjlplesXqFfNWi07JOqnI0OcGq_w9Y
Message-ID: <CAJqdLrpfefPpU+QB6-4YXoHxhx+nMyZO5d6RBHxTOc=yU-fq9g@mail.gmail.com>
Subject: Re: [PATCH 0/9] hw/audio/virtio-sound: basic migration support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x634.google.com
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

Am Do., 25. Juni 2026 um 10:37 Uhr schrieb Daniel P. Berrang=C3=A9
<berrange@redhat.com>:
>
> On Thu, Jun 25, 2026 at 10:09:01AM +0200, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Dear friends,
> >
> > This patchset is aimed to support virtio-sound live migration and based=
 on
> > pre-existing Volker R=C3=BCmelin's patches from qemu-devel lists [1]. I=
 tried
> > to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b=
8a335fc53569.camel@mihalicyn.com/)
> > if Volker is going to continue his work on this, but received no reply =
so I
> > just decided to go forward: take his patches, rebase and resend. Of cou=
rse,
> > I kept all authorship/tags so I hope that it is fine.
>
> Yes, that's the right way to approach it, you waited a decently long
> time for any response to your query.
>
> My only suggestion, in the commit messages, if you made any non-trivial
> changes to Volker's functional code, then just put a single sentence
> inbetween the two S-o-B lines to highlight it, eg
>
>   Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
>   [AM:  changed blah, blah & blah because blah]
>   Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
>
> if you didn't make any non-trivial changes, then what you've done is fine=
.

Hi Daniel,

thank you for such a fast reaction on my patch submission ;-)

I've addressed this in -v2 and sent it.

Kind regards,
Alex

>
> > Changelog relative to the original Volker R=C3=BCmelin's submission:
> > - rebased:
> >       - "hw/audio/virtio-sound: return correct command response size"
> >               was dropped as it was already merged
> >       - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer ha=
ndler"
> >               was dropped as it seems to be replaced with another fix
> >               https://github.com/qemu/qemu/commit/731655f87f319fd06f272=
82c6cafbc2467ac8045
> >       - I had to drop all pre-existing Reviewed-by tags cause it was 2 =
years since
> >         this patchset was sent and reviewed and I did a quite significa=
nt code changes
> >         during rebase
>
> No problem.
>
> >
> > Kind regards,
> > Alex
> >
> > Volker R=C3=BCmelin (9):
> >   hw/audio/virtio-sound: remove command and stream mutexes
> >   hw/audio/virtio-sound: allocate an array of streams
> >   hw/audio/virtio-sound: free all stream buffers on reset
> >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
> >   hw/audio/virtio-sound: add stream state variable
> >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
> >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
> >   hw/audio/virtio-sound: add missing vmstate fields
> >   hw/audio/virtio-sound: add placeholder for buffer write position
> >
> >  hw/audio/trace-events         |   3 +-
> >  hw/audio/virtio-snd.c         | 685 ++++++++++++++++++++--------------
> >  include/hw/audio/virtio-snd.h |  25 +-
> >  3 files changed, 407 insertions(+), 306 deletions(-)
> >
> > --
> > 2.47.3
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

