Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E0BC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhviF-0004eD-Cw; Wed, 06 Mar 2024 13:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhviE-0004e4-12
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:09:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhviB-0006DG-9b
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:09:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqgSV6Vv1z6J9h6;
 Thu,  7 Mar 2024 02:09:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AE37F14111D;
 Thu,  7 Mar 2024 02:09:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 18:09:47 +0000
Date: Wed, 6 Mar 2024 18:09:46 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 11/13] hw/cxl/cxl-mailbox-utils: Add partial and
 superset extent release mailbox support
Message-ID: <20240306180946.00005161@Huawei.com>
In-Reply-To: <20240304194331.1586191-12-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-12-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon,  4 Mar 2024 11:34:06 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we extend the extent release mailbox command processing
> to allow more flexible release. As long as the DPA range of the extent to
> release is covered by valid extent(s) in the device, the release can be
> performed.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Ouch this is more complex than I was thinking, but seems correct to me.

A few minor comments inline

Jonathan

> +/*
> + * Detect potential extent overflow caused by extent split during processing
> + * extent release requests, also allow releasing superset of extents where the
> + * extent to release covers the range of multiple extents in the device.
> + * Note:
> + * 1.we will reject releasing an extent if some portion of its rang is

range

> + * not covered by valid extents.
> + * 2.This function is called after cxl_detect_malformed_extent_list so checks
> + * already performed there will be skipped.
> + */
> +static CXLRetCode cxl_detect_extent_overflow(const CXLType3Dev *ct3d,
> +        const CXLUpdateDCExtentListInPl *in)

This code is basically dry running the actual removal.  Can we just
make the core code the same for both cases?  The bit where you update bitmaps
and extent lists at least.

> +{
> +    uint64_t nbits, offset;
> +    const CXLDCRegion *region;
> +    unsigned long **bitmaps_copied;
> +    uint64_t dpa, len;
> +    int i, rid;
> +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> +    long extent_cnt_delta = 0;
> +    CXLDCExtentList tmp_list;
> +    CXLDCExtent *ent;
> +
> +    QTAILQ_INIT(&tmp_list);
> +    copy_extent_list(&tmp_list, &ct3d->dc.extents);
> +
> +    bitmaps_copied = g_new0(unsigned long *, ct3d->dc.num_regions);
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        nbits = region->len / region->block_size;
> +        bitmaps_copied[i] = bitmap_new(nbits);
> +        bitmap_copy(bitmaps_copied[i], region->blk_bitmap, nbits);
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        rid = cxl_find_dc_region_id(ct3d, dpa, len);
> +        region = &ct3d->dc.regions[rid];
> +        offset = (dpa - region->base) / region->block_size;
> +        nbits = len / region->block_size;
> +
> +        /* Check whether range [dpa, dpa + len) is covered by valid range */
> +        if (find_next_zero_bit(bitmaps_copied[rid], offset + nbits, offset) <
> +                               offset + nbits) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto free_and_exit;
> +        }
> +
> +        QTAILQ_FOREACH(ent, &tmp_list, node) {
> +            /* Only split within an extent can cause extent count increase */
> +            if (ent->start_dpa <= dpa &&
> +                dpa + len <= ent->start_dpa + ent->len) {
> +                uint64_t ent_start_dpa = ent->start_dpa;
> +                uint64_t ent_len = ent->len;
> +                uint64_t len1 = dpa - ent_start_dpa;
> +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> +
> +                extent_cnt_delta += len1 && len2 ? 2 : (len1 || len2 ? 1 : 0);
I think this is the same as

		if (len1)
			extent_cnt_delta++;
		if (len2)
			extent_cnt_delta++;
		extent_cnt_delta--;



> +                extent_cnt_delta -= 1;
> +                if (ct3d->dc.total_extent_count + extent_cnt_delta >
> +                    CXL_NUM_EXTENTS_SUPPORTED) {

This early overflow detect seems valid to me because a device might run
out or resource mid processing the list even if it would fit at the end.
Good.
> +                    ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> +                    goto free_and_exit;
> +                }
> +
> +                offset = (ent->start_dpa - region->base) / region->block_size;
> +                nbits = ent->len / region->block_size;
> +                bitmap_clear(bitmaps_copied[rid], offset, nbits);
> +                cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +
> +                 if (len1) {
> +                    offset = (dpa - region->base) / region->block_size;
> +                    nbits = len1 / region->block_size;
> +                    bitmap_set(bitmaps_copied[rid], offset, nbits);
> +                    cxl_insert_extent_to_extent_list(&tmp_list,
> +                                                     ent_start_dpa, len1,
> +                                                     NULL, 0);
> +                 }
> +
> +                 if (len2) {
> +                    offset = (dpa + len - region->base) / region->block_size;
> +                    nbits = len2 / region->block_size;
> +                    bitmap_set(bitmaps_copied[rid], offset, nbits);
> +                    cxl_insert_extent_to_extent_list(&tmp_list, dpa + len,
> +                                                     len2, NULL, 0);
> +                 }
> +                 break;
> +             }
> +         }
> +    }
> +
> +free_and_exit:
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        g_free(bitmaps_copied[i]);
> +    }
> +    g_free(bitmaps_copied);
> +
> +    while (!QTAILQ_EMPTY(&tmp_list)) {
> +        ent = QTAILQ_FIRST(&tmp_list);
> +        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +    }
> +
> +    return ret;
> +}
> +
>  /*
>   * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
>   */
> @@ -1644,15 +1793,28 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          return ret;
>      }
>  
> -    for (i = 0; i < in->num_entries_updated; i++) {
> -        bool found = false;
> +    ret = cxl_detect_extent_overflow(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
>  
> +    /*
> +     * After this point, it is guaranteed that the extents in the
> +     * updated extent list to release is valid, that means:
> +     * 1. All extents in the list have no overlaps;
> +     * 2. Each extent belongs to a valid DC region;
> +     * 3. The DPA range of each extent is covered by valid extent
> +     * in the device.
> +     */
> +    for (i = 0; i < in->num_entries_updated; i++) {
>          dpa = in->updated_entries[i].start_dpa;
>          len = in->updated_entries[i].len;
>  
> +process_leftover:
>          QTAILQ_FOREACH(ent, extent_list, node) {
>              /* Found the extent overlapping with */
>              if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
> +                /* Case 1: The to-release extent is subset of ent */
>                  if (dpa + len <= ent->start_dpa + ent->len) {
>                      /*
>                       * The incoming extent covers a portion of an extent
> @@ -1669,17 +1831,6 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>                      uint64_t len1 = dpa - ent_start_dpa;
>                      uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
>  
> -                    /*
> -                     * TODO: checking for possible extent overflow, will be
> -                     * moved into a dedicated function of detecting extent
> -                     * overflow.
> -                     */
> -                    if (len1 && len2 && ct3d->dc.total_extent_count ==
> -                        CXL_NUM_EXTENTS_SUPPORTED) {
> -                        return CXL_MBOX_RESOURCES_EXHAUSTED;
> -                    }
> -
> -                    found = true;
>                      cxl_remove_extent_from_extent_list(extent_list, ent);
>                      ct3d->dc.total_extent_count -= 1;
>                      ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
> @@ -1700,20 +1851,34 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>                      break;
>                  } else {
>                      /*
> -                     * TODO: we reject the attempt to remove an extent that
> -                     * overlaps with multiple extents in the device for now,
> -                     * once the bitmap indicating whether a DPA range is
> -                     * covered by valid extents is introduced, will allow it.
> +                     * Case 2: the to-release extent overlaps with multiple
> +                     * extents, including the superset case
>                       */
> -                    return CXL_MBOX_INVALID_PA;
> +                    uint64_t ent_start_dpa = ent->start_dpa;
> +                    uint64_t ent_len = ent->len;
> +                    uint64_t len1 = dpa - ent_start_dpa;
> +
> +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> +                    ct3d->dc.total_extent_count -= 1;
> +                    ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
> +
> +                    if (len1) {
> +                        cxl_insert_extent_to_extent_list(extent_list,
> +                                                         ent_start_dpa, len1,
> +                                                         NULL, 0);
> +                        ct3d->dc.total_extent_count += 1;
> +                        ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
> +                    }
> +                    /*
> +                     * processing the portion of the range following current
> +                     * extent

> +                     */
> +                    len = dpa + len - ent_start_dpa - ent_len;
> +                    dpa = ent_start_dpa + ent_len;
> +                    goto process_leftover;

I'd slightly prefer a while loop I think based on len > 0
It does add indent, but easier to follow for me than a retry type goto.


>                  }
>              }
>          }
> -
> -        if (!found) {
> -            /* Try to remove a non-existing extent. */
> -            return CXL_MBOX_INVALID_PA;
> -        }
>      }
>  
>      return CXL_MBOX_SUCCESS;


