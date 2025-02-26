Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EAAC18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIXn-0003Xg-6K; Wed, 26 Feb 2025 09:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIXO-0003UB-9w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIXK-0002nV-Sa
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740580640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNNyHaSzh3aipvYYRYAq367+LGxJVyGiBGHv/4SoK5k=;
 b=LbA1zzU/ipY9SBGh6XbW7rXQoaqat/+rw0UpBeU+eyg8o52pcv4yOZWxhbjgB8DqpapjPx
 YvR6/uHvv2ZLYuKne+6ZvNAlwUQPxEJuPT4cYcm2034c42zGOsPigwjIFlglbsIYeKn2Bx
 CLxiMoujWKRyn5TyhVwkZkeFYSdUeWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-9PfULTKjMAqyk9g6VG9rCQ-1; Wed, 26 Feb 2025 09:37:18 -0500
X-MC-Unique: 9PfULTKjMAqyk9g6VG9rCQ-1
X-Mimecast-MFC-AGG-ID: 9PfULTKjMAqyk9g6VG9rCQ_1740580637
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so34829325e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740580637; x=1741185437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNNyHaSzh3aipvYYRYAq367+LGxJVyGiBGHv/4SoK5k=;
 b=Ma9qzSNQLKGpxSA3/5ocy3SYu/p1jlYTZY0I1oMqjLStj1yBl4jFVmddOHLcocS+KF
 V6DZc1fGsY95Hb66pqqhoVKDYek+N0EWQUQhyVvcSVZv8KI2yQwu2KfDqSM3cLQJsVuL
 L5DvmATvfEUIuhHSCUkh75uPtdsiZVQNwj8IjkHpow9dHZWlJUGy5YY97x3iLkp6uUYv
 TLvCImM1lGgYSHnLtHnsEzjqlC8f9PsxF69nw/y3WLzQVDIo/eWWE40/vtznk1E0I3nE
 3HkV3jwXGA2UPC6L+JOeRciNQ0LMHMP0s4P/6+fHyqhBPkTTd5LgN5gme2/lkIJaX2W0
 /WEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUDEqf+aghWrFX+UgxNlMNxOsoyQjMH8FfMvCRQqNPl0GOvTMPeEbHDI2hlEIymLZ8OZhtRC6Qftwz@nongnu.org
X-Gm-Message-State: AOJu0Yx9agf0lMzWU/xgpiTxIPn7TQlQa72xJwv4UizUXFiT9qrGq9YL
 LErYSFu3PzDqIuEv/LduGFcH8KIOehTyZR5M1B6hauMburSbqMoCy4zis86NgK9T0yeHkmBXTGU
 SF7/h5tlOofqpGCRhTHgynfg8T3pzR/PvoUSDiT0U/0H4YbD+QWVK
X-Gm-Gg: ASbGncuvRXrxYmLqJlBKOR4VkzoYoYqv4mx9jOZXa7CZg+KLHKkVJTyVex/s55NlCS7
 rI8tEoKqyu6RF+RBd3mrZW2yA3dQmn2KLtxz3SuZ/4qEto1WoFlBR3JHQrzadEF7Be5lqllugaZ
 tPlhoTQlH8nSJ699LvGic94GPs47o5EMX43WNqeT5+V/62IwLF2gTYBScLpXXNrA0NhW0l+5jA7
 3wHAwJByhtZz6KDfv8y0UTBee/J233eUYNatgkTxkn3T7M6/yRgSJfGM1/hcjA7kmozGWLmNw4H
 DphWibDVAmH9jxEZrH1poDpN1EXsITa4G6n066zir3JZOSsoHbPgNwI2VJcrhgc=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id
 5b1f17b1804b1-439b2b06189mr206468035e9.14.1740580637311; 
 Wed, 26 Feb 2025 06:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSCA3XFIVyQZsw18frYh1t81BW8lTaHenavCbqgsRrhYxpuoQ/ptQly88DpV9iZZ1qQr4+YQ==
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id
 5b1f17b1804b1-439b2b06189mr206467585e9.14.1740580636855; 
 Wed, 26 Feb 2025 06:37:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5711fcsm24896715e9.28.2025.02.26.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:37:16 -0800 (PST)
Date: Wed, 26 Feb 2025 15:37:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
In-Reply-To: <9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 15:35:10 +0100
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
> ---
>  hw/acpi/ghes.c           | 46 ++++++++++++++++++++++++----------------
>  hw/arm/virt-acpi-build.c | 15 ++++++++++---
>  include/hw/acpi/ghes.h   | 14 ++++++++++--
>  3 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b709c177cdea..e49a03fdb94e 100644
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
> @@ -357,11 +361,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> -
> -    ags->present = true;
> +    if (!ags->use_hest_addr) {
> +        /* Create a read-write fw_cfg file for Address */
> +        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    }
>  }
>  
>  static void get_hw_error_offsets(uint64_t ghes_addr,
> @@ -411,8 +415,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      ags = &acpi_ged_state->ghes_state;
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
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
> @@ -494,5 +501,8 @@ bool acpi_ghes_present(void)
>          return false;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    return ags->present;
> +    if (!ags->hw_error_le)
> +        return false;
> +
> +    return true;
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e17861..8ab8d11b6536 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGedState *acpi_ged_state;
> +        AcpiGhesState *ags;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                            ^^^ will explode if object_resolve_path_type() returns NULL
> +                                                       NULL));

it's also expensive load-wise.
You have access to vms with ged pointer here, use that
(search for 'acpi_ged_state = ACPI_GED' example)

                            

> +        if (acpi_ged_state) {

                hence, this check is not really needed,
                we have to have GED at this point or abort

                earlier code that instantiates GED should take care of
                cleanly exiting if it failed to create GED so we would never get
                to missing GED here


> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +                            tables->linker, vms->oem_id, vms->oem_table_id);
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 39619a2457cb..a3d62b96584f 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -64,12 +64,22 @@ enum {
>      ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
> +/*
> + * AcpiGhesState stores an offset that will be used to fill HEST entries.
> + *
> + * When use_hest_addr is false, the stored offset is placed at hw_error_le,
> + * meaning an offset from the etc/hardware_errors firmware address. This
> + * is the default on QEMU 9.x.
> + *
> + * An offset value equal to zero means that GHES is not present.
> + */
>  typedef struct AcpiGhesState {
>      uint64_t hw_error_le;
> -    bool present; /* True if GHES is present at all on this board */
> +    bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,


