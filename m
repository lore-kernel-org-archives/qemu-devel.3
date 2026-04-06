Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B59BEF4ECA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9hls-0003uf-GG; Mon, 06 Apr 2026 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1w9hln-0003st-Pv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:05:27 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1w9hll-0003RR-9V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:05:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35d9923eec5so2206708a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775473524; x=1776078324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDabuopvI4cEhh7FEKyL+72w4eJz9sd6DRtakqpqGB0=;
 b=jtUFCLKY9LYImCtTf1yGHBDtt2ppbza46nmqQ71LX43CbqvKsMvJXWoR7Zon4c3NMI
 2yroE6jM8uPzhsilhqrbrL0g0fguQWxpdnAm77HxNmFKpvacaG9msva3kV745uV3xRrk
 oEodlp/k6zQNFnvO1YSs8yIk4BVBax6iZAY8nYlIy9S4g9DpyxbeZbZ43EU+xbesZGFW
 KES871bV7RpHGCacsDiILapRQJWl2skqev2yTKS4rh7SDL7v+7wBl+ypu9LCuslz4IZy
 7mNt6GrnCNCYCEL75H6gy1gy+4dj0C5chuLh3V0L7h2tnw8SSza3wJ6f1VzlGQS/e2ZA
 8yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775473524; x=1776078324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gDabuopvI4cEhh7FEKyL+72w4eJz9sd6DRtakqpqGB0=;
 b=J9B/eUjsvA18D2yt0A//Dbzvuh1r+it1cTL4EdPwETuUrbnMVkQPUMKk1GZ6h8MmKC
 tLRKBwfFvmxVLZRWywIjPObbBZFqHxto4gmhfTho0eQ5tLkilIc5h55YR3jOpaPSw/mF
 NuuDiVol+d/XBN580u8qXIhyq5Nz520JQqOTgqckiT5jU5i7Gdmw2waiFBmox2gwla9h
 xAgvz61BaS/v+4ssh4OMTjlBuSrcuO39nIQXvziQboY7vZTC8XDMQaXp5ArvMYheMl83
 u5bheZ5EBhqBbgLj4K8WBLcyWZQBI+yGTCxKeR+7ZAThTBH+YVkxXC4LOkKqrUFj9la6
 O+Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk7jSBultRZr5GFVsBuzaqEmwqJdbjhzNuIP1qWAXOfgi7APE1TDiXwcdBGKQ8VzdF0+QzVEcJYJr5@nongnu.org
X-Gm-Message-State: AOJu0YwiWfbaCHRfou9eYr/VTNQFpOOL0lqGpq0zr+Y4MO0ttOgrxRwj
 /V+o+qvMFcdHPZldU4lp4gK2OsUQf/ZdAzum2ZxxnSfUXTe4wjKyBkcH
X-Gm-Gg: AeBDietYeHJ7odSvhO0J261q9MCyEkqtHmiNnptcMb5bajZlnXMNUr2puDX8dhIcZAs
 NPGilnXsWn96Rs94DjUdVcr/PVXlEMD3M7pqS3fwpPYmAyV2t3FsOsyfgE+0zlnf96OqJNH8eJ4
 3SSlI4IqExEAh6bs0/9vF4NVS7yhd3iisT34N4gLhwu7kdQrdEp+13jyj+vc7K8ETCeXrAhtR/Z
 U5cYj4TOCf1aHCwwr842wvqK+nMwsac9t370CnilpBTI0CjkFXpyizDFBQxIqpg/b/SoNtk+z8v
 JCJSzuH6OqbThsNX/QfFDS21yC/ZPuUvXhvhJVydKlH+NrZjJEttg1Zs30e3oQwLOPPUSYT8gwD
 JwCbCSMcLhdJu9E9FsXGw9lJIdaIyEV10eS1qkUd10LGTgWVYxt+s8x9Pz5Q+lkbtWRG8ksRbAP
 sUaGikv7vn2CN9SR0jSsr6kYcZhh6y180qTG90kMjvWw==
X-Received: by 2002:a17:90a:dfc3:b0:35b:e529:2d60 with SMTP id
 98e67ed59e1d1-35de68712b0mr11175755a91.8.1775473523674; 
 Mon, 06 Apr 2026 04:05:23 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de6a5e62dsm3666335a91.13.2026.04.06.04.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 04:05:23 -0700 (PDT)
Message-ID: <723521f1-84b8-4fe9-a790-225d1e3c84d2@gmail.com>
Date: Mon, 6 Apr 2026 20:05:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/ufs: Add UFS Write Booster Support
To: Jaemyung Lee <ldc.jml@gmail.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jaemyung Lee <jaemyung.lee@samsung.com>
References: <20260402-write_booster-v1-0-e4fed1df6c7e@samsung.com>
 <20260402-write_booster-v1-4-e4fed1df6c7e@samsung.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260402-write_booster-v1-4-e4fed1df6c7e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 4/2/2026 6:43 PM, Jaemyung Lee wrote:
> Add UFS Write Booster implementation which follows UFS 4.1 Spec.
>
> Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
> ---
>   hw/ufs/lu.c         |  85 ++++++++++++++
>   hw/ufs/ufs.c        | 328 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   hw/ufs/ufs.h        |  39 +++++++
>   include/block/ufs.h |  51 ++++++++
>   4 files changed, 488 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index 3f3c9589cee57ae3e77e2f486476d5fcec204d80..7c25c15169f76f22059c3ae03dfc1f21b0e41e8d 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -247,6 +247,89 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
>       return UFS_REQUEST_SUCCESS;
>   }
>   
> +#define UFS_GROUP_NUMBER_MASK 0x1F
> +#define UFS_WB_GROUP_NUMBER_PINNED 0x18 /* 11000b */
> +static bool ufs_wb_check_write_pinned(UfsHc *u, UfsRequest *req)
> +{
> +    uint8_t group_number = req->req_upiu.sc.cdb[6] & UFS_GROUP_NUMBER_MASK;
> +
> +    if (u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) {
> +        return false;
> +    }
> +
> +    return (group_number == UFS_WB_GROUP_NUMBER_PINNED);
> +}
> +
> +#define UFS_WB_TOTAL_WRITTEN_SHIFT 21 /* 10MB */
> +static void ufs_wb_process_write_pinned(UfsHc *u, UfsRequest *req)
> +{
> +    UfsWb *wb = &u->wb;
> +    uint64_t remain_bytes, remain_data;
> +    uint32_t total_written;
> +
> +    if (!wb->pinned_curr_bytes) {
> +        return;
> +    }
> +
> +    if (wb->pinned_used_bytes >= wb->pinned_curr_bytes) {
> +        return;
> +    }
> +
> +    remain_bytes = wb->pinned_curr_bytes - wb->pinned_used_bytes;
> +    if (remain_bytes >= req->data_len) {
> +        wb->pinned_total_written_bytes += req->data_len;
> +        wb->pinned_used_bytes += req->data_len;
> +        remain_data = 0;
> +
> +    } else {
> +        wb->pinned_total_written_bytes += remain_bytes;
> +        wb->pinned_used_bytes += remain_bytes;
> +        remain_data = req->data_len - remain_bytes;
> +    }
> +
> +    total_written = wb->pinned_total_written_bytes >> UFS_WB_TOTAL_WRITTEN_SHIFT;
> +    u->attributes.pinned_wb_cumm_written_size = cpu_to_be32(total_written);
> +
> +    remain_bytes = wb->curr_bytes - wb->used_bytes;
> +    wb->used_bytes += MIN(remain_bytes, remain_data);
> +}
> +
> +static void ufs_wb_process_write_normal(UfsHc *u, UfsRequest *req)
> +{
> +    UfsWb *wb = &u->wb;
> +    uint64_t curr_bytes, used_bytes, remain_bytes;
> +
> +    if (!wb->curr_bytes) {
> +        return;
> +    }
> +
> +    curr_bytes = wb->curr_bytes - wb->pinned_curr_bytes;
> +    used_bytes = wb->used_bytes - wb->pinned_used_bytes;
> +
> +    if (used_bytes >= curr_bytes) {
> +        return;
> +    }
> +
> +    remain_bytes = curr_bytes - used_bytes;
> +    wb->used_bytes += MIN(remain_bytes, req->data_len);
> +}
> +
> +static void ufs_wb_process_write_cmd(UfsRequest *req)
> +{
> +    uint8_t command = req->req_upiu.sc.cdb[0];
> +    UfsHc *u = req->hc;
> +
> +    if (command != WRITE_10 || !u->flags.wb_en) {

QEMU UFS supports not only WRITE_10 but also WRITE_6, WRITE_12, and 
WRITE_16.

This path should take those commands into account as well, and the group 
number handling would need to be updated accordingly.


> +        return;
> +    }
> +
> +    if (ufs_wb_check_write_pinned(u, req)) {
> +        ufs_wb_process_write_pinned(u, req);
> +    } else {
> +        ufs_wb_process_write_normal(u, req);
> +    }
> +}
> +
>   static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
>   {
>       uint8_t task_tag = req->req_upiu.header.task_tag;
> @@ -261,6 +344,8 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
>           return ufs_emulate_scsi_cmd(lu, req);
>       }
>   
> +    ufs_wb_process_write_cmd(req);

It seems better to account this at completion time instead.

Otherwise failed writes can still consume WB space, and the accounting 
has to rely on req->data_len rather than the actual transferred_len 
reported at completion.

> +
>   static void ufs_init_hc(UfsHc *u)
>   {
>       uint32_t cap = 0;
>       uint32_t mcqconfig = 0;
>       uint32_t mcqcap = 0;
> +    uint32_t ext_wb_sup = WB_RESIZE | WB_FIFO | WB_PINNED;
> +    uint32_t ext_ufs_feat_sup = UFS_DEV_WB_SUPPORT |
> +                                UFS_DEV_HIGH_TEMP_NOTIF |
> +                                UFS_DEV_LOW_TEMP_NOTIF;
>       int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
>   
>       u->reg_size = pow2ceil(ufs_reg_size(u));
> @@ -1965,8 +2241,13 @@ static void ufs_init_hc(UfsHc *u)
>           UFS_DEV_LOW_TEMP_NOTIF;
>       u->device_desc.queue_depth = u->params.nutrs;
>       u->device_desc.product_revision_level = 0x04;
> +    u->device_desc.extended_wb_support |= cpu_to_be16(ext_wb_sup);
>       u->device_desc.extended_ufs_features_support =
> -        cpu_to_be32(UFS_DEV_HIGH_TEMP_NOTIF | UFS_DEV_LOW_TEMP_NOTIF);
> +        cpu_to_be32((ext_ufs_feat_sup));
> +    u->device_desc.write_booster_buffer_preserve_user_space_en = 0x01;
> +    u->device_desc.write_booster_buffer_type = 0x01;
> +    u->device_desc.num_shared_write_booster_buffer_alloc_units =
> +        cpu_to_be32(0x400); /* 4GB */

Shouldn't this use the configured wb-max-size rather than a hardcoded 
value?


>   
>       memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
>       u->geometry_desc.length = sizeof(GeometryDescriptor);
> @@ -1982,6 +2263,16 @@ static void ufs_init_hc(UfsHc *u)
>           0x0; /* out-of-order data transfer is not supported */
>       u->geometry_desc.max_context_id_number = 0x5;
>       u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
> +    u->geometry_desc.write_booster_buffer_max_n_alloc_units =
> +        cpu_to_be32(u->params.wb_max_size);
> +    u->geometry_desc.device_max_write_booster_l_us =
> +        u->params.wb_max_lus;
> +    u->geometry_desc.write_booster_buffer_cap_adj_fac =
> +        u->params.wb_cap_adj_fac;
> +    u->geometry_desc.supported_write_booster_buffer_user_space_reduction_types =
> +        u->params.wb_reduction;
> +    u->geometry_desc.supported_write_booster_buffer_types =
> +        0x1; /* lu-dedicated buffer type is not supported */
>   
>       memset(&u->attributes, 0, sizeof(u->attributes));
>       u->attributes.max_data_in_size = 0x08;
> @@ -1996,6 +2287,8 @@ static void ufs_init_hc(UfsHc *u)
>       memset(&u->flags, 0, sizeof(u->flags));
>       u->flags.permanently_disable_fw_update = 1;
>   
> +    ufs_wb_init(u);
> +
>       /*
>        * The temperature value is fixed to UFS_TEMPERATURE and does not change
>        * dynamically
> @@ -2061,6 +2354,11 @@ static const Property ufs_props[] = {
>       DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
>       DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
>       DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
> +    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
> +    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
> +    DEFINE_PROP_UINT8("wb-max-lus", UfsHc, params.wb_max_lus, 1),
> +    DEFINE_PROP_UINT8("wb-cap-adj-fac", UfsHc, params.wb_cap_adj_fac, 3),
> +    DEFINE_PROP_UINT8("wb-reduction", UfsHc, params.wb_reduction, 1),
>   };
>   
>   static const VMStateDescription ufs_vmstate = {
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index b5f040302129f4d02732ddd20ef82eb33c41922a..f27c30d202195636726e6920d14c3ee9c03494be 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -91,6 +91,11 @@ typedef struct UfsParams {
>       bool mcq; /* Multiple Command Queue support */
>       uint8_t mcq_qcfgptr; /* MCQ Queue Configuration Pointer in MCQCAP */
>       uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
> +    uint32_t wb_max_size; /* WB Maximum allocation units */
> +    uint32_t wb_min_size; /* WB Minimum allocation units */

How about checking this in ufs_check_constraints() and rejecting 
configurations where wb_min_size is larger than wb_max_size?
Allowing that configuration can make the WB resize calculation behave 
unexpectedly from the start.


> +    uint8_t wb_max_lus; /* WB Maximum number of LUs */
> +    uint8_t wb_cap_adj_fac; /* WB Capacity Adjustment Factor */
> +    uint8_t wb_reduction; /* WB User Space Reduction */
>   } UfsParams;
>   
>   /*
> @@ -118,6 +123,24 @@ typedef struct UfsCq {
>       QTAILQ_HEAD(, UfsRequest) req_list;
>   } UfsCq;
>   
> +/*
> + * Extended features
> + */
> +typedef struct UfsWb {
> +    struct UfsHc *u;
> +    uint64_t max_bytes;
> +    uint64_t min_bytes;
> +    uint64_t curr_bytes;
> +    uint64_t used_bytes;
> +    uint64_t resize_bytes;
> +
> +    uint64_t pinned_max_bytes;
> +    uint64_t pinned_min_bytes;
> +    uint64_t pinned_curr_bytes;
> +    uint64_t pinned_used_bytes;
> +    uint64_t pinned_total_written_bytes;
> +} UfsWb;
> +
>   typedef struct UfsHc {
>       PCIDevice parent_obj;
>       UfsBus bus;
> @@ -147,6 +170,9 @@ typedef struct UfsHc {
>       UfsSq *sq[UFS_MAX_MCQ_QNUM];
>       UfsCq *cq[UFS_MAX_MCQ_QNUM];
>   
> +    /* Extended features */
> +    UfsWb wb;
> +
>       uint8_t temperature;
>   
>       QEMUTimer idle_timer;
> @@ -211,6 +237,19 @@ static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
>       return tail == ufs_mcq_cq_head(u, qid);
>   }
>   
> +static inline uint64_t ufs_unit_to_byte(UfsHc *u, uint32_t unit)
> +{
> +    return unit * u->geometry_desc.allocation_unit_size *
> +           be32_to_cpu(u->geometry_desc.segment_size) * BDRV_SECTOR_SIZE;

The size conversion path should promote to 64-bit before doing the 
multiplication.

(uint64_t)unit * u->geometry_desc.allocation_unit_size *
     ...


> +}
> +
> +static inline uint32_t ufs_byte_to_unit(UfsHc *u, uint64_t byte)
> +{
> +    return byte / BDRV_SECTOR_SIZE /
> +           be32_to_cpu(u->geometry_desc.segment_size) /
> +           u->geometry_desc.allocation_unit_size;
> +}
> +
>   #define TYPE_UFS "ufs"
>   #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
>   
> diff --git a/include/block/ufs.h b/include/block/ufs.h
> index 4dacfb776f947a285d86018add82115f148b7dd9..aa0dde805826d0b06ab80fb74034192ba06c2045 100644
> --- a/include/block/ufs.h
> +++ b/include/block/ufs.h
> @@ -1126,11 +1126,24 @@ enum health_desc_param {
>       UFS_HEALTH_DESC_PARAM_LIFE_TIME_EST_B = 0x4,
>   };
>   
> +/* Possible values for bUFSFeaturesSupport */
>   enum {
>       UFS_DEV_HIGH_TEMP_NOTIF = BIT(4),
>       UFS_DEV_LOW_TEMP_NOTIF = BIT(5),
>   };
>   
> +/* Possible values for dExtendedWriteBoosterSupport */
> +enum {
> +    WB_RESIZE = BIT(0),
> +    WB_FIFO = BIT(1),
> +    WB_PINNED = BIT(2),
> +};
> +
> +/* Possible values for dExtendedUFSFeaturesSupport */
> +enum {
> +    UFS_DEV_WB_SUPPORT = BIT(8),
> +};
> +
>   /* WriteBooster buffer mode */
>   enum {
>       UFS_WB_BUF_MODE_LU_DEDICATED = 0x0,
> @@ -1207,6 +1220,44 @@ enum ufs_dev_pwr_mode {
>       UFS_DEEPSLEEP_PWR_MODE = 4,
>   };
>   
> +/* UFS Write Booster */
> +enum ufs_wb_flush_status {
> +    UFS_WB_FLUSH_IDLE = 0,
> +    UFS_WB_FLUSH_IN_PROGRESS = 1,
> +    UFS_WB_FLUSH_SUSPENDED = 2,
> +    UFS_WB_FLUSH_COMPLETED = 3,
> +    UFS_WB_FLUSH_FAILED = 4,
> +    UFS_WB_FLUSH_STATUS_MAX,
> +};
> +
> +enum ufs_wb_flush_mode {
> +    UFS_WB_FLUSH_NONE = 0,
> +    UFS_WB_FLUSH_FIFO = 1,
> +    UFS_WB_FLUSH_PINNED = 2,
> +    UFS_WB_FLUSH_MODE_MAX,
> +};
> +
> +enum ufs_wb_resize_hint {
> +    UFS_WB_HINT_KEEP = 0,
> +    UFS_WB_HINT_DECREASE = 1,
> +    UFS_WB_HINT_ENCREASE = 2,
> +    UFS_WB_RESIZE_HINT_MAX,
> +};
> +
> +enum ufs_wb_resize_op {
> +    UFS_WB_DECREASE = 0,
> +    UFS_WB_INCREASE = 1,
> +    UFS_WB_RESIZE_OP_MAX,
> +};
> +
> +enum ufs_wb_resize_status {
> +    UFS_WB_RESIZE_IDLE = 0,
> +    UFS_WB_RESIZE_IN_PROGRESS = 1,
> +    UFS_WB_RESIZE_COMPLETED = 2,
> +    UFS_WB_RESIZE_FAILED = 3,
> +    UFS_WB_RESIZE_STATUS_MAX,
> +};
> +
>   /*
>    * struct UtpCmdRsp - Response UPIU structure
>    * @residual_transfer_count: Residual transfer count DW-3
>

