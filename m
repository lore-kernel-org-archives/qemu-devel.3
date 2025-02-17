Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F308C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4U0-0007db-Kv; Mon, 17 Feb 2025 12:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk4To-0007bI-Lm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:00:25 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk4Tl-0002cj-6J
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:00:24 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso3608249f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739811618; x=1740416418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NsWCNeTZWcXyOIm6SjjakzACAHJRWd5DfnCVis1xGU=;
 b=DN9C4vrOEFm2G8E7bthGSo1facX5eHhd1/EDr8MyW4Q8F8fnCfuiBiS7tmWdUzZ7UX
 8+81Y8nCsEByvzBM4ZQ2en75l683ryeM6iV0MN1gigS/oYv+Y8C1xHc2zZv+IPKE3C0k
 5b4CHsXmp0bHZkRwEGPmPg1Sz7C44X/yvy4NFcCC/oDmhMan/aSZEGazpv3PnVqqbw/P
 EbvUNrJnLdKU4UTYTGS1sYYZ3t6ZpJJaiP4BqjUDRpByjgZNKcyCuYRi/8atw7YO7GxK
 MUj9Y6cfp/cNdgtmSgI4rko4vHdwPWKefPW/GUmZyU/EJn2OtBKrwj4oVOM+cBctNf+M
 OzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739811618; x=1740416418;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+NsWCNeTZWcXyOIm6SjjakzACAHJRWd5DfnCVis1xGU=;
 b=JUdgcRHreIpqPMlLns6r75+bJgOZ9pPv3iStKldLIyabXwN9YEEFIHRCPu+kEBzCUF
 QBbGF/Jq2hvNnjIqkKluNfAKeYt+9vR5/Ik7+TEpf2Pb7xMbm5i/FK1Go+q0V0UoRJ1R
 82c58CPRQx0494fK5g1wXjE+TDe2y/hjFmyxi3tTxJQryEkB/fdusXSh/dTv0tOi0YiL
 yP+NvjtGlWIIlTsGUDQwEW0LcneacvjJ4Ep0ukM2JBhESikb7pfTOWsi0TwG5rNjKo7T
 gX5U6d4a1xPdrzRtgkhnVXoquELgAKGpjpGeFUe53zFmrqOIG52GJUq3zoJianU2cbe8
 uKPw==
X-Gm-Message-State: AOJu0Yzhi9KrC1z49WPBp+fSfSOhB61gHaMbsprEg2+YFrKEcU11EmAI
 pd9AU5+BfSlgJEBIED/YVuUXdxBi1kFnGZeES1xsnDISyQs177VB5S9P1XQ/3wE=
X-Gm-Gg: ASbGncudbWbTCnoYlO5nf8ZWu2f1/kHHVlZj3jsegxid5/eMyk1ieiVrZqGEA58qYiR
 xdfdRUD83bkfukmULE0CUTC771pavcFgq2yPDdrVyVhpx4XiCB/pWlp9USFuMOvoXUzrbYDyhg4
 XXeTzAVVGj/jPapzj4vg7gFDWnzJaoJfyHULXk7PRJk6Gi98k9Yw3FvUo73oZEhM6EZEovqyWwx
 9q1e5qYJTeKdQqOjXnNjpjHPbjsFZceSbIMsaBT4Rg03tkhslPOAs1+bn+NuI/B4ZPizGFmjFUC
 jZ64rEdvxKoLoPNCFA==
X-Google-Smtp-Source: AGHT+IEnxzGIh2QC4cyZ2Ay0HacopsFmFUiqpg5aUW5sm9Qz7GlFsMoq7uGXZR+7bxBy+pVsNL4qtQ==
X-Received: by 2002:adf:f647:0:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-38f33f510eamr8935289f8f.42.1739811618511; 
 Mon, 17 Feb 2025 09:00:18 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba533bfaabsm908545266b.181.2025.02.17.09.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:00:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8EF05F936;
 Mon, 17 Feb 2025 17:00:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  "open
 list:Virt" <qemu-arm@nongnu.org>
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
In-Reply-To: <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 17 Feb 2025 16:30:22 +0000")
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
 <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 17 Feb 2025 17:00:16 +0000
Message-ID: <875xl8ld5r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 10 Jan 2025 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> Now that we have virtio-gpu Vulkan support, let's add a test for it.
>> Currently this is using images build by buildroot:
>>
>>   https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.h=
tml
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
>
> Hi; this test currently fails for me with a clang sanitizer
> build (ubuntu 24.04 host). It seems to run weston in the guest,
> which fails with:
>
> 2025-02-17 16:11:10,218: [16:11:10.672] Command line: weston -B
> headless --renderer gl --shell kiosk -- vkmark -b:duration=3D1.0
> 2025-02-17 16:11:10,224: [16:11:10.675] OS: Linux, 6.11.10, #2 SMP Thu
> Dec  5 16:27:12 GMT 2024, aarch64
> 2025-02-17 16:11:10,225: [16:11:10.680] Flight recorder: enabled
> 2025-02-17 16:11:10,226: [16:11:10.681] warning: XDG_RUNTIME_DIR
> "/tmp" is not configured
> 2025-02-17 16:11:10,226: correctly.  Unix access mode must be 0700
> (current mode is 0777),
> 2025-02-17 16:11:10,226: and must be owned by the user UID 0 (current
> owner is UID 0).
> 2025-02-17 16:11:10,227: Refer to your distribution on how to get it, or
> 2025-02-17 16:11:10,227:
> http://www.freedesktop.org/wiki/Specifications/basedir-spec
> 2025-02-17 16:11:10,228: on how to implement it.
> 2025-02-17 16:11:10,240: [16:11:10.695] Starting with no config file.
> 2025-02-17 16:11:10,253: [16:11:10.707] Output repaint window is 7 ms max=
imum.
> 2025-02-17 16:11:10,262: [16:11:10.716] Loading module
> '/usr/lib/libweston-14/headless-backend.so'
> 2025-02-17 16:11:10,313: [16:11:10.768] Loading module
> '/usr/lib/libweston-14/gl-renderer.so'
> 2025-02-17 16:11:21,858: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:21,959: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:22,023: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:22,032: [16:11:22.486] failed to initialize display
> 2025-02-17 16:11:22,033: [16:11:22.488] EGL error state:
> EGL_NOT_INITIALIZED (0x3001)
> 2025-02-17 16:11:22,036: [16:11:22.490] fatal: failed to create
> compositor backend

I guess we can catch that in the test case and fail the test.

>
> Then eventually the test framework times it ou and sends it
> a SIGTERM, and QEMU SEGVs inside libEGL trying to run an
> exit handler:
>
> qemu-system-aarch64: terminating on signal 15 from pid 242824
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/py=
thon3)
> UndefinedBehaviorSanitizer:DEADLYSIGNAL
> =3D=3D243045=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown addr=
ess
> 0x73fbfefe6a31 (pc 0x73fbba9788e9 bp 0x73fbbbe0af80 sp 0x7ffd676fbfe0
> T243045)
> =3D=3D243045=3D=3DThe signal is caused by a READ memory access.
>     #0 0x73fbba9788e9
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #1 0x73fbbaafc178
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16fc178)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #2 0x73fbba62564f
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x122564f)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #3 0x73fbbab067d7
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x17067d7)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #4 0x73fbba63b786
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x123b786)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #5 0x73fbba96290a
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x156290a)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #6 0x73fbba941c5c
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x1541c5c)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>     #7 0x73fbc2041f20
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f20) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #8 0x73fbc2041f68
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f68) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #9 0x73fbc2034ca9
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x34ca9) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #10 0x73fbc203ae90
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3ae90) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #11 0x73fbc203aeda
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3aeda) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #12 0x73fbc20a45f5
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa45f5) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #13 0x73fbc20a2bfc
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa2bfc) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>     #14 0x73fbd3047a75 in __run_exit_handlers stdlib/exit.c:108:8

Ok - interesting that we can corrupt the nVidia state so much it dies on
cleanup. I'll try and replicate with my intel setup.

>     #15 0x73fbd3047bbd in exit stdlib/exit.c:138:3
>     #16 0x5a5bab5e3fdb in qemu_default_main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/m=
ain.c:52:5
>     #17 0x5a5bab5e3f9e in main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/m=
ain.c:76:9
>     #18 0x73fbd302a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #19 0x73fbd302a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #20 0x5a5ba9c5b554 in _start
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-a=
arch64+0x15dc554)
> (BuildId: 8efda3601b42aa2644dde35d1d63f7b22b649a33)
>
> UndefinedBehaviorSanitizer can not provide additional info.
> SUMMARY: UndefinedBehaviorSanitizer: SEGV
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> =3D=3D243045=3D=3DABORTING
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

