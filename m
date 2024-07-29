Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E85AC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 11:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOkO-0001Cv-Lr; Mon, 29 Jul 2024 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYOkE-000184-SF; Mon, 29 Jul 2024 07:40:52 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYOk9-0008Me-2X; Mon, 29 Jul 2024 07:40:47 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2643DCE0AED;
 Mon, 29 Jul 2024 11:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C3CC32786;
 Mon, 29 Jul 2024 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722253240;
 bh=7vuEUPWCtOsmYrp6otur2CNDMnhPRPOkRmNYGEq5/1k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JZyJXEB8dXfNibr8dHNhC0qnTDUMk6wjafjeiottKjoUbJS+C34SdpwgIAdppg7/9
 qjgtSoQHkNnVMpLazj3k4xerKiTGaatlR+2B28vMC4Yws0RmSkJ+fcX0h+LaN/KZL3
 fbOU2Q2eeR3YVXSYpGIXkfIER/Tg5cM+IyqOR0Ays7veey5GNyXF8y7LiYnAlPTpsq
 NTmQINaFDplhZPaVG3oDx4jOG58GpHY6pawfwUQ9gbA/nxJYaoeZ9kiM1FkHYE7SYw
 +5kZxM6T/4NV5RiXpQ0eGd1vvgj7WvAP3Vpy7ZcJZK06tvL3wU13yBRX+kfKxcZfx/
 glv8ZfMyAfdPg==
Date: Mon, 29 Jul 2024 13:40:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240729134034.1754bf14@foz.lan>
In-Reply-To: <20240726134412.000038c1@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <20240726134412.000038c1@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Fri, 26 Jul 2024 13:44:12 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Mon, 22 Jul 2024 08:45:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > 1. Some GHES functions require handling addresses. Add a helper function
> >    to support it.
> > 
> > 2. Add support for ACPI CPER (firmware-first) ARM processor error injection.
> > 
> > Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
> > upper specs, using error type bit encoding as detailed at UEFI 2.9A
> > errata.
> > 
> > Error injection examples:
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error']
> >       }
> > }
> > 
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['tlb-error']
> >       }
> > }
> > 
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['bus-error']
> >       }
> > }
> > 
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error', 'tlb-error']
> >       }
> > }
> > 
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
> >       }
> > }
> > ...
> > 
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > For Add a logic to handle block addresses,  
> # before comments I think?
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > For FW first ARM processor error injection,
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> I can't remember what I wrote in here so may well be commenting on
> my past self ;)
> 
> > ---
> >  configs/targets/aarch64-softmmu.mak |   1 +
> >  hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
> >  hw/arm/Kconfig                      |   4 +
> >  hw/arm/arm_error_inject.c           |  35 ++++
> >  hw/arm/arm_error_inject_stubs.c     |  18 ++
> >  hw/arm/meson.build                  |   3 +
> >  include/hw/acpi/ghes.h              |   2 +
> >  qapi/arm-error-inject.json          |  49 ++++++
> >  qapi/meson.build                    |   1 +
> >  qapi/qapi-schema.json               |   1 +
> >  10 files changed, 361 insertions(+), 11 deletions(-)
> >  create mode 100644 hw/arm/arm_error_inject.c
> >  create mode 100644 hw/arm/arm_error_inject_stubs.c
> >  create mode 100644 qapi/arm-error-inject.json
> > 
> > diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
> > index 84cb32dc2f4f..b4b3cd97934a 100644
> > --- a/configs/targets/aarch64-softmmu.mak
> > +++ b/configs/targets/aarch64-softmmu.mak
> > @@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
> >  TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
> >  # needed by boot.c
> >  TARGET_NEED_FDT=y
> > +CONFIG_ARM_EINJ=y
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 5b8bc6eeb437..6075ef5893ce 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "qemu/uuid.h"
> > +#include "qapi/qapi-types-arm-error-inject.h"
> >  
> >  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> >  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> > @@ -53,6 +54,12 @@
> >  /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
> >  #define ACPI_GHES_MEM_CPER_LENGTH           80
> >  
> > +/*
> > + * ARM Processor section CPER size, UEFI 2.10: N.2.4.4
> > + * ARM Processor Error Section
> > + */
> > +#define ACPI_GHES_ARM_CPER_LENGTH (72 + 600)
> > +
> >  /* Masks for block_status flags */
> >  #define ACPI_GEBS_UNCORRECTABLE         1
> >  
> > @@ -231,6 +238,142 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> >      return 0;
> >  }
> >  
> > +/* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
> > +static void acpi_ghes_build_append_arm_cper(uint8_t error_types, GArray *table)
> > +{
> > +    /*
> > +     * ARM Processor Error Record
> > +     */
> > +
> > +    /* Validation Bits */
> > +    build_append_int_noprefix(table,
> > +                              (1ULL << 3) | /* Vendor specific info Valid */
> > +                              (1ULL << 2) | /* Running status Valid */
> > +                              (1ULL << 1) | /* Error affinity level Valid */
> > +                              (1ULL << 0), /* MPIDR Valid */
> > +                              4);
> > +    /* Error Info Num */
> > +    build_append_int_noprefix(table, 1, 2);
> > +    /* Context Info Num */
> > +    build_append_int_noprefix(table, 1, 2);
> > +    /* Section length */
> > +    build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_LENGTH, 4);
> > +    /* Error affinity level */
> > +    build_append_int_noprefix(table, 2, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table, 0, 3);
> > +    /* MPIDR_EL1 */
> > +    build_append_int_noprefix(table, 0xAB12, 8);  
> 
> These need to be real - I see you fix that in later
> patches, but I'd be tempted to pull it back here.  Or maybe just
> add a comment to say you will rewrite this later.
> 
> I know you aren't keen to smash patches with different authorship
> together, but here I think you should just have this
> correct from the start (so combine this and 5-7)
> perhaps with some links back to the version where they are split?

I folded this with patch 7. I kept patch 5 as a separate one,
as it is a different logical change.

After folding, this field is filled from the emulation value for
it (by default, as it can be overridden via QMP).

> > +    /* MIDR_EL1 */
> > +    build_append_int_noprefix(table, 0xCD24, 8);
> > +    /* Running state */
> > +    build_append_int_noprefix(table, 0x1, 4);
> > +    /* PSCI state */
> > +    build_append_int_noprefix(table, 0x1234, 4);
> > +
> > +    /* ARM Propcessor error information */
> > +    /* Version */
> > +    build_append_int_noprefix(table, 0, 1);
> > +    /*  Length */
> > +    build_append_int_noprefix(table, 32, 1);
> > +    /* Validation Bits */
> > +    build_append_int_noprefix(table,
> > +                              (1ULL << 4) | /* Physical fault address Valid */  
> 
> Some tabs hiding in here that need to be spaces.

Solved when folding with patch 7.

> > +                             (1ULL << 3) | /* Virtual fault address Valid */
> > +                             (1ULL << 2) | /* Error information Valid */
> > +                              (1ULL << 1) | /* Flags Valid */
> > +                              (1ULL << 0), /* Multiple error count Valid */
> > +                              2);
> > +    /* Type */
> > +    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR) ||
> > +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR) ||
> > +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR) ||
> > +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
> > +        build_append_int_noprefix(table, error_types, 1);
> > +    } else {
> > +        return;
> > +    }
> > +    /* Multiple error count */
> > +    build_append_int_noprefix(table, 2, 2);
> > +    /* Flags  */
> > +    build_append_int_noprefix(table, 0xD, 1);
> > +    /* Error information  */
> > +    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR)) {
> > +        build_append_int_noprefix(table, 0x0091000F, 8);
> > +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR)) {
> > +        build_append_int_noprefix(table, 0x0054007F, 8);
> > +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR)) {
> > +        build_append_int_noprefix(table, 0x80D6460FFF, 8);
> > +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
> > +        build_append_int_noprefix(table, 0x78DA03FF, 8);
> > +    } else {
> > +        return;
> > +    }
> > +    /* Virtual fault address  */
> > +    build_append_int_noprefix(table, 0x67320230, 8);
> > +    /* Physical fault address  */
> > +    build_append_int_noprefix(table, 0x5CDFD492, 8);
> > +
> > +    /* ARM Propcessor error context information */
> > +    /* Version */
> > +    build_append_int_noprefix(table, 0, 2);
> > +    /* Validation Bits */
> > +    /* AArch64 EL1 context registers Valid */
> > +    build_append_int_noprefix(table, 5, 2);
> > +    /* Register array size */
> > +    build_append_int_noprefix(table, 592, 4);
> > +    /* Register array */
> > +    build_append_int_noprefix(table, 0x12ABDE67, 8);
> > +}
> > +
> > +static int acpi_ghes_record_arm_error(uint8_t error_types,
> > +                                      uint64_t error_block_address)
> > +{
> > +    GArray *block;
> > +
> > +    /* ARM processor Error Section Type */
> > +    const uint8_t uefi_cper_arm_sec[] =
> > +          UUID_LE(0xE19E3D16, 0xBC11, 0x11E4, 0x9C, 0xAA, 0xC2, 0x05, \
> > +                  0x1D, 0x5D, 0x46, 0xB0);
> > +
> > +    /*
> > +     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> > +     * Table 17-13 Generic Error Data Entry
> > +     */
> > +    QemuUUID fru_id = {};
> > +    uint32_t data_length;
> > +
> > +    block = g_array_new(false, true /* clear */, 1);
> > +
> > +    /* This is the length if adding a new generic error data entry*/  
> 
> space before *

Fixed.

> 
> > +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_ARM_CPER_LENGTH;
> > +    /*
> > +     * It should not run out of the preallocated memory if adding a new generic
> > +     * error data entry
> > +     */
> > +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> > +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> > +
> > +    /* Build the new generic error status block header */
> > +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> > +        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> > +
> > +    /* Build this new generic error data entry header */
> > +    acpi_ghes_generic_error_data(block, uefi_cper_arm_sec,
> > +        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> > +        ACPI_GHES_ARM_CPER_LENGTH, fru_id, 0);
> > +
> > +    /* Build the ARM processor error section CPER */
> > +    acpi_ghes_build_append_arm_cper(error_types, block);
> > +
> > +    /* Write the generic error data entry into guest memory */
> > +    cpu_physical_memory_write(error_block_address, block->data, block->len);
> > +
> > +    g_array_free(block, true);
> > +
> > +    return 0;
> > +}  
> 
> 
> > +bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify)
> > +{
> > +    int read_ack_register = 0;
> > +    uint64_t read_ack_register_addr = 0;
> > +    uint64_t error_block_addr = 0;
> > +
> > +    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
> > +        return false;
> > +    }
> > +
> > +    cpu_physical_memory_read(read_ack_register_addr,
> > +                             &read_ack_register, sizeof(uint64_t));  
> 
> longer but I'd prefer sizeof(read_ack_register)
> Maybe we can shorten to read_ack and read_ack_addr?
> 
> > +    /* zero means OSPM does not acknowledge the error */
> > +    if (!read_ack_register) {
> > +        error_report("Last time OSPM does not acknowledge the error,"
> > +                     " record CPER failed this time, set the ack value to"
> > +                     " avoid blocking next time CPER record! exit");
> > +        read_ack_register = 1;
> > +        cpu_physical_memory_write(read_ack_register_addr,
> > +                                  &read_ack_register, sizeof(uint64_t));  
> sizeof(read_ack_register)
> 
> > +        return false;
> > +    }
> > +
> > +    read_ack_register = cpu_to_le64(0);
> > +    cpu_physical_memory_write(read_ack_register_addr,
> > +                              &read_ack_register, sizeof(uint64_t));  
> 
> sizeof(read_ack_register)
> 
> > +    return acpi_ghes_record_arm_error(error_types, error_block_addr);
> > +}
> > +  

Changed as suggested.

> 
> > diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> > new file mode 100644
> > index 000000000000..430e6cea6b60
> > --- /dev/null
> > +++ b/qapi/arm-error-inject.json  
> 
> > +##
> > +# @arm-inject-error:
> > +#
> > +# Inject ARM Processor error.
> > +#
> > +# @errortypes: ARM processor error types to inject
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is experimental.
> > +#
> > +# Since: 9.1  
> Update to 9.2 on next version.

Ok.

Thanks,
Mauro

