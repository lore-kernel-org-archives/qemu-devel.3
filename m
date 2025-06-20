Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6CC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbWT-0008Qz-OE; Fri, 20 Jun 2025 09:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbVz-0007xK-5V
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbVx-0005N6-6y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750425040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6E3ldKAHT76gzfPbKZDc3nqLlogjlvLORH7eAQ0qwM=;
 b=I+Hy79KgcMPUegGucOCfgFhfBhwNrvYcV+TjUnRqVnCXt6yS5OLlwX6piqFdtbfn1Clv/C
 Rk+5vMB9CHAZEJmRjej0Q2Ba5mxRF3MObVji9yyP8zR9pwAcY1i4t0T7LLl8Tdcos7Iw+n
 EqN2fI4xMUm5su//z4bIjVeTw4JdK6U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-H39fxkCHPgGvF3vJaewhcw-1; Fri, 20 Jun 2025 09:10:38 -0400
X-MC-Unique: H39fxkCHPgGvF3vJaewhcw-1
X-Mimecast-MFC-AGG-ID: H39fxkCHPgGvF3vJaewhcw_1750425037
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eed325461so11324945e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750425036; x=1751029836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6E3ldKAHT76gzfPbKZDc3nqLlogjlvLORH7eAQ0qwM=;
 b=vlk0wWcmCrExLeYRdmymRK5Kktn3Az0pr5iSRVfzOYbJwayZFwu2vlH3g0CxbxTd0x
 GROkxMxjCZ8Py28iypxon7rv12hRXie+/+EgG3SDV6YV6RFu/MMOX2uvDv3Gj/s3wsW8
 MXqRBD6CSImn+WKiCCY6UYCJcEB4eNLLge8HhwAeZUDA2JE2sC+FBLr0I/p0M5/WHI4n
 DqbAyeVaDT0Vuj0CC22h13BBVJGoR8iKXEid8tWaVM5tAZhbMe4SakS/KbZABagB1iUN
 YtJ0V2s8dSn6v3pxX8A2ddapgQR+zG6AJIRwx2DUA+akxvdy5BgL20DzfcqHB/RmIJ9s
 fzFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjt0zXt0OYh/br7Zph8mvkTYD4RyTn/h9oe6nnOy9A+18DeJGdqTroBL/IoyJistOyCKmsj0pa4PK1@nongnu.org
X-Gm-Message-State: AOJu0YxZTmB8RLnCHdQedpTIhVDTM5/0BpWphnd67L6hBqt+8wOT4Gdk
 /HFbZ/5SAFBM7hkgMTemp5BZMEhQ7REiuxotEme/N6TBQRdOk82TQsihb7zzmScMt7Opz1HJyF2
 xJHMDwsuaBwPBuGWgiUc6StItG0WbKy/vrVrF+o+NWbWBgmkX8ifdglAU
X-Gm-Gg: ASbGncutqnVg/+EGi0uiivUIITUxtadNiXsLMk77N9cxh2nGcrrX6MjpzYnlUyZOe0R
 7ZhebpWhUMeIxQLhqlT8mrTdr91C/XmqDnsi0M+PAfiHZFHINUesYm+z4NNE2pT0nE5xhpeuGH8
 RoCSXKe/FFgW7X8fsjkyTdYQan5O+k1/yq58O8EsbVapdRidyGne+ebMuvSlhkmNBGyrhdTXgfq
 heD1Wiz8MkKv4Fp6FhRyKyozN1jtW6XGVV6EfedxsWJDlPjVsyk0Qer8wGqshUDQnL3kfcnALm8
 +p4krtASy83B
X-Received: by 2002:a5d:5c04:0:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a6d12e5d82mr1959448f8f.50.1750425036489; 
 Fri, 20 Jun 2025 06:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2W0fmWOlLCAQljo1O/IiB2kjvffcVlNOtpbAbK+sla4NcBVH8/91OeTg+K8WJG/GRQjqkPQ==
X-Received: by 2002:a5d:5c04:0:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a6d12e5d82mr1959414f8f.50.1750425036060; 
 Fri, 20 Jun 2025 06:10:36 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c6b2sm2041443f8f.46.2025.06.20.06.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:10:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:10:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 26/29] hw/arm/virt: Plug pcihp hotplug/hotunplug
 callbacks
Message-ID: <20250620151033.7fedf673@fedora>
In-Reply-To: <20250616094903.885753-27-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-27-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Jun 2025 11:46:55 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Signed-off-by: Eric Auger <eric.auger@redhat.com>

why do we still need this?

pcihp code should override native pcie bus handlers, and then
when device_add calls bus hotplug handlers it will be pcihp ones.

> ---
> v2 -> v3:
> - fix cohabitation with virtio-mem-pci device and tested
>   hotplug/unplug of this latter (Igor)
> ---
>  hw/arm/virt.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8c882e0794..06b87e1050 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1747,6 +1747,22 @@ static void virt_build_smbios(VirtMachineState *vms)
>      }
>  }
>  
> +static AcpiPciHpState *get_acpi_pcihp_state(VirtMachineState *vms)
> +{
> +    AcpiGedState *acpi_ged_state;
> +    AcpiPciHpState *pcihp_state;
> +
> +    if (!vms->acpi_dev) {
> +        return NULL;
> +    }
> +    acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +    pcihp_state = &acpi_ged_state->pcihp_state;
> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> +        return pcihp_state;
> +    }
> +    return NULL;
> +}
> +
>  static
>  void virt_machine_done(Notifier *notifier, void *data)
>  {
> @@ -2907,6 +2923,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        if (get_acpi_pcihp_state(vms)) {
> +            acpi_pcihp_device_pre_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
> +                                          dev, errp);
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -2961,6 +2984,15 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          }
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
> +
> +        if (pcihp_state) {
> +            acpi_pcihp_device_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
> +                                      pcihp_state, dev, errp);
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -3017,12 +3049,27 @@ out:
>  static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    bool supported = false;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_dimm_unplug_request(hotplug_dev, dev, errp);
> +        supported = true;
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>          virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>                                       errp);
> -    } else {
> +        supported = true;
> +    }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
> +
> +        if (pcihp_state) {
> +            acpi_pcihp_device_unplug_request_cb(HOTPLUG_HANDLER(vms->acpi_dev),
> +                                                pcihp_state, dev, errp);
> +            supported = true;
> +        }
> +    }
> +    if (!supported) {
>          error_setg(errp, "device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
>      }
> @@ -3031,11 +3078,27 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>  static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    bool supported = false;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_dimm_unplug(hotplug_dev, dev, errp);
> +        supported = true;
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>          virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> -    } else {
> +        supported = true;
> +    }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
> +        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
> +
> +        if (pcihp_state) {
> +            acpi_pcihp_device_unplug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
> +                                        pcihp_state, dev, errp);
> +            supported = true;
> +        }
> +    }
> +    if (!supported) {
>          error_setg(errp, "virt: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
>      }
> @@ -3045,11 +3108,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>                                                          DeviceState *dev)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    VirtMachineState *vms = VIRT_MACHINE(machine);
>  
>      if (device_is_dynamic_sysbus(mc, dev) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE) &&
> +                             get_acpi_pcihp_state(vms))) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;


