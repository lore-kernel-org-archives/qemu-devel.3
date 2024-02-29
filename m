Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38993C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpYJ-0000Yl-Dw; Thu, 29 Feb 2024 18:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rfpY1-0000VJ-Jr
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:10:45 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rfpXl-0007xp-Kz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:10:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E1992CE1B22;
 Thu, 29 Feb 2024 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DF7C433F1;
 Thu, 29 Feb 2024 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709248219;
 bh=PGsZG3sU7hajT14NZwdUpq2C3rYv9teT56gyoIJ0P3s=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=p77jp8uduPUDTaJp2v38mcsWqHlje8fZHiub+sCfdF3kN15dy28vdCrk7uNsSiNlq
 CRZ1MIEVxT/gFrWsOAYLcp6AYcs5E4yz1bF0VxkeTZi4dPDH0IoF7xyZf45t0i6aMd
 tTAi/zdHOvs8OIRA5ArQtCAc54e0ECWijdri+rDbx6AtNJyxkvt/8ujvDMB3kUiwKX
 YuZFsk4CnTISF4nqmlUAnuoL/NmwdefePanMk63kkdJXecO4f803pLWVMyomF2Ktnq
 zOIvrChtbc3EPV6Rjy97ivHEtpUche0/Zfu1AbxWAAiZwwM2+S9xtSrYKSqJGIbChV
 ELyK/8bVMRD4g==
Date: Thu, 29 Feb 2024 15:10:16 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v3 6/7] xen: add map and unmap callbacks for grant
 region
In-Reply-To: <20240227223501.28475-7-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2402291510080.853156@ubuntu-linux-20-04-desktop>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-7-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 27 Feb 2024, Vikram Garhwal wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Add the callbacks for mapping/unmapping guest memory via grants to the
> special grant memory region.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 176 +++++++++++++++++++++++++++++++++++++++++-
>  system/physmem.c      |  11 ++-
>  2 files changed, 182 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 179b7e95b2..2e4c9b4947 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -9,6 +9,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/thread.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  
> @@ -23,6 +25,8 @@
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>  
> +#include <xenevtchn.h>
> +#include <xengnttab.h>
>  
>  #if HOST_LONG_BITS == 32
>  #  define MCACHE_BUCKET_SHIFT 16
> @@ -377,7 +381,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>      return p;
>  }
>  
> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +static ram_addr_t xen_ram_addr_from_mapcache_try(void *ptr)
>  {
>      MapCacheEntry *entry = NULL;
>      MapCacheRev *reventry;
> @@ -588,10 +592,179 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>      return p;
>  }
>  
> +struct XENMappedGrantRegion {
> +    void *addr;
> +    unsigned int pages;
> +    unsigned int refs;
> +    unsigned int prot;
> +    uint32_t idx;
> +    QLIST_ENTRY(XENMappedGrantRegion) list;
> +};
> +
> +static xengnttab_handle *xen_region_gnttabdev;
> +static QLIST_HEAD(GrantRegionList, XENMappedGrantRegion) xen_grant_mappings =
> +    QLIST_HEAD_INITIALIZER(xen_grant_mappings);
> +static QemuMutex xen_map_mutex;
> +
> +static void *xen_map_grant_dyn(MemoryRegion **mr, hwaddr addr, hwaddr *plen,
> +                               bool is_write, MemTxAttrs attrs)
> +{
> +    unsigned int page_off = addr & (XC_PAGE_SIZE - 1);
> +    unsigned int i;
> +    unsigned int total_grants = 0;
> +    unsigned int nrefs = (page_off + *plen + XC_PAGE_SIZE - 1) >> XC_PAGE_SHIFT;
> +    uint32_t ref = (addr - XEN_GRANT_ADDR_OFF) >> XC_PAGE_SHIFT;
> +    uint32_t *refs = NULL;
> +    unsigned int prot = PROT_READ;
> +    struct XENMappedGrantRegion *mgr = NULL;
> +
> +    if (is_write) {
> +        prot |= PROT_WRITE;
> +    }
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->idx == ref &&
> +            mgr->pages == nrefs &&
> +            (mgr->prot & prot) == prot) {
> +            break;
> +        }
> +
> +        total_grants += mgr->pages;
> +    }
> +
> +    if (!mgr) {
> +        if (nrefs + total_grants >= XEN_MAX_VIRTIO_GRANTS) {
> +            qemu_mutex_unlock(&xen_map_mutex);
> +            return NULL;
> +        }
> +
> +        mgr = g_new(struct XENMappedGrantRegion, 1);
> +
> +        if (nrefs == 1) {
> +            refs = &ref;
> +        } else {
> +            refs = g_new(uint32_t, nrefs);
> +            for (i = 0; i < nrefs; i++) {
> +                refs[i] = ref + i;
> +            }
> +        }
> +        mgr->addr = xengnttab_map_domain_grant_refs(xen_region_gnttabdev, nrefs,
> +                                                    xen_domid, refs, prot);
> +        if (mgr->addr) {
> +            mgr->pages = nrefs;
> +            mgr->refs = 1;
> +            mgr->prot = prot;
> +            mgr->idx = ref;
> +
> +            QLIST_INSERT_HEAD(&xen_grant_mappings, mgr, list);
> +        } else {
> +            g_free(mgr);
> +            mgr = NULL;
> +        }
> +    } else {
> +        mgr->refs++;
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +
> +    if (nrefs > 1) {
> +        g_free(refs);
> +    }
> +
> +    return mgr ? mgr->addr + page_off : NULL;
> +}
> +
> +static void xen_unmap_grant_dyn(MemoryRegion *mr, void *buffer, ram_addr_t addr,
> +                                hwaddr len, bool is_write, hwaddr access_len)
> +{
> +    unsigned int page_off = (unsigned long)buffer & (XC_PAGE_SIZE - 1);
> +    unsigned int nrefs = (page_off + len + XC_PAGE_SIZE - 1) >> XC_PAGE_SHIFT;
> +    unsigned int prot = PROT_READ;
> +    struct XENMappedGrantRegion *mgr = NULL;
> +
> +    if (is_write) {
> +        prot |= PROT_WRITE;
> +    }
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->addr == buffer - page_off &&
> +            mgr->pages == nrefs &&
> +            (mgr->prot & prot) == prot) {
> +            break;
> +        }
> +    }
> +    if (mgr) {
> +        mgr->refs--;
> +        if (!mgr->refs) {
> +            xengnttab_unmap(xen_region_gnttabdev, mgr->addr, nrefs);
> +
> +            QLIST_REMOVE(mgr, list);
> +            g_free(mgr);
> +        }
> +    } else {
> +        error_report("xen_unmap_grant_dyn() trying to unmap unknown buffer");
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +}
> +
> +static ram_addr_t xen_ram_addr_from_grant_cache(void *ptr)
> +{
> +    unsigned int page_off = (unsigned long)ptr & (XC_PAGE_SIZE - 1);
> +    struct XENMappedGrantRegion *mgr = NULL;
> +    ram_addr_t raddr = RAM_ADDR_INVALID;
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->addr == ptr - page_off) {
> +            break;
> +        }
> +    }
> +
> +    if (mgr) {
> +        raddr = (mgr->idx << XC_PAGE_SHIFT) + page_off + XEN_GRANT_ADDR_OFF;
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +
> +    return raddr;
> +}
> +
> +ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +{
> +    ram_addr_t raddr;
> +
> +    raddr = xen_ram_addr_from_mapcache_try(ptr);
> +    if (raddr == RAM_ADDR_INVALID) {
> +        raddr = xen_ram_addr_from_grant_cache(ptr);
> +    }
> +
> +    return raddr;
> +}
> +
> +static const struct MemoryRegionOps xen_grant_mr_ops = {
> +    .map = xen_map_grant_dyn,
> +    .unmap = xen_unmap_grant_dyn,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  MemoryRegion *xen_init_grant_ram(void)
>  {
>      RAMBlock *block;
>  
> +    qemu_mutex_init(&xen_map_mutex);
> +
> +    xen_region_gnttabdev = xengnttab_open(NULL, 0);
> +    if (xen_region_gnttabdev == NULL) {
> +        fprintf(stderr, "can't open gnttab device\n");
> +        return NULL;
> +    }
> +
>      memory_region_init(&ram_grants, NULL, "xen.grants",
>                         XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE);
>      block = g_malloc0(sizeof(*block));
> @@ -606,6 +779,7 @@ MemoryRegion *xen_init_grant_ram(void)
>      ram_grants.ram_block = block;
>      ram_grants.ram = true;
>      ram_grants.terminates = true;
> +    ram_grants.ops = &xen_grant_mr_ops;
>      ram_block_add_list(block);
>      memory_region_add_subregion(get_system_memory(), XEN_GRANT_ADDR_OFF,
>                                  &ram_grants);
> diff --git a/system/physmem.c b/system/physmem.c
> index d989e9fc1f..e6fc075d8f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2232,13 +2232,16 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  
>      if (xen_enabled()) {
>          ram_addr_t ram_addr;
> +
>          RCU_READ_LOCK_GUARD();
>          ram_addr = xen_ram_addr_from_mapcache(ptr);
> -        block = qemu_get_ram_block(ram_addr);
> -        if (block) {
> -            *offset = ram_addr - block->offset;
> +        if (ram_addr != RAM_ADDR_INVALID) {
> +            block = qemu_get_ram_block(ram_addr);
> +            if (block) {
> +                *offset = ram_addr - block->offset;
> +            }
> +            return block;
>          }
> -        return block;
>      }
>  
>      RCU_READ_LOCK_GUARD();
> -- 
> 2.17.1
> 

