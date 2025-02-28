Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A7AC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzw3-0002t7-Dc; Fri, 28 Feb 2025 07:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzw0-0002pM-RW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzvz-0006Bp-0n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740747461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EO0dvLIRsOSJYII3MZSMXo/uV/4vt5Geh4Q79B7fQU0=;
 b=QWi8uFY3/eogAJ9vvB32OSSudEIN2S3LhmlAbfNDdzkYNzu5LrL8GDBQH5FBAIP1fYHWFX
 RpNbEX8hyVhNWzA31z6Af1/d7KvxoOwpduB9hE04BfhA3ezpZzm8PIIkq8mDfUf7idQlXQ
 TQEIW+Y7I0iCy2hALopqTSScMXx9jFA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-GFEU-UFLPae8zzHHrgbjRA-1; Fri, 28 Feb 2025 07:57:39 -0500
X-MC-Unique: GFEU-UFLPae8zzHHrgbjRA-1
X-Mimecast-MFC-AGG-ID: GFEU-UFLPae8zzHHrgbjRA_1740747458
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so1746573f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 04:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740747458; x=1741352258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EO0dvLIRsOSJYII3MZSMXo/uV/4vt5Geh4Q79B7fQU0=;
 b=MzHi0nBprCTw3rrO/0bA/vfJ2O4rGZf63i1en8fzVO8xoSesvjce1E5ipON7YHoymT
 qZCs9GDl0QsY2ifhkGVNqq6LY/n66XvcY+nkrB2pOKDaWzHrjvGxa/aGGs4wX3mrDzB7
 9Dk2d4C75MeuT/6Tj4K1BgC0xJnlVrksE9uOldU3ZZnzmFSpTK8neuhPDp3lKM8ZvhFe
 INl1VFyvFGL9lfcizXLQtrG/VkxlG6RbjAJf12Tn/MbIjrfLK5ZAnrOegsp6Z4c61oM4
 WbXXoYez6AyOJTIc+4SIOAgtYwDdCIln5hWSHuM9G9Je27f1f7eLXCnKKxNak/IdBV2q
 TSAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ6mr9HDb/pylzPC33caDy2oogGG2NQt2uHnRfyfIvoPTyC4Nvo/Jrcck8Q1aYITDCKu3iJEZMtcyZ@nongnu.org
X-Gm-Message-State: AOJu0Yyk8yHELuKd77k5cE6XVNC1wLTtheVnLEUd4SLfOQzn/xXdPJ7x
 nmw8cmILjf1jPLvB/fQG06Wb7r6PuJS0L2OyTC3RBSMJw9jWWDS3bOhH5NgTVTckTldIANZu3B0
 XbgETa3a5ogy78XDemUPtZ3mZRd6CNuhUyyb5UmKjElkSL7o+JGrj
X-Gm-Gg: ASbGnctYcoYtBQQ4DWUhvFcVMp7xdqxEfQY2WvjFQfGXwHgKqX4XDuC36wYhT4RTlsP
 taGN1hKFKN37GOYY5sHXtmVPOoCUDrACXW7KaXNBol978vqLJVMuPt7LblUu4L3dzWtrtmMxg9X
 xBtviSh4hOEvx61qj/nThe86yN7tAW9McMEsx/bLcr7cyNXz9NqmHgaoBUwMEFGnhexqhoD809w
 WNkdNHJwNIS73e1/DnywUjLG4AI6OQVb36JWT7Bo3LuiXl69HJ8BBbiYiYXxXXc1DU5xaKLzDKY
 mLJ1JyFvbKb04Od7svvSYa9nwoHG5lCKAPFV8qaabOkYbLIAOXHe3YQ192rtctM=
X-Received: by 2002:a5d:6da2:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-390ec9bcf2cmr2037407f8f.27.1740747458248; 
 Fri, 28 Feb 2025 04:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5pZkRnTSZmpHVs+jeM3IRrIXDHQTuhiGcbapnJ6k3yjf+h2Zt1ij5RmmtgvDB3MGiIGYEYA==
X-Received: by 2002:a5d:6da2:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-390ec9bcf2cmr2037382f8f.27.1740747457848; 
 Fri, 28 Feb 2025 04:57:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844c0dsm5029592f8f.80.2025.02.28.04.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:57:37 -0800 (PST)
Date: Fri, 28 Feb 2025 13:57:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/19] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250228135735.43c3ad9c@imammedo.users.ipa.redhat.com>
In-Reply-To: <ac3cc2002267e1ad848aea367ff0b08f2c4b5c69.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
 <ac3cc2002267e1ad848aea367ff0b08f2c4b5c69.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Thu, 27 Feb 2025 17:00:43 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Add a new ags flag to change the way HEST offsets are calculated.
> Currently, offsets needed to store ACPI HEST offsets and read ack
> are calculated based on a previous knowledge from the logic
> which creates the HEST table.
> 
> Such logic is not generic, not allowing to easily add more HEST
> entries nor replicates what OSPM does.
> 
> As the next patches will be adding a more generic logic, add a
> new use_hest_addr, set to false, in preparation for such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c           | 39 ++++++++++++++++++++++++---------------
>  hw/arm/virt-acpi-build.c | 13 ++++++++++---
>  include/hw/acpi/ghes.h   | 12 +++++++++++-
>  3 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 84b891fd3dcf..9243b5ad4acb 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -206,7 +206,8 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> +                                   BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
> @@ -251,13 +252,15 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>                                         i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>      }
>  
> -    /*
> -     * tell firmware to write hardware_errors GPA into
> -     * hardware_errors_addr fw_cfg, once the former has been initialized.
> -     */
> -    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> -                                     sizeof(uint64_t),
> -                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
> +    if (!ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write hardware_errors GPA into
> +         * hardware_errors_addr fw_cfg, once the former has been initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE,
> +                                         0, sizeof(uint64_t),
> +                                         ACPI_HW_ERROR_FW_CFG_FILE, 0);
> +    }
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> @@ -331,14 +334,15 @@ static void build_ghes_v2(GArray *table_data,
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
> -    build_ghes_error_table(hardware_errors, linker);
> +    build_ghes_error_table(ags, hardware_errors, linker);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -357,9 +361,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    if (!ags->use_hest_addr) {
> +        /* Create a read-write fw_cfg file for Address */
> +        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    }
>  }
>  
>  static void get_hw_error_offsets(uint64_t ghes_addr,
> @@ -395,8 +401,11 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      }
>  
>      assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> -    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> -                         &cper_addr, &read_ack_register_addr);
> +
> +    if (!ags->use_hest_addr) {
> +        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                             &cper_addr, &read_ack_register_addr);
> +    }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e17861..040d875d4e83 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -946,9 +946,16 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGedState *acpi_ged_state;
> +        AcpiGhesState *ags;
> +
> +        acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +        ags = &acpi_ged_state->ghes_state;
> +        if (ags) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +                            tables->linker, vms->oem_id, vms->oem_table_id);
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index f96ac3e85ca2..411f592662af 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -64,11 +64,21 @@ enum {
>      ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
> +/*
> + * AcpiGhesState stores GPA values that will be used to fill HEST entries.
> + *
> + * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
> + * is stored at hw_error_le. This is the default on QEMU 9.x.
> + *
> + * An GPA value equal to zero means that GHES is not present.
> + */
>  typedef struct AcpiGhesState {
>      uint64_t hw_error_le;
> +    bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,


