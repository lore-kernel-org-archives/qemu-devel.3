Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A0BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 18:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHRO3-0006aM-LN; Tue, 20 May 2025 14:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHRO0-0006a0-45
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:08:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHRNx-0005bT-Qi
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:08:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso6768008b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747764496; x=1748369296; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FGZOIKDHXfmlCpUXnw2zM5I9TqK9NU7ayWgoiqsfGqQ=;
 b=YV1khhwUxREK7GYQ6NxeN4e9hCMXarMwTFApUutns4ErtNQUJdzSu3pzrpyGWEWJcf
 3xdblpkOCaS/xuEb7HPWoyuuvTFaEek0E7f6FlBj7hf0AeyMQm5Z62JStfrqcTZtODZj
 ZBNYLE/MziEhxWFYIwKu0sE1oBDecqaAfuT3CeYEZPZCtb9x42w/hCjzFWIrIx/rlBKy
 2VFZ1ULeBl/cJ6f6Bh18k4/6RzwqRQXZpe34Ab7uKchRNizfPd0SOWNcvS8rNsVYTzoF
 nU0WE1t6zQtOSjLpxJyvUYlh8aoL9x5krYjEN5vIwctzOCGlw6PIwQYWnm/RXBW7wUnn
 7DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747764496; x=1748369296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGZOIKDHXfmlCpUXnw2zM5I9TqK9NU7ayWgoiqsfGqQ=;
 b=jrr2ETH8BrfsgGUiWsJV0Rt/CdHUcQaBuJ8iZAyHQOQq75TKCxYOjORroFdyJy07I4
 oRzoqsdUL54a/1TTyG/WXsM37o9GQ2aYzvHY7RrxPJ3FCqgTkGWvJcni73lYObV01qm1
 V9Tbpy+eGjJWrebH0Gx8nPnz5uSVT05XwnzzDWBkoYmCVzxd6M6ulq5KOWl6CaHJhDIf
 IFDbO02aSdJr8x9PkqsOScYwUtfIGbtHvwmKPtsA5aIYUA8fuVG1gSiyVkoSTpvkNm9E
 8/jOv1iC2KH3y2R7c7OQCovcIEJ5Peqx6oiOMcdV60mgdnGqMDzfiU4CMS4mnLEGA3KF
 +hbA==
X-Gm-Message-State: AOJu0YxUlMBr71MghLWx/M/gE94jSBojhF9tV055cdnpQJzcxFSae5lH
 /cWEPbfpujGEhulXpntA1rZBldWzoS1JRECKclDuG5z6yTjPVqgcpWly
X-Gm-Gg: ASbGnctBTGG8nl28Q0S3qHZsclMMpUyyLeP8YZLWUG0VeC26I2rXPInXGXfzUXV438V
 dwE838I1KXRRrdV6CsLlNbj3YBDZel6qrmGaOtRhrWpEvkcZnHMKu+6nE32FX6a8Uzjul4Ngk2K
 M8fPyw59PpGNbfgGj+wzpornjUPQ9wxSez8jyWld0LFZuleqdA5EZUpybk+p4QpGNrD4DKiHWQO
 Oxh2lJRclJPeu5AbNhN5jL7FjavNOFSKNUo0uTGg9maqGpGa/Y+/yENDHiBONG7i6sHzE6lJqAz
 YRAQihzW4Ex5ipQzVB/G2KgtXBrjdOGs+pcrHSIx2g==
X-Google-Smtp-Source: AGHT+IEjlGtC8XDja5CbbL/XfYOy/ih8P9vPo+gLIc2jmZoqHOefGAxAqq0KsiPIy8MhoVCWrlSxjg==
X-Received: by 2002:a05:6a20:3d12:b0:1f5:59e5:8ada with SMTP id
 adf61e73a8af0-2162187a945mr24644341637.4.1747764496008; 
 Tue, 20 May 2025 11:08:16 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf8ead7sm8292634a12.46.2025.05.20.11.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 11:08:15 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 11:08:13 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Message-ID: <aCzFDaVWQoclyR0l@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-10-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-10-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x434.google.com
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

On Thu, May 08, 2025 at 12:01:05AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 

This patch needs to fix. See comments below.

> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   8 +-
>  include/hw/cxl/cxl_device.h  |   4 +
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  4 files changed, 204 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a897a34ef9..9b176dea08 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> +                                                        uint16_t host_id,
> +                                                        uint32_t ext_count,
> +                                                        CXLDCExtentRaw extents[],
> +                                                        CXLDCEventType type)
> +{
> +    CXLDCExtentRaw ext;
> +    CXLDCRegion *reg = NULL;
> +    int i, j;
> +
> +    if (host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    for (i = 0; i < ext_count; i++) {
> +        ext = extents[i];
> +
> +        if (ext.len == 0) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
> +        if (!reg) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        /* Check requested extents do not overlap with each other. */
> +        for (j = i + 1; j < ext_count; j++) {
> +            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
> +                               extents[j].len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}

Per the spec, we need to detect resource exhausted case.
"The command shall fail with Resources Exhausted if the Extent List would cause the
device to exceed its extent or tag tracking ability."

We need to make sure the total number of extents does not exceed the max
number of extents the device can maintain.


> +
> +static int cxl_mbox_get_pending_ext_count(CXLType3Dev *ct3d)
> +{
> +    CXLDCExtentGroup *group;
> +    CXLDCExtentList *list;
> +    CXLDCExtent *ent;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(group, &ct3d->dc.extents_pending, node) {
> +        list = &group->list;
> +        QTAILQ_FOREACH(ent, list, node) {
> +            count++;
> +        }
> +    }
> +
> +    return count;
> +}
> +
> +static int cxl_mbox_get_accepted_ext_count(CXLType3Dev *ct3d)
> +{
> +    CXLDCExtent *ent;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> +        count++;
> +    }
> +
> +    return count;
> +}
ct3d->total_extent_count is used to record number of accepted
extents.
So in below, the code logic is not correct.
> +
> +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
> +                                       uint32_t ext_count,
> +                                       CXLDCExtentRaw extents[])
> +{
> +    CXLDCExtentGroup *group = NULL;
> +    int i;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        group = cxl_insert_extent_to_extent_group(group,
> +                                                  extents[i].start_dpa,
> +                                                  extents[i].len,
> +                                                  extents[i].tag,
> +                                                  extents[i].shared_seq);
> +    }
> +
> +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +}
> +
> +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                                         CXLDCEventType type,
> +                                                         CXLDCExtentRaw extents[],
> +                                                         uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = ct3d->dc.total_extent_count -
> +                              cxl_mbox_get_accepted_ext_count(ct3d) -
> +                              cxl_mbox_get_pending_ext_count(ct3d);

This is not right.

As I mentioned total_extent_count only accounts for accepted extents
today.
Also, max number of extents to track is hardcoded to
CXL_NUM_EXTENTS_SUPPORTED.

The value for the above shoud be consistent with what we return for
command 5601h or 4800h.

Based on the spec cxl r3.2 9.13.3.3 Extent list Tracking.
We should take pending extents into account when considering the
tracking ability. So after this series gets in, we need to fix
"num_extents_available" field for 4800h.
Or a easier way, take pending list counting into total_extent_count.


Fan
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int rc;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents exceeds device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> +                                                   in->host_id,
> +                                                   in->ext_count,
> +                                                   in->extents,
> +                                                   DC_EVENT_ADD_CAPACITY);
> +        if (rc) {
> +            return rc;
> +        }
> +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_ADD_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3724,6 +3912,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>          cmd_fm_get_dc_region_extent_list, 12, 0 },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index edc29f1ccb..71fad3391c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1991,8 +1991,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>   * the list.
>   * Return value: return true if has overlaps; otherwise, return false
>   */
> -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> -                                           uint64_t dpa, uint64_t len)
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtent *ent;
>      Range range1, range2;
> @@ -2037,8 +2037,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
>      return false;
>  }
>  
> -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> -                                                 uint64_t dpa, uint64_t len)
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtentGroup *group;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 22823e2054..93b6df0ccd 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -824,4 +824,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index ad4e614daa..72ea0a7d44 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -66,5 +66,6 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
>          #define GET_DC_REGION_EXTENT_LIST 0x3
> +        #define INITIATE_DC_ADD           0x4
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni

