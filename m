Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB658C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 22:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1torpL-0005Du-KC; Sun, 02 Mar 2025 17:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1torp3-0005AC-8h; Sun, 02 Mar 2025 17:30:09 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1torp0-0004m9-Vw; Sun, 02 Mar 2025 17:30:09 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e4cbade42aso5537131a12.1; 
 Sun, 02 Mar 2025 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740954605; x=1741559405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PUpPoQTvVdjjXZT/CGrhL09uXSqJSo3bX+RYt0RG/0=;
 b=a2Qqh7VNR0Q7cRPXQwAA3DIQmUevZn6RGLbBpeaYUSI7BkKY2i4RsIcw5fbwzr7qQg
 0CzRq0XkDdCGY8/QvzirAsb2QLolg5xeltf5ytI8cQEcJ6Wh20d7TMa3x9Ro8hl0b71V
 KF/ed6mZYNKjs3Q2JRvr9xhOTV6MIXF3JfX3Lys447JbkUQtsNIU4YfeID0nOHkbXIr/
 UtGXQYjMHB+xPGC3uFIR4BhbgYCGls1GqhvSa7yjkJYNrAlvwyi/+2fq6QpRxIYtkST6
 AMIlqcHBCkRt9NAeO9RM05XUcu0YGEdMPHE0j9dI8T+ctTkzxBNQQ2kbrhnUm2rq8JRX
 ICpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740954605; x=1741559405;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PUpPoQTvVdjjXZT/CGrhL09uXSqJSo3bX+RYt0RG/0=;
 b=pvMLfJBhf+OY18F+WDiIgJb/JBLcay17tSH5cr2P5OALoBJ+ewR5IA07BYvG6JDmzD
 AjC6GrSXEpy9PnDWt1Gizz1CNKIc5xT/rKpL65PHAwVhwqVbgeCzwKO3c0BSK7tZxaxp
 AJDnY9/2wqqkfCZKpPnO/7jtyP8U97qRw98KLhBjhy0S1chKTWbQgIZV1IDu1quJsJmu
 L1gJJ7Hwon7IWPneLeb4q5+KiEP6Pg4EB9u0piSV4/bkaIM+CZnbGWnzuC4cPcI0Ailg
 m8q1JE5BngnX/GHpQHdCaRUfaiXiWmbiH80KEDYQuHD7EXYYASAVf8TFGt9KW+YDgsmJ
 GW5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCCwdMX0UqC6oxVwaOs4j7Fp/7WoF7tDKN2OEzbcf7fFqSRHOOpI1mw40zB1HaYOvymPHz5T5GH3YF@nongnu.org,
 AJvYcCUOyzt1swuT4RMB/LVdldV6b58GPJoM5AVVi0ubedLfiuNGrtGZ9fNQge0SWCWh9OzuuNMhnIOswu8=@nongnu.org
X-Gm-Message-State: AOJu0Yww7qNKC67Yo4g4GAA8NhCZIprwJeNxdVU8yOQ3gkCEtEYcyeqH
 tqWwXrXTc7div9l+XJPmSCKgak0g6DK6ldTyY+ts9b9nGe1RqI3O
X-Gm-Gg: ASbGnct4G66bB7F356O90jYwS0W1BdEG/PEk8giYcvoVkurBp5a1lAAf2buBhnKsmnr
 N/27BBnyNC8eS10nCh4dntXgYVeObLqzeBeiA9vC0MQPnW7n8u0JErPw+7hwWEAQGNT8Sel3Kl8
 ra/0tlVLJlA9RMIWkveJtyjN8qOeRlHhQE6gNJEgcuAg7JAr4hzvUzrjN1mUXya+yqoR0TzFYq4
 p7Yg8WHjAR4jKzrNlD3EzLP8KrqjtnpQWYb9X7ww02ccnoqrgqmJDlKZijwndrSVCYEoljS8v+0
 ow2RUzHaSKXCmcUNMflSZmSi9uIcISe+8bjCxxVCRqsupOSthsYeNUBvPIFa1FHiro+fRMFRRdW
 HTvpCHWAUoEs0ZXKNkeSR8axobCxEIyAjPZB5/Drl4iZl6fIODXHl
X-Google-Smtp-Source: AGHT+IGEKe0nmEy2saPMk1McyBLjKF6VERW7S7odocwWmUksXni0W0LHAiW4TuFQmfLAVjMgI3Purg==
X-Received: by 2002:a17:906:dc92:b0:abf:6d6e:7728 with SMTP id
 a640c23a62f3a-abf6d6e78c8mr384376966b.19.1740954604535; 
 Sun, 02 Mar 2025 14:30:04 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2f94-9100-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2f94:9100:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf76f450f6sm113773366b.114.2025.03.02.14.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Mar 2025 14:30:03 -0800 (PST)
Date: Sun, 02 Mar 2025 22:30:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <aabb2da4-3eaa-2a5f-b461-01727c380372@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <aabb2da4-3eaa-2a5f-b461-01727c380372@eik.bme.hu>
Message-ID: <24E72FE6-E2AE-4BF4-9273-1B915908EE2E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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



Am 1=2E M=C3=A4rz 2025 16:10:35 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>> This allows guests to set the CCSR base address=2E Also store and retur=
n
>> values of the local access window registers but their functionality
>> isn't implemented=2E
>
>Bernhard,

Hi Zoltan,

>
>If you have no alternative patch you plan to submit for next release shou=
ld we merge this for now? This helps running u-boot binaries even if it's n=
ot enough alone but would be one patch less in my local tree=2E Or do you k=
now about a problem with this patch why this should not be merged?

QEMU sets a machine-specific CCSR base address (pmc->ccsrbar_base) which d=
iffers from the real chip's default=2E The default is checked by U-Boot whi=
ch enters an infinite loop on mismatch: <https://source=2Edenx=2Ede/u-boot/=
u-boot/-/blob/v2024=2E07/arch/powerpc/cpu/mpc85xx/start=2ES#L614>=2E How do=
es this work for you?

In addition, when moving the CCSR region, `env->mpic_iack` should be updat=
ed as well: <https://gitlab=2Ecom/qemu-project/qemu/-/blob/v9=2E2=2E2/hw/pp=
c/e500=2Ec?ref_type=3Dtags#L969>

I'm happy to submit an implementation on top of my e500 cleanup series <ht=
tps://patchew=2Eorg/QEMU/20241103133412=2E73536-1-shentey@gmail=2Ecom/> whi=
ch needs agreement on some open discussions=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> ---
>> hw/ppc/e500-ccsr=2Eh |  4 +++
>> hw/ppc/e500=2Ec      | 79 ++++++++++++++++++++++++++++++++++++++++++++-=
-
>> 2 files changed, 80 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500-ccsr=2Eh b/hw/ppc/e500-ccsr=2Eh
>> index 249c17be3b=2E=2Ecfbf96e181 100644
>> --- a/hw/ppc/e500-ccsr=2Eh
>> +++ b/hw/ppc/e500-ccsr=2Eh
>> @@ -4,12 +4,16 @@
>> #include "hw/sysbus=2Eh"
>> #include "qom/object=2Eh"
>>=20
>> +#define NR_LAWS 12
>> +
>> struct PPCE500CCSRState {
>>     /*< private >*/
>>     SysBusDevice parent;
>>     /*< public >*/
>>=20
>>     MemoryRegion ccsr_space;
>> +
>> +    uint32_t law_regs[NR_LAWS * 2];
>> };
>>=20
>> #define TYPE_CCSR "e500-ccsr"
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 64f8c766b4=2E=2E376cb4cb37 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -43,6 +43,7 @@
>> #include "qemu/host-utils=2Eh"
>> #include "qemu/option=2Eh"
>> #include "hw/pci-host/ppce500=2Eh"
>> +#include "qemu/log=2Eh"
>> #include "qemu/error-report=2Eh"
>> #include "hw/platform-bus=2Eh"
>> #include "hw/net/fsl_etsec/etsec=2Eh"
>> @@ -1331,11 +1332,83 @@ void ppce500_init(MachineState *machine)
>>     boot_info->dt_size =3D dt_size;
>> }
>>=20
>> +static int law_idx(hwaddr addr)
>> +{
>> +    int idx;
>> +
>> +    addr -=3D 0xc08;
>> +    idx =3D 2 * ((addr >> 5) & 0xf);
>> +    if (addr & 8) {
>> +        idx++;
>> +    }
>> +    assert(idx < 2 * NR_LAWS);
>> +    return idx;
>> +}
>> +
>> +static uint64_t law_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    PPCE500CCSRState *s =3D opaque;
>> +    uint64_t val =3D 0;
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        val =3D s->ccsr_space=2Eaddr >> 12;
>> +        break;
>> +    case 0xc08 =2E=2E=2E 0xd70:
>> +        val =3D s->law_regs[law_idx(addr)];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register =
read"
>> +                      "0x%" HWADDR_PRIx "\n", addr);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void law_write(void *opaque, hwaddr addr, uint64_t val, unsigne=
d size)
>> +{
>> +    PPCE500CCSRState *s =3D opaque;
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        val &=3D 0xffff00;
>> +        memory_region_set_address(&s->ccsr_space, val << 12);
>> +        break;
>> +    case 0xc08 =2E=2E=2E 0xd70:
>> +    {
>> +        int idx =3D law_idx(addr);
>> +
>> +        qemu_log_mask(LOG_UNIMP, "Unimplemented local access register =
write"
>> +                      "0x%" HWADDR_PRIx " <- 0x%" PRIx64 "\n", addr, v=
al);
>> +        val &=3D (idx & 1) ? 0x80f0003f : 0xffffff;
>> +        s->law_regs[idx] =3D val;
>> +        break;
>> +    }
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register =
write"
>> +                      "0x%" HWADDR_PRIx "\n", addr);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps law_ops =3D {
>> +    =2Eread =3D law_read,
>> +    =2Ewrite =3D law_write,
>> +    =2Eendianness =3D DEVICE_BIG_ENDIAN,
>> +    =2Evalid =3D {
>> +        =2Emin_access_size =3D 4,
>> +        =2Emax_access_size =3D 4,
>> +    },
>> +};
>> +
>> static void e500_ccsr_initfn(Object *obj)
>> {
>> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>> -                       MPC8544_CCSRBAR_SIZE);
>> +    PPCE500CCSRState *s =3D CCSR(obj);
>> +    MemoryRegion *mr;
>> +
>> +    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC8544_CCSRB=
AR_SIZE);
>> +
>> +    mr =3D g_new(MemoryRegion, 1);
>> +    memory_region_init_io(mr, obj, &law_ops, s, "local-access", 4096);
>> +    memory_region_add_subregion(&s->ccsr_space, 0, mr);
>> }
>>=20
>> static const TypeInfo e500_ccsr_info =3D {
>>=20

