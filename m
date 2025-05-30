Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF9C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 14:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL0qD-0002ZQ-4X; Fri, 30 May 2025 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL0qB-0002Z0-J7
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL0q8-0006Zj-1G
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748615766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/a5/vGJlf6FRqZe0d0YrCOWXV3mq8ZW9W/UpoyL/gU=;
 b=c6As4DWoR3vIgRp++U5XTcdC8weVtj7mvaJRVnnbN7vip/5C5OIMEi42HnbMWrTs5Vl4qJ
 m1rkcePifzl/HqEYzqydBH2qPH4flEEpsAVvuBrTVnxIDt7nxqG5zvjGzfocsxuDanavo4
 eOvedJYW1w/WdiKJSvtAaUxuev6qThA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-o-6PbwcnMoOp1gNqxTtXfA-1; Fri, 30 May 2025 10:36:04 -0400
X-MC-Unique: o-6PbwcnMoOp1gNqxTtXfA-1
X-Mimecast-MFC-AGG-ID: o-6PbwcnMoOp1gNqxTtXfA_1748615763
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so17083615e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 07:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748615763; x=1749220563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/a5/vGJlf6FRqZe0d0YrCOWXV3mq8ZW9W/UpoyL/gU=;
 b=XxCVaazRjovsVLuCQHmfowLjg40UIwWGgYwdaOXqCbu7MdqYE5vyNrtkJIIc2J3Z3H
 YuiqeVYioKsyAjwhM92z8UZu7gkRJm8zi5mvQNUraff9orh7r9jnBl40st/wBfvD1+Tv
 b2ZyQm2yo307xBBkIfEGR86Cqgvxtey4rwWiWutfBJPPg4VO2egh1iSXEjipjK5T8GkF
 YTnU8U0MMVIkDsfYx1CCdiXLfFi97rCER3drW8oWdd8v1o4lSPA3LVlrcs6i4nNkvppw
 0YvUoClo+h8jXwAwBNvJK9CcOrCwX+gmeoII/YThJM5BL5RRtqvesGyyDL/FO10piLWt
 TfOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY8WdTQ3TU3guq09fAQr17wQPRqSnmI1L8dYweUVGMs5+Re1R0YbbUgKcSc1FFMKc6995CeyXxz+Nt@nongnu.org
X-Gm-Message-State: AOJu0YwFNlY+CVIUAw/lXmEvnP1sZNycPjGKkcjOSENdKNQ4P1asSXBJ
 AxJwoBdBTdY/2e8SseGDH1HqiWP5m4LF71WT30AaMu+0EzE9NQjoOQUnDRWm9RsyAIO702DoS0U
 lDGD+L60AcMgMwFYRmkQ5r6aYBgYPg0TEWCus2gD5nv50jZWVPm/yXirN
X-Gm-Gg: ASbGncsq4pZA606cH2JAG544wmrQLnnP7yKh3/nAxZMkR8c6KxQuDJJ+Q7joYOWm/Ht
 OT7yL+C7tg43+irKyyFl51WMn9wkzVUQ4Xaqe2IUzU2X9Z7d4dIwMv1tNabp2aZp0o0h1cplwzF
 sPAsggfs5mpIu/LxkULK6AVbhySy7zL+Lu/MiQ9znbJnvPtlobC9vj4woSheD25QdKNbyaTQ2Bq
 SYcVfMXkF4FVpZS3qbwM4IMXpmNm8K3gm8PWzethwjKpZacXjuZweP3RS0xu3sPCZLO5TV+svMP
 T/dQuDuzPEcjO8h402iWsUq/RTdCk52V
X-Received: by 2002:a05:600c:8b68:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-450d651182fmr45228805e9.10.1748615763049; 
 Fri, 30 May 2025 07:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV3HJ8ILb3aqwl8Zpd/iyskFtiwxOT/H5EXz/BdpsSQTWkKiiuGboUgNaAOEqcUU7F2TbGtg==
X-Received: by 2002:a05:600c:8b68:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-450d651182fmr45228485e9.10.1748615762654; 
 Fri, 30 May 2025 07:36:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa249esm19938405e9.13.2025.05.30.07.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:36:02 -0700 (PDT)
Date: Fri, 30 May 2025 16:35:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] acpi/ghes: move use_hest_addr out of
 acpi_build_hest()
Message-ID: <20250530163558.2182fcb3@imammedo.users.ipa.redhat.com>
In-Reply-To: <e1abcd0e1c5b66d91a7faed5b4147951c11b2e6d.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
 <e1abcd0e1c5b66d91a7faed5b4147951c11b2e6d.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue,  4 Mar 2025 14:30:56 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The only reason why we're passing ags to acpi HEST table build
> is to check if migration will be used or not.
> 
> Well, we only need migration for arm, as other architectures
> will only use the new code. So, move this out of acpi_build_hest(),

> as otherwise we can't use it for x86, as the hotplug logic there
> may not initialize ags during acpi table build time.

can you expand on what hotplug logic you are talking about?

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           | 16 ++++++++--------
>  hw/arm/virt-acpi-build.c | 12 ++++++++----
>  include/hw/acpi/ghes.h   | 25 +++++++++++++------------
>  3 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 1fd5ba941771..ea00fed75c16 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -243,7 +243,7 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> +static void build_ghes_error_table(GArray *hardware_errors, bool use_hest_addr,
>                                     BIOSLinker *linker, int num_sources)
>  {
>      int i, error_status_block_offset;
> @@ -289,7 +289,7 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
>                                         i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>      }
>  
> -    if (!ags->use_hest_addr) {
> +    if (!use_hest_addr) {
>          /*
>           * Tell firmware to write hardware_errors GPA into
>           * hardware_errors_addr fw_cfg, once the former has been initialized.
> @@ -372,7 +372,7 @@ static void build_ghes_v2_entry(GArray *table_data,
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +void acpi_build_hest(GArray *table_data, bool use_hest_addr,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId *notif_source,
> @@ -386,7 +386,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  
>      hest_offset = table_data->len;
>  
> -    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
> +    build_ghes_error_table(hardware_errors, use_hest_addr, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -398,7 +398,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  
>      acpi_table_end(linker, &table);
>  
> -    if (ags->use_hest_addr) {
> +    if (use_hest_addr) {
>          /*
>           * Tell firmware to write into GPA the address of HEST via fw_cfg,
>           * once initialized.
> @@ -411,13 +411,13 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> -                          GArray *hardware_error)
> +                          bool use_hest_addr, GArray *hardware_error)
>  {
>      /* Create a read-only fw_cfg file for GHES */
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    if (ags->use_hest_addr) {
> +    if (use_hest_addr) {
>          fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
>      } else {
> @@ -529,7 +529,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>          return;
>      }
>  
> -    if (!ags->use_hest_addr) {
> +    if (ags->hw_error_le) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
>      } else {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 154337e1a77b..71da17b652b2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -964,9 +964,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          acpi_ged_state = ACPI_GED(vms->acpi_dev);
>          ags = &acpi_ged_state->ghes_state;
>          if (ags) {
> +            bool use_hest_addr = ags->use_hest_addr;
> +
>              acpi_add_table(table_offsets, tables_blob);
>  
> -            if (!ags->use_hest_addr) {
> +            if (!use_hest_addr) {
>                  notify = hest_ghes_notify_9_2;
>                  notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
>              } else {
> @@ -974,7 +976,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                  notify_sz = ARRAY_SIZE(hest_ghes_notify);
>              }
>  
> -            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +            acpi_build_hest(tables_blob, use_hest_addr, tables->hardware_errors,
>                              tables->linker, notify, notify_sz,
>                              vms->oem_id, vms->oem_table_id);
>          }
> @@ -1143,8 +1145,10 @@ void virt_acpi_setup(VirtMachineState *vms)
>      if (vms->ras) {
>          assert(vms->acpi_dev);
>          acpi_ged_state = ACPI_GED(vms->acpi_dev);
> -        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> -                             vms->fw_cfg, tables.hardware_errors);
> +        AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> +
> +        acpi_ghes_add_fw_cfg(ags, vms->fw_cfg, ags->use_hest_addr,
> +                             tables.hardware_errors);
>      }
>  
>      build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index df2ecbf6e4a9..eae6d4d0a562 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,31 +73,32 @@ typedef struct AcpiNotificationSourceId {
>      enum AcpiGhesNotifyType notify;
>  } AcpiNotificationSourceId;
>  
> -/*
> - * AcpiGhesState stores GPA values that will be used to fill HEST entries.
> +/**
> + * struct AcpiGhesState - GPA values that will be used to fill HEST entries
>   *
> - * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
> - * is stored at hw_error_le. This is the default on QEMU 9.x.
> + * @hest_addr_le: GPA of the HEST table. Used on QEMU 10.x and above.
> + * @hw_error_le: GPA of the etc/hardware_errors firmware.
> + *               Used only on arm64 virt-9.x to preserve compatibility
> + *               with QEMU 9.x.
> + * @use_hest_addr: True if HEST address is present. Used only on arm64,
> + *                 to identify if QEMU 9.x migration is needed.
>   *
> - * When use_hest_addr is true, the GPA of the HEST table is stored at
> - * hest_addr_le. This is the default for QEMU 10.x and above.
> - *
> - * Whe both GPA values are equal to zero means that GHES is not present.
> + * When both GPA values are equal to zero means that GHES is not present.
>   */
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool use_hest_addr; /* True if HEST address is present */
> +    bool use_hest_addr;
>  } AcpiGhesState;
>  
> -void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +void acpi_build_hest(GArray *table_data, bool use_hest_addr,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId * const notif_source,
>                       int num_sources,
>                       const char *oem_id, const char *oem_table_id);
> -void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> -                          GArray *hardware_errors);
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> +                          bool use_hest_addr, GArray *hardware_error);
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>                              uint64_t error_physical_addr);
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,


