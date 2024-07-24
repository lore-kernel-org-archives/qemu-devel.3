Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A60C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 16:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWf9q-0008Hz-Uf; Wed, 24 Jul 2024 12:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWf9o-0008HH-3C
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 12:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWf9l-0000Dl-FQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 12:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721839679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qhkTJGtPwP8eNQpkONkMQaSkCkLhtQ9pwHosUujZJAQ=;
 b=TgtrYJeBg9ES6FOuKd6LBloQChCnSKWwk3sGccv751Ambg6ewvhI32mMHDibZ8DbWGcPWV
 K324I6HNBzRV7hmVK86p6XAjjDptXkmtEtc2I9hpu4Nj78MY5EnUobJrLB7wBYyvRU7Ltr
 0eAcqXzk9D57j9htDkk9fjcp7V9edfo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Hbu9VewjNkmEJ9QbE8eahQ-1; Wed,
 24 Jul 2024 12:47:55 -0400
X-MC-Unique: Hbu9VewjNkmEJ9QbE8eahQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ED191955F6A; Wed, 24 Jul 2024 16:47:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A8941955D42; Wed, 24 Jul 2024 16:47:41 +0000 (UTC)
Date: Wed, 24 Jul 2024 17:47:38 +0100
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
Subject: Re: [PATCH v4 02/17] backends/confidential-guest-support: Add
 functions to support IGVM
Message-ID: <ZqEwKsGFyHQZNFUn@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <c07dcfe9496a8682bf262bfa6caa180e0eefcce4.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c07dcfe9496a8682bf262bfa6caa180e0eefcce4.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

On Wed, Jul 03, 2024 at 12:05:40PM +0100, Roy Hopkins wrote:
> In preparation for supporting the processing of IGVM files to configure
> guests, this adds a set of functions to ConfidentialGuestSupport
> allowing configuration of secure virtual machines that can be
> implemented for each supported isolation platform type such as Intel TDX
> or AMD SEV-SNP. These functions will be called by IGVM processing code
> in subsequent patches.
> 
> This commit provides a default implementation of the functions that
> either perform no action or generate an error when they are called.
> Targets that support ConfidentalGuestSupport should override these
> implementations.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  include/exec/confidential-guest-support.h | 75 +++++++++++++++++++++++
>  backends/confidential-guest-support.c     | 31 ++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index 02dc4e518f..4834efbe38 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -21,6 +21,7 @@
>  #ifndef CONFIG_USER_ONLY
>  
>  #include "qom/object.h"
> +#include "exec/hwaddr.h"
>  
>  #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
>  OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
> @@ -28,6 +29,36 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
>                      CONFIDENTIAL_GUEST_SUPPORT)
>  
>  
> +typedef enum ConfidentialGuestPlatformType {
> +    CGS_PLATFORM_SEV,
> +    CGS_PLATFORM_SEV_ES,
> +    CGS_PLATFORM_SEV_SNP,
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
> @@ -66,6 +97,40 @@ typedef struct ConfidentialGuestSupportClass {
>  
>      int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
>      int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
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
> +                           ConfidentialGuestPageType memory_type,
> +                           uint16_t cpu_index, Error **errp);
> +
> +    /*
> +     * Iterate the system memory map, getting the entry with the given index
> +     * that can be populated into guest memory.
> +     *
> +     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
> +     */
> +    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
> +                             Error **errp);
>  } ConfidentialGuestSupportClass;
>  
>  static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
> @@ -94,6 +159,16 @@ static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
>      return 0;
>  }
>  
> +#define CONFIDENTIAL_GUEST_SUPPORT_CLASS(klass)                \
> +    OBJECT_CLASS_CHECK(ConfidentialGuestSupportClass, (klass), \
> +                       TYPE_CONFIDENTIAL_GUEST_SUPPORT)
> +#define CONFIDENTIAL_GUEST_SUPPORT(obj)           \
> +    OBJECT_CHECK(ConfidentialGuestSupport, (obj), \
> +                 TYPE_CONFIDENTIAL_GUEST_SUPPORT)
> +#define CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(obj)          \
> +    OBJECT_GET_CLASS(ConfidentialGuestSupportClass, (obj), \
> +                     TYPE_CONFIDENTIAL_GUEST_SUPPORT)

Are you sure these are needed ? Earlier in this header have

  OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
                      ConfidentialGuestSupportClass,
                      CONFIDENTIAL_GUEST_SUPPORT)

which calls DECLARE_INSTANCE_CHECKER and
DECLARE_CLASS_CHECKERS, which should define these
very same macros.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


