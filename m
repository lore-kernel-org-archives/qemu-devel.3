Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16743C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTHd-0003kc-W1; Mon, 29 Jul 2024 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sYTHK-0003j6-J1; Mon, 29 Jul 2024 12:31:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sYTHG-0005Q4-Hj; Mon, 29 Jul 2024 12:31:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXkM05dSpz6K5nF;
 Tue, 30 Jul 2024 00:28:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 22A07140B38;
 Tue, 30 Jul 2024 00:31:11 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 17:31:10 +0100
Date: Mon, 29 Jul 2024 17:31:09 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 6/6] acpi/ghes: Add a logic to inject ARM processor CPER
Message-ID: <20240729173109.00006911@Huawei.com>
In-Reply-To: <7e0c1ae181e9792e876ec0e7d2a9e7f32d7b60ac.1722259246.git.mchehab+huawei@kernel.org>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <7e0c1ae181e9792e876ec0e7d2a9e7f32d7b60ac.1722259246.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Jul 2024 15:21:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Add an ACPI APEI GHES error injection logic for ARM
> processor CPER, allowing to set fields at from
> UEFI spec 2.10 tables N.16 and N.17 to any valid
> value.
> 
> As some GHES functions require handling addresses, add
> a helper function to support it.
> 
> Before starting erorr inject, the QAPI requires to negociate
> QMP with:
> 
> { "execute": "qmp_capabilities" }
> 
> Afterwards, errors can be injected with:
> 
> 	{ "execute": "arm-inject-error" }
> 
> The error injection events supports several optional arguments,
> having Processor Error Information (PEI) mapped into an array.
> 
> So, it is possible to inject multiple errors at the same CPER record,
> as defined at UEFI spec, with:
> 
> 	{ "execute": "arm-inject-error", "arguments": {
> 	   "error": [ {"type": [ "cache-error" ]},
> 		      {"type": [ "tlb-error" ]} ] } }
> 
> The above generates a single CPER record with two PEI info, one
> reporting a cache error, and the other one a TLB error, using
> default values for other fields.
> 
> As all fields from ARM Processor CPER are mapped, so, the error
> could contain physical/virtual addresses, register dumps,
> vendor-specific data, etc.
> 
> This patch is co-authored:
> - ghes logic to inject a simple ARM record by Shiju Jose;
> - generic logic to handle block addresses by Jonathan Cameron;
> - logic to allow changing all fields by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

A few minor comments inline.
This crossed (I think) with a reply from Markus though so there are
some other bits to address from that.

Jonathan

> diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
> index 84cb32dc2f4f..b4b3cd97934a 100644
> --- a/configs/targets/aarch64-softmmu.mak
> +++ b/configs/targets/aarch64-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
>  TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=y
> +CONFIG_ARM_EINJ=y
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 9346f45c59a5..e435c9aa0961 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -27,6 +27,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
> +#include "qapi/qapi-types-arm-error-inject.h"
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -53,6 +54,12 @@
>  /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>  #define ACPI_GHES_MEM_CPER_LENGTH           80
>  
> +/*
> + * ARM Processor error section CPER sizes - UEFI 2.10: N.2.4.4
> + */
> +#define ACPI_GHES_ARM_CPER_LENGTH           40
> +#define ACPI_GHES_ARM_CPER_PEI_LENGTH       32
> +
>  /* Masks for block_status flags */
>  #define ACPI_GEBS_UNCORRECTABLE         1
>  
> @@ -234,6 +241,152 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>      return 0;
>  }
>  
> +/* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
> +static void acpi_ghes_build_append_arm_cper(ArmError err, uint32_t cper_length,
> +                                            GArray *table)
> +{
> +    unsigned int i, j;
> +
> +    /*
> +     * ARM Processor Error Record
> +     */
> +
> +    /* Validation Bits */

Given nice naming, maybe drop the comments where the field
name makes it obvious?

> +    build_append_int_noprefix(table, err.validation, 4);
> +
> +    /* Error Info Num */
> +    build_append_int_noprefix(table, err.err_info_num, 2);
> +
> +    /* Context Info Num */
> +    build_append_int_noprefix(table, err.context_info_num, 2);
> +
> +    /* Section length */
> +    build_append_int_noprefix(table, cper_length, 4);
> +
> +    /* Error affinity level */
> +    build_append_int_noprefix(table, err.affinity_level, 1);
> +
> +    /* Reserved */
> +    build_append_int_noprefix(table, 0, 3);
> +
> +    /* MPIDR_EL1 */
> +    build_append_int_noprefix(table, err.mpidr_el1, 8);
> +
> +    /* MIDR_EL1 */
> +    build_append_int_noprefix(table, err.midr_el1, 8);
> +
> +    /* Running state */
> +    build_append_int_noprefix(table, err.running_state, 4);
> +
> +    /* PSCI state: only valid when running state is zero  */
> +    build_append_int_noprefix(table, err.psci_state, 4);
> +
> +    for (i = 0; i < err.err_info_num; i++) {
> +        /* ARM Propcessor error information */
> +        /* Version */
> +        build_append_int_noprefix(table, 0, 1);
> +
> +        /*  Length */
> +        build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1);
> +
> +        /* Validation Bits */
> +        build_append_int_noprefix(table, err.pei[i].validation, 2);
> +
> +        /* Type */
> +        build_append_int_noprefix(table, err.pei[i].type, 1);
> +
> +        /* Multiple error count */
> +        build_append_int_noprefix(table, err.pei[i].multiple_error, 2);
> +
> +        /* Flags  */
> +        build_append_int_noprefix(table, err.pei[i].flags, 1);
> +
> +        /* Error information  */
> +        build_append_int_noprefix(table, err.pei[i].error_info, 8);
> +
> +        /* Virtual fault address  */
> +        build_append_int_noprefix(table, err.pei[i].virt_addr, 8);
> +
> +        /* Physical fault address  */
> +        build_append_int_noprefix(table, err.pei[i].phy_addr, 8);
> +    }
> +
> +    for (i = 0; i < err.context_info_num; i++) {
> +        /* ARM Propcessor error context information */
> +        /* Version */
> +        build_append_int_noprefix(table, 0, 2);
> +
> +        /* Validation type */
> +        build_append_int_noprefix(table, err.context[i].type, 2);
> +
> +        /* Register array size */
> +        build_append_int_noprefix(table, err.context[i].size * 8, 4);
> +
> +        /* Register array (byte 8 of Context info) */
> +        for (j = 0; j < err.context[i].size; j++) {
> +            build_append_int_noprefix(table, err.context[i].array[j], 8);
> +        }
> +    }
> +
> +    for (i = 0; i < err.vendor_num; i++) {
> +        build_append_int_noprefix(table, err.vendor[i], 1);
> +    }
> +}


...

> diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> new file mode 100644
> index 000000000000..5ebbdf2b2adc
> --- /dev/null
> +++ b/hw/arm/arm_error_inject.c
> @@ -0,0 +1,420 @@
> +/*
> + * ARM Processor error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/acpi/ghes.h"
> +#include "cpu.h"
> +
> +#define ACPI_GHES_ARM_CPER_CTX_DEFAULT_NREGS 74
> +
> +/* Handle ARM Processor Error Information (PEI) */
> +static const ArmProcessorErrorInformationList *default_pei = { 0 };
> +
> +static ArmPEI *qmp_arm_pei(uint16_t *err_info_num,
> +              bool has_error,
> +              ArmProcessorErrorInformationList const *error_list)
> +{
> +    ArmProcessorErrorInformationList const *next;
> +    ArmPeiValidationBitsList const *validation_list;
> +    ArmPEI *pei = NULL;
> +    uint16_t i;
> +
> +    if (!has_error) {
> +        error_list = default_pei;
> +    }
> +
> +    *err_info_num = 0;
> +
> +    for (next = error_list; next; next = next->next) {
> +        (*err_info_num)++;
> +
> +        if (*err_info_num >= 255) {
> +            break;
> +        }
> +    }
> +
> +    pei = g_new0(ArmPEI, (*err_info_num));
> +
> +    for (next = error_list, i = 0;
> +                i < *err_info_num; i++, next = next->next) {
> 
Odd alignment.


> +/* For ARM processor errors */
> +void qmp_arm_inject_error(bool has_validation,
> +                    ArmProcessorValidationBitsList *validation_list,
> +                    bool has_affinity_level,
> +                    uint8_t affinity_level,
> +                    bool has_mpidr_el1,
> +                    uint64_t mpidr_el1,
> +                    bool has_midr_el1,
> +                    uint64_t midr_el1,
> +                    bool has_running_state,
> +                    ArmProcessorRunningStateList *running_state_list,
> +                    bool has_psci_state,
> +                    uint32_t psci_state,
> +                    bool has_context,
> +                    ArmProcessorContextList *context_list,
> +                    bool has_vendor_specific,
> +                    uint8List *vendor_specific_list,
> +                    bool has_error,
> +                    ArmProcessorErrorInformationList *error_list,
> +                    Error **errp)
> +{
...

> +
> +    if (error.context) {

No need for check. If context_info_num is zero their
won't be a loop iteration. 

> +        for (i = 0; i < error.context_info_num; i++) {
> +            g_free(error.context[i].array);
> +        }
> +    }
> +    g_free(error.context);
> +    g_free(error.pei);
> +    g_free(error.vendor);
> +
> +    return;
> +}
> diff --git a/hw/arm/arm_error_inject_stubs.c b/hw/arm/arm_error_inject_stubs.c
> new file mode 100644
> index 000000000000..be6e8be2d0d9
> --- /dev/null
> +++ b/hw/arm/arm_error_inject_stubs.c
> @@ -0,0 +1,34 @@
> +/*
> + * QMP stub for ARM processor error injection.
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_arm_inject_error(bool has_validation,
> +                        ArmProcessorValidationBitsList *validation,
> +                        bool has_affinity_level,
> +                        uint8_t affinity_level,
> +                        bool has_mpidr_el1,
> +                        uint64_t mpidr_el1,
> +                        bool has_midr_el1,
> +                        uint64_t midr_el1,
> +                        bool has_running_state,
> +                        ArmProcessorRunningStateList *running_state,
> +                        bool has_psci_state,
> +                        uint32_t psci_state,
> +                        bool has_context, ArmProcessorContextList *context,
> +                        bool has_vendor_specific, uint8List *vendor_specific,
> +                        bool has_error,
> +                        ArmProcessorErrorInformationList *error,
> +                        Error **errp)
> +{
> +    error_setg(errp, "ARM processor error support is not compiled in");
> +}
Markus suggested:

> A target-specific command like this one should be conditional.  Try
> this:
> 
>     { 'command': 'arm-inject-error',
>       'data': { 'errortypes': ['ArmProcessorErrorType'] },
>       'features': [ 'unstable' ],
>       'if': 'TARGET_ARM' }
>
> No need to provide a qmp_arm_inject_error() stub then.

(I noticed because never knew you could do this.)

Probably crossed with your v4 posting.

> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 4f1ab1a73a06..c591a5fb02c4 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h

...

> +/* ARM processor - UEFI 2.10 table N.16 */
> +typedef struct ArmError {
> +    uint16_t validation;
> +
> +    uint8_t affinity_level;
> +    uint64_t mpidr_el1;
> +    uint64_t midr_el1;
> +    uint32_t running_state;
> +    uint32_t psci_state;
> +
> +    /* Those are calculated based on the input data */
    /* Calculated based on the input data */
> +    uint16_t err_info_num;
> +    uint16_t context_info_num;
> +    uint32_t vendor_num;
> +    uint32_t context_length;
> +
> +    ArmPEI *pei;
> +    ArmContext *context;
> +    uint8_t *vendor;
> +} ArmError;


