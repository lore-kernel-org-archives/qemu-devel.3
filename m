Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD3BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8c5d-0002v2-PF; Mon, 21 Sep 2026 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x8c5a-0002uk-Eb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:21:38 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x8c5K-0003sf-VR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:21:34 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2953a01240so405661166b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 04:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789989673; cv=none;
 d=google.com; s=arc-20260327;
 b=fY7CwvGkYLasvqhHLnxk2F7PUW38k5rN++1xhPjG1ZuTAj5cp0e1tSOfL7tRe2eJee
 My2W+Fk0fgESUslq0zJzUFmsr7FMkca0m/1QzB2bm5ZNGcwAV8uuzOJke8deYzM96cWy
 QI+IY0RuS+cMWL4IKgqhZ8Z7M8Kro3SVOCTlpMV9Zd34friedQyhdmrkQxTIjDBs4TV6
 3iVomkuq8tOYwZdHW9CmrInsbofQIPvnbTL9LVP3a/OnbYoDxvln96HFLUd/L8/G2anx
 rhIoSb1MZlt7R7/1rrzS+gH7zhr66P5z4XRbL5kmiay3xCYOIebpJKT/KcY5LcNrc9pH
 Ccgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HkY2Kp6Dq6xYVUqUFZ/2o1dghSee/9c+nLqlJzLVuQk=;
 fh=+YY8Td6BzP/pG4PCbnufthTNhmxWwkmv9wr1dFxI/U4=;
 b=swt+IWQREv+kuvg08B4ApLfZSWOlmsS4grdHR/HwLnWpSxBpNHH0LYQ30BGdWy4Il7
 qa+Ecw0nc3jIFon44b9ndgQKRqWx2RTR3CbwgfYFuyWIkba2GzaF+dX/nDXS5u/9/P9/
 y6v5ZRCgAjbwwQtWnNTeciffteXb5mcP6uYuwn8D6nX44e3+OZqXB1ka8P1K1w3kTVnj
 hBQcdxjrrrUwz9394iCq6u9GDTAUScoo5NuKH/fdPIZMrUOiO4E8xEM+NcXqUXmOqU+Q
 lvQd83Yxa8BS8+g9HUmEzeO/Ivdsk7ZrvOmwozhxsJKC2GynAZj5J8bmTGeD5y1M2lYt
 nkgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1789989673; x=1790594473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HkY2Kp6Dq6xYVUqUFZ/2o1dghSee/9c+nLqlJzLVuQk=;
 b=eSnouzuFPAuHCuqPMyFEw2xJ//6QtJkyma3wcB/9+wiO5Qr2celeYxRR525LKs7Pdl
 4t3djUd+ouVsqwisPcYocLEiSW1Teytq+0O0iwwIolV6wJjWDx8pr81YOCruHlFDEN6A
 +TSh88KuqjBBKzx50PzzOvt/fWXGng7/iQaUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789989673; x=1790594473;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HkY2Kp6Dq6xYVUqUFZ/2o1dghSee/9c+nLqlJzLVuQk=;
 b=P7fSNWFUhanF/HxBQV+24EHufY4/Y6orYfX+3XZ9Iv7NwYVZJAsKKom3PxtmM863bV
 52jGLc2dXJtqQ9Ig118Pu5wyTDeylyNpLOocbzBysyZ4nQzpl7ocKgaUQus2+WtS8qQ8
 vEhGHaWexMUNCrU07xrsi+SPSYpQVvrGz/BMnnPIzT49T/7HFxui0exNfnsze4+gH26/
 HnE4pksdeTGil/fBm6V+fclCmPB+BA417Cg+f3WUwMxO3SFP9THP4O62BCIFlGKBoz5w
 204M8PlEFyQCSl9t6+FNlBCLlJL+RQAO+A/TVTKnFTj3Y87LnK87/jxQucE9l7gJyF8p
 LbuQ==
X-Gm-Message-State: AFuF++m+FnoWEc+8xEYOE+cqpl4syoLbAKk/lap/HY/kDKFxGGeNDxCW
 B8N6Z1PZifTCemwAHGlb3Lc76kzFeaGEAIJtmbwVseUplh7P3LRtk28HIBVh5HWAbzQH8h6W4ua
 ZfWlvaxyyOGXemywTLLwOjHL38Dy69OTSDv/ERcUhBj6xCVRVOsG0
X-Gm-Gg: AYBFou1Xk/rKUCj8k+SjjyDV3Mq+KiWIQt23NiHSELNLwxe6Q7a7qLw+h6scgYb8Y09
 ZwEsu+eSNmwPeT9R97pXS9sFeJSzSc+/dG2xgdajTGQNuGavYxyLmWUYmQHsIkkKXoZJ0ZErJSP
 KERcOy5pLxrnvkw6db2F2ybamhClmmGtrjDqR7Kvo01xstmFqMRAGCtch1Ae1YFceQSgZv634+s
 bxtdfmemq2RpWmFv1Ae282xSUNF78CMgXMjKsiTg6CVPsZGS9UWm8aKpPYfVmKhKIRrBjdpBc8K
 1loDsrSQGi7RsqmwElsA3rmbKuNNPH35POJ8RXchyPo8fguaUyoj6QfJTU9ZL9Dnw0oqXB/s6ht
 Uem7aT0FH6Zw=
X-Received: by 2002:a17:906:f597:b0:c21:8c6a:c680 with SMTP id
 a640c23a62f3a-c2a159adfdfmr853843066b.22.1789989673286; Mon, 21 Sep 2026
 04:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <CAAjaMXaxAXJcufXy--q9b1o9Kd68N4zvoLX9srrCuKsOB_XTkQ@mail.gmail.com>
In-Reply-To: <CAAjaMXaxAXJcufXy--q9b1o9Kd68N4zvoLX9srrCuKsOB_XTkQ@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 21 Sep 2026 13:21:01 +0200
X-Gm-Features: AcwNN1V3_keTvNaE3j5FqqBnMaw41VIknnglUwdAv2fr1Q4t5yP985Zaoc8m4oo
Message-ID: <CAJqdLrpMQqfB1qXdcc3JnXm-_-tx2+aGAMXq70MxFVtHxPijsw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej2-x10.google.com
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

Am Mo., 21. Sept. 2026 um 12:33 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> Merged to master
> https://gitlab.com/qemu-project/qemu/-/commit/c1c18d1e640b64292859ce9f30f=
3c344edfb0294

Great. Thank you very much again, Manos! ;-)

Kind regards,
Alex

>
> On Mon, Aug 3, 2026 at 11:12=E2=80=AFAM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
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

