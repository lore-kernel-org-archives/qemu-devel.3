Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53DBC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZuU-0007ep-HT; Fri, 06 Jun 2025 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNZuS-0007eK-Pm
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:27:12 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNZuQ-0000MO-Qm
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:27:12 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-313154270bbso2465715a91.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749227229; x=1749832029; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LJo/2H61aEcasih2UA9s9opFRItpP5BcPNNKHiIMYyI=;
 b=Kg+YRDgTNKR0kSVD9lXjEcs2iTOPO5a2Bc+NDVKTxjcwK9ZcDKoM3usa0BRDkpzsHz
 73Dq74hf2j+x2Yz4Sme8KYD/7zvOTd2Pfqd73eF6Qg0lLRh0b5PVcM9KGbrOIJU6fUXW
 H3yxLBYhng0z+Fyx4P1BsQ74Tu241m9Rek5eX94WNl07ejVOthiWcUn47qHPbbEc2rDc
 5TG5ZZh+URJDNycA0l2eLa1YYbDJqiZVyepNlBfbu6OXyZw1FN6ay9MJ4Vk7B0lREoZ6
 hwAixtgqBDCIN4dMbbPQuH24sGxWJqys6HmtoSlTQ6e3bcwAkgfNZZo9jGfJp9awQAnG
 k6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749227229; x=1749832029;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJo/2H61aEcasih2UA9s9opFRItpP5BcPNNKHiIMYyI=;
 b=QYeGp0Iseoh6BDd4V3zv4M7uiNaQyz9Ko7becDNuCctpoZqh2jvqfPAYDLRyOem2GF
 ypFlNb5LsXoDQGCQAQNIG0Mqu80rMjB/b3P0ri366akUl33aAbKWRHx0NdycStGI5bOP
 OXs3ifIgLweUnmRDxGgi8cUs5QrKqWWlIjG023kDxnWuRh1vOTrqS3A2gC2POx2qOWmQ
 MNTKxBwBUeo/Bi955oK/xejoblAADO1bjNQDZR8LD4yTwW7bsMokodEPqgGmDunNqvb8
 BKIcihdGkmmTnV+J5Y6r9aCRvp2gcKXvK2arlAIgJACOXORQXHI40LrMD9jZGnR0cLYO
 G+1w==
X-Gm-Message-State: AOJu0YzK59jmPsFqbYumQT0y7iXj+3XuM0PkJe6CvCerz6qzgAMTx9T6
 /SN6dQWMGJ+X4Q7lkjzUFwmCC6UWfZwOHRQCWDUmqtp5OSH8Wq0yzIso
X-Gm-Gg: ASbGncsSbUUsz5gfz4WBG40AwXwIDIaLfZjlrFo3ff7v0Mgml0FuqzqY/uwMoHawYn5
 snjcR3PMveZujxxh9QXgkqknEe8xmUbfgnlH+g/ME0V3n6LPBE6jH5CL3PGo11H1P8r6MPppkWK
 CGvIVgAymomxwOXnSWwWiF6sRWL22K84eM+yvHTJv2R3fqiSQ7LFaMZExYGESsBcxj1fRoSHlb+
 oMeDLQVAjjxv+KqUAhZqdrJzMoMYD54UUz3LR8ohxoQrm24D16ewArvkTZ1d0WM2Ff5SFXPFLe0
 92923N3ZW2K45e3MbAsNL3PXcdB6hMxbmtuk2JXRQAMjrA==
X-Google-Smtp-Source: AGHT+IEKi6kelnMID7Y/svXIB+jik0hfOHx3xJYctF6Pu+ddRZqnbbb0d7EMCaz4F2yl+M80M3Uyug==
X-Received: by 2002:a17:90b:1646:b0:311:f05b:869a with SMTP id
 98e67ed59e1d1-313472eb280mr5905063a91.8.1749227228714; 
 Fri, 06 Jun 2025 09:27:08 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f35284sm1514066a91.17.2025.06.06.09.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:27:08 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 09:27:05 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aEMW2SDuAE10Iyuf@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-7-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605234227.970187-7-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x102c.google.com
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

On Thu, Jun 05, 2025 at 11:42:20PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

One minor comment, otherwise LGTM.

>  hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  6 +--
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  4 files changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1b5c7216f9..47b1509a0e 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -121,6 +121,7 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO    0x0
>          #define GET_HOST_DC_REGION_CONFIG   0x1
> +        #define SET_DC_REGION_CONFIG        0x2
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3387,6 +3388,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> +     * This command shall fail with Unsupported when the Sanitize on Release
> +     * field does not match the region’s configuration... and the device
> +     * does not support reconfiguration of the Sanitize on Release setting.
> +     *
> +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
> +     * doesn't match.
> +     */
> +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Return success if new block size == current block size */
> +    if (in->block_sz == region->block_size) {
> +        return CXL_MBOX_SUCCESS;
> +    }

Should we move this below, after checking the bitmap?

Fan
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that new block size is supported */
> +    if (!test_bit(BIT((int) log2(in->block_sz)),
> +                  &region->supported_blk_size_bitmask)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    qemu_mutex_lock(&region->bitmap_lock);
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +    qemu_mutex_unlock(&region->bitmap_lock);
> +    region->block_size = in->block_sz;
> +
> +    /* Create event record and insert into event log */
> +    cxl_assign_event_header(&dcEvent.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(dcEvent),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    dcEvent.validity_flags = 1;
> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                         CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                         (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3505,6 +3584,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0 },
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0 },
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b872a26173..ee554a77be 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> -                                    const QemuUUID *uuid, uint32_t flags,
> -                                    uint8_t length, uint64_t timestamp)
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp)
>  {
>      st24_le_p(&hdr->flags, flags);
>      hdr->length = length;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 96ef9be444..76af75d2d0 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp);
>  #endif
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..a05d7cb5b7 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -8,6 +8,7 @@
>  #ifndef CXL_MAILBOX_H
>  #define CXL_MAILBOX_H
>  
> +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
>  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -15,5 +16,10 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
>  
>  #endif
> -- 
> 2.47.2
> 

