Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5657FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 05:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDFit-00028E-64; Mon, 27 Oct 2025 01:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDFip-000285-Lh
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:24:47 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDFim-0007CO-MV
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761542685; x=1793078685;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=L1X57Rt5+mnDOtwmB7rC39R4LN2kkY5jfQ+6PNSHpjc=;
 b=eY7Cue8sEt1ayfTQ/nqhnPBWfx0NP7cANdn4D/JPhtRcx9is7AF/YpQ4
 fIDMnSWJ6KsFTcst2ByCWI0ET0KGxrdlQW5HwMedMw9G6e6TJBsvHiY2B
 Oys4vrQHrhL9XEuQQz59Nt01D/hU3jU4KDcPk63loneWfiP+JDRazqOHS
 Sn79RqeSOFaDF+tNFlfVku8uBRuaDWSYXYz5r/4UNxufVINKLFOvosaHV
 fiwINtOjJzNsCXCI4twSxhaTGQ2Jb5ys3t9xVAIpyAnOf0iPA3LX18wSq
 sd4HbZbGl3NgwoPO4RK0/acuEDd+N/A9cnmoYuvxs16Sa+GRvvpfAQmfY Q==;
X-CSE-ConnectionGUID: 4dYOIDaqR1eozT5enb+5bg==
X-CSE-MsgGUID: 9LwSdWFVRY+78pLu5BPcjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81043187"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="81043187"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:24:31 -0700
X-CSE-ConnectionGUID: N8elalFfQG+RL46FZYZVaw==
X-CSE-MsgGUID: Vv1prR8gRnKkaLuvKF3ICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184563772"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:24:28 -0700
Message-ID: <ebb35318-5c02-469a-82bd-dc278cd583e9@intel.com>
Date: Mon, 27 Oct 2025 13:24:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] hostmem: Support in-place guest memfd to back a VM
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-9-peterx@redhat.com>
 <fe713fb6-56db-4080-b03d-a0c36952ee22@intel.com> <aPuZuf_S-gvOf_7J@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aPuZuf_S-gvOf_7J@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.57, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/24/2025 11:22 PM, Peter Xu wrote:
> On Fri, Oct 24, 2025 at 05:01:44PM +0800, Xiaoyao Li wrote:
>> On 10/24/2025 2:59 AM, Peter Xu wrote:
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
>>
>> First, I'm not sure "in-place" is the proper wording here. At first glance
>> on the series, I thought it's something related to "in-place" page
>> conversion. After reading a bit, I really that it is enabling guest memfd
>> with mmap support to serve as normal memory backend.
> 
> It'll be only proper in current context of qemu, but yes I'm aware CoCo
> also has such idea, so at least I should have come up with something
> better. My bad.  When I wrote the patches a while ago it wasn't as clear,
> and I didn't pay attention when I prepare them upstream.
> 
>>
>> Second, my POC implementation chose to implement a separate and specific
>> memory-backend type "memory-backend-guest-memfd". Your approach to add an
>> option of "guest-memfd" to memory-backend-memfd looks OK to me and it
>> requires less code. But I think we need to explicitly error out to users
>> when they set "guest_memfd" to on with unsupported properties configured,
>> e.g., "hugetlb", "hugetlbsize", and "seal".
> 
> In my local tree I actually reused hugetlb* parameters, that needs
> Ackerley's 1G kernel patches, and some mine on top.
> 
> Before I go and reply your other series..  I was definitely not aware that
> anyone has been working on it!  Could you share a pointer?  Or is it still
> in a private branch?

I shared it publicly when reviwed and tested KVM series: 
https://lore.kernel.org/all/13654746-3edc-4e4a-ac4f-fa281b83b2ae@intel.com/

The poc branch:

   https://github.com/intel-staging/qemu-tdx.git lxy/gmem-mmap-poc

It was based on the old QEMU and based on old kernel API of v6.18-rc1 
(the API changes on -rc2).

> I'm more than happy to drop this series if you have an older / better
> version.  Then I can rebase whatever I work on top.

I was not authorized to do the QEMU upstream of gmem mmap support inside 
the company. So please keep your series and I'm happy to help review it 
and make it upstreamed.

>>
>> Third, the intended usage of gmem with mmap from KVM/kernel's perspective is
>> userspace configures the meomry slot by passing the gmem fd to @guest_memfd
>> and @guest_memfd of struct kvm_userspace_memory_region2 instead of passing
>> the user address returned by mmap of the fd to @userspace_addr return mmap()
>> as this patch does. Surely the usage of this path works. But when QEMU is
>> going to support in-place conversion of gmem, we has to pass the
>> @guest_memfd.
>> Well, this is no issue now and we can handle it in the future when needed.
> 
> Yes, that's something the private guest-memfd would need.  For completely
> shared guest-memfd, IIUC we will use a lot of different code paths, the
> goal is to make old APIs work not only for KVM_SET_USER_MEMORY_REGION, but
> for all the rest modules like vhost-kernel, vhost-user, and so on.

And if pass the @guest_memfd, we will need to handle the issue of 
aliased: https://lore.kernel.org/all/aH-0MdNJbH19Mhm3@google.com/

>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    qapi/qom.json            |  6 +++-
>>>    backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 67 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 830cb2ffe7..6b090fe9a0 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -764,13 +764,17 @@
>>>    # @seal: if true, create a sealed-file, which will block further
>>>    #     resizing of the memory (default: true)
>>>    #
>>> +# @guest-memfd: if true, use guest-memfd to back the memory region.
>>> +#     (default: false, since: 10.2)
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
>>> +         * to make it simple, so that each memory backend can only have
>>> +         * guest-memfd either as private, or fully shared.
>>> +         */
>>> +        if (backend->guest_memfd_private) {
>>> +            error_setg(errp, "In-place guest-memfd cannot be used with another "
>>> +                       "private guest-memfd");
>>> +            return false;
>>> +        }
>>
>> Add kvm_enabled() here, otherwise the following calling of
>> kvm_create_guest_memfd() emits confusing information when accelerator is not
>> configured as KVM, e.g., -machine q35,accel=tcg
>>
>> qemu-system-x86: KVM does not support guest_memfd
>>
>>
>>> +        /* TODO: add huge page support */
>>> +        fd = kvm_create_guest_memfd(backend->size,
>>> +                                    GUEST_MEMFD_FLAG_MMAP |
>>> +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
>>> +                                    errp);
>>> +        if (fd < 0) {
>>> +            return false;
>>> +        }
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
>>> @@ -65,6 +104,18 @@ have_fd:
>>>                                              backend->size, ram_flags, fd, 0, errp);
>>>    }
>>> +static bool
>>> +memfd_backend_get_guest_memfd(Object *o, Error **errp)
>>> +{
>>> +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
>>> +}
>>> +
>>> +static void
>>> +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
>>> +{
>>> +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
>>> +}
>>> +
>>>    static bool
>>>    memfd_backend_get_hugetlb(Object *o, Error **errp)
>>>    {
>>> @@ -152,6 +203,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>>>            object_class_property_set_description(oc, "hugetlbsize",
>>>                                                  "Huge pages size (ex: 2M, 1G)");
>>>        }
>>> +
>>> +    object_class_property_add_bool(oc, "guest-memfd",
>>> +                                   memfd_backend_get_guest_memfd,
>>> +                                   memfd_backend_set_guest_memfd);
>>> +    object_class_property_set_description(oc, "guest-memfd",
>>> +                                          "Use guest memfd");
>>> +
>>>        object_class_property_add_bool(oc, "seal",
>>>                                       memfd_backend_get_seal,
>>>                                       memfd_backend_set_seal);
>>
> 


