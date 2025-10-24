Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDgP-0008Ih-Fy; Fri, 24 Oct 2025 05:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vCDgK-0008IQ-Oy
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:01:58 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vCDgH-00007b-HQ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761296513; x=1792832513;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QrWx9HqYEJn9WQCVSkwS08uVEcYf2HjK2TjZa6plgVg=;
 b=Rx86SCJ7NKP1IesJi9+cNcxKR9/huytHhtnDNDncK4QYiBwL1qcKMBPi
 hza84CgQqjxWemyRifpfb3vKxxqCw8l/SBqT0BIGVa7MGtuK+eP2k3CIy
 BzRTEIRQWJ/o94etQCpByhQIXT0zDYYk4wNXMnxL4YO61DzqEb/RReXP/
 QFzXz55Gq7aiyAwy6l9erqnoZvZ7skQaEvujfN0gzz2Sr+w1edREFRzj3
 vPHThBBb1/3RnRueA7d/8MvObzNnBXEgqD0XkXjPloGfJpZZNHi0X0fqt
 xqakA8ahU7t8oCK1HY2C3cl/p5Z3ANMIndi9rnz6GGBexnMeFyok4/NSM Q==;
X-CSE-ConnectionGUID: EgFkJjJZR4Gdrr4QATYfFQ==
X-CSE-MsgGUID: wNWFFllnQiqLTTqOEuNxtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74148002"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="74148002"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:01:50 -0700
X-CSE-ConnectionGUID: O3GGm8H8T4uTPnhgBwIzzw==
X-CSE-MsgGUID: gIS9o2nYSuOifs+fhjzICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183609676"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:01:47 -0700
Message-ID: <fe713fb6-56db-4080-b03d-a0c36952ee22@intel.com>
Date: Fri, 24 Oct 2025 17:01:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] hostmem: Support in-place guest memfd to back a VM
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Chenyi Qiang <chenyi.qiang@intel.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-9-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251023185913.2923322-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/24/2025 2:59 AM, Peter Xu wrote:
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it in-place.  If we use guest-memfd, it so far always implies we need
> two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
> 
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, in place), rather than
> having another backend supporting the pages converted to shared.
> 
> To use the in-place guest-memfd, one can add a memfd object with:
> 
>    -object memory-backend-memfd,guest-memfd=on,share=on
> 
> Note that share=on is required with in-place guest_memfd.

First, I'm not sure "in-place" is the proper wording here. At first 
glance on the series, I thought it's something related to "in-place" 
page conversion. After reading a bit, I really that it is enabling guest 
memfd with mmap support to serve as normal memory backend.

Second, my POC implementation chose to implement a separate and specific 
memory-backend type "memory-backend-guest-memfd". Your approach to add 
an option of "guest-memfd" to memory-backend-memfd looks OK to me and it 
requires less code. But I think we need to explicitly error out to users 
when they set "guest_memfd" to on with unsupported properties 
configured, e.g., "hugetlb", "hugetlbsize", and "seal".

Third, the intended usage of gmem with mmap from KVM/kernel's 
perspective is userspace configures the meomry slot by passing the gmem 
fd to @guest_memfd and @guest_memfd of struct 
kvm_userspace_memory_region2 instead of passing the user address 
returned by mmap of the fd to @userspace_addr return mmap() as this 
patch does. Surely the usage of this path works. But when QEMU is going 
to support in-place conversion of gmem, we has to pass the @guest_memfd.
Well, this is no issue now and we can handle it in the future when needed.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/qom.json            |  6 +++-
>   backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 830cb2ffe7..6b090fe9a0 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -764,13 +764,17 @@
>   # @seal: if true, create a sealed-file, which will block further
>   #     resizing of the memory (default: true)
>   #
> +# @guest-memfd: if true, use guest-memfd to back the memory region.
> +#     (default: false, since: 10.2)
> +#
>   # Since: 2.12
>   ##
>   { 'struct': 'MemoryBackendMemfdProperties',
>     'base': 'MemoryBackendProperties',
>     'data': { '*hugetlb': 'bool',
>               '*hugetlbsize': 'size',
> -            '*seal': 'bool' },
> +            '*seal': 'bool',
> +            '*guest-memfd': 'bool' },
>     'if': 'CONFIG_LINUX' }
>   
>   ##
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index ea93f034e4..1fa16c1e1d 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -18,6 +18,8 @@
>   #include "qapi/error.h"
>   #include "qom/object.h"
>   #include "migration/cpr.h"
> +#include "system/kvm.h"
> +#include <linux/kvm.h>
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
>   
> @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
>       bool hugetlb;
>       uint64_t hugetlbsize;
>       bool seal;
> +    /*
> +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> +     * which represents a internally private guest-memfd that only backs
> +     * private pages.  Instead, this flag marks the memory backend will
> +     * 100% use the guest-memfd pages in-place.
> +     */
> +    bool guest_memfd;
>   };
>   
>   static bool
> @@ -47,10 +56,40 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>           goto have_fd;
>       }
>   
> -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> -                           m->hugetlb, m->hugetlbsize, m->seal ?
> -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> -                           errp);
> +    if (m->guest_memfd) {
> +        /* User choose to use in-place guest-memfd to back the VM.. */
> +        if (!backend->share) {
> +            error_setg(errp, "In-place guest-memfd must be used with share=on");
> +            return false;
> +        }
> +
> +        /*
> +         * This is the request to have a guest-memfd to back private pages.
> +         * In-place guest-memfd doesn't work like that.  Disable it for now
> +         * to make it simple, so that each memory backend can only have
> +         * guest-memfd either as private, or fully shared.
> +         */
> +        if (backend->guest_memfd_private) {
> +            error_setg(errp, "In-place guest-memfd cannot be used with another "
> +                       "private guest-memfd");
> +            return false;
> +        }

Add kvm_enabled() here, otherwise the following calling of 
kvm_create_guest_memfd() emits confusing information when accelerator is 
not configured as KVM, e.g., -machine q35,accel=tcg

qemu-system-x86: KVM does not support guest_memfd


> +        /* TODO: add huge page support */
> +        fd = kvm_create_guest_memfd(backend->size,
> +                                    GUEST_MEMFD_FLAG_MMAP |
> +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> +                                    errp);
> +        if (fd < 0) {
> +            return false;
> +        }
> +    } else {
> +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> +                               m->hugetlb, m->hugetlbsize, m->seal ?
> +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> +                               errp);
> +    }
> +
>       if (fd == -1) {
>           return false;
>       }
> @@ -65,6 +104,18 @@ have_fd:
>                                             backend->size, ram_flags, fd, 0, errp);
>   }
>   
> +static bool
> +memfd_backend_get_guest_memfd(Object *o, Error **errp)
> +{
> +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
> +}
> +
> +static void
> +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
> +{
> +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
> +}
> +
>   static bool
>   memfd_backend_get_hugetlb(Object *o, Error **errp)
>   {
> @@ -152,6 +203,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>           object_class_property_set_description(oc, "hugetlbsize",
>                                                 "Huge pages size (ex: 2M, 1G)");
>       }
> +
> +    object_class_property_add_bool(oc, "guest-memfd",
> +                                   memfd_backend_get_guest_memfd,
> +                                   memfd_backend_set_guest_memfd);
> +    object_class_property_set_description(oc, "guest-memfd",
> +                                          "Use guest memfd");
> +
>       object_class_property_add_bool(oc, "seal",
>                                      memfd_backend_get_seal,
>                                      memfd_backend_set_seal);


