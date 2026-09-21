Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD043C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8bKj-0007MM-6k; Mon, 21 Sep 2026 06:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x8bKh-0007M0-Cj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:33:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x8bKf-0004Un-IJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:33:11 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1600536f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789986787; cv=none;
 d=google.com; s=arc-20260327;
 b=g1LZmlb3WXg8aFqaUrP2gvVPEMS6lUHaPlKLs8h/Ctrs5d4Zo3wur2+ZOhIQH4S5GG
 FF/Z0EYK+c/KC/mSKktPcxAGi2Q9QTJGbsoCn+C/GE9rDOp9BAB7DiLQiY8IFRsHrvu9
 /B6YliOcQM1rjxx3NtjbqONpQEr3+NPCEN8qU7KPUEFAgnubxvW1xO5fDzE5BTYbUePc
 rLwn5kgIz0vgZF7H7sDL19ptXdafKlyfYmfoYCzqwOjpSJD7OZztMErtxxDO3PPoALus
 o5rCwfA9GTMLVUvzPRegXrNA3kpp9MbfVcIXiXnX1UDOwXex4DPRWk/EVMsCNwX3QEdw
 /DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2rUYu4YSoIUAdgSWAhzt2zTe1zlevitFqFUxChhjulM=;
 fh=zde/FCo2amAF6NGk8HNdLm8aB//qin1KEb2gDgenNdI=;
 b=D+uWBehArKX99vJEo83QFTEO264abQjLXxUnKiWVjP7zvcprcDsNta910pqL6j9SEK
 /AJuipuLuL31kE/DH1Sr6Y0Uw9HCLsY3gbDZqXE1zCAq/mw8NjPkfW5GjhnttwL3gHgF
 jp+V5qrMg3/afRvNLOnzBPTaebrI/H0Cgk04DNpFqt3ZhZ1tCNR5idNNyPH4TusP8R75
 y+Mh1go9LqyTpLWcT5FxAZaxC58FljKC8XH6hWIDqyRKqR6jleWfYgt2lEUEL5IKSJSt
 rMhOYuVuTA45t6rJ/xEJtH5APiFj7o+tVweGohfCn3oCoa6V02+gzNgZTh2UcMxxgVfo
 h6kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789986787; x=1790591587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2rUYu4YSoIUAdgSWAhzt2zTe1zlevitFqFUxChhjulM=;
 b=hTeMTH0hsbaXUdc9wsUA2wpk9MalP33xZtg0npsYi6CMTcoD6DhtITCItxGHTJym1D
 PcOR4TAxhQGO+FB8TlqUrlv6QNslrHLu1MBJeXEWlqJFu61/ExN1xdWeK9z2LZba4L4e
 UwI6TecD0+9YI/H8cPr7Hor+w7ilEc5RBGhVm8jUOLbegprmR5cdM3grJqYZqtxGJfe5
 sFogtHFEFR5XxdeeuLg1BD/wnNY17DYFsy44r5ATZFWkS42x7Xo94X3oL8+qNcyLgnMF
 9XHtDLAc84pbb4FzMZKjRYXoHoHxIF9aGyG1yqMYk/MevurhCg4Fdbgd24rKH2Nwe12c
 cfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986787; x=1790591587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2rUYu4YSoIUAdgSWAhzt2zTe1zlevitFqFUxChhjulM=;
 b=ptSuVgAluwgKvb5TCnxx0EKSNh9xfYp0Aqjy7yM9pJdCNYCOS0rvIR8YMkw+1QRs0f
 boBLYL7tFP8X3kvDwBJEmVDW4X++rVbxQAwsOpVH07mDkT3oHYWuzUa7/TPouEh5dx9a
 pcCCQ04Tkvh3ZfyILlMP3LLZXFxcHUcYlrRLI3qFOFf4ZUwYjCsJ7dniJ18zAoHlAvm7
 K/NKy5XcFnyR1xLFhXoG5Z12ddAWNDJ+9fmAW9ZxOUZUALsJmoGjxuAkJSo6PzHT+tcZ
 ZpwkZGJchYfPUL+p13VTzgCrDr354fJXZ+n+w1ssMFOKU1ORPxlA+KSmwHT0Q+QCbZWo
 RVXw==
X-Gm-Message-State: AFuF++lf+OL1aESFDrWqd4UjQc03Zf2CcJV4i4ZVjDRfgKiq23D+P8/X
 pamJ/9TdoxqOOM0ElDLtbHXUxgEGRuku8w7d4U4CVyEu7aqRerR/v8dKIo0hbPulLnd26BjlLUK
 oH3GxCxPf3TxIf28qbOZ8i+/7IFenCqj6GOujXzBTsQ==
X-Gm-Gg: AYBFou1c2blvuBL0OF+Fm3aqjTVx1xHGCKfI7ym1Flu+qans34cUh/yi3ExNbGFuHpX
 NVAX4bHGCQnz/0tqtXNhzp6sSo+cfEL8LtVM7F0WfDYnLczuNH+Oj3qwFmEDOrBnJ3RT+zQsBHY
 P3XqybgEjn0PkY00jaJNZ+5KFVbtPd4tEy1sdNh3I7D8ivI5aE4wxV9hbudUPwXU3tOcPkD7RB1
 is3tZQXQH2z78PMv6i/v23y32j9Vw+DpTdPi4zKfZSkyfR2dgLscyTsTk5FP4b1I+gybEHTAaUi
 yYT01zXWzX2WQEwRvikuIXyxonOrSI3ZL9HdG0gFPTSuTJYcJ+hO1iwJ8vzJ1O/2q89yamMUpu7
 CJN+PZAzwS6qmLGZziGct3Xa+9mf/f7AHAgLFzUdMurmmWXWLTUFM0MaHgHBvjD2RKCtnamg3sj
 xSrRjztFgsbLt7w3RBSxNfTflhOh74z+JFaA==
X-Received: by 2002:adf:e185:0:b0:487:27f6:a4e0 with SMTP id
 ffacd0b85a97d-48727f6a66amr8017096f8f.48.1789986787107; Mon, 21 Sep 2026
 03:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 21 Sep 2026 13:32:41 +0300
X-Gm-Features: AcwNN1WYcxY_3_4gWiPexolAAlJNu4M6n61j2dIGNfXtycyUT-iT15oi-soRP-8
Message-ID: <CAAjaMXaxAXJcufXy--q9b1o9Kd68N4zvoLX9srrCuKsOB_XTkQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr2-x10.google.com
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

Merged to master
https://gitlab.com/qemu-project/qemu/-/commit/c1c18d1e640b64292859ce9f30f3c=
344edfb0294

On Mon, Aug 3, 2026 at 11:12=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
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

