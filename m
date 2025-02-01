Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F5C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 15:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teFFb-0000i4-Rz; Sat, 01 Feb 2025 10:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teFFU-0000hh-NP; Sat, 01 Feb 2025 10:17:32 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teFFS-0007Xd-IC; Sat, 01 Feb 2025 10:17:32 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so416242566b.1; 
 Sat, 01 Feb 2025 07:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738423048; x=1739027848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=2nTvcdUHNTievAB3rEn+RuZvnhGjiLMC+zNm7L6ovkY=;
 b=Vr+ria6l8PIkfxCE+Tr/xoedNThvmQrYZq/adRrEwcT+3HUjollXya0aAwQ0p8Fs1f
 zfF0MDb+p8E+JUY8Xdt0mAEX4Vaj+42XeYvCEwNOPuiG0QYpHb27mFCayQlExi5hTOie
 vzrjZ31TFDKh7/+OYuTkVntmOWxALrZ9VcGufZSZR5Vgt7grRWHzrvWUWB0l/BKofCln
 v7+P2ut9zgr48GaegfvKnjf/tfGYukZkvoFAbxymSzbpVeaGM+xzUWhKzVjO7dp8TjJ/
 XVSPLH8BJp8fqXmP+LIJ3+38Db87k9vIPGdNzJrix0nmn/WvVXkQkE57OSdNEH1AOC9G
 lCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738423048; x=1739027848;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nTvcdUHNTievAB3rEn+RuZvnhGjiLMC+zNm7L6ovkY=;
 b=Km07dcmVA62cVkOOB8AmaM8kxOhSGm0pYE/dhXPiJktPDKmyrvoKTY12MuvMSKGtVp
 nadX5rL5DT3IKcFe54VTUsG5xOwiLVlPt6gEVW+dUmHiszUveWshTbjIWrm86/83sr6h
 YWyj91fMC6XuxCF5l0/T2gYmXXUsjPPgGDMcYru9nS3cZ7gugiihZiY10K5Y+tYWjPhC
 K8X3n7eRuu1lZJda3e22+RasDHIFqDWtL2A0wnhNYAkfKY4cUe9tXNZ2Jk1OlcyBsxSO
 yJsDmHeoPFsJmLHMl9Py5/kXVhgfK/XZ+TZm1QMkAsNZCyhssmEJN7QtZdeJDPW2nrtB
 SZyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg6Gt3AF6teeucNI8WyglC43Fx8I4ne1FJXZQHKdU6ujE/+0p1at9J0RnxLx7CYr63XpzQQlXaVLE=@nongnu.org,
 AJvYcCW6o8QPS3XjZHaHYh4iFXYv2qXX/J9f3uW/MfqsbwcgGK9c6un07inOcJ8kUXfestb8PmfaVKRGw7Ih@nongnu.org
X-Gm-Message-State: AOJu0Yx2m1QwplVeyFAY2GFIeYCxDc3FUYMAmOAnek4JZeTUMd455/OG
 2ZKrO07PG7BQulNZOsUhCQXrPG+lQddlY898x3533qd7nynWL++H
X-Gm-Gg: ASbGncthskTQdQACERKZBC3GhQYUuaAwTs63dutG3rxekjCP9YVFsQbtkZ9+GQXKWCy
 K4Wmabln4ShrmHPXWjdnPwydvi6RKn5eh6hDpUEEe8If9gbaB4EalR3jJmCuj3AZ2fVwkiryVQk
 9azKUz7MzYP4w6iEWGGox7KJHuhgmxeWEj7O2cbDHZ4amFwhvR0wdpKupmyaGPRWqzSGmfPpwea
 bA2d5JnlugUs5QickFXcclWnMK/tFaTBiEEXs2y3N34BOJ4M7NF94hm8jBxpxB85STJx8jUASNn
 g/9Vuvq4leq7CZVWf/zDXmbbqTxKa0I43Bkly/lpaL/rVm47rY8D6ET3BrHCky1z9Us=
X-Google-Smtp-Source: AGHT+IH30e3m/qiLf5T4KqxFKLUFn8fxaub2DJ1EgHNo6sMWU4X2usQ5B+CZg8ruC0n9PWtsn22T+A==
X-Received: by 2002:a05:6402:4311:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dc5efa8bcdmr36242813a12.2.1738423047403; 
 Sat, 01 Feb 2025 07:17:27 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-083-158.77.183.pool.telefonica.de.
 [77.183.83.158]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723d0021sm4553387a12.5.2025.02.01.07.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2025 07:17:26 -0800 (PST)
Date: Sat, 01 Feb 2025 15:17:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
Message-ID: <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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



Am 1=2E Februar 2025 14:55:15 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 30=2E Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>>On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>> This allows guests to set the CCSR base address=2E Also store and retu=
rn
>>> values of the local access window registers but their functionality
>>> isn't implemented=2E
>>
>>Ping?
>
>I guess you're trying to boot a real firmware image from SD card? I've im=
plemented that in my e500-fdt branch which I want to send as an RFC=2E I st=
ill need to clean it up=2E Once it's on the list we could make a plan how t=
o turn it into a p10xx=2E Would that work for you?
>
>Best regards,
>Bernhard
>
>P=2ES=2E The last commit teaches you how to start a firmware from SD card=
=2E

Forgot to mention the link to the branch=2E Here it is: https://github=2Ec=
om/shentok/qemu/tree/e500-fdt

Best regards,
Bernhard

>
>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> ---
>>> hw/ppc/e500-ccsr=2Eh |  4 +++
>>> hw/ppc/e500=2Ec      | 79 ++++++++++++++++++++++++++++++++++++++++++++=
--
>>> 2 files changed, 80 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/hw/ppc/e500-ccsr=2Eh b/hw/ppc/e500-ccsr=2Eh
>>> index 249c17be3b=2E=2Ecfbf96e181 100644
>>> --- a/hw/ppc/e500-ccsr=2Eh
>>> +++ b/hw/ppc/e500-ccsr=2Eh
>>> @@ -4,12 +4,16 @@
>>> #include "hw/sysbus=2Eh"
>>> #include "qom/object=2Eh"
>>>=20
>>> +#define NR_LAWS 12
>>> +
>>> struct PPCE500CCSRState {
>>>     /*< private >*/
>>>     SysBusDevice parent;
>>>     /*< public >*/
>>>=20
>>>     MemoryRegion ccsr_space;
>>> +
>>> +    uint32_t law_regs[NR_LAWS * 2];
>>> };
>>>=20
>>> #define TYPE_CCSR "e500-ccsr"
>>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>>> index 64f8c766b4=2E=2E376cb4cb37 100644
>>> --- a/hw/ppc/e500=2Ec
>>> +++ b/hw/ppc/e500=2Ec
>>> @@ -43,6 +43,7 @@
>>> #include "qemu/host-utils=2Eh"
>>> #include "qemu/option=2Eh"
>>> #include "hw/pci-host/ppce500=2Eh"
>>> +#include "qemu/log=2Eh"
>>> #include "qemu/error-report=2Eh"
>>> #include "hw/platform-bus=2Eh"
>>> #include "hw/net/fsl_etsec/etsec=2Eh"
>>> @@ -1331,11 +1332,83 @@ void ppce500_init(MachineState *machine)
>>>     boot_info->dt_size =3D dt_size;
>>> }
>>>=20
>>> +static int law_idx(hwaddr addr)
>>> +{
>>> +    int idx;
>>> +
>>> +    addr -=3D 0xc08;
>>> +    idx =3D 2 * ((addr >> 5) & 0xf);
>>> +    if (addr & 8) {
>>> +        idx++;
>>> +    }
>>> +    assert(idx < 2 * NR_LAWS);
>>> +    return idx;
>>> +}
>>> +
>>> +static uint64_t law_read(void *opaque, hwaddr addr, unsigned size)
>>> +{
>>> +    PPCE500CCSRState *s =3D opaque;
>>> +    uint64_t val =3D 0;
>>> +
>>> +    switch (addr) {
>>> +    case 0:
>>> +        val =3D s->ccsr_space=2Eaddr >> 12;
>>> +        break;
>>> +    case 0xc08 =2E=2E=2E 0xd70:
>>> +        val =3D s->law_regs[law_idx(addr)];
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register=
 read"
>>> +                      "0x%" HWADDR_PRIx "\n", addr);
>>> +    }
>>> +    return val;
>>> +}
>>> +
>>> +static void law_write(void *opaque, hwaddr addr, uint64_t val, unsign=
ed size)
>>> +{
>>> +    PPCE500CCSRState *s =3D opaque;
>>> +
>>> +    switch (addr) {
>>> +    case 0:
>>> +        val &=3D 0xffff00;
>>> +        memory_region_set_address(&s->ccsr_space, val << 12);
>>> +        break;
>>> +    case 0xc08 =2E=2E=2E 0xd70:
>>> +    {
>>> +        int idx =3D law_idx(addr);
>>> +
>>> +        qemu_log_mask(LOG_UNIMP, "Unimplemented local access register=
 write"
>>> +                      "0x%" HWADDR_PRIx " <- 0x%" PRIx64 "\n", addr, =
val);
>>> +        val &=3D (idx & 1) ? 0x80f0003f : 0xffffff;
>>> +        s->law_regs[idx] =3D val;
>>> +        break;
>>> +    }
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register=
 write"
>>> +                      "0x%" HWADDR_PRIx "\n", addr);
>>> +    }
>>> +}
>>> +
>>> +static const MemoryRegionOps law_ops =3D {
>>> +    =2Eread =3D law_read,
>>> +    =2Ewrite =3D law_write,
>>> +    =2Eendianness =3D DEVICE_BIG_ENDIAN,
>>> +    =2Evalid =3D {
>>> +        =2Emin_access_size =3D 4,
>>> +        =2Emax_access_size =3D 4,
>>> +    },
>>> +};
>>> +
>>> static void e500_ccsr_initfn(Object *obj)
>>> {
>>> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
>>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>>> -                       MPC8544_CCSRBAR_SIZE);
>>> +    PPCE500CCSRState *s =3D CCSR(obj);
>>> +    MemoryRegion *mr;
>>> +
>>> +    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC8544_CCSR=
BAR_SIZE);
>>> +
>>> +    mr =3D g_new(MemoryRegion, 1);
>>> +    memory_region_init_io(mr, obj, &law_ops, s, "local-access", 4096)=
;
>>> +    memory_region_add_subregion(&s->ccsr_space, 0, mr);
>>> }
>>>=20
>>> static const TypeInfo e500_ccsr_info =3D {
>>>=20

