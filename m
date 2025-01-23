Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03690C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 11:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tavr0-00041C-U2; Thu, 23 Jan 2025 06:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tavqv-00040v-G9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:58:29 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tavqt-0000Wx-Fz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:58:29 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so139889766b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737633505; x=1738238305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJpcF5/d5YI/Ij4GEgP4kTEECceDK3+UOyRdXMkw838=;
 b=zNOhv/sEU/bwjC3fnlPt/MpZejqOOsq8vDLU7y6BDd0U5ez0WcHL52OBv4jz4TQxrI
 ToLuR0LPxN/LH+uvRDGCRnLx27CreAsLYxQUTFr/hfP1ETmOCf7UtAba6V+dHN7uHC22
 XGrLRpxjh3EJRnmgFySjHdlctTWeida8ts1MW1NxMdKck92UzTtsBU2Z3YB5WBfuWjzC
 0Y3zUtjLtGh+JXbpRKjuM7fyhjzh8mOL49sqpD6vAZXRNow0b245mDK/AYtqQUkCpP6C
 jLRh+z32f4hCvox/nGLK04CErYnXGXYCU3PReqs0qbG4HiLxYoeuszu+EZxRVH6po7S+
 UTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737633505; x=1738238305;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJpcF5/d5YI/Ij4GEgP4kTEECceDK3+UOyRdXMkw838=;
 b=d5sWv5UYnMnTCGXxi74LIk70GsYDupD9FFhebUvf4tdWejfxRN2Ms5pPjsM2S7eKYL
 MW8FM7cH+OgY9/Ycqg+WVTjVmJiPjztDnbA8fRv3H3OUNFQUohfmd3HfGiYbj3RFhlrG
 2WuEp3IzoaRDh7KGPTqsAXRYPY6jzOCioqi62vWcj1MBwKPpQsfbD9zROCeRjaV/g6XX
 e403VM9CQcaN39mBvSWWxck9CXJDzL/5llyMfuqxc8CCsSiZVHlFER0OCa2AwLRLWRMb
 nd0zwMbPmoahrH6QcS6HMXQ81jY9xtkBdrrr4gdZ+yuP3FkpA50kqSQhjFb/lICKVdCI
 ht9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzvII6Q5NoB8wECyz3Ebi8eIrjJeRErgh3twWah8Zp1jWsZskW/MWoDDSAh+utK6N19XKnO+AHMwdn@nongnu.org
X-Gm-Message-State: AOJu0YzPuYn15/vUduTgBQietz+v2gf8Gaa7YkVGzUeJZUBXyOc5jK9U
 aBqvCrjJoFZFGhqw6uVmd5AmAhoV9ENN0JdlOY55NZqJGkGfhUrZ5t+PMkRe1GE=
X-Gm-Gg: ASbGncs5QH/xBjLo/8nAbBmCsDLB7nU8Jm2h68a/n0DdmZjMIyZP2CfWdeWiou9OF60
 zC5qrA5vZZjdY1luqbWaCa8tnxEc8Qpa39Quf7bYjQ3S/mV6Kg4ui6ySZ+uh4nS0N+LLDErrDAU
 +4e0J3fFhj4xnwWxWaFVjVLTX9QvS/EBIAfVInvyqbUDuVzmiBFXmkyNJLp0Ar3ocRhlPb/yRgp
 UkVji7MY5qCBuQYQIDRpNEhPiOXw22Q1XoK6wmf9BeT4qq4npNT9uzmJAHZkf1t9IY0nMPWDSGc
 4Ck=
X-Google-Smtp-Source: AGHT+IHZSn/hkJLrEg5PYSWkpxTzY07xlPA/GbBPVS8/DFkrsgJVBOgWSZldEuXCqTAmRcOYK8+SXg==
X-Received: by 2002:a05:6402:2105:b0:5db:f52c:8074 with SMTP id
 4fb4d7f45d1cf-5dbf52c8de5mr14669434a12.28.1737633505471; 
 Thu, 23 Jan 2025 03:58:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8628asm1059904766b.138.2025.01.23.03.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 03:58:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F0985FAA0;
 Thu, 23 Jan 2025 11:58:24 +0000 (GMT)
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
In-Reply-To: <f5c8e901-5d36-47b0-91d3-40699c51c259@collabora.com> (Dmitry
 Osipenko's message of "Thu, 23 Jan 2025 14:23:48 +0300")
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <87jzamn5ri.fsf@draig.linaro.org>
 <f5c8e901-5d36-47b0-91d3-40699c51c259@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 23 Jan 2025 11:58:24 +0000
Message-ID: <874j1plp27.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

> On 1/22/25 20:00, Alex Benn=C3=A9e wrote:
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
>>> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>>>
>>> Today there are four known DRM native context drivers existing in a wil=
d:
>>>
>>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>>   - AMDGPU, mostly merged into upstreams
>>=20
>> I tried my AMD system today with:
>>=20
>> Host:
>>   Aarch64 AVA system
>>   Trixie
>>   virglrenderer @ v1.1.0/99557f5aa130930d11f04ffeb07f3a9aa5963182
>>   -display sdl,gl=3Don (gtk,gl=3Don also came up but handled window resi=
zing
>>   poorly)
>>=20=20=20
>> KVM Guest
>>=20
>>   Aarch64
>>   Trixie
>>   mesa @ main/d27748a76f7dd9236bfcf9ef172dc13b8c0e170f
>>   -Dvulkan-drivers=3Dvirtio,amd -Dgallium-drivers=3Dvirgl,radeonsi -Damd=
gpu-virtio=3Dtrue
>>=20
>> However when I ran vulkan-info --summary KVM faulted with:
>>=20
>>   debian-trixie login: error: kvm run failed Bad address
>>    PC=3D0000ffffb9aa1eb0 X00=3D0000ffffba0450a4 X01=3D0000aaaaf7f32400
>>   X02=3D000000000000013c X03=3D0000ffffba045098 X04=3D0000aaaaf7f3253c
>>   X05=3D0000ffffba0451d4 X06=3D00000000c0016900 X07=3D000000000000000e
>>   X08=3D0000000000000014 X09=3D00000000000000ff X10=3D0000aaaaf7f32500
>>   X11=3D0000aaaaf7e4d028 X12=3D0000aaaaf7edbcb0 X13=3D0000000000000001
>>   X14=3D000000000000000c X15=3D0000000000007718 X16=3D0000ffffb93601f0
>>   X17=3D0000ffffb9aa1dc0 X18=3D00000000000076f0 X19=3D0000aaaaf7f31330
>>   X20=3D0000aaaaf7f323f0 X21=3D0000aaaaf7f235e0 X22=3D000000000000004c
>>   X23=3D0000aaaaf7f2b5e0 X24=3D0000aaaaf7ee0cb0 X25=3D00000000000000ff
>>   X26=3D0000000000000076 X27=3D0000ffffcd2b18a8 X28=3D0000aaaaf7ee0cb0
>>   X29=3D0000ffffcd2b0bd0 X30=3D0000ffffb86c8b98  SP=3D0000ffffcd2b0bd0
>>   PSTATE=3D20001000 --C- EL0t
>>   QEMU 9.2.50 monitor - type 'help' for more information
>>   (qemu) quit
>>=20
>> Which looks very much like the PFN locking failure. However booting up
>> with venus=3Don instead works. Could there be any differences in the way
>> device memory is mapped in the two cases?
>
> Memory mapping works exactly the same for nctx and venus. Are you on
> 6.13 host kernel?

Yes - with the Altra PCI workaround patches on both host and guest
kernel.

Is there anyway to trace the sharing of device memory on the host so I
can verify its an attempt at device access? The PC looks like its in
user-space but once this fails the guest is suspended so I can't poke
around in its environment.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

