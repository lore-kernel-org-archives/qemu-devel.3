Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BECE77173
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIsOp-0002Gu-EV; Wed, 04 Dec 2024 11:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsOo-0002Gh-GE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:38:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsOm-00021C-Mb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733330327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7FHAZNgtIO2mya219lJtrQUxVa6TSIG1yUsoSpK1nk=;
 b=ah4caY1Se57koN38AVZIuIuzOq7li5watAGQbaKylvFYQlUHVTYjhxwFdYV6Ix18ZxVJss
 +D1rBjkeGKUjS8A8VVw1/rjYZ9OR4ASan72a/uTflcCj8AoW4ijWzD9p2mHEE1BJC97vTD
 C2EP1FEv9QmuUaPkvXCDVynnHLlQoaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-DI8umWkxP1SQ-3RV5Gz1YQ-1; Wed, 04 Dec 2024 11:38:46 -0500
X-MC-Unique: DI8umWkxP1SQ-3RV5Gz1YQ-1
X-Mimecast-MFC-AGG-ID: DI8umWkxP1SQ-3RV5Gz1YQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43498af7937so57204395e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 08:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733330325; x=1733935125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7FHAZNgtIO2mya219lJtrQUxVa6TSIG1yUsoSpK1nk=;
 b=vo4vHN5VMtw2o8V8DtnjLkunFVdYaVvkgFsHoWU7HV4+IplGiW89/xm51KvFOw8k9i
 Ku0CT9wpAwBrUm85uBbl99u0kD5HOxbNR7V169/WmTbN5gUwQyn3iSKFwUrkrpWxfEEo
 tABetnCsahgxBuXzPpF775aJ1nYiwE7b0ZIigcU5o4F7VNpSN4AOX9nRI3qpiycgy2Tn
 I8OzIg3yBrKXxGvDyZBdJvPTCbtU2NrvKWJ3gjdD88do8qChKmJBdx8SmrYUg95TQWfX
 cmMfucdtjtoTTrsufkGh6DHA7MNrslpqDIRM8zERqEZch75gd4rQfemmO8AD4/MrT3xc
 5/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTGcLjG6prA0uHjcSQZxrCl6/FG6LUEJS9MR17Ra1ABwLlCTb36wIlmo2tln3vnkugj80WgeOZV+dg@nongnu.org
X-Gm-Message-State: AOJu0Yx2x4GxQZjfOPB302ZI+0xujdAnTsM42Q1IU4uE9RUMwVQQqCMq
 KRg7j7Encj/34lfvHlMCo6F6JS6yo/U4FMx9FTWe7Lkn4aUR8tbcZziwaPYZHuO+q7riULtJMEO
 M0Xfu0gNI59SlYRJEcfW71secpWLaqpyv2WI6TmhiTpUOjYTev49W
X-Gm-Gg: ASbGnctKZveQxhr1X11zzwGPAZxTySV4zlRZLIRcrKQBFAJlradkcGEZTIepcVzTP+j
 61bKMEUBK5XK9KQWaLKq73Eo7kOzrO0oDPpn0s67sn2Mqq+mzigTuN46HVdVvhojNV4P8iYTDEW
 mMBWASlWaQPsY2llY0WwY/3X3+uXdJoVB8mMc1GI2Wz2LUVJBQ/Te4l8HBda3uTPgmnZuKHME0/
 LZolPNJ5jZt7tGKAsMe70zEf8rTMfUqYxC2gufJ5RJOAr9LCx7rPQ2WohBofOGmOnDc4fDTyRo0
 30gzkI8jJTzVPObKC8wJ2Q==
X-Received: by 2002:a05:600c:19cc:b0:434:9f0d:3823 with SMTP id
 5b1f17b1804b1-434d09b65cdmr65110345e9.9.1733330325122; 
 Wed, 04 Dec 2024 08:38:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgS/tXRLkVvWJzJRPdSMcfQnoJ+MJatvpJpBw2izGhf6xSOfLRGEB75XhYrYjcuaJia8KK1w==
X-Received: by 2002:a05:600c:19cc:b0:434:9f0d:3823 with SMTP id
 5b1f17b1804b1-434d09b65cdmr65109995e9.9.1733330324699; 
 Wed, 04 Dec 2024 08:38:44 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm29851305e9.17.2024.12.04.08.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:38:44 -0800 (PST)
Date: Wed, 4 Dec 2024 17:38:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 09/16] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241204173843.7ddd2c0a@imammedo.users.ipa.redhat.com>
In-Reply-To: <a35a02028136f9d5445b41760c892de302801500.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <a35a02028136f9d5445b41760c892de302801500.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed,  4 Dec 2024 08:41:17 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill the Generic Error Data part of the record,
> as described at:
> 
> 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> # Conflicts:
> #	roms/edk2
> ---
>  hw/acpi/ghes.c         | 121 ++++++++++++++++++++++++-----------------
>  include/hw/acpi/ghes.h |   3 +
>  2 files changed, 73 insertions(+), 51 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a3dffd78b012..4b5332f8c667 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -181,51 +181,24 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
>      build_append_int_noprefix(table, 0, 7);
>  }
>  
> -static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> -                                      uint64_t error_physical_addr)
> +static void
> +ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> +                                            const uint8_t *section_type,
> +                                            int data_length)
>  {
> -    GArray *block;
> -
> -    /* Memory Error Section Type */
> -    const uint8_t uefi_cper_mem_sec[] =
> -          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> -                  0xED, 0x7C, 0x83, 0xB1);
> -
>      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>       * Table 17-13 Generic Error Data Entry
>       */
>      QemuUUID fru_id = {};
> -    uint32_t data_length;
> -
> -    block = g_array_new(false, true /* clear */, 1);
> -
> -    /* This is the length if adding a new generic error data entry*/
> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> -    /*
> -     * It should not run out of the preallocated memory if adding a new generic
> -     * error data entry
> -     */
> -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
>  
>      /* Build the new generic error status block header */
>      acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
>          0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
>  
>      /* Build this new generic error data entry header */
> -    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> +    acpi_ghes_generic_error_data(block, section_type,
>          ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>          ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> -
> -    /* Build the memory section CPER for above new generic error data entry */
> -    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> -
> -    /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_address, block->data, block->len);
> -
> -    g_array_free(block, true);
> -
> -    return 0;
>  }
>  
>  /*
> @@ -383,15 +356,18 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
>      uint64_t start_addr;
> -    bool ret = -1;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> -    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +        return;
> +    }
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> @@ -406,6 +382,10 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>                               sizeof(error_block_addr));
>  
>      error_block_addr = le64_to_cpu(error_block_addr);
> +    if (!error_block_addr) {
> +        error_setg(errp, "can not find Generic Error Status Block");
> +        return;
> +    }
>  
>      read_ack_register_addr = start_addr +
>                               ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> @@ -415,24 +395,63 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      /* zero means OSPM does not acknowledge the error */
>      if (!read_ack_register) {
> -        error_report("OSPM does not acknowledge previous error,"
> -                     " so can not record CPER for current error anymore");
> -    } else if (error_block_addr) {
> -        read_ack_register = cpu_to_le64(0);
> -        /*
> -         * Clear the Read Ack Register, OSPM will write it to 1 when
> -         * it acknowledges this error.
> -         */
> -        cpu_physical_memory_write(read_ack_register_addr,
> -                                  &read_ack_register, sizeof(uint64_t));
> -
> -        ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                         physical_address);
> -    } else {
> -        error_report("can not find Generic Error Status Block");
> +        error_setg(errp,
> +                   "OSPM does not acknowledge previous error,"
> +                   " so can not record CPER for current error anymore");
> +        return;
>      }
>  
> -    return ret;
> +    read_ack_register = cpu_to_le64(0);
> +    /*
> +     * Clear the Read Ack Register, OSPM will write 1 to this register when
> +     * it acknowledges the error.
> +     */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}
> +
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +{
> +    /* Memory Error Section Type */
> +    const uint8_t guid[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +    Error *errp = NULL;
> +    int data_length;
> +    GArray *block;
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> +    /*
> +     * It should not run out of the preallocated memory if adding a new generic
> +     * error data entry
> +     */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +
> +    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
> +                                                data_length);
> +
> +    /* Build the memory section CPER for above new generic error data entry */
> +    acpi_ghes_build_append_mem_cper(block, physical_address);
> +
> +    /* Report the error */
> +    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> +
> +    g_array_free(block, true);
> +
> +    if (errp) {
> +        error_report_err(errp);
> +        return -1;
> +    }
> +
> +    return 0;
>  }
>  
>  bool acpi_ghes_present(void)
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 9295e46be25e..8859346af51a 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  
>  /*
>   * Values for Hardware Error Notification Type field
> @@ -73,6 +74,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**


