Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3246FC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI95Z-0008EI-JA; Thu, 22 May 2025 12:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uI95X-0008DV-BX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 12:48:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uI95S-0005yS-MX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 12:48:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30ea7770bd2so6931606a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747932485; x=1748537285; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GlMKiFRanFtlZJYo40oafrA+55CGT6D7S30D46a1gy8=;
 b=OV4UVvhQtJibkczb7LyaiJrZxZ8CImYiUXE+fXlEf4x2dCn11r4qhayfMtqh6cpUum
 DJxiBKIJSDaILhnbJGZ1z/A6ZXxoALe/8C6SNbQkbctqRAFXPghFuLdbyooJmK27xXIO
 mgGBlYjXURKoK68opz3ljcZLLaYoxwIqTjo+vtOF77zH1PaS644X02JFCRDp703rFSzN
 812dKmhZd+SlADkExL7HGML9V2eHz3lp8jrq4MdO1b3lldz0ApDpmQsTfLyqyw7PY415
 gWaygVdPtEMTJTTgrxfKAFTBkguEgsLHT8MWBQOBboQvWOKm38sh5B0p/0jCtYevDkmC
 DBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747932485; x=1748537285;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlMKiFRanFtlZJYo40oafrA+55CGT6D7S30D46a1gy8=;
 b=XTaCfasJT7lwfhOEEbctYe40rBTRDkfTK/jKTwhq1xzDaUzXxMx8X5GS7NbitGvuXX
 HZ1L/V7T03en0+925m7BJXjZpEJq5YbEKZ4afmYMKrKIUJn1+/bnDrxdb3YYiWQWGW/H
 PpCSRHOSZnaEHJte/zU6pgGkFgvGoN8olzKI1LUC439OgU1DZu5lkKEfiqYXb3J9AYiW
 slMFuI0IpqUmY9sO/42HBkWCTOzrNPjoTZNLXCyordSNWVrreU6rD2UGCBJUenXCUoxO
 q0JA+HjMAmlDbpu0/CBfyRJCk6nymrhpjPJX6F0VAv1Eln+muviJ6KAdNKYIr0ukWrOS
 0+Pw==
X-Gm-Message-State: AOJu0YwiYxdayLVocyzbw7gxNuRXKumrG6Y2HY4olHuLH00Yt/pUUnyI
 1QTht+x/SBN2hjyAVcaXLw8vt39zmiGbfEli7NTCRbtJ066T6lP2dAlR
X-Gm-Gg: ASbGncuH8/FSxyHPcCfPzDZnNIWVd/t7oY1WTy4saK/u+L1RESpvco/fN/wlB3ULIw0
 KYFR6ki3zJq6rKTHy7NkypGDGfVqVX1UHmGhVyfzUQIH/6nPY/sW8yL1umbmniAUQIxwOhwQLSY
 DLHzqnCPFnC47VXuP7lA5cv+8kUNFpP69cTdGrqLEVmORvAI9KMo7O/lD/YcH7QMQvJlFZHq5kf
 hhYQT+j3tJLPasv5s+RJlhPmY4dZNjnBuxqZvHKhhIAxBUsP2QOxbS7rtFyFtrbix0ZY+Wr1uLc
 h08+Ic9J9ucNik/1fhKxgCbpC+m+Wevb54REW0zaeeNAVSS+ys9TrEkHjRRTHnWbL6/ur9bVIXc
 aQhA=
X-Google-Smtp-Source: AGHT+IEI82wszA21q3499uRUANOfVvz0CzEOdUXPtSAqFrWDdKSuplwvedJHfEjbx9YGRUcpDjrEZw==
X-Received: by 2002:a17:90b:3b46:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30e7d5564e7mr45318810a91.17.1747932484548; 
 Thu, 22 May 2025 09:48:04 -0700 (PDT)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365e5bd3sm5751145a91.37.2025.05.22.09.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 09:48:03 -0700 (PDT)
Message-ID: <682f5543.170a0220.2bc644.8b61@mx.google.com>
X-Google-Original-Message-ID: <aC9VQUc0A8z0Oizt@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 22 May 2025 09:48:01 -0700
To: Vinayak Holikatti <vinayak.kh@samsung.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
 <20250522063135.366295-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522063135.366295-1-vinayak.kh@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1031.google.com
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
That does not match the section subject of the spec
Get Head Info (...
> + */
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in, size_t len_in,
> +                                   uint8_t *payload_out, size_t *len_out,
> +                                   CXLCCI *cci)
The indent here is not right.
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                        uint8_t *payload_in, size_t len_in,

> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    if (cvc->mhd_get_head_info) {
> +        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
> +                                 len_out, cci);

indent needs fix.

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
>  };
>  
>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> @@ -3761,6 +3780,8 @@ static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>                                       cmd_tunnel_management_cmd, ~0, 0 },
> +    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
> +    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
>  };
>  
>  void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
> diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
> index 9f633b3bed..981546b5ff 100644
> --- a/hw/cxl/mhsld/mhsld.c
> +++ b/hw/cxl/mhsld/mhsld.c
> @@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
> + *
> + * This command retrieves the number of heads, number of supported LDs,
> + * and Head-to-LD mapping of a Multi-Headed device.
> + */
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                        uint8_t *payload_in, size_t len_in,
> +                                        uint8_t *payload_out, size_t *len_out,
> +                                        CXLCCI *cci)
> +{
> +    CXLMHSLDState *s = CXL_MHSLD(cci->d);
> +    MHDGetHeadInfoInput *input = (void *)payload_in;
> +    MHDGetHeadInfoOutput *output = (void *)payload_out;
> +    int i = 0;
> +
> +    if (input->start_head > MHSLD_HEADS) {

Should be ">=" ?

Also, per the spec, we need also check the "number of heads" field, if 
start_head and number of heads together point to a non-exist head, we
should return invalid input.

> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
> +    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
> +        output->head_info_list[i].port_number =
> +                                 s->mhd_state->head_info_blocks[i].port_number;
> +        output->head_info_list[i].max_link_width =
> +                              s->mhd_state->head_info_blocks[i].max_link_width;
> +        output->head_info_list[i].nego_link_width =
> +                             s->mhd_state->head_info_blocks[i].nego_link_width;
> +        output->head_info_list[i].supp_link_speeds_vector =
> +                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
> +        output->head_info_list[i].max_link_speed =
> +                              s->mhd_state->head_info_blocks[i].max_link_speed;
> +        output->head_info_list[i].current_link_speed =
> +                          s->mhd_state->head_info_blocks[i].current_link_speed;
> +        output->head_info_list[i].ltssm_state =
> +                                 s->mhd_state->head_info_blocks[i].ltssm_state;
> +        output->head_info_list[i].first_nego_lane_num =
> +                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
> +        output->head_info_list[i].link_state_flags =
> +                            s->mhd_state->head_info_blocks[i].link_state_flags;
> +    }
> +
> +    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
>      [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
>          cmd_mhd_get_info, 2, 0},
> +    [MHSLD_MHD][GET_MHD_HEAD_INFO] = {"GET_HEAD_INFO",
> +        cmd_mhd_get_head_info, 2, 0},
>  };
>  
>  static const Property cxl_mhsld_props[] = {
> @@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>      s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
>  }
>  
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

s/head_info_list/head_info/

Fan

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
>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>      bool (*mhd_reserve_extents)(PCIDevice *d,
>                                  CxlDynamicCapacityExtentList *records,
> -- 
> 2.34.1
> 

