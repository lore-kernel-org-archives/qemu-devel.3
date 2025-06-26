Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2E0C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhn0-0000SQ-35; Thu, 26 Jun 2025 04:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUhmw-0000QH-DX
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUhmt-0007it-Bo
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750925808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLaCiP+fRMAVbTwIzpfwb5TGbUB5bgOHC/V9Yd1Bbls=;
 b=R5TiBkwZeqIE3P2zLrPzaZ3/JpAZdylWnDw9AqXCx/m8OjIavV6PRYEItE+t92mdBOU3I5
 7hUGLAMUVePdb/yNkp0kdwT9/cTBpUokPvTs3ePYwz+6OGvrcjQuMx8OzZAVR3WtQAjdgI
 S0fm7BG+sjtFHh2pOBd+LAp+XVRz2R8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-AZ61QhGSO02tAL35uLehOQ-1; Thu, 26 Jun 2025 04:16:46 -0400
X-MC-Unique: AZ61QhGSO02tAL35uLehOQ-1
X-Mimecast-MFC-AGG-ID: AZ61QhGSO02tAL35uLehOQ_1750925805
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso3853185e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 01:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750925805; x=1751530605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLaCiP+fRMAVbTwIzpfwb5TGbUB5bgOHC/V9Yd1Bbls=;
 b=ZIISFqeQg6I1oDMixUXlERDWP2OhW/CzBeDpVR2uucU35DXm1TGY1KNAmWIhBeZGCG
 bWQtoX24HqSplWZbkF/A0ylTxv2j90LhRZxOYNSxZasMLu89Ron4fJn3CyVrBDKNKGjR
 ZUUz+IBT8Xk2HJGupRYuT12BH2KTC+fXZKrJwfMvNMZ3UCmlxNmJxmOt6pePFDXUm9CZ
 LShMS/FJbkdBJeq3dNvYiRy6nfd7F5qVHd0pbgfwYVywN8TVdGlssoI91uWyNxRZW27k
 y36JypnTXkJW2XvTs0Rfb6RPUmZfOygtxacRWKSBFq7BXIFyUd5VZeynYqnjmNK245N/
 DZXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc/LokCRqcJKFOMeY+lJ1zUwywE/T6OYzDsQWF+mIAx0FtPHSMJ5dZccWmefRPFkr2XOQt++mXyrx9@nongnu.org
X-Gm-Message-State: AOJu0Yw3lNPO/MN8ndEFsjz8VblCtOOBlMLEMax1IvWdb0HoiecZBwF/
 7f675FYV7GZX+1e0Lbeh7nm7FHugkR7xZTrd/isOWP4QwRdmlF8+JBxLvyspyp2NiEUIIaafwlG
 1XedP9lANyt08Au7ZhvPef8z2tzNNpOkLJvQn6qPlR8v/RFy0fafzrMUv
X-Gm-Gg: ASbGncu80G+Dvy//nBllwHXXLKQV1OJcDQKUc1BvTSd+iXS4dviRt7aimr7NGDChP+M
 B6ziBFcYaGoW8hzuP+AfeIsIba9PS+S61H+q2a0hWfa+prbc4W0pLWgtXfrBdewt0LVjXEw0jo9
 f4jV//FaWbvAjXe/bBArR28hGvhxQnKdj3QhCdi6JSxGyeKfOntvBPA8S+CjZWHxuENejsu4EMJ
 lLmvKYpqNM6LGIkQpS3YwrcYxPzQ27oFbV3lU+PBr6zWorIpsrDkzhMCKfqVHCyw1XpT8wKHL3T
 5v7565MiZyOvKCrKEqL5wCGjnSUNFw4mcMYa4U5Zst7pX2lrSX6F/WMI8lskmadJl+ItaQ==
X-Received: by 2002:a05:600c:3496:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-45381ae9033mr59825415e9.18.1750925804763; 
 Thu, 26 Jun 2025 01:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiozj5IcJ+4br1H1IJUs6QwU0fIKaG5TRQeC5/o5PIdahzN3Zhaqdyu196taU0zAbD1wu8eQ==
X-Received: by 2002:a05:600c:3496:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-45381ae9033mr59825045e9.18.1750925804326; 
 Thu, 26 Jun 2025 01:16:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8069467sm6545380f8f.42.2025.06.26.01.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 01:16:43 -0700 (PDT)
Message-ID: <e6dde520-e889-4102-aac9-9a5df3b57f5e@redhat.com>
Date: Thu, 26 Jun 2025 10:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/29] hw/arm/virt: Plug pcihp hotplug/hotunplug
 callbacks
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-27-eric.auger@redhat.com>
 <20250620151033.7fedf673@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620151033.7fedf673@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

On 6/20/25 3:10 PM, Igor Mammedov wrote:
> On Mon, 16 Jun 2025 11:46:55 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> why do we still need this?
>
> pcihp code should override native pcie bus handlers, and then
> when device_add calls bus hotplug handlers it will be pcihp ones.
It was needed because I did not call qbus_set_hotplug_handler() as done in
ich9.c. So I think I should be able to get rid of this patch

Thanks

Eric
>
>> ---
>> v2 -> v3:
>> - fix cohabitation with virtio-mem-pci device and tested
>>   hotplug/unplug of this latter (Igor)
>> ---
>>  hw/arm/virt.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 69 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 8c882e0794..06b87e1050 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1747,6 +1747,22 @@ static void virt_build_smbios(VirtMachineState *vms)
>>      }
>>  }
>>  
>> +static AcpiPciHpState *get_acpi_pcihp_state(VirtMachineState *vms)
>> +{
>> +    AcpiGedState *acpi_ged_state;
>> +    AcpiPciHpState *pcihp_state;
>> +
>> +    if (!vms->acpi_dev) {
>> +        return NULL;
>> +    }
>> +    acpi_ged_state = ACPI_GED(vms->acpi_dev);
>> +    pcihp_state = &acpi_ged_state->pcihp_state;
>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>> +        return pcihp_state;
>> +    }
>> +    return NULL;
>> +}
>> +
>>  static
>>  void virt_machine_done(Notifier *notifier, void *data)
>>  {
>> @@ -2907,6 +2923,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>  {
>>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>  
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        if (get_acpi_pcihp_state(vms)) {
>> +            acpi_pcihp_device_pre_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
>> +                                          dev, errp);
>> +        }
>> +    }
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_memory_pre_plug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>> @@ -2961,6 +2984,15 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>          }
>>      }
>>  
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
>> +
>> +        if (pcihp_state) {
>> +            acpi_pcihp_device_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
>> +                                      pcihp_state, dev, errp);
>> +        }
>> +    }
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_memory_plug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>> @@ -3017,12 +3049,27 @@ out:
>>  static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>                                            DeviceState *dev, Error **errp)
>>  {
>> +    bool supported = false;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_dimm_unplug_request(hotplug_dev, dev, errp);
>> +        supported = true;
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>          virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>>                                       errp);
>> -    } else {
>> +        supported = true;
>> +    }
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
>> +
>> +        if (pcihp_state) {
>> +            acpi_pcihp_device_unplug_request_cb(HOTPLUG_HANDLER(vms->acpi_dev),
>> +                                                pcihp_state, dev, errp);
>> +            supported = true;
>> +        }
>> +    }
>> +    if (!supported) {
>>          error_setg(errp, "device unplug request for unsupported device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> @@ -3031,11 +3078,27 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>  static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>>                                            DeviceState *dev, Error **errp)
>>  {
>> +    bool supported = false;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_dimm_unplug(hotplug_dev, dev, errp);
>> +        supported = true;
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>          virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>> -    } else {
>> +        supported = true;
>> +    }
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>> +
>> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
>> +
>> +        if (pcihp_state) {
>> +            acpi_pcihp_device_unplug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
>> +                                        pcihp_state, dev, errp);
>> +            supported = true;
>> +        }
>> +    }
>> +    if (!supported) {
>>          error_setg(errp, "virt: device unplug for unsupported device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> @@ -3045,11 +3108,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>>                                                          DeviceState *dev)
>>  {
>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    VirtMachineState *vms = VIRT_MACHINE(machine);
>>  
>>      if (device_is_dynamic_sysbus(mc, dev) ||
>>          object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>>          object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
>> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>> +        (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE) &&
>> +                             get_acpi_pcihp_state(vms))) {
>>          return HOTPLUG_HANDLER(machine);
>>      }
>>      return NULL;


