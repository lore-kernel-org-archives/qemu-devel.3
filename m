Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E72CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjg9-0006qQ-BX; Mon, 07 Oct 2024 05:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxjg8-0006pu-6W; Mon, 07 Oct 2024 05:05:20 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxjg3-0001Q9-BQ; Mon, 07 Oct 2024 05:05:19 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5398e53ca28so4479200e87.3; 
 Mon, 07 Oct 2024 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728291912; x=1728896712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sZfaH5BnGfDJJ4QQ2EcrNlYEUSfgzh644aQ3HVn2wY=;
 b=TYnHB9rhXjB0M690hurAOg31NlKHVWT7wLL3T3MT//+3xEgwqOrKC9yDGYUHY5BRdZ
 tsUFmdEEBvonXVW6mNgQtZOBB4zGYR+SEJGEAyDpXxvtQoha1WRwnPrtwSzf9fNGYDe2
 YmlM1TkInMUuDjp47hiX1RTijwv3p4wSuK2yxlLa86WU/5mc3m0nEukBdsoYQIk7VdIc
 BCj1MtYJEwCdDNa3u4qf2+jnKbk2JYS5L1CLDg5wkMVkrQdVmNIt9UhnS3BFyewYW3lk
 092DMVm3uhLU6U3iNnUd1ve04dN2DBpuimzRHO2sqvNrzcnPJ684Ut86POOvYp4ogcc2
 0LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728291912; x=1728896712;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sZfaH5BnGfDJJ4QQ2EcrNlYEUSfgzh644aQ3HVn2wY=;
 b=uMVFlWEfXO8bdbwEDXjs2xBdzlwxyES4wGPox+8kzdbX7pIM5ljUBT0I9c/tbq+qMJ
 UZZw8jcEiyJHqePKDUgh/vp5tQL2+/jHeCGCLEYxBIJWWuJLxno4w+7iln2V0zqkTuN8
 HCy1tpFkucUY/ljTgbNDWg8hM9NZrc7UmYZwxoIakrH+tBpbM19KkSFaxZakfamNxLGZ
 mDDWpT0RkAGrZd/TbBojCjsVgBjcwzKo+kzVJrlQBPiM1pswvvEal03cP0BrulHdgxri
 yI7hYEQE17IJ8Cxj9DzeKbrxM/PPTzE/FhmXY4TzcK0LCwFzKhQHVFkK1AnzV7Ymnq1C
 umzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWEJVgbyPU+2J7n0X6ix6OhmqoC2Y6Wm/0pnOZ2exo6u6pYg9Rb8KtyKkGQeYayOzLftwOE9LbUI=@nongnu.org,
 AJvYcCWYH/PTIZD6vqGc/891YF+imH1QihHwgGXkJZAX+rglTIhyKPPbnSoWxTPF9ax+I9wuRgi5mRtF7t6m@nongnu.org
X-Gm-Message-State: AOJu0YxSZjsyp3AoOrHYR2xRVJltQ0orpb6VJi0AiRR1UUse1u6E413s
 o6bFnIxPV4DHqlw31Dt0Tw6RrC8ZLc7yPSGnYzcMdVN4240vLy1/
X-Google-Smtp-Source: AGHT+IGZz8b6OCdt8Sw8zPTOMQeSJfWvm/OhHtCedHPv7IJTGW2y6QicjW67fiZmo0+25h28/kH6rg==
X-Received: by 2002:a05:6512:3d21:b0:530:daaa:271c with SMTP id
 2adb3069b0e04-539ab876c8fmr5302611e87.16.1728291912153; 
 Mon, 07 Oct 2024 02:05:12 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05c119esm3090521a12.55.2024.10.07.02.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:05:11 -0700 (PDT)
Date: Mon, 07 Oct 2024 08:36:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 01/23] hw/ppc/e500: Do not leak struct boot_info
In-Reply-To: <631e016f-730f-7b2d-2ab0-49ce767e5e37@eik.bme.hu>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-2-shentey@gmail.com>
 <631e016f-730f-7b2d-2ab0-49ce767e5e37@eik.bme.hu>
Message-ID: <12B37C28-31F3-4DE5-93A3-7903FB7C9750@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x129.google.com
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



Am 6=2E Oktober 2024 16:56:52 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Sat, 5 Oct 2024, Bernhard Beschow wrote:
>> The struct is allocated once with g_new0() but never free()'d=2E Fix th=
e leakage
>> by adding an attribute to struct PPCE500MachineState which avoids the
>> allocation=2E
>>=20
>> While at it remove the obsolete /*< private >*/ markers=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/e500=2Eh |  9 +++++++--
>> hw/ppc/e500=2Ec | 17 ++++-------------
>> 2 files changed, 11 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>> index 8c09ef92e4=2E=2E5654bb7907 100644
>> --- a/hw/ppc/e500=2Eh
>> +++ b/hw/ppc/e500=2Eh
>> @@ -5,18 +5,23 @@
>> #include "hw/platform-bus=2Eh"
>> #include "qom/object=2Eh"
>>=20
>> +typedef struct boot_info {
>> +    uint32_t dt_base;
>> +    uint32_t dt_size;
>> +    uint32_t entry;
>> +} boot_info;
>> +
>
>You either don't need a typedef or don't need a struct name=2E Since codi=
ng style says typedefs should be camel case but other machines don't use a =
typedef it's probably simplest to drop the typedef and define the machine s=
tate field as struct boot_info below for consistency with other similar str=
ucts=2E Otherwise you'd have to come up with some camel case type name here=
 but that would be less consistent with other machines=2E So I'd go without=
 the typedef=2E

Indeed, not sure why I added the typedef=2E I'll omit the typedef then=2E

This code hasn't changed since v1, so it would have been nice to have caug=
ht that in the first round to avoid another spin=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> struct PPCE500MachineState {
>> -    /*< private >*/
>>     MachineState parent_obj;
>>=20
>>     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>>      * board supports dynamic sysbus devices
>>      */
>>     PlatformBusDevice *pbus_dev;
>> +    boot_info boot_info;
>> };
>>=20
>> struct PPCE500MachineClass {
>> -    /*< private >*/
>>     MachineClass parent_class;
>>=20
>>     /* required -- must at least add toplevel board compatible */
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 3bd12b54ab=2E=2E75b051009f 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -80,13 +80,6 @@
>>=20
>> #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>>=20
>> -struct boot_info
>> -{
>> -    uint32_t dt_base;
>> -    uint32_t dt_size;
>> -    uint32_t entry;
>> -};
>> -
>> static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slo=
t,
>>                                 int nr_slots, int *len)
>> {
>> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>>     bool kernel_as_payload;
>>     hwaddr bios_entry =3D 0;
>>     target_long payload_size;
>> -    struct boot_info *boot_info =3D NULL;
>>     int dt_size;
>>     int i;
>>     unsigned int smp_cpus =3D machine->smp=2Ecpus;
>> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>>         /* Register reset handler */
>>         if (!i) {
>>             /* Primary CPU */
>> -            boot_info =3D g_new0(struct boot_info, 1);
>>             qemu_register_reset(ppce500_cpu_reset, cpu);
>> -            env->load_info =3D boot_info;
>> +            env->load_info =3D &pms->boot_info;
>>         } else {
>>             /* Secondary CPUs */
>>             qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>>     }
>>     assert(dt_size < DTB_MAX_SIZE);
>>=20
>> -    boot_info->entry =3D bios_entry;
>> -    boot_info->dt_base =3D dt_base;
>> -    boot_info->dt_size =3D dt_size;
>> +    pms->boot_info=2Eentry =3D bios_entry;
>> +    pms->boot_info=2Edt_base =3D dt_base;
>> +    pms->boot_info=2Edt_size =3D dt_size;
>> }
>>=20
>> static void e500_ccsr_initfn(Object *obj)
>>=20

