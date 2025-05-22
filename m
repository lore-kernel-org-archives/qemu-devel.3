Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E8C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 23:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIF5E-0000r2-PX; Thu, 22 May 2025 19:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uIF5C-0000qr-ED
 for qemu-devel@nongnu.org; Thu, 22 May 2025 19:12:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uIF5A-0002Z3-6w
 for qemu-devel@nongnu.org; Thu, 22 May 2025 19:12:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6927282b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747955528; x=1748560328; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j1J0rdfNf6oSVNd0zB5466LyVNvbYFqQVm29KeuaT/c=;
 b=CSyV44zrUT03oWB0N5EZROS2tuH7FJdnuxnSbUDs3uuwTKKCK7oTUEef5oNWS5GS1e
 kbSSEA/wOt7bk7DyyxGNIsPi5X1kq+1fnmGcA9B3kXDOipi2AsBm4UinGqECMR/Ppt49
 zq3OkRo4/nm8bS5dY5ZkgS1s4eY9HlYDczU2NXeFJKvdTrco9cbw4aPYR41/FEEVjPxM
 w5oaOnfdqQfdQ5LF8t4u5pewx8XpxY0tM23p9uSVRl+vgeWA3rpm6key78HOOVSnIc7C
 PBX7JrNYbomj3VtYtrFfpaVTQrGlMFgcyZvZ9WF8N1w5Nnp8gTeCvsKzwZYtKM2TKdwU
 1vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747955528; x=1748560328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1J0rdfNf6oSVNd0zB5466LyVNvbYFqQVm29KeuaT/c=;
 b=JJkYkXx3BWXb6uV4Ane1DbpcdsdHCFezKPPPhYpqZBKh2a3tnBAKqFPprqn21uXQmT
 2o6cVO3p4MEo2TyyNGJafLtkmV4pSw/0lw7OTd0oO3dfTssFtToo2tcvbrupUwoPRJ9x
 u7qNjB/4r9d2+ITNbLTanVuPiVVFqenowekTLNyRZSSEX+B+eLGsSbveFKlP3Prt4PbP
 b6LddtwLiAYPuK2VYHJqudOFocVRLtk0DfDnnD0dAGFwsum9r2kFrTP/P5TMDwMw6AXP
 CmFbCfVZmEk8cQ/kXaTqdBhGdm7u9sdeMRbiKySTz+oC2Ag+FLBqiZqoXWhAx33CDInQ
 jI9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzrwK0DNtWYDT7EUh7GHrJFP43IMAENx7P+CFJo9YJx2knPet6Xn/AAJV6Tb+9fG+6DJyVAidgPp1c@nongnu.org
X-Gm-Message-State: AOJu0YxOzpb1hf4QXvhxF9TEvuqAtShu6k50r9gLyPk1LLNcy9UabjOn
 xXpdG5vR4vTOwJwbM7EhNnz8jzWeE3cztmJGp5TtA68b1+s1Iv4gtvmO
X-Gm-Gg: ASbGncvTMyW7/PFiTxJ0MwHfZcU/DcIxIuU/dC2KxFC839gsQ2V3tabca76L/x5hvBK
 SGVnN4h33zGUGrWeysvytzpKJRHibJX6TFkbSsxE8XWlMawy+Is5EvIemq0AIlqluw0YiDQiwv1
 Qdxv8i9TiHh5WygVttxuJ6rZ6XxJ4EmVq+d8/3z0C2D8zsXYPTbAELnHeG+vVB8EbJB9KyShu5R
 HpJtNcRaeaTvGU2pqPIvd3rLgQyuJffSmfI2FDZeY7IP78Gngma8eZDAkrO8dUCuOCMsD0trGmB
 SCJ60lAx29JLq8GDziroIrIp38YxMXr3bcSSpLW8aPcmaDFBlOlI5nmu4EZmGERVlweduv5gmfJ
 Yt1KRboJCYQO9
X-Google-Smtp-Source: AGHT+IFEIgXigdlw1VBiXkMiCdivhEwucMa8iHNVPAwYBgAkncbxZL2qPZ1uPumoF+TIZfHlqUeqAA==
X-Received: by 2002:aa7:88c8:0:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-742a97c4fd9mr34074533b3a.11.1747955528252; 
 Thu, 22 May 2025 16:12:08 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9739906sm11733480b3a.80.2025.05.22.16.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 16:12:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 22 May 2025 23:12:05 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
Cc: nifan.cxl@gmail.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com, krish.reddy@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, vishak.g@samsung.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <aC-vRUoCDJ70_yox@deb-101020-bm01.eng.stellus.in>
References: <20250522063135.366295-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522063135.366295-1-vinayak.kh@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 22, 2025 at 12:01:35PM +0530, Vinayak Holikatti wrote:
> CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> ---
> This patch is generated against Jonathan Cameron's branch cxl-2025-03-20
> 
>  hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
>  hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
>  hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
>  include/hw/cxl/cxl_device.h |  6 +++
>  4 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a02d130926..4f25caecea 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -122,6 +122,7 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +        #define GET_MHD_HEAD_INFO 0x1
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_UNSUPPORTED;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
> + */
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in, size_t len_in,
> +                                   uint8_t *payload_out, size_t *len_out,
> +                                   CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    if (cvc->mhd_get_head_info) {
> +        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
> +                                 len_out, cci);
> +    }
> +    return CXL_MBOX_UNSUPPORTED;
> +}
> +
>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in, size_t len_in,
>                                           uint8_t *payload_out, size_t *len_out,
> @@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>          cmd_media_get_scan_media_results, 0, 0 },
>      [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
> +    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
The name here "GET_MULTI_HEADED_INFO" is the same as the previous command.
>  };
>  
...  
> +
> +static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
> +{
> +    uint16_t lnksta = 0;
> +    uint16_t current_link_speed = 0;
> +    uint16_t negotiated_link_width = 0;
> +    uint16_t lnkcap = 0, lnkcap2 = 0;
> +    uint16_t max_link_width = 0;
> +    uint16_t max_link_speed = 0;
> +    uint16_t supported_link_speeds_vector = 0;
> +
> +    lnksta = pdev->config_read(pdev,
> +                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
> +                               sizeof(lnksta));
> +    lnkcap = pdev->config_read(pdev,
> +                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
> +                               sizeof(lnkcap));
> +    lnkcap2 = pdev->config_read(pdev,
> +                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
> +                                sizeof(lnkcap2));
> +    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
> +    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
> +    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
> +    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
> +    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
> +
> +    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
> +    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
> +                                                          negotiated_link_width;
> +    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
> +                                                   supported_link_speeds_vector;
> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
> +                                                                 max_link_speed;
> +    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
> +                                                             current_link_speed;
> +    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
I think it would be helpful to make a define for the ltssm states?
> +    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
> +    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
> +}
> +
>  /* Returns starting index of region in MHD map. */
>  static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
>                                                      CXLDCRegion *r)
> @@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
>      }
>  
>      cxl_mhsld_state_initialize(s, dc_size);
> -
> +    cxl_mhsld_init_head_info(s, pci_dev);
>      /* Set the LD ownership for this head to this system */
>      s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>      return;
> @@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
>  
>      CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
>      cvc->mhd_get_info = cmd_mhd_get_info;
> +    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
>      cvc->mhd_access_valid = cxl_mhsld_access_valid;
>      cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
>      cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
> diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
> index e7ead1f0d2..c9fbec71ca 100644
> --- a/hw/cxl/mhsld/mhsld.h
> +++ b/hw/cxl/mhsld/mhsld.h
> @@ -23,6 +23,18 @@
>   */
>  #define MHSLD_HEADS  (8)
>  
> +typedef struct MHDHeadInfoBlock {
> +    uint8_t port_number;
> +    uint8_t max_link_width;
> +    uint8_t nego_link_width;
> +    uint8_t supp_link_speeds_vector;
> +    uint8_t max_link_speed;
> +    uint8_t current_link_speed;
> +    uint8_t ltssm_state;
> +    uint8_t first_nego_lane_num;
> +    uint8_t link_state_flags;
> +} QEMU_PACKED MHDHeadInfoBlock;
> +
>  /*
>   * The shared state cannot have 2 variable sized regions
>   * so we have to max out the ldmap.
> @@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
>      uint8_t nr_lds;
>      uint8_t ldmap[MHSLD_HEADS];
>      uint64_t nr_blocks;
> +    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
>      uint8_t blocks[];
>  } MHSLDSharedState;
>  
> @@ -52,6 +65,7 @@ struct CXLMHSLDClass {
>  enum {
>      MHSLD_MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +        #define GET_MHD_HEAD_INFO 0x1
>  };
>  
>  /*
> @@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
>      uint16_t resv2;
>      uint8_t ldmap[];
>  } QEMU_PACKED MHDGetInfoOutput;
> +
> +typedef struct MHDGetHeadInfoInput {
> +    uint8_t start_head;
> +    uint8_t nr_heads;
> +} QEMU_PACKED MHDGetHeadInfoInput;
> +
> +typedef struct MHDGetHeadInfoOutput {
> +    uint8_t nr_heads;
> +    uint8_t rsvd[3];
> +    MHDHeadInfoBlock head_info_list[];
> +} QEMU_PACKED MHDGetHeadInfoOutput;
> +
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..c93c71c45d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -732,6 +732,12 @@ struct CXLType3Class {
>                                 uint8_t *payload_out,
>                                 size_t *len_out,
>                                 CXLCCI *cci);
> +    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
> +                               uint8_t *payload_in,
> +                               size_t len_in,
> +                               uint8_t *payload_out,
> +                               size_t *len_out,
> +                               CXLCCI *cci);
I think the indent here needs to be aligned with the open parentheses on
the first line of the function declaration
>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>      bool (*mhd_reserve_extents)(PCIDevice *d,
>                                  CxlDynamicCapacityExtentList *records,
> -- 
> 2.34.1

