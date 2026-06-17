Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED116CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoEH-00039O-AG; Wed, 17 Jun 2026 07:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZoED-00038y-Pz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZoEB-0000xJ-OP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781694878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcHNDihXIUiDxWQD5o8ftLCwhJmfn66XCK/xyjTuzEI=;
 b=BxquCS7cOIC1QK7IR/nQLes8I1HtOXwt+ruqkSSs2RAb9wP+P6cXsPMFrj/MYsBjke28NB
 6YF8IPkU+fasUlxQl+DoniiSZjP9spEoLLoxG1wqxAKwusmT/kMrv8KY0h/LaOpzC9eLP+
 6bFYNfmaiIFpEZv0TchLZF7y1gIL51s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Ox8fm4mpMzqb2E9gu1GMRQ-1; Wed, 17 Jun 2026 07:14:36 -0400
X-MC-Unique: Ox8fm4mpMzqb2E9gu1GMRQ-1
X-Mimecast-MFC-AGG-ID: Ox8fm4mpMzqb2E9gu1GMRQ_1781694875
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-461c8319c73so995729f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781694875; x=1782299675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcHNDihXIUiDxWQD5o8ftLCwhJmfn66XCK/xyjTuzEI=;
 b=Q1CyVQA51J65Vxkw+z4al+SNaiL+xE8ojIWSdu9xL3/QliCUOEnqshp+Ys8LO1QOBH
 W6cnXGGrxWieK1TQ8Zg0sRFJLt9ViVcSzuengJtX5hngmw70E/8VU6EmzQ1lcypmdDYO
 yygoHQhEj9e1MiUxS/0sUucKDwKByLVX/dIcqwgDEOnX7rxRN206cUW8YquKEQOSe6Hb
 iAj221s2Lei1fO0RPdNLNso8SsaXSI7/cmt5v5Pm8ochtZ+EvRfIG9CxYYtBasDFVE5t
 x0s5J7CmNHlWBuja2jUtw1MoRfUaa89bNKM3Lp42XtSNSurC8CVrfMF8yhcRhru04XfY
 fuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781694875; x=1782299675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcHNDihXIUiDxWQD5o8ftLCwhJmfn66XCK/xyjTuzEI=;
 b=VLeneVA6sTe5xbNoq8K3AqcBHTbJ+rqFQky9GeIG5TJYUiKmH3XcT/FFZwDBI+9dSF
 2NmMkv/uTrcZ4igbsE7XuId96pg3TbJPxkvyPsBCOsZRuvJcrIfHv2Y8aVh2Z8tg7fW7
 7HMTk0c3DzXR/2LpSZopW7wk15vu4mUyXUAe4w8tlB/aV5AIt/Y6WlM+5iHEhkTHr0La
 epiWxby6oMBXtMUh6j2Upa4qzugC7Yt0t5cAdcMqSFm9Y7U1ow4qLlPoR1j+EKt84BYw
 KpjVAcOfQseky2KHmUA/ciQXhWZ1MQy63pZSTK1dxKp2b2uTu4SXOSPRq+/mlVMvY4JI
 IpuA==
X-Gm-Message-State: AOJu0YxXU3sBo1cv9grbh2IgQ1gzs2QDeZ4yN4Y2CgzpqLlzRgsYVHwl
 vvNjoMMqAsXULojkvM8NTtIaGYeVQqxHmA7OO3RvsIPRU6N0+75cTiJvoSUMGhIVwjZmDlvJ8ze
 w8HQjDO5kbXv8BKkfEOTOeCNfVHtBSmTYkdF2o+z7ROWR7CHbUeh2bou5
X-Gm-Gg: AfdE7clX9rkiUUpMPF2pxQtcv43pw7CO6FYdKQtwqTqBJVihGdjBJdaoDZLFDHvdV2M
 IpiLZCFBbOGVuqaiWocohh241uYZgB3Q6UIhfdPflQ5PIdUgA3LynqwU6sAeWf0Nq0Vjuz2TKIb
 lKPV8NvCnzULg1OFq+4QithMxRdcc/dGWSfPOX1TvGAt8AgovGnh8B5+S6TPBZlT05Bp7o5+AWz
 ru+nD0Dqq/M5M6IyJVkGgiQtncTv1xXkEJcegW37N3+ZSAYj+x101Z4xLhbn4B+hcXDCyeImfos
 1vrvE189mZt2rTw2QG9KZOkvLb+axCCOT1VmxVwZCogQIQuF/pHo+/LtyWdrb0KyqCPKQCM=
X-Received: by 2002:a5d:5443:0:b0:45e:d3d4:c230 with SMTP id
 ffacd0b85a97d-4623955bc53mr4404067f8f.38.1781694874729; 
 Wed, 17 Jun 2026 04:14:34 -0700 (PDT)
X-Received: by 2002:a5d:5443:0:b0:45e:d3d4:c230 with SMTP id
 ffacd0b85a97d-4623955bc53mr4404008f8f.38.1781694874106; 
 Wed, 17 Jun 2026 04:14:34 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm52557061f8f.21.2026.06.17.04.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:14:33 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:14:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v12 3/4] hw/i386: hook sp-mem into the pc machine plug path
Message-ID: <20260617131432.5c186219@imammedo>
In-Reply-To: <20260616090808.3047939-4-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
 <20260616090808.3047939-4-FangSheng.Huang@amd.com>
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

On Tue, 16 Jun 2026 17:08:07 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
> placed by the memory-device framework and reported to the guest as
> E820_SOFT_RESERVED.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

see below comment below wrt testing but otherwise:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


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
> index 7b6ad97e5a..ec3459389b 100644
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
> @@ -1283,11 +1284,43 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
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

We haven't been testing e820 (lack of coverage mostly historical due to
it being mostly static not touched code).
But I think we should add tests for it. (something similar to bios-tables-test)
 
1st add clean slate test before your change, and then build/add on top to
make sure we do not regress, whatever existed before.

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
> @@ -1324,6 +1357,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
> +        pc_sp_mem_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          x86_cpu_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> @@ -1368,6 +1403,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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


