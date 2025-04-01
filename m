Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55241C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd1T-0002MA-VF; Tue, 01 Apr 2025 10:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzd1R-0002Ld-KV
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:55:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzd1P-0001xf-K6
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:55:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so5043598f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519321; x=1744124121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/v6av2c5ZeAr/TtPiOGClVJAp7oQh5/1ysF0gu629U=;
 b=zj1XEA1cO18XJhU8damJcftQkl/0uqWLZBvrKzsQDx3MnoJlaVknYlhDaLzIfZKdYR
 Xhka4BDTFFPgm29tm+nGd6iuUJzJPTursF6/eihqnKJQ406DlKQv3etVLUPCXRwL9Eyz
 4Qu25OfuB8BwN4jBPR2wMtYwVXpUnWbxJtDsV7w8bGQ3tIfXYQIQ9NpWg3e1QH0U0l7Q
 z/FruzZiukQQADajBIJ+JKsW/HLs01kUebwV21xj703Oto1pvCML7PcNVMyuS9ggc+3s
 eSljyoEKIujRj59ZGtxvPCAe4ZILpOMO/1uNH/hbRD3o85SZQdYurHLNs5LiGe+a3nit
 EsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519321; x=1744124121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/v6av2c5ZeAr/TtPiOGClVJAp7oQh5/1ysF0gu629U=;
 b=oOuTVnJCVLjUS6bObgsXnF1lYnvYiV0j4Wx/ovzNDsoVyHYuhrwTDkqZyUxDWKuGx8
 BkLRduP6jFJ9RYd3FBgj55F4+5RnmMr5IGuoEhV+7pWha9Ou5GL3lXevAaN+CmFAARkG
 jx4AsPSpNl1GwpUqsDPU1P4GPilwBn30qsZl19SEgVTNEO986voCNoMkKv4egJe2Frv2
 azyaPy+k4pUOtpwVsaecKRM+IaFDsVd9YZABsIof2sHR3GnQNQX5aphV5kFw/Uqxb5zQ
 Jm916ToXtgj6MC1Yh591ts8PTOfD65fAEUGE2bHDnn+xtRm1l6deyIdzITXZWdd/Nepm
 4TPA==
X-Gm-Message-State: AOJu0YxGMP3qcg+hpxb+LfDfsHiZrFgxmXzm1K+IUZqNMLHpm9i4+/nV
 ZHy20fitVGpZgSUplq4742/JBDJ8VCHzM8xK5b3jpU280yoqeo0yWmdy8CDrFqw=
X-Gm-Gg: ASbGnctxcYilY0AytqoamgWCNyIc3au/GSK/LyGXjtPTNLEiwZI9uzS4RVrCkiJWujv
 kGIhtWzU+Hy0uWuwVQVWJYUtwR6BPlimOYKR/UNzQ0V+YLSAiUpjFLakhPsqWr2YmwH2imkm7H4
 ollk3sVehYNt+YlOAhXrvvevgaGAdDV9OP+XIR5XAJWsQF6jduELCV02ECQBpTQhAwy6sBmC4I6
 ljuOU1J0sL/4aQgpPfLzsGGf15knso2K1zrcEME5bYGQS6HEzblC07awLDDzA6xcOXH9onUQUOD
 0MN3ZK8r97JXQ1Tuqro1aJduc2gYUQlZ0A0i5E+grFQjAYfzPZxqc4Qy6GYQT5l5ZBnrl7uL9/V
 vmACTGsPuW4F3
X-Google-Smtp-Source: AGHT+IG/Sxd6JlQJJy5pfpnKOEQJigAtum31eD9VgvDtdr7xDZx0yNB0gRgSWZbeKu0Xr0tHmTV5dA==
X-Received: by 2002:a5d:588a:0:b0:394:ef93:9afc with SMTP id
 ffacd0b85a97d-39c120dc1aamr10176337f8f.18.1743519321153; 
 Tue, 01 Apr 2025 07:55:21 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41a9sm14696333f8f.90.2025.04.01.07.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:55:20 -0700 (PDT)
Message-ID: <a5872e83-7007-4ade-94cd-221437da30e1@linaro.org>
Date: Tue, 1 Apr 2025 16:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-3-npiggin@gmail.com>
 <b0842a9c-dac4-4433-b69a-054ac65d8735@linaro.org>
 <D8VC57XK27CZ.1W6DLSB9MBN1D@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D8VC57XK27CZ.1W6DLSB9MBN1D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/4/25 15:27, Nicholas Piggin wrote:
> On Tue Apr 1, 2025 at 9:57 PM AEST, Philippe Mathieu-Daudé wrote:
>> Hi Nick,
>>
>> On 1/4/25 13:44, Nicholas Piggin wrote:
>>> This requires some adjustments to callers to avoid possible behaviour
>>> changes for PCI devices.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    include/hw/ipmi/ipmi.h     |  5 +++++
>>>    hw/acpi/ipmi.c             |  2 +-
>>>    hw/ipmi/isa_ipmi_bt.c      |  1 +
>>>    hw/ipmi/isa_ipmi_kcs.c     |  1 +
>>>    hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>>>    hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>>>    hw/smbios/smbios_type_38.c |  6 +++++-
>>>    7 files changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>>> index 77a7213ed93..71c4efac8cd 100644
>>> --- a/include/hw/ipmi/ipmi.h
>>> +++ b/include/hw/ipmi/ipmi.h
>>> @@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
>>>        } memspace;
>>>    
>>>        int interrupt_number;
>>> +    enum {
>>> +        IPMI_NO_IRQ = 0,
>>> +        IPMI_ISA_IRQ,
>>> +        IPMI_PCI_IRQ,
>>> +    } irq;
>>>        enum {
>>>            IPMI_LEVEL_IRQ,
>>>            IPMI_EDGE_IRQ
>>> diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
>>> index a20e57d465c..c81cbd2f158 100644
>>> --- a/hw/acpi/ipmi.c
>>> +++ b/hw/acpi/ipmi.c
>>> @@ -55,7 +55,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
>>>            abort();
>>>        }
>>>    
>>> -    if (info->interrupt_number) {
>>> +    if (info->irq == IPMI_ISA_IRQ && info->interrupt_number) {
>>>            aml_append(crs, aml_irq_no_flags(info->interrupt_number));
>>>        }
>>>    
>>> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
>>> index a1b66d5ee82..b5556436b82 100644
>>> --- a/hw/ipmi/isa_ipmi_bt.c
>>> +++ b/hw/ipmi/isa_ipmi_bt.c
>>> @@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
>>>        ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
>>>    
>>>        ipmi_bt_get_fwinfo(&iib->bt, info);
>>> +    info->irq = IPMI_ISA_IRQ;
>>>        info->interrupt_number = iib->isairq;
>>>        info->i2c_slave_address = iib->bt.bmc->slave_addr;
>>>        info->uuid = iib->uuid;
>>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>>> index d9ebdd5371f..326115f51bb 100644
>>> --- a/hw/ipmi/isa_ipmi_kcs.c
>>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>>> @@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
>>>        ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
>>>    
>>>        ipmi_kcs_get_fwinfo(&iik->kcs, info);
>>> +    info->irq = IPMI_ISA_IRQ;
>>>        info->interrupt_number = iik->isairq;
>>>        info->uuid = iik->uuid;
>>>    }
>>> diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
>>> index a3b742d22c9..33ff7190ee8 100644
>>> --- a/hw/ipmi/pci_ipmi_bt.c
>>> +++ b/hw/ipmi/pci_ipmi_bt.c
>>> @@ -38,6 +38,17 @@ struct PCIIPMIBTDevice {
>>>        uint32_t uuid;
>>>    };
>>>    
>>> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
>>> +{
>>> +    PCIIPMIBTDevice *pib = PCI_IPMI_BT(ii);
>>> +
>>> +    ipmi_bt_get_fwinfo(&pib->bt, info);
>>> +    info->irq = IPMI_PCI_IRQ;
>>> +    info->interrupt_number = pci_intx(&pib->dev);
>>> +    info->i2c_slave_address = pib->bt.bmc->slave_addr;
>>> +    info->uuid = pib->uuid;
>>> +}
>>> +
>>>    static void pci_ipmi_raise_irq(IPMIBT *ib)
>>>    {
>>>        PCIIPMIBTDevice *pib = ib->opaque;
>>> @@ -125,6 +136,7 @@ static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
>>>    
>>>        iic->get_backend_data = pci_ipmi_bt_get_backend_data;
>>>        ipmi_bt_class_init(iic);
>>> +    iic->get_fwinfo = pci_ipmi_bt_get_fwinfo;
>>>    }
>>>    
>>>    static const TypeInfo pci_ipmi_bt_info = {
>>> diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
>>> index 05ba97ec58f..6673b2088ef 100644
>>> --- a/hw/ipmi/pci_ipmi_kcs.c
>>> +++ b/hw/ipmi/pci_ipmi_kcs.c
>>> @@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
>>>        uint32_t uuid;
>>>    };
>>>    
>>> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
>>> +{
>>> +    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(ii);
>>> +
>>> +    ipmi_kcs_get_fwinfo(&pik->kcs, info);
>>> +    info->irq = IPMI_PCI_IRQ;
>>> +    info->interrupt_number = pci_intx(&pik->dev);
>>> +    info->uuid = pik->uuid;
>>> +}
>>> +
>>>    static void pci_ipmi_raise_irq(IPMIKCS *ik)
>>>    {
>>>        PCIIPMIKCSDevice *pik = ik->opaque;
>>> @@ -125,6 +135,7 @@ static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
>>>    
>>>        iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
>>>        ipmi_kcs_class_init(iic);
>>> +    iic->get_fwinfo = pci_ipmi_kcs_get_fwinfo;
>>>    }
>>>    
>>>    static const TypeInfo pci_ipmi_kcs_info = {
>>> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
>>> index 168b886647d..2823929c258 100644
>>> --- a/hw/smbios/smbios_type_38.c
>>> +++ b/hw/smbios/smbios_type_38.c
>>> @@ -72,7 +72,11 @@ static void smbios_build_one_type_38(IPMIFwInfo *info)
>>>                         " SMBIOS, ignoring this entry.", info->register_spacing);
>>>            return;
>>>        }
>>> -    t->interrupt_number = info->interrupt_number;
>>> +    if (info->irq == IPMI_ISA_IRQ) {
>>> +        t->interrupt_number = info->interrupt_number;
>>> +    } else {
>>> +        t->interrupt_number = 0;
>>
>> Can you explain why use 0 for PCI?
> 
> To avoid changes to other callers after this patch. Previously PCI
> devices would leave interrupt_number as 0, not sure if such devices
> are relevant here. If there is a better approach I would take it.

OK, this is what I thought but I felt I could have missed something.
Thanks!

