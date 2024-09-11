Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49735EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIT-0002pi-5D; Wed, 11 Sep 2024 08:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1soMHP-0007pJ-NF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1soMHN-0007XI-RQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:03 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so450686766b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726057020; x=1726661820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AwwrO7AexIBn5UzkGBUXAL6NYrI5jimiZLN5RSW2Xo=;
 b=mz2W7+zy1uVx5XRRsEX6vbW+McOBvxyqXFZG0g4YRA0m33SbjWsmeDrxZMOv82qy2Z
 XzpBMb/82ptBck9x/UXcmTJTEz6vIpP7SNUNOrMLtr7MMGxRnIHGyt5zGqjdWiIgi7ZH
 +TmBAccZ6n/B0U0lvOS5f6lrR1yJj6JhlHM/XkjoyRRiFH+IEuenmd/fNVFdMMDmeqCN
 potJmJkT5w9zNQsc9Z+V3OKXHhcvvrH3JAxLOimCzz7Dly9QmMkVcL2wU2dOCVkUtVMR
 Mk2Q6fQJ9gsePaT4NlgG59drzrHWP6aEi91xsfWwtTqTGG5pyJwCqiPOM6uaieV/rwxT
 Q8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057020; x=1726661820;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AwwrO7AexIBn5UzkGBUXAL6NYrI5jimiZLN5RSW2Xo=;
 b=hlWK7l+Y+6X3VtONoYP9XM160XiyEZlpzYdlCdmagKmkKvqPUecglU846MxDKxJwmO
 9pFHZTVjLF8MuD6SnoOLGsFvb2j6RaIEd2yjWLkXOQh3oqd6ejSyvhEv+1r6ayrSLTPx
 Yv8pky4P8Wn9dwq1vvbEQa1D3QLcyM+mgmforhhzesMS3dAX2coKUcWONZdUyFqgpJ7Z
 pF3cYFgIKyLNgMnNTskUupv9u//kguTH6EtTe6V8s69HQnQJ4+KQtA6JYHnaMBAPPiDQ
 0/KEtt47oaxQWKQtvAvY8r4+6OuPI4Bqjs0kBw2RcC8FDVlWhjhQC5XXejIoclTTSnaj
 CoqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVOnhG4Gz45+0S/92+cwlDNP+lYDwP1wnnDDqOKdcEnNymlbbcVbhY2kgCIakLcAKL4iwTHB+/9rxo@nongnu.org
X-Gm-Message-State: AOJu0YwUeYfIKc238tP+sJJNFOnZIagYdH483gwU/9yzJtkkbhE1d+JE
 TUWrXo18RhQZdiQ+3xGpRoObxNdQkl2F8gOjhyp/CMFBR96WwoBi
X-Google-Smtp-Source: AGHT+IFRlxqnYhEIZO2oI77aWYnWRf/ZFuQWw/RutCDhXoQob0sgHJwtjX+G39hy62Nw1AEnvGb8Iw==
X-Received: by 2002:a17:907:2daa:b0:a8d:3338:a48c with SMTP id
 a640c23a62f3a-a8ffaaacf88mr416697866b.7.1726057018777; 
 Wed, 11 Sep 2024 05:16:58 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-102-051.77.191.pool.telefonica.de.
 [77.191.102.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7277bsm599441766b.102.2024.09.11.05.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 05:16:58 -0700 (PDT)
Date: Wed, 11 Sep 2024 12:16:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
CC: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>,
 qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_ui/sdl2=3A_reenable_the?=
 =?US-ASCII?Q?_SDL2_Windows_keyboard_hook_procedure?=
In-Reply-To: <1e160bbe-f16a-4396-9f73-e9a6cab91fd9@linaro.org>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
 <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
 <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
 <7b536856-3155-432b-95b0-e03f96a0808e@linaro.org>
 <1e160bbe-f16a-4396-9f73-e9a6cab91fd9@linaro.org>
Message-ID: <6F67E7BA-44A5-4CBE-8678-C4273D6ECC20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E September 2024 11:59:25 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>On 11/9/24 13:57, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Volker,
>>=20
>> On 9/9/24 21:38, Volker R=C3=BCmelin wrote:
>>> Am 09=2E09=2E24 um 09:26 schrieb Marc-Andr=C3=A9 Lureau:
>>>> Hi
>>>>=20
>>>> On Mon, Sep 9, 2024 at 10:22=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@=
t-online=2Ede> wrote:
>>>>> Windows only:
>>>>>=20
>>>>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>>>>> level keyboard hook procedure to grab the left and right Windows
>>>>> keys correctly=2E Reenable the SDL2 Windows keyboard hook procedure=
=2E
>>>>>=20
>>>>> Because the QEMU Windows keyboard hook procedure is still needed
>>>>> to filter out the special left Control key event for every Alt Gr
>>>>> key event, it's important to install the two keyboard hook
>>>>> procedures in the following order=2E First the SDL2 procedure, then
>>>>> the QEMU procedure=2E
>>>>>=20
>>>>> Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2139
>>>>> Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2323
>>>>> Tested-by: Howard Spoelstra <hsp=2Ecat7@gmail=2Ecom>
>>>>> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online=2Ede>
>>>>> ---
>>>>> =C2=A0 ui/sdl2=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 53 ++++++++++++++++++++++++++++++---------------
>>>>> =C2=A0 ui/win32-kbd-hook=2Ec |=C2=A0 3 +++
>>>>> =C2=A0 2 files changed, 38 insertions(+), 18 deletions(-)
>>=20
>>=20
>>>> Note: there is no 2=2E16 release=2E They jumped from 2=2E0=2E22 to 2=
=2E24 (see
>>>> https://github=2Ecom/libsdl-org/SDL/releases/tag/release-2=2E24=2E0)
>>>=20
>>> Hi Marc-Andr=C3=A9
>>>=20
>>> Oh=2E This means that the comparison I wrote is true for SDL2 versions=
 <
>>> 2=2E24=2E0=2E
>>>=20
>>>>=20
>>>> The windows hook was indeed added in 2=2E0=2E16, released on Aug 10, =
2021=2E
>>>>=20
>>>> Given the distribution nature of the Windows binaries, I think we
>>>> could simply depend on a much recent version without worrying about
>>>> compatibility with < 2=2E0=2E16=2E This would help reduce the potenti=
al
>>>> combinations of versions and bugs reports=2E
>>>=20
>>> Okay, I'll send a version 2 patch series=2E
>>=20
>> Queuing patches 2 & 3 meanwhile=2E Please do not bury series within
>> threads, if Bernhard hadn't sent his T-b tag, I'd have missed it=2E
>
>Oh actually this is a series with a cover, but the cover subject
>doesn't contains 'PATCH' which is why my git tool missed it=2E
>

For me, `git am` didn't work after downloading the series' mbox=2E I had t=
o download each patch mail individually and apply one by one=2E Then I coul=
d test the series=2E


