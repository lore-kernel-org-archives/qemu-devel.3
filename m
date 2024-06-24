Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjlP-0004h8-GN; Mon, 24 Jun 2024 09:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLjlI-0004d4-My
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLjlD-0000Kr-R4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719235770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JhesVBtNl7YTokSEIqKhTXJ2swYMOJ1WEh41iN9UJT0=;
 b=JjY0TUHItakgiQcvpGwBENJIphK1xYvSEGoLkHnuZRRKCB95eQHtMcUqJxQ+9+yTTyzcNk
 WYn0E/vF3RIO84YPt+el3t+lWpButdZ956T72Mro9uc58yNLHJbRWN6hOfpPo56UpmDm20
 nBn2yIvARV6nxdCqPinqppuvaFpqj9U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-cTYHYwddPDKci14QiUHkHA-1; Mon,
 24 Jun 2024 09:29:26 -0400
X-MC-Unique: cTYHYwddPDKci14QiUHkHA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3069319560B1; Mon, 24 Jun 2024 13:29:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE4AC19560AE; Mon, 24 Jun 2024 13:29:19 +0000 (UTC)
Date: Mon, 24 Jun 2024 14:29:11 +0100
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
Subject: Re: [PATCH v3 03/15] backends/igvm: Add IGVM loader and configuration
Message-ID: <Znl0p9IwzT24uHlf@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <31e19ee36bdbf0ba91d95bc2d71865d7d0007ff1.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31e19ee36bdbf0ba91d95bc2d71865d7d0007ff1.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 03:29:06PM +0100, Roy Hopkins wrote:
> Adds an IGVM loader to QEMU which processes a given IGVM file and
> applies the directives within the file to the current guest
> configuration.
> 
> The IGVM loader can be used to configure both confidential and
> non-confidential guests. For confidential guests, the
> ConfidentialGuestSupport object for the system is used to encrypt
> memory, apply the initial CPU state and perform other confidential guest
> operations.
> 
> The loader is configured via a new IgvmCfg QOM object which allows the
> user to provide a path to the IGVM file to process.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  qapi/qom.json             |  16 +
>  backends/igvm.h           |  37 ++
>  include/sysemu/igvm-cfg.h |  54 +++
>  backends/igvm-cfg.c       |  66 ++++
>  backends/igvm.c           | 791 ++++++++++++++++++++++++++++++++++++++
>  backends/meson.build      |   2 +
>  6 files changed, 966 insertions(+)
>  create mode 100644 backends/igvm.h
>  create mode 100644 include/sysemu/igvm-cfg.h
>  create mode 100644 backends/igvm-cfg.c
>  create mode 100644 backends/igvm.c
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..e586707c4c 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -874,6 +874,18 @@
>    'base': 'RngProperties',
>    'data': { '*filename': 'str' } }
>  
> +##
> +# @IgvmCfgProperties:
> +#
> +# Properties common to objects that handle IGVM files.
> +#
> +# @file: IGVM file to use to configure guest (default: none)
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'IgvmCfgProperties',
> +  'data': { '*file': 'str' } }
> +
>  ##
>  # @SevCommonProperties:
>  #
> @@ -1039,6 +1051,8 @@
>      'filter-redirector',
>      'filter-replay',
>      'filter-rewriter',
> +    { 'name': 'igvm-cfg',
> +      'if': 'CONFIG_IGVM' },
>      'input-barrier',
>      { 'name': 'input-linux',
>        'if': 'CONFIG_LINUX' },
> @@ -1111,6 +1125,8 @@
>        'filter-redirector':          'FilterRedirectorProperties',
>        'filter-replay':              'NetfilterProperties',
>        'filter-rewriter':            'FilterRewriterProperties',
> +      'igvm-cfg':                   { 'type': 'IgvmCfgProperties',
> +                                      'if': 'CONFIG_IGVM' },
>        'input-barrier':              'InputBarrierProperties',
>        'input-linux':                { 'type': 'InputLinuxProperties',
>                                        'if': 'CONFIG_LINUX' },
> diff --git a/backends/igvm.h b/backends/igvm.h
> new file mode 100644
> index 0000000000..3a3824b391
> --- /dev/null
> +++ b/backends/igvm.h
> @@ -0,0 +1,37 @@
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
> +#ifndef BACKENDS_IGVM_H
> +#define BACKENDS_IGVM_H
> +
> +#include "exec/confidential-guest-support.h"
> +#include "sysemu/igvm-cfg.h"
> +#include "qapi/error.h"
> +
> +#if defined(CONFIG_IGVM)
> +
> +int igvm_process_file(IgvmCfgState *igvm, ConfidentialGuestSupport *cgs,
> +                      Error **errp);
> +
> +#else
> +
> +static inline int igvm_process_file(IgvmCfgState *igvm,
> +                                    ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    error_setg(
> +        errp, "Invalid call to igvm_process_file when CONFIG_IGVM is disabled");
> +    return -1;
> +}

IIUC, the only call to this is from igvm-cfg.c, but that file is not
compiled if CONFIG_IGVM is unset.

IOW, isn't this inline stub deadcode that will never been compiled,
let alone called ?  Can we just get rid of the conditional in this
file entirely ? If someone were to change the build rules to create
an inconsistent build scenario, they'd get a linker error from the
missing igvm_process_file which seems good enough ?




> diff --git a/backends/igvm.c b/backends/igvm.c
> new file mode 100644
> index 0000000000..25bbddfa33
> --- /dev/null
> +++ b/backends/igvm.c
> @@ -0,0 +1,791 @@
> +/*
> + * QEMU IGVM configuration backend for guests
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
> +#include "igvm.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "hw/core/cpu.h"
> +
> +#include <igvm/igvm.h>
> +#include <igvm/igvm_defs.h>
> +
> +typedef struct IgvmParameterData {
> +    QTAILQ_ENTRY(IgvmParameterData) next;
> +    uint8_t *data;
> +    uint32_t size;
> +    uint32_t index;
> +} IgvmParameterData;
> +
> +/*
> + * QemuIgvm contains the information required during processing
> + * of a single IGVM file.
> + */
> +typedef struct QemuIgvm {
> +    IgvmHandle file;
> +    ConfidentialGuestSupport *cgs;
> +    ConfidentialGuestSupportClass *cgsc;
> +    uint32_t compatibility_mask;
> +    unsigned current_header_index;
> +    QTAILQ_HEAD(, IgvmParameterData) parameter_data;
> +
> +    /* These variables keep track of contiguous page regions */
> +    IGVM_VHS_PAGE_DATA region_prev_page_data;
> +    uint64_t region_start;
> +    unsigned region_start_index;
> +    unsigned region_last_index;
> +    unsigned region_page_count;
> +} QemuIgvm;
> +
> +static int directive_page_data(QemuIgvm *ctx, const uint8_t *header_data,
> +                               Error **errp);
> +static int directive_vp_context(QemuIgvm *ctx, const uint8_t *header_data,
> +                                Error **errp);
> +static int directive_parameter_area(QemuIgvm *ctx, const uint8_t *header_data,
> +                                    Error **errp);
> +static int directive_parameter_insert(QemuIgvm *ctx, const uint8_t *header_data,
> +                                      Error **errp);
> +static int directive_memory_map(QemuIgvm *ctx, const uint8_t *header_data,
> +                                Error **errp);
> +static int directive_vp_count(QemuIgvm *ctx, const uint8_t *header_data,
> +                              Error **errp);
> +static int directive_environment_info(QemuIgvm *ctx, const uint8_t *header_data,
> +                                      Error **errp);
> +static int directive_required_memory(QemuIgvm *ctx, const uint8_t *header_data,
> +                                     Error **errp);
> +
> +struct IGVMHandler {
> +    uint32_t type;
> +    uint32_t section;
> +    int (*handler)(QemuIgvm *ctx, const uint8_t *header_data, Error **errp);

All the impls of the handler are doing manual casts from 'header_data' to
some other struct. If you declare this 'void *' instead, then all those
manual casts are redundant.

> +};
> +
> +static struct IGVMHandler handlers[] = {
> +    { IGVM_VHT_PAGE_DATA, IGVM_HEADER_SECTION_DIRECTIVE, directive_page_data },
> +    { IGVM_VHT_VP_CONTEXT, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_vp_context },
> +    { IGVM_VHT_PARAMETER_AREA, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_parameter_area },
> +    { IGVM_VHT_PARAMETER_INSERT, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_parameter_insert },
> +    { IGVM_VHT_MEMORY_MAP, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_memory_map },
> +    { IGVM_VHT_VP_COUNT_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_vp_count },
> +    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_environment_info },
> +    { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_required_memory },
> +};
> +
> +static int handler(QemuIgvm *ctx, uint32_t type, Error **errp)
> +{
> +    size_t handler;
> +    IgvmHandle header_handle;
> +    const uint8_t *header_data;
> +    int result;
> +
> +    for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
> +        if (handlers[handler].type != type) {
> +            continue;
> +        }
> +        header_handle = igvm_get_header(ctx->file,
> +                                        handlers[handler].section,
> +                                        ctx->current_header_index);
> +        if (header_handle < 0) {
> +            error_setg(
> +                errp,
> +                "IGVM file is invalid: Failed to read directive header (code: %d)",
> +                (int)header_handle);
> +            return -1;
> +        }
> +        header_data = igvm_get_buffer(ctx->file, header_handle) +
> +                      sizeof(IGVM_VHS_VARIABLE_HEADER);
> +        result = handlers[handler].handler(ctx, header_data, errp);
> +        igvm_free_buffer(ctx->file, header_handle);
> +        return result;
> +    }
> +    error_setg(errp,
> +               "IGVM: Unknown header type encountered when processing file: "
> +               "(type 0x%X)",
> +               type);
> +    return -1;
> +}
> +
> +static void *igvm_prepare_memory(QemuIgvm *ctx, uint64_t addr, uint64_t size,
> +                                 int region_identifier, Error **errp)
> +{
> +    ERRP_GUARD();
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

nit-pick, typically we'd prefer g_new0 over g_malloc + sizeof

> +        if (ctx->cgs && ctx->cgs->require_guest_memfd) {
> +            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> +                                                    region_name, size, errp)) {
> +                return NULL;
> +            }
> +        } else {
> +            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
> +                                        errp)) {
> +                return NULL;
> +            }
> +        }
> +        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
> +        return memory_region_get_ram_ptr(igvm_pages);
> +    }

> +static int directive_memory_map(QemuIgvm *ctx, const uint8_t *header_data,
> +                                Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;

If changing header_data to 'const void *', then this repetition
of typename goes away e.g.

   const IGVM_VHS_PARAMETER *param = header_data;




> +int igvm_process_file(IgvmCfgState *cfg, ConfidentialGuestSupport *cgs,
> +                      Error **errp)
> +{
> +    int32_t header_count;
> +    IgvmParameterData *parameter;
> +    int retval = -1;
> +    QemuIgvm ctx;
> +
> +    memset(&ctx, 0, sizeof(ctx));

Can avoid the manual memset using

  QemuIgvm ctx = {};

> +    ctx.file = igvm_file_init(cfg->filename, errp);
> +    if (ctx.file < 0) {
> +        return -1;
> +    }
> +
> +    /*
> +     * The ConfidentialGuestSupport object is optional and allows a confidential
> +     * guest platform to perform extra processing, such as page measurement, on
> +     * IGVM directives.
> +     */
> +    ctx.cgs = cgs;
> +    ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
> +
> +    /*
> +     * Check that the IGVM file provides configuration for the current
> +     * platform
> +     */
> +    if (supported_platform_compat_mask(&ctx, errp) < 0) {
> +        return -1;
> +    }
> +
> +    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
> +    if (header_count <= 0) {
> +        error_setg(
> +            errp, "Invalid directive header count in IGVM file. Error code: %X",
> +            header_count);
> +        return -1;
> +    }
> +
> +    QTAILQ_INIT(&ctx.parameter_data);
> +
> +    for (ctx.current_header_index = 0;
> +         ctx.current_header_index < (unsigned)header_count;
> +         ctx.current_header_index++) {
> +        IgvmVariableHeaderType type = igvm_get_header_type(
> +            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
> +        if (handler(&ctx, type, errp) < 0) {
> +            goto cleanup;
> +        }
> +    }
> +
> +    /*
> +     * Contiguous pages of data with compatible flags are grouped together in
> +     * order to reduce the number of memory regions we create. Make sure the
> +     * last group is processed with this call.
> +     */
> +    retval = process_mem_page(&ctx, NULL, errp);
> +
> +cleanup:
> +    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
> +    {
> +        g_free(parameter->data);
> +        parameter->data = NULL;
> +    }
> +
> +    return retval;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


