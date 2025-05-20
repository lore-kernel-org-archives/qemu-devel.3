Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C66C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTFo-0005qH-9b; Tue, 20 May 2025 16:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHTFO-0005oX-El
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:07:39 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHTFL-0000e2-3B
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:07:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 21E23A4EE5E;
 Tue, 20 May 2025 20:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810A4C4CEE9;
 Tue, 20 May 2025 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747771648;
 bh=GRKumoL2rpa9v8LuupZgj5Z40OqQlw5yok9CFvQ9Rqo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iT7AdcJegF47FkybE+tPMKpRA775XTgw9N8siJUiFYsAz1HI0AgR2YV3TWUohjXro
 +2RDCVQwwU8BWuK1Hn3dK22V6VgOabPW23ou3kM0zznhizpxnZ15WlMrJ4uUVT8x6A
 LW3AqF3KI2ISvmrc7nEayqPuZLosUxAa3+aOKQCkJDbvltJe9ppv02R7TPZuUuBdwa
 Mwg2rOMOLIdqLxkxDKp7M59Rmmye1PdGMSUaCSAqKBcqhEERWlMFmkJSXmgMkMtAr6
 icxgvq/WtPe9/7lsKohQJRLKObgEAUcOX9ibwLM1to4Npw8uiDRiYpqEe/pp3PZ4Hr
 ujpfElLey/03Q==
Date: Tue, 20 May 2025 20:07:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 09/25] accel/mshv: Register guest memory regions with
 hypervisor
Message-ID: <aCzg__6lGlvypZMB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-10-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-10-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=wei.liu@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 20, 2025 at 01:30:02PM +0200, Magnus Kulke wrote:
> Handle region_add events by invoking the MSHV memory registration
> ioctl to map guest memory into the hypervisor partition. This allows
> the guest to access memory through MSHV-managed mappings.
> 
> Note that this assumes the hypervisor will accept regions that overlap
> in userspace_addr. Currently that's not the case, it will be addressed
> in a later commit in the series.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mem.c        | 116 ++++++++++++++++++++++++++++++++++++++--
>  accel/mshv/trace-events |   1 +
>  include/system/mshv.h   |  11 ++++
>  3 files changed, 125 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
> index eddd83ae83..2bbeae4f4a 100644
> --- a/accel/mshv/mem.c
> +++ b/accel/mshv/mem.c
> @@ -13,13 +13,123 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "hw/hyperv/linux-mshv.h"
>  #include "system/address-spaces.h"
>  #include "system/mshv.h"
> +#include "exec/memattrs.h"
> +#include <sys/ioctl.h>
> +#include "trace.h"
> +
> +static int set_guest_memory(int vm_fd, const mshv_user_mem_region *region)
> +{
> +    int ret;
> +
> +    ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
> +    if (ret < 0) {
> +        error_report("failed to set guest memory");
> +        return -errno;
> +    }
> +
> +    return 0;
> +}
> +
> +static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool add)

Change "add" to "map" to match the name of the function.

> +{
> +    struct mshv_user_mem_region region = {0};
> +
> +    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
> +    region.size = mr->memory_size;
> +    region.userspace_addr = mr->userspace_addr;
> +
> +    if (!add) {
> +        region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);

Use BIT() like you did in other places?

> +        return set_guest_memory(vm_fd, &region);
> +    }
> +
> +    region.flags = (1 << MSHV_SET_MEM_BIT_EXECUTABLE);

Should this be always set? Is there a way to get more information from
the caller or QEMU's core memory region management logic?

> +    if (!mr->readonly) {
> +        region.flags |= (1 << MSHV_SET_MEM_BIT_WRITABLE);
> +    }
> +
> +    return set_guest_memory(vm_fd, &region);
> +}
> +
> +static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
> +{
> +    int ret = 0;
> +
> +    if (!mshv_mr) {
> +        error_report("Invalid mshv_mr");
> +        return -1;
> +    }
> +
> +    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
> +                          mshv_mr->memory_size,
> +                          mshv_mr->userspace_addr, mshv_mr->readonly,
> +                          ret);
> +    return map_or_unmap(mshv_state->vm, mshv_mr, add);
> +}
> +
> +/*
> + * Calculate and align the start address and the size of the section.
> + * Return the size. If the size is 0, the aligned section is empty.
> + */
> +static hwaddr align_section(MemoryRegionSection *section, hwaddr *start)
> +{
> +    hwaddr size = int128_get64(section->size);
> +    hwaddr delta, aligned;
> +
> +    /*
> +     * works in page size chunks, but the function may be called
> +     * with sub-page size and unaligned start address. Pad the start
> +     * address to next and truncate size to previous page boundary.
> +     */
> +    aligned = ROUND_UP(section->offset_within_address_space,
> +                       qemu_real_host_page_size());
> +    delta = aligned - section->offset_within_address_space;
> +    *start = aligned;
> +    if (delta > size) {
> +        return 0;
> +    }
> +
> +    return (size - delta) & qemu_real_host_page_mask();
> +}
>  
>  void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>                         bool add)
>  {
> -	error_report("unimplemented");
> -	abort();
> -}
> +    int ret = 0;
> +    MemoryRegion *area = section->mr;
> +    bool writable = !area->readonly && !area->rom_device;
> +    hwaddr start_addr, mr_offset, size;
> +    void *ram;
> +    MshvMemoryRegion tmp, *mshv_mr = &tmp;
> +
> +    if (!memory_region_is_ram(area)) {
> +        if (writable) {
> +            return;
> +        }
> +    }
> +

I don't follow the check here. Can you put in a comment?

Thanks,
Wei.

> +    size = align_section(section, &start_addr);
> +    if (!size) {
> +        return;
> +    }
> +
> +    mr_offset = section->offset_within_region + start_addr -
> +                section->offset_within_address_space;
>  
> +    ram = memory_region_get_ram_ptr(area) + mr_offset;
> +
> +    memset(mshv_mr, 0, sizeof(*mshv_mr));
> +    mshv_mr->guest_phys_addr = start_addr;
> +    mshv_mr->memory_size = size;
> +    mshv_mr->readonly = !writable;
> +    mshv_mr->userspace_addr = (uint64_t)ram;
> +
> +    ret = set_memory(mshv_mr, add);
> +    if (ret < 0) {
> +        error_report("Failed to set memory region");
> +        abort();
> +    }
> +}

