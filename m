Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C5C36018
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWry-0004WM-IV; Tue, 17 Sep 2024 07:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWrw-0004Ub-4b
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWru-0003yz-1L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726574380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0PJ7PkwEzbZGxWHx3WAu3PZd7aveOxf5Ybsvqj+2Y8=;
 b=aTrK+auwiQ5+R7CCX0JHufuPas63sn3+e4S24a1rSrAfrraR47qTPFWIdDEfQ8ZIGQd/yo
 sIG96C11BTTfWzXmLJMyePZGUT4pesigOGoSVV9qpijp/cwgHqxwOu7cBxhBsDI7cQ9bB8
 KMD0YorRCFCL1ZdCzcAz2u3oZea3F+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-gulUxPLYM7uLbWf7DI8Eww-1; Tue, 17 Sep 2024 07:59:38 -0400
X-MC-Unique: gulUxPLYM7uLbWf7DI8Eww-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374bacd5cccso3283572f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574377; x=1727179177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0PJ7PkwEzbZGxWHx3WAu3PZd7aveOxf5Ybsvqj+2Y8=;
 b=lQ37soXSvo3m6FWK5F+upLUbL9WIqZlo1DN0jeg7kjvyCbzHMOuItBMhDyRNbq17Ow
 S6iBkDPh1v8/2/6XI1vqtGRhvZ8R3Qajhz5SfSJDeNNwxQ8sBD2bxy2R696RVhV9SpWz
 So8DCPPD+fgs/qAwLui71NO6XGEFRS5g2FkHiHFcJWR7ICusHKr4Iu3z7YYKyNFr4Y8T
 YJawZSQogck3qDg7myIbePFMk4YN5UuWOrNJ+uPdiE4Rb8dGcm0PWXft91vn8CNeaxBm
 ZIh4iy5JfPbMkUR99xljWDXujJ9EPS7nCTC0sxMfOhI2Lp8xUUBhcAlq+rtBav5HSwWN
 wTVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7WDAqBluhNVtq2adoRLmzmZ5XG4Fc/jwvz3DguKi2P4IXWWf4D5q9bwvrN+cdNmOPE9YktR6KM65@nongnu.org
X-Gm-Message-State: AOJu0Yy2VHcxLdC1+Al8zaVizwFN3Vd4AOK4fI9FKHJ+0S7eiaqsyBim
 fpNDxthn2HV+umrxBV4/YIbfhMxjZ+vfoj1kwWVFgU0t0ComJF2SEPP7bqGfejwomraXMpYtSWW
 FQuaZAhWKPMOpFHsoCmPMwevPtCcftdlVeKKmXOdNQY5ycu5J1S9a
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id
 ffacd0b85a97d-378c2d065c0mr9143151f8f.20.1726574377527; 
 Tue, 17 Sep 2024 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjC41MYJffw19rKEKQL46pxo/mJddKgbcEKKYmVKZJhDrHTTgKw4LwBKde+I7JXBcisF/wAw==
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id
 ffacd0b85a97d-378c2d065c0mr9143133f8f.20.1726574376947; 
 Tue, 17 Sep 2024 04:59:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780015dsm9361963f8f.69.2024.09.17.04.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 04:59:36 -0700 (PDT)
Date: Tue, 17 Sep 2024 13:59:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 07/21] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240917135934.38579213@imammedo.users.ipa.redhat.com>
In-Reply-To: <0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 08:13:28 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current logic is based on a lot of duct tape, with
> offsets calculated based on one define with the number of
> source IDs and an enum.
> 
> Rewrite the logic in a way that it would be more resilient
> of code changes, by moving the source ID count to an enum
> and make the offset calculus more explicit.
> 
> Such change was inspired on a patch from Jonathan Cameron
> splitting the logic to get the CPER address on a separate
> function, as this will be needed to support generic error
> injection.

so this patch switches to using HEST to lookup error status block
by source id, though nothing in commit message mentions that.
Perhaps it's time to rewrite commit message to be more
specific/clear on what it's doing.  

now, I'd split this on several patches that should also take care of
wiring needed to preserve old lookup to keep migration with 9.1 machines
working:

 1. extract error status block read_ack addresses calculation/lookup
    into a separate function (just current code, without HEST lookup).
 2. since old lookup code handles only 1 source and won't ever see multiple
    error sources, simplify that as much as possible to keep old way simple
    (and mention that in commit message).
    it basically should take 1st error status block/read ack addresses from
    hardware_errors

 3. add to AcpiGedState a callback to with signature of #1 lookup func.
    (which will be used to switch between old/new code), by default set to
    old lookup func

 4. add to GED a bool property x-has-hardware_errors_addr = 1
    and use it in acpi_ged_realize() to set callback

          if x-has-hardware_errors_addr == 1
               callback = old_lookup

 5. add new HEST lookup func (not used yet with mentioning that follow up patch
    will use it)

 6. cleanup fwcfg based on x-has-hardware_errors_addr,
       i.e. for 'true':
          ask for write pointer to hardware_errors like it's done in current code
          and don't register hest_addr write pointer
       while for 'false'
          do opposite of above.


 7. flip x-has-hardware_errors_addr default to 0 and add to hw/core/machine.c
      hw_compat_9_1[] = {
          {ged type,  'x-has-hardware_errors_addr', 'true'},
      }
    this will make 9.1 and older machine types to use old lookup callback
    while newer machines will use default new lookup

that should take care of switching between new and old ABI,
i.e. which code qemu and guest will use/see.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Changes from v9:
> - patch split on multiple patches to avoid multiple changes
>   at the same patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 95 ++++++++++++++++++++++++++++++------------
>  include/hw/acpi/ghes.h |  6 ++-
>  2 files changed, 73 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 36fe5f68782f..6e5f0e8cf0c9 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,23 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> +
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -401,11 +418,13 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>  
>  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> -    bool ret = -1;
> +    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
> +    uint64_t hest_addr, cper_addr, err_source_struct;
> +    uint64_t hest_err_block_addr, error_block_addr;
> +    uint32_t i, ret;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> +    uint64_t read_ack;
>  
>      assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
>  
> @@ -414,44 +433,66 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      g_assert(acpi_ged_state);
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    hest_addr = le64_to_cpu(ags->hest_addr_le);
>  
>      if (!physical_address) {
>          return -1;
>      }
>  
> -    start_addr += source_id * sizeof(uint64_t);
> +    err_source_struct = hest_addr + ACPI_GHES_ERROR_SOURCE_COUNT;
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                sizeof(error_block_addr));
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +        uint64_t addr = err_source_struct;
> +        uint16_t type, src_id;
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
>  
> -    read_ack_register_addr = start_addr +
> -        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +        /* For now, we only know the size of GHESv2 table */
> +        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);
>  
> -    cpu_physical_memory_read(read_ack_register_addr,
> -                                &read_ack_register, sizeof(read_ack_register));
> +        /* It is GHES. Compare CPER source address */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
>  
> -    /* zero means OSPM does not acknowledge the error */
> -    if (!read_ack_register) {
> -        error_report("OSPM does not acknowledge previous error,"
> -            " so can not record CPER for current error anymore");
> -    } else if (error_block_addr) {
> -        read_ack_register = cpu_to_le64(0);
> -        /*
> -         * Clear the Read Ack Register, OSPM will write it to 1 when
> -         * it acknowledges this error.
> -         */
> -        cpu_physical_memory_write(read_ack_register_addr,
> -            &read_ack_register, sizeof(uint64_t));
> +        if (src_id == source_id) {
> +            break;
> +        }
>  
> -        ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                            physical_address);
> -    } else {
> +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == ACPI_GHES_ERROR_SOURCE_COUNT) {
>          error_report("can not find Generic Error Status Block");
> +
> +        return -1;
>      }
>  
> +    /* Navigate though table address pointers */
> +
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, &cper_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr,
> +                             sizeof(read_ack_start_addr));
> +
> +    /* Update ACK offset to notify about a new error */
> +
> +    cpu_physical_memory_read(read_ack_start_addr,
> +                             &read_ack, sizeof(read_ack));
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_start_addr,
> +                              &read_ack, sizeof(read_ack));
> +
> +    ret = acpi_ghes_record_mem_error(error_block_addr, physical_address);
>      return ret;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index c9bbda4740e2..7485f54c28f2 100644
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
> @@ -74,7 +75,10 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint8_t source_id,
> +                            uint64_t error_physical_addr);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


