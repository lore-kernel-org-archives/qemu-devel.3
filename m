Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746CBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFw5g-0002af-Vc; Mon, 03 Nov 2025 10:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw5f-0002aW-Uh
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw5Z-00009x-RP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762182195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwZZLAszsfKxB4H2dic/Da+s4mspn2nuegpRXjtxmqo=;
 b=MrsuosNE0TIG3pgD+XiJUy+8LJjPAvLjbNVyH+zZ6mys7WiggnuHg6Fuxg8vPdY1zpy411
 sPDL/e0BaGQDeLBSChBDLax6RemT25M7Rh9QsQMG7XfmRTJtBNo7CKUnctxStIhzJyDCw2
 1Y7WOlTDLm9P56leiy+qNAvrLrpIjm8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-mwYZrNiIMI2g0Pq_70cdlg-1; Mon, 03 Nov 2025 10:03:10 -0500
X-MC-Unique: mwYZrNiIMI2g0Pq_70cdlg-1
X-Mimecast-MFC-AGG-ID: mwYZrNiIMI2g0Pq_70cdlg_1762182189
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c76c8a1bso1234357f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762182189; x=1762786989;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwZZLAszsfKxB4H2dic/Da+s4mspn2nuegpRXjtxmqo=;
 b=KEBgA++wv1JMw5b1QtOyRPNT/hUzjoX7xUljYJ2C5hMjsbc60AWfA8J4h0fn+ghDEA
 9wjx1Ho/gCkxL2qBciboE4eln9yCA2WzKg+wf6UDh4a7dxq8XdpYYuM05Ip4NxwmU4bG
 SFNTtMfhuwC25QI2KzWZnq9hTEqCV1uecXq0DnFARFS9CEdGv00r5W2ni23ElI4dfR1d
 uXq13eH6tNl1S8UryvW6fRoZSXAIu3+tuBmADdQP7enQsC654/PpGLVPO4e5dj6H2bW1
 Vo5mLG28Pgt/jWxqY1l8SJ35huu0Sl5aE14+8lZbcHnHT0B56Yx4B/Pt7YRfV6UwK5ny
 73Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3rGy74fepf97Qn8k0LMp3Q18OdIhW32I6Ea+uQQlHTfMrvfe3RtT9mwF3ToBTu7BppmzWWhwW0tcs@nongnu.org
X-Gm-Message-State: AOJu0YzcX9bGxeYeDWU1tzhLMZqDMuUxhsD/l/J7KOU2vTCAI9ybOBOT
 +aGNacgGEbxg5v0+tGeq1A2f9qR13x70OZDx+v4lc7+TMYEbbAwnVroktNRHZb4mvVeWT5Ef3SH
 BpmqSw5Oo2ikKjDUga8mDsVyXIKkQMvUcW56hgVMKE2LJKFpW0QpmrY5D
X-Gm-Gg: ASbGncujp2Hcrage5Sc1IzoeQWi/X25fFBrK1CAIx8Vcn+fMiZNUD3E0S8nrX26nP7A
 RVYO+YRKzGqdBdyYsuY4ScYLrEftA8TJ4hD7LPMThYXtwp4/vMJcpwmuPRKXYqaIa9/3J+FzMZP
 NIn00pW2dCoR05soGTe4FXo85rTHBP40UcXhaAZzH5PPS5BA7cYtzGEoSpsIjjyg4ErTT3DixAy
 OXWkZhk6qUrAckDtP2uYclrkAXFpUqlghgiqKgF/BZuTwTDfLicM9rCfXu+Ty7n4bY7wP/bH9QV
 JEx2PNN5KITVTDZRdURNQ46Caj4NYhaLNJrRcIE4hC6MguZK4FQ83hxxD0urFQY70KSVvpl4mE5
 eW55ggSd7ss/0iqjkLS0wHNmQ/jauE/e1lUb2dWzXSkh5Vw==
X-Received: by 2002:a05:6000:2387:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-429bd683416mr12286809f8f.14.1762182188598; 
 Mon, 03 Nov 2025 07:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWtHHmX9+9KWoqdZKO0U9XDLjstnSogpl55hZwJUk9ozXzcafrUvUrYVjOUq9vFYwZWTrsOQ==
X-Received: by 2002:a05:6000:2387:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-429bd683416mr12286767f8f.14.1762182188099; 
 Mon, 03 Nov 2025 07:03:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429d12e1173sm8929705f8f.42.2025.11.03.07.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 07:03:07 -0800 (PST)
Message-ID: <4e0ed196-b156-4de5-9a2c-e241a853ce57@redhat.com>
Date: Mon, 3 Nov 2025 16:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/32] hw/arm/virt: Set PCI preserve_config for accel
 SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-22-skolothumtho@nvidia.com>
 <28dd6856-71ce-445c-9b9c-d4b6502a92bb@redhat.com>
In-Reply-To: <28dd6856-71ce-445c-9b9c-d4b6502a92bb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-to:  eric.auger@redhat.com
X-ACL-Warn: ,  Eric Auger <eric.auger@redhat.com>
From:  Eric Auger via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/3/25 3:58 PM, Eric Auger wrote:
> 
> 
> On 10/31/25 11:49 AM, Shameer Kolothum wrote:
>> Introduce a new pci_preserve_config field in virt machine state which
>> allows  the generation of DSM #5. This field is only set if accel SMMU
>> is instantiated.
>>
>> In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
>> to enable nested translation of MSI doorbell addresses. IORT RMR requires
>> _DSM #5 to be set for the PCI host bridge so that the Guest kernel
>> preserves the PCI boot configuration.
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>  hw/arm/virt-acpi-build.c | 8 ++++++++
>>  hw/arm/virt.c            | 4 ++++
>>  include/hw/arm/virt.h    | 1 +
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 8bb6b60515..d51da6e27d 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -163,6 +163,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>          .pci_native_hotplug = !acpi_pcihp,
>>      };
>>  
>> +    /*
>> +     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM for
>> +     * preserving PCI Boot Configurations
> as suggested in v4 you can be more precise and explictly state
> 
> _DSM function 5 (Ignore PCI Boot Configuration)
> 
>> +     */
>> +    if (vms->pci_preserve_config) {
>> +        cfg.preserve_config = true;
>> +    }
>> +
>>      if (vms->highmem_mmio) {
>>          cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
>>      }
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 175023897a..8a347a6e39 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -3091,6 +3091,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>              }
>>  
>>              create_smmuv3_dev_dtb(vms, dev, bus);
>> +            if (object_property_find(OBJECT(dev), "accel") &&
> why do you need to test
> 
> object_property_find(OBJECT(dev), "accel")?

Hum, because at that moment it does not exist yet. So you can remove it
in 25/32 I think

Eric
> 
>> +                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
>> +                vms->pci_preserve_config = true;
>> +            }
>>          }
>>      }
>>  
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 04a09af354..60db5d40b2 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -182,6 +182,7 @@ struct VirtMachineState {
>>      bool ns_el2_virt_timer_irq;
>>      CXLState cxl_devices_state;
>>      bool legacy_smmuv3_present;
>> +    bool pci_preserve_config;
>>  };
>>  
>>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> With those changes takin into account
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 


