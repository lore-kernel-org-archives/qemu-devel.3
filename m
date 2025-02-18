Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB4EC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKUh-0004c0-QN; Tue, 18 Feb 2025 05:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tkKUf-0004ad-M4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:06:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tkKUd-0005h6-A8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:06:21 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ded69e6134so7915228a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739873177; x=1740477977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVHmn2di7wEz8AAfK2RCNiymNJ8Gb2ufA4Im3UFonq0=;
 b=YjjwRtn+hAEVtaPCBemiEBbJrpTrpGQTgSxRCJSbmtnha+3geMUJyNmVC2AIB0csn+
 DSgVjqVVqlyWy+PBAMTyuZNQMo6r9iFvONIBgf9hUNMV2wqpzqKP+M/qg0yFOuAS2dhs
 JWUXO508G554iHQUL/+sVjLdjxaNRcwlPGiJbH9Lbfv7nXHp9Z/Caqt0DIcDj/+A81uP
 0VYSoTysPhKZePELYRAxiJ0ezqYkRe8G3oRjPZKAaEAO06dgMOUAY71leZ2UFB2Py6D8
 dZuzmDaihx45d02paQpNx/OrGmCNRT3lLKh8VCo62q9VWGEtKu5uLDeXDfFeORz1iol/
 cVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739873177; x=1740477977;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVHmn2di7wEz8AAfK2RCNiymNJ8Gb2ufA4Im3UFonq0=;
 b=SSiHCU51C85B6Y8Frgksaf2sSlcv7Qei3Pf3Q9OOk2k5eRQpqsK0VUep5BgIlik9ia
 IPvCwLWFQV1HQvvzZb0HmxifYwvpcAmQ5QmbpWw2rYRhxDlegsJU/jbNA7mpgv+TNBdz
 BE4noL1t3AVXSFwRtDsfCn1SSCRgc/AYbfKeHJ9qbDsE9kIYZzVfchXg2eXGVFUFl0e3
 2809+xnkF0gs129jkJhiYjJC9i0ZkpRV/ZsfFIEqe2eCQlQDYb+4VZ2ZogaaK+n0Uytu
 5do3+14ZKHJCKNeMUaf5zkU5rKEWBfu9k+hzqfNCkNe48XU0t7RM8v29i8aEVw+e5Dca
 H+4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZJQPOjynfYDJY3oNSplHIS7APxVOmr2GRIos0NdnshoFiVIAHpcinGyOL3va8lq30UBEFfCzuZsuR@nongnu.org
X-Gm-Message-State: AOJu0YyBsVirRvQ9VSgOizL0cG3ilHLOWTbBpPb7JqQx58JoIwE4VM2l
 GFycOHMp9T1S4LjSOg44fzq51zg94qnDkiSvullqRGh9eRam5F70YyQqUhQNTCI4pITyRjXhaZ1
 r3gw=
X-Gm-Gg: ASbGncs8lExwrqaEg+kNw3nvPl2SaujJiiCmi1ZtOpC0kk/MiuaOMBRPRyMeXaq1wET
 vCwUCkwNzJ1j8qO3FGavYfHFokhOXyRL1YGg4/ayeVu4s8bv23+Hg23Fb0dISYz/LN1qPwwYlBU
 bP9XoD91Iv1Ho1C7XqgIBBbOW1Uzv+PrXOzjbG1RUyAScULZopt3KF0wxN+USGYDwc3GHNKqYv3
 uOuPplirCmO4nM5hUkHIz16mBf5ihtD/HXsOieocFJcCjHdhwbDCmp2I254T8szW+DzSbTBQGDO
 hDCkt6YEQXrKBMWtoQ==
X-Google-Smtp-Source: AGHT+IF7efTaNttSE20ZvER2UL1TfOQ56UDB9IEMAqVg1BVs/5389TpdaMsO0DJwVwGi3EcsLpbo0A==
X-Received: by 2002:a05:6402:210a:b0:5dc:74f1:8a31 with SMTP id
 4fb4d7f45d1cf-5e0361c273fmr13074780a12.26.1739873176807; 
 Tue, 18 Feb 2025 02:06:16 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e3bsm8388608a12.11.2025.02.18.02.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 02:06:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 942225F843;
 Tue, 18 Feb 2025 10:06:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  "open
 list:Virt" <qemu-arm@nongnu.org>
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
In-Reply-To: <6d1cad85-4824-4912-b209-60a8070c59af@redhat.com> (Thomas Huth's
 message of "Tue, 18 Feb 2025 07:34:53 +0100")
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
 <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
 <6d1cad85-4824-4912-b209-60a8070c59af@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 18 Feb 2025 10:06:14 +0000
Message-ID: <87tt8rk1nt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 17/02/2025 17.30, Peter Maydell wrote:
>> On Fri, 10 Jan 2025 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>> Now that we have virtio-gpu Vulkan support, let's add a test for it.
>>> Currently this is using images build by buildroot:
>>>
>>>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196=
.html
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
>> Hi; this test currently fails for me with a clang sanitizer
>> build (ubuntu 24.04 host). It seems to run weston in the guest,
>> which fails with:
>> 2025-02-17 16:11:10,218: [16:11:10.672] Command line: weston -B
>> headless --renderer gl --shell kiosk -- vkmark -b:duration=3D1.0
>> 2025-02-17 16:11:10,224: [16:11:10.675] OS: Linux, 6.11.10, #2 SMP Thu
>> Dec  5 16:27:12 GMT 2024, aarch64
>> 2025-02-17 16:11:10,225: [16:11:10.680] Flight recorder: enabled
>> 2025-02-17 16:11:10,226: [16:11:10.681] warning: XDG_RUNTIME_DIR
>> "/tmp" is not configured
>> 2025-02-17 16:11:10,226: correctly.  Unix access mode must be 0700
>> (current mode is 0777),
>> 2025-02-17 16:11:10,226: and must be owned by the user UID 0 (current
>> owner is UID 0).
>> 2025-02-17 16:11:10,227: Refer to your distribution on how to get it, or
>> 2025-02-17 16:11:10,227:
>> http://www.freedesktop.org/wiki/Specifications/basedir-spec
>> 2025-02-17 16:11:10,228: on how to implement it.
>> 2025-02-17 16:11:10,240: [16:11:10.695] Starting with no config file.
>> 2025-02-17 16:11:10,253: [16:11:10.707] Output repaint window is 7 ms ma=
ximum.
>> 2025-02-17 16:11:10,262: [16:11:10.716] Loading module
>> '/usr/lib/libweston-14/headless-backend.so'
>> 2025-02-17 16:11:10,313: [16:11:10.768] Loading module
>> '/usr/lib/libweston-14/gl-renderer.so'
>> 2025-02-17 16:11:21,858: libEGL warning: egl: failed to create dri2 scre=
en
>> 2025-02-17 16:11:21,959: libEGL warning: egl: failed to create dri2 scre=
en
>> 2025-02-17 16:11:22,023: libEGL warning: egl: failed to create dri2 scre=
en
>> 2025-02-17 16:11:22,032: [16:11:22.486] failed to initialize display
>> 2025-02-17 16:11:22,033: [16:11:22.488] EGL error state:
>> EGL_NOT_INITIALIZED (0x3001)
>> 2025-02-17 16:11:22,036: [16:11:22.490] fatal: failed to create
>> compositor backend
>> Then eventually the test framework times it ou and sends it
>> a SIGTERM, and QEMU SEGVs inside libEGL trying to run an
>> exit handler:
>> qemu-system-aarch64: terminating on signal 15 from pid 242824
>> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/p=
ython3)
>> UndefinedBehaviorSanitizer:DEADLYSIGNAL
>> =3D=3D243045=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown add=
ress
>> 0x73fbfefe6a31 (pc 0x73fbba9788e9 bp 0x73fbbbe0af80 sp 0x7ffd676fbfe0
>> T243045)
>> =3D=3D243045=3D=3DThe signal is caused by a READ memory access.
>>      #0 0x73fbba9788e9
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #1 0x73fbbaafc178
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16fc178)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #2 0x73fbba62564f
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x122564f)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #3 0x73fbbab067d7
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x17067d7)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #4 0x73fbba63b786
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x123b786)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #5 0x73fbba96290a
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x156290a)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #6 0x73fbba941c5c
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x1541c5c)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>      #7 0x73fbc2041f20
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f20) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #8 0x73fbc2041f68
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f68) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #9 0x73fbc2034ca9
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x34ca9) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #10 0x73fbc203ae90
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3ae90) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #11 0x73fbc203aeda
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3aeda) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #12 0x73fbc20a45f5
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa45f5) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #13 0x73fbc20a2bfc
>> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa2bfc) (BuildId:
>> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>>      #14 0x73fbd3047a75 in __run_exit_handlers stdlib/exit.c:108:8
>>      #15 0x73fbd3047bbd in exit stdlib/exit.c:138:3
>>      #16 0x5a5bab5e3fdb in qemu_default_main
>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/=
main.c:52:5
>>      #17 0x5a5bab5e3f9e in main
>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/=
main.c:76:9
>>      #18 0x73fbd302a1c9 in __libc_start_call_main
>> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>>      #19 0x73fbd302a28a in __libc_start_main csu/../csu/libc-start.c:360=
:3
>>      #20 0x5a5ba9c5b554 in _start
>> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-=
aarch64+0x15dc554)
>> (BuildId: 8efda3601b42aa2644dde35d1d63f7b22b649a33)
>> UndefinedBehaviorSanitizer can not provide additional info.
>> SUMMARY: UndefinedBehaviorSanitizer: SEGV
>> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
>> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>> =3D=3D243045=3D=3DABORTING
>
> FWIW, I just saw this test also failing in a normal clang build
> (without sanitizers enabled). In the console log:
>
> 2025-02-18 07:08:47,497: [06:08:47.588] Loading module
> '/usr/lib/weston/kiosk-shell.so'
> 2025-02-18 07:08:47,914: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2025-02-18 07:08:47,915: vkmark 2017.08
> 2025-02-18 07:08:47,915: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2025-02-18 07:08:47,915: Vendor ID:      0x8086
> 2025-02-18 07:08:47,915: Device ID:      0x9A60
> 2025-02-18 07:08:47,916: Device Name:    Virtio-GPU Venus (Intel(R)
> UHD Graphics (TGL GT1))
> 2025-02-18 07:08:47,916: Driver Version: 100675584
> 2025-02-18 07:08:47,916: Device UUID:    c5930b2b12677aad53343f8a072209af
> 2025-02-18 07:08:47,916: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2025-02-18 07:08:52,277: [vertex] device-local=3Dtrue:MESA-VIRTIO:
> debug: stuck in fence wait with iter at 1024
> 2025-02-18 07:09:03,142: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 2048
> 2025-02-18 07:09:24,640: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 3072
> 2025-02-18 07:09:46,192: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 4096
> 2025-02-18 07:10:28,665: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 5120
> 2025-02-18 07:11:11,067: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 6144
> 2025-02-18 07:11:53,619: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 7168
> 2025-02-18 07:12:36,397: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 8192
> 2025-02-18 07:14:01,431: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 9216
> 2025-02-18 07:15:26,387: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 10240
> 2025-02-18 07:16:51,349: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 11264
> 2025-02-18 07:18:16,409: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 12288
> 2025-02-18 07:19:41,439: MESA-VIRTIO: debug: stuck in fence wait with
> iter at 13312
>
> Should we maybe mark it as flaky for the time being?

I think the tests are too sensitive to host conditions
(mesa/virglrenderer builds/flags and underlying graphics hardware). I'd
rather detect the known flakiness and report it as a skip so they still
run on known good setups.

Hopefully this will work itself out as distros update and we can narrow
down requirements in configure.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

