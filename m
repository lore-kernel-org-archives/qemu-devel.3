Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA64C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjRZ-00037Y-Cm; Tue, 16 Apr 2024 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjRF-00036t-PB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjR8-00047d-6B
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713276325;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Wk2ZKqoUU32HleQuUL7TJZ5zDQI8ehajJWQmzCDEex8=;
 b=Oy9suhgUHzs8GpayXbaZ56Fm//jidqFHm4tdaCejFDDA+VkoR4GpJPksEBg+LCPbI9X40/
 NhtsM+VopoXnny5vsQu/xHIwlaH49ueCR+iWOFZel0uZ6A/0WV68CPXrYbNk1dNn7tQuMt
 UI5gSHOT4qWN/ydcH6ZT67bZEyZpMuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18--V6DD0RxMY2l7hit-dq6CA-1; Tue, 16 Apr 2024 10:05:19 -0400
X-MC-Unique: -V6DD0RxMY2l7hit-dq6CA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4009580A0D5;
 Tue, 16 Apr 2024 14:05:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12B90480F23;
 Tue, 16 Apr 2024 14:05:14 +0000 (UTC)
Date: Tue, 16 Apr 2024 15:05:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 04/10] backends/igvm: Implement parsing and processing
 of IGVM files
Message-ID: <Zh6FlIiBgVPPjz58@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <9e4268647c2b3dc7fcc59d795575622c4f35a413.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e4268647c2b3dc7fcc59d795575622c4f35a413.1712141833.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 03, 2024 at 12:11:35PM +0100, Roy Hopkins wrote:
> This commit adds an implementation of an IGVM loader which parses the
> file specified as a pararameter to ConfidentialGuestSupport and provides
> a function that uses the interface in the same object to configure and
> populate guest memory based on the contents of the file.
> 
> The IGVM file is parsed when a filename is provided but the code to
> process the IGVM file is not yet hooked into target systems. This will
> follow in a later commit.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  backends/confidential-guest-support.c     |   4 +
>  backends/igvm.c                           | 745 ++++++++++++++++++++++
>  backends/meson.build                      |   1 +
>  include/exec/confidential-guest-support.h |   5 +
>  include/exec/igvm.h                       |  36 ++
>  5 files changed, 791 insertions(+)
>  create mode 100644 backends/igvm.c
>  create mode 100644 include/exec/igvm.h
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index cb0bc543c0..adfe447334 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -16,6 +16,7 @@
>  #include "exec/confidential-guest-support.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "exec/igvm.h"
>  
>  OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                              confidential_guest_support,
> @@ -34,6 +35,9 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
>      ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>      g_free(cgs->igvm_filename);
>      cgs->igvm_filename = g_strdup(value);
> +#if defined(CONFIG_IGVM)
> +    igvm_file_init(cgs, errp);
> +#endif


>  }
>  #endif
>  
> diff --git a/backends/igvm.c b/backends/igvm.c
> new file mode 100644
> index 0000000000..87e6032a2e
> --- /dev/null
> +++ b/backends/igvm.c
> @@ -0,0 +1,745 @@
> +/*
> + * QEMU IGVM configuration backend for Confidential Guests
> + *
> + * Copyright (C) 2023-2024 SUSE
> + *
> + * Authors:
> + *  Roy Hopkins <roy.hopkins@suse.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#if defined(CONFIG_IGVM)
> +
> +#include "exec/confidential-guest-support.h"
> +#include "qemu/queue.h"
> +#include "qemu/typedefs.h"
> +
> +#include "exec/igvm.h"
> +#include "qemu/error-report.h"
> +#include "hw/boards.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +
> +#include <igvm/igvm.h>
> +#include <igvm/igvm_defs.h>
> +#include <linux/kvm.h>
> +
> +typedef struct IgvmParameterData {
> +    QTAILQ_ENTRY(IgvmParameterData) next;
> +    uint8_t *data;
> +    uint32_t size;
> +    uint32_t index;
> +} IgvmParameterData;
> +
> +
> +struct IGVMDirectiveHandler {
> +    uint32_t type;
> +    int (*handler)(ConfidentialGuestSupport *cgs, int i,
> +                   uint32_t compatibility_mask, const uint8_t *header_data,
> +                   Error **errp);
> +};
> +
> +static struct IGVMDirectiveHandler directive_handlers[] = {
> +    { IGVM_VHT_PAGE_DATA, directive_page_data },
> +    { IGVM_VHT_VP_CONTEXT, directive_vp_context },
> +    { IGVM_VHT_PARAMETER_AREA, directive_parameter_area },
> +    { IGVM_VHT_PARAMETER_INSERT, directive_parameter_insert },
> +    { IGVM_VHT_MEMORY_MAP, directive_memory_map },
> +    { IGVM_VHT_VP_COUNT_PARAMETER, directive_vp_count },
> +    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, directive_environment_info },
> +    { IGVM_VHT_REQUIRED_MEMORY, directive_required_memory },
> +};
> +
> +static int directive(uint32_t type, ConfidentialGuestSupport *cgs, int i,
> +                      uint32_t compatibility_mask, Error **errp)
> +{
> +    size_t handler;
> +    IgvmHandle header_handle;
> +    const uint8_t *header_data;
> +    int result;
> +
> +    for (handler = 0; handler < (sizeof(directive_handlers) /
> +                                 sizeof(struct IGVMDirectiveHandler));
> +         ++handler) {

Normal style is post-increment (ie handler++), also you can replace the
sizeof calculation with "G_N_ELEMENTS(directive_handlers)"

> +        if (directive_handlers[handler].type == type) {

if (directive_handlers[handler].type != type) {
  continue
}

means we can reduce indent in the rest of the block

> +            header_handle =
> +                igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +            if (header_handle < 0) {
> +                error_setg(
> +                    errp,
> +                    "IGVM file is invalid: Failed to read directive header (code: %d)",
> +                    (int)header_handle);
> +                return -1;
> +            }
> +            header_data = igvm_get_buffer(cgs->igvm, header_handle) +
> +                          sizeof(IGVM_VHS_VARIABLE_HEADER);
> +            result = directive_handlers[handler].handler(
> +                cgs, i, compatibility_mask, header_data, errp);
> +            igvm_free_buffer(cgs->igvm, header_handle);
> +            return result;
> +        }
> +    }
> +    error_setg(errp,
> +               "IGVM: Unknown directive type encountered when processing file: "
> +               "(type 0x%X)",
> +               type);
> +    return -1;
> +}
> +
> +static void *igvm_prepare_memory(uint64_t addr, uint64_t size,
> +                                 int region_identifier, Error **errp)
> +{
> +    MemoryRegion *igvm_pages = NULL;
> +    Int128 gpa_region_size;
> +    MemoryRegionSection mrs =
> +        memory_region_find(get_system_memory(), addr, size);
> +    if (mrs.mr) {
> +        if (!memory_region_is_ram(mrs.mr)) {
> +            memory_region_unref(mrs.mr);
> +            error_setg(
> +                errp,
> +                "Processing of IGVM file failed: Could not prepare memory "
> +                "at address 0x%lX due to existing non-RAM region",
> +                addr);
> +            return NULL;
> +        }
> +
> +        gpa_region_size = int128_make64(size);
> +        if (int128_lt(mrs.size, gpa_region_size)) {
> +            memory_region_unref(mrs.mr);
> +            error_setg(
> +                errp,
> +                "Processing of IGVM file failed: Could not prepare memory "
> +                "at address 0x%lX: region size exceeded",
> +                addr);
> +            return NULL;
> +        }
> +        return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
> +    } else {
> +        /*
> +         * The region_identifier is the is the index of the IGVM directive that
> +         * contains the page with the lowest GPA in the region. This will
> +         * generate a unique region name.
> +         */
> +        g_autofree char *region_name =
> +            g_strdup_printf("igvm.%X", region_identifier);
> +        igvm_pages = g_malloc(sizeof(*igvm_pages));
> +        if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
> +                                    errp)) {
> +            return NULL;
> +        }
> +        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
> +        return memory_region_get_ram_ptr(igvm_pages);
> +    }
> +}
> +
> +static int igvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
> +                                 bool zero)
> +{
> +    switch (memory_type) {
> +    case NORMAL: {
> +        if (unmeasured) {
> +            return CGS_PAGE_TYPE_UNMEASURED;
> +        } else {
> +            return zero ? CGS_PAGE_TYPE_ZERO : CGS_PAGE_TYPE_NORMAL;
> +        }
> +    }
> +    case SECRETS:
> +        return CGS_PAGE_TYPE_SECRETS;
> +    case CPUID_DATA:
> +        return CGS_PAGE_TYPE_CPUID;
> +    case CPUID_XF:
> +        return CGS_PAGE_TYPE_CPUID;
> +    default:
> +        return -1;
> +    }
> +}
> +
> +static bool page_attrs_equal(IgvmHandle igvm, int i,
> +                             const IGVM_VHS_PAGE_DATA *page_1,
> +                             const IGVM_VHS_PAGE_DATA *page_2)
> +{
> +    IgvmHandle data_handle1, data_handle2;
> +
> +    /*
> +     * If one page has data and the other doesn't then this results in different
> +     * page types: NORMAL vs ZERO.
> +     */
> +    data_handle1 = igvm_get_header_data(igvm, HEADER_SECTION_DIRECTIVE, i - 1);
> +    data_handle2 = igvm_get_header_data(igvm, HEADER_SECTION_DIRECTIVE, i);
> +    if ((data_handle1 == IGVMAPI_NO_DATA) &&
> +        (data_handle2 != IGVMAPI_NO_DATA)) {
> +        return false;
> +    } else if ((data_handle1 != IGVMAPI_NO_DATA) &&
> +               (data_handle2 == IGVMAPI_NO_DATA)) {
> +        return false;
> +    }
> +    return ((*(const uint32_t *)&page_1->flags ==
> +             *(const uint32_t *)&page_2->flags) &&
> +            (page_1->data_type == page_2->data_type) &&
> +            (page_1->compatibility_mask == page_2->compatibility_mask));
> +}
> +
> +static int igvm_process_mem_region(ConfidentialGuestSupport *cgs,
> +                                   IgvmHandle igvm, int start_index,
> +                                   uint64_t gpa_start, int page_count,
> +                                   const IgvmPageDataFlags *flags,
> +                                   const IgvmPageDataType page_type,
> +                                   Error **errp)
> +{
> +    ERRP_GUARD();
> +    uint8_t *region;
> +    IgvmHandle data_handle;
> +    const void *data;
> +    uint32_t data_size;
> +    int i;
> +    bool zero = true;
> +    const uint64_t page_size = flags->is_2mb_page ? 0x200000 : 0x1000;
> +    int result;
> +    int cgs_page_type;
> +
> +    region = igvm_prepare_memory(gpa_start, page_count * page_size, start_index,
> +                                 errp);
> +    if (!region) {
> +        return -1;
> +    }
> +
> +    for (i = 0; i < page_count; ++i) {
> +        data_handle = igvm_get_header_data(igvm, HEADER_SECTION_DIRECTIVE,
> +                                           i + start_index);
> +        if (data_handle == IGVMAPI_NO_DATA) {
> +            /* No data indicates a zero page */
> +            memset(&region[i * page_size], 0, page_size);
> +        } else if (data_handle < 0) {
> +            error_setg(
> +                errp,
> +                "IGVM file contains invalid page data for directive with "
> +                "index %d",
> +                i + start_index);
> +            return -1;
> +        } else {
> +            zero = false;
> +            data_size = igvm_get_buffer_size(igvm, data_handle);
> +            if (data_size < page_size) {
> +                memset(&region[i * page_size], 0, page_size);
> +            } else if (data_size > page_size) {
> +                error_setg(errp,
> +                           "IGVM file contains page data with invalid size for "
> +                           "directive with index %d",
> +                           i + start_index);
> +                return -1;
> +            }
> +            data = igvm_get_buffer(igvm, data_handle);
> +            memcpy(&region[i * page_size], data, data_size);
> +            igvm_free_buffer(igvm, data_handle);
> +        }
> +    }
> +
> +    cgs_page_type = igvm_type_to_cgs_type(page_type, flags->unmeasured, zero);
> +    if (cgs_page_type < 0) {
> +        error_setg(
> +            errp,
> +            "Invalid page type in IGVM file. Directives: %d to %d, "
> +            "page type: %d",
> +            start_index, start_index + page_count, page_type);
> +        return -1;
> +    }
> +
> +    result = cgs->set_guest_state(gpa_start, region, page_size * page_count,
> +                                  cgs_page_type, 0, errp);
> +    if ((result < 0) && !*errp) {
> +        error_setg(errp, "IGVM set guest state failed with code %d", result);
> +        return -1;
> +    }

It is bad practice to have a method which only fills 'errp' in some
error conditions. We should expect that any impl of set_guest_state
always sets 'errp' if it returns -1, and thus not need this error_setg
call. Same point later on.

Removing this check means we cna also remove the ERRP_GUARD.

> +    return 0;
> +}
> +
> +static int process_mem_page(ConfidentialGuestSupport *cgs, int i,
> +                            const IGVM_VHS_PAGE_DATA *page_data, Error **errp)
> +{
> +    ERRP_GUARD();

Nothing dereferences 'errp' so this ERRP_GUARD is redundant.

> +    static IGVM_VHS_PAGE_DATA prev_page_data;
> +    static uint64_t region_start;
> +    static int region_start_i;
> +    static int last_i;
> +    static int page_count;
> +
> +    if (page_data) {
> +        if (page_count == 0) {
> +            region_start = page_data->gpa;
> +            region_start_i = i;
> +        } else {
> +            if (!page_attrs_equal(cgs->igvm, i, page_data, &prev_page_data) ||
> +                ((prev_page_data.gpa +
> +                  (prev_page_data.flags.is_2mb_page ? 0x200000 : 0x1000)) !=
> +                 page_data->gpa) ||
> +                (last_i != (i - 1))) {
> +                /* End of current region */
> +                if (igvm_process_mem_region(cgs, cgs->igvm, region_start_i,
> +                                        region_start, page_count,
> +                                        &prev_page_data.flags,
> +                                        prev_page_data.data_type, errp) < 0) {
> +                    return -1;
> +                }
> +                page_count = 0;
> +                region_start = page_data->gpa;
> +                region_start_i = i;
> +            }
> +        }
> +        memcpy(&prev_page_data, page_data, sizeof(prev_page_data));
> +        last_i = i;
> +        ++page_count;
> +    } else {
> +        if (page_count > 0) {
> +            if (igvm_process_mem_region(cgs, cgs->igvm, region_start_i,
> +                                    region_start, page_count,
> +                                    &prev_page_data.flags,
> +                                    prev_page_data.data_type, errp) < 0) {
> +                return -1;
> +            }
> +            page_count = 0;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int directive_page_data(ConfidentialGuestSupport *cgs, int i,
> +                               uint32_t compatibility_mask,
> +                               const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PAGE_DATA *page_data =
> +        (const IGVM_VHS_PAGE_DATA *)header_data;
> +    if (page_data->compatibility_mask & compatibility_mask) {
> +        return process_mem_page(cgs, i, page_data, errp);
> +    }
> +    return 0;
> +}
> +
> +static int directive_vp_context(ConfidentialGuestSupport *cgs, int i,
> +                                uint32_t compatibility_mask,
> +                                const uint8_t *header_data, Error **errp)
> +{
> +    ERRP_GUARD();
> +    const IGVM_VHS_VP_CONTEXT *vp_context =
> +        (const IGVM_VHS_VP_CONTEXT *)header_data;
> +    IgvmHandle data_handle;
> +    uint8_t *data;
> +    int result;
> +
> +    if (vp_context->compatibility_mask & compatibility_mask) {
> +        data_handle =
> +            igvm_get_header_data(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +        if (data_handle < 0) {
> +            error_setg(errp, "Invalid VP context in IGVM file. Error code: %X",
> +                       data_handle);
> +            return -1;
> +        }
> +
> +        data = (uint8_t *)igvm_get_buffer(cgs->igvm, data_handle);
> +        result = cgs->set_guest_state(
> +            vp_context->gpa, data, igvm_get_buffer_size(cgs->igvm, data_handle),
> +            CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
> +        igvm_free_buffer(cgs->igvm, data_handle);
> +        if (result != 0) {

Other places check 'result < 0'.

> +            if (!*errp) {

Again, we  should expect set_guest_state to have correctly
reported errors already.

> +                error_setg(errp,
> +                           "IGVM: Failed to set CPU context: error_code=%d",
> +                           result);
> +            }
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int directive_parameter_area(ConfidentialGuestSupport *cgs, int i,
> +                                    uint32_t compatibility_mask,
> +                                    const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER_AREA *param_area =
> +        (const IGVM_VHS_PARAMETER_AREA *)header_data;
> +    IgvmParameterData *param_entry;
> +
> +    param_entry = g_new0(IgvmParameterData, 1);
> +    param_entry->size = param_area->number_of_bytes;
> +    param_entry->index = param_area->parameter_area_index;
> +    param_entry->data = g_malloc0(param_entry->size);
> +
> +    QTAILQ_INSERT_TAIL(&parameter_data, param_entry, next);
> +    return 0;
> +}
> +
> +static int directive_parameter_insert(ConfidentialGuestSupport *cgs, int i,
> +                                      uint32_t compatibility_mask,
> +                                      const uint8_t *header_data, Error **errp)
> +{
> +    ERRP_GUARD();
> +    const IGVM_VHS_PARAMETER_INSERT *param =
> +        (const IGVM_VHS_PARAMETER_INSERT *)header_data;
> +    IgvmParameterData *param_entry;
> +    int result;
> +    void *region;
> +
> +    QTAILQ_FOREACH(param_entry, &parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {
> +            region =
> +                igvm_prepare_memory(param->gpa, param_entry->size, i, errp);
> +            if (!region) {
> +                return -1;
> +            }
> +            memcpy(region, param_entry->data, param_entry->size);
> +            g_free(param_entry->data);
> +            param_entry->data = NULL;
> +
> +            result = cgs->set_guest_state(param->gpa, region, param_entry->size,
> +                                          CGS_PAGE_TYPE_UNMEASURED, 0, errp);
> +            if (result != 0) {

Use '< 0'

> +                if (!*errp) {

Redundant

> +                    error_setg(errp,
> +                               "IGVM: Failed to set guest state: error_code=%d",
> +                               result);
> +                }
> +                return -1;
> +            }
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int cmp_mm_entry(const void *a, const void *b)
> +{
> +    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_a =
> +        (const IGVM_VHS_MEMORY_MAP_ENTRY *)a;
> +    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_b =
> +        (const IGVM_VHS_MEMORY_MAP_ENTRY *)b;
> +    if (entry_a->starting_gpa_page_number < entry_b->starting_gpa_page_number) {
> +        return -1;
> +    } else if (entry_a->starting_gpa_page_number >
> +               entry_b->starting_gpa_page_number) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static int directive_memory_map(ConfidentialGuestSupport *cgs, int i,
> +                                uint32_t compatibility_mask,
> +                                const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
> +    IgvmParameterData *param_entry;
> +    int max_entry_count;
> +    int entry = 0;
> +    IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
> +    ConfidentialGuestMemoryMapEntry cgmm_entry;
> +    int retval = 0;
> +
> +    /* Find the parameter area that should hold the memory map */
> +    QTAILQ_FOREACH(param_entry, &parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {
> +            max_entry_count =
> +                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
> +            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
> +
> +            retval = cgs->get_mem_map_entry(entry, &cgmm_entry, errp);
> +            while (retval == 0) {
> +                if (entry > max_entry_count) {
> +                    error_setg(
> +                        errp,
> +                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
> +                    return -1;
> +                }
> +                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
> +                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
> +
> +                switch (cgmm_entry.type) {
> +                case CGS_MEM_RAM:
> +                    mm_entry[entry].entry_type = MEMORY;
> +                    break;
> +                case CGS_MEM_RESERVED:
> +                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
> +                    break;
> +                case CGS_MEM_ACPI:
> +                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
> +                    break;
> +                case CGS_MEM_NVS:
> +                    mm_entry[entry].entry_type = PERSISTENT;
> +                    break;
> +                case CGS_MEM_UNUSABLE:
> +                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
> +                    break;
> +                }
> +                retval = cgs->get_mem_map_entry(++entry, &cgmm_entry, errp);
> +            }
> +            if (retval < 0) {
> +                return retval;
> +            }
> +            /* The entries need to be sorted */
> +            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
> +                  cmp_mm_entry);
> +
> +            break;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int directive_vp_count(ConfidentialGuestSupport *cgs, int i,
> +                              uint32_t compatibility_mask,
> +                              const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
> +    IgvmParameterData *param_entry;
> +    uint32_t *vp_count;
> +    CPUState *cpu;
> +
> +    QTAILQ_FOREACH(param_entry, &parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {
> +            vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
> +            *vp_count = 0;
> +            CPU_FOREACH(cpu)
> +            {
> +                (*vp_count)++;
> +            }
> +            break;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int directive_environment_info(ConfidentialGuestSupport *cgs, int i,
> +                                      uint32_t compatibility_mask,
> +                                      const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
> +    IgvmParameterData *param_entry;
> +    IgvmEnvironmentInfo *environmental_state;
> +
> +    QTAILQ_FOREACH(param_entry, &parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {
> +            environmental_state =
> +                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
> +            environmental_state->memory_is_shared = 1;
> +            break;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int directive_required_memory(ConfidentialGuestSupport *cgs, int i,
> +                                     uint32_t compatibility_mask,
> +                                     const uint8_t *header_data, Error **errp)
> +{
> +    ERRP_GUARD();
> +    const IGVM_VHS_REQUIRED_MEMORY *mem =
> +        (const IGVM_VHS_REQUIRED_MEMORY *)header_data;
> +    uint8_t *region;
> +    int result;
> +
> +    if (mem->compatibility_mask & compatibility_mask) {
> +        region = igvm_prepare_memory(mem->gpa, mem->number_of_bytes, i, errp);
> +        if (!region) {
> +            return -1;
> +        }
> +        result = cgs->set_guest_state(mem->gpa, region, mem->number_of_bytes,
> +                                      CGS_PAGE_TYPE_REQUIRED_MEMORY, 0, errp);
> +        if (result < 0) {
> +            if (!*errp) {

Redynudat

> +                error_setg(errp,
> +                           "IGVM: Failed to set guest state: error_code=%d",
> +                           result);
> +            }
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static uint32_t supported_platform_compat_mask(ConfidentialGuestSupport *cgs,
> +                                               Error **errp)
> +{
> +    int32_t result;
> +    int i;
> +    IgvmHandle header_handle;
> +    IGVM_VHS_SUPPORTED_PLATFORM *platform;
> +    uint32_t compatibility_mask = 0;
> +
> +    result = igvm_header_count(cgs->igvm, HEADER_SECTION_PLATFORM);
> +    if (result < 0) {
> +        error_setg(errp,
> +                   "Invalid platform header count in IGVM file. Error code: %X",
> +                   result);
> +        return 0;
> +    }
> +
> +    for (i = 0; i < (int)result; ++i) {
> +        IgvmVariableHeaderType typ =
> +            igvm_get_header_type(cgs->igvm, HEADER_SECTION_PLATFORM, i);
> +        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
> +            header_handle =
> +                igvm_get_header(cgs->igvm, HEADER_SECTION_PLATFORM, i);
> +            if (header_handle < 0) {
> +                error_setg(errp,
> +                           "Invalid platform header in IGVM file. "
> +                           "Index: %d, Error code: %X",
> +                           i, header_handle);
> +                return 0;
> +            }
> +            platform =
> +                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(cgs->igvm,
> +                                                                header_handle) +
> +                                                sizeof(
> +                                                    IGVM_VHS_VARIABLE_HEADER));
> +            /* Currently only support SEV-SNP. */
> +            if (platform->platform_type == SEV_SNP) {
> +                /*
> +                 * IGVM does not define a platform types of SEV or SEV_ES.
> +                 * Translate SEV_SNP into CGS_PLATFORM_SEV_ES and
> +                 * CGS_PLATFORM_SEV and let the cgs function implementations
> +                 * check whether each IGVM directive results in an operation
> +                 * that is supported by the particular derivative of SEV.
> +                 */
> +                if (cgs->check_support(
> +                        CGS_PLATFORM_SEV_ES, platform->platform_version,
> +                        platform->highest_vtl, platform->shared_gpa_boundary) ||
> +                    cgs->check_support(
> +                        CGS_PLATFORM_SEV, platform->platform_version,
> +                        platform->highest_vtl, platform->shared_gpa_boundary)) {
> +                    compatibility_mask = platform->compatibility_mask;
> +                    break;
> +                }
> +            }
> +            igvm_free_buffer(cgs->igvm, header_handle);
> +        }
> +    }
> +    if (compatibility_mask == 0) {
> +        error_setg(
> +            errp,
> +            "IGVM file does not describe a compatible supported platform");
> +    }
> +    return compatibility_mask;
> +}
> +
> +int igvm_file_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    g_autofree uint8_t *buf = NULL;
> +    unsigned long len;
> +    g_autoptr(GError) gerr = NULL;
> +
> +    if (!cgs->igvm_filename) {
> +        return 0;
> +    }

I'd prefer to see this check in the caller, as it makes it clearer
that the igvm logic won't be run when the filename is unset.

> +
> +    if (!g_file_get_contents(cgs->igvm_filename, (gchar **)&buf, &len, &gerr)) {
> +        error_setg(errp, "Unable to load %s: %s", cgs->igvm_filename,
> +                   gerr->message);
> +        return -1;
> +    }
> +
> +    cgs->igvm = igvm_new_from_binary(buf, len);
> +    if (cgs->igvm < 0) {
> +        error_setg(errp, "Unable to parse IGVM file %s: %d", cgs->igvm_filename,
> +                   cgs->igvm);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +int igvm_process(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    int32_t result;
> +    int i;
> +    uint32_t compatibility_mask;
> +    IgvmParameterData *parameter;
> +    int retval = 0;

Change to 'retval = -1'

> +
> +    /*
> +     * If this is not a Confidential guest or no IGVM has been provided then
> +     * this is a no-op.
> +     */
> +    if (!cgs->igvm) {
> +        return 0;
> +    }

Again I'd prefedr the caller to do this check and avoid calling
igvm_process, to make it clear it is a no-op.

> +
> +    /*
> +     * Check that the IGVM file provides configuration for the current
> +     * platform
> +     */
> +    compatibility_mask = supported_platform_compat_mask(cgs, errp);
> +    if (compatibility_mask == 0) {
> +        return -1;
> +    }
> +
> +    result = igvm_header_count(cgs->igvm, HEADER_SECTION_DIRECTIVE);
> +    if (result < 0) {

Is 0 a valid header count, or should this be '<=' instead of '<' ?

> +        error_setg(
> +            errp, "Invalid directive header count in IGVM file. Error code: %X",
> +            result);
> +        return -1;
> +    }
> +
> +    QTAILQ_INIT(&parameter_data);
> +
> +    for (i = 0; i < (int)result; ++i) {

Preferrably  'i++ ' for more common style.

> +        IgvmVariableHeaderType type =
> +            igvm_get_header_type(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +        if (directive(type, cgs, i, compatibility_mask, errp) < 0) {
> +            retval = -1;
> +            break;

Replace two lines with 'goto cleanup'.

> +        }
> +    }
> +
> +    /*
> +     * Contiguous pages of data with compatible flags are grouped together in
> +     * order to reduce the number of memory regions we create. Make sure the
> +     * last group is processed with this call.
> +     */
> +    if (retval == 0) {

Can remove this condition check

> +        retval = process_mem_page(cgs, i, NULL, errp);
> +    }
> +

Here add:

  cleanup:

> +    QTAILQ_FOREACH(parameter, &parameter_data, next)
> +    {
> +        g_free(parameter->data);
> +        parameter->data = NULL;
> +    }
> +
> +    return retval;
> +}
> +
> +#endif
> diff --git a/backends/meson.build b/backends/meson.build
> index d550ac19f7..d092850a07 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -32,6 +32,7 @@ system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
>  system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
>  if igvm.found()
>    system_ss.add(igvm)
> +  system_ss.add(files('igvm.c'))
>  endif
>  
>  subdir('tpm')
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index a8ad84fa07..9419e91249 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -27,6 +27,10 @@
>  #include "igvm/igvm.h"
>  #endif
>  
> +#if defined(CONFIG_IGVM)
> +#include "igvm/igvm.h"
> +#endif
> +
>  #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
>  OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
>  
> @@ -93,6 +97,7 @@ struct ConfidentialGuestSupport {
>       *                Virtual Machine (IGVM) format.
>       */
>      char *igvm_filename;
> +    IgvmHandle igvm;
>  #endif
>  
>      /*
> diff --git a/include/exec/igvm.h b/include/exec/igvm.h
> new file mode 100644
> index 0000000000..59594f047e
> --- /dev/null
> +++ b/include/exec/igvm.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU IGVM configuration backend for Confidential Guests
> + *
> + * Copyright (C) 2023-2024 SUSE
> + *
> + * Authors:
> + *  Roy Hopkins <roy.hopkins@suse.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef EXEC_IGVM_H
> +#define EXEC_IGVM_H
> +
> +#include "exec/confidential-guest-support.h"
> +
> +#if defined(CONFIG_IGVM)
> +
> +int igvm_file_init(ConfidentialGuestSupport *cgs, Error **errp);
> +int igvm_process(ConfidentialGuestSupport *cgs, Error **erp);
> +
> +#else
> +
> +static inline int igvm_file_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    return 0;

This should report an error and return -1, since reaching
this would be a error scenario

> +}
> +
> +static inline int igvm_process(ConfidentialGuestSupport *cgs, Error **errp)
> +{

Also should report an error

> +}
> +
> +#endif
> +
> +#endif
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


