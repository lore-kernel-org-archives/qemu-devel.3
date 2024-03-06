Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E0C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhu83-0006sJ-IH; Wed, 06 Mar 2024 11:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhu81-0006qh-7B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:28:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhu7x-0005k6-DS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:28:24 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqd6r69FZz6K8tX;
 Thu,  7 Mar 2024 00:24:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E8F351400D7;
 Thu,  7 Mar 2024 00:28:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 16:28:17 +0000
Date: Wed, 6 Mar 2024 16:28:16 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240306162816.00002e0e@Huawei.com>
In-Reply-To: <20240304194331.1586191-7-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon,  4 Mar 2024 11:34:01 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all dc regions share one
>    host backend.
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region;
> 4. Fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan, 

This one has a few more significant comments inline.

thanks,

Jonathan

> ---

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c045fee32d..2b380a260b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -45,7 +45,8 @@ enum {
>  
>  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>                                            int dsmad_handle, uint64_t size,
> -                                          bool is_pmem, uint64_t dpa_base)
> +                                          bool is_pmem, bool is_dynamic,
> +                                          uint64_t dpa_base)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;

There is a fixlet going through for these as the autofree doesn't do anything.
Will require a rebase.  I'll do it on my tree, but might not push that out for a
few days so this is just a heads up for anyone using these.

https://lore.kernel.org/qemu-devel/20240304104406.59855-1-thuth@redhat.com/

It went in clean for me, so may not even be something anyone notices!

> @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
>          .DPA_base = dpa_base,
>          .DPA_length = size,
>      };
> @@ -149,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      g_autofree CDATSubHeader **table = NULL;
>  
>  
> @@ -176,21 +179,55 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>          pmr_size = memory_region_size(nonvolatile_mr);
>      }
>  
> +    if (ct3d->dc.num_regions) {
> +        if (ct3d->dc.host_dc) {
> +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +            if (!dc_mr) {
> +                return -EINVAL;
> +            }
> +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> +        } else {
> +            return -EINVAL;

Flip logic to get the error out the way first and reduce indent.

     if (ct3d->dc.num_regions) {
        if (!ct3d->dc.host_dc) {
            return -EINVAL;
        }
        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
        if (!dc_mr) {
            return -EINVAL;
        }
        len += CT3...
     }

> +        }
> +    }
> +

>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -300,11 +337,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>              range2_size_hi = ct3d->hostpmem->size >> 32;
>              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                               (ct3d->hostpmem->size & 0xF0000000);
> +        } else if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
>          }
> -    } else {
> +    } else if (ct3d->hostpmem) {
>          range1_size_hi = ct3d->hostpmem->size >> 32;
>          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                           (ct3d->hostpmem->size & 0xF0000000);
> +        if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
> +        }
> +    } else {
> +        range1_size_hi = ct3d->dc.host_dc->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                         (ct3d->dc.host_dc->size & 0xF0000000);

I've forgotten if we ever closed out on the right thing to do
with the legacy range registers.   Maybe, just ignoring DC is the
right option for now?  So I'd drop this block of changes.
Maybe Linux will do the wrong thing if we do, but then we should
make Linux more flexible on this.

If we did get a clarification that this is the right way to go
then add a note here.


>      }
>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> @@ -579,11 +629,27 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>  {
>      int i;
>      uint64_t region_base = 0;
> -    uint64_t region_len =  2 * GiB;
> -    uint64_t decode_len = 2 * GiB;
> +    uint64_t region_len;
> +    uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
>      CXLDCRegion *region;
>      MemoryRegion *mr;
> +    uint64_t dc_size;
> +
> +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +    dc_size = memory_region_size(mr);
> +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> +
> +    if (region_len * ct3d->dc.num_regions > dc_size) {
This check had me scratching my head for a minute.
Why not just check

	if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLER) != 0) {
		error_setg(errp, "host backend must by a multiple of 256MiB and region len);
		return false;
	}
> +        error_setg(errp, "host backend size must be multiples of region len");
> +        return false;
> +    }
> +    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
> +        error_setg(errp, "DC region size is unaligned to %lx",
> +                   CXL_CAPACITY_MULTIPLIER);
> +        return false;
> +    }
> +    decode_len = region_len;




> @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>                                         AddressSpace **as,
>                                         uint64_t *dpa_offset)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(vmr);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(pmr);
> +    }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        /* Do we want dc_size to be dc_mr->size or not?? */

Maybe - definitely don't want to leave this comment here
unanswered and I think you enforce it above anyway.

So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
As such we could just not stash total_capacity at all?


> +        dc_size = ct3d->dc.total_capacity;
>      }


