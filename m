Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CCCC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5th-00011U-Nx; Fri, 01 Mar 2024 11:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg5te-00010A-Ii
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg5tb-0005Uq-Aw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709311081;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KxN9MjuotYhe0BLdZwH5sJ0H0O1jVrASjfSEj6nnoWM=;
 b=OpEg0Ou8Xp1fuD5LOe58v6LafVQxYTwyS4uTFhXJtYnWkXuPLg3Jdz+0noP/JTGPZxzCYm
 poaXXKe63TQ6L/yu7HKDZLywHzceRZx9avzcQ5DdDGPIzBKQHOZjj/j2uHsZPZB6t2qV9v
 O635ug+BJX64rppkkapr/TzBS0cOjU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-GV9OeDfENPmG7INPekCXiw-1; Fri, 01 Mar 2024 11:37:57 -0500
X-MC-Unique: GV9OeDfENPmG7INPekCXiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DBB7862F7D;
 Fri,  1 Mar 2024 16:37:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C66E6492BE2;
 Fri,  1 Mar 2024 16:37:53 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:37:51 +0000
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
Subject: Re: [PATCH 3/9] backends/confidential-guest-support: Add functions
 to support IGVM
Message-ID: <ZeIEX8v7828JcXte@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <0d5af28ab63f6e4e4089b8b5a11b9fc9c941986f.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d5af28ab63f6e4e4089b8b5a11b9fc9c941986f.1709044754.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Tue, Feb 27, 2024 at 02:50:09PM +0000, Roy Hopkins wrote:
> In preparation for supporting the processing of IGVM files to configure
> guests, this adds a set of functions to ConfidentialGuestSupport
> allowing configuration of secure virtual machines that can be
> implemented for each supported isolation platform type such as Intel TDX
> or AMD SEV-SNP. These functions will be called by IGVM processing code
> in subsequent patches.
> 
> This commit provides a default implementation of the functions that
> either perform no action or generate a warning or error when they are
> called. Targets that support ConfidentalGuestSupport should override
> these implementations.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  backends/confidential-guest-support.c     | 26 ++++++++
>  include/exec/confidential-guest-support.h | 76 +++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index da436fb736..42628be8d7 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  
>  #include "exec/confidential-guest-support.h"
> +#include "qemu/error-report.h"
>  
>  OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                              confidential_guest_support,
> @@ -45,8 +46,33 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
>  #endif
>  }
>  
> +static int check_support(ConfidentialGuestPlatformType platform,
> +                         uint16_t platform_version, uint8_t highest_vtl,
> +                         uint64_t shared_gpa_boundary)
> +{
> +    /* Default: no support. */
> +    return 0;
> +}
> +
> +static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> +                                 ConfidentialGuestPageType memory_type,
> +                                 uint16_t cpu_index)
> +{
> +    warn_report("Confidential guest memory not supported");
> +    return -1;
> +}
> +
> +static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry)
> +{
> +    return 1;
> +}

IIUC, all these can reports errors, and as such I think
they should have an 'Error **errp' parameter, so we can
report precise errors in these methods, rather than
less useful generic errors in the caller.

The above 'warn_report' ought to be an error too, since
it is returning an failure code (-1)

> +
>  static void confidential_guest_support_init(Object *obj)
>  {
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +    cgs->check_support = check_support;
> +    cgs->set_guest_state = set_guest_state;
> +    cgs->get_mem_map_entry = get_mem_map_entry;
>  }
>  
>  static void confidential_guest_support_finalize(Object *obj)
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index b08ad8de4d..c43a1a32f1 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -21,10 +21,46 @@
>  #ifndef CONFIG_USER_ONLY
>  
>  #include "qom/object.h"
> +#include "exec/hwaddr.h"
> +
> +#if defined(CONFIG_IGVM)
> +#include "igvm/igvm.h"
> +#endif
>  
>  #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
>  OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
>  
> +typedef enum ConfidentialGuestPlatformType {
> +    CGS_PLATFORM_SEV,
> +    CGS_PLATFORM_SEV_ES,
> +    CGS_PLATFORM_SEV_SNP,
> +    CGS_PLATFORM_TDX,

QEMU only has support for SEV & SEV_ES today. We should leave the
others until we actually get an impl of SEV-SNP/TDX in QEMU that
supports those platforms.

> +} ConfidentialGuestPlatformType;
> +
> +typedef enum ConfidentialGuestMemoryType {
> +    CGS_MEM_RAM,
> +    CGS_MEM_RESERVED,
> +    CGS_MEM_ACPI,
> +    CGS_MEM_NVS,
> +    CGS_MEM_UNUSABLE,
> +} ConfidentialGuestMemoryType;
> +
> +typedef struct ConfidentialGuestMemoryMapEntry {
> +    uint64_t gpa;
> +    uint64_t size;
> +    ConfidentialGuestMemoryType type;
> +} ConfidentialGuestMemoryMapEntry;
> +
> +typedef enum ConfidentialGuestPageType {
> +    CGS_PAGE_TYPE_NORMAL,
> +    CGS_PAGE_TYPE_VMSA,
> +    CGS_PAGE_TYPE_ZERO,
> +    CGS_PAGE_TYPE_UNMEASURED,
> +    CGS_PAGE_TYPE_SECRETS,
> +    CGS_PAGE_TYPE_CPUID,
> +    CGS_PAGE_TYPE_REQUIRED_MEMORY,
> +} ConfidentialGuestPageType;
> +
>  struct ConfidentialGuestSupport {
>      Object parent;
>  
> @@ -60,6 +96,46 @@ struct ConfidentialGuestSupport {
>       */
>      char *igvm_filename;
>  #endif
> +
> +    /*
> +     * The following virtual methods need to be implemented by systems that
> +     * support confidential guests that can be configured with IGVM and are
> +     * used during processing of the IGVM file with process_igvm().
> +     */
> +
> +    /*
> +     * Check for to see if this confidential guest supports a particular
> +     * platform or configuration
> +     */
> +    int (*check_support)(ConfidentialGuestPlatformType platform,
> +                         uint16_t platform_version, uint8_t highest_vtl,
> +                         uint64_t shared_gpa_boundary);
> +
> +    /*
> +     * Configure part of the state of a guest for a particular set of data, page
> +     * type and gpa. This can be used for example to pre-populate and measure
> +     * guest memory contents, define private ranges or set the initial CPU state
> +     * for one or more CPUs.
> +     *
> +     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
> +     * context for a virtual CPU. The format of the data depends on the type of
> +     * confidential virtual machine. For example, for SEV-ES ptr will point to a
> +     * vmcb_save_area structure that should be copied into guest memory at the
> +     * address specified in gpa. The cpu_index parameter contains the index of
> +     * the CPU the VMSA applies to.
> +     */
> +    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
> +                                 ConfidentialGuestPageType memory_type,
> +                                 uint16_t cpu_index);
> +
> +    /*
> +     * Iterate the system memory map, getting the entry with the given index
> +     * that can be populated into guest memory.
> +     *
> +     * Returns 1 if the index is out of range.
> +     */
> +    int (*get_mem_map_entry)(int index,
> +                              ConfidentialGuestMemoryMapEntry *entry);
>  };
>  
>  typedef struct ConfidentialGuestSupportClass {
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


