Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C6CDD1CE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 16:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEHn-00070Y-Jn; Fri, 27 Sep 2024 12:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1suEHi-0006ze-TV; Fri, 27 Sep 2024 12:57:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1suEHh-0007hj-85; Fri, 27 Sep 2024 12:57:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c883459b19so1064569a12.2; 
 Fri, 27 Sep 2024 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727456253; x=1728061053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vK+Y0UFrgOHQPGAIF3oL4mkheZGyZxE24+7YL4Cm35o=;
 b=MDazSDWMpMKT7tBrYURW+mN7XufMMVcedNsqZ8EGFZeV/DTQGXdB3hlxhFVGo4YuGb
 AsqM1yhV1y/RGKZbRs2fMzz+1GAxk6vkdSjeX4WaO10XuFlx75ALN9kx74RVw+SZ29i1
 lYtNZYsfyxlnXdeMvjxcFErnZefwPLOZuHb4IXO4E/1R+iw1vA/lrlSv8mZsjXFpOukY
 Q6W5ZHlaiMlMln+1p6NddFHHNCodNk3ByJQxafVMRmsWM6x+/FOm1n4wYxep9iV7C2PZ
 R2SuyGI/0D1GlxzQfPQ9jGbivI4nadnWR3a7yYN6mC3/9YjLlTKgqYYcG3qGRCJE29cS
 mDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727456253; x=1728061053;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vK+Y0UFrgOHQPGAIF3oL4mkheZGyZxE24+7YL4Cm35o=;
 b=rPsFD2yOsKZIudi4+VTAxRVa3XwNlyJF1Effuh07qReZ5xiaWXPty8CPzoVaYCo7sz
 ctHCUZ5FPJA2AAQ9xSNuB+J2pFUktHclt5/0lxPkKrDSOXMETz3B5p7av3Jbhahy/lWx
 ea9zfQJ2+JtDAlmFesOgyVcBAfHQJy018NG2NtlAyrCWnLif4w7Di6jPMkmZD6b4JSer
 aFAX5uMyveJpLGbONtrUUavW0a+nlnBcKmlU3yJNikNxuTIOWEh8M+i0W5C4tuR9k2pt
 MddDReN0Pz9So14V/ArdvinZ2VkqfhdUTKKc6imiu1l3Ah5XP2BSeeBK/+4LKFTiZKFT
 LpYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTg76vLFPoxKhobM1jbcBk83nOz9HDa2xGzmuiMlOXBisaJqDIBQckGz6JeRDIhpAu+D6suoghnyw=@nongnu.org,
 AJvYcCVRRUzPOHwa02axmOYIPmR6eG05hEOYruJy98Km5aa2fvqXIC8Uak30x3nECVPYv1Jp8TcZ+iq4aTuy@nongnu.org
X-Gm-Message-State: AOJu0YyeASigrpS9yrKMGHPfH7MqJ1QwaU4QLx21pbgrDH9L7tfUaZ2W
 N5Z2mAcsmPrZzA+TJvCLupIYJYf6GUSH+KnWT+YdbqkleIYiTc5/
X-Google-Smtp-Source: AGHT+IEB1edEU6aV/uChw21vWG8srO87IB/0EE+NqM2Bo/e+jW3LE9VRBQNVx8uKIhJWU/RxpICYBw==
X-Received: by 2002:a05:6402:158e:b0:5be:d7d8:49ad with SMTP id
 4fb4d7f45d1cf-5c8825fcb70mr3031587a12.22.1727456252979; 
 Fri, 27 Sep 2024 09:57:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-188-044-253.77.188.pool.telefonica.de.
 [77.188.44.253]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88240a8e9sm1349097a12.36.2024.09.27.09.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 09:57:32 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:57:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_06/23=5D_hw/ppc/e500=3A_Use_SysBusDevic?=
 =?US-ASCII?Q?e_API_to_access_TYPE=5FCCSR=27s_internal_resources?=
In-Reply-To: <d563d5ea-f644-6cce-560b-a62c222e398c@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-7-shentey@gmail.com>
 <d563d5ea-f644-6cce-560b-a62c222e398c@eik.bme.hu>
Message-ID: <0CD27B53-BE80-436B-BBDB-13AD51EE72FD@gmail.com>
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



Am 23=2E September 2024 10:28:35 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> Rather than accessing the attributes of TYPE_CCSR directly, use the Sys=
BusDevice
>> API which exists exactly for that purpose=2E Furthermore, registering t=
he memory
>> region with the SysBusDevice API makes it show up in QMP's `info qom-tr=
ee`
>> command=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/pci-host/ppce500=2Ec | 10 +++++-----
>> hw/ppc/e500=2Ec         |  8 ++++----
>> 2 files changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/hw/pci-host/ppce500=2Ec b/hw/pci-host/ppce500=2Ec
>> index 95b983b2b3=2E=2E97e5d47cec 100644
>> --- a/hw/pci-host/ppce500=2Ec
>> +++ b/hw/pci-host/ppce500=2Ec
>> @@ -16,7 +16,6 @@
>>=20
>> #include "qemu/osdep=2Eh"
>> #include "hw/irq=2Eh"
>> -#include "hw/ppc/e500-ccsr=2Eh"
>> #include "hw/qdev-properties=2Eh"
>> #include "migration/vmstate=2Eh"
>> #include "hw/pci/pci_device=2Eh"
>> @@ -419,11 +418,12 @@ static const VMStateDescription vmstate_ppce500_p=
ci =3D {
>> static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
>> {
>>     PPCE500PCIBridgeState *b =3D PPC_E500_PCI_BRIDGE(d);
>> -    PPCE500CCSRState *ccsr =3D CCSR(container_get(qdev_get_machine(),
>> -                                  "/e500-ccsr"));
>> +    SysBusDevice *ccsr =3D SYS_BUS_DEVICE(container_get(qdev_get_machi=
ne(),
>> +                                                      "/e500-ccsr"));
>> +    MemoryRegion *ccsr_space =3D sysbus_mmio_get_region(ccsr, 0);
>>=20
>> -    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", =
&ccsr->ccsr_space,
>> -                             0, int128_get64(ccsr->ccsr_space=2Esize))=
;
>> +    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
>> +                             ccsr_space, 0, int128_get64(ccsr_space->s=
ize));
>
>I wonder if this really needs an alias or could the original memory regio=
n be registered as the PCI BAR region? Otherwise:

This hits an assertion when running Buildroot's qemu_ppc64_e5500_defconfig=
=2E Therefore I'll keep the alias=2E

Best regards,
Bernhard

>
>Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>
>Regards,
>BALATON Zoltan
>
>>     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
>> }
>>=20
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index e2a4f265a5=2E=2E2225533e33 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -924,7 +924,6 @@ void ppce500_init(MachineState *machine)
>>     DriveInfo *dinfo;
>>     MemoryRegion *ccsr_addr_space;
>>     SysBusDevice *s;
>> -    PPCE500CCSRState *ccsr;
>>     I2CBus *i2c;
>>=20
>>     irqs =3D g_new0(IrqLines, smp_cpus);
>> @@ -980,10 +979,10 @@ void ppce500_init(MachineState *machine)
>>     memory_region_add_subregion(address_space_mem, 0, machine->ram);
>>=20
>>     dev =3D qdev_new("e500-ccsr");
>> +    s =3D SYS_BUS_DEVICE(dev);
>>     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev)=
);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> -    ccsr =3D CCSR(dev);
>> -    ccsr_addr_space =3D &ccsr->ccsr_space;
>> +    sysbus_realize_and_unref(s, &error_fatal);
>> +    ccsr_addr_space =3D sysbus_mmio_get_region(s, 0);
>>     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
>>                                 ccsr_addr_space);
>>=20
>> @@ -1270,6 +1269,7 @@ static void e500_ccsr_initfn(Object *obj)
>>     PPCE500CCSRState *ccsr =3D CCSR(obj);
>>     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>>                        MPC8544_CCSRBAR_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>> }
>>=20
>> static const TypeInfo e500_ccsr_info =3D {
>>=20

