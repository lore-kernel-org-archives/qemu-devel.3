Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0EC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwl7-0001uS-St; Fri, 14 Feb 2025 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiwkq-0001pl-0z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:33:25 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiwkn-0007Es-QK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:33:19 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so3780925a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739543596; x=1740148396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTIaYVbvgeKVCxjxTPG8zXLvteu1AlKPN98Z9Zf7gJA=;
 b=SpSdz9NbaFdyMXikmOTJNZwpw2x4u3a4I0B/ASJ/OIRIuO/oc80tzurdBs0Jnwwzm4
 g3WVp2BEHg9jPvVTgK4HpKim1J7mGJjWgOMMvh/jmB8fv+Fc7RtEdiXVi9MbyTl5g/Ch
 H3q4xowR6SBMh1BCFeIVG5goGUxHV1r1dElRW9s+VLyAgeIDRMxFvcfzy462f7oY06CB
 YJ8FLfa3gN1MCgMD4875ADTiQstdOtFsHy02PlYL/ytOLDIWcUps51S2qEA+xNNaeNHU
 BZie9/MHOIPOt1tPDilPJwuTzOGOPEIldQ15KhPVs4bvg4k7HBDYLWzxoO9/KHLQeAX+
 B1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739543596; x=1740148396;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NTIaYVbvgeKVCxjxTPG8zXLvteu1AlKPN98Z9Zf7gJA=;
 b=nGaVwxQwcQCheEKHnSL/tzH4mLkuadyX0Pf2enRTVtAAZdm2hraNSu5c/iIrH3uQuB
 mQpRlIAEv2uA9cx/So1CvEbOCqM36lRXHeiDKSh8U59+SC6tJMnRSHfd0zpIoOTEJrRO
 EVosXh+Iy1kuRRTqIQ2w1dgN6spNKsjTr6cCC4cy4uoipeAftU7AezEFkiO2d8LArzs/
 27qYuhnf2nj0rokx3R5vn23o30Amy6yehUfWIwBb+HaZHgR/RCfAFh/Ye2Ps8cpT6D+N
 jUDBnSHXQUJkms7hzKockFtUtiCW3M0IeMaYHSGkiZ1yy50yuHkIGxuyHggoDfBJeglI
 1Cvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqMnUw+ostBP5UR9FOxtJF16h6CoaXQFmQggqDnzETl5eEDn+kz38D6bXAw1VdcCm6nsj/ksOEe2Uk@nongnu.org
X-Gm-Message-State: AOJu0Yw+2ztJ/XJpmZo/6Ul3baDzBwIIkVHNlbIu8N8cAmTOfgGsWa6y
 88PG998sBtA5tTAcw8d19GeLGc7+VQA+q92YvsdMriZh3A3fvjofv8k/+sshQ1Q=
X-Gm-Gg: ASbGnctfbNTiCVZkALfDuoBfDvF62dUfTrxHvQVg3UN7HARGGVQSgE92WFCKulTsNPh
 w42iBO3HEN2mDhVexaJXYYG2yVy9oNl0lUssEom2PAUWSeHHaLiuPUMNIWtYpXfvEjdBXrr+4hz
 axrgj5MQf9B/kx2WOCwK/SmGnktU8feOZXXqOt93HJurXjtz8cwb/AvP+SuzqgtbvEqMIF+kq/K
 cUDagfN/2Pq/DMWOAv+wDcK8v4nsZJd4Zfn0CBThWo/guf/Cm+bBpqyJRQqCPJah++e9+a4sktX
 HX1xx6Y8fSilBCjhaw==
X-Google-Smtp-Source: AGHT+IELRYCCQoOZSkYMBzINI9HYfMynA0v9bCS2IrtFslSjtWGATjZZwSuGNDODgsxfMjQN8hV/WA==
X-Received: by 2002:a05:6402:40c1:b0:5dc:1289:7f1c with SMTP id
 4fb4d7f45d1cf-5deade0a57fmr11744869a12.29.1739543595983; 
 Fri, 14 Feb 2025 06:33:15 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1c4646sm3022492a12.27.2025.02.14.06.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:33:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BB395F8FC;
 Fri, 14 Feb 2025 14:33:14 +0000 (GMT)
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
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
In-Reply-To: <20250126201121.470990-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 26 Jan 2025 23:11:11 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 14:33:14 +0000
Message-ID: <8734ggpped.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
<snip>

So first the good news. I can now get this up and running (x86/kvm guest
with Intel graphics) and as far as I can tell the native context mode is
working. With Dongwon Kim's patch the mirroring/corruption I was seeing
is gone.

I can successfully run glmark2-wayland (although see bellow) but vkmark
completely fails to start reporting:

  MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_FENCE_PASSI=
NG
  MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_GUEST_HANDLE
  MESA: error: DRM_IOCTL_VIRTGPU_GET_CAPS failed with Invalid argument
  MESA: error: DRM_IOCTL_VIRTGPU_CONTEXT_INIT failed with Invalid argument,=
 continuing without context...
  MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left o=
n device
  MESA: error: Failed to create virtgpu AddressSpaceStream
  MESA: error: vulkan: Failed to get host connection
  MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left o=
n device
  MESA: error: Failed to create virtgpu AddressSpaceStream
  MESA: error: vulkan: Failed to get host connection
  MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left o=
n device
  MESA: error: Failed to create virtgpu AddressSpaceStream
  MESA: error: vulkan: Failed to get host connection
  MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:681:=
 VK_ERROR_DEVICE_LOST
  MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left o=
n device
  MESA: error: Failed to create virtgpu AddressSpaceStream
  MESA: error: vulkan: Failed to get host connection
  MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:332:=
 VK_ERROR_DEVICE_LOST
  =3D=3D=3D Physical Device 0 =3D=3D=3D
      Vendor ID:      0x8086
      Device ID:      0xA780
      Device Name:    Intel(R) Graphics (RPL-S)
      Driver Version: 101068899
      Device UUID:    b39e1cf39b101489e3c6039406f78d6c

I was booting with 4G of shared memory.

Later versions of vkmark (2025.01) fail due to missing the
VK_KHR_display extension required as of
https://github.com/vkmark/vkmark/commit/7c3189c6482cb84c3c0e69d6dabb9d80e0c=
0092a

> # Note about known performance problem in Qemu:
>
> DRM contexts are mapping host blobs extensively and these mapping
> operations work slowly in Qemu. Exact reason is unknown. Mappings work
> fast on Crosvm For DRM contexts this problem is more visible than for
> Venus/Virgl.

And how!

With drm_native I get a lot of stutter while running and barely 100FPS
(compared to ~8000 on pure venus). IMHO we need to figure out why there
is such a discrepancy before merging because currently it makes more
sense to use Venus.=20

<snip>

I'll do some more testing with my AMD/Aarch64 rig next week.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

