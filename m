Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9192DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 22:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcCLO-0006ci-J5; Mon, 19 Feb 2024 17:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcCLL-0006bw-Hm
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 17:42:35 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcCLI-0000fC-Dn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 17:42:35 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so662890266b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 14:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708382551; x=1708987351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVRe4oAbKwnejLsPFxLblgW35fG6IMmK0xh4kag9f0U=;
 b=AnXxPnZMSfNPObdGJMF8XiwjxCzifrxRyqtHbaZp48yhF6Pz1YhSyXPIMAkR4bhWsH
 65qFzLHl9FuCq4RsL3OTVaRvB8D0NX/1ugb0/fmb7gCx3wuSuZr0jeZbGxzznJJ5BedQ
 QSioK6OXmzeO0zEb4VEF5l8DFB6A6B9zYxWbXhDCOY7vPjVQTuI6qnxxB1R9jWN9nMgl
 qnTvBqq5AQsQM0FBDlSKtmRmchlBjJzFwD5xjJp0vPGPU4rAWtGMI6tn4i5ZhyuoHlRc
 tFM3cBg6Mk9TLTZ1hQQNGSGT4DfBqgwQY8GHXN9AyLnaT21qWEH7hEU3DfoB748XOh9H
 h5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708382551; x=1708987351;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVRe4oAbKwnejLsPFxLblgW35fG6IMmK0xh4kag9f0U=;
 b=NQ/J5TIE6leZ+iv3w3ONlkZpr+0sVMKrE9yGmu4bGrDuqrAJQvHpm4Yet2jc2/s6Zk
 7dIs98JbhOzxG/9t/skNkx1uTCv8VvIqW8j56pgYAYf7M5FqSQdoQkypwg/ZBO9Ktrbv
 2/yOnY3cs/A7BSNA4mJUxlPu39bj2DX/jV9dXyhChWq426EhztRGbOIRR9P9NABeztdF
 1/6M3SXY+Uk2NMpZevhtYUWf69pfiJyTH3scCHoPS70j/hMp8ckNC/eJj+UJrZt+MFkq
 nFldwYt3MD5Ku4qxJtHw2hfgbenrXTq8uHR4QK1twpeuovgXXmacgiWSo4KXoSgYMjW2
 a9IA==
X-Gm-Message-State: AOJu0YwqPKg0YQNKHNW65jIqGIwEsZN5tST6RLxNE8jz1Nd0QOojpfK3
 4KO0Tn65LK8VXK+cDCLy2MRaXWEFsnp0pnAoJCmoVFTcHuIFp2jr
X-Google-Smtp-Source: AGHT+IGCtlmfQZIGAuHZvp0t92ISZt9h/eImjhcXo7EQ9xe3jzQ5QrNVGko2tUf2NuWNDcpvLsvXOw==
X-Received: by 2002:a17:906:68d7:b0:a3e:e768:398f with SMTP id
 y23-20020a17090668d700b00a3ee768398fmr516926ejr.71.1708382550446; 
 Mon, 19 Feb 2024 14:42:30 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-244-242.89.14.pool.telefonica.de.
 [89.14.244.242]) by smtp.gmail.com with ESMTPSA id
 tl7-20020a170907c30700b00a3e5bcfe5b7sm2240241ejc.134.2024.02.19.14.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 14:42:30 -0800 (PST)
Date: Mon, 19 Feb 2024 22:42:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 0/5] Implement port 92 in south bridges
In-Reply-To: <35e05c51-6a06-1830-972b-42332e7b7b56@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <35e05c51-6a06-1830-972b-42332e7b7b56@eik.bme.hu>
Message-ID: <C3298468-C026-475D-9FF4-18699007CD6C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 18=2E Februar 2024 16:12:30 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sun, 18 Feb 2024, Bernhard Beschow wrote:
>> This series attempts to make QEMU's south bridge families PIIX, ICH9, a=
nd VIA
>> 82xx more self-contained by integrating IO port 92 like the originals d=
o=2E
>>=20
>> In QEMU, the IO port is currently instantiated as a dedicated device in=
 common
>> PC code=2E While this works and even results in less code, it seems cle=
aner to
>> model the behavior of the real devices=2E For example, software running=
 on the
>> Malta machine, which uses PIIX4, needs to take port 92 into account, ev=
en if it
>> doesn't use it (does it?)=2E Moreover, the FDC37M81x used in the origin=
al Malta
>> machine provides a port 92 too, which can be activated=2E If QEMU imple=
mented the
>> FDC37M81x more closely, one could check if Yamon (or any alternative bo=
ot
>> loader) deals correctly with these ports=2E
>
>Maybe that's unlikely as this register is for controlling A20 line of Int=
el CPUs so probably there's no use for it in a MIPS or PPC board but I'm no=
t sure if it may be used for something else=2E
>
>> Moving port 92 into the south bridges might also help with configuratio=
n-driven
>> machine creation=2E In such a scenario it is probably desirable if mach=
ine code
>> had less of its own idea of which devices it creates=2E
>
>The direction is probably good as these chips have a pin for A20 control =
and handle the register themselves but I'm not sure this series is the righ=
t way=2E One immediate problem is that TYPE_PORT92 has state which is in th=
e migration stream so moving it elsewhere would break migration which would=
 need to be handled=2E Does this series handle that?

I've created two migration streams, one before and one after the change=2E=
 Then I've converted both to JSON with `analyze-migration=2Epy -d desc`=2E =
The only difference is the position of the port92 record in the devices arr=
ay (before: 31, after: 14)=2E I'm no migration expert, but telling from the=
 JSON content, "name" and "instance_id" seem to uniquely identify a device =
record and changing positions in an array seems rather innocent to me=2E Si=
nce there will be one port92 record before and after this series, it seems =
as if migration is not affected=2E But someone's judgment with migration ex=
pertise may be needed here=2E

> I'm not sure it's worth the effort though if it results in more comlex c=
ode=2E If the migration issue is handled, then I think we should get rid of=
 TYPE_PORT92 completely and just add the one reg and qemu_irq modeling the =
output pin as qemu_gpio to the south bridge implementations directly, not e=
mbedding a separate object for it as these south bridges may already have s=
ome io region for ports and state where the reg can be stored so it could b=
e added there instead of just moving the TYPE_PORT92 there=2E

I'd rather avoid adding copy'n'paste code=2E Having port 92 wrapped in a d=
edicated, reusable device model which handles migration seems like the way =
to go to me=2E

> But with the migration issue it's probably easier to just leave it as it=
 is now=2E Even if this would model the real chip better, it would result i=
n more code and complexity in QEMU so not sure it's a good idea because of =
that=2E
>
>> Moving port 92 from
>> machine code into a potentially user-creaeable device (where it is part=
 of per
>> datasheet) seems like a good direction=2E Of course, machine code still=
 wires up
>> port 92 and I don't have a good idea on how to make this user-configura=
ble=2E
>> Such insights might provide some input for discussions around
>> configuration-driven machine creation=2E
>
>That's a generic problem for dynamic or declarative machine creation to s=
olve=2E Likely the machine description will also need to describe the conne=
ctions between devices, not just what devices to instantiate=2E So that's n=
ot specific to port92=2E As we're not there yet it's also not urgent to tou=
ch this port92 stuff=2E
>
>Maybe I overestimate the migration issue as I'm not familiar with that so=
 if others think it's not an issue then I'm not against this series as it w=
ould bring the model closer to the actual hardware but then go all the way =
and get rid of TYPE_PORT92 and just implement it in the south bridges=2E Bu=
t due to how it's currently done and how that's now baked in because of bac=
kward compatibility requrement for migration, I'm not sure it would really =
simplify the code, so we may need to live with what we have now=2E But let =
me know if I'm wrong and missed something=2E
>
>Regards,
>BALATON Zoltan

Any other opinions?

Best regards,
Bernhard

>
>> This series is structured as follows: Patch 1 moves TYPE_PORT92 into th=
e isa
>> directory to make it reusable by other architectures=2E It also adds a
>> configuration switch=2E Patch 2 integrates TYPE_PORT92 into the PC sout=
h bridges
>> and adapts PC code accordingly=2E While at it, patch 3 cleans up wiring=
 of the
>> A20 line with the keyboard controller=2E Patch 4 simply adds TYPE_PORT9=
2 to the
>> VIA south bridges which is also needed when using the VIA south bridges=
 in the
>> pc machine=2E
>>=20
>> Testing done:
>> * `qemu-system-x86_64 -M {q35,pc},i8042=3D{true,false} =2E=2E=2E`
>>  -> `info mtree` confirms port92 to be present iff i8042=3Dtrue
>> * `make check`
>> * `make check-avocado`
>> * Start amigaone and pegasos2 machines as described in
>>    https://patchew=2Eorg/QEMU/20240216001019=2E69A524E601F@zero=2Eeik=
=2Ebme=2Ehu/
>>  -> no regressions compared to master
>>=20
>> Best regards,
>> Bernhard
>>=20
>> Bernhard Beschow (5):
>>  hw/isa/meson=2Ebuild: Sort alphabetically
>>  hw/i386/port92: Allow for TYPE_PORT92 to be embedded in devices
>>  hw/isa: Embed TYPE_PORT92 in south bridges used in PC machines
>>  hw/i386/pc: Inline i8042_setup_a20_line() and remove it
>>  hw/isa/vt82c686: Embed TYPE_PORT92
>>=20
>> include/hw/i386/pc=2Eh          |  7 +------
>> include/hw/input/i8042=2Eh      |  1 -
>> include/hw/isa/port92=2Eh       | 30 ++++++++++++++++++++++++++++++
>> include/hw/southbridge/ich9=2Eh |  4 ++++
>> include/hw/southbridge/piix=2Eh |  3 +++
>> hw/i386/pc=2Ec                  | 21 ++++++++++++++-------
>> hw/i386/pc_piix=2Ec             |  9 +++++++--
>> hw/i386/pc_q35=2Ec              |  8 +++++---
>> hw/input/pckbd=2Ec              |  5 -----
>> hw/isa/lpc_ich9=2Ec             |  9 +++++++++
>> hw/isa/piix=2Ec                 |  9 +++++++++
>> hw/{i386 =3D> isa}/port92=2Ec     | 14 +-------------
>> hw/isa/vt82c686=2Ec             |  7 +++++++
>> hw/i386/Kconfig               |  1 +
>> hw/i386/meson=2Ebuild           |  3 +--
>> hw/i386/trace-events          |  4 ----
>> hw/isa/Kconfig                |  6 ++++++
>> hw/isa/meson=2Ebuild            |  3 ++-
>> hw/isa/trace-events           |  4 ++++
>> 19 files changed, 104 insertions(+), 44 deletions(-)
>> create mode 100644 include/hw/isa/port92=2Eh
>> rename hw/{i386 =3D> isa}/port92=2Ec (91%)
>>=20
>> --
>> 2=2E43=2E2
>>=20
>>=20
>>=20

