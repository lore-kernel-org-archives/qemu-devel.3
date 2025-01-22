Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDECC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tae5i-00086o-Nd; Wed, 22 Jan 2025 12:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tae5L-0007wn-1y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:00:14 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tae5F-0000c4-Nv
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:00:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so50167055e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737565203; x=1738170003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIrBZ+7+jhmh9C1WL+7alT0Ya9pKzT/iF9eErs9R8LQ=;
 b=QNM8wXvHvsgp1szPCmAglc3UaQKDoEyqICmVx23ALtAcwYjhAajFogayEksi7DollP
 ShnARBRS52x3lFR/2OT+dNBowXaDpzpF+sLERyWj2sV6oyVT7aX/oTC8WAozwqYNObY2
 SddFHX2osZ1XLcK9vhaM97oPTk7tpUnR37X/o8uYBqEV09J+1DmG5Qd8U83ukTuYohdp
 9deIQLKGvFT8h7wBh3R/btwBnBJUE0Z17SblB3anYu06x1vv38Xt7bkS9hEfld+RztvX
 /sntlEBsR9qK3jdCKfeD/9iDU+FdF7rINadiadz7+W0oJe8FuUNMRh+V5tSvIkf2u2PV
 fZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565203; x=1738170003;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yIrBZ+7+jhmh9C1WL+7alT0Ya9pKzT/iF9eErs9R8LQ=;
 b=p1d1YPTcs4iTsLasHHjZCsba47xBbQhKZwBEY7ZXFIgEdrDIw6EX4lUnhu9SfUh7PD
 W7IHbuld5GpK1F/hoiuhxJ0AURnUQCbDE7NNBWZirvE/cTuAsNSZdND003Xm2kCEsnGr
 n127N6Izl+OVMecNMSV2ofYX1FBOcARFY9sFBINsDf8o3uGgN7TKwMjJwQyCt2qJh4hs
 LK6RJjbSL5Srm5F4QJPh+QWwSIdcoIN4RiHOgO52HxMUs4A2jU2FD0/bsbihk/uxklsl
 zCQyZbD9A4mnFQ48Fn5tk0oUEqH4O77E72XFYock0NVODyCGnWsMWqoEbqXAF+RAmFnQ
 Tq0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUBUgGfqMb8M1YW7B3miTtYsg8JkaVd5VPR3Qu5P7SLpMBjtYzzkie/iNy8ujP2JN3TuqrldcgC/u@nongnu.org
X-Gm-Message-State: AOJu0YwO0KBfZXRXPV/j3t9U4iMzp7IJKcIwoLh6CXYW3JL6HZbis1Ja
 Xb+Ki5lEomuSnEOI9yJwfd2BERH9MYxg+QVdXGcO/4wWyKCMCDOhzy6MNrt1fDk=
X-Gm-Gg: ASbGncvlv2Qw8UNaihQs9eKy709SwUuYR7l1ovAtUUTVtLkBBhP7nauOdVZiFSyhU5R
 D+1G9A/Mp4PRbcQ9Rk9CLxD2qRoZJmbazJDGLcC2p09h8vlKaXaP74Xlyqp5VhAlgL0r/auYR5s
 kDqqpCtZO6Ikfg0k/UEDJymkl3wCt9BFymKPtZwDkKIjobQ2dXWnQdy6VPP0coDS8HJkIGVvutl
 UCCFjK5xiWT9t9ktASJZuEHGgz7wQv3ipZgig/50jVuST9IsoSmbRXqSLzPcAVOBFmw
X-Google-Smtp-Source: AGHT+IFJgkUbjw+Rmmb6MX2l3vnstPSrIGAuwUDnq7sBH5hz9EnODPyOwlzqh6BJ43/PrCk3IqLESQ==
X-Received: by 2002:a7b:c00f:0:b0:434:f5c0:32b1 with SMTP id
 5b1f17b1804b1-4389eecb1f5mr192920315e9.15.1737565203302; 
 Wed, 22 Jan 2025 09:00:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31adbd7sm32042305e9.17.2025.01.22.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:00:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C4A35FA4B;
 Wed, 22 Jan 2025 17:00:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v5 0/8] Support virtio-gpu DRM native context
In-Reply-To: <20250119220050.15167-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 20 Jan 2025 01:00:42 +0300")
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 17:00:01 +0000
Message-ID: <87jzamn5ri.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>
> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support i=
t.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU =
as
> a real/native host GPU device for GL/VK applications.
>
> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>
> Today there are four known DRM native context drivers existing in a wild:
>
>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>   - AMDGPU, mostly merged into upstreams

I tried my AMD system today with:

Host:
  Aarch64 AVA system
  Trixie
  virglrenderer @ v1.1.0/99557f5aa130930d11f04ffeb07f3a9aa5963182
  -display sdl,gl=3Don (gtk,gl=3Don also came up but handled window resizing
  poorly)
=20=20
KVM Guest

  Aarch64
  Trixie
  mesa @ main/d27748a76f7dd9236bfcf9ef172dc13b8c0e170f
  -Dvulkan-drivers=3Dvirtio,amd -Dgallium-drivers=3Dvirgl,radeonsi -Damdgpu=
-virtio=3Dtrue

However when I ran vulkan-info --summary KVM faulted with:

  debian-trixie login: error: kvm run failed Bad address
   PC=3D0000ffffb9aa1eb0 X00=3D0000ffffba0450a4 X01=3D0000aaaaf7f32400
  X02=3D000000000000013c X03=3D0000ffffba045098 X04=3D0000aaaaf7f3253c
  X05=3D0000ffffba0451d4 X06=3D00000000c0016900 X07=3D000000000000000e
  X08=3D0000000000000014 X09=3D00000000000000ff X10=3D0000aaaaf7f32500
  X11=3D0000aaaaf7e4d028 X12=3D0000aaaaf7edbcb0 X13=3D0000000000000001
  X14=3D000000000000000c X15=3D0000000000007718 X16=3D0000ffffb93601f0
  X17=3D0000ffffb9aa1dc0 X18=3D00000000000076f0 X19=3D0000aaaaf7f31330
  X20=3D0000aaaaf7f323f0 X21=3D0000aaaaf7f235e0 X22=3D000000000000004c
  X23=3D0000aaaaf7f2b5e0 X24=3D0000aaaaf7ee0cb0 X25=3D00000000000000ff
  X26=3D0000000000000076 X27=3D0000ffffcd2b18a8 X28=3D0000aaaaf7ee0cb0
  X29=3D0000ffffcd2b0bd0 X30=3D0000ffffb86c8b98  SP=3D0000ffffcd2b0bd0
  PSTATE=3D20001000 --C- EL0t
  QEMU 9.2.50 monitor - type 'help' for more information
  (qemu) quit

Which looks very much like the PFN locking failure. However booting up
with venus=3Don instead works. Could there be any differences in the way
device memory is mapped in the two cases?

>   - Intel (i915), merge requests are opened
>   - Asahi (Apple SoC GPUs), WIP status
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

