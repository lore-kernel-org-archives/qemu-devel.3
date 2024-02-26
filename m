Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A3CC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reerC-0001Qq-7k; Mon, 26 Feb 2024 12:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1reer4-0001Pl-2A
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:33:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1reeqy-0006MC-CI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:33:27 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk6zK098sz6JBTl;
 Tue, 27 Feb 2024 01:28:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3C990140B73;
 Tue, 27 Feb 2024 01:33:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 17:33:18 +0000
Date: Mon, 26 Feb 2024 17:33:17 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240226173317.0000299d@Huawei.com>
In-Reply-To: <20240221182020.1086096-3-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 21 Feb 2024 10:15:55 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: decode_len of a dc region is aligned to 256*MiB, divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

A few comments inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  16 ++++++
>  2 files changed, 126 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..88e3b733e3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,7 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> +#define CXL_SPEC_AFTER_R30
As below. Drop this.  Kernel code needs to be able to cope with newer specs
than it understands anyway so should be fine with the larger records (otherwise
it's buggy and needs fixing!) 

>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -80,6 +81,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
> + * (Opcode: 4800h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_config_in_pl {
Type not needed - see below. 
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED;
   } QEMU_PACKED *in;

> +
> +    struct get_dyn_cap_config_out_pl {
Don't think giving this a type is necessary - see below.
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        uint8_t rsvd1[6];
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;
> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +        /*
> +         * if cxl spec version >= 3.1, extra output payload as defined
> +         * in struct get_dyn_cap_config_out_pl_extra comes here.
> +         */
> +    } QEMU_PACKED;
    } QEMU_PACKED *out;
> +
> +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;

We've (mostly) use the (void *) casting where we haven't given the structures
a type.  I think I'd prefer we kept to that style for consistency.

There is an argument we should have given all these types
for readability reasons and to avoid casting via void * but
we have gone this way now - with the exception of
the poison list - oops.   

> +    uint16_t record_count = 0;
> +    uint16_t i;
> +    uint16_t out_pl_len;
> +    uint8_t start_region_id = in->start_region_id;
> +#ifdef CXL_SPEC_AFTER_R30

Handy for testing, but I'd drop the ifdef for the final
version.  We don't need to support old specs.

> +    struct get_dyn_cap_config_out_pl_extra {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED;
> +    struct get_dyn_cap_config_out_pl_extra *extra_out;
As above, anonymous structure should work ok.
> +#endif
> +
> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +#ifdef CXL_SPEC_AFTER_R30
> +    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
> +            out_pl_len);
> +    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
> +#endif
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    out->num_regions = ct3d->dc.num_regions;
> +#ifdef CXL_SPEC_AFTER_R30
> +    out->regions_returned = record_count;
> +#endif
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                ct3d->dc.regions[start_region_id + i].base);
Qemu allows a couple of style choices, but don't think this matches any of them.
https://elixir.bootlin.com/qemu/latest/source/docs/devel/style.rst#L79

My preference is immediately after opening bracket.


> +        stq_le_p(&out->records[i].decode_len,
> +                ct3d->dc.regions[start_region_id + i].decode_len /
> +                CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                ct3d->dc.regions[start_region_id + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                ct3d->dc.regions[start_region_id + i].block_size);
> +        stl_le_p(&out->records[i].dsmadhandle,
> +                ct3d->dc.regions[start_region_id + i].dsmadhandle);
> +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> +    }
> +#ifdef CXL_SPEC_AFTER_R30
> +    /*FIXME: need to set valid values in the future*/

We need to do that before upstreaming..
For tags, 0 is fine for now.

For extents allow say 512 and count how many are in lists
I guess then subtract that.

> +    stq_le_p(&extra_out->num_extents_supported, 0);
> +    stq_le_p(&extra_out->num_extents_available, 0);
> +    stq_le_p(&extra_out->num_tags_supported, 0);
> +    stq_le_p(&extra_out->num_tags_available, 0);
> +#endif
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>  };
>  
> +static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> +    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
> +        cmd_dcd_get_dyn_cap_config, 2, 0 },
> +};
> +
>  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
>      [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
> @@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>  
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set);
> +    if (ct3d->dc.num_regions) {
> +        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
> +    }
>      cci->d = d;
>  
>      /* No separation for PCI MB as protocol handled in PCI device */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3cf3077afa..6df7fecdf1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -422,6 +422,17 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +#define DCD_MAX_REGION_NUM 8
Really trivial but call this 

DCD_MAX_NUM_REGION because it's the maximum number of
regions. The maximum region number is 7 (as zero indexed).

> +
> +typedef struct CXLDCDRegion {
> +    uint64_t base;
Probably makes sense to call out that bas also aligned to 256 MiB
as not immediately clear the comment applies to both.
Easiest will be to duplicate it.
> +    uint64_t decode_len; /* aligned to 256*MiB */
> +    uint64_t len;
> +    uint64_t block_size;
> +    uint32_t dsmadhandle;
> +    uint8_t flags;
> +} CXLDCDRegion;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -454,6 +465,11 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +
> +    struct dynamic_capacity {
> +        uint8_t num_regions; /* 0-8 regions */
> +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> +    } dc;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"


