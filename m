Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22ABCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWv0a-0006x2-G7; Tue, 09 Jun 2026 07:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWv0Y-0006wZ-8q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWv0W-0002e4-AE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781005953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJvXh2+BGEhLxZvKWssx0xtBdEKf7cnFzkS58uHwBjI=;
 b=IDe1GpdqVnOSZ9MwmAnIcEmPtW2F3BpJ5p2Z2+X17dcXIxrhCwxZcIS/VAloyXpugfme/w
 aDFX9S9gp1E2KjH9XT1cxR4gNOiHtA+GUrMtgA2x5BwkTPqpx2xnX95uPeEHvX2eFOJlmd
 rWRUC4r9KtRPqB3ObVY+N/xMd1/vxPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-hwZKlDbgPcOVCovilOP_dQ-1; Tue, 09 Jun 2026 07:52:30 -0400
X-MC-Unique: hwZKlDbgPcOVCovilOP_dQ-1
X-Mimecast-MFC-AGG-ID: hwZKlDbgPcOVCovilOP_dQ_1781005950
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so43139015e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781005949; x=1781610749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJvXh2+BGEhLxZvKWssx0xtBdEKf7cnFzkS58uHwBjI=;
 b=lf4gjz/6zMcgSD12D9NDDrn5Fdt5ms/FTM6xpO8EmdI/A3MpWYsaTndHqXjtpwPmWO
 NlAheBAVbYqYoDLlkNoDTw+t/5J7Do2T8VMHmgqW1TGplprbLclzweHOxPs8wlygoxIs
 JpvKtXsb/ypbATj1yeI2UnrZIq57Gcmj4NU/kwJWFGk1NhLNRq/4KkF6A7lD7ef6hzWz
 J128875C9tuF2tbIIAYUGdESbGtSH1utXg2FK7Gac/ZidO5UpgpQE+7sUFsC84PB0Dab
 zVAVRVYvBUVtApWUYM1e7i6N5IHAwqdQvIkHigAfzgOrJkAYqT2g+TqfwlAPpja91H2a
 77Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781005949; x=1781610749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJvXh2+BGEhLxZvKWssx0xtBdEKf7cnFzkS58uHwBjI=;
 b=np1+DZUCQwzmQLfJJrndgcwxHZ7XVpcP8uAec0TfnOncHUKBe0GBVN2b/JOHOogmVA
 in5NEaxzL9Oq7wM24S/e6d3MJBoQDCzNoz+ygxDjMEE3uaDiEitcQ/zJTZa15A+LIDYN
 Jm3y9HhqhSurYp+y/5Wt/EV15IhuJzkFL6T3FUUKT/DlJ7dT0zOACuU6NQVF3oz+Av0D
 TfZtIhD6SX9OxL9PciPcImYro5f4vTtPAsAwm0RrbexBAA5mle+CAJCt23nfQY9SSWTK
 g25os268Z2Nsw7ojiZB7lRnvcIakzYqdrI/LQKSogszhim5kIc/dH0xo4/0KK99lQh++
 f5nQ==
X-Gm-Message-State: AOJu0YwhhBJm1oUE5pOkUCWJrQeuO4N/YclvIv1ZPr/ooTNAFWLrFXzH
 EY17IZUjKMsc2XbDjKcBDTloV1kEwOsmMT61ztwrXYzrCifeVWEuaQ9usj90SiwRKUBdutTkt2P
 DcFlOXx0MnMJCbq/bW2A1hwFijRYctsIdGt72SDRxRvfHwjHWl4FV/sPD
X-Gm-Gg: Acq92OFfxzACsYmWqZiXJI8O9k4SrVti2CMluWPL1jP193EP1YNJKpZCgAffus1fCum
 7/mfLfd969jVDYcrhvLc+4VYcZdESb4buOIygsq+QT7CxHwmspVDpKveBR3BrFNSgdJY/lB5l9z
 9YT0k5AfmW8f9syp6T9eQtId9neUF9t1N2caLl12XQYZnnAzU3QjKqoBpxrgHGjLjAeoMQFpjIm
 nr2nshYNmzOejmGSPTOTPfl2/wwOtwyGV/ian/ogcro88BphOg9uEuDRhFju5xcJKHj7fkXNaLP
 Yx6xztjVX5r2LiUdAeRbbnJ8W9AAedJRXAmKHkCoJyaCwSD9XBo33+8IhpubyZpQLt5nZ7vYEhF
 nZryr6A/Ri3N2iE6i
X-Received: by 2002:a05:600c:6094:b0:490:4b89:5362 with SMTP id
 5b1f17b1804b1-490c2609cecmr329492865e9.24.1781005949535; 
 Tue, 09 Jun 2026 04:52:29 -0700 (PDT)
X-Received: by 2002:a05:600c:6094:b0:490:4b89:5362 with SMTP id
 5b1f17b1804b1-490c2609cecmr329492325e9.24.1781005949176; 
 Tue, 09 Jun 2026 04:52:29 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d37edbsm378895495e9.2.2026.06.09.04.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:52:28 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:52:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v10 3/4] hw/i386: hook sp-mem into the pc machine plug path
Message-ID: <20260609135227.6dd6eb99@imammedo>
In-Reply-To: <20260605104609.1739911-4-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-4-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jun 2026 18:46:08 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
> placed by the memory-device framework and reported to the guest as
> E820_SOFT_RESERVED.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  hw/i386/e820_memory_layout.h | 11 +++++-----
>  hw/i386/pc.c                 | 42 ++++++++++++++++++++++++++++++++++++
>  hw/i386/Kconfig              |  2 ++
>  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> index b50acfa201..6ef169db9c 100644
> --- a/hw/i386/e820_memory_layout.h
> +++ b/hw/i386/e820_memory_layout.h
> @@ -10,11 +10,12 @@
>  #define HW_I386_E820_MEMORY_LAYOUT_H
>  
>  /* e820 types */
> -#define E820_RAM        1
> -#define E820_RESERVED   2
> -#define E820_ACPI       3
> -#define E820_NVS        4
> -#define E820_UNUSABLE   5
> +#define E820_RAM           1
> +#define E820_RESERVED      2
> +#define E820_ACPI          3
> +#define E820_NVS           4
> +#define E820_UNUSABLE      5
> +#define E820_SOFT_RESERVED 0xefffffff
>  
>  struct e820_entry {
>      uint64_t address;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2ecad3c503..b538f49f23 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -63,6 +63,7 @@
>  #include "hw/i386/kvm/xen_gnttab.h"
>  #include "hw/i386/kvm/xen_xenstore.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/mem/sp-mem.h"
>  #include "e820_memory_layout.h"
>  #include "trace.h"
>  #include "sev.h"
> @@ -1283,11 +1284,49 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
>      memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
>  }
>  
> +static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    SpMemDevice *spm = SP_MEM(dev);
> +

> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
> +        error_setg(errp, "memory backend '%s' is already in use",
> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
> +        return;
> +    }
this belongs to sp_mem realize

> +    if (ms->numa_state && spm->node >= ms->numa_state->num_nodes) {
> +        error_setg(errp,
> +                   "'node' property value %" PRIu32
> +                   " exceeds the number of NUMA nodes (%d)",
> +                   spm->node, ms->numa_state->num_nodes);
> +        return;
> +    }

I think this the right place for this, despite what other mems do.
Perhaps it is worth to consolidate/cleanup 1st. 

I'd put it in memory_device_pre_plug():
       if has_node_prop:
          .....

> +    memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
> +}
> +
> +static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
> +    uint64_t addr, size;
> +
> +    host_memory_backend_set_mapped(spm->hostmem, true);
dup? see above.

> +    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +
> +    addr = mdc->get_addr(MEMORY_DEVICE(dev));
> +    size = memory_region_size(host_memory_backend_get_memory(spm->hostmem));
> +    e820_add_entry(addr, size, E820_SOFT_RESERVED);
> +}
> +
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
> +        pc_sp_mem_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          x86_cpu_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -1324,6 +1363,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
> +        pc_sp_mem_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          x86_cpu_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -1368,6 +1409,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
>                                               DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 12473acaa7..e27d8816e5 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -84,6 +84,7 @@ config I440FX
>      select PCI_I440FX
>      select PIIX
>      select DIMM
> +    select SP_MEM
>      select SMBIOS
>      select SMBIOS_LEGACY
>      select FW_CFG_DMA
> @@ -113,6 +114,7 @@ config Q35
>      select LPC_ICH9
>      select AHCI_ICH9
>      select DIMM
> +    select SP_MEM
>      select SMBIOS
>      select FW_CFG_DMA
>  


