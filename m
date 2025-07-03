Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B96C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMjJ-0000ja-6j; Thu, 03 Jul 2025 12:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMjF-0000hV-17
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:24:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMjC-0006j9-QG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:24:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso284677b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751559840; x=1752164640; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAR9pDVF5hUoGujqZRHMIvGAE0u3AiggpsjR/ihLtZg=;
 b=OKSRhRzKiEYqP4nAzkrz7Xmprk2UAeecFmc1bCeL5BfyI48JFhlsGOB8DLl1EXnyWI
 jmGZ6fSKQKjJK6f10Y5DMnpl7YBNbSDIm+HaG7fbqo0J++vmUcExgJgaEqa0hWl61Cx6
 oxIy1G5RqRpUsUNnzQHXieOlaUQunj9oyAYYWW9sqEPtx9q4OAIoT7RqXA4f6iRAHrps
 GgC3nBWMXKI3+146EM6n9DpOYqCFJkUA/7BWzGiP0+newM4rQU1LfztTMEGPcSh1KxNM
 QoG4rBKvX5fuod5lLxbch09kD2oxM+io7Q1gJ3y0ip5m0Ln4mVkpgDNUsYPCNJKU3bJu
 Igpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559840; x=1752164640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAR9pDVF5hUoGujqZRHMIvGAE0u3AiggpsjR/ihLtZg=;
 b=i/7hZfbaYUHHnNM+ak9UqWMSpQp7xo0+pIiBF8L/8kWhztKNx8Pcgtheba6+mGw92X
 O7G9YETMz3igqVvELR5nqUUfqF66UudhnpTMRndnqvFiDlNqliZdzWScKBBHUW2k/r+9
 Y0oqhpjIiqAzzWJtZVBhiDwf842TMS9ZCeonOWx+c7idlEVM/aUD13Mf4rlPBIinTkB3
 W6sl4CZ1MSUNa/1D2XtL4cpoFOHuaiXgwG9H7U2ssy7O5/fbu8KYSmWMYkAffW6geGnr
 ylTN3Mi6/VJ/cLiVtuWFTFqXbACejj5HwYNghS6ejKR6N+UnuxxdlvyoSYt8/sYhNuR9
 lYpA==
X-Gm-Message-State: AOJu0YwtPDE/3wRLX27u7ysP6zlaVEPNy+WF0K2ScqYKXqZfnU2DfDgJ
 haHYgukcth3xfNRffCi+ohHvAmha3j7IFoD+JSdMO4z5O7Glg0IGprWp
X-Gm-Gg: ASbGnct/Uy6RbUvjQBGn8a2ye5NroHgNNcMo3myj6irK2Y0H7Ae3cpQMB5glh3ycn4g
 RTKR+fjLNEzseNZV9IArV0vN0/qgVZw8xMcO+j8FZQwr20r9BuurWLba3Y8txSNdtZkJryKoBZ9
 Q9c9btFv/dzwVl7NWGEvrgDsVEAk4nVM06Bdf6/K0mAyC8bhAyXWwL9Q/xoEDaug5cv7d+j84Z7
 pHQM0gqylQVIdPLv2eKWdaagska0ZFmxmO7qMYvEmX8P/FmdPiwbmp2+B6xQFX3ZmC1mdPPVjLr
 HBWnj1pbjWXcf8d4B2s8pF0/D/UyeEQCZA4toGjiSa2ogdVSI2NImZUB0xTmMTRJvg==
X-Google-Smtp-Source: AGHT+IG958++ZBfQ2mwL/heVpUWlSKautY3lAE2wrUlCD8oQiuac13gIaQnOBlCxgeedSaTULXhmDw==
X-Received: by 2002:a05:6a00:2307:b0:748:2d1d:f7b7 with SMTP id
 d2e1a72fcca58-74b515128ccmr9942294b3a.21.1751559839526; 
 Thu, 03 Jul 2025 09:23:59 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce359df31sm29610b3a.29.2025.07.03.09.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:23:58 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:23:57 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 10/11] hw/cxl: mailbox-utils: 0x5604 - FMAPI
 Initiate DC Add
Message-ID: <aGaunVxcE8aOyg2V@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-11-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-11-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
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

On Wed, Jul 02, 2025 at 05:02:16PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Only a minor comment inline ...
> ---
>  include/hw/cxl/cxl_device.h |   4 ++
>  hw/cxl/cxl-mailbox-utils.c  | 109 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +--
>  3 files changed, 117 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed91e5387e..fdee60b977 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -728,4 +728,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
>                                               uint32_t ext_count);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d0a1d63582..5ea0d07808 100644
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
> @@ -3542,6 +3543,107 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
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

/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */

Fan

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
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw *ext = &in->extents[i];
> +
> +                /* Check requested extents do not overlap with pending ones. */
> +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                         ext->start_dpa,
> +                                                         ext->len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +                /* Check requested extents do not overlap with existing ones. */
> +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                                   ext->start_dpa,
> +                                                   ext->len)) {
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
> +                CXLDCExtentRaw *ext = &in->extents[i];
> +
> +                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
> +                                                          ext->len, ext->tag,
> +                                                          ext->shared_seq);
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
> @@ -3669,6 +3771,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)

