Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E520CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ref2h-00052f-VL; Mon, 26 Feb 2024 12:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ref2d-00051L-Jf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:45:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ref2P-0008W0-Gh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:45:27 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk7Dz5CXwz6JBTy;
 Tue, 27 Feb 2024 01:40:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E41F9140B73;
 Tue, 27 Feb 2024 01:45:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 17:45:09 +0000
Date: Mon, 26 Feb 2024 17:45:08 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240226174508.00006366@Huawei.com>
In-Reply-To: <20240221182020.1086096-7-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-7-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 10:15:59 -0800
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
>    one host backend.
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region;
> 4. Fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Only comment on this one from me is beware of FIXME wording for
features we haven't implemented yet.  Makes people thing code isn't
good to go, when in reality we may or may not care about implementing
that configurability in the future!

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6e5f908fb1..b966fa4f10 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +
> +    if (dc_mr) {
> +        int i;
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /* FIXME: Currently we assume the dynamic capacity to be volatile. */
As below.  TODO: Allow for non volatile dynamic capacity.

> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
> +                    dsmad_handle++,
> +                    ct3d->dc.regions[i].len,
> +                    false, true, region_base);
> +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +
> +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> +            region_base += ct3d->dc.regions[i].len;
> +        }
> +    }
> +



> +
> +        /* FIXME: set dc as volatile for now */

Not sure it's a fixme, more of a TODO to add control of this later.
Fixme sounds broken, whereas it's a missing feature only.

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
> 

