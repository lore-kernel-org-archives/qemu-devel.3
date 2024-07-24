Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7EFC3DA7E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfLQ-00069T-Id; Wed, 24 Jul 2024 13:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfLN-00068f-CC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfLJ-0003PK-Rn
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721840395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PUoCIAyiFRUZ/YvAvHUgRxdQkR2aXhO3b2tT0XfQudE=;
 b=c50F0sMfjaA+LeyYrupTsWn80HE+z39/EXDokQFF+e0Bc9f+5HWAWqJccmdpBclDfvXSFl
 vKnWuB2rs8J7WAxbiVy9qsWK8U2s7v6v7ST9epPzEG+6iEX1FWFsWfNiIcaQ2UUH1x/xBY
 HdW0n1XXsiiahUrqZRfwHe/Li9GiJuo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-R_mPJnUQO-Cj9eU8RXPqfw-1; Wed,
 24 Jul 2024 12:59:49 -0400
X-MC-Unique: R_mPJnUQO-Cj9eU8RXPqfw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC151944B25; Wed, 24 Jul 2024 16:59:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1811B1955F40; Wed, 24 Jul 2024 16:59:36 +0000 (UTC)
Date: Wed, 24 Jul 2024 17:59:13 +0100
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
Subject: Re: [PATCH v4 03/17] backends/igvm: Add IGVM loader and configuration
Message-ID: <ZqEy4Q9hK7kCnva_@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <50a0ccaf47c0106daccfbb7ed8b7dc27ca45f8ff.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50a0ccaf47c0106daccfbb7ed8b7dc27ca45f8ff.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 03, 2024 at 12:05:41PM +0100, Roy Hopkins wrote:
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
>  qapi/qom.json             |  17 +
>  backends/igvm.h           |  23 ++
>  include/sysemu/igvm-cfg.h |  54 +++
>  backends/igvm-cfg.c       |  66 ++++
>  backends/igvm.c           | 799 ++++++++++++++++++++++++++++++++++++++
>  backends/meson.build      |   2 +
>  6 files changed, 961 insertions(+)
>  create mode 100644 backends/igvm.h
>  create mode 100644 include/sysemu/igvm-cfg.h
>  create mode 100644 backends/igvm-cfg.c
>  create mode 100644 backends/igvm.c
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..93b416e697 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -874,6 +874,19 @@
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
> +  'if': 'CONFIG_IGVM',
> +  'data': { '*file': 'str' } }

I feel like 'file' should be mandatory rather than optional.

It doesn't make sense to use "-object igvm-cfg" without any
filename, since you can simply omit creating the object
entirely in that case.

> +
>  ##
>  # @SevCommonProperties:
>  #
> @@ -1039,6 +1052,8 @@
>      'filter-redirector',
>      'filter-replay',
>      'filter-rewriter',
> +    { 'name': 'igvm-cfg',
> +      'if': 'CONFIG_IGVM' },
>      'input-barrier',
>      { 'name': 'input-linux',
>        'if': 'CONFIG_LINUX' },
> @@ -1111,6 +1126,8 @@
>        'filter-redirector':          'FilterRedirectorProperties',
>        'filter-replay':              'NetfilterProperties',
>        'filter-rewriter':            'FilterRewriterProperties',
> +      'igvm-cfg':                   { 'type': 'IgvmCfgProperties',
> +                                      'if': 'CONFIG_IGVM' },
>        'input-barrier':              'InputBarrierProperties',
>        'input-linux':                { 'type': 'InputLinuxProperties',
>                                        'if': 'CONFIG_LINUX' },

> diff --git a/include/sysemu/igvm-cfg.h b/include/sysemu/igvm-cfg.h
> new file mode 100644
> index 0000000000..8ac8b33d8d
> --- /dev/null
> +++ b/include/sysemu/igvm-cfg.h
> @@ -0,0 +1,54 @@
> +/*
> + * QEMU IGVM interface
> + *
> + * Copyright (C) 2024 SUSE
> + *
> + * Authors:
> + *  Roy Hopkins <roy.hopkins@suse.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_IGVM_CFG_H
> +#define QEMU_IGVM_CFG_H
> +
> +#include "qom/object.h"
> +
> +typedef struct IgvmCfgState {
> +    ObjectClass parent_class;
> +
> +    /*
> +     * filename: Filename that specifies a file that contains the configuration
> +     *           of the guest in Independent Guest Virtual Machine (IGVM)
> +     *           format.
> +     */
> +    char *filename;
> +} IgvmCfgState;
> +
> +typedef struct IgvmCfgClass {
> +    ObjectClass parent_class;
> +
> +    /*
> +     * If an IGVM filename has been specified then process the IGVM file.
> +     * Performs a no-op if no filename has been specified.
> +     *
> +     * Returns 0 for ok and -1 on error.
> +     */
> +    int (*process)(IgvmCfgState *cfg, ConfidentialGuestSupport *cgs,
> +                   Error **errp);
> +
> +} IgvmCfgClass;
> +
> +#define TYPE_IGVM_CFG "igvm-cfg"
> +
> +#define IGVM_CFG_CLASS_SUFFIX "-" TYPE_IGVM_CFG
> +#define IGVM_CFG_CLASS_NAME(a) (a IGVM_CFG_CLASS_SUFFIX)
> +
> +#define IGVM_CFG_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(IgvmCfgClass, (klass), TYPE_IGVM_CFG)
> +#define IGVM_CFG(obj) OBJECT_CHECK(IgvmCfgState, (obj), TYPE_IGVM_CFG)
> +#define IGVM_CFG_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(IgvmCfgClass, (obj), TYPE_IGVM_CFG)

Everything after 'TYPE_IGVM_CFG' can be replaced by OBJECT_DECLARE_TYPE()
I believe.

> +
> +#endif
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> new file mode 100644
> index 0000000000..5e18f3fd5f
> --- /dev/null
> +++ b/backends/igvm-cfg.c
> @@ -0,0 +1,66 @@
> +/*
> + * QEMU IGVM interface
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
> +#include "sysemu/igvm-cfg.h"
> +#include "igvm.h"
> +#include "qom/object_interfaces.h"
> +
> +static char *get_igvm(Object *obj, Error **errp)
> +{
> +    IgvmCfgState *igvm = IGVM_CFG(obj);
> +    return g_strdup(igvm->filename);
> +}
> +
> +static void set_igvm(Object *obj, const char *value, Error **errp)
> +{
> +    IgvmCfgState *igvm = IGVM_CFG(obj);
> +    g_free(igvm->filename);
> +    igvm->filename = g_strdup(value);
> +}
> +
> +static int igvm_process(IgvmCfgState *cfg, ConfidentialGuestSupport *cgs,
> +                        Error **errp)
> +{
> +    if (!cfg->filename) {
> +        return 0;
> +    }

If filename is made mandatory, then I think this check is
redundant.

> +    return igvm_process_file(cfg, cgs, errp);
> +}
> +
> +static void igvm_cfg_class_init(ObjectClass *oc, void *data)
> +{
> +    IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
> +
> +    object_class_property_add_str(oc, "file", get_igvm, set_igvm);
> +    object_class_property_set_description(oc, "file",
> +                                          "Set the IGVM filename to use");
> +
> +    igvmc->process = igvm_process;
> +}
> +
> +static const TypeInfo igvm_cfg_type = {
> +    .name = TYPE_IGVM_CFG,
> +    .parent = TYPE_OBJECT,
> +    .class_init = igvm_cfg_class_init,
> +    .class_size = sizeof(IgvmCfgClass),
> +    .instance_size = sizeof(IgvmCfgState),
> +    .interfaces = (InterfaceInfo[]){ { TYPE_USER_CREATABLE }, {} }
> +};
> +
> +static void igvm_cfg_type_init(void)
> +{
> +    type_register_static(&igvm_cfg_type);
> +}
>
> +type_init(igvm_cfg_type_init);

The boilerplate type definition can be replaced with the macro
OBJECT_DEFINE_TYPE-WITH_INTERFACES.

> diff --git a/backends/igvm.c b/backends/igvm.c
> new file mode 100644
> index 0000000000..97af1a6cb3
> --- /dev/null
> +++ b/backends/igvm.c
> @@ -0,0 +1,799 @@
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

I'd suggest that every single method in this file, even the
static ones, get an 'qigvm_' prefix, and all structs get
an QIGVM name prefix.  This will ensure we avoid any risk
of clashes with code from the igvm C headers, which will
all be using 'igvm' / 'IGVM' prefixes. Will also make it
clearer to the reader, which methods are from this file
vs igvm library.

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

Mild preference for doing   g_new0(MemoryRegion, 1);

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
> +}
> +


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


