Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF97FC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2xJ-00007s-OU; Mon, 17 Feb 2025 10:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk2xF-00006t-AX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:22:42 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk2xD-0001Qh-3l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:22:41 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abb8d63b447so167427266b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739805757; x=1740410557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WWGKNxiozGh75XkklhUkHM2qBIGifIFRLsE6JUAYtc=;
 b=v5nkVGWXeh5HK0NyHPe4Z2VN69FhrMWZe3ASgS8m8Bqgusbv3Ee1gWx+WEDH6oSSZ2
 qkbU3FY7ntyB7mxMRKG9fmTyfAaBcQha7m3bs7/8RN9BtFnHsmjk73OFA8oNWbDzMpOX
 pp6wYlgbhC4CLhGk9Vx5z7duGn8f9G2WCqZJx2klzEfCXJiqwdkiF5aFP/6P1lG0woti
 jbALcTSy5XuBpuBurtn2DFbP5rWx/f+GPT3/cp6FtZ1eBCaywpaj9WIsCPXvsWWgmR6F
 xXj9PBnBIT2GNmWXvvCbN5mxkaK2mdJD5N+0+Mf0TmwvI4FjGFHDmBBEnYn+k/c0bjm+
 h81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739805757; x=1740410557;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+WWGKNxiozGh75XkklhUkHM2qBIGifIFRLsE6JUAYtc=;
 b=RVS8mP5z0gUHhV7c+fgWtFze0clVhOdSkpqySKQjKKjKUjX0wLcFnyfJkLHPZvzyDl
 1SQsJu2qV/6rGcOduPD5/bXoJSuJJIBgMDIxfb92oOTEU2t2tAx0DWc37yw8TRouq0DT
 4K/c5Nnns/kRWwHuBz0cwicvKWJN0OJW97Fw6l25pS3rz96AFzfmeQjzbqS5biHI7wXR
 zEM6l1/Cmgfc/3gfrOlu+g+Gc8+T6ztSUFqLAd7uuWEwaPqsHhEH5BTEKkZD8QGLAg35
 54ftA4Av4FohdJdv+TmgrYDZ1Y61pc9994A/ACqwgIq2UsbjYdGObMfXVgqTydoy/xCV
 jLbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs0CvNZn0llwWIP+q4GI5tfYcTmoPVBpHzJugEXMAxWY/SJHCaL3r6eBdTy5yALt7ltmZi7/FAsadL@nongnu.org
X-Gm-Message-State: AOJu0Yy3S3NttnqEg5k++twSJjEXxoNohyZeaCmlhF+L5NbNZ80G2fQp
 a8XFD224Gvv7p0zO+rVlIzZX63qLNAJKe2Vwnl6cCJfiQHv0cMeZscZZTp1WCoQ=
X-Gm-Gg: ASbGnctY1Hs3HhRWkbmOZlUeqFINr+gRfjJJZQX+r6YTjPAsAanO67CAy2P1TjeslMV
 upgPtyNfB75ffgN5PlrYOWGzrOma15JOET+MCKh9kv519cHZaf+dRNVE3uAlxxTR2MgJX0n1WAf
 pxL+Jfk1gVWx6oi7Qwu7xYfpX8H5xjoQBuhQB8Kj2OuXJgPKwLt5rsP/XTyghwDtvH/8fcbQ5uA
 Ld9YkYrhAeb2QjaPHNMalICAfLhpWwW+xPegqw5yTGKWN/q62PLsT8HQRcDP5iwje4Q1NUYlD1q
 LFAqIjJcN0X1YP17qg==
X-Google-Smtp-Source: AGHT+IGBU8JyPxlo67GfMYxtmsxmejrUaTtVzeau0aOtFEo0gAPGM/4o5qeLPaAoaS6zwz+HmHmnoQ==
X-Received: by 2002:a17:906:6a02:b0:ab7:e1d5:d0c3 with SMTP id
 a640c23a62f3a-abb70e3fc7fmr992525766b.51.1739805756572; 
 Mon, 17 Feb 2025 07:22:36 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb804fc0b3sm434856366b.11.2025.02.17.07.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 07:22:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F4E45F936;
 Mon, 17 Feb 2025 15:22:35 +0000 (GMT)
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
In-Reply-To: <f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com> (Dmitry
 Osipenko's message of "Fri, 14 Feb 2025 19:03:44 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <8734ggpped.fsf@draig.linaro.org>
 <f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 17 Feb 2025 15:22:35 +0000
Message-ID: <87bjv0lhok.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

> On 2/14/25 17:33, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>>
>>> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
>>> DRM native context [1] mediates lower level kernel driver UAPI, which
>>> reflects in a less CPU overhead and less/simpler code needed to support=
 it.
>>> DRM context consists of a host and guest parts that have to be implemen=
ted
>>> for each GPU driver. On a guest side, DRM context presents a virtual GP=
U as
>>> a real/native host GPU device for GL/VK applications.
>>>
>> <snip>
>>=20
>> So first the good news. I can now get this up and running (x86/kvm guest
>> with Intel graphics) and as far as I can tell the native context mode is
>> working. With Dongwon Kim's patch the mirroring/corruption I was seeing
>> is gone.
>>=20
>> I can successfully run glmark2-wayland (although see bellow) but vkmark
>> completely fails to start reporting:
>>=20
>>   MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_FENCE_PA=
SSING
>>   MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_GUEST_HA=
NDLE
>>   MESA: error: DRM_IOCTL_VIRTGPU_GET_CAPS failed with Invalid argument
>>   MESA: error: DRM_IOCTL_VIRTGPU_CONTEXT_INIT failed with Invalid argume=
nt, continuing without context...
>>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space lef=
t on device
>>   MESA: error: Failed to create virtgpu AddressSpaceStream
>>   MESA: error: vulkan: Failed to get host connection
>>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space lef=
t on device
>>   MESA: error: Failed to create virtgpu AddressSpaceStream
>>   MESA: error: vulkan: Failed to get host connection
>>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space lef=
t on device
>>   MESA: error: Failed to create virtgpu AddressSpaceStream
>>   MESA: error: vulkan: Failed to get host connection
>>   MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:6=
81: VK_ERROR_DEVICE_LOST
>>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space lef=
t on device
>>   MESA: error: Failed to create virtgpu AddressSpaceStream
>>   MESA: error: vulkan: Failed to get host connection
>>   MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:3=
32: VK_ERROR_DEVICE_LOST
>>   =3D=3D=3D Physical Device 0 =3D=3D=3D
>>       Vendor ID:      0x8086
>>       Device ID:      0xA780
>>       Device Name:    Intel(R) Graphics (RPL-S)
>>       Driver Version: 101068899
>>       Device UUID:    b39e1cf39b101489e3c6039406f78d6c
>>=20
>> I was booting with 4G of shared memory.
>
> Thanks for the testing.
>
> I assume all these errors are generated by the failing gfxstream. Hence,
> may ignore them since you don't have enabled gfxstream.
>
>> Later versions of vkmark (2025.01) fail due to missing the
>> VK_KHR_display extension required as of
>> https://github.com/vkmark/vkmark/commit/7c3189c6482cb84c3c0e69d6dabb9d80=
e0c0092a
>
> This VK_KHR_display problem is only reproducible with your rootfs that
> you shared with me. It could be a trouble with your build configs or a
> buggy package version used by your rootfs build, more likely the
> former.

So you have built that latest vkmark? This is a recent addition to
vkmark for the 2025.1 release.

Does vulkaninfo --summary show the extension available for you? It is
certainly available on the host side:

VK_KHR_display                         : extension revision 23

>>> # Note about known performance problem in Qemu:
>>>
>>> DRM contexts are mapping host blobs extensively and these mapping
>>> operations work slowly in Qemu. Exact reason is unknown. Mappings work
>>> fast on Crosvm For DRM contexts this problem is more visible than for
>>> Venus/Virgl.
>>=20
>> And how!
>>=20
>> With drm_native I get a lot of stutter while running and barely 100FPS
>> (compared to ~8000 on pure venus). IMHO we need to figure out why there
>> is such a discrepancy before merging because currently it makes more
>> sense to use=20
> If you'd run with Xorg/Wayland directly without a DE, then it should
> work okay. This should be a problem with unmapping performance that I'm
> thinking about.
>
> That unmapping problem is partially understood. Unmapping code works
> correctly, but we'll need to optimize the flatview code to perform
> unmapping immediately.

Why immediately? Surely if we are unmapping we can defer it. Or is this
a case of having stale mappings making the life of new allocations
harder?

> Meanwhile, you may apply the QEMU hack below, it
> should resolve most of the stutter, please let me know if it helps.
>
> There is also a pending Mesa intel-virtio blob mapping optimization that
> currently isn't available in my gitlab code, I'll refresh that feature
> and then ask you to try it.
>
> Could be that there is more to the unmapping perf issue in QEMU. I'm
> investigating.
>
> AMDGPU nctx is less affected by the bad unmapping performance. I expect
> it will work well for you.
>
>
>
> diff --git a/util/rcu.c b/util/rcu.c
> index fa32c942e4bb..aac3522c323c 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -174,7 +174,7 @@ void synchronize_rcu(void)
>  }
>
>
> -#define RCU_CALL_MIN_SIZE        30
> +#define RCU_CALL_MIN_SIZE        1
>
>  /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
>   * from liburcu.  Note that head is only used by the consumer.
> @@ -267,7 +267,7 @@ static void *call_rcu_thread(void *opaque)
>           * added before synchronize_rcu() starts.
>           */
>          while (n =3D=3D 0 || (n < RCU_CALL_MIN_SIZE && ++tries <=3D 5)) {
> -            g_usleep(10000);
> +            g_usleep(1000);
>              if (n =3D=3D 0) {
>                  qemu_event_reset(&rcu_call_ready_event);
>                  n =3D qatomic_read(&rcu_call_count);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

