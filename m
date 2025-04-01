Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91242C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbeR-0007ZH-Ut; Tue, 01 Apr 2025 09:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbeO-0007Yc-5w
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:27:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbeJ-000417-0w
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:27:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22928d629faso67985965ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514044; x=1744118844; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBk/iiT5Xk0T7ocQ8xWo0zlHZpDCmcGhiDAIpAL9qYw=;
 b=CLm2snM4rni00IwdanmzBhkfwZMbx5HAEadfBt2TJ0q7os4LbZg9gdHfIFTOEbTmZG
 qjpm3j4+mRLCBqOtr4GnFHigAhud/Rgh4CwYjDRHOfl+kgwmDllC5JV+hvVa2cxUdrX4
 WZUr0aIAEtUzhrDbMoKq+iSxE+eg4ViNDTydxHXNBxYGxNUzd4LkM5W31QyojWgBW4CN
 vlnX0L932t9EY8MLpQUUz4PlFldhZJKoCIKgWOS15o8ieB/CYS5grucK7tURdr7+IGMa
 BDkmXGDhxfzjEAdY8B/hszAbUKTDDLixGA51a8NQKbawYtQFJzWSefeLldv2eHs3zIzD
 EQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514044; x=1744118844;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vBk/iiT5Xk0T7ocQ8xWo0zlHZpDCmcGhiDAIpAL9qYw=;
 b=cWlXj0PuX/bSO61pmCty1ZmNkQ3Gr8vXplKqpMrowd7MFwO9hUHFA5OrhUPPWwHt+u
 H+SJptqV1auMNZbNRS9zwmz7/oPhBnXVz4EcT7kw1ljV1MAjuZi8lOLvopHdPr3izWQP
 Yejm+YVcne9sUEYbsirBWgvUdxgg8GWaKqzOjJrVxOyjxX3KTMqZMTdHrGwzrrXkfI6d
 fU2ecplQ1wDll3GO0b/GN6DDcOVzxVazWd/r8/sTSgG8KWZBAZSWdtJCwDXSUJtVvND1
 3HX4uYHxzVRcNTQR80bx6IIw6tcXoj8zr8cmM9wbixE4aw8sI8eF3GaTqseYOWAW6dA7
 GwXw==
X-Gm-Message-State: AOJu0Yzeb+GytLEmRvWsRhQd7p+2KxToAxTeA755ZMeWXP+83ccPCl1U
 0p2xswA9AEfCOtbT6Tgtjo0ysEwP4VmkD6syGsnSYTBP57sBkW5N
X-Gm-Gg: ASbGnctfjzmGsXDLXVOVBEAfZUYZq6TSJEqiPkpTVrujmAQfD9Xk+kCHhe+bamMvIh9
 5loUIS2lJ3ZDzPlNMFqNM5OD9GwUBOEE5s1m7tVEzxyz9lLl9fJ7syEFnFgbrOdN5fIGgEi1CVk
 Eipm7MwZjk5/um7QbMObRxEA0+DcMrhsOaRL60Rg8Z2ScanQDRGRvlOaS9qqxgbCKqGFJqeyo+J
 xNtMSf7TZi2Yh9IdU1sFRdKv1ArepLQdcrQQiG6DtvyG7GX+t8hpFN1arBCLAtO8d7VJvUiwu4r
 XhH+TA4jCwACVJRaplnnPyGERYgtT9CuvKTcch8=
X-Google-Smtp-Source: AGHT+IGIirnyVD8t0OB7AEXFYmPcotAigGn4ra6u1pp3t5H64fxRygALt6a1XdytGIvi9hOa1u5jtA==
X-Received: by 2002:a17:902:f709:b0:223:3b76:4e22 with SMTP id
 d9443c01a7336-2292f949db4mr175175945ad.6.1743514043909; 
 Tue, 01 Apr 2025 06:27:23 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cdfb0sm87459895ad.142.2025.04.01.06.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:27:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 23:27:18 +1000
Message-Id: <D8VC57XK27CZ.1W6DLSB9MBN1D@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Corey
 Minyard" <minyard@acm.org>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-3-npiggin@gmail.com>
 <b0842a9c-dac4-4433-b69a-054ac65d8735@linaro.org>
In-Reply-To: <b0842a9c-dac4-4433-b69a-054ac65d8735@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Tue Apr 1, 2025 at 9:57 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Nick,
>
> On 1/4/25 13:44, Nicholas Piggin wrote:
>> This requires some adjustments to callers to avoid possible behaviour
>> changes for PCI devices.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/hw/ipmi/ipmi.h     |  5 +++++
>>   hw/acpi/ipmi.c             |  2 +-
>>   hw/ipmi/isa_ipmi_bt.c      |  1 +
>>   hw/ipmi/isa_ipmi_kcs.c     |  1 +
>>   hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>>   hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>>   hw/smbios/smbios_type_38.c |  6 +++++-
>>   7 files changed, 36 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>> index 77a7213ed93..71c4efac8cd 100644
>> --- a/include/hw/ipmi/ipmi.h
>> +++ b/include/hw/ipmi/ipmi.h
>> @@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
>>       } memspace;
>>  =20
>>       int interrupt_number;
>> +    enum {
>> +        IPMI_NO_IRQ =3D 0,
>> +        IPMI_ISA_IRQ,
>> +        IPMI_PCI_IRQ,
>> +    } irq;
>>       enum {
>>           IPMI_LEVEL_IRQ,
>>           IPMI_EDGE_IRQ
>> diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
>> index a20e57d465c..c81cbd2f158 100644
>> --- a/hw/acpi/ipmi.c
>> +++ b/hw/acpi/ipmi.c
>> @@ -55,7 +55,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
>>           abort();
>>       }
>>  =20
>> -    if (info->interrupt_number) {
>> +    if (info->irq =3D=3D IPMI_ISA_IRQ && info->interrupt_number) {
>>           aml_append(crs, aml_irq_no_flags(info->interrupt_number));
>>       }
>>  =20
>> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
>> index a1b66d5ee82..b5556436b82 100644
>> --- a/hw/ipmi/isa_ipmi_bt.c
>> +++ b/hw/ipmi/isa_ipmi_bt.c
>> @@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterfac=
e *ii, IPMIFwInfo *info)
>>       ISAIPMIBTDevice *iib =3D ISA_IPMI_BT(ii);
>>  =20
>>       ipmi_bt_get_fwinfo(&iib->bt, info);
>> +    info->irq =3D IPMI_ISA_IRQ;
>>       info->interrupt_number =3D iib->isairq;
>>       info->i2c_slave_address =3D iib->bt.bmc->slave_addr;
>>       info->uuid =3D iib->uuid;
>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>> index d9ebdd5371f..326115f51bb 100644
>> --- a/hw/ipmi/isa_ipmi_kcs.c
>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>> @@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii,=
 IPMIFwInfo *info)
>>       ISAIPMIKCSDevice *iik =3D ISA_IPMI_KCS(ii);
>>  =20
>>       ipmi_kcs_get_fwinfo(&iik->kcs, info);
>> +    info->irq =3D IPMI_ISA_IRQ;
>>       info->interrupt_number =3D iik->isairq;
>>       info->uuid =3D iik->uuid;
>>   }
>> diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
>> index a3b742d22c9..33ff7190ee8 100644
>> --- a/hw/ipmi/pci_ipmi_bt.c
>> +++ b/hw/ipmi/pci_ipmi_bt.c
>> @@ -38,6 +38,17 @@ struct PCIIPMIBTDevice {
>>       uint32_t uuid;
>>   };
>>  =20
>> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo=
 *info)
>> +{
>> +    PCIIPMIBTDevice *pib =3D PCI_IPMI_BT(ii);
>> +
>> +    ipmi_bt_get_fwinfo(&pib->bt, info);
>> +    info->irq =3D IPMI_PCI_IRQ;
>> +    info->interrupt_number =3D pci_intx(&pib->dev);
>> +    info->i2c_slave_address =3D pib->bt.bmc->slave_addr;
>> +    info->uuid =3D pib->uuid;
>> +}
>> +
>>   static void pci_ipmi_raise_irq(IPMIBT *ib)
>>   {
>>       PCIIPMIBTDevice *pib =3D ib->opaque;
>> @@ -125,6 +136,7 @@ static void pci_ipmi_bt_class_init(ObjectClass *oc, =
void *data)
>>  =20
>>       iic->get_backend_data =3D pci_ipmi_bt_get_backend_data;
>>       ipmi_bt_class_init(iic);
>> +    iic->get_fwinfo =3D pci_ipmi_bt_get_fwinfo;
>>   }
>>  =20
>>   static const TypeInfo pci_ipmi_bt_info =3D {
>> diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
>> index 05ba97ec58f..6673b2088ef 100644
>> --- a/hw/ipmi/pci_ipmi_kcs.c
>> +++ b/hw/ipmi/pci_ipmi_kcs.c
>> @@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
>>       uint32_t uuid;
>>   };
>>  =20
>> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo=
 *info)
>> +{
>> +    PCIIPMIKCSDevice *pik =3D PCI_IPMI_KCS(ii);
>> +
>> +    ipmi_kcs_get_fwinfo(&pik->kcs, info);
>> +    info->irq =3D IPMI_PCI_IRQ;
>> +    info->interrupt_number =3D pci_intx(&pik->dev);
>> +    info->uuid =3D pik->uuid;
>> +}
>> +
>>   static void pci_ipmi_raise_irq(IPMIKCS *ik)
>>   {
>>       PCIIPMIKCSDevice *pik =3D ik->opaque;
>> @@ -125,6 +135,7 @@ static void pci_ipmi_kcs_class_init(ObjectClass *oc,=
 void *data)
>>  =20
>>       iic->get_backend_data =3D pci_ipmi_kcs_get_backend_data;
>>       ipmi_kcs_class_init(iic);
>> +    iic->get_fwinfo =3D pci_ipmi_kcs_get_fwinfo;
>>   }
>>  =20
>>   static const TypeInfo pci_ipmi_kcs_info =3D {
>> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
>> index 168b886647d..2823929c258 100644
>> --- a/hw/smbios/smbios_type_38.c
>> +++ b/hw/smbios/smbios_type_38.c
>> @@ -72,7 +72,11 @@ static void smbios_build_one_type_38(IPMIFwInfo *info=
)
>>                        " SMBIOS, ignoring this entry.", info->register_s=
pacing);
>>           return;
>>       }
>> -    t->interrupt_number =3D info->interrupt_number;
>> +    if (info->irq =3D=3D IPMI_ISA_IRQ) {
>> +        t->interrupt_number =3D info->interrupt_number;
>> +    } else {
>> +        t->interrupt_number =3D 0;
>
> Can you explain why use 0 for PCI?

To avoid changes to other callers after this patch. Previously PCI
devices would leave interrupt_number as 0, not sure if such devices
are relevant here. If there is a better approach I would take it.

Thanks,
Nick

