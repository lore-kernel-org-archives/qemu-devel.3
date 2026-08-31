Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45417C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wdl-0003Vv-BB; Mon, 31 Aug 2026 03:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x0wdj-0003VT-KD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:41:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x0wdh-0004tw-Hy
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:41:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso14797895e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788162067; cv=none;
 d=google.com; s=arc-20260327;
 b=NuQCtyYkz5MSwLFPVmnvOfvjUjFqqP3WsM7D9Xt0H2LA/FPsyqTxS+UVo0+4rg2tAH
 YkqAO31EzyZYbVcNfO6pchHw7RqRVab06zqHLUXOiTjmjJpZd1CcXzLhQwZdN9Fc7hAx
 bKtfAD6aVWsonlYi+SDuwkeSItT/mKFF2insWJoYMNdEyNodl7vNtty4QVu2NAYb9nLK
 xPmtSrrddH7wRLieo1jM6SYsj/QmC36rIe9bHZ3mujnDNyQ7V9k4jxkKrB9hnWN5y6Kg
 AinYKi+3KOZT4tF/AXtFTWZCBZjg6KstfDRh/PRyz3Bh/+rMkWCLWoLX/BAnBirZwzd1
 lovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GpuGOCIIyNj1BGe4oWzvEgY32X+2v4J25gDa482vKvM=;
 fh=hZlilrbqsditQ0+hAfZywczFkhc1DWF7LFZ1QY5cZTM=;
 b=PRml2eJ2eiRI1Cq9bd3uLB/C4CFRCHGVrvhu2l25KhcrFWBfO2+Vr9G1+R9+3gKT1E
 rZ/50/rl/V5Ms4/t6geeaJuCCNigCmH2yIGTCWU2dNKF87wdCf40eOK53LxdXb6ETPdP
 DNwLec1zbak+HrSrXIzwE2y/7lhbwEP3VDgZbWa3+4ZZmaHumTCZH2PbFDfmmfTNagz0
 zM578+7rpUiSgS9oQwFgWoY5XTGsXNa26CPj6VT05FPR8S1JoKbaFc/IzJOoo9uIcNAZ
 7jOBsvhsfYCMGVDtE9tufkptU+BTBIXp4FSo9rffg0eZyidQd12DZqFc5iwTLbKGKHv5
 BdKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788162067; x=1788766867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GpuGOCIIyNj1BGe4oWzvEgY32X+2v4J25gDa482vKvM=;
 b=Qh0gE6U09c1duIgNVAERfCSqzimbUZTajOYfJ6CDPZYX2CdJRWU5DOtxxzYw++tCF2
 o71Sl7qHmeP7+rmqlQ5yczRV5cYhB4n7Ux1JBn+9CKN+bDkqUX7Th61khDzbH4eD6twb
 u7bpLG563/RrKdHFX+BfK9+7Pvfd3egWeOKadqmGYlZXNorgrXSMoOdY/Fa+5AOUsdgB
 X750wzXNX/r7u/HA/IP0b+6PoZ43hFCchTkonZevZvSS8FKuyQZ/ud55xCSfXexCTC2s
 qxl0WlJgnRoqy6ydeZlGy62HlRL1GNS3mhzHqbQkNtX2zja699F/cF73LeDSgpReT/s9
 ulsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788162067; x=1788766867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GpuGOCIIyNj1BGe4oWzvEgY32X+2v4J25gDa482vKvM=;
 b=JNoV0MtdaYd6KNa9ncOt6Sb6ytbFnACEOVTDOhRyhi03KK0SB+0RobZk5IGnjQ4JiP
 1hnGhrNMcyUas7PlD7Gso/jzvp87jn6FIJtdFspISBeM0hx45cTUkX21F4nfLtGrSjyi
 +eEbnndsAt06xKnqeaZE/VjirI9ZOB+EckpAEAhJgZyZ9OnzDU/L4r5Y36ZtC1DteGjz
 IdxBVlWnBNbp91Ecr1dowLH1aNjQ3ETkDB/FOWs0pdNzLlBi8MSMh0ZsV5Jri7XS3xsk
 +k8aoeSDIxHR3/w1DVmdLlfgRfX8dbJr99Qsk+8AQUfCoEV2kfn65373BrhPaD1JXTvA
 Qc/g==
X-Gm-Message-State: AFuF++kmBOtATbWQB8LxeDKI2JS46b1QpbFIZwqRpJtYJUebHY8FGX1J
 bmaUGiyICIfe6+N3xYYQbD22YMI5M6o7l6vgpCvMiPO2V0TyjW+aJGiDjvKqYaZlStt0rvVgO0C
 QtGsisdhyH/xjGqsQtvz4XVYNQFTXvxMkJge7OpFxoA==
X-Gm-Gg: AR+sD12P7SkQXRnLNlt90lLv8jNCSde5UWkg5KXyGwU3/rUZ8ftVrFjgyyBuU4PJgWF
 hEu7ZEMqUBo+0enO7ELEBRNAOxaFLhSsL2LkmIfBvDvfGEddnd5p/NhCF2kW1EQoevi4e5IQjZG
 gx+kXWXCv3+YSu7xDddbFF+RSqX9kSvhEl6/mT9eHRdwX/QQPfhJLOls63smuSi7a6csdyxbvPF
 6kKp6HiavMZdU+xA4hZe+B6GmHnUWSw82TKmFmcPg8+3tKG4ofeJ/V/TbXc49GHLLJ5rPcfJvcH
 LHYUiZNdXR6eA1SyzfKxugHcL03FxmbMmi374i29rpMgXN91b07Y5MiJ8GFzDtdzzD2AoRlXTMT
 8kcmxhBC1W++43zQZyh5inJpKoFO8TeJXm4m1ePnfo6cJJSi8nAsNwLU8T3ty4QkXz1CBtQfeHb
 my4J9aXrMdYUnMzjJhl4+17TA=
X-Received: by 2002:a05:600c:1f91:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49b91c1c784mr341096665e9.2.1788162066652; Mon, 31 Aug 2026
 00:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
In-Reply-To: <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 31 Aug 2026 10:40:39 +0300
X-Gm-Features: AcwNN1Vp2H3JgEPDfwjYfKX2q9dmTye9P8GEfMSnplIsDcU_rc5s7TUJN_yAusI
Message-ID: <CAAjaMXZ80o20S-o7=QbrP+wNKqo==w-9Cc3BfeZGG9DazMTnPA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Alexander, so sorry for the massive delay but I'm on PTO for a big
part of August and some of September. Your series is on my priorities
as soon as I return.

On Mon, Aug 31, 2026 at 10:27=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Mo., 3. Aug. 2026 um 10:12 Uhr schrieb Alexander Mikhalitsyn
> <alexander@mihalicyn.com>:
> >
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
> >
> > Testing.
> >
> > I manually validated this with Ubuntu 24.04 Desktop VM and found no iss=
ues.
> > Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/pip=
elines/2626702088).
> >
> > Original patchset:
> > https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e=
@t-online.de [1]
> >
> > Git tree:
> > https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
> >
> > Changelog for version 5:
> > - rebased
> > - added RWB tags
> >
> > Changelog for version 4:
> > - addressed review feedback from Marc-Andr=C3=A9 Lureau
> > - and from Manos Pitsidianakis
> > *there is a detailed changelog under each commit message*
> >
> > Changelog for version 3:
> > - addressed review feedback from Marc-Andr=C3=A9 Lureau:
> >         - drop VirtIOSoundPCMStream's id field (unused)
> >         - resurrected error_report(..) in virtio_snd_pcm_start_stop()
> >         - fixes in "hw/audio/virtio-sound: add stream state variable"
> >           [ please, look in commit message for details ]
> >         - added "hw/audio/virtio-sound: remove channel positions field
> >           from VirtIOSoundPCMStream"
> >         - fixes in "hw/audio/virtio-sound: add missing vmstate fields"
> >           [ details in commit message ]
> >
> > Changelog for version 2:
> > - no code changes (only commit messages)
> >   followed suggestions from Daniel P. Berrang=C3=A9 (thanks, Daniel!)
> >   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
> >   and added some extra details about what I did with the original
> >   patches during rebase (for some of them it was simpler and less error
> >   prone to just drop changes and reimplement them by following the idea
> >   of the patch, cause base code has changed significantly).
> >
> > Changelog relative to the original Volker R=C3=BCmelin's submission:
> > - rebased:
> >         - "hw/audio/virtio-sound: return correct command response size"
> >                 was dropped as it was already merged
> >         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer =
handler"
> >                 was dropped as it seems to be replaced with another fix
> >                 https://github.com/qemu/qemu/commit/731655f87f319fd06f2=
7282c6cafbc2467ac8045
> >         - I had to drop all pre-existing Reviewed-by tags cause it was =
2 years since
> >           this patchset was sent and reviewed and I did a quite signifi=
cant code changes
> >           during rebase
> >
> > Kind regards,
> > Alex
> >
> > Alexander Mikhalitsyn (2):
> >   hw/audio/virtio-sound: remove channel positions field from
> >     VirtIOSoundPCMStream
> >   hw/audio/virtio-sound: drop unused struct
> >     VirtIOSoundPCMStream.flushing field
> >
> > Volker R=C3=BCmelin (8):
> >   hw/audio/virtio-sound: remove command and stream mutexes
> >   hw/audio/virtio-sound: allocate an array of streams
> >   hw/audio/virtio-sound: free all stream buffers on reset
> >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
> >   hw/audio/virtio-sound: add stream state variable
> >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
> >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
> >   hw/audio/virtio-sound: add missing vmstate fields
> >
> >  hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++--------------
> >  include/hw/audio/virtio-snd.h |  26 +-
> >  2 files changed, 414 insertions(+), 308 deletions(-)
> >
> > --
> > 2.47.3
> >
>
> Gentle ping.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

