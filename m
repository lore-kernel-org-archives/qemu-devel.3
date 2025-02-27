Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE2FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZJG-0006Kk-QN; Thu, 27 Feb 2025 03:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZJE-0006KK-Sy; Thu, 27 Feb 2025 03:31:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZJC-0005y1-F0; Thu, 27 Feb 2025 03:31:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c8f38febso10750165ad.2; 
 Thu, 27 Feb 2025 00:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740645112; x=1741249912; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrDpXVe8dpv7t1I8KLkj3/VmjhrRhfuHtNzj44soXF4=;
 b=DeoVbq4RTGrgNloRT0L5fH5tPdERt9Ju6ovC3TIvISs4MOiwBiCjwuHLZMm/WA0QZm
 hTSiWBf2+I6KnMcZJB1eukLznMt8gu1mTWoeVRCkSILap4ctWLyqVe9pzSFCGB632am2
 Z7rzcxV5hjjvLNtOnDjKWbGYpXGO22MFgPlDD+LKHrie8R3d5iVgqh/ZET3UcH/yJ3fz
 h56m6oRrJyQRRfx412VRwhQCEefiSHhzYL8Pog4P6vpFKjwzLP0zH57c+Ae8CpIPt4kj
 8p2OkDsxvWtoABcJhdLRzZ7mdNHXhMvk2lLCTX+D/ag35B1vh380JxKUB81YcTlCxGp2
 zCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740645112; x=1741249912;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PrDpXVe8dpv7t1I8KLkj3/VmjhrRhfuHtNzj44soXF4=;
 b=f94n39tBq/DHoky5MDmMT3WXxWT9JriDwV8151cO+1uiLdsdKBx+Rpb9TjMV0CvGdS
 bT/rT9TAoBmQRle9jIeGAaBPRwm8NuS8PQwPZYDYH9VfiVUkWZyVr5TxG1W9AaYiHKEj
 SFSBWJRIE2O+YATckdUEcrOIBmTKafL1XAeruOrtdSBQCdKzf40JFsVaJ6luoRWg1GFx
 1A7hvc+/uscQzpYqiX30rbPnqcDGydczCun+JQniHlQPTQen4spBoWqL3q9VHMTY+v94
 jijgBEWE8oMOO31gUlWMimA1DD2WdLzG6apda32VHk0SW6JH0M4OzhW4Dx0hvbmpYGwm
 mV8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdeydDKWw8V201gbPQhaqFMAxIJrbpBIoxEVTjTw39ZsqL2Nk2NXvu0ujubeTtfZlsYU9Cx5j+Ow==@nongnu.org
X-Gm-Message-State: AOJu0YyikKOPDTHOs2nUiunEbG+GMsd7QAdEV2aXdb84hiYqMsgPOZpJ
 2KTEJqGyyIl4fDC7V0DIYVqCrq9OUOqHQM+QRxYJHlifZvs53T4VXTM+Wg2p
X-Gm-Gg: ASbGnctwi5gBkD/GcpoKo5GUV160UiUsLcuoo/LRS6TjWdgt7ORTk/Ra1bI/WtAmM+I
 Jo46wRJkw/KsFZeVNgwFtUnvoeaQw4rg2ZCNXlJu0o+SpSj+0NLXWSDasFEtQpwESLe/F/DpZHk
 2dhyMqO+dVbPPwSIe5/StYSBD0gPr3pK5btegc6OrM2BskV5gbRM05RkmN8r7xh6/6hkupZw9Jj
 E77+1bPkxfjHz20hZiW8CnOaOkRIaXcM8ElG2W9IeVVgLv9tZgFrmrhQjU2jfr6VbkVo/t7kKm2
 tYVPCHkyhqYExxQAmw==
X-Google-Smtp-Source: AGHT+IGIOOfP8MH6qONbfyQzSPYWXzA4dPDwID+p0e5xZCDCTQyfAn/H52gTtFG369BANEf+o2a5ow==
X-Received: by 2002:a17:903:41c7:b0:220:f40c:71e9 with SMTP id
 d9443c01a7336-2219ff8288amr383551145ad.9.1740645110612; 
 Thu, 27 Feb 2025 00:31:50 -0800 (PST)
Received: from localhost ([1.146.124.39]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d323bsm9053765ad.3.2025.02.27.00.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:31:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 18:31:44 +1000
Message-Id: <D8336Y20C01W.31TRBEP0KTC1U@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 3/4] ppc/amigaone: Add default environment
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <f1b53e0822111c6c557797adcc75f8d2c7eed17f.1740243918.git.balaton@eik.bme.hu>
 <D82U15TLWUH7.2HKA1PQKQGVMM@gmail.com>
 <3a522e6f-5800-c530-e59f-a602c11a0fea@eik.bme.hu>
In-Reply-To: <3a522e6f-5800-c530-e59f-a602c11a0fea@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Thu Feb 27, 2025 at 12:18 PM AEST, BALATON Zoltan wrote:
> On Thu, 27 Feb 2025, Nicholas Piggin wrote:
>> On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
>>> Initialise empty NVRAM with default values. This also enables IDE UDMA
>>> mode in AmigaOS that is faster but has to be enabled in environment
>>> due to problems with real hardware but that does not affect emulation
>>> so we can use faster defaults here.
>>
>> So this overwrites a blank NVRAM file. Okay I suppose if that works.
>
> We're emulating what U-Boot does. If it does not find a valid environment=
=20
> it will overwrite with defaults.

AFAIKS u-boot provides a default environment if the CRC does not match.

If all-zeros env was created with correct CRC, IMO it should be
accepted.

Does u-boot write back a default environment or corrected CRC to NVRAM
if it was missing/bad?

> These defaults are to get the same=20
> behaviour and additionally to enable UDMA for IDE driver that until now=
=20
> had to be done manually to get the same speed as with pegasos2 where this=
=20
> is enabled by default. (That's because these VIA VT82C686B chips had some=
=20
> issues with DMA even in PCs but the emulated devices work so can be=20
> enabled and that's faster on QEMU too.)
>
>> You could have a property to supply the default environment
>> alternatively.
>
> U-Boot has the defaults hard coded. I set and use it from the same file s=
o=20
> I don't see the need to send this through a property. (Properties are als=
o=20
> listed in QEMU Monitor with info qtree and I don't know how a long string=
=20
> with embedded zeros would look there so I don't think that's a good idea.=
)
>
>> Anywhere to document this behaviour for users?
>
> I've added docs in the cover letter that I hope would end up in the=20
> changelog and I have a separate page for this which I'll update at=20
> qmiga.codeberg.page (Haven't done that yet but would do it by the=20
> release once this is merged.)

Okay. It would still be better to add QEMU options to docs/ files and
point the amiga pages to that rather than the other way around, since
this is QEMU specific stuff. Doc in cover letter unfortunately is
not very good since it  just gets lost.

>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>> index 5273543460..35e4075cc3 100644
>>> --- a/hw/ppc/amigaone.c
>>> +++ b/hw/ppc/amigaone.c
>>> @@ -52,6 +52,28 @@ static const char dummy_fw[] =3D {
>>>  #define NVRAM_ADDR 0xfd0e0000
>>>  #define NVRAM_SIZE (4 * KiB)
>>>
>>> +static char default_env[] =3D
>>> +    "baudrate=3D115200\0"
>>> +    "stdout=3Dvga\0"
>>> +    "stdin=3Dps2kbd\0"
>>> +    "bootcmd=3Dboota; menu; run menuboot_cmd\0"
>>> +    "boot1=3Dide\0"
>>> +    "boot2=3Dcdrom\0"
>>> +    "boota_timeout=3D3\0"
>>> +    "ide_doreset=3Don\0"
>>> +    "pci_irqa=3D9\0"
>>> +    "pci_irqa_select=3Dlevel\0"
>>> +    "pci_irqb=3D10\0"
>>> +    "pci_irqb_select=3Dlevel\0"
>>> +    "pci_irqc=3D11\0"
>>> +    "pci_irqc_select=3Dlevel\0"
>>> +    "pci_irqd=3D7\0"
>>> +    "pci_irqd_select=3Dlevel\0"

Hmm, the u-boot default env (before it was removed) selected
edge for these. Was that wrong?

>>> +    "a1ide_irq=3D1111\0"
>>> +    "a1ide_xfer=3DFFFF\0";
>>> +#define CRC32_DEFAULT_ENV 0xb5548481
>>> +#define CRC32_ALL_ZEROS   0x603b0489
>>> +
>>>  #define TYPE_A1_NVRAM "a1-nvram"
>>>  OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>>
>>> @@ -97,7 +119,7 @@ static void nvram_realize(DeviceState *dev, Error **=
errp)
>>>  {
>>>      A1NVRAMState *s =3D A1_NVRAM(dev);
>>>      void *p;
>>> -    uint32_t *c;
>>> +    uint32_t crc, *c;
>>>
>>>      memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram"=
,
>>>                                    NVRAM_SIZE, &error_fatal);
>>> @@ -116,12 +138,25 @@ static void nvram_realize(DeviceState *dev, Error=
 **errp)
>>>              return;
>>>          }
>>>      }
>>> +    crc =3D crc32(0, p + 4, NVRAM_SIZE - 4);
>>> +    if (crc =3D=3D CRC32_ALL_ZEROS) { /* If env is uninitialized set d=
efault */
>>> +        *c =3D cpu_to_be32(CRC32_DEFAULT_ENV);
>>> +        /* Also copies terminating \0 as env is terminated by \0\0 */
>>> +        memcpy(p + 4, default_env, sizeof(default_env));
>>> +        if (s->blk) {
>>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p=
, 0);
>>> +        }
>>> +        return;
>>> +    }
>>>      if (*c =3D=3D 0) {
>>>          *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>>          if (s->blk) {
>>>              blk_pwrite(s->blk, 0, 4, p, 0);
>>>          }
>>>      }
>>> +    if (be32_to_cpu(*c) !=3D crc) {
>>> +        warn_report("NVRAM checksum mismatch");
>>> +    }
>>
>> Maybe the default environment should be set if there is no CRC? If there
>> is a CRC already then that seems to indicate a valid rom file was
>> supplied and user wanted it blank.
>
> The idea is to allow supplying an environment via the backing file or let=
=20
> users edit it and clear the checksum in which case it will take the=20
> supplied data and only fix the checksum. Unlike U-Boot it will only=20
> replace empty backing file with defaults. (This is kind of undocumented=
=20
> for advanced users only but that's why the above code looks like that.)=
=20
> Having an empty NVRAM does not make much sense as U-Boot always has some=
=20
> values there so it's never empty. If it finds empty NVRAM then installs=
=20
> default env which is to help new users so they only need to create an=20
> empty file to get started. It also works without backing file in which=20
> case we want to use defaults and keep it persistent only for the session.
>
>> This can also be rewritten:
>>
>>    crc =3D crc32(0, p + 4, NVRAM_SIZE - 4);
>>    if (crc =3D=3D CRC32_ALL_ZEROS) { /* If env is uninitialized set defa=
ult */
>>        /* Also copies terminating \0 as env is terminated by \0\0 */
>>        memcpy(p + 4, default_env, sizeof(default_env));
>>        crc =3D CRC32_DEFAULT_ENV;
>>    }
>>    if (*c =3D=3D 0) {
>>        *c =3D cpu_to_be32(crc);
>>        if (s->blk) {
>>            blk_pwrite(s->blk, 0, 4, p, 0);
>>        }
>>    } else if (be32_to_cpu(*c) !=3D crc) {
>>        warn_report("NVRAM checksum mismatch");
>>    }
>
> I have the checksum check in separate if to warn if there is a checksum=
=20
> but it's wrong because I only want it to fix checksum if it's zero but no=
t=20
> touch it otherwise. Basically it will only overwrite zero values but leav=
e=20
> nonzero values there. (Might be useful for testing what does the guest do=
=20
> if the checksum is wrong, although on real machine U-Boot would have=20
> replaced the env with default in that case so this would only happen if=
=20
> the NVRAM is changed during runtime without updating the checksum.)

Right, you can just rewrite it a bit simpler to have only one exit point
and only do the blk_pwrite once etc I think (although my version might
have had a bug it was a bit hasty but you get the idea).

Thanks,
Nick

