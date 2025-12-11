Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC876D3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbJI-0006gV-6p; Thu, 11 Dec 2025 02:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTbJH-0006gN-66
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:41:59 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTbJD-00030w-UN
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765438916; x=1796974916;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=liDSYEWH2JMtVhdcHmh1S1iCdt1517yBqTIzuK1X0Sg=;
 b=KAxNbGV04PZjH1gzQi47Dm8mmniv+mYHTlA+CqZ/N41fX+IIuKvlg3P8
 X+KsDBN7EiT5bA6xU2JwYEs6Px8vAUB6+yToEL1wfozFwaVo83WzuLU/Y
 AsMWvIdoiXvu2c5oKRK3yPaSrpkhMGjJY8PW5cMK3HVqEphsvgt9VREjk
 wQlF0hZ1Aj16RADfpilC2XpGZDqmwgXzwmOmOKEWC1i6mmzjPW6+2FlIi
 EXtwcNLNB/5pCzNFYf8Hg+JBjpZrJzjbWxiXf9A1qRbkzoaetbGU3AQLI
 2Pv7avWl+qpCC3zHHdjZ8YQpsIdB0Mnz0Rqe2vaBNExusW8vyGwA1PRLH Q==;
X-CSE-ConnectionGUID: l2bjTM+ARs6qh1PvPvWOxg==
X-CSE-MsgGUID: y3/GQMtPSOebwhacSiVJrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67146927"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67146927"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:41:52 -0800
X-CSE-ConnectionGUID: iWVdL7j1QmyPwkveTn5Vow==
X-CSE-MsgGUID: 6thQOz/VTneh5VMJAfuk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="220083738"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:41:49 -0800
Message-ID: <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com>
Date: Thu, 11 Dec 2025 15:41:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-8-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251119172913.577392-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/20/2025 1:29 AM, Peter Xu wrote:
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
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

overall looks good to me except a few comments below,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   qapi/qom.json            |  6 +++-
>   backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6f5c9de0f0..9ebf17bfc7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -763,13 +763,17 @@
>   # @seal: if true, create a sealed-file, which will block further
>   #     resizing of the memory (default: true)
>   #
> +# @guest-memfd: if true, use guest-memfd to back the memory region.
> +#     (default: false, since: 11.0)
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

This seems not correct to me. I think in-place guest-memfd can work with 
guest_memfd_private. The former serves as shared memory and referenced 
by the userspace_addr while the latter serves as private memory 
referenced by the fd of guest_memfd.

While the argument of "disable it for now to make it simple" does make 
sense to me.

> +         * to make it simple, so that each memory backend can only have
> +         * guest-memfd either as private, or fully shared.
> +         */
> +        if (backend->guest_memfd_private) {
> +            error_setg(errp, "In-place guest-memfd cannot be used with another "
> +                       "private guest-memfd");
> +            return false;
> +        }

please add the following check as I commented in v1:

	if (!kvm_enabled()) {
		error_setg(errp, "in-place guest-memfd requires KVM");
		return false;
	}

> +        /* TODO: add huge page support */
> +        fd = kvm_create_guest_memfd(backend->size,
> +                                    GUEST_MEMFD_FLAG_MMAP |
> +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> +                                    errp);
> +        if (fd < 0) {
> +            return false;
> +        }

how about just removing the fd check here because ...

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

... the existing check can work for the guest memfd as well.

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


