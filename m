Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4DC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWr7-0000i1-KQ; Mon, 24 Feb 2025 06:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmWr6-0000hm-ER
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:42:36 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmWr4-0006eK-FW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:42:36 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so6268219a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740397352; x=1741002152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Xi3pkRBFCTosNuAKZH42pnlN0B5kg+sQvAEiQvZnDs=;
 b=y/AZSPNwJHvLjxgyfJs2LK1AelWkattGTBrAmgWM3yin+L8g4HNxhS9q8MF9t76vRo
 YIMVjp7vnrOsm4X3k4GducifRV2BcMrFwh0HT1dD2K58L3TujYZPT8it8uID+8CKLbm4
 +7q9Z/GZpmV57xrVsvSuY8drYkesWakSxziokFPX4A0Go//j3ENlxNJ6vMgVKjBs7M8r
 luPahu/8Aa7AdBBtAfdSHv8jT5jgh4XH6wTWMGs81peMkjY33mIkcG6f+uVjmmY71SHL
 2WxBY+dF5RWW5vF+w/jN2KAN0AFgdgn0ElqSWRjagwPL9mUOn2n0LQQXSXPqWRyhOgSX
 OSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740397352; x=1741002152;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Xi3pkRBFCTosNuAKZH42pnlN0B5kg+sQvAEiQvZnDs=;
 b=vZcMZ/tFaP+YLNTZs6Bdxh67ddBSas43cdpMArUlqwGAQr09k6vGgBrMPWgLK8AAur
 DMXwKGWsQJPk4EvLGz1K9+26kDcolt9Ynw1FuMjGv2J02tLSpsVrRHPsrlgZssPKsNkE
 6Q4TN6Ol9Az3rCqOS6Vn7NcAkg9G5KHM5wlERU1p0U8eN0daclQdeqEdiq/s8bdomtkf
 n6QsBklyVI8hSbxnWGlEslpYSPBIH4Lw2+7Z/4v8NLKdFknXiW41/MSkwx7PEOsOnp0v
 9MCPodzV/otZ7Ft8ibtXATewfLdOeX5niA31KYEdfSLmmRICEYgVAyMakrXBLvz4VAN1
 VbXQ==
X-Gm-Message-State: AOJu0Yygz/9yeSO71NgQrS4wguNLF07tRgyTw7ht32QqQab6A6Z9XPD9
 gXn9MJIt9zOnHx5xb7ncOdAfsMLZqV8o1dw1TppjQ9+MAMb1HcwUm8jartbypKi/atqrx0fMI+8
 lqbs=
X-Gm-Gg: ASbGncsrTdfSvydjY6dAdJ1uIujwT58y8/ErmDCAV6Emp3YpQxZ3MfUD2/JxkK2TxP3
 bza6C8NsdBpdw8SMIJ1OUvxghAD75fcLh8lKgcDMDk7Ix63cRAa0ZvBeR7Z7cMNGGnRNmtIKkBP
 2ID6kOyAMvbPr2C/LR8CGC6niT92yIZJghMcnj2EJYEYG0CI083AJDPdNXBH0FdG2Tc8lvYwEIV
 E4Hl6kFG9vcM7QNw1aZ57m/R5S8GtCYMFEqoFvcx3+S4MRa4t6/9B4NlUbtBpvAw/WS8sWZAR4X
 W8aJdgEF15q0Pu/T/Vkaf0jWQXbD
X-Google-Smtp-Source: AGHT+IHcUbXJcbJLku6VvAhcrti8b6QMdZkRZ1KyFBodR/Kiy/Tvzm7xkCjcXoWTjCA9ziM6UissqQ==
X-Received: by 2002:a17:907:7284:b0:abb:6e07:3714 with SMTP id
 a640c23a62f3a-abc099d60e2mr1468126966b.10.1740397352383; 
 Mon, 24 Feb 2025 03:42:32 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abaa663210asm1937816266b.117.2025.02.24.03.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:42:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 966CC5F77B;
 Mon, 24 Feb 2025 11:42:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
In-Reply-To: <Z7xTDYS7SzYyNvGo@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 24 Feb 2025 11:07:57 +0000")
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
 <Z7xFQ4bHwBEo8aQw@redhat.com> <87eczn8vcj.fsf@draig.linaro.org>
 <Z7xTDYS7SzYyNvGo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 24 Feb 2025 11:42:30 +0000
Message-ID: <875xkz8t7d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Feb 24, 2025 at 10:56:12AM +0000, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Feb 21, 2025 at 04:01:01PM +0000, Alex Benn=C3=A9e wrote:
>> >> While running the new GPU tests it was noted that the proprietary
>> >> nVidia driver barfed when run under the sanitiser:
>> >>=20
>> >>   2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
>> >>   EOTF mode SDR and colorimetry mode default.
>> >>   2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using col=
or
>> >>   profile: stock sRGB color profile
>> >>=20
>> >>   and that's the last thing it outputs.
>> >>=20
>> >>   The sanitizer reports that when the framework sends the SIGTERM
>> >>   because of the timeout we get a write to a NULL pointer (but
>> >>   interesting not this time in an atexit callback):
>> >>=20
>> >>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
>> >>   =3D=3D471863=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknow=
n address
>> >>   0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6=
d0
>> >>   T471863)
>> >>   =3D=3D471863=3D=3DThe signal is caused by a WRITE memory access.
>> >>   =3D=3D471863=3D=3DHint: address points to the zero page.
>> >>       #0 0x7a18ceaafe80
>> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
>> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>> >>       #1 0x7a18ce9e72c0
>> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
>> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>> >>       #2 0x7a18ce9f11bb
>> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
>> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>> >>       #3 0x7a18ce6dc9d1
>> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
>> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>> >>       #4 0x7a18e7d15326 in vrend_renderer_create_fence
>> >>   /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/v=
rend_renderer.c:10883:26
>> >>       #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
>> >>=20
>> >> The #dri-devel channel confirmed:
>> >>=20
>> >>   <digetx> stsquad: nv driver is known to not work with venus, don't =
use
>> >>       it for testing
>> >>=20
>> >> So lets implement a blocklist to stop users starting a known bad
>> >> setup.
>> >
>> > I don't much like the conceptual idea of blocking usage of QEMU itself
>> > based on current point-in-time bugs in the host OS driver stack, becau=
se
>> > it is making an assertion that all future versions of the driver will
>> > also be broken and that's not generally valid.
>> >
>> > If the user chose to use a dodgy graphics driver, they can deal with
>> > the consequences of their choice.
>> >
>> > Skipping only the functional test, without any qemu-system code changes
>> > though is more palettable as that's not a hard block on usage.
>>=20
>> Well how do you do one without the other? I don't want to always skip the
>> vulkan testing because some developer setups have broken drivers. Unless
>> you are suggesting something like:
>>=20
>>   -device virtio-vga-gl,hostmem=3D4G,blob=3Don,venus=3Don,ignore-nvidia=
=3Don
>>=20
>> or something like that?
>
> I was thinking that test_aarch64_virt_gpu.py would dynamically check
> the kernel driver and use that in its @skip annotation.

If we can make the vulkan-info tool a dependency we could certainly do
that - otherwise the host-gpu code would need to be built as a command
line helper.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

