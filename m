Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6C6C369D1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 12:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u91WP-0005uf-Jq; Sun, 27 Apr 2025 08:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u91WO-0005uS-0P
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 08:54:12 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u91WL-0004r9-4t
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 08:54:11 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so6130103a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745758447; x=1746363247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xkg9BqbsSJVhugyf6KcJ+Zy8RTsGpqHCGzvTXSk9jjg=;
 b=U5GEqJl97xrsTaEfvTW/kJOE1IpqkNa+0Ia+UtsrG+lFMRS85lpEW79byxcqupGpuv
 ECKkr8CcGxYdoR31usBOcGsPwdPKyk35PbudwNdXWb0n5czSITjDdZZAhBGF69S/ne2o
 /bGo7DaJT0rTfpOlwoNtObwtbH6Khz28hZHwfQnlJKhZ1O9W7NKmTtliT6KgPSxf9Q5U
 p2zkd7ECvwYtS5m8vyDf00I6xRcUdYGXCjSgiVulEqg1s71iNIo0nM0fKXU0BRzO3FSx
 nJHoO4FOt/LicVP2j4YWyq7zYJiMTbKJeVJArnYqI/u/ggR68S/O15rxeS1bzdQM5FiS
 kJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745758447; x=1746363247;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xkg9BqbsSJVhugyf6KcJ+Zy8RTsGpqHCGzvTXSk9jjg=;
 b=RTnlUBT9HoIkLeSFygKENbnx5rGzOCgSgkEB4Z3xz8qR4mXn3bSTPWPFGleJu96aME
 Ycy5lpwFw+m3TjxrrmfwjvL5v9jusfp62lBzyG/MV6Tt9cJltAyeIMJ/PoycnikoCTY/
 Sx41m4+HZbq5In6vW7tRNOLib92gGSw7ATzAUJlo6iKKlMqaLSAi+wt7oUP7wDXKCKY4
 vEVKiPwYzcWvEZblNang7LTHv4JqFFTGF2Ofuel/AO3cjGRaP0dAkXHWbcr/srZmW1NK
 EHspKX93HHw98JWSOh4I/DtPAJSXUBmSGkUc8Z8QkdNTUDE1wOWO/W4A+Xx1xEwRbAHb
 n9zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFRyA7XNquAGAcYAvttJrzqMoT4mvP0Drk7mkvMN6HNfLQtl9nXx816+1ezxCoJVPA+ZJSIAtr7Q+l@nongnu.org
X-Gm-Message-State: AOJu0YzBwuw648CzCypZuC4kiZPYWIQGwRy3Hh/CWWta2a0yMmwknpCz
 tw4gnlFjgJ1+kjGpd9tL6d2+VMHObae3r8fUr7C5eoQEVBE4Ku0SOBFHFkjNl14=
X-Gm-Gg: ASbGncsjDCykwhWISqfwnzKQHNCMkVp5OJJDlXOZfzXc8p5qhhJ0Oo2HZTB0PecJND0
 yBa+ii+VtqLb1AYoU+exDd6/ar7cScBwjLatn1D5lyn1rV8mwifsZYDjQNP1tnSSexY2fCq5/Zd
 8mfdR9un4QaiVQnIZrcaj4qzvWVG/kcZOLHaZkflif68YT52suxX12OwIsttkKsGmlBsJXO/OLc
 zv85ME8+HzO+DMsLEmIm3ETihQ6ssGIHHcM7aohfi+MeItcd8o5hDcEN5UCFPpvqVY11G5vKpd9
 YT9iB0az31lAakFssjlDlIODTmQbkdrOFpEDDLffqQ6/E5anxksoXw==
X-Google-Smtp-Source: AGHT+IF6OE8bOv41ImlO0E52eCpdw+CCm0NfYfANlb3Vy5zVkDobdQdQ1CxLeuF5DTWRZSs6MauXlA==
X-Received: by 2002:a50:cb86:0:b0:5f7:eb05:7eaf with SMTP id
 4fb4d7f45d1cf-5f7eb057edcmr678540a12.9.1745758446878; 
 Sun, 27 Apr 2025 05:54:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7016f6770sm4166797a12.43.2025.04.27.05.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 05:54:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 557515F716;
 Sun, 27 Apr 2025 13:54:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?5YiY6IGq?= <liucong2565@phytium.com.cn>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,  Jiqian.Chen@amd.com,
 akihiko.odaki@daynix.com,  alexander.deucher@amd.com,
 christian.koenig@amd.com,  gert.wollny@collabora.com,
 gurchetansingh@chromium.org,  hi@alyssa.is,  honglei1.huang@amd.com,
 julia.zhang@amd.com,  kraxel@redhat.com,  marcandre.lureau@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com,  philmd@linaro.org,
 pierre-eric.pelloux-prayer@amd.com,  qemu-devel@nongnu.org,
 ray.huang@amd.com,  robdclark@gmail.com,  roger.pau@citrix.com,
 slp@redhat.com,  stefano.stabellini@amd.com,  xenia.ragiadakou@amd.com,
 zzyiwei@chromium.org
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
In-Reply-To: <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn> ("
 =?utf-8?B?5YiY6IGqIidz?= message of "Sun, 27 Apr 2025 19:53:02 +0800
 (GMT+08:00)")
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 27 Apr 2025 13:54:04 +0100
Message-ID: <87h629ix3n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

=E5=88=98=E8=81=AA <liucong2565@phytium.com.cn> writes:

> Hi Dmitry,
>
> The virglrender patch can fix the virgl issue, but the native context sti=
ll fails to run on my machine.
> I'm not sure if anyone has successfully run it on an ARM64 machine before.
>
> When running with Venus, the virtual machine can successfully run vkcube.=
 However, when using the native context, a KVM error is triggered. Both my =
guest and host kernels are already updated to version 6.14.
>
> Here are the commands and error messages I encountered:
>
> ```
> phytium@ubuntu:~/working/virglrenderer$
> /opt/native-context-v11/bin/qemu-system-aarch64 --machine
> virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=3D=
raw,if=3Dvirtio
> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
> virtio-net-pci,netdev=3Dnet0 -device
> virtio-gpu-gl,hostmem=3D4G,blob=3Don,venus=3Don -object
> memory-backend-memfd,id=3Dmem1,size=3D4G -display sdl,gl=3Don,show-cursor=
=3Don
> -device usb-ehci,id=3Dusb -device usb-mouse,bus=3Dusb.0 -device
> usb-kbd,bus=3Dusb.0
> phytium@ubuntu:~/working/virglrenderer$=20
> phytium@ubuntu:~/working/virglrenderer$
> /opt/native-context-v11/bin/qemu-system-aarch64 --machine
> virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=3D=
raw,if=3Dvirtio
> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
> virtio-net-pci,netdev=3Dnet0 -device
> virtio-gpu-gl,hostmem=3D4G,blob=3Don,drm_native_context=3Don -object
> memory-backend-memfd,id=3Dmem1,size=3D4G -display sdl,gl=3Don,show-cursor=
=3Don
> -device usb-ehci,id=3Dusb -device usb-mouse,bus=3Dusb.0 -device
> usb-kbd,bus=3Dusb.0
> error: kvm run failed Bad address

That very much looks like a page not being accessible when trying to do
something. Do we know the page address? Can we dump the current state of
the page table for that? Is the page locked?

>  PC=3D0000e2bcbbf31ab0 X00=3D0000e2bc9c3ae060 X01=3D0000e2bc7c02af00
> X02=3D0000000000000014 X03=3D0000e2bc9c3ae000 X04=3D0000e2bc7c02af14
> X05=3D0000e2bc9c3ae074 X06=3D0000000000000200 X07=3D0000e2bc7c02a8f8
> X08=3D00000000000000de X09=3D0000000000000200 X10=3D0000000000001000
> X11=3D0000000000000004 X12=3D0000e2bc7c0000b0 X13=3D0000000000000001
> X14=3D0000000000000020 X15=3D0000e2bc9e465f93 X16=3D0000e2bcad6a01f0
> X17=3D0000e2bcbbf31a80 X18=3D0000000000000093 X19=3D0000000000000060
> X20=3D0000000000000074 X21=3D0000e2bc9e46c5f0 X22=3D0000e2bc9c3ae000
> X23=3D0000000000000074 X24=3D0000c02241da83b0 X25=3D0000c02241da85a0
> X26=3D0000c02241da85a0 X27=3D0000000000000014 X28=3D0000e2bc9e46c5f0
> X29=3D0000e2bc9e46c610 X30=3D0000e2bcac809c38  SP=3D0000e2bc9e46c510
> PSTATE=3D20001000 --C- EL0t
> phytium@ubuntu:~/working/virglrenderer$ uname -a
> Linux ubuntu 6.14.1-061401-generic #202504071048 SMP PREEMPT_DYNAMIC Mon =
Apr  7 11:34:37 UTC 2025 aarch64 aarch64 aarch64 GNU/Linux
> ```
>
> Best regards,
> Cong
>
>> -----Original Messages-----
>> From: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
>> Send time:Sunday, 04/27/2025 06:27:39
>> To: =E5=88=98=E8=81=AA <liucong2565@phytium.com.cn>
>> Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com,
>> alex.bennee@linaro.org, alexander.deucher@amd.com,
>> christian.koenig@amd.com, gert.wollny@collabora.com,
>> gurchetansingh@chromium.org, hi@alyssa.is, honglei1.huang@amd.com,
>> julia.zhang@amd.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
>> mst@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
>> pierre-eric.pelloux-prayer@amd.com, qemu-devel@nongnu.org,
>> ray.huang@amd.com, robdclark@gmail.com, roger.pau@citrix.com,
>> slp@redhat.com, stefano.stabellini@amd.com,
>> xenia.ragiadakou@amd.com, zzyiwei@chromium.org
>> Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
>>=20
>> On 4/14/25 17:47, Dmitry Osipenko wrote:
>> > On 4/11/25 04:42, =E5=88=98=E8=81=AA wrote:
>> >>
>> >>
>> >>
>> >>> -----Original Messages-----
>> >>> From: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
>> >>> Send time:Friday, 04/11/2025 05:59:11
>> >>> To: "Cong Liu" <liucong2565@phytium.com.cn>
>> >>> Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com,
>> >>> alex.bennee@linaro.org, alexander.deucher@amd.com,
>> >>> christian.koenig@amd.com, gert.wollny@collabora.com,
>> >>> gurchetansingh@chromium.org, hi@alyssa.is,
>> >>> honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com,
>> >>> marcandre.lureau@redhat.com, mst@redhat.com,
>> >>> pbonzini@redhat.com, philmd@linaro.org,
>> >>> pierre-eric.pelloux-prayer@amd.com, qemu-devel@nongnu.org,
>> >>> ray.huang@amd.com, robdclark@gmail.com, roger.pau@citrix.com,
>> >>> slp@redhat.com, stefano.stabellini@amd.com,
>> >>> xenia.ragiadakou@amd.com, zzyiwei@chromium.org
>> >>> Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fenc=
ing
>> >>>
>> >>> 10.04.2025 12:54, Cong Liu =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> >>>> I discovered that on an ARM64 environment, the 'virtio-gpu:
>> >>>> Support asynchronous fencing' patch causes the virtual machine
>> >>>> GUI to fail to display. Rolling back this patch and using virgl
>> >>>> allows the virtual machine to start normally. When the VM
>> >>>> screen is black, I can see some errors in QEMU. I used QEMU's
>> >>>> -serial stdio to enter the virtual machine's command line
>> >>>> console but didn't see any errors inside the VM - the graphical
>> >>>> interface seems to be stuck. I would greatly appreciate any
>> >>>> suggestions regarding effective troubleshooting methods or
>> >>>> specific areas I should investigate to resolve this issue.
>> >>>>
>> >>>> Here's my software and hardware environment:
>> >>>> - host and guest are ubuntu 24.04
>> >>>> - QEMU: https://gitlab.freedesktop.org/digetx/qemu.git native-conte=
xt-v11 branch
>> >>>> - virglrender: latest main branch 08eb12d00711370002e8f8fa6d620df9b=
79f9e27
>> >>>> - Mesa: Mesa 25.0~git2504031308.ff386e~oibaf~n (git-ff386eb 2025-04=
-03 noble-oibaf-ppa)
>> >>>> - Kernel: Linux d3000 6.14.1-061401-generic #202504071048
>> >>>> - GPU: Radeon RX 6600/6600 XT/6600M
>> >>>> - CPU: phytium D3000 aarch64
>> >>>>
>> >>>> Here's the command I'm using to run the virtual machine, which disp=
lays a black frame with "Display output is not active" and fails to start t=
he graphical interface normally:
>> >>>>
>> >>>>     phytium@d3000:~/working/qemu$
>> >>>> /usr/local/bin/qemu-system-aarch64 --machine virt,accel=3Dkvm
>> >>>> -cpu host -smp 4 -m 4G -drive
>> >>>> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,for=
mat=3Draw,if=3Dvirtio
>> >>>> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0
>> >>>> -device virtio-net-pci,netdev=3Dnet0 -device virtio-gpu-gl
>> >>>> -display gtk,gl=3Don,show-cursor=3Don -device usb-ehci,id=3Dusb
>> >>>> -device usb-mouse,bus=3Dusb.0 -device usb-kbd,bus=3Dusb.0
>> >>>>
>> >>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent fail=
ed
>> >>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent fail=
ed
>> >>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent fail=
ed
>> >>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent fail=
ed
>> >>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.716: eglMakeCurrent fail=
ed
>> >>>>
>> >>>> When using SDL, the error messages are slightly different:
>> >>>>
>> >>>>     phytium@d3000:~/working/qemu$
>> >>>> /usr/local/bin/qemu-system-aarch64 --machine virt,accel=3Dkvm
>> >>>> -cpu host -smp 4 -m 4G -drive
>> >>>> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,for=
mat=3Draw,if=3Dvirtio
>> >>>> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0
>> >>>> -device virtio-net-pci,netdev=3Dnet0 -device virtio-gpu-gl
>> >>>> -display sdl,gl=3Don,show-cursor=3Don -device usb-ehci,id=3Dusb
>> >>>> -device usb-mouse,bus=3Dusb.0 -device usb-kbd,bus=3Dusb.0
>> >>>>
>> >>>>     vrend_renderer_fill_caps: Entering with stale GL error: 1286
>> >>>>
>> >>>
>> >>> Hi,
>> >>>
>> >>> 1. Please make sure that you're not only building QEMU against your
>> >>> virglrenderer version, but also setting LD_LIBRARY_PATH properly at
>> >>> runtime. Best to remove system version of virglrenderer if unsure,
>> >>
>> >> I built and installed virglrenderer with the --prefix=3D/usr option, =
so
>> >>  it replaces the system version as expected.
>> >>
>> >>>
>> >>> 2. Can you reproduce this problem using tcg instead of kvm?
>> >>>
>> >>
>> >>  yes, change qemu command '--machine virt,accel=3Dkvm -cpu host' to
>> >> '--machine virt -cpu max' can reproduce this problem.=20
>> >>> --=20
>> >>> Best regards,
>> >>> Dmitry
>> >>
>> >> diff --git a/src/vrend_renderer.c b/src/vrend_renderer.c
>> >> index f6df9dcb..f6e06842 100644
>> >> --- a/src/vrend_renderer.c
>> >> +++ b/src/vrend_renderer.c
>> >> @@ -12808,7 +12808,7 @@ void vrend_renderer_fill_caps(uint32_t set, u=
int32_t version,
>> >>                                union virgl_caps *caps)
>> >>  {
>> >>     int gl_ver, gles_ver;
>> >> -   GLenum err;
>> >> +   GLenum err =3D GL_NO_ERROR;
>> >>     bool fill_capset2 =3D false;
>> >>=20=20
>> >>     if (!caps)
>> >>
>> >> phytium@d3000:~/working/qemu$ git log --oneline  -n 10
>> >> e0286f56c8 (HEAD -> native-context-v11, origin/native-context-v11) Re=
vert "amd_iommu: Add support for pass though mode"
>> >> d6e9eb0f0d docs/system: virtio-gpu: Document host/guest requirements
>> >> 55db821ea5 docs/system: virtio-gpu: Update Venus link
>> >> 003940db9a docs/system: virtio-gpu: Add link to Mesa VirGL doc
>> >> 7674e82755 ui/gtk: Don't disable scanout when display is refreshed
>> >> 712fd024e3 ui/sdl2: Don't disable scanout when display is refreshed
>> >> 9003da356f virtio-gpu: Support DRM native context
>> >> e2ff4f4a48 virtio-gpu: Support asynchronous fencing
>> >> 25458c7625 virtio-gpu: Handle virgl fence creation errors
>> >>
>> >> I tried initializing GLenum err =3D GL_NO_ERROR in vrend_renderer_fil=
l_caps, but it doesn=E2=80=99t seem to resolve the =E2=80=9CEntering with s=
tale GL error: 1286=E2=80=9D message. However, this error might not be dire=
ctly related to the VM black screen issue. I noticed that even when the VM =
was working correctly=E2=80=94specifically when I reset to commit 25458c762=
5=E2=80=94the same GL error still appeared.
>> >=20
>> > Thanks for the report. I confirm that something is wrong with virgl wh=
en
>> > async fencing is used. Don't have this GL 1286 error, but getting a
>> > lockup on ARM VM and with one of my new x64 VM setups. Will investigate
>> > further and report back here.
>>=20
>> Hi, Cong. Please give a test to [1]. It fixes the problem for me.
>>=20
>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/=
1518
>>=20
>> --=20
>> Best regards,
>> Dmitry
>
>
> =E4=BF=A1=E6=81=AF=E5=AE=89=E5=85=A8=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=BD=92=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E6=89=80=E6=9C=89,=E5=
=8F=91=E4=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E5=AF=B9=E8=AF=
=A5=E9=82=AE
> =E4=BB=B6=E6=8B=A5=E6=9C=89=E6=89=80=E6=9C=89=E6=9D=83=E5=88=A9=E3=80=82=
=E8=AF=B7=E6=8E=A5=E6=94=B6=E8=80=85=E6=B3=A8=E6=84=8F=E4=BF=9D=E5=AF=86,=
=E6=9C=AA=E7=BB=8F=E5=8F=91=E4=BB=B6=E4=BA=BA=E4=B9=A6=E9=9D=A2=E8=AE=B8=E5=
=8F=AF,=E4=B8=8D=E5=BE=97=E5=90=91=E4=BB=BB=E4=BD=95=E7=AC=AC=E4=B8=89=E6=
=96=B9=E7=BB=84
> =E7=BB=87=E5=92=8C=E4=B8=AA=E4=BA=BA=E9=80=8F=E9=9C=B2=E6=9C=AC=E9=82=AE=
=E4=BB=B6=E6=89=80=E5=90=AB=E4=BF=A1=E6=81=AF=E3=80=82Information Security =
Notice: The
> information contained in this mail is solely property of the sender's
> organization.This mail communication is confidential.Recipients named
> above are obligated to maintain secrecy and are not permitted to
> disclose the contents of this communication to others.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

