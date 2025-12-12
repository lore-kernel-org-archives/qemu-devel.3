Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A47FD43369
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTtTn-0003lE-OF; Thu, 11 Dec 2025 22:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTtTi-0003l2-Gw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:05:59 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTtTc-0000lv-M0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765508753; x=1797044753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KlVrxqcN2Ic21PjrgOGw+h2S/28wowkFapC/8E5+XkM=;
 b=VuFH342nBGfZpoM0tuq3+WWyE/j9aUBzWBaBuiDUjQqLgB/CxmflcjiM
 zeo5Co2uxH2pjSuv406dufbyTBVERvyZXR5tSBQ/W3TLk239PsXue/pck
 2u10DmEDsKkH6Wdm8f+Fu7JgY7RKWvT76cRk3dzHk4QWPYDopzt3ZWsBI
 8qeX2pdJj/nwynFhnWjUj38Vf6p2Jd1wFYcEEZG4xvWxLa7/2TmWPkbbf
 FZjRu1W5ub7Ata/cZTxzEVvqspgROj5Z7IxdwhTDMkpHudfnGwtoibEud
 50+NMYKQPllwqMvFija4LWdvqSRJrhzqtTTStAutD5e5l4kpfM0XeqyHH w==;
X-CSE-ConnectionGUID: 8bmEqoBvT+27rQ5HEQJzJg==
X-CSE-MsgGUID: UOv1ARhuRbyeBJsClwXosg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90150529"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="90150529"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 19:05:50 -0800
X-CSE-ConnectionGUID: p/xr2oyPT0uVM6rR3r5L+g==
X-CSE-MsgGUID: mArN1l6mQgydfVNKgYfJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="197440740"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 19:05:48 -0800
Message-ID: <b9309d98-381b-4531-925c-a4558be1428a@intel.com>
Date: Fri, 12 Dec 2025 11:05:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-8-peterx@redhat.com>
 <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com> <aTrw6Xtg_GRh1DQO@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aTrw6Xtg_GRh1DQO@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
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

On 12/12/2025 12:27 AM, Peter Xu wrote:
> On Thu, Dec 11, 2025 at 03:41:46PM +0800, Xiaoyao Li wrote:
>> On 11/20/2025 1:29 AM, Peter Xu wrote:
>>> Host backends supports guest-memfd now by detecting whether it's a
>>> confidential VM.  There's no way to choose it yet from the memory level to
>>> use it in-place.  If we use guest-memfd, it so far always implies we need
>>> two layers of memory backends, while the guest-memfd only provides the
>>> private set of pages.
>>>
>>> This patch introduces a way so that QEMU can consume guest memfd as the
>>> only source of memory to back the object (aka, in place), rather than
>>> having another backend supporting the pages converted to shared.
>>>
>>> To use the in-place guest-memfd, one can add a memfd object with:
>>>
>>>     -object memory-backend-memfd,guest-memfd=on,share=on
>>>
>>> Note that share=on is required with in-place guest_memfd.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>
>> overall looks good to me except a few comments below,
>>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>>> ---
>>>    qapi/qom.json            |  6 +++-
>>>    backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 67 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 6f5c9de0f0..9ebf17bfc7 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -763,13 +763,17 @@
>>>    # @seal: if true, create a sealed-file, which will block further
>>>    #     resizing of the memory (default: true)
>>>    #
>>> +# @guest-memfd: if true, use guest-memfd to back the memory region.
>>> +#     (default: false, since: 11.0)
>>> +#
>>>    # Since: 2.12
>>>    ##
>>>    { 'struct': 'MemoryBackendMemfdProperties',
>>>      'base': 'MemoryBackendProperties',
>>>      'data': { '*hugetlb': 'bool',
>>>                '*hugetlbsize': 'size',
>>> -            '*seal': 'bool' },
>>> +            '*seal': 'bool',
>>> +            '*guest-memfd': 'bool' },
>>>      'if': 'CONFIG_LINUX' }
>>>    ##
>>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
>>> index ea93f034e4..1fa16c1e1d 100644
>>> --- a/backends/hostmem-memfd.c
>>> +++ b/backends/hostmem-memfd.c
>>> @@ -18,6 +18,8 @@
>>>    #include "qapi/error.h"
>>>    #include "qom/object.h"
>>>    #include "migration/cpr.h"
>>> +#include "system/kvm.h"
>>> +#include <linux/kvm.h>
>>>    OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
>>> @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
>>>        bool hugetlb;
>>>        uint64_t hugetlbsize;
>>>        bool seal;
>>> +    /*
>>> +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
>>> +     * which represents a internally private guest-memfd that only backs
>>> +     * private pages.  Instead, this flag marks the memory backend will
>>> +     * 100% use the guest-memfd pages in-place.
>>> +     */
>>> +    bool guest_memfd;
>>>    };
>>>    static bool
>>> @@ -47,10 +56,40 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>>            goto have_fd;
>>>        }
>>> -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>>> -                           m->hugetlb, m->hugetlbsize, m->seal ?
>>> -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
>>> -                           errp);
>>> +    if (m->guest_memfd) {
>>> +        /* User choose to use in-place guest-memfd to back the VM.. */
>>> +        if (!backend->share) {
>>> +            error_setg(errp, "In-place guest-memfd must be used with share=on");
>>> +            return false;
>>> +        }
>>> +
>>> +        /*
>>> +         * This is the request to have a guest-memfd to back private pages.
>>> +         * In-place guest-memfd doesn't work like that.  Disable it for now
>>
>> This seems not correct to me. I think in-place guest-memfd can work with
>> guest_memfd_private. The former serves as shared memory and referenced by
>> the userspace_addr while the latter serves as private memory referenced by
>> the fd of guest_memfd.
>>
>> While the argument of "disable it for now to make it simple" does make sense
>> to me.
> 
> Oops, I forgot to touch up quite a few places that kept mentioning
> in-place, sorry.
> 
> I'll squash this diff into this patch when repost:
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 1fa16c1e1d..e9e288651e 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -57,16 +57,16 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       }
>   
>       if (m->guest_memfd) {
> -        /* User choose to use in-place guest-memfd to back the VM.. */
> +        /* User choose to use fully shared guest-memfd to back the VM.. */
>           if (!backend->share) {
> -            error_setg(errp, "In-place guest-memfd must be used with share=on");
> +            error_setg(errp, "Guest-memfd=on must be used with share=on");

lower-case the guest-memfd? since it's the name of the property?

>               return false;
>           }
>   
>           /*
>            * This is the request to have a guest-memfd to back private pages.
> -         * In-place guest-memfd doesn't work like that.  Disable it for now
> -         * to make it simple, so that each memory backend can only have
> +         * Fully shared guest-memfd doesn't work like that.  Disable it for
> +         * now to make it simple, so that each memory backend can only have
>            * guest-memfd either as private, or fully shared.
>            */
>           if (backend->guest_memfd_private) {

After rethinking on it, I think we just remove the check. There is 
nothing from QEMU side to prevent such usage. It is KVM currently that 
doesn't support INIT_SHARED guest-memfd for confidential VMs.

If we change to KVM to allow it:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8bb8830561d4..a658b636a9cf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13957,7 +13957,8 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
   */
  bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
  {
-       return !kvm_arch_has_private_mem(kvm);
+       return true;
+

and remove this check in QEMU, it can actually boot a TDX guest with
fully-shared guest-memfd back'ed as shared part.

> I'll also fix the commit message on in-place, now the one to be reposted:
> 
>    hostmem: Support fully shared guest memfd to back a VM
>    
>    Host backends supports guest-memfd now by detecting whether it's a
>    confidential VM.  There's no way to choose it yet from the memory level to
>    use it fully shared.  If we use guest-memfd, it so far always implies we
>    need two layers of memory backends, while the guest-memfd only provides the
>    private set of pages.
>    
>    This patch introduces a way so that QEMU can consume guest memfd as the
>    only source of memory to back the object (aka, fully shared), rather than
>    having another backend supporting the pages converted to shared.

As above, I think what the patch achieves is to enable guest-memfd (with 
MMAP and INIT_SHARED) to back shared memory. And it is not conflicted 
with using another guest-memfd to back private memory.

>    To use the fully shared guest-memfd, one can add a memfd object with:
>    
>      -object memory-backend-memfd,guest-memfd=on,share=on
>    
>    Note that share=on is required with fully shared guest_memfd.
> 
> I'll not take your R-b as of now, please check and ack again if you see fit
> after reading.
> 
>>
>>> +         * to make it simple, so that each memory backend can only have
>>> +         * guest-memfd either as private, or fully shared.
>>> +         */
>>> +        if (backend->guest_memfd_private) {
>>> +            error_setg(errp, "In-place guest-memfd cannot be used with another "
>>> +                       "private guest-memfd");
>>> +            return false;
>>> +        }
>>
>> please add the following check as I commented in v1:
>>
>> 	if (!kvm_enabled()) {
>> 		error_setg(errp, "in-place guest-memfd requires KVM");
>> 		return false;
>> 	}
> 
> IMHO it's redundant to set here, when kvm not enabled,
> kvm_create_guest_memfd() should be a stub.

No. The KVM stub is for the case where KVM is disable at compile time.

The kvm_enabled() check here is for the case where users use different 
accelerators other than KVM, e.g., -accel tcg.

> However indeed I found the stub didn't set an error, so how about add one
> trivial patch to add a verbal error for it instead?
> 
> commit aeeaba6dfc68a1c89af90c12f36cb8fe48faecfd
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Dec 11 11:19:44 2025 -0500
> 
>      kvm/stub: Provide explicit error for kvm_create_guest_memfd()
>      
>      So that there will be a verbal string returned when kvm not enabled.
>      
>      Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   accel/stubs/kvm-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 73f04eb589..01b1d6285e 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
>   
>   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>   {
> +    error_setg(errp, "KVM is not enabled");
>       return -ENOSYS;
>   }
> 
> IIUC it'll achieve the same goal with better layering.
> 
>>
>>> +        /* TODO: add huge page support */
>>> +        fd = kvm_create_guest_memfd(backend->size,
>>> +                                    GUEST_MEMFD_FLAG_MMAP |
>>> +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
>>> +                                    errp);
>>> +        if (fd < 0) {
>>> +            return false;
>>> +        }
>>
>> how about just removing the fd check here because ...
> 
> We needed it because at least the stub returns -ENOSYS..
> 
> I can remove it, but I'll need to change below to "fd<0" check.  That I can
> do.

yeah, change to "fd < 0" looks better.

> Thanks,
> 
>>
>>> +    } else {
>>> +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>>> +                               m->hugetlb, m->hugetlbsize, m->seal ?
>>> +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
>>> +                               errp);
>>> +    }
>>> +
>>>        if (fd == -1) {
>>>            return false;
>>>        }
>>
>> ... the existing check can work for the guest memfd as well.
>>

