Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70389C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZ2u-0001mL-TJ; Mon, 12 May 2025 15:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEZ2s-0001m3-Ub
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEZ2q-0003OZ-1o
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747078954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nkDtm9Lnjo5cyrTByxOa1qBNfkDZM4x6dBOWMRIyzWY=;
 b=FlihpkOhN4udWibjALP4NZtyXUUUx1gUoloc8LAjAQpgnk4oifm3UIGEwONbrLsc/s42an
 PXRDp3TxUS814zTzkGXbU+GwasCBT7MiQqTbbljaL87L5pYvETreNvsVNkI9pBS5KlqcgS
 rHMdlLiaPSo0zSXfsBmLxmJfbg69hPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-oLX1gk3-NZWN1DxgfkHxlw-1; Mon, 12 May 2025 15:42:32 -0400
X-MC-Unique: oLX1gk3-NZWN1DxgfkHxlw-1
X-Mimecast-MFC-AGG-ID: oLX1gk3-NZWN1DxgfkHxlw_1747078952
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so27159395e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747078951; x=1747683751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkDtm9Lnjo5cyrTByxOa1qBNfkDZM4x6dBOWMRIyzWY=;
 b=S+zx0ba4ey+qNxHJHbyjFQX8HUUBV+d1ooHhxl1131ARO2qQ/M+6AUvii5RbPqVvUP
 WKCptfj963dkUTHVyuECu41Xm8f14du5AfSpFLPINzkTCILMQB8AvJzNEMTcF1mHKLQU
 4SmBD0NWXwUpcIph2kWs4dHNBsxFHdFoE2wHgc5nUWwm1mBT5OvBB9hfcuJpdOyrHN5L
 4NzkGJlseik/t9Hd4jblstARZOEw9q9XCJbS2isGr8LvR1vXm5B3SNJvWD0RhQ1JBiGT
 ep0vnhQwGSCiNIlHvIRdrziKRA0957WU06//VrE5wNZxuznwnnNOm9ke4EYINmSweQ1s
 rvqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXICMpyKOCaau0NHHpLXP1KXH1DoHuMubwKE3v5WrzPoa2lb8LbjqO8otqgakelNgik7jIBVMTetNJn@nongnu.org
X-Gm-Message-State: AOJu0Yy53+pjGBjFbmNIKT61DGssZckq1Anrqr3aOsUkW1HYKvpoiTra
 M+bMYNCBWrk0pNEgXedUV3jHB4DyoZuhWo06YdRigbtW6tKShwVrvcuvH3DF5/6Hrgcxc0STsQM
 k9Asb2hbewwuP1sReLFGNgR3ZKQrDscfSbKCyeP7t0xk9idIPbBqI
X-Gm-Gg: ASbGncucDHz1MeAa4Qarno6NEbc1We0gfY3VAh790FD1L9ave2t6CEMGWcLUIq2ayU1
 Y4hZ/f9hZckb5eFV3h5sVE3rE/kdH/noCqT/3FFTG3LZMlFG0d2VVN6MWWKMnI+6CIIOjH2cKA8
 +VQridxtj0aWE6i7rvlczli0iTSOuw1bT90mo6U17f9iZa60hGTanHcK6chMsXdJnC2qOetlrys
 Fo2qpcdufb9Ac2C0Vksyhvb9/KQxZZMW4pUYwBL1GViUdRAA7dlyXlwkepQm+3vJ68SZl4iSn1z
 NGGmgA==
X-Received: by 2002:a05:600c:a00a:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-442d6dd2421mr120003655e9.22.1747078951533; 
 Mon, 12 May 2025 12:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaPTUja3nXtLYCqcBglz3Nf901OuvmwBqg1z+x1kFw4Q1uPi+QWQ1uhTYsA7GUU1gszNGdxQ==
X-Received: by 2002:a05:600c:a00a:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-442d6dd2421mr120003535e9.22.1747078951123; 
 Mon, 12 May 2025 12:42:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442eb5f4ca8sm3063405e9.18.2025.05.12.12.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:42:30 -0700 (PDT)
Date: Mon, 12 May 2025 15:42:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/20] acpi/ghes: don't hard-code the number of
 sources for HEST table
Message-ID: <20250512154053-mutt-send-email-mst@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <1c024a700815fa4a100fc3bada477481fd266a83.1741374594.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c024a700815fa4a100fc3bada477481fd266a83.1741374594.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 07, 2025 at 08:14:38PM +0100, Mauro Carvalho Chehab wrote:
> The current code is actually dependent on having just one error
> structure with a single source, as any change there would cause
> migration issues.
> 
> As the number of sources should be arch-dependent, as it will depend on
> what kind of notifications will exist, and how many errors can be
> reported at the same time, change the logic to be more flexible,
> allowing the number of sources to be defined when building the
> HEST table by the caller.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Breaks CI:

https://gitlab.com/mstredhat/qemu/-/jobs/10007863974

I dropped the patchset for now, pls rebase and repost.

> ---
>  hw/acpi/ghes.c           | 39 +++++++++++++++++++++------------------
>  hw/arm/virt-acpi-build.c |  8 +++++++-
>  include/hw/acpi/ghes.h   | 17 ++++++++++++-----
>  3 files changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 668ca72587c7..f49d0d628fc4 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -238,17 +238,17 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
>  static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> -                                   BIOSLinker *linker)
> +                                   BIOSLinker *linker, int num_sources)
>  {
>      int i, error_status_block_offset;
>  
>      /* Build error_block_address */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
>      }
>  
>      /* Build read_ack_register */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Initialize the value of read_ack_register to 1, so GHES can be
>           * writable after (re)boot.
> @@ -263,13 +263,13 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
>  
>      /* Reserve space for Error Status Data Block */
>      acpi_data_push(hardware_errors,
> -        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
> +        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
>      bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Tell firmware to patch error_block_address entries to point to
>           * corresponding "Generic Error Status Block"
> @@ -295,12 +295,14 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data,
> -                          BIOSLinker *linker,
> -                          enum AcpiGhesNotifyType notify,
> -                          uint16_t source_id)
> +static void build_ghes_v2_entry(GArray *table_data,
> +                                BIOSLinker *linker,
> +                                const AcpiNotificationSourceId *notif_src,
> +                                uint16_t index, int num_sources)
>  {
>      uint64_t address_offset;
> +    const uint16_t notify = notif_src->notify;
> +    const uint16_t source_id = notif_src->source_id;
>  
>      /*
>       * Type:
> @@ -331,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   source_id * sizeof(uint64_t));
> +                                   index * sizeof(uint64_t));
>  
>      /* Notification Structure */
>      build_ghes_hw_error_notification(table_data, notify);
> @@ -351,8 +353,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
> -                                   * sizeof(uint64_t));
> +                                   (num_sources + index) * sizeof(uint64_t));
>  
>      /*
>       * Read Ack Preserve field
> @@ -368,22 +369,26 @@ static void build_ghes_v2(GArray *table_data,
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId *notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>      uint32_t hest_offset;
> +    int i;
>  
>      hest_offset = table_data->len;
>  
> -    build_ghes_error_table(ags, hardware_errors, linker);
> +    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
>  
>      /* Error Source Count */
> -    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, linker,
> -                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
> +    build_append_int_noprefix(table_data, num_sources, 4);
> +    for (i = 0; i < num_sources; i++) {
> +        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
> +    }
>  
>      acpi_table_end(linker, &table);
>  
> @@ -515,8 +520,6 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>          return;
>      }
>  
> -    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> -
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 040d875d4e83..ea9682ee2662 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
>      g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
>  }
>  
> +static const AcpiNotificationSourceId hest_ghes_notify[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -954,7 +958,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          if (ags) {
>              acpi_add_table(table_offsets, tables_blob);
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, vms->oem_id, vms->oem_table_id);
> +                            tables->linker, hest_ghes_notify,
> +                            ARRAY_SIZE(hest_ghes_notify),
> +                            vms->oem_id, vms->oem_table_id);
>          }
>      }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 5265102ba51f..8c4b08433760 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -57,13 +57,18 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> -enum {
> -    ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> -
> -    ACPI_GHES_ERROR_SOURCE_COUNT
> +/*
> + * ID numbers used to fill HEST source ID field
> + */
> +enum AcpiGhesSourceID {
> +    ACPI_HEST_SRC_ID_SYNC,
>  };
>  
> +typedef struct AcpiNotificationSourceId {
> +    enum AcpiGhesSourceID source_id;
> +    enum AcpiGhesNotifyType notify;
> +} AcpiNotificationSourceId;
> +
>  /*
>   * AcpiGhesState stores GPA values that will be used to fill HEST entries.
>   *
> @@ -84,6 +89,8 @@ typedef struct AcpiGhesState {
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId * const notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -- 
> 2.48.1


