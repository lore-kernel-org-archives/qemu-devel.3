Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA9CCD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvJC-00027V-K0; Wed, 20 Mar 2024 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvJ9-00021b-PB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:44:39 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvJ8-0000Ac-43
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710938679; x=1742474679;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bFqvZxHKRsZyymilWY2dauLtOBypXV5U9yYI3vXV++k=;
 b=SUwREH0SAESmcXxqciWTJhuiqDN36lAbxqKqmbCuj7pO+wBouJSZa833
 YPqaHwvRd1W9sUMPy1x9GFPGLwzdszGV5tm+sgvYfKKrIO4SguqB+EkyK
 JBe2V21IgaWQdcLi2j3XjbxutpgY8a+aHEoOF+wAkhp0s3fA47YEkvurc
 M91qoncAZJzr4aXIX5QGPND2p7vKwszTCuSQ3DZPPB+Dv9/RPkwv3mFi/
 ETpfDWKuuf7UZCroJibLeZW+8Hmu+SUW1GbH/rIUbXUHpf10gc36IlzhJ
 ncro4syu0n/cHa1EQ+mrE9b1qFCJZYjjV0F3pak7YmyDYu8MfnIrBRQol A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5980176"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5980176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14119430"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:44:29 -0700
Message-ID: <a86deafd-a13b-4382-9012-f58431839e24@intel.com>
Date: Wed, 20 Mar 2024 20:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/65] kvm: Introduce support for memory_attributes
Content-Language: en-US
To: "Wang, Lei" <lei4.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-7-xiaoyao.li@intel.com>
 <5b4ba4d8-3e18-4feb-8cb6-f78d21da77f9@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <5b4ba4d8-3e18-4feb-8cb6-f78d21da77f9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/19/2024 10:03 AM, Wang, Lei wrote:
> On 2/29/2024 14:36, Xiaoyao Li wrote:> Introduce the helper functions to set the attributes of a range of
>> memory to private or shared.
>>
>> This is necessary to notify KVM the private/shared attribute of each gpa
>> range. KVM needs the information to decide the GPA needs to be mapped at
>> hva-based shared memory or guest_memfd based private memory.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v4:
>> - move the check of kvm_supported_memory_attributes to the common
>>    kvm_set_memory_attributes(); (Wang Wei)
>> - change warn_report() to error_report() in kvm_set_memory_attributes()
>>    and drop the __func__; (Daniel)
>> ---
>>   accel/kvm/kvm-all.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/sysemu/kvm.h |  3 +++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index cd0aa7545a1f..70d482a2c936 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -92,6 +92,7 @@ static bool kvm_has_guest_debug;
>>   static int kvm_sstep_flags;
>>   static bool kvm_immediate_exit;
>>   static bool kvm_guest_memfd_supported;
>> +static uint64_t kvm_supported_memory_attributes;
>>   static hwaddr kvm_max_slot_size = ~0;
>>   
>>   static const KVMCapabilityInfo kvm_required_capabilites[] = {
>> @@ -1304,6 +1305,46 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
>>       kvm_max_slot_size = max_slot_size;
>>   }
>>   
>> +static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
>> +{
>> +    struct kvm_memory_attributes attrs;
>> +    int r;
>> +
>> +    if (kvm_supported_memory_attributes == 0) {
>> +        error_report("No memory attribute supported by KVM\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if ((attr & kvm_supported_memory_attributes) != attr) {
>> +        error_report("memory attribute 0x%lx not supported by KVM,"
>> +                     " supported bits are 0x%lx\n",
>> +                     attr, kvm_supported_memory_attributes);
>> +        return -EINVAL;
>> +    }
>> +
>> +    attrs.attributes = attr;
>> +    attrs.address = start;
>> +    attrs.size = size;
>> +    attrs.flags = 0;
>> +
>> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
>> +    if (r) {
>> +        error_report("failed to set memory (0x%lx+%#zx) with attr 0x%lx error '%s'",
>> +                     start, size, attr, strerror(errno));
>> +    }
>> +    return r;
>> +}
>> +
>> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
>> +{
>> +    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +}
>> +
>> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
>> +{
>> +    return kvm_set_memory_attributes(start, size, 0);
>> +}
>> +
>>   /* Called with KVMMemoryListener.slots_lock held */
>>   static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>                                MemoryRegionSection *section, bool add)
>> @@ -2439,6 +2480,9 @@ static int kvm_init(MachineState *ms)
>>   
>>       kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
>>   
>> +    ret = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>> +    kvm_supported_memory_attributes = ret > 0 ? ret : 0;
> 
> kvm_check_extension() only returns non-negative value, so we can just
>
> kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);

Good catch, I will update it in next version.

>> +
>>       if (object_property_find(OBJECT(current_machine), "kvm-type")) {
>>           g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
>>                                                               "kvm-type",
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 6cdf82de8372..8e83adfbbd19 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -546,4 +546,7 @@ uint32_t kvm_dirty_ring_size(void);
>>   bool kvm_hwpoisoned_mem(void);
>>   
>>   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
>> +
>> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
>> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
>>   #endif


