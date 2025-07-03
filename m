Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E1C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 03:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXB5w-0003IV-0o; Wed, 02 Jul 2025 23:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXB5v-0003IN-2B
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 23:58:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXB5s-0003ug-FE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 23:58:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso4274477a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751515117; x=1752119917; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Go8oYBd2sxtyrP6WJqHWWOw27H9fU4zxt1+fi7opBI=;
 b=QzBeYBfshtlZBSgtr0w6GLfR7HaVO5OsdlSCyNFHA7C1jzrz54sizc5yFaoYDKbCDZ
 kJB2iSyZln3I/OLCt6t03PLPmkNpa4ilkZMj9ZL+N4XgoE+jINpxjATQVOhvqyubOYlx
 s2569/cz/5Y1Re6dXPa4YRpveSeTwa+lBf3Z2rBb1sHYcK6RT5tTb6gqueRNSBgBtooY
 w+o5LVlNrt+6QvVmq4209CiI/ACxZubgusoJCQ9FTTacp1/THVdiuhSsPQhVRK7B/CgW
 GPjtOoNzoaxkaBQfjiC1RLgtkF3OEwIoNx4QAQC6hLs1MoRwpoEgqpsDwG2NPdt5m6Gv
 gAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751515117; x=1752119917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Go8oYBd2sxtyrP6WJqHWWOw27H9fU4zxt1+fi7opBI=;
 b=qyq0y19fpQXCjdwpNH8PKsOYOC1ti12Klb9gtQ0qOox0veUVwv1zM121Ujn3S/pxwl
 bv+H39E3bd5Y0U3qn5lwuBWG+wsJvdM+tnv2ONshENq4hEpUt9alZlt9egPqFw4cWe5m
 1eRxZNECqb7boCvFjwA87bIPeOw5+RpyNi7x+2NdnOjGgh5cJcmiTcIwrZsewiGmvulI
 tBNG7Uv4j6qIDfy8OCdFSEyGKty1Jjc46QS12GwsQ1BKxb6+kZSxrr+q+BqDSd0o8oHD
 Dw4OooLeb/sqMcHmFztjaQ7giqR42hnjw9sEWG6QZjzKYy3q0/2vVvq2u8QuTPHcR4k3
 /M4g==
X-Gm-Message-State: AOJu0YwmlWOGgq4256wlLQlkR1sodX7zC79Jc2XMXY2zH0nJtZ4fr+eo
 9O2Q0GRiByFafJf4Fdt6wHnFOHvr9DXeLzqsl3rO7gfwiewwKgJAymqv
X-Gm-Gg: ASbGnctzwHzIqaLXAFfIFmkUFsMQEXBjvg65icwUV9Qv9DKhUEVZ43lfX9br8o0t/Cb
 WbZlSavv8S3Qnwnf8s8xhsFsYy2jB7fh7pOp5cPhcUZHC8B/kP8G5/CwTBLup8M6KeTQWdeoSFr
 XNWKGc/U8RCFzgb4I5cEtktNjHqwA+9VW6gk5GWNC5DAiWZOdvlHjSMwMdgnk/TDQNsfoxrW/X4
 HOQ0gLargtaZ3yiSBtmJfVwTuiYkKvb+ShLXcSKGK04ssjkQdNCDwo/yJKQXfviJdEEOkM3KSfi
 ESPXXcF3d7PPHFh32f2XkyGXc/Ds0J+i44zdBCFgt8Pz6+OexT0kYHmOs37r7UkhFkyc
X-Google-Smtp-Source: AGHT+IEy2EBV5wygliAxQ1KH/cRgjS8XYzieVtx7l+itL8MEy6pNnTw5RW11X1TihQZBbbvCvL+vUw==
X-Received: by 2002:a17:90b:3b8c:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31a9d6998d2mr2235412a91.29.1751515117043; 
 Wed, 02 Jul 2025 20:58:37 -0700 (PDT)
Received: from fanair.local ([67.131.46.202]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cc67568sm1097844a91.15.2025.07.02.20.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 20:58:36 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 2 Jul 2025 20:58:34 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, alok.a.tiwari@oracle.com,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 08/10] hw/cxl: create helper function to create
 DC Event Records from extents
Message-ID: <aGX_6ihs4lp-RSr4@fanair.local>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-9-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-9-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x102f.google.com
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

On Thu, Jun 26, 2025 at 10:23:31PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Prepatory patch for following FMAPI Add/Release Patches. Refactors part
> of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
> function to create DC Event Records and insert in the event log.
> 
> Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
> accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
> function is defined.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  1 -
>  hw/mem/cxl_type3.c          | 37 +-----------------------------------
>  include/hw/cxl/cxl.h        |  1 +
>  include/hw/cxl/cxl_device.h |  4 ++++
>  5 files changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..724055f2cf 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
>          }
>      }
>  }
> +
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
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
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e3d54ed124..382c41c025 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -27,7 +27,6 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> -#define CXL_NUM_EXTENTS_SUPPORTED 512
>  #define CXL_NUM_TAGS_SUPPORTED 0
>  #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
>  #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ee554a77be..9c2b9d197b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          CxlDynamicCapacityExtentList *records, Error **errp)
>  {
>      Object *obj;
> -    CXLEventDynamicCapacity dCap = {};
> -    CXLEventRecordHdr *hdr = &dCap.hdr;
>      CXLType3Dev *dcd;
> -    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
>      uint32_t num_extents = 0;
>      CxlDynamicCapacityExtentList *list;
>      CXLDCExtentGroup *group = NULL;
>      g_autofree CXLDCExtentRaw *extents = NULL;
> -    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
>      uint64_t dpa, offset, len, block_size;
>      g_autofree unsigned long *blk_bitmap = NULL;
>      int i;
> @@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          dcd->dc.total_extent_count += num_extents;
>      }
>  
> -    /*
> -     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> -     *
> -     * All Dynamic Capacity event records shall set the Event Record Severity
> -     * field in the Common Event Record Format to Informational Event. All
> -     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> -     * Event Log.
> -     */
> -    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> -                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> -
> -    dCap.type = type;
> -    /* FIXME: for now, validity flag is cleared */
> -    dCap.validity_flags = 0;
> -    stw_le_p(&dCap.host_id, hid);
> -    /* only valid for DC_REGION_CONFIG_UPDATED event */
> -    dCap.updated_region_id = 0;
> -    for (i = 0; i < num_extents; i++) {
> -        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> -               sizeof(CXLDCExtentRaw));
> -
> -        dCap.flags = 0;
> -        if (i < num_extents - 1) {
> -            /* Set "More" flag */
> -            dCap.flags |= BIT(0);
> -        }
> -
> -        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> -                             (CXLEventRecordRaw *)&dCap)) {
> -            cxl_event_irq_assert(dcd);
> -        }
> -    }
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
>  }
>  
>  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..3ae4303383 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -23,6 +23,7 @@
>  #define CXL_DEVICE_REG_BAR_IDX 2
>  
>  #define CXL_WINDOW_MAX 10
> +#define CXL_NUM_EXTENTS_SUPPORTED 512
>  
>  typedef struct PXBCXLDev PXBCXLDev;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 82e3bc1a71..91ec1ba299 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -732,4 +732,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count);
>  #endif
> -- 
> 2.47.2
> 

