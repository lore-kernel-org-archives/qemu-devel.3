Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA9DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuPu-0003gA-Sf; Tue, 09 Jun 2026 07:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWuPs-0003ft-6c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWuPp-0004PU-LT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781003680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdkVMVGtoy59iqPOwHbGtIE/43+sDgUaPj0ygDg9zxY=;
 b=PG49KAenOxfXHKmLM66GZOJjqqn2aAMKROV+Ksob8wckVODGFGuPdilzE6wTb0/n8pPwcU
 UQt32mGEYyt5ssAs2l0TVONAKpJnUPV8Tv44Z8guiC9grimLdHMIOllRcR4tP2zl7Edfmg
 fKeHa19SdHUaoT6jVWmenB2zT9ba15I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-k8oLuyyqOVWxK5ofS5qA3A-1; Tue, 09 Jun 2026 07:14:38 -0400
X-MC-Unique: k8oLuyyqOVWxK5ofS5qA3A-1
X-Mimecast-MFC-AGG-ID: k8oLuyyqOVWxK5ofS5qA3A_1781003677
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so39159985e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781003677; x=1781608477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdkVMVGtoy59iqPOwHbGtIE/43+sDgUaPj0ygDg9zxY=;
 b=iIB8jn/Ql5DGoskISOvm0HWZQuVNZDZCl/gWcmpCHJ7toOJNZTFmuVeZMk7vrfIzqG
 aNeQQbacgKbwZ7PDx/QDSNt2Ve7+UdChP9vqdOWjtB+9l3OvTM0oidKNKaLjs5Ig4cv9
 qBdfP/lVXB/n1oD4HopTWhh/VgFbeQqQFVO/fPnZga+Brr4vkTuIAq843ClyEIGJfG2I
 UYlf2jJfgYErafHP7Nuwc2PNzl4zfSf/Zy02rtQNqqRFwbHXtuygcQ9uQyGXIbGbl0/M
 laD76i8PA/LzKphTBvuqKdhfFgEOvnbpcEQI7pyrgbsS8KhZrfPVVE3WcOE8q6nGIbhQ
 ZZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781003677; x=1781608477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AdkVMVGtoy59iqPOwHbGtIE/43+sDgUaPj0ygDg9zxY=;
 b=YKathiZgyhgj+cY0Vt3KshoY9K+8P4dBYVVgJxe/65hm7gbGCYZi3qBg+eqryrxAVI
 37xurNslkmw5XWKLeBxqbRP4fhR6F60C38h/K2x2Q/IfK6WEIAGHmxpqMetdq+gMrSkX
 FlmROVnbNxwMP9L6k3gYNZNt/am9+cLR3KEf6zaEVnNgHU108xLgWDPI/MxscwvdB+QZ
 1CcrxYvfhp5utqGLkDxwccIpdusqQ3ogmuSnMoRQ0VM/fe4aXRATDn+997FiKl74by0M
 M9MAkp4EgTk0iQNWygzqcbDIGhEx2kEVjDj97odgsfcwaIUUCaKBCdeA3pGKMraCHLxb
 eT7w==
X-Gm-Message-State: AOJu0YyTLQfXCJek8CEBlaF1E9YLKewfuS7YSe0cKt9uPB0EZesSqsk1
 mRWuzB7VmqHVkJNex6/dH8c6cZW1Hv13xtJMiVl5kyJt8H6YWg7sZty8AaVFFNn1bawpR871ffm
 l/5KtczTUFy/XIgYrGS1Rbh2hruFDbuU6ij68Li4lf0VRvgrz6r+28KyB
X-Gm-Gg: Acq92OGWWyOiVA/xOyW0YMvmAFFMLbMlcV46XGbMSduSZ99ZqcbHtfpCCxrJ3lGyOvZ
 4Lj4Y6syAmW34EhusSbQlGYu5T2CnTgjKWvzP51z2Gm9R8TG231Ws2xGjeMTCHndukg8vTRM5Ih
 uGSil9BYRiPfZopHfdNlaz6Tr/wIX/a6R/v2hL0L3L0QvvSvshKNPapbdgJqIB+b/7BWNqwm+Au
 t13+5ar6jpfjedyuBggMtaj1n6zkmU/LzSGbvQbeJJQPr4wXcg7MyylZFbQmGROM/S1yJUyUG4X
 xCLKN+40sTPTRfe7WboLuaoKocG65DS/Qubi0XTmIm/TkvvLfBjSYtuuiRkvXVDJY/q9F0iSWY/
 RQH0qlbJFUBBUxfWt
X-Received: by 2002:a05:600c:1d0a:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-490d71ecbe8mr28973175e9.1.1781003677312; 
 Tue, 09 Jun 2026 04:14:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-490d71ecbe8mr28972815e9.1.1781003676939; 
 Tue, 09 Jun 2026 04:14:36 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm60276191f8f.21.2026.06.09.04.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:14:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:14:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v10 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Message-ID: <20260609131435.34646220@imammedo>
In-Reply-To: <20260605104609.1739911-3-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-3-FangSheng.Huang@amd.com>
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

On Fri, 5 Jun 2026 18:46:07 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Restructure the device_memory SRAT umbrella entry into a per-kind
> partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
> proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
> placeholders at the highest PXM, preserving the existing umbrella
> convention.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  hw/i386/acpi-build.c | 98 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d7c83d5e9..76efa83808 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -52,6 +52,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/mem/sp-mem.h"
>  #include "system/numa.h"
>  #include "system/reset.h"
>  #include "hw/hyperv/vmbus-bridge.h"
> @@ -1346,6 +1347,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  }
>  #endif
>  
> +typedef struct {
> +    uint64_t addr;
> +    uint64_t size;
> +    uint32_t node;
> +} SpMemRange;
> +
> +static int collect_sp_mem_ranges_cb(Object *obj, void *opaque)
sp_mem_collect... maybe

> +{
> +    GArray *ranges = opaque;
> +    SpMemDevice *spm;
> +    MemoryDeviceClass *mdc;
> +    SpMemRange r;
> +
> +    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
> +        return 0;
> +    }
> +    spm = SP_MEM(obj);
> +    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
> +    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
> +    r.size = memory_region_size(
> +                 host_memory_backend_get_memory(spm->hostmem));
> +    r.node = spm->node;
> +    g_array_append_val(ranges, r);
> +    return 0;
> +}
> +
> +static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
> +{
> +    const SpMemRange *range_a = a;
> +    const SpMemRange *range_b = b;
> +
> +    if (range_a->addr < range_b->addr) {
> +        return -1;
> +    }
> +    if (range_a->addr > range_b->addr) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Emit SRAT memory-affinity entries covering the device_memory region.
> + *
> + * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
> + * device's own proximity_domain.  All remaining sub-ranges (gaps
> + * between sp-mem devices, leading and trailing padding, and ranges
> + * occupied by other memory devices) are covered by HOTPLUGGABLE |
> + * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
> + */
> +static void build_srat_device_memory(GArray *table_data, MachineState *ms)
> +{
> +    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
> +    uint64_t cursor, end;
region_start, region_end

> +    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
> +    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;

when function is called ms->numa_state->num_nodes is always > 0, isn't it?

> +    guint i;
> +
> +    if (!ms->device_memory) {
> +        return;
> +    }
> +
> +    cursor = ms->device_memory->base;
> +    end = cursor + memory_region_size(&ms->device_memory->mr);
> +
> +    object_child_foreach_recursive(qdev_get_machine(),
> +                                   collect_sp_mem_ranges_cb, ranges);
> +    g_array_sort(ranges, sp_mem_range_compare);
> +
> +    for (i = 0; i < ranges->len; i++) {
> +        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
> +
> +        if (cursor < r->addr) {
> +            build_srat_memory(table_data, cursor, r->addr - cursor,
> +                              hotplug_pxm,
> +                              MEM_AFFINITY_HOTPLUGGABLE |
> +                              MEM_AFFINITY_ENABLED);
> +        }
> +        build_srat_memory(table_data, r->addr, r->size, r->node,
> +                          MEM_AFFINITY_ENABLED);
> +        cursor = r->addr + r->size;
> +    }
> +
> +    if (cursor < end) {
> +        build_srat_memory(table_data, cursor, end - cursor,
> +                          hotplug_pxm,
> +                          MEM_AFFINITY_HOTPLUGGABLE |
> +                          MEM_AFFINITY_ENABLED);
> +    }
> +}
> +
>  #define HOLE_640K_START  (640 * KiB)
>  #define HOLE_640K_END   (1 * MiB)
>  
> @@ -1481,12 +1572,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       * Memory devices may override proximity set by this entry,
>       * providing _PXM method if necessary.
>       */
> -    if (machine->device_memory) {
keep it here, and drop one in build_srat_device_memory()

> -        build_srat_memory(table_data, machine->device_memory->base,
> -                          memory_region_size(&machine->device_memory->mr),
> -                          nb_numa_nodes - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> -    }
> +    build_srat_device_memory(table_data, machine);
>  
>      acpi_table_end(linker, &table);
>  }


