Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389E2C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 09:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6o19-0005VG-IA; Tue, 14 May 2024 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s6o17-0005Ux-Qx
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:00:14 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s6o0w-0008Nc-Sf
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:00:13 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52327368e59so2425127e87.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715677200; x=1716282000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iThEkEHLKSgcwO0cwAbjOyyavSBOD5qd3pu/1jMktfE=;
 b=Es++kwkW9nW4NMrTGNcPylhqbg3IwM5xIES0EYUlBQn+XlyO462o61uOhDgUXFsakZ
 WJ/VerhirRh3FzdM4zqH9txViUJFqCy0nXK8tb5K+CEIPaSsAyPjgo+AEpf1xjZHsWTB
 KOTfmf7c3UKlvkYxFUtAvFWCU9p7rEG7CyrR6CgpDsHaF7rirbPDhXjjJtniabIiiFEw
 aWrTC2EDgfJnTZDvE5ZJgWZAizQ69YW4Rgm1SEKo16MTRuzCzylTIU5hX0yOakbcI1kT
 bWryhyw82RxfV3TnD1AiE/JwH4ckGGagJaX1W8uRWEKumuXuuAUj1v7ojeYTexm4Q65u
 Yn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715677200; x=1716282000;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iThEkEHLKSgcwO0cwAbjOyyavSBOD5qd3pu/1jMktfE=;
 b=OP/jWAwpWIsLR8EzTOjiPsjNR6X41ik5TtlH8Ej59GNpfKjN13mf3IBmRj6M6q9IIV
 7B/zXqg00GBiYE6LXzbjWhGRA+04qT/iSJ+4jLhqVmPme9jnRb0P0F/oU3F9a4OHWZ5q
 gOiD7DMJEYFrTFtA7VZYdnsslsvQhdPj09denoneMM0Iq7iHSYLdE99XnIH++w8oZkgH
 N1qe9HLsfNmVjb71YwvhjHexGjR+wcaJ7ljGB9mMdDCABFfvHvcFd0g9fib5Rbig9fqK
 14M5KD7fwhkwLc5oQ2JyHsPVV6El1xgwzf2KxX8et7tVBMGm0MQiPGwdnwZMN/ifii6E
 9fGQ==
X-Gm-Message-State: AOJu0Yy5/H1unSBgA80895o0dqAHuZ3PrfhmBefBrwl7ag0IJvoa3l+1
 UPWC5w9wzhRSKj9UF0H1W4wtPm2XJp15upzKYyMcTabKY94bMNW+
X-Google-Smtp-Source: AGHT+IElQbjNSumBOLO7whAToMdAncNkIEOzNH6HaqTxz81LPK17Ef7etEe+ulBV1bUMMY/G1JEjTw==
X-Received: by 2002:a05:6512:308f:b0:51a:c21b:73fb with SMTP id
 2adb3069b0e04-5221007498fmr9165787e87.44.1715677200137; 
 Tue, 14 May 2024 02:00:00 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea659dsm7234938a12.18.2024.05.14.01.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 01:59:59 -0700 (PDT)
Date: Tue, 14 May 2024 08:31:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 0/6] X86: Alias isa-bios area and clean up
In-Reply-To: <bf76c488-c454-e893-89f5-94e78a8d0329@eik.bme.hu>
References: <20240508175507.22270-1-shentey@gmail.com>
 <bf76c488-c454-e893-89f5-94e78a8d0329@eik.bme.hu>
Message-ID: <0F5CD4D8-4942-4E6C-A88D-EB715CAC2553@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 8=2E Mai 2024 20:39:28 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=2E=
hu>:
>On Wed, 8 May 2024, Bernhard Beschow wrote:
>> This series changes the "isa-bios" MemoryRegion to be an alias rather t=
han a
>> copy in the pflash case=2E This fixes issuing pflash commands in the is=
a-bios
>> region which matches real hardware and which some real-world legacy bio=
ses I'm
>> running rely on=2E Furthermore, aliasing in the isa-bios area is alread=
y the
>
>I wonder if this allows the guest to flash the bios now, replacing or bre=
aking it which may be a new security issue=2E

The bios can already be flashed, just from different addresses=2E This ser=
ies just adds another alias region through which flashing will be possible=
=2E AFAICS it doesn't impose new security issues=2E

Ping=2E=2E=2E The last patch still needs an R-b, the other patches are alr=
eady on master=2E

Best regards,
Bernhard

> If so this may need some machine property to enable it or is that not a =
problem in practice?
>
>Regards,
>BALATON Zoltan
>
>> current behavior in the bios (a=2Ek=2Ea=2E ROM) case, so this series co=
nsolidates
>> behavior=2E
>>=20
>> For migration compatibility the aliasing is only performed on new versi=
ons of
>> the q34 and pc machine types=2E
>>=20
>> v3:
>> * Amend commit message with a diff of `info mtree` (Phil)
>> * Add comments for bios memory regions (Phil)
>>=20
>> v2:
>> * Don't leak bios memory regions (Phil)
>> * Add compat machinery (Michael)
>>=20
>> Testing done:
>> * `make check` with qemu-system-x86_64 (QEMU 8=2E2=2E2) installed=2E Al=
l tests
>>  including migration tests pass=2E
>> * `make check-avocado`
>>=20
>> Best regards,
>> Bernhard
>>=20
>> Bernhard Beschow (6):
>>  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>>  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
>>    MachineState
>>  hw/i386/x86: Don't leak "isa-bios" memory regions
>>  hw/i386/x86: Don't leak "pc=2Ebios" memory region
>>  hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()
>>  hw/i386/pc_sysfw: Alias rather than copy isa-bios region
>>=20
>> include/hw/i386/pc=2Eh  |  1 +
>> include/hw/i386/x86=2Eh | 17 +++++++++++++++-
>> hw/i386/microvm=2Ec     |  2 +-
>> hw/i386/pc=2Ec          |  1 +
>> hw/i386/pc_piix=2Ec     |  3 +++
>> hw/i386/pc_q35=2Ec      |  2 ++
>> hw/i386/pc_sysfw=2Ec    | 17 ++++++++++------
>> hw/i386/x86=2Ec         | 45 ++++++++++++++++++++++--------------------=
-
>> 8 files changed, 58 insertions(+), 30 deletions(-)
>>=20
>> --
>> 2=2E45=2E0
>>=20
>>=20
>>=20

