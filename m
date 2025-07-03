Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A07C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 04:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXBOF-0007XV-FT; Thu, 03 Jul 2025 00:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXBOD-0007X1-LN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:17:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXBOA-0002aa-KK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:17:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23526264386so47213285ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751516251; x=1752121051; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=08NQ+TjkxcZaFANSHy0nh1+PPk3TzQQAToiAVZBT/ME=;
 b=gWGQHq1Y0/CjuRXiRgBaw1axIplNb64NFRe8N9FSxH1bvEjRcTukMQ6LEmLsWJwOWK
 LqPwWRv0WcyoIy3aYBcWD3c325keNq7Bm2BPFVEnOjZxH49citeqw3rY2gVkhFWY+jf+
 Ych2Cj2W8HEPoqKpJSecQliCF6cFyX3D7Ox1ijj0EGJKQwzDlWv/37vzbDPY4H+oy0/o
 gVQDiBTMIgQY1fRPVYEOuB00MWnaNuVoiln9yrV8TbmxovYSPJ0wuEVTyGLAcKaSTkjV
 ZO8Ye8JPlqvOqcbLOg/b0SwO5uVcTje3NxVwqD/t6wPqm/AS5DsrZhRE1cw13RB7UV/t
 m8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751516251; x=1752121051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08NQ+TjkxcZaFANSHy0nh1+PPk3TzQQAToiAVZBT/ME=;
 b=Kx8oT8wLPMlQdOSxZVNa+QcJtUvMELxa2ClLG79ZnP50yOlJOjhwzSEgDfz4OAeXER
 DR/IXQVroXdkwCfsHE99RN4PHzOSrzcQqSNy1oNHzoRlISlQA03hnt4YffcWGHStpV0z
 fVNr8AWH4NgrV6n0frQtkN2EbIWrpumlIdCxiPihfJJFmyhFv4sKVQ/et2w3JDTQuRi4
 1ey+1CaqDBUwFKY3mK7oBqMB08mv+MwFHBwYXC1C4K3GLRbEzym/G04Qjm5zf6VWTF3j
 0fRYe+qbw5NNwwDmuocvLyMqqG9AZB/JbWFFDQYAKuCm+lJhjGkBldNjWLxu+1nWTbUc
 QxDw==
X-Gm-Message-State: AOJu0YyepBSuLi49I0wf85OlULcDq9X+sbqdRnx79AmzkRI4aYfm1JUK
 Cp2eDwBo40Xc4lgnfsPMheCUF9NhHAVIzODn6G8Pgv7J/Ma6lV2AjvPd
X-Gm-Gg: ASbGncu1PzB2T9QZtEMLgShjyFJZYHDWsY/n1GaxOrle64mwmHx4bvkBYjAhzXaimpl
 AcOZa8SMYYLLHN5C2guWDKF8gSykH+19xXL5EtSYvVpRTTktCUC2On18qmZ/wqatJwGCps411A7
 NfscorClzYCK7zb1MWN02te/uckK5gbXg0KojI/jHA6CigAalhB6CArUvqTFMvqEWC3WqPqXERN
 OfHT8m2M7CzCKsQuTHqT9IzlXdF34cNQ8RZv32TpnNPM0GUOjbBcPUtaSF9lwGj8seZjJKSgMSS
 pbD0PPyrfsIMvcfjx1OJrCUuc+yt1YG8w5+c7/130DLc0eBDIjqdI3tkUUwjBU6xojMMTkL0PNU
 f
X-Google-Smtp-Source: AGHT+IEbGztOUWf5B7SpFHLemr8o7EKypKBByaiK87oOjUhC7qGuUyRY3Ci1wZazLCfp5+V8KPf0/w==
X-Received: by 2002:a17:902:e5cc:b0:234:c7e6:8459 with SMTP id
 d9443c01a7336-23c6e5023f8mr71405255ad.20.1751516251221; 
 Wed, 02 Jul 2025 21:17:31 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e219asm151676075ad.40.2025.07.02.21.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 21:17:30 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 04:17:28 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, alok.a.tiwari@oracle.com,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aGYEWDOGPbtncEmN@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-10-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-10-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
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

On Thu, Jun 26, 2025 at 10:23:32PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

Minor comments inline...

>  hw/cxl/cxl-mailbox-utils.c  | 106 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +--
>  include/hw/cxl/cxl_device.h |   4 ++
>  3 files changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 382c41c025..787eeaa7b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -122,6 +122,7 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG   0x1
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3539,6 +3540,104 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() function which accepts
> + * CXLUpdateDCExtentListInPl as a parameter.
> + */
> +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> +                                CXLUpdateDCExtentListInPl *extent_list,
> +                                int count)
> +{
> +    int i;
> +
> +    extent_list->num_entries_updated = count;
> +
> +    for (i = 0; i < count; i++) {
> +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> +        extent_list->updated_entries[i].len = raw_extents[i].len;
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */

Keep the spec reference comments consistent like below,
/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */

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
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
> +            /* Adding extents exceeds device's extent tracking ability. */
> +            if (in->ext_count + ct3d->dc.total_extent_count >
> +                CXL_NUM_EXTENTS_SUPPORTED) {
> +                return CXL_MBOX_RESOURCES_EXHAUSTED;
> +            }
> +
> +            g_autofree CXLUpdateDCExtentListInPl *list =
This seems not consistent with existing code style. Type declaration
comes first.
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw ext = in->extents[i];
Use pointer as Jonathan mentioned.
> +                /* Check requested extents do not overlap with pending extents. */
shorten the comments like
Extents to add cannot overlap with pending extents
> +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                         ext.start_dpa, ext.len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +                /* Check requested extents do not overlap with existing extents. */
Not allowed to add extents already existing
> +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                                   ext.start_dpa, ext.len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +            }
> +
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            CXLDCExtentGroup *group = NULL;
> +            for (i = 0; i < in->ext_count; i++) {
> +                group = cxl_insert_extent_to_extent_group(group,
> +                                                          in->extents[i].start_dpa,
> +                                                          in->extents[i].len,
> +                                                          in->extents[i].tag,
> +                                                          in->extents[i].shared_seq);
Shorten the lines as Jonathan suggested. 

Fan
> +            }
> +
> +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +            ct3d->dc.total_extent_count += in->ext_count;
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_ADD_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "CXL extent selection policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3666,6 +3765,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> index 9c2b9d197b..7676d785c2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
> @@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
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
> index 91ec1ba299..7be68d98c6 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -736,4 +736,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
>                                               uint32_t ext_count);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> -- 
> 2.47.2
> 

-- 
Fan Ni (From gmail)

