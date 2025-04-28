Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1B1C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9LOW-0001w7-Cy; Mon, 28 Apr 2025 06:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9LOR-0001vw-7X
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:07:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9LOO-0000e1-9S
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:07:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so8503528a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745834833; x=1746439633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfy3YvyTiko4df9AwnisD8cH/l8e+t8MO+Ftd9FpUqY=;
 b=LyCISH5bMvs+d1Jw6i6uZyejjIAoigvpjTq/mnH+e3dyetQ1uX+zp+HgO6nCKozjPp
 ELba768JyS3W8EW7o0UUQy2EPLsNpwWujXQEd9doXJyv6hDXydQpT0hFaft6T8Sf9C5a
 WJ+0XGlfVknbc8Ax1YR2ApuHmW6ylrRDrrs6E3ViTfphdQxx3PRtvIUJBs63n0E0r6yq
 rBv4aBCBQ8PRBXoXI7KTQaAjsP2PsafEIz/Nrl1nC82y5bv3vVkxeT9fydGz+nmxTtPr
 NRGazzqzXZVPTPs/rBwa1goZZK/wWVNyBJqoYYw21AjKiJDRJIxGonJRY9CYyV9T/SFk
 7vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745834833; x=1746439633;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sfy3YvyTiko4df9AwnisD8cH/l8e+t8MO+Ftd9FpUqY=;
 b=UwvB7T5aQ5vhoMk+DynEgOIK09Mj8upapsgv7ClL7R0mFMoi+KuKiCS5axp6OXFTtZ
 zWbo/lodlnMQWGWQ6Q4yUBDuHiyzMqZ/RpqhmDGeI1SZSy3aX7JEszig8h4etwOMqiUm
 E0T8TX/+4R2wLTx7Dmvji4F0rZgIoWHiRxgsMg73TYOfRtxg9DjSl0QypDojucXiwxA+
 dfctPyz/xrMymJMhMv+XvS+dVZ2Q0gyJ5SU1XP+DUImtWTBE0CnddWm1Ob8b+5IeM/1I
 MNj6Xwo7DsYEpeJtEgbJAAHjvOvqrXk7runbx0y6GT2dQaqaOWHrCLv3DeiPNo053sqY
 zpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl2IrSqbC1dRsxPyxRWQThmLRS+Sz4R21ALmWP4UuCAtRwKNJrINqgWacnwqfBvvTDty+6Ju6IYt3A@nongnu.org
X-Gm-Message-State: AOJu0YzBzGQWqpmsgwswJb53EnJnF3slK02z9b+BQ3mkZYhjYdxF4q93
 e45U/tJqJUr6WwTz/g+yjJsPuGkpwQDdCXTPgJWlo+Se1jyyjNtxBddUxzrqeck=
X-Gm-Gg: ASbGncs08e0LXD8W0df6bCf0Go7DNUIaTP2ifwH1AiTqTE1cFKRgncX0d13JTe6ZYvG
 0GIorbksA1FwYyLjy+BxeGWVV7pL+N8/Rc3awswC0g/D29r6yOZnuRdKPB9wAqoPfh0ns6k3f9X
 ATXnhq7sa5biWfafYJqVp5htuR3zAt5ZJDETn86K/EBX6T529sY8vqGAiyxo7VTwUekDELvNNJy
 lUlQRIHM1Lpo0wbXqXWZncwtourMQpezq45SjMIN49TwMRNWicKrg2HVBGgX7NFlcMuGnWMDyQP
 YbTUvh8b374vHz6X73TVzniVbqmY1XUzAzdyOmRDBS8=
X-Google-Smtp-Source: AGHT+IETgHngsb4qTDJMps7CeFvKAb9NaUyX2KcrYNBY3mOx7zIUza0kkDIc6fXCEjwI00/tE7nfiA==
X-Received: by 2002:a05:6402:51d2:b0:5f6:31f3:d744 with SMTP id
 4fb4d7f45d1cf-5f72268597dmr10175266a12.11.1745834832927; 
 Mon, 28 Apr 2025 03:07:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f703833c8csm5550618a12.72.2025.04.28.03.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 03:07:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FC735F877;
 Mon, 28 Apr 2025 11:07:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: =?utf-8?B?5YiY6IGq?= <liucong2565@phytium.com.cn>,  Sean Christopherson
 <seanjc@google.com>,  Jiqian.Chen@amd.com,  akihiko.odaki@daynix.com,
 alexander.deucher@amd.com,  christian.koenig@amd.com,
 gert.wollny@collabora.com,  gurchetansingh@chromium.org,  hi@alyssa.is,
 honglei1.huang@amd.com,  julia.zhang@amd.com,  kraxel@redhat.com,
 marcandre.lureau@redhat.com,  mst@redhat.com,  pbonzini@redhat.com,
 philmd@linaro.org,  pierre-eric.pelloux-prayer@amd.com,
 qemu-devel@nongnu.org,  ray.huang@amd.com,  robdclark@gmail.com,
 roger.pau@citrix.com,  slp@redhat.com,  stefano.stabellini@amd.com,
 xenia.ragiadakou@amd.com,  zzyiwei@chromium.org
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
In-Reply-To: <03414f52-def8-4b50-8da4-69b722dfc758@collabora.com> (Dmitry
 Osipenko's message of "Sun, 27 Apr 2025 17:16:52 +0300")
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
 <03414f52-def8-4b50-8da4-69b722dfc758@collabora.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 28 Apr 2025 11:07:11 +0100
Message-ID: <87cycw61m8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

> On 4/27/25 14:53, =E5=88=98=E8=81=AA wrote:
>> Hi Dmitry,
>>=20
>> The virglrender patch can fix the virgl issue, but the native context st=
ill fails to run on my machine.
>> I'm not sure if anyone has successfully run it on an ARM64 machine befor=
e.
>
> Thanks for the testing!
>
>> When running with Venus, the virtual machine can successfully run vkcube=
. However, when using the native context, a KVM error is triggered. Both my=
 guest and host kernels are already updated to version 6.14.
>>=20
>> Here are the commands and error messages I encountered:
>>=20
>> ```
>> phytium@ubuntu:~/working/virglrenderer$
>> /opt/native-context-v11/bin/qemu-system-aarch64 --machine
>> virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
>> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=
=3Draw,if=3Dvirtio
>> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
>> virtio-net-pci,netdev=3Dnet0 -device
>> virtio-gpu-gl,hostmem=3D4G,blob=3Don,venus=3Don -object
>> memory-backend-memfd,id=3Dmem1,size=3D4G -display
>> sdl,gl=3Don,show-cursor=3Don -device usb-ehci,id=3Dusb -device
>> usb-mouse,bus=3Dusb.0 -device usb-kbd,bus=3Dusb.0
>> phytium@ubuntu:~/working/virglrenderer$=20
>> phytium@ubuntu:~/working/virglrenderer$
>> /opt/native-context-v11/bin/qemu-system-aarch64 --machine
>> virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
>> file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=
=3Draw,if=3Dvirtio
>> -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
>> virtio-net-pci,netdev=3Dnet0 -device
>> virtio-gpu-gl,hostmem=3D4G,blob=3Don,drm_native_context=3Don -object
>> memory-backend-memfd,id=3Dmem1,size=3D4G -display
>> sdl,gl=3Don,show-cursor=3Don -device usb-ehci,id=3Dusb -device
>> usb-mouse,bus=3Dusb.0 -device usb-kbd,bus=3Dusb.0
>> error: kvm run failed Bad address
>>  PC=3D0000e2bcbbf31ab0 X00=3D0000e2bc9c3ae060 X01=3D0000e2bc7c02af00
>> X02=3D0000000000000014 X03=3D0000e2bc9c3ae000 X04=3D0000e2bc7c02af14
>> X05=3D0000e2bc9c3ae074 X06=3D0000000000000200 X07=3D0000e2bc7c02a8f8
>> X08=3D00000000000000de X09=3D0000000000000200 X10=3D0000000000001000
>> X11=3D0000000000000004 X12=3D0000e2bc7c0000b0 X13=3D0000000000000001
>> X14=3D0000000000000020 X15=3D0000e2bc9e465f93 X16=3D0000e2bcad6a01f0
>> X17=3D0000e2bcbbf31a80 X18=3D0000000000000093 X19=3D0000000000000060
>> X20=3D0000000000000074 X21=3D0000e2bc9e46c5f0 X22=3D0000e2bc9c3ae000
>> X23=3D0000000000000074 X24=3D0000c02241da83b0 X25=3D0000c02241da85a0
>> X26=3D0000c02241da85a0 X27=3D0000000000000014 X28=3D0000e2bc9e46c5f0
>> X29=3D0000e2bc9e46c610 X30=3D0000e2bcac809c38  SP=3D0000e2bc9e46c510
>> PSTATE=3D20001000 --C- EL0t
>> phytium@ubuntu:~/working/virglrenderer$ uname -a
>> Linux ubuntu 6.14.1-061401-generic #202504071048 SMP PREEMPT_DYNAMIC Mon=
 Apr  7 11:34:37 UTC 2025 aarch64 aarch64 aarch64 GNU/Linux
>> ```
>
> Alex Benn=C3=A9e reported the very same problem with KVM on ARM + native =
ctx
> AMD dGPU in the past. You may try to add error messages to
> virt/kvm/kvm_main.c of host Linux kernel to find from where KVM error
> originates. Sounds like page refcounting may be not working properly
> on ARM.

Also what hardware is the machine? The AVA (and most things with the
same chipset) have a broken PCI which needs a workaround for unaligned
SIMD access:

  https://github.com/stsquad/linux/tree/testing/altra-tweaks-for-gpu

>
> +CC: Sean Christopherson

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

