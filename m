Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2691AC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6pn-0006vF-6n; Mon, 19 Feb 2024 11:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6pl-0006v6-Vw
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:49:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6pi-000589-Ki
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:49:37 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdpM74qhNz67RYs;
 Tue, 20 Feb 2024 00:45:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1075E140B54;
 Tue, 20 Feb 2024 00:49:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:49:28 +0000
Date: Mon, 19 Feb 2024 16:49:27 +0000
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol
 scrub control feature
Message-ID: <20240219164927.0000753b@Huawei.com>
In-Reply-To: <20240219150025.1531-3-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
 <20240219150025.1531-3-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Mon, 19 Feb 2024 23:00:24 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle. The patrol scrub control allows the request to
> configure patrol scrub input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours for which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

The data can't be global as we need to have separate controls per CXL type3
device so that each instance can have different settings. 

Otherwise a few minor comments inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 779ce80e3c..908ce16642 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -997,6 +997,7 @@ typedef struct CXLSupportedFeatureEntry {
>  } QEMU_PACKED CXLSupportedFeatureEntry;
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_PATROL_SCRUB = 0,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -1037,6 +1038,38 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>  };
>  
> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
> +static const QemuUUID patrol_scrub_uuid = {
> +    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
> +};
> +
> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> +
> +/* CXL memdev patrol scrub control attributes */
> +typedef struct CXLMemPatrolScrubReadAttrs {
> +        uint8_t scrub_cycle_cap;
> +        uint16_t scrub_cycle;
> +        uint8_t scrub_flags;
> +} QEMU_PACKED CXLMemPatrolScrubReadAttrs;
> +
> +typedef struct CXLMemPatrolScrubWriteAttrs {
> +    uint8_t scrub_cycle_hr;
> +    uint8_t scrub_flags;
> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrs;
> +
> +typedef struct CXLMemPatrolScrubSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLMemPatrolScrubWriteAttrs feat_data;
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
> +static CXLMemPatrolScrubReadAttrs cxl_memdev_ps_feat_attrs;
> +
>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1060,7 +1093,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      uint16_t feat_entries = 0;
>  
>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {

Change looks valid, but should have been in patch 1.


>          return CXL_MBOX_INVALID_INPUT;
>      }
>      req_entries = (get_feats_in->count -
> @@ -1072,6 +1105,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      entry = 0;
>      while (entry < req_entries) {
>          switch (index) {
> +        case  CXL_FEATURE_PATROL_SCRUB:
> +            /* Fill supported feature entry for device patrol scrub control */
> +            get_feats_out->feat_entries[entry] =
> +                           (struct CXLSupportedFeatureEntry) {
> +                .uuid = patrol_scrub_uuid,
> +                .feat_index = index,
> +                .get_feat_size = sizeof(CXLMemPatrolScrubReadAttrs),
> +                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrs),
> +                /* Bit[0] : 1, feature attributes changeable */
> +                .attr_flags = 0x1,
> +                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
> +                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +            /* Set default value for device patrol scrub read attributes */
> +            cxl_memdev_ps_feat_attrs.scrub_cycle_cap =
> +                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
> +                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
> +            cxl_memdev_ps_feat_attrs.scrub_cycle =
> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
> +            cxl_memdev_ps_feat_attrs.scrub_flags =
> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;

This is general defaults setup - doesn't belong here.
Not strictly necessary for a driver to have called the query for supported
features before trying to use them.

Move this to mem/cxl_type3.c as part of the device emulation.

 
> +            break;
>          default:
>              break;
>          }
> @@ -1112,6 +1170,20 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
> +        if (get_feature->offset >= sizeof(CXLMemPatrolScrubReadAttrs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(CXLMemPatrolScrubReadAttrs) -
> +                                             get_feature->offset;
> +        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
> +        memcpy(payload_out,
> +               &cxl_memdev_ps_feat_attrs + get_feature->offset,
> +               bytes_to_copy);
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      *len_out = bytes_to_copy;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1125,6 +1197,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             size_t *len_out,
>                                             CXLCCI *cci)
>  {
> +    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> +
> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        ps_set_feature = (void *)payload_in;
> +        ps_write_attrs = &ps_set_feature->feat_data;
> +        cxl_memdev_ps_feat_attrs.scrub_cycle &= ~0xFF;

This needed to be embedded in the Type 3 device structures - not globally shared.
You'll need to check the device type, then convert cci->d to it.

if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);

Add the feature attrs to that structure (as for now it's type 3 specific and
we don't have a generalized place for memory features beyond that).



> +        cxl_memdev_ps_feat_attrs.scrub_cycle |=
> +                          ps_write_attrs->scrub_cycle_hr & 0xFF;
> +        cxl_memdev_ps_feat_attrs.scrub_flags &= ~0x1;
> +        cxl_memdev_ps_feat_attrs.scrub_flags |=
> +                          ps_write_attrs->scrub_flags & 0x1;
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  


