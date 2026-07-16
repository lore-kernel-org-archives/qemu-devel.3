Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA37C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPgg-0001bH-Ar; Thu, 16 Jul 2026 13:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wkPgc-0001XN-Kt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:15:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wkPgZ-0008H8-QH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:15:50 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id D1E5F20B7167;
 Thu, 16 Jul 2026 10:15:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1E5F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784222136;
 bh=4I192PBpJlHkSlIakbjHa+Nt2Q62XhHE90XMvtWvG5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lwOvwnKsincILXuYWef8EleDO4pQco2QcqWbNNouLUJSGjgLYUSMJFnXwFxc2Y2Nv
 ppuR/8ULQj81NLQVGJaChnzKMzYfDKwcACj5c/RIwUmnSN3D5FIdM/L9btk5O2pL4e
 bUXgnMg1UaARRsfL9kIOC6iPMsd42k42srR3V9zg=
Date: Thu, 16 Jul 2026 20:15:35 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: Re: [PATCH] accel/mshv: skip double unmap of mem regions
Message-ID: <alkRt7MVMCUZX02v@linux.microsoft.com>
References: <20260326144000.492037-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326144000.492037-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Mar 26, 2026 at 03:40:00PM +0100, Magnus Kulke wrote:
> This change addresses a regression that was introduced when the dynamic
> mapping handler was removed, from the MSHV controller, breaking OVMF
> support.
> 
> We introduce a small uaddr-indexed table to track mapped regions. The
> current logic turns an add into a remove op if a rom-device region is
> currently not in romd_mode.
> 
> We could ignore both map + unmap for this condition, but this misses a
> the case of a region transitioning from romd_mode=true => false. In this
> case we still do want to unmap a region.
> 
> Fixes: 626e5dc999 (Remove remap overlapping mappings code)
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mem.c          | 41 ++++++++++++++++++++++++++++++++++++---
>  accel/mshv/mshv-all.c     |  1 +
>  include/system/mshv_int.h |  1 +
>  3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
> index e55c38d4db..db28dcd83c 100644
> --- a/accel/mshv/mem.c
> +++ b/accel/mshv/mem.c
> @@ -12,6 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "linux/mshv.h"
>  #include "system/address-spaces.h"
>  #include "system/mshv.h"
> @@ -165,6 +166,25 @@ static hwaddr align_section(MemoryRegionSection *section, hwaddr *start)
>      return (size - delta) & qemu_real_host_page_mask();
>  }
>  
> +static bool uaddr_is_mapped(MshvMemoryListener *mml, hwaddr start_addr)
> +{
> +    assert(bql_locked());
> +
> +    return g_hash_table_contains(mml->mapped_regions,
> +                                 GINT_TO_POINTER(start_addr));
> +}
> +
> +static void track_region(MshvMemoryListener *mml, hwaddr start_addr, bool add)
> +{
> +    assert(bql_locked());
> +
> +    if (add) {
> +        g_hash_table_add(mml->mapped_regions, GINT_TO_POINTER(start_addr));
> +    } else {
> +        g_hash_table_remove(mml->mapped_regions, GINT_TO_POINTER(start_addr));
> +    }
> +}
> +
>  void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>                         bool add)
>  {
> @@ -173,15 +193,19 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>      bool writable = !area->readonly && !area->rom_device;
>      hwaddr start_addr, mr_offset, size;
>      void *ram;
> +    bool is_mapped;
>      MshvMemoryRegion mshv_mr = {0};
>  
>      size = align_section(section, &start_addr);
>      trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
>  
>      /*
> -     * If the memory device is a writable non-ram area, we do not
> -     * want to map it into the guest memory. If it is not a ROM device,
> -     * we want to remove mshv memory mapping, so accesses will trap.
> +     * ROM devices (e.g. pflash) have ram=false, rom_device=true.
> +     * In romd_mode, they behave like RAM and should be mapped.
> +     * Outside romd_mode, accesses should trap to QEMU for emulation.
> +     *
> +     * For non-RAM, non-rom_device regions (writable MMIO), we never map.
> +     * For rom_device regions not in romd_mode, we want them unmapped.
>       */
>      if (!memory_region_is_ram(area)) {
>          if (writable) {
> @@ -195,6 +219,15 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>          return;
>      }
>  
> +    is_mapped = uaddr_is_mapped(mml, start_addr);
> +
> +    if (add && is_mapped) {
> +        return;
> +    }
> +    if (!add && !is_mapped) {
> +        return;
> +    }
> +
>      mr_offset = section->offset_within_region + start_addr -
>                  section->offset_within_address_space;
>  
> @@ -210,4 +243,6 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>          error_report("Failed to set memory region");
>          abort();
>      }
> +
> +    track_region(mml, start_addr, add);
>  }
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d4cc7f5371..0a30149030 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -371,6 +371,7 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
>  
>      mml->listener = mshv_memory_listener;
>      mml->listener.name = name;
> +    mml->mapped_regions = g_hash_table_new(g_direct_hash, g_direct_equal);
>      memory_listener_register(&mml->listener, as);
>      for (i = 0; i < s->nr_as; ++i) {
>          if (!s->as[i].as) {
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 35386c422f..4aa1b6962d 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -32,6 +32,7 @@ struct AccelCPUState {
>  
>  typedef struct MshvMemoryListener {
>      MemoryListener listener;
> +    GHashTable *mapped_regions;
>      int as_id;
>  } MshvMemoryListener;
>  
> -- 
> 2.34.1
> 
> 

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

