Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1B5C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rshHq-000086-CW; Fri, 05 Apr 2024 06:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rshHo-00007j-VZ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:59:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rshHm-0003b7-B8
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:59:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9wNC6VGKz67RYs;
 Fri,  5 Apr 2024 18:54:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 69F9B1400CD;
 Fri,  5 Apr 2024 18:59:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 11:58:59 +0100
Date: Fri, 5 Apr 2024 11:58:58 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240405115858.00005e3e@Huawei.com>
In-Reply-To: <20240325190339.696686-7-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-7-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 25 Mar 2024 12:02:24 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. 

This doesn't parse.  I suggests splitting it into 2 sentences.

Add (file/memory backend) host backend for DCD.  All the dynamic capacity
regions will share a single, large enough host backend.

> Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:

Oddity of English wrt to plurals.

With this change, the following support is added.

> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all dc regions share one
>    host backend.
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region;
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
All comments trivial with exception of the one about setting size of range
registers. For now I think just set the flags and we will deal with whatever
output we get from the consortium in the long run.
With that tweaked.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  16 ++-
>  hw/mem/cxl_type3.c          | 187 +++++++++++++++++++++++++++++-------
>  include/hw/cxl/cxl_device.h |   8 ++
>  3 files changed, 172 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 0f2ad58a14..831cef0567 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -622,7 +622,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a9e8bdc436..75ea9b20e1 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -45,7 +45,8 @@ enum {



> +    if (dc_mr) {
> +        int i;
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /*
> +         * TODO: we assume the dynamic capacity to be volatile for now,
> +         * non-volatile dynamic capacity will be added if needed in the
> +         * future.

Trivial but I'd make that 2 sentences with a full stop after "now".


>      assert(len == cur_ent);
>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -300,11 +336,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
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
>      }

As per your cover letter this is a work around for an ambiguity in the
spec and what Linux is currently doing with.  However as per the call
the other day, Linux only checks the flags.  So I'd set those only and
not the size field.  We may have to deal with spec errata later, but
I don't want to block this series on the corner case in the meantime.

Given complexity of DC we'll be waiting for ever if we have to get
all clarifications before we land anything!
(Quick though those nice folk in the CXL consortium working groups are :))


> @@ -679,9 +746,41 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          g_free(p_name);
>      }
>  
> -    if (!cxl_create_dc_regions(ct3d, errp)) {
> -        error_setg(errp, "setup DC regions failed");
> -        return false;
> +    ct3d->dc.total_capacity = 0;
> +    if (ct3d->dc.num_regions) {

Trivial suggestion.

As dc.num_regions already existed from patch 4, maybe it's worth pushing this
if statement back there?  It will be harmless short cut for cxl_create_dc_regions()
which won't do anything if num_regions = 0 anyway  but will reduce churn a little
in this patch.

> +        MemoryRegion *dc_mr;
> +        char *dc_name;
> +
> +        if (!ct3d->dc.host_dc) {
> +            error_setg(errp, "dynamic capacity must have a backing device");
> +            return false;
> +        }
> +
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        if (!dc_mr) {
> +            error_setg(errp, "dynamic capacity must have a backing device");
> +            return false;
> +        }
> +
> +        /*
> +         * TODO: set dc as volatile for now, non-volatile support can be added
> +         * in the future if needed.
> +         */
> +        memory_region_set_nonvolatile(dc_mr, false);
> +        memory_region_set_enabled(dc_mr, true);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +        if (ds->id) {
> +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +        } else {
> +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +        }
> +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +        g_free(dc_name);
> +
> +        if (!cxl_create_dc_regions(ct3d, errp)) {
> +            error_setg(errp, "setup DC regions failed");
> +            return false;
> +        }
>      }

