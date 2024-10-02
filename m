Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9250CF6D21
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzC8-0007Wd-4P; Wed, 02 Oct 2024 09:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzC6-0007Vn-EP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzC4-0006WY-Hw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727874902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvjBB4Z24fOzaO8VMYHdIrBr4Huj0MDAFDPneoWKBqY=;
 b=QRxMkPXelvxCa+hhgG2y6d1ggNKBwjUovskaNbFWYPErAlBrirVo5YcBxtpJmdss7TwDe1
 lMu5XYkt/j1+sfWQDxdcu/69zQDxT18Xp+YA/7TlPYfrVsmzpxQvIs0aERq5llLNKXB/DO
 isRS2ugDLEM2Un2rVhINWXqKVI+JcSc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623--cyHq2IUP0ekhe7lqMQAWA-1; Wed, 02 Oct 2024 09:15:01 -0400
X-MC-Unique: -cyHq2IUP0ekhe7lqMQAWA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd2044558so3049552f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727874900; x=1728479700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvjBB4Z24fOzaO8VMYHdIrBr4Huj0MDAFDPneoWKBqY=;
 b=Ur2XD/6BZ3K97CFWlhKGywRmEaes+0S99015hQ5ZeoFpEXBOuIHHGcCmk1kcp6o8yc
 iUxDohsuhgMTjkrKZ7ptV3HhnVr3/c8IctfiekjTIO82Kpc1u2cZnBnBTfFgYK1EFmuc
 tcO5bzmauM1hVbG01SE9ZyehvtVu6R6nzTckOjuQ91wgiqis4hQJRdY7O8N16ZtYoN6v
 vyYAhxlOyt7A+J8YSBxKgriKcK+43Tdq+tHPTTBXOVaViGlkr3JXuODMSkFUtAXRooJQ
 EOLsVLsB5kDfz0eS1TYXxBLVKMx2xox1ROPLUtGeON5DQrad6LeNtofMHUXCjv41a9S0
 4oww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4wtgf23fiNfTIsvK1PIFn8ld/J6oy4qrpnu4cg/esyso+ZSzB4jPPSkgh2gh2Y1dJLsrIF7TQD8H/@nongnu.org
X-Gm-Message-State: AOJu0YxlsAkPa2zGbQDi8UMlbgfIpcQ5dS4SySII362DnzEEQiRdStKZ
 qQvTNE/hKweoqKOWTnpiPCWBkW/cauQaIRnwa878qGXh51K90gjAGl4Q9r2mjwSup9VroYLQIJb
 XcRm4Yn1YPnfi468/qKnctkkthQUDS4jOrBF+Wffm6nn9S2RjJDK1
X-Received: by 2002:adf:a1c2:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-37cfb8b5378mr2031300f8f.4.1727874899716; 
 Wed, 02 Oct 2024 06:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkMHxCYjUvECqHmJ9+LIr7wZGQNEWn+AD2XDU2j1KDH6HKGZYaiarIjgfsYO9+B30oElXsAQ==
X-Received: by 2002:adf:a1c2:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-37cfb8b5378mr2031285f8f.4.1727874899275; 
 Wed, 02 Oct 2024 06:14:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57450c7sm13828486f8f.101.2024.10.02.06.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:14:57 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:14:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241002151456.1135d663@imammedo.users.ipa.redhat.com>
In-Reply-To: <e3e5f093e97508a1e668f90203d6ef0c496d0dc1.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <e3e5f093e97508a1e668f90203d6ef0c496d0dc1.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue,  1 Oct 2024 09:03:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill GEGB part of the record.
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.

checkpatch is not happy with you.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 118 +++++++++++++++++++++++++----------------
>  include/hw/acpi/ghes.h |   3 ++
>  2 files changed, 74 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f3d0283beb3b..628fa9b22f4b 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -181,51 +181,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
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
>  
> -    block = g_array_new(false, true /* clear */, 1);
> -
> -    /* This is the length if adding a new generic error data entry*/
> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
>      /*
> -     * It should not run out of the preallocated memory if adding a new generic
> -     * error data entry
> +     * Calculate the size with this block. No need to check for
> +     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
>       */
> -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +    data_length += ACPI_GHES_GESB_SIZE;
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
> @@ -399,14 +378,19 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
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
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +        return;
> +    }
> +
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
>      g_assert(acpi_ged_state);
> @@ -422,6 +406,10 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>                               sizeof(error_block_addr));
>  
>      error_block_addr = le64_to_cpu(error_block_addr);
> +    if (!error_block_addr) {
> +        error_setg(errp, "can not find Generic Error Status Block");
> +        return;
> +    }
>  
>      /*
>       * As the current version supports only one source, the ack offset is


> @@ -434,24 +422,60 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
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
> +        * Clear the Read Ack Register, OSPM will write it to 1 when
> +        * it acknowledges this error.
> +        */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}

this hunk is 'reduce indent' mostly, so do that in separate patch 1st.


> +
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +{
> +    /* Memory Error Section Type */
> +    const uint8_t guid[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +    Error *errp = NULL;
> +    GArray *block;
> +
> +    if (!physical_address) {
> +        error_report("can not find Generic Error Status Block for source id %d",
> +                     source_id);
> +        return -1;
> +    }
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
> +                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
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
> index d6e2801d9cd9..1b988ac1e2f2 100644
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
> @@ -80,6 +81,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**


