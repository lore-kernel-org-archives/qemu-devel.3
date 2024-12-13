Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D348E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9RX-0008SK-0V; Fri, 13 Dec 2024 12:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tM9RS-0008Pz-Uy; Fri, 13 Dec 2024 12:27:08 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tM9RM-0007nA-2C; Fri, 13 Dec 2024 12:27:06 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so3532394a12.3; 
 Fri, 13 Dec 2024 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734110815; x=1734715615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZAdsWK52VAb8fudDg9PRQ5VSPYseUmnxkNdC1pBytY=;
 b=cgPvUz3jP9IkmLGtyPwRd33/1+4LayXwEOshMnkSQ8/qf427S63KKunQoRLH/bLns9
 bzKEO9Rl6u3gpQiXEDl/do58Hz0Mxs7vAc1OCzkhN0P2SVhttDmg3sk6NkQBBrZEcTR5
 GrZZy3w6A3OkFNBa+2wCVG/C2IFVmSZVnmq79kE1p/t8U4WK+l+HJL/FBrL/rgZ3M0fK
 IC3FVoNsXhcx7Wfb2ZMT35angcx/Hk62apmzZoQiUhrr/Rf+vRKM0vqe0fh9yX3jNQPX
 Uj3qDDXJ48HRLRLdVxcfD1BfOSqgq/olndQ+pNV3CzVGo7s1V6zqG+s9ogZtdiaeogfQ
 AkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110815; x=1734715615;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZAdsWK52VAb8fudDg9PRQ5VSPYseUmnxkNdC1pBytY=;
 b=im6FRDFZolFlljd+GVxsFol1fWyQdNhwhZ7yrf8q7EINoN7BZFLvZ8mceS99Lto6fO
 VYY0BOo8PlB7sQnmCyLOknORohwl+DLTMRAvPGOkV8AUMCrRT+7QUFjGYYAkaH9WM/Jq
 +IDdW254Et/lV037fsEywLpXqaWoYJb8DWmMQsvhdWU9BEOLovAiX7Q1l7DZFuMP1Yc0
 BQaYkzewBIid0QLyjMSOZ/TNWlQXBuHjY+llilnCxZ8tQv0bE+f4uO91jrpo2oDKSgc7
 eptwZlFezluWt5qBBkechv/7USd3hUJFuCmQYZ34giFbuF36+GSs9Gv2Bxv0WDfnfCSl
 cEVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfS7TBP3xiZOIp8OuvqOpZh6H6kdrUa+Zg6c5qCD6tbYs0IU33Ia0zXhhIduu+uJ5WgppsEQI1eHCJfg==@nongnu.org,
 AJvYcCVCH6a7cg4S9Evjk2kjD+MqAfLUL0uv3W7kxn6EqI63nedCCEMgU2VUmkaLtb0g6e5DJKP6SUdQiQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy2ksfLyFINcrxWspimVoqE79wrharlh+1uIV0k7mkNM6toE1/G
 Enyq+EkzV/sy8GCDJ5s0rKfiXdKg0/fcxYY7b1+XnLTs5RzDX7Dg
X-Gm-Gg: ASbGncsRe9tQ0afhJiftpD3PIXvN6ZP2FjAe7BLEpMr5ZB8507Wi5AT/xPttxerJeFZ
 B6qWRgWSEvp7HN6T1LOEcnCmHwbxUdAIdXGDQS+UkBaIAVxj6al2xQYBhk2H8bbmqKkgE/zQ1UP
 nN8/LUPzV4YdqCQLBv8AHBN4OY+Ut3QX0w+OjnwBmAk7JEewh0m/kCf7asxEckpmdZsYjdGA9wE
 /CnfKD0xVyapMmIcZcN9FzL7oqWFZuh1qo3+d6BTPaC96+lQ1kyQ6Rq4UKpNiYnmTbfx+MAFO8P
 IDAodHRT2l7cB6hRpkvgDqG2aGY5/9I=
X-Google-Smtp-Source: AGHT+IFuaPKsYeud5IDSK7rt1B38SIlmppDIe43Li8rTuFFkhboRnnBTdzPI60LNTM1KigaR471KkQ==
X-Received: by 2002:a17:907:6d12:b0:aa6:8096:2048 with SMTP id
 a640c23a62f3a-aab7790a02dmr347318266b.17.1734110815242; 
 Fri, 13 Dec 2024 09:26:55 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-249-001.77.183.pool.telefonica.de.
 [77.183.249.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa65d18510asm950478766b.122.2024.12.13.09.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 09:26:54 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] hw/ide/ahci: Decouple from PCI
In-Reply-To: <b87473d2-d132-42a4-8ca3-aaace8da7bf9@linaro.org>
References: <20241212110926.23548-1-shentey@gmail.com>
 <20241212110926.23548-2-shentey@gmail.com>
 <b87473d2-d132-42a4-8ca3-aaace8da7bf9@linaro.org>
Message-ID: <F723466D-FB22-485A-936E-1C4AAEEFF05E@gmail.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 13=2E Dezember 2024 14:41:46 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>On 12/12/24 12:09, Bernhard Beschow wrote:
>> In some adhoc profiling booting Linux VMs, it's observed that ahci_irq_=
lower()
>> can be a hot path (10000+ triggers until login prompt appears)=2E Even =
though the
>> parent device never changes, this method re-determines whether the pare=
nt device
>> is a PCI device or not using the rather expensive object_dynamic_cast()
>> function=2E Avoid this overhead by pushing the interrupt handling to th=
e parent
>> device, essentially turning AHCIState into an "IP block"=2E
>>=20
>> Note that this change also frees AHCIState from the PCI dependency whic=
h wasn't
>> reflected in Kconfig=2E
>>=20
>> Reported-by: Peter Xu <peterx@redhat=2Ecom>
>> Inspired-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/ide/ahci-internal=2Eh    |  1 -
>>   include/hw/ide/ahci-pci=2Eh |  2 ++
>>   include/hw/ide/ahci=2Eh     |  2 --
>>   hw/ide/ahci=2Ec             | 39 ++++--------------------------------=
---
>>   hw/ide/ich=2Ec              | 19 +++++++++++++++----
>>   5 files changed, 21 insertions(+), 42 deletions(-)
>
>
>>   static void pci_ich9_reset(DeviceState *dev)
>>   {
>>       AHCIPCIState *d =3D ICH9_AHCI(dev);
>> @@ -102,7 +114,9 @@ static void pci_ich9_ahci_init(Object *obj)
>>   {
>>       AHCIPCIState *d =3D ICH9_AHCI(obj);
>>   +    qemu_init_irq(&d->irq, pci_ich9_ahci_update_irq, d, 0);
>>       ahci_init(&d->ahci, DEVICE(obj));
>> +    d->ahci=2Eirq =3D &d->irq;
>
>Pre-existing, but we shouldn't set this directly=2E
>Does the IRQState belong to AHCIState?

AHCIState isn't an Object, and therefore can't have any properties, so we =
can only set it directly=2E In the SysBus devices, d->ahci=2Eirq is treated=
 with sysbus_init_irq(), so needs to stay a pointer=2E

I tried to convert AHCIState into a SysBusDevice in order to access it via=
 these APIs, but that would create migration compatibility problems for the=
 q35 machine which was a rabbit hole I didn't want to get into=2E So I sett=
led on this solution=2E Any better proposals?

Best regards,
Bernhard

>
>>   }
>>     static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>> @@ -125,8 +139,6 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, E=
rror **errp)
>>       /* XXX Software should program this register */
>>       dev->config[0x90]   =3D 1 << 6; /* Address Map Register - AHCI mo=
de */
>>   -    d->ahci=2Eirq =3D pci_allocate_irq(dev);
>> -
>>       pci_register_bar(dev, ICH9_IDP_BAR, PCI_BASE_ADDRESS_SPACE_IO,
>>                        &d->ahci=2Eidp);
>>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY=
,
>> @@ -161,7 +173,6 @@ static void pci_ich9_uninit(PCIDevice *dev)
>>         msi_uninit(dev);
>>       ahci_uninit(&d->ahci);
>> -    qemu_free_irq(d->ahci=2Eirq);
>>   }
>>     static void ich_ahci_class_init(ObjectClass *klass, void *data)
>

