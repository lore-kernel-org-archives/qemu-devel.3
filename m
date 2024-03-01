Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E7EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg674-0000Xw-JE; Fri, 01 Mar 2024 11:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg672-0000XT-PZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg670-0008Fb-BB
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709311913;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sbZ8h1xDJwGtQpNZ41KGaJEtUbMQhgg64//3EzGAf3Q=;
 b=PHWTtNCuf0bsxnd6jUBOAExQOOw/LJ8frINgGUVYKsD4iacRW5GzQri+CyZvViQHKsXDYd
 oiZBAGnQMpt/gmVrfU5W/Szj3SEwBYpqatgCudSmRXQXhIGomzjzP2A5DdYlkRsCRnpNLD
 mvItR4XzDpPpSDMGD/d+Bg02jf9NJPo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-ZuNoOq3NOau8oiguFa7Fqw-1; Fri,
 01 Mar 2024 11:51:51 -0500
X-MC-Unique: ZuNoOq3NOau8oiguFa7Fqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AFAF2932495;
 Fri,  1 Mar 2024 16:51:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C7C120229D6;
 Fri,  1 Mar 2024 16:51:47 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:51:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 4/9] backends/igvm: Implement parsing and processing of
 IGVM files
Message-ID: <ZeIHoSvGiK5CqtV9@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <57b5139839f0e08c5d7ed35763eb01898506fd3d.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57b5139839f0e08c5d7ed35763eb01898506fd3d.1709044754.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 02:50:10PM +0000, Roy Hopkins wrote:
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
>  backends/igvm.c                           | 718 ++++++++++++++++++++++
>  backends/meson.build                      |   1 +
>  include/exec/confidential-guest-support.h |   5 +
>  include/exec/igvm.h                       |  35 ++
>  5 files changed, 763 insertions(+)
>  create mode 100644 backends/igvm.c
>  create mode 100644 include/exec/igvm.h
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index 42628be8d7..cb7651a8d0 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -15,6 +15,7 @@
>  
>  #include "exec/confidential-guest-support.h"
>  #include "qemu/error-report.h"
> +#include "exec/igvm.h"
>  
>  OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                              confidential_guest_support,
> @@ -33,6 +34,9 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
>      ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>      g_free(cgs->igvm_filename);
>      cgs->igvm_filename = g_strdup(value);
> +#if defined(CONFIG_IGVM)
> +    igvm_file_init(cgs);
> +#endif
>  }
>  #endif
>  
> diff --git a/backends/igvm.c b/backends/igvm.c
> new file mode 100644
> index 0000000000..a6261d796f
> --- /dev/null
> +++ b/backends/igvm.c
> @@ -0,0 +1,718 @@
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
> +static QTAILQ_HEAD(, IgvmParameterData) parameter_data;
> +
> +static void directive_page_data(ConfidentialGuestSupport *cgs, int i,
> +                                uint32_t compatibility_mask);
> +static void directive_vp_context(ConfidentialGuestSupport *cgs, int i,
> +                                 uint32_t compatibility_mask);
> +static void directive_parameter_area(ConfidentialGuestSupport *cgs, int i,
> +                                     uint32_t compatibility_mask);
> +static void directive_parameter_insert(ConfidentialGuestSupport *cgs, int i,
> +                                       uint32_t compatibility_mask);
> +static void directive_memory_map(ConfidentialGuestSupport *cgs, int i,
> +                                 uint32_t compatibility_mask);
> +static void directive_vp_count(ConfidentialGuestSupport *cgs, int i,
> +                               uint32_t compatibility_mask);
> +static void directive_environment_info(ConfidentialGuestSupport *cgs, int i,
> +                                       uint32_t compatibility_mask);
> +static void directive_required_memory(ConfidentialGuestSupport *cgs, int i,
> +                                      uint32_t compatibility_mask);
> +
> +struct IGVMDirectiveHandler {
> +    uint32_t type;
> +    void (*handler)(ConfidentialGuestSupport *cgs, int i,
> +                    uint32_t compatibility_mask);
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
> +static void directive(uint32_t type, ConfidentialGuestSupport *cgs, int i,
> +                      uint32_t compatibility_mask)
> +{
> +    size_t handler;
> +    for (handler = 0; handler < (sizeof(directive_handlers) /
> +                                 sizeof(struct IGVMDirectiveHandler));
> +         ++handler) {
> +        if (directive_handlers[handler].type == type) {
> +            directive_handlers[handler].handler(cgs, i, compatibility_mask);
> +            return;
> +        }
> +    }
> +    warn_report("IGVM: Unknown directive encountered when processing file: %X",
> +                type);
> +}

If a directive in a IGVM file has functional effects on the
guest behaviour it does not feel right to just ignore it and
carry on launching the guest in a likely incorrect state.

IOW, I think this should be a error, not a warning, and
this method ought to have an 'Error **errp' parameter.

> +
> +static void igvm_handle_error(int32_t result, const char *msg)
> +{
> +    if (result < 0) {
> +        error_report("Processing of IGVM file failed: %s (code: %d)", msg,
> +                     (int)result);
> +        exit(EXIT_FAILURE);
> +    }
> +}

IMHO all the code below should have "Error **errp" parameters
to report and return to the caller. The top level CGS code
that calls into IVGM can use 'error_report_err'. As such
I think this method shouldn't exist, and code shoud directly
call error_setg.

> +
> +static void *igvm_prepare_memory(uint64_t addr, uint64_t size,
> +                                 int region_identifier)
> +{
> +    MemoryRegion *igvm_pages = NULL;
> +    Int128 gpa_region_size;
> +    MemoryRegionSection mrs =
> +        memory_region_find(get_system_memory(), addr, size);
> +    if (mrs.mr) {
> +        if (!memory_region_is_ram(mrs.mr)) {
> +            memory_region_unref(mrs.mr);
> +            error_report(
> +                "Processing of IGVM file failed: Could not prepare memory "
> +                "at address 0x%lX due to existing non-RAM region",
> +                addr);
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        gpa_region_size = int128_make64(size);
> +        if (int128_lt(mrs.size, gpa_region_size)) {
> +            memory_region_unref(mrs.mr);
> +            error_report(
> +                "Processing of IGVM file failed: Could not prepare memory "
> +                "at address 0x%lX: region size exceeded",
> +                addr);
> +            exit(EXIT_FAILURE);
> +        }
> +        return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
> +    } else {
> +        /*
> +         * The region_identifier is the is the index of the IGVM directive that
> +         * contains the page with the lowest GPA in the region. This will
> +         * generate a unique region name.
> +         */
> +        char region_name[22];
> +        snprintf(region_name, sizeof(region_name), "igvm.%X",
> +                 region_identifier);

IMO it is preferrable to use

  g_autofree char *region_name = g_strdup_printf("igvm.%X", region_identifier);

> +        igvm_pages = g_malloc(sizeof(*igvm_pages));
> +        memory_region_init_ram(igvm_pages, NULL, region_name, size,
> +                               &error_fatal);
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
> +            return zero ? CGS_PAGE_TYPE_ZERO :
> +                          CGS_PAGE_TYPE_NORMAL;
> +        }
> +    }
> +    case SECRETS:
> +        return CGS_PAGE_TYPE_SECRETS;
> +    case CPUID_DATA:
> +        return CGS_PAGE_TYPE_CPUID;
> +    case CPUID_XF:
> +        return CGS_PAGE_TYPE_CPUID;
> +    default:
> +        return CGS_PAGE_TYPE_UNMEASURED;
> +    }
> +}
> +
> +static bool page_attrs_equal(const IGVM_VHS_PAGE_DATA *page_1,
> +                             const IGVM_VHS_PAGE_DATA *page_2)
> +{
> +    return ((*(const uint32_t *)&page_1->flags ==
> +             *(const uint32_t *)&page_2->flags) &&
> +            (page_1->data_type == page_2->data_type) &&
> +            (page_1->compatibility_mask == page_2->compatibility_mask));
> +}




> +void igvm_file_init(ConfidentialGuestSupport *cgs)
> +{
> +    FILE *igvm_file = NULL;
> +    uint8_t *igvm_buf = NULL;
> +
> +    if (cgs->igvm_filename) {

Invert this condition and return immediately, so we
don't have the entire method body uneccessarily indented.

> +        IgvmHandle igvm;
> +        unsigned long igvm_length;
> +
> +        igvm_file = fopen(cgs->igvm_filename, "rb");
> +        if (!igvm_file) {
> +            error_report("IGVM file not found '%s'", cgs->igvm_filename);
> +            goto error_out;
> +        }
> +
> +        fseek(igvm_file, 0, SEEK_END);
> +        igvm_length = ftell(igvm_file);
> +        fseek(igvm_file, 0, SEEK_SET);
> +
> +        igvm_buf = g_new(uint8_t, igvm_length);
> +        if (!igvm_buf) {
> +            error_report(
> +                "Could not allocate buffer to read file IGVM file '%s'",
> +                cgs->igvm_filename);
> +            goto error_out;
> +        }
> +        if (fread(igvm_buf, 1, igvm_length, igvm_file) != igvm_length) {
> +            error_report("Unable to load IGVM file '%s'", cgs->igvm_filename);
> +            goto error_out;
> +        }
> +
> +        igvm = igvm_new_from_binary(igvm_buf, igvm_length);
> +        if (igvm < 0) {
> +            error_report("Parsing IGVM file '%s' failed with  error_code %d",
> +                         cgs->igvm_filename, igvm);
> +            goto error_out;
> +        }
> +        fclose(igvm_file);
> +        g_free(igvm_buf);
> +
> +        cgs->igvm = igvm;
> +    }
> +    return;
> +
> +error_out:
> +    free(igvm_buf);
> +    if (igvm_file) {
> +        fclose(igvm_file);
> +    }
> +    exit(EXIT_FAILURE);
> +}

This can be massively simplified to:

    g_autofree uint8_t *buf = NULL;
    unsigned long len;
    g_autoptr(GError) gerr = NULL;

    if (!cgs->igvm_filename) {
        return 0;
    }

    if (!g_file_get_contents(cgs->igvm_filename, (gchar**)&buf, &len, &gerr)) {
        error_setg(errp, "Unable to load %s: %s", cgs->igvm_filename, gerr->message);
        return -1;
    }
    
    if ((cgs->igvm = igvm_new_from_binary(buf, len)) < 0) {
        error_setg(errp, "Unable to parse IGVM %s: %s", cgs->igvm_filename, cgs->igvm);
	return -1;
    }

    return 0;


> +
> +void igvm_process(ConfidentialGuestSupport *cgs)
> +{
> +    int32_t result;
> +    int i;
> +    uint32_t compatibility_mask;
> +    IgvmParameterData *parameter;
> +
> +    /*
> +     * If this is not a Confidential guest or no IGVM has been provided then
> +     * this is a no-op.
> +     */
> +    if (!cgs || !cgs->igvm) {
> +        return;
> +    }

The caller should not be invoking this method if cgs is NULL.

> +
> +    QTAILQ_INIT(&parameter_data);
> +
> +    /*
> +     * Check that the IGVM file provides configuration for the current
> +     * platform
> +     */
> +    compatibility_mask = supported_platform_compat_mask(cgs);
> +    if (compatibility_mask == 0) {
> +        error_report(
> +            "IGVM file does not describe a compatible supported platform");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    result = igvm_header_count(cgs->igvm, HEADER_SECTION_DIRECTIVE);
> +    igvm_handle_error(result, "Failed to read directive header count");
> +    for (i = 0; i < (int)result; ++i) {
> +        IgvmVariableHeaderType type =
> +            igvm_get_header_type(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +        directive(type, cgs, i, compatibility_mask);
> +    }
> +
> +    /*
> +     * Contiguous pages of data with compatible flags are grouped together in
> +     * order to reduce the number of memory regions we create. Make sure the
> +     * last group is processed with this call.
> +     */
> +    process_mem_page(cgs, i, NULL);
> +
> +    QTAILQ_FOREACH(parameter, &parameter_data, next)
> +    {
> +        g_free(parameter->data);
> +        parameter->data = NULL;
> +    }
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
> index c43a1a32f1..1a017a8fda 100644
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
> @@ -95,6 +99,7 @@ struct ConfidentialGuestSupport {
>       *                Virtual Machine (IGVM) format.
>       */
>      char *igvm_filename;
> +    IgvmHandle igvm;
>  #endif
>  
>      /*
> diff --git a/include/exec/igvm.h b/include/exec/igvm.h
> new file mode 100644
> index 0000000000..6f40a3239c
> --- /dev/null
> +++ b/include/exec/igvm.h
> @@ -0,0 +1,35 @@
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
> +void igvm_file_init(ConfidentialGuestSupport *cgs);
> +void igvm_process(ConfidentialGuestSupport *cgs);

Both of these should gain an "Error *errp" parameter and 'int'
return type and leave the error_report + exit to the caller.

> +
> +#else
> +
> +static inline void igvm_file_init(ConfidentialGuestSupport *cgs)
> +{
> +}
> +
> +static inline void igvm_process(ConfidentialGuestSupport *cgs)
> +{
> +}
> +
> +#endif
> +
> +#endif
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


