Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1618EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUcR-00016K-It; Mon, 26 May 2025 05:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uJUcL-000161-VN
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:59:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uJUcJ-0007hu-OT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:59:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso17363965e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748253573; x=1748858373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKYWIkEksdeuZJ6gbHvGraHFCtyi40qni5poZgDrRhw=;
 b=Ze7DYqLKqq4aCv0p0p7ChCtfv5MX4cOkeA2eM43q20ZS0nHoOI5wykrK6O1xLEufnC
 6sKiQenh+ex/diSt5LcXTRJ67yDsPmnxXP81QTlU5QsvvRmSEPATwYhdd2Y7fKWT0Uct
 g8CEFDtj/zLufQ+BUTtfhnOX3IJ0/5F0Q9xaOnpnGV+GmqDcS8oB4xYzUu91ONYgTi6J
 +tT1jiC/my4OJ3GxQGVJaNd4A0XLvTKaq8oZpIYck+0pfIkvlHk2h4lKgFipk8cl/8bU
 nhlflG2qyQyjykanWhOKUO25xR/O2dLj48xqCDwbwA68a0YIoEcF42DUCfCoaIkhRqOc
 CJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253573; x=1748858373;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKYWIkEksdeuZJ6gbHvGraHFCtyi40qni5poZgDrRhw=;
 b=Wusm6tng97VEzkusA7OXbc5SwOAEOun1vi3A/CZEzTWfuUaII7uIDgfu8/1NJlGIJA
 7Oj1Xjxl1oMLiORYaIDmw+42bBk/PEYyQW7lXTpobkQIHzgdNfHiSaBwiDDgs8YhuBEl
 X9gUZqg+LACR2YUWhh85NrsC01/9qhzBtCxjrkZUIS/rr3Ketea9WZ5TkD7+1XNdwIgA
 85PsywGsrHrmkcwmpwt7Bz+G3MZwg1w2f+Gx6a16tghKJ1zgLEdok8pcpSJJCfmn7Xai
 XkyGOt6DvB8dwrcszOdg1MyFj0TOUyI0u5ztoKGLCRQQ17tPOndkaPVpqmf6rmR1jZLF
 wEEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX78NuWQ0VtfYCmeL5ZCLz1OQkhELBIl/nzzzcRV4HTf5BNqaNwTYpEF5cbNyCXFSDmKT17YupPrHt9@nongnu.org
X-Gm-Message-State: AOJu0YwAJM/SK6/m6K9ZtVZevXvs43TVc/A9JGMxr/cSzwRMtRy1DzcU
 XregPL9//GWlgTVWlcQ+0la4SkODzFlIwbqvScHQd9YRyIK3NkY/Edis
X-Gm-Gg: ASbGncuE1ZBJ1udy6eX4NIP32jClhh2P6R2Je/iiG2x/QryaS46wBzbLUjB0LQnK8TG
 do/gC8+tzqdUMLrfA0IVEqilKf+tqp9UYPwwYiqokXZfIfl7ZNi25URWmilfB6Yj+wXv4j1M9Bz
 FGWa2vwbGHWhcbXdCNr27lwvvQJdDr2Lh8Tde1Z4SH3AKVodCKQuS5B5GqPFu102DzdlfZHnxej
 p6d1096kbovJv3ud2FMYJrr8yUB1JcmhdlIC5G3cEXFJa4oc3O3dIU+S6Dp+cDCxBvUW15I+THp
 lAoXsw8x4dQHbNgfhl+kexjo4lQy9ZXE4RDG3E49CReJbXjkCYgSBoApcw==
X-Google-Smtp-Source: AGHT+IHLbEgbFMFqQB2/YUJ7f4aC42L2ocmdDALE17N9Y4GB1IMKrk8sFqS8qiuJXN8E7/ciI3EUyA==
X-Received: by 2002:a05:600c:348d:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-44c94c2a69fmr71958845e9.30.1748253572909; 
 Mon, 26 May 2025 02:59:32 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78aea59sm238608115e9.25.2025.05.26.02.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:59:32 -0700 (PDT)
Date: Mon, 26 May 2025 09:59:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
CC: philmd@linaro.org, smarkusg@gmail.com
Subject: Re: Using parallel port on the Pegasos 2
In-Reply-To: <1d4bc5e4-54ee-84d4-6f5c-50e2d5dd2850@eik.bme.hu>
References: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
 <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
 <1d4bc5e4-54ee-84d4-6f5c-50e2d5dd2850@eik.bme.hu>
Message-ID: <9F18409A-D9E4-45B3-8A82-BF605F9C56CE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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



Am 25=2E Mai 2025 00:03:15 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Sun, 28 Jul 2024, BALATON Zoltan wrote:
>> On Sun, 28 Jul 2024, quan wrote:
>>> I am playing around with the parallel port on the pegasos 2 and I noti=
ced
>>> the following issue:
>>> The parallel port on startup is set to iobase 0x378, then later it get=
s
>>> remapped to iobase 0x3bc=2E
>>> When I tried writing to the 0x3bc location with
>>> trace:memory_region_ops_write on, I get logs about writing to the loca=
tion
>>> 'parallel', so far so good, but the writes don't make it through (it n=
ever
>>> calls parallel_ioport_write* functions)
>>>=20
>>> I traced it through where it calls portio_write, and inside the
>>> portio_write code:
>>> This line always fails for me:
>>> const MemoryRegionPortio *mrp =3D find_portio(mrpio, addr, size, true)=
;
>>> This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the l=
ist,
>>> and the 'addr' in the code ranges from (0-15) (address relative to 0x3=
bc),
>>> so it can never match the parallel io function to execute=2E
>>>=20
>>> This seems like a bug to me=2E I think there is some issue where the
>>> portio_list is not getting updated properly after the remapping to 0x3=
bc=2E
>>>=20
>>> The other devices (Serial, RTC, PM, VGA) responds properly for me, so =
it is
>>> only the parallel port that has this issue=2E
>>=20
>> Is this something that broke recently or can the same be reproduced wit=
h QEMU v8=2E2=2E0=2E The relocation of these devices was implemented around=
 commit 35a6380b4ed27f (and the ones before that)=2E Adding Bernhard to cc =
as well=2E
>
>This commit also seems to break display with some VGA ROMs as can be repr=
oduced with:
>
>qemu-system-ppc -machine pegasos2 -bios pegasos2=2Erom -serial stdio -vga=
 none -device ati-vga,romfile=3Dati-rage128progl16mb=2EVBI
>
>where the romfile is something from http://vgamuseum=2Einfo/index=2Ephp/c=
ompanies/item/111-ati-rage-128-pro for example)=2E Until commit 35a6380b4ed=
27f^ you get picture on emulated VGA but not after (although I have no idea=
 what a VGA BIOS has to do with the parallel port)=2E Any idea how to fix t=
his?

Here an observation: Executing `info mtree` reveals that the parallel port=
 gets mapped to 0x3bc - 0x3c3 which overlaps with some vga region (0x3c0 - =
0x3cf)=2E So the commit seems to expose a firmware bug in pegasos2=2Erom or=
 in its default configuration=2E On real hardware both devices might respon=
d such that the bug might not materialize there like in QEMU, but that's ju=
st a guess=2E Maybe one could work around that by decreasing the priority o=
f the parallel io ports=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

