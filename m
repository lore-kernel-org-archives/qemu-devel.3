Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384FFCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbe0g-0003Re-I9; Mon, 22 Jun 2026 08:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe0d-0003RJ-FK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe0a-0002sX-81
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxvHwoPnCWhik6ccjb0RIrAJqLMwL8VwGFrTYf0rDjY=;
 b=KfMdh9tEpiUoGmFqBclAvW0sPTK8D0JS2/4OB2wdWSawe094kM3ynOsCfD0SqACORVEysi
 FH7SDRslSXX0bqV2Td9DRiw94U0NdU1DkgL9pBzKt9+NxCW6LiaoLUXvwdBS8pENC66VkG
 VINLBDOuSphEAplceq+2Jn65AC+F500=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-cRTJ2ExPPv2pEFVLG9SWuQ-1; Mon, 22 Jun 2026 08:44:09 -0400
X-MC-Unique: cRTJ2ExPPv2pEFVLG9SWuQ-1
X-Mimecast-MFC-AGG-ID: cRTJ2ExPPv2pEFVLG9SWuQ_1782132248
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso29195795e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782132248; x=1782737048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxvHwoPnCWhik6ccjb0RIrAJqLMwL8VwGFrTYf0rDjY=;
 b=WiO5jWJvNZix+ndpTQfj8Yaq0w+HAKMAd1B7LRWyroLnpyMLdvStoPwGeEc6MSagoa
 FC6FmjnNI5NEu61iu+BGCPccc22CSx8xE5VLutS3tg4LEL76UK0cIN8u7NoMhV/leA45
 efX1tF3s+WIjAmzzmJc4eyzMhL7F2wUgJScF4Z69XZQxgkj4NJlWrJFK9KF8/QyCzcEh
 9wIYUmJv8KZNFaehR4cHDsniM1EGFnVzQrPpsRbMKl6g97WGFvBZ6WKgjJbobx70dyOg
 yXLAawp2LsVLLnf6acbANsjcSdDT+Au1Irj8XJw1auCf12Qz0sA0qBnoux3PNeUAbebU
 xe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132248; x=1782737048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxvHwoPnCWhik6ccjb0RIrAJqLMwL8VwGFrTYf0rDjY=;
 b=XQPiAYBSR6Ip06L/lpUa60mlSUrW5aOkO6N5uP/nNs2qaKzSCLrdO4gxke8dHD9xRv
 d0YeKIuuRbDsSLi2VnSi3fcBjRNMiTLWhZnSrH93w8zZkuwP7YrjJEGVt48TURdalf3T
 KJe8uU5ug/PuI8gQLoIKloRAwO4Jo0RkTLo7SRL0SGLiAuIu6iZByz6mR5q+XARzVFBl
 2Nj5DPCnUaTL7IONHAWHUnaSWOm7o4V2MnoCHDuBdfc33ksUvVnzj6aEX7anUwyc+KRH
 uHr8vTwxoBPI6bbz1WLWtScR9KtCnNkCUUM439WUGVCFpo1jkJWAqtuJmAt0jTOaorDb
 RReg==
X-Gm-Message-State: AOJu0Yy3/UJvpiXYbgUjMRMEZzhsZqWRC3f/AXSo2OfsC3PxPiijkvS5
 13CNVDT8QfOoGNSeeSFEFHCOx5JulRnnPPbdH4nNxucEegu30C47r9SQwP+l9Vjb8ThlmK+E2VO
 YKO9imVsTjKcVH0TX6z0eyYr3579Q2VPTljBcdbSKV9E0mEYleoYFs0aY
X-Gm-Gg: AfdE7clVoyCYIYDa+wGKqRfGHMWoWT4Hg/mbk7Ubp1HLyj5cJs7rtvAm7lKJGEXZDZR
 lRu0troUCLuA3MxGFTRGeXm5ULF9F2fLk7NVXXqQSYeapld7SB9BDgkd+VpJdYtAkwBSvZNqGqY
 Fs3SQXbNMMOmuMstpjcOlmNLmc6WJ5cJJGmfRMyCGqraryW/VI8QMqBLKtH8ugvqodlnfEYeYq/
 6/WlszQkey9KS3oClgvbo8gtIMz/EMdAF1dreF9vsX23HDkuSxWuTKgqlsTs4fGIeyr/pGz+H5P
 9r7WgW1A8oHbiYV69VHxclWg6CrKhmZibKMekHD8/YiJ7rUKhd28Hu2HI4ymOXAKxr3DOhs=
X-Received: by 2002:a05:600c:3b05:b0:492:4a70:faaa with SMTP id
 5b1f17b1804b1-4924a7101b5mr144927875e9.11.1782132248113; 
 Mon, 22 Jun 2026 05:44:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3b05:b0:492:4a70:faaa with SMTP id
 5b1f17b1804b1-4924a7101b5mr144927395e9.11.1782132247678; 
 Mon, 22 Jun 2026 05:44:07 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245711032sm268892725e9.0.2026.06.22.05.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:44:07 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:44:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 04/10] hw/i386: hook sp-mem into the pc machine plug
 path
Message-ID: <20260622144404.1a2e7c04@imammedo>
In-Reply-To: <20260619111136.3481329-5-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-5-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 19 Jun 2026 19:11:30 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
> placed by the memory-device framework and reported to the guest as
> E820_SOFT_RESERVED.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/e820_memory_layout.h | 11 ++++++-----
>  hw/i386/pc.c                 | 36 ++++++++++++++++++++++++++++++++++++
>  hw/i386/Kconfig              |  2 ++
>  3 files changed, 44 insertions(+), 5 deletions(-)
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
> index 73a625327c..782122f7be 100644
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
> @@ -1285,11 +1286,43 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
>      memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
>  }
>  
> +static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    if (ms->numa_state && spm->node >= ms->numa_state->num_nodes) {
> +        error_setg(errp,
> +                   "'node' property value %" PRIu32
> +                   " exceeds the number of NUMA nodes (%d)",
> +                   spm->node, ms->numa_state->num_nodes);
> +        return;
> +    }
> +    memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
> +}
> +
> +static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)

^^^ fix indent


> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
> +    uint64_t addr, size;
> +
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
> @@ -1326,6 +1359,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
> +        pc_sp_mem_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          x86_cpu_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -1370,6 +1405,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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


