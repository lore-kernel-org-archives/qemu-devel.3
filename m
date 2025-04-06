Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA335C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 11:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1NnA-00066w-A8; Sun, 06 Apr 2025 07:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u1Nmv-000653-LK
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 07:03:44 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u1Nms-0002AF-74
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 07:03:40 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac34257295dso698825866b.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743937414; x=1744542214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXhm/3YGGl0wmL3UHG87iEmiSBpzr25wHoprMxF9yVQ=;
 b=GEXs4sg7TNNBd22QKMVwNNSfvtF9YiFu1v8lMrmg/mFp0AKD1zi7TJVhSomdBqwXX1
 MZso0HrKG8yQ6eKgfUbf3/mo2PiDQxaqBQ/pdbYeZxSC6Y2OYUPLgMz+czTJVaePczbF
 8GDrB06WwWeGpgYlHncBynBS+3ARwZUWmgNYscyqxdyJdmGzneYQ9EU2qq64XPtDz7vi
 G0a5oRPisbEa6/ehpqwEHvwuUxAyUiX0dV75M8cXz/CO0bMybeY742NaOEcCKZhh4dj8
 35jTrMJG+g1r0fg4e+AaHqtIVoq4IP7PEmWVM1QmtMW3wTMg5qMEBMq2XJWwEVpnL19S
 x8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743937414; x=1744542214;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXhm/3YGGl0wmL3UHG87iEmiSBpzr25wHoprMxF9yVQ=;
 b=pFfGt6IqlbiOxQLLsdnTbGAqVjDf69hfmDyN6N+Zy9KSJF74eBQ5b1eKyOaJAhrbjB
 GcOKlnT0ZkhsEE2i/PdXCifas+f9NLtUd+tC5rfSuWxrI5g+xsrGuUimUm5KyLMBb1kI
 LTb1ZU8sKxhPlbi1jXe3cjNbUZadIqyBgm4MIaQLaxc18JpWVOcKn5HzLy9/2pKmaVH4
 KCXCk7lBXd2KuONHVREH31F8UvMmQAj3Q4KS5IgV4tJqXmjnGrSf1CviKH3aSGwQEs+U
 arutmv7/7UyTQIXNkqgUr+Vi4WHD5qE8z/TyzoUEsJZ/nazjPX/0iu1AQOSAmTbHF8b4
 jZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/nShCydRK2DoiNmz1UpNmqrerEmwgHdPZ8lIpjNMjrxd5MB6uDeuwTfHTrDjWnet3Q2uLT2amsyOq@nongnu.org
X-Gm-Message-State: AOJu0YytQ+q85Hy5fwBtHxBwbshpZ6kiYbTjJNLFswg6wNMNJ6T0llfO
 2ZFClRwvD3Uv3JVLpaYImwv+QkNkISCW/5XLGqmr3+PEKrDqQ65U
X-Gm-Gg: ASbGncsnweRnyXUrUKPgdS807jJ9j4FkYYNFf51Sk9jlgABXhxa6ZltWAgo1hVcfo6U
 c/Y9i8s4Xzji1Z9pU56VdLSqQdZZpRU7us/e4QqA5lY49x0iLttY7rpHSXJC2+PSTmVClDnG9KC
 XY0Hcg32lcVXganv74FEW/ODBjzsIE2GrGtI2fWZQPguYvUhsz9+ICpCUHzoJwMpa3R1AWlZQwz
 J2Eeyhvv3JJpgaL6qCEH525vy3OUG/iPWRoSi4zkjd7Mxkge3R2dKhJ6HVhR95lZFPTOgLgPJEx
 pXhgR8YIo6thnqJEqw2EYHKRuCaH2MMBlhOcgDjzpYyCR07RB+wmltrndS40BUay3cjN8ZKf1AA
 157fBkf9tU2IJoaB1FpIvV7kVggksQEXlCV/wXcFoqKueElrgITcb
X-Google-Smtp-Source: AGHT+IE5Bp4x04UhqE517FMbZWa+kX2LQz03ZihZ17ydIpCSytflg9i7ZJ6M8FUvLShKnBvFB3UAjA==
X-Received: by 2002:a17:907:3ea1:b0:ac7:19d3:1b2 with SMTP id
 a640c23a62f3a-ac7d6d062eemr872562266b.18.1743937413826; 
 Sun, 06 Apr 2025 04:03:33 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2fcd-c200-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:2fcd:c200:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0186973sm562482766b.154.2025.04.06.04.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 04:03:33 -0700 (PDT)
Date: Sun, 06 Apr 2025 11:03:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
Message-ID: <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 6=2E April 2025 01:31:49 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On 4/5/25 12:28, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 5=2E April 2025 17:26:14 UTC schrieb Guenter Roeck <linux@roeck-us=
=2Enet>:
>>> On 4/5/25 07:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi Guenter,
>>>>=20
>>>> On 5/4/25 16:00, Guenter Roeck wrote:
>>>>> This series is needed to support the USB interface on imx8mp-evk whe=
n
>>>>> booting the Linux kernel=2E
>>>>>=20
>>>>> According to the XHCI specification, ERSTBA should be written in Low=
-High
>>>>> order=2E The Linux kernel writes the high word first=2E This results=
 in an
>>>>> initialization failure=2E
>>>>>=20
>>>>> The following information is found in the Linux kernel commit log=2E
>>>>>=20
>>>>> [Synopsys]- The host controller was design to support ERST setting
>>>>> during the RUN state=2E But since there is a limitation in controlle=
r
>>>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>>>> It is supported when the ERSTBA is programmed in 64bit,
>>>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>>>=20
>>>>> [Synopsys]- The internal initialization of event ring fetches
>>>>> the "Event Ring Segment Table Entry" based on the indication of
>>>>> ERSTBA_LO written=2E
>>>>>=20
>>>>> Add property to support writing the high word first=2E Enable it
>>>>> for dwc3=2E
>>>>>=20
>>>>> ----------------------------------------------------------------
>>>>> Guenter Roeck (2):
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw: usb: xhci: Add property to=
 support writing ERSTBA in high-low order
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/usb/hcd-dwc3: Set erstba-hi=
-lo property
>>>>=20
>>>> What about using =2Eimpl=2Emin_access_size =3D 8 instead?
>>>>=20
>>>> Could you try this patch, or provide me with a reproducer?
>>>>=20
>>>=20
>>> You should find everything you need to reproduce the problem at
>>=20
>> Hi Guenter,
>>=20
>> thanks for testing the new board, much appreciated=2E
>>=20
>
>In this context: Did you get the PCIe interface to work ?
>It instantiates for me, but interrupts don't get through=2E
>This is with the latest Linux kernel=2E

Yeah, it works with Buildroot as described in the handbook=2E When I appen=
d `-netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0` on the cli =
I can `wget http://www=2Egoogle=2Ecom` successfully=2E When I omit it there=
 is no network connectivity=2E This is with a 6=2E6=2E23 vendor kernel=2E

However, even with your USB patches applied, PCIe and USB are non-function=
al on the latest aarch64 Arch Linux kernel (v6=2E14 [1]):

  [   21=2E102444] platform 32f10108=2Eusb: deferred probe pending: platfo=
rm: supplier 32f10000=2Eblk-ctrl not ready
  [   21=2E102914] platform 32f00000=2Epcie-phy: deferred probe pending: p=
latform: supplier 32f10000=2Eblk-ctrl not ready

I suspect that some bits need to indicate stable PLLs or similar, but that=
 needs further investigation=2E

Best regards,
Bernhard

[1] <https://archlinuxarm=2Eorg/packages/aarch64/linux-aarch64>

>
>Thanks,
>Guenter
>

