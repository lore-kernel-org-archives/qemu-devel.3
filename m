Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DAC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYzU-00088g-Qe; Fri, 20 Jun 2025 06:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYzP-00087e-Vy; Fri, 20 Jun 2025 06:28:56 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYzM-0007Ag-4C; Fri, 20 Jun 2025 06:28:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNtqd4nm1z6L565;
 Fri, 20 Jun 2025 18:23:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D098514027A;
 Fri, 20 Jun 2025 18:28:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 12:28:42 +0200
Date: Fri, 20 Jun 2025 11:28:41 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 26/29] hw/arm/virt: Plug pcihp hotplug/hotunplug
 callbacks
Message-ID: <20250620112841.00007cb2@huawei.com>
In-Reply-To: <20250616094903.885753-27-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-27-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:55 +0200
Eric Auger <eric.auger@redhat.com> wrote:

Maybe needs a little bit of description.

> Signed-off-by: Eric Auger <eric.auger@redhat.com>

A few trivial things inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
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

Really trivial but if this isn't going to gain extra stuff I'd consider
the NULL return the 'error' path and prefer that out of line for consistency.
That is.

    if(!pcihp_state->use_acpi_hotplug_bridge) {
        return NULL;
    }

    return pcihp_state;


That just ends up a tiny bit more consistent with the !vms->acpi_dev test
earlier in the function.

> +}
> +
>  static
>  void virt_machine_done(Notifier *notifier, void *data)
>  {
> @@ -2907,6 +2923,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>  

Maybe add a comment on why this is not in the if/else stack.  I assume
because a few of those are also TYPE_PCI_DEVICE.
Something in the patch description would also work for me.

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



