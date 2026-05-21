Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC53CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyY1-0006Xb-1i; Thu, 21 May 2026 04:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPyXu-0006Wl-VC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:14:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPyXt-0002dt-CS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:14:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso4906688f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779351260; cv=none;
 d=google.com; s=arc-20240605;
 b=OARRRMPzEIZRPa56sfTagWc76OMGmi9oaAvtRVtfpebc1kM2oCQV3I36daCOzpG0pX
 7oNC/hqcQ+P2zAmewKhNIkPdil2MLTvYzxzF/IgxEvS9XCXrsXs+nCL6/nfiWg3JSNgi
 dHYEeJv3p6dnXs7a95BhHWHAywZuXzars3Y/5XLRcOaBFY8qTkIagQhgq4pbfYu66uOG
 tmEl1UepKiC+Ywu0BgMg+eDLxiAuGk/hdgmxkURoNH5EN/94PYMMng8sPm/HTs2Crw/e
 11+T9pX4O86IGXw14j5jvouhBKeFgX2mVt93013Mh3OcyaMhjj0VGmgpd07OAsW/1Pk+
 qPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cFyEKc2RuFzVXv14aIK2p2xMrCEP6O/kFOfswcQzhEs=;
 fh=4Ie8pqyCjq2wtzfHfXl2d/Z/EkaVMCQZv32AAhh/p4A=;
 b=j3eTAh716sLcRF3Hy1UQUNRbWnddY32RXnW/BrX08XA8m02XQBa4r2T+zfHQooAzvo
 l4V6A724WZ0E/uljJPCVD/nASwCW+dcLHhffGJzBtSil1qq8DrTeHMJjD4IPaMPSwZJp
 3MPM1MV747j2gHSNFF/wNSjVrZe796yDWV6Fs5WinXI8P0bIrV+jNsGPwgXOLtIUxmGA
 KMEwj7YOCJOLbNpHMRevMfHdA1fzUfP8//E5SukCmVNTWKGWsu39FvOzZDX8g4xnlofZ
 Gz7WZOANPG2ZZc65n72dIJYhn6giOWTHYA8YMOK6AQZc+cH7GBo6Bze5ObHhoT7EEHoA
 J0xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779351260; x=1779956060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFyEKc2RuFzVXv14aIK2p2xMrCEP6O/kFOfswcQzhEs=;
 b=agbL7lw9PwZJbBYeGZc0nzPIMhk79mWcZs/O3HlSAsfC4FOdFNjtcnm1rVPttVN0mi
 hEEr+N1OMFx2PdOb0WmKr49ovhByTGV10RizCKCuYAEFegTwR4ncGVEX1XIMmC6Hq3Td
 SQLf1FYVPnMXnaltsasgpAlWJQXJ3QxMDvEmGLSXe1/AvfEbQacXJ8alv+8T1tatyR3q
 GhJYa1EXZ+zetz09BFVxGliQqttk2rlNpInRQ7MFMzjhnr8Rf9KcqQ+Ta/k1cQS4/wIz
 HuCNdP2pbTPXIY4cLhWENI8i8EqZlp2XS5WsP1ujBvO9hCkDdqS2c195fCztKvpnAWU+
 FY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351260; x=1779956060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cFyEKc2RuFzVXv14aIK2p2xMrCEP6O/kFOfswcQzhEs=;
 b=ehVCe448HDJXL1YR831MvFCV0I39GSDi9xT39gLCZD+tRAsuyzGoNYXO480AndkxMp
 QVk0t70+7FyGQXtX5MZHvuVyJzsds+qKljjjf1hj86xYEkBrc1V9Xa+SuhEcbIv5KlfX
 Ys8oMdKcGFu5gpKws9k3ht1VS+120nKcyGjRMTVkHFFwJ3BHqikNdQ75REBIOyzvz7Fn
 VWl8hbCx8xGXseXFhKZiMXNXYIlDswYFC6LqQCXX0kQ80vCcMosJhID59PqXkmvvEyOk
 DEzOYoE16Y3dZdVcCMHk1PTEmt/YobswXkVp6m0bhb23wVRHehMzxhS0V90h7Lrez9Qo
 HL1Q==
X-Gm-Message-State: AOJu0Yx+g88AmdpIZH86kCaaO3i0GaNBUCyQ8Ot97V2MwBs7LltomWBZ
 7fmIMsHyvirFuaE5ieTM1nocsIzM6Y4Qb5QYa6i97FL9QwRlVPZrEJ6zgxfph4FAMVDYRrNr/L/
 XZp2blTEgk/mSv5kJbOhuMQeCnPQk29dTZ/V2zVYHhg==
X-Gm-Gg: Acq92OG5+ekFD0s4h4A2Jb+sP0wQx00fFllPde20Ipi3qMueQ5IsXMkCS1LpQrjpy4o
 ggQhKYB6K4XVtFq2EfZTCYhY4BqdUktWRbRryjfgXGEI1LehAQrnlp6O6/I6xGfiIcUmcuu8e6g
 6CHjU4+vCas13wusuNnv9Mnf/7pI287rdJja0U0pFfuwR8hjRpMx70xEPXVu9zHvAdLOrcdtozJ
 JNwgpaHjTdZDg37x1qx1f1hD/vkOHlvQT5EcjWMvRCwpA3MZE7BeG4ICTB+KR4OXD//Sw1U1IJQ
 3C1ofif9xCDCaO2Zk0UgVHE1e3uBRAGcf8al2flOPg2z7rFGIA==
X-Received: by 2002:a05:6000:1884:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-45ea36b099bmr2861780f8f.10.1779351259691; Thu, 21 May 2026
 01:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-26-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-26-armbru@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 21 May 2026 11:13:53 +0300
X-Gm-Features: AVHnY4KztKJl1ywlSjP52t5jXrikSxhypwLf6q0580sSW9Hr-EdAl6iciyabCNU
Message-ID: <CAAjaMXZnV-RJM18OkT_eyC2ni4eCJcMKkyk_xJvBpWoMnG8ouQ@mail.gmail.com>
Subject: Re: [PATCH 25/39] MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Thu, May 21, 2026 at 11:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> We neglected to update MAINTAINERS when we moved
> docs/system/devices/virtio-snd.rst and
> docs/system/devices/virtio-gpu.rst to docs/system/devices/virtio/.
> Update it now.
>
> Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-=
10-16)
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks,

>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03817a0ebe..c864fb971d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2613,7 +2613,7 @@ S: Supported
>  F: hw/audio/virtio-snd.c
>  F: hw/audio/virtio-snd-pci.c
>  F: include/hw/audio/virtio-snd.h
> -F: docs/system/devices/virtio-snd.rst
> +F: docs/system/devices/virtio/virtio-snd.rst
>
>  nvme
>  M: Keith Busch <kbusch@kernel.org>
> @@ -2802,7 +2802,7 @@ S: Odd Fixes
>  F: hw/display/virtio-gpu*
>  F: hw/display/virtio-vga.*
>  F: include/hw/virtio/virtio-gpu.h
> -F: docs/system/devices/virtio-gpu.rst
> +F: docs/system/devices/virtio/virtio-gpu.rst
>  F: tests/functional/aarch64/test_virt_gpu.py
>  F: tests/functional/x86_64/test_virtio_gpu.py
>
> --
> 2.54.0
>

