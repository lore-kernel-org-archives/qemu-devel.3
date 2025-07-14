Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76792C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFbc-0005Fo-AG; Mon, 14 Jul 2025 05:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubFYR-0003Ck-KP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubFYM-00047O-33
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752485571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BkT8p2YW/M9VYSgCvpbzN2lnaj46fH5yJZ5UAMNKGU=;
 b=UX0uwDXmbE9Cw/l+U8l4s4S7FkvWiwQ1f9tbMrnEufRmyRocoC3RbRsmUSX6T8aeV3X0H3
 46bsOuEzLACIBahe1YRMtXJHNGpj72WGxSs3nKz893gxnhu7YXVFaSEygAw71atHzv+3HS
 9hN3t9so2VW3UVzQP0ey6mNvN9gXsx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-FKQjpUeaOA6Es47rUlQOqg-1; Mon, 14 Jul 2025 05:32:24 -0400
X-MC-Unique: FKQjpUeaOA6Es47rUlQOqg-1
X-Mimecast-MFC-AGG-ID: FKQjpUeaOA6Es47rUlQOqg_1752485543
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455e918d690so12116255e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752485543; x=1753090343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BkT8p2YW/M9VYSgCvpbzN2lnaj46fH5yJZ5UAMNKGU=;
 b=QgUJv28eiJhpNyH4nPcD7BODNykKx/27ZEROPxrO8jaf3QeKo4n2aXCbQ4egkiRPQH
 RQt1n4P/Vhzz1miaDcmCa2Ix9R0nedcnNzrDJqeWansuafBHJTn4dTEVW3YvxWgVukcf
 ecDZlIyGAgd6F8MW1YQ4HWhn9u06i5WFQz0RHvs6A7yFQ1BFeDf1pGpjYIZ7bHjko2Xn
 0U+Ka5pNEq1DrCpXjYjL+z2BT00fNaP6l3HNVFBUpxXsoVOYDbBf/oBLJgQU3TpkePPA
 r1U2U4JpdY6gYVZSoMWEdFFn3ZgwhcnvOaizNkJLAFMvOvxmjg89YmkoLB311d9dpLE8
 5ItQ==
X-Gm-Message-State: AOJu0Yy0rSdh1d5WL1cjwilFPFGAUBK35o9BOyIO/GRZwGPbgdwZAF7g
 eBojAx2+6BTf3pP7R1wu/OyjBjUQQkFmYi1fmxlBat1YRK9gOUvUtb/csPvM6sS/pbIOIti/kLQ
 bTp0ZREA/8w+w/ZDfU7kA2E9cmKwECPnpBalSzplqn1UCoaGnRJKIHvDJeBvpAKjZ
X-Gm-Gg: ASbGncv7ARvhRdctXIp2YqfB5tma7igcwVfj9J0FxwMHyqVEW1LbLqY7CdljlJYLPSE
 NcjMB0qXkdjBrgZq4CSKMOYKEeKYGqZ4Jy+WAFAPGa/wougq3JGLN1LkHKUZBySA4v/L9Ito1uM
 Y9pfR6Sm7MrF8AhkvZhpQ4SgT+TOxKLvcs82PTolDlZfhQqfeJDawi6qBnQI/7UhGMBBeXwCnMu
 fEZbaTNMJZuvFD5ccygzR0TjoxrE4a8U52nSuGK3N5LoixOs8rXW2BpG8p/2jUPGe9RHWFc9m1F
 59MCb/Kvr2KTLd8PTzNAGuxzWMqkIt0C
X-Received: by 2002:a05:600c:c097:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-454db8b7aa9mr123777625e9.10.1752485543038; 
 Mon, 14 Jul 2025 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmqmT+EBkAgDQgxCs3fzbMYZTOiU6Wq2jej9Z8+hmfEvxkO4md31GcLOvInI3c9HtrT1f5RA==
X-Received: by 2002:a05:600c:c097:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-454db8b7aa9mr123777295e9.10.1752485542441; 
 Mon, 14 Jul 2025 02:32:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b600722780sm4251288f8f.23.2025.07.14.02.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 02:32:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 05:32:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <20250714052757-mutt-send-email-mst@kernel.org>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  6 +--
>  4 files changed, 98 insertions(+), 3 deletions(-)
> 
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
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index bf1710b251..1fc453f70d 100644
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
> @@ -3390,6 +3391,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
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

This does not work: test_bit works on unsigned long, while
supported_blk_size_bitmask is uint64_t.

Why so funky? what is wrong with:

if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))

And BTW why cast to int here?


> +
> +    /* Return success if new block size == current block size */
> +    if (in->block_sz == region->block_size) {
> +        return CXL_MBOX_SUCCESS;
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
> @@ -3508,6 +3587,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> -- 
> 2.48.1


