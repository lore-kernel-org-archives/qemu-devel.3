Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1037BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rai7h-0003aT-At; Thu, 15 Feb 2024 15:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rai7f-0003a9-S0; Thu, 15 Feb 2024 15:14:19 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rai7d-0004zv-Ro; Thu, 15 Feb 2024 15:14:19 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51178bbb5d9so10523e87.2; 
 Thu, 15 Feb 2024 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708028055; x=1708632855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxExqKLIxTmaSxNlYnPZSVjMIQEFl7DX9ZXUow+7Z+k=;
 b=gqzMCev8+kkr8cj4ffIifoDB28YbIUJeK2Ab1eo9H8ZnlMBTgkPmaMfbgSopGTww71
 Zh1XXBGgbAw3fhnDe1LFqmOfaEeW+3YrZFWNecjq+IiNkfKsgOPcp3sC9vKg4xNw/Dam
 B0QbuSPrIFgKJ40I5t7iBhWzqhtm3fBDiUxjfV4F9r5Fnt8OKti86R+7u4nNuuNlZ4Vc
 e32J27Fg9bmUHkmEL1I/PWxatyaBCTrogEEWMbjMz6VaycyFqkWd1SwJDHO4K0uQlwoc
 9yzn3NVMxR3Pm5F40SpTVmbZ+GLVsU0hEyAuvDyHr9XktnIF+zHKQtOUd16IlpjZjsvk
 XOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708028055; x=1708632855;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxExqKLIxTmaSxNlYnPZSVjMIQEFl7DX9ZXUow+7Z+k=;
 b=pyU+Ztdkhq6CdvZDQBkBuDLpr/aKEvn69CUTfYt1glMh8GbzyNt/psU52hBfjR99Io
 e0YnMWg7cYsZLoYgGja4r7WqiQes/UPcBUVfsNekel6pfKnThfdBlFEav3Z6Ugcdmx7G
 zP5YPC3u+woNBeoB+PxkYh75VZnzhwm81RVJ4ndgTgjGP8tTdMZAa1lvMIkPGkEgGeXD
 rbpjSc6JG94beGSoh8HtNtdQ8S0qwFQvrT6DiGYk8U/cpqNHuMt8EqFD6jUeBEmpzMEy
 Chq3Ygf6EKe+uetORCGeyioxJg9eSHCa5FkFyyrZ0r1g17kh7HPo1OrypLTrZjS02o52
 ieyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWURABa2S75x4o7RUIigd5kclaLHt8ecCjw8ZSeKSqSRYxKZ8QdIr3uP69046ftv5EAs7AAiRdwWTKuuPwriV8dalCK+4E9vw==
X-Gm-Message-State: AOJu0YzpYZm3mzLUJk7hLxWrxETDL1pxwcDK2xIOmIp/gD3B3iTVUAV3
 dYDz9mpmifxiHf7DvkzgqfdnTlUxVrkKrjhSWLp8eVTarrN66XpN
X-Google-Smtp-Source: AGHT+IG/alztCjVZa71muav968s8Nhey35mxuOJ4g1qtmfCw7F6InTON0hKCBMwV0P+bVDFNFNViiA==
X-Received: by 2002:a05:6512:401c:b0:511:6268:e66e with SMTP id
 br28-20020a056512401c00b005116268e66emr3135907lfb.38.1708028054905; 
 Thu, 15 Feb 2024 12:14:14 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-153-037.77.191.pool.telefonica.de.
 [77.191.153.37]) by smtp.gmail.com with ESMTPSA id
 v14-20020a056402174e00b0055ff9299f71sm855754edx.46.2024.02.15.12.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:14:14 -0800 (PST)
Date: Thu, 15 Feb 2024 19:33:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/7] hw/i386: Cleanups around 'hw/i386/pc.h'
In-Reply-To: <5e872a94-d4ab-4fe4-afe1-ffc952be8116@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
 <20240213105455-mutt-send-email-mst@kernel.org>
 <5e872a94-d4ab-4fe4-afe1-ffc952be8116@linaro.org>
Message-ID: <86BE0D60-FDEF-4552-8B9D-34CE03630043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12e.google.com
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



Am 13=2E Februar 2024 16:00:26 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 13/2/24 16:55, Michael S=2E Tsirkin wrote:
>> On Tue, Feb 13, 2024 at 01:01:45PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>> Trivial patches removing uses of "hw/i386/pc=2Eh"=2E
>>=20
>> How did you test that it's indeed unused?
>
>I put and #error in hw/i386/pc=2Eh and built :)
>(I'm trying to remove the PC dependency on generic devices=2E)
>
>The few generic devices left are not as trivial=2E
>
>>> Philippe Mathieu-Daud=C3=A9 (7):
>>>    target/i386/monitor: Remove unused 'hw/i386/pc=2Eh' header
>>>    hw/timer: Move HPET_INTCAP definition to "hpet=2Eh"
>>>    hw/isa/lpc_ich9: Remove unused 'hw/i386/pc=2Eh'
>>>    hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common=2Eh'
>>>    hw/i386/port92: Add missing 'hw/isa/isa=2Eh' header
>>>    hw/acpi/cpu_hotplug: Include 'pci_device=2Eh' instead of 'pci=2Eh'
>>>    hw/acpi/cpu_hotplug: Include 'x86=2Eh' instead of 'pc=2Eh'
>>>=20
>>>   hw/i386/acpi-common=2Eh   | 3 +++
>>>   include/hw/i386/pc=2Eh    | 6 ------
>>>   include/hw/timer/hpet=2Eh | 2 ++
>>>   hw/acpi/cpu_hotplug=2Ec   | 4 ++--
>>>   hw/i386/acpi-common=2Ec   | 1 -
>>>   hw/i386/port92=2Ec        | 1 +

I'd take care of port92 and make it part of all our three south bridge fam=
ilies (which models the real hardware more closely)=2E

Best regards,
Bernhard

>>>   hw/isa/lpc_ich9=2Ec       | 1 -
>>>   hw/timer/hpet=2Ec         | 1 -
>>>   target/i386/monitor=2Ec   | 1 -
>>>   9 files changed, 8 insertions(+), 12 deletions(-)
>>>=20
>>> --=20
>>> 2=2E41=2E0
>>=20
>

