Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACDE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmjl-0003iN-0V; Thu, 12 Dec 2024 12:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLmjf-0003hn-RH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:12:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLmjb-0003gB-Re
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:12:23 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8JsM70Vsz6L7F4;
 Fri, 13 Dec 2024 01:11:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D9BB9140109;
 Fri, 13 Dec 2024 01:12:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 18:12:15 +0100
Date: Thu, 12 Dec 2024 17:12:13 +0000
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <svetly.todorov@memverge.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v3 2/3] cxl_type3: add MHD callbacks
Message-ID: <20241212171213.000028f8@huawei.com>
In-Reply-To: <20241018161252.8896-3-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-3-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 18 Oct 2024 12:12:51 -0400
Gregory Price <gourry@gourry.net> wrote:

> From: Svetly Todorov <svetly.todorov@memverge.com>
> 
> Introduce an API for validating DC adds, removes, and responses
> against a multi-headed device.
> 
> mhd_reserve_extents() is called during a DC add request. This allows
> a multi-headed device to check whether the requested extents belong
> to another host. If not, then this function can claim those extents
> in the MHD state and allow the cxl_type3 code to follow suit in the
> host-local blk_bitmap.
> 
> mhd_reclaim_extents() is called during the DC add response. It allows
> the MHD to reclaim extents that were preallocated to a host during the
> request but rejected in the response.
> 
> mhd_release_extent() is called during the DC release response. It can
> be invoked after a host frees an extent in its local bitmap, allowing
> the MHD handler to release that same extent in the multi-host state.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>

Hi Gregory, Svetly,

A few minor comments inline.  I want to think a bit more on the general
approach before providing a broader reply.

If I apply this on my cxl staging tree an can easily tidy the stuff up I mention
whilst doing so.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 28 +++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 17 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  8 ++++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 10de26605c..112272e9ac 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2545,6 +2545,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  {
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
>      uint32_t i;
>      uint64_t dpa, len;
> @@ -2579,6 +2580,11 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>          ct3d->dc.total_extent_count += 1;
>          ct3_set_region_block_backed(ct3d, dpa, len);
>      }
> +
> +    if (cvc->mhd_reclaim_extents)
> +        cvc->mhd_reclaim_extents(&ct3d->parent_obj, &ct3d->dc.extents_pending,
> +                in);
> +
Trivial but qemu style requires {} always.

I'd also indent that in to be aligned under the &


>      /* Remove the first extent group in the pending list */
>      cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>  
> @@ -2612,6 +2618,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
>          uint32_t *updated_list_size)
>  {
>      CXLDCExtent *ent, *ent_next;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      uint64_t dpa, len;
>      uint32_t i;
>      int cnt_delta = 0;
> @@ -2632,6 +2639,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
>              goto free_and_exit;
>          }
>  
> +        /* In an MHD, check that this DPA range belongs to this host */
> +        if (cvc->mhd_access_valid &&
> +            !cvc->mhd_access_valid(&ct3d->parent_obj, dpa, len)) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto free_and_exit;
> +        }
> +
>          /* After this point, extent overflow is the only error can happen */
>          while (len > 0) {
>              QTAILQ_FOREACH(ent, updated_list, node) {
> @@ -2704,9 +2718,11 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>  {
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      CXLDCExtentList updated_list;
>      CXLDCExtent *ent, *ent_next;
> -    uint32_t updated_list_size;
> +    uint32_t updated_list_size, i;
> +    uint64_t dpa, len;
>      CXLRetCode ret;
>  
>      if (in->num_entries_updated == 0) {
> @@ -2724,6 +2740,16 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          return ret;
>      }
>  
> +    /* Updated_entries contains the released extents. Free those in the MHD */
> +    for (i = 0; cvc->mhd_release_extent && i < in->num_entries_updated; ++i) {

local style is post increment.

Also, indent isn't too bad if you pull the mhd_release_extent out of the loop
condition as an if statement.  It think that ends up more reaable.



> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        if (cvc->mhd_release_extent) {

Checked in loop condition as well so this isn't needed. 
> +            cvc->mhd_release_extent(&ct3d->parent_obj, dpa, len);
> +        }
> +    }
> +
>      /*
>       * If the dry run release passes, the returned updated_list will
>       * be the updated extent list and we just need to clear the extents
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b7b24b6a32..a94b9931d2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -799,6 +799,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
>  {
>      CXLDCExtent *ent, *ent_next;
>      CXLDCExtentGroup *group, *group_next;
> +    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
>      int i;
>      CXLDCRegion *region;
>  
> @@ -817,6 +818,10 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
>      for (i = 0; i < ct3d->dc.num_regions; i++) {
>          region = &ct3d->dc.regions[i];
>          g_free(region->blk_bitmap);
> +        if (cvc->mhd_release_extent) {
> +            cvc->mhd_release_extent(&ct3d->parent_obj, region->base,
> +                    region->len);
Indent to align after (

> +        }
>      }
>  }
>  
> @@ -2077,6 +2082,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      CXLEventDynamicCapacity dCap = {};
>      CXLEventRecordHdr *hdr = &dCap.hdr;
>      CXLType3Dev *dcd;
> +    CXLType3Class *cvc;
>      uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
>      uint32_t num_extents = 0;
>      CxlDynamicCapacityExtentList *list;
> @@ -2094,6 +2100,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      }
>  
>      dcd = CXL_TYPE3(obj);
> +    cvc = CXL_TYPE3_GET_CLASS(dcd);
>      if (!dcd->dc.num_regions) {
>          error_setg(errp, "No dynamic capacity support from the device");
>          return;
> @@ -2166,6 +2173,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          num_extents++;
>      }
>  
> +    /* If this is an MHD, attempt to reserve the extents */
> +    if (type == DC_EVENT_ADD_CAPACITY && cvc->mhd_reserve_extents &&
> +       !cvc->mhd_reserve_extents(&dcd->parent_obj, records, rid)) {
> +        error_setg(errp, "mhsld is enabled and extent reservation failed");

I'd reorganize this so you can get the return value. It might be useful in the long run.

> +        return;
> +    }
> +
>      /* Create extent list for event being passed to host */
>      i = 0;
>      list = records;
> @@ -2304,6 +2318,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->set_cacheline = set_cacheline;
>      cvc->mhd_get_info = NULL;
>      cvc->mhd_access_valid = NULL;
> +    cvc->mhd_reserve_extents = NULL;
> +    cvc->mhd_reclaim_extents = NULL;
> +    cvc->mhd_release_extent = NULL;
>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b2dc7fb769..13c97b576f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -14,6 +14,7 @@
>  #include "hw/pci/pci_device.h"
>  #include "hw/register.h"
>  #include "hw/cxl/cxl_events.h"
> +#include "qapi/qapi-commands-cxl.h"
>  
>  #include "hw/cxl/cxl_cpmu.h"
>  /*
> @@ -682,6 +683,13 @@ struct CXLType3Class {
>                                 size_t *len_out,
>                                 CXLCCI *cci);
>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
> +    bool (*mhd_reserve_extents)(PCIDevice *d,
> +                                CxlDynamicCapacityExtentList *records,
> +                                uint8_t rid);
> +    bool (*mhd_reclaim_extents)(PCIDevice *d,
> +                                CXLDCExtentGroupList *groups,
> +                                CXLUpdateDCExtentListInPl *in);
> +    bool (*mhd_release_extent)(PCIDevice *d, uint64_t dpa, uint64_t len);
>  };
>  
>  struct CSWMBCCIDev {


