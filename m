Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F98C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 19:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc8Ht-0003LS-6H; Wed, 16 Jul 2025 15:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uc8Hj-0003IV-O5
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 15:59:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uc8Hh-0007sR-Bs
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 15:59:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo312481a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752695959; x=1753300759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2a97NqwIEw9g87CsmoxLNZJ0rrqrzEHQ8Q7KpDyHhw=;
 b=FWt9pJw3DZUHla9TT4+A3lyHSRNCluPNFfCtZ9hk3WcnvMAG8Cd5sKSlC8SIMvisye
 FZW3pIopRdiS4iYvRyKvaIPIU6WE8u1iyqP77yYBEdW/5ZFojU+EV7D5BbaZPpaHAPCp
 CJagXsNL/adQrJ8OUjo+3OLBsTqvi/JuUkRUzhQYDQ8Lr07gInaER5cYrfPE0T72DR+e
 U8A7PgO4/2KH7cDtFqmeqCCFmZBQ9tVOY8Glqj3fAUDJiJuiSRy6jkafu0muhELyw6Ij
 ykIUwA2RiwoXjt87aIFXL/pt5wpka4mc1xr5OB5Fi8L7gGyUS1mZJHO2z/JWKCVHsapO
 APig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752695959; x=1753300759;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2a97NqwIEw9g87CsmoxLNZJ0rrqrzEHQ8Q7KpDyHhw=;
 b=k3SjJJC7Z1mExPRdS4u60nqUWGSxQT8VajdLpCbTtk9qCKjgHG6Mn/J+Ev/cY1EDCX
 0fT1Y0cvCzsR+41oL5hOSi5qgfZdzo1Uuho7bMsRbpx+GQcw85njSWfHJZdveiU2rvxw
 JentMuc+yy30pa1Wddsr2FeK6MgAwZ4C+M3nAHELUFo1LMAsU/7qCNXQ1mhkAk2X3zOI
 Uz+vRhjmTZA2jFZmtZJ6Kaw3sgEm85F3FFgUltWkqFEieX7ob7zAokgiCb9TfR4oGeh2
 SlHDoiGJi5Wb3JjPeG8KGGwcIrmmCdemA8jPSfw3YfhMyI+tLES2OcXn4HiIm3OmMVwV
 eWNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVonwbnZkw/v7lQcK2qSGUzjP4jrIGfpipmMRgMupNH24feKa5bew+rIuTQRls0BP7g+nYubbV3l9Ns@nongnu.org
X-Gm-Message-State: AOJu0Yxm6ax0TslRZBkvL212g/LzMSchlUw9k2B3ai3aHS31va0CiR3P
 C5ovcBRHD7YRLoHXEh/zJYrKFRMlMw4oFhJPDldlxbngjkhX8Yx1JPaw
X-Gm-Gg: ASbGncvG8O5OZVmPmmILT8WpzTGjCFBCHkDXUgvm0mbd0PNHXrorvSS4BpSMjPsgzH+
 lTsaZr/8zc4xWEfHYlncqH2TjJOkbisUMnDDJFE67I0eDYi/UIodaITEFWkLEuMFhSrv4qw55qc
 bNA0dvCxjM5udmBXRCrTfD0U2WXOtTrrh9ro6gcUzwKf9JafNR0BCz8ZIu5KmymMNGfFcfm8fow
 ESrv7ZmnMuGLiwdwfbtCJoZa3CW5qw8gkQ5i+s2VAYzmqZFTTgTGcu4Cll5IhIAJTxmfnEypELW
 2ZnTfqjvAhJ9JCXrOcwpSr4FZcGk4xHYDhsi6cdGE1tYpKIZEc3jGwdrpfQMRevoywqnma/qBzu
 5YjY/833qnFqWcZCwQ4lSN7wKIoOeneld+KDx6gxs7/G91p7GMkiNLs5RNKfreVY9hAgnrjZzLE
 bKHr+9hPUXjMlTLxr1AELnJADfytyUug==
X-Google-Smtp-Source: AGHT+IFMcfAjF2d4P2Q3cXbAWituO6YKBDDma3KBI6cln2yxz2oKORQB5L8F/g1DqAk3S9+bZE52VA==
X-Received: by 2002:a17:906:d268:b0:ae3:c6a3:f855 with SMTP id
 a640c23a62f3a-ae9ce0b9061mr387861966b.31.1752695958908; 
 Wed, 16 Jul 2025 12:59:18 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-189e-df00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:189e:df00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e92176sm1220967966b.22.2025.07.16.12.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 12:59:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 19:59:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <groeck7@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw=3A_usb=3A_xhci=3A_Add_property?=
 =?US-ASCII?Q?_to_support_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <41a54c58-25df-4027-bc93-45a817c2d570@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-2-linux@roeck-us.net>
 <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
 <41a54c58-25df-4027-bc93-45a817c2d570@roeck-us.net>
Message-ID: <15C9B399-B43D-4D81-9FBA-64C30C07C94C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



Am 13=2E April 2025 16:03:16 UTC schrieb Guenter Roeck <linux@roeck-us=2En=
et>:
>On 4/11/25 00:40, Nicholas Piggin wrote:
>> On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
>>> According to the XHCI specification, ERSTBA should be written in Low-H=
igh
>>> order=2E The Linux kernel writes the high word first=2E This results i=
n an
>>> initialization failure=2E
>>=20
>> This should probably be reworded, it's not so much that Linux does it,
>> this kind of implies a Linux bug=2E It is that the hardware requires it
>> and Linux works around such quirk=2E
>>=20
>>    According to the XHCI specification, ERSTBA should be written in Low=
-High
>>    order, however some controllers have a quirk that requires the low
>>    word to be written last=2E
>>=20
>>>=20
>>> The following information is found in the Linux kernel commit log=2E
>>>=20
>>> [Synopsys]- The host controller was design to support ERST setting
>>> during the RUN state=2E But since there is a limitation in controller
>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>> It is supported when the ERSTBA is programmed in 64bit,
>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>=20
>>> [Synopsys]- The internal initialization of event ring fetches
>>> the "Event Ring Segment Table Entry" based on the indication of
>>> ERSTBA_LO written=2E
>>=20
>> Could you include a reference to the commit in the normal form?
>>=20
>> The following information is found in the changelog for Linux kernel
>> commit sha ("blah")=2E
>>=20
>>>=20
>>> Add property to support writing the high word first=2E
>>>=20
>>> Signed-off-by: Guenter Roeck <linux@roeck-us=2Enet>
>>> ---
>>>   hw/usb/hcd-xhci=2Ec | 8 +++++++-
>>>   hw/usb/hcd-xhci=2Eh | 1 +
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/hw/usb/hcd-xhci=2Ec b/hw/usb/hcd-xhci=2Ec
>>> index 64c3a23b9b=2E=2E8c0ba569c8 100644
>>> --- a/hw/usb/hcd-xhci=2Ec
>>> +++ b/hw/usb/hcd-xhci=2Ec
>>> @@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, hwad=
dr reg,
>>>           } else {
>>>               intr->erstba_low =3D val & 0xffffffc0;
>>>           }
>>> +        if (xhci->erstba_hi_lo) {
>>> +            xhci_er_reset(xhci, v);
>>> +        }
>>>           break;
>>>       case 0x14: /* ERSTBA high */
>>>           intr->erstba_high =3D val;
>>> -        xhci_er_reset(xhci, v);
>>> +        if (!xhci->erstba_hi_lo) {
>>> +            xhci_er_reset(xhci, v);
>>> +        }
>>>           break;
>>>       case 0x18: /* ERDP low */
>>>           if (val & ERDP_EHB) {
>>> @@ -3636,6 +3641,7 @@ static const Property xhci_properties[] =3D {
>>>       DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
>>>       DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
>>>                        DeviceState *),
>>> +    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, false),
>>>   };
>>>     static void xhci_class_init(ObjectClass *klass, void *data)
>>> diff --git a/hw/usb/hcd-xhci=2Eh b/hw/usb/hcd-xhci=2Eh
>>> index 9c3974f148=2E=2Ecf3f074261 100644
>>> --- a/hw/usb/hcd-xhci=2Eh
>>> +++ b/hw/usb/hcd-xhci=2Eh
>>> @@ -189,6 +189,7 @@ typedef struct XHCIState {
>>>       uint32_t numports_3;
>>>       uint32_t numintrs;
>>>       uint32_t numslots;
>>> +    bool erstba_hi_lo;
>>=20
>> Could you use the "quirk" prefix for the device and property name?
>>=20
>
>Done all, except then I noticed that you want me to prepend "quirk"
>and I appended it out of habit=2E So I'll need to start over :-(=2E

Ping

Any news? Would be nice if a fix made it into 10=2E1=2E

>
>Guenter
>

