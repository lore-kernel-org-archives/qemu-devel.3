Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA31EE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voL9P-00070y-O7; Fri, 06 Feb 2026 07:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voL9L-00070Z-Tb
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:41:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voL9H-00077U-EL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:41:26 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6twQ0FR3zJ46Cy;
 Fri,  6 Feb 2026 20:40:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 53D1040584;
 Fri,  6 Feb 2026 20:41:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:41:13 +0000
Date: Fri, 6 Feb 2026 12:41:11 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 5/7] hw/cxl: Add performant direct mapping for extents
Message-ID: <20260206124111.00000723@huawei.com>
In-Reply-To: <20251127225526.700-6-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
 <20251127225526.700-6-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 27 Nov 2025 22:55:23 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add alias direct mapping into the fixed memory window.

Say more on why, plus provide sequence of commands to do this.

> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b785553225..15114a5314 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

> @@ -3123,6 +3141,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>              }
>  
>              mr = host_memory_backend_get_memory(hmb_dc);
> +
>              if (!mr) {
>                  qemu_log("Could not get memory region from host memory "
>                           "backend\n");
> @@ -3132,11 +3151,32 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>              memory_region_set_nonvolatile(mr, false);
>              memory_region_set_enabled(mr, true);
>              host_memory_backend_set_mapped(hmb_dc, true);
> +
> +            if (ct3d->direct_mr_enabled) {
> +                g_autofree char *direct_mapping_name =
> +                    g_strdup_printf("cxl-direct-mapping-%d", mr_idx);
> +                int region_offset = dpa - ct3d->dc.regions[rid].base;
> +                MemoryRegion *dr_dc_mr = &ct3d->dc.dc_direct_mr[mr_idx];
> +                memory_region_init_alias(dr_dc_mr, OBJECT(ct3d),
> +                                         direct_mapping_name, mr, region_offset,
> +                                         ct3d->dc.dc_decoder_window.size);
> +                memory_region_add_subregion(&fw->mr,
> +                                            ct3d->dc.dc_decoder_window.base -
> +                                                fw->base + offset,
> +                                            dr_dc_mr);
> +                /*
> +                 * for now assuming 4 extents and 4 direct mapping memory
> +                 * regions.
> +                 */
> +                ct3d->dc.cur_direct_region_idx =
> +                    (ct3d->dc.cur_direct_region_idx + 1) % 4;

Don't do a modulo as that'll just overwrite someone else.  Just check if
we are out of space.  Ultimately they will come and go in random orders
so you'll need a different data structure to avoid running out too early.

> +            }

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index fe0c44e8d7..1a521df881 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -524,6 +524,7 @@ typedef struct CXLDCExtent {
>      uint16_t shared_seq;
>      uint8_t rsvd[0x6];
>      int rid;
> +    uint64_t offset;
>  
>      QTAILQ_ENTRY(CXLDCExtent) node;
>  } CXLDCExtent;
> @@ -589,6 +590,7 @@ struct CXLType3Dev {
>  
>      /* State */
>      MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
> +    bool direct_mr_enabled;
>      AddressSpace hostvmem_as;
>      AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
> @@ -633,6 +635,14 @@ struct CXLType3Dev {
>          HostMemoryBackend *host_dc;
>          AddressSpace host_dc_as;
>          struct CXLFixedWindow *fw;
> +        int cur_direct_region_idx;
> +        /*
> +         * dc_decoder_window represents the CXL Decoder Window

What decoder? Needs more info on why this exists.
There is no particular reason a decoder maps to a DCD region but
that's probably the largest granularity we'll get. Could well point
to just part of a dc region.  I don't mind rejecting fast path
in those corner cases but we need to make the slow path work then.

> +         */
> +        struct decoder_window {
> +            hwaddr base;
> +            hwaddr size;
> +        } dc_decoder_window;
>          /*
>           * total_capacity is equivalent to the dynamic capability
>           * memory region size.
> @@ -647,6 +657,11 @@ struct CXLType3Dev {
>  
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
> +        /*
> +         * Assume 4 now but many possible, each region is one alias an extent
> +         * to allow performance translation in KVM.

The KVM bit doesn't matter.  It is better with this in TCG as well.
I think we'll ultimately want a list for these - but this is fine for now.

> +         */
> +        MemoryRegion dc_direct_mr[4];
>      } dc;


