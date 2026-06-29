Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191F7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9nE-0003cr-Gz; Mon, 29 Jun 2026 07:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we9nD-0003cQ-FB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:04:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we9nB-0002bL-9v
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:04:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so2102505e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782731083; cv=none;
 d=google.com; s=arc-20260327;
 b=TrLvhZ6MGGiOpNDQYgGbZOmU4eD4lKwTzdUY7DLZX9lZcF2ap57yIYaoDaomKZW6wK
 /Vvjn+T3yxeZzCrjgyULKNMlf7wBmOEy7dU7GeRnVy25cQURvcsfCYj5bYjgT3LFkb74
 SJiVg0BIdQ+y6X0kKqqAldhLCHF5QB4iiHjH+ejZ2f3LiS0CJG9s5JdqPIjlgCoYoksW
 iInQv+Exp5JfEtq4jGWlqC/IT03/raIQZxkDHrvHxWFabZfcSJ87TleUtAEeLubMyGpZ
 Zk/I3pggPfxt/o1W0q6woZw7TG1w+EZWp/58zQlHUMnjB5yqnpdgGPvBr06LV6DPwLP/
 YGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ode3gc+oa6EJOWIDQa/ErNDO3rOM+s5mh32PACNAPFo=;
 fh=8RUj9I7f+xWGgTMe9QkV6YSB9vzdqYA/iBz75JNnkZI=;
 b=SdNY13iD3lmSmjw4RFvzsBsYeJrm24HkyvuHNXix4qRqGqoL7uOY6ZunIW1+Hnzjrk
 +qy5xoR2UMejqzHkEYhD4A5BU70R2Q+TaU1zb4fGRxFy6WNtl7NvZO6kAa+suYPPh+fY
 e6YZUSVgOOdG06MRy6HZ1qC8TRoJx0s+5BZVgAz7zb8QLBycTja946XCewRMJPf+JyOP
 +l7seBdIC81jDulTE2TSJIs9Gr1Z3jMot43sXOB5DbaOlIv6EEUqwvzbkDcnaAIBheFI
 tRRCw4MqgvHmrYLcpSb56BcgN2dz12Aw29AR4xuXqOtEz1fA2rQdzLRlHZmSYnDHB7Su
 8Ebg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782731083; x=1783335883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ode3gc+oa6EJOWIDQa/ErNDO3rOM+s5mh32PACNAPFo=;
 b=A6EY2Eh+wTXneZzZNj1Ly9N8Sa0f75FrI3alWhv5l1DcMbCFO5WaqonnDN3VaeNpYL
 Z0tKuu5NXJ8ncQCezCDP5N/UNlh+i26FNGwWDHEXrvkrePl49OVI5NIs2a3ght/Mr2xK
 okY7KavTvdsgh2emgXPUL+9r3vrOAt8Np7t8GVds1ChHPk9pIVvqYN901ekZNpeUWLwz
 zJPxdq91JFbXBi22dtsKFAY7jLIvXeQlt3ilFsrHrdCII4r6dNQTsmiF+1+KYjTRLoKn
 CwSEEm2AI1KU26s29OyBmyZRDTQKBeGF60BiJ9gW/wN38NXHO4mOXCGjE1T5MvsvuYtR
 MNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731083; x=1783335883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ode3gc+oa6EJOWIDQa/ErNDO3rOM+s5mh32PACNAPFo=;
 b=SQ3SFBkR3Z+N1fPjOJLv9idP6YTMP8SZKUMP8ZugT6sGEXdLa/qlK9KpHt+Typ/49T
 9B9ufkZ/l2/ZGvaDwepGo0jph0Cdf3xvAB/as8joW/dLd+AQnOmk3qVj/JF9SWGt56Ao
 cUAwOmuhXLor3t5wsFzt0M5J/k/ioEvnpPCEJtpvz20rzP6eCwxU9zUyZMCLI+VGT+Fm
 hc0ApvFBtsqet1dEoruN2+SHeGCMmNtprUoAOT848HWvCV1pV63Zm2FZAt0GMAdpxzkB
 mbCuwo9rTLqiayooIqZwBgE/HeQKCt3H4Q3mvgozP2M9KhMUIhq++AbaTKmkJucufs+3
 IcSw==
X-Gm-Message-State: AOJu0YyJY2ehLSGUCgfi1y+V/toZRFxl2PgudCSwIc7+d70YMLF1Umxj
 1bspQdIfDb1DmTTBYP0mdw+cnUZxh8ijxp68TcCnozCcN8PuoflS4bVIKzLFhLdRdArj0GOIe0b
 ujcRzvvOMpPtFdgihy0/BegyacEMfLSEsMeDuDgvXBw==
X-Gm-Gg: AfdE7cnI9Y7Ln3v8HajNi1CRJr8bvEKIXMqqDlwAT78jcVQw56/l9+diED87VqvBFMX
 WmrwJXEHDD5/nV0yFRMfSZezZ+7+FYofzU5Et7USCRzUyXqFXZQMjYOjFux8EVeWrDG5zJ9xsma
 j3eCfBpAvMfRI9WUPn/lFyKZbeSVDyaJM6yurBMrbgjHAqfW57V/vtRz5arZRPoyczBnHu7lzK3
 QHcSYjhASPpGlbVJANOfMMe6Ae241aMeExIEGK3hU+GIErd4AOljqBhaL0ocvtqK3RkkT7z1leB
 idad+yReFgOWHeP/t66UxfRNDHbe2Rlcxf1kHPAHTPvAN6JH9ospeqsV07IO8/KFiPRvZ7Jvz7D
 0AvLa60Ck3CiZGlw6cqE=
X-Received: by 2002:a05:600c:1908:b0:492:465c:56f6 with SMTP id
 5b1f17b1804b1-49266873d4emr244320295e9.10.1782731083174; Mon, 29 Jun 2026
 04:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Jun 2026 14:04:16 +0300
X-Gm-Features: AVVi8CcEY52K33GYkfBvpqWFh5hwuh8BR0QOnP0DbZMU_2S4h-kIQvuA9KM5yRY
Message-ID: <CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] hw/audio/virtio-sound: basic migration support
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Alexander,

On Fri, Jun 26, 2026 at 3:35=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Could you please send your patches from your
aleksandr.mikhalitsyn@futurfusion.io address for the next revision?
Replying to review comments with your personal email is fine, but the
s-o-b should match your sending address. We do not know if the address
belongs to you otherwise. This is not explicitly stated in our Code
Provenance documentation but we need a way to verify your S-o-b
provenance.

Thanks,

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
> Alexander Mikhalitsyn (1):
>   hw/audio/virtio-sound: remove channel positions field from
>     VirtIOSoundPCMStream
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
>  hw/audio/trace-events         |   3 +-
>  hw/audio/virtio-snd.c         | 679 ++++++++++++++++++++--------------
>  include/hw/audio/virtio-snd.h |  26 +-
>  3 files changed, 399 insertions(+), 309 deletions(-)
>
> --
> 2.47.3
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

