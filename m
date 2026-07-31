Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8572EC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpkOy-0003Kp-4k; Fri, 31 Jul 2026 06:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpkOv-0003KU-Gn
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:23:38 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpkOt-0002bL-Ad
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:23:37 -0400
Received: from [192.168.106.196]
 (dynamic-077-002-060-183.77.2.pool.telefonica.de [77.2.60.183])
 by csgraf.de (Postfix) with ESMTPSA id 003D5608027F;
 Fri, 31 Jul 2026 12:23:31 +0200 (CEST)
Message-ID: <5bb69baf-a00f-4b71-8065-90a7cfc7da8b@csgraf.de>
Date: Fri, 31 Jul 2026 12:23:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>
Cc: graf@amazon.com, qemu-devel@nongnu.org
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-6-anisinha@redhat.com>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20260730071254.80695-6-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 30.07.26 09:12, Ani Sinha wrote:
> VM launch update is a mechanism where the virtual machines can use IGVM
> file bundle to boot into a trusted execution environment without
> having to depend on a untrusted party to provide the IGVM bundle or firmware
> image. This is particularly useful for confidential virtual machines that
> are deployed in the cloud where the tenant and the cloud provider are two
> different entities. In this scenario, virtual machines can bring their own
> trusted IGVM file containing a trusted firmware image
> bundled as a part of their filesystem and then use this hypervisor interface
> to update to a trusted and deterministic boot state.
> This also allows the guests to have a consistent measurements on the firmware
> image.
>
> Currently, this mechanism only works if the VM was started with IGVM in the
> first place.
>
> This change introduces support for the fw-cfg based hypervisor interface
> and the corresponding device. The interface is made generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they are
> running their own trusted boot state) without the hypervisor getting
> involved in between.
>
> Currently, this device is only supported for x86 machines. Presence of
> IGVM host libraries is also required for parsing IGVM files. Hence, the device
> cannot be initialized for other machine types or hosts where IGVM support
> is not present. Trying to initialize it for arm for example will lead to failure:
>
> $ ./qemu-system-arm -device vm-launch-update -machine virt
> qemu-system-arm: -device vmfwupdate: This machine does not support vm-launch-update device
>
> Functional and qtests will be added in a subsequent patch.
>
> CC: Alex Graf <graf@amazon.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/misc/meson.build              |   3 +
>   hw/misc/trace-events             |   6 +
>   hw/misc/vmlaunchupdate.c         | 309 +++++++++++++++++++++++++++++++
>   include/hw/misc/vmlaunchupdate.h |  38 ++++
>   4 files changed, 356 insertions(+)
>   create mode 100644 hw/misc/vmlaunchupdate.c
>   create mode 100644 include/hw/misc/vmlaunchupdate.h
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..b8c7de295e 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -163,6 +163,9 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>   
>   specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
>   specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
> +if igvm.found()
> +   specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
> +endif
>   
>   system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..2d6d2238c5 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,9 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>   iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>   iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>   iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# vmlaunchupdate.c
> +launch_update_write(void) ""
> +vmlaunch_reset_enter(void) ""
> +vm_launchupdate_finalize(void) ""
> +restore_host_x86_igvm(void) ""
> diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
> new file mode 100644
> index 0000000000..5b0222310b
> --- /dev/null
> +++ b/hw/misc/vmlaunchupdate.c
> @@ -0,0 +1,309 @@
> +/*
> + * Guest driven VM launch component update (using IGVM) device
> + * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
> + *
> + * Copyright (C) 2026 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "system/physmem.h"
> +#include "system/reset.h"
> +#include "qemu/target-info-qapi.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/i386/pc.h"
> +#include "exec/cpu-common.h"
> +#include "hw/misc/vmlaunchupdate.h"
> +#include "system/igvm.h"
> +#include "system/igvm-internal.h"
> +#include "qemu/error-report.h"
> +#include "trace.h"
> +
> +/* returns NULL unless there is exactly one device */
> +static VMLaunchUpdateState *vm_launchupdate_find(void)
> +{
> +    Object *o = object_resolve_path_type("", TYPE_VMLAUNCHUPDATE, NULL);
> +
> +    return o ? VMLAUNCHUPDATE(o) : NULL;
> +}
> +
> +static bool vmlaunchupdate_supported(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_X86_64;
> +}
> +
> +static void init_vm_launch_update(VMLaunchUpdateState *s)
> +{
> +    s->launch_update.capabilities = VM_LAUNCHUPDATE_FORMAT_IGVM;
> +    s->launch_update.control = 0;
> +
> +    if (s->disabled) {
> +        s->launch_update.control |= VM_LAUNCHUPDATE_CTL_DISABLE;
> +    }
> +
> +    s->launch_update.version = VM_LAUNCHUPDATE_VERSION;
> +    return;
> +}
> +
> +static void clear_init_vm_launch_update(VMLaunchUpdateState *s)
> +{
> +    memset(&s->launch_update, 0, sizeof(s->launch_update));
> +    init_vm_launch_update(s);
> +}
> +
> +static int process_x86_igvm(VMLaunchUpdateState *s,
> +                            uint64_t fw_image_addr, uint64_t fw_image_size)
> +{
> +    X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
> +    IgvmCfg *igvmc = x86machine->igvm;
> +    IgvmHandle igvm;
> +    void *image_addr_ptr;
> +    hwaddr len;
> +
> +    if (!igvmc) {
> +        /* The VM was not started with an IGVM, bail */
> +        info_report("guest was not initially started with IGVM, "
> +                    "not changing launch state.");
> +        return -2;
> +    }
> +
> +    if (!fw_image_addr || !fw_image_size) {
> +        return -1;
> +    }
> +
> +    len = (hwaddr) fw_image_size;
> +    image_addr_ptr = physical_memory_map((hwaddr) fw_image_addr,
> +                                         (hwaddr *) &len, 0);
> +
> +    if (!image_addr_ptr || (len < fw_image_size)) {
> +        warn_report("vmlaunchupdate: Invalid guest addresses.");
> +        physical_memory_unmap(image_addr_ptr, len, 0, 0);


On !image_addr_ptr, wouldn't this invoke unmap(NULL)?


> +        return -1;
> +    }
> +
> +    igvm = igvm_new_from_binary(image_addr_ptr, fw_image_size);
> +    if (igvm < 0) {
> +        warn_report("vmlaunchupdate: Unable to parse IGVM file %"
> +                    PRIx64 ": %" PRIx64, fw_image_addr, fw_image_size);


Don't we need to unmap here as well, like above?

I think the best way to make this code pretty is a goto err with 
conditional unmap.


> +        return -1;
> +    }
> +
> +    /* free previous file context */
> +    if (igvmc->file >= 0) {
> +        igvm_free(igvmc->file);
> +    }
> +    /* set new context */
> +    igvmc->file = igvm;
> +
> +    physical_memory_unmap(image_addr_ptr, len, 0, 0);
> +    info_report("vmlaunchupdate: new IGVM context set.");
> +
> +    return 0;
> +}
> +
> +static void restore_host_x86_igvm(void)
> +{
> +    X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
> +    IgvmCfg *igvmc = x86machine->igvm;


The igvm property can be NULL, if nobody set igvm-cfg. So if you launch 
QEMU with just "-device vm-launch-update", it will crash here. You check 
it above in process_x86_igvm(), but not here. Maybe create a generic 
function that does the info_report and bails out?


> +    Error *errp;


Please always preinitialize errp with NULL. Typically callers expects 
that it's NULL, so they can choose not to touch it on error.


Alex


