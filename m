Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CACEB26EA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprT2-0007BI-56; Tue, 10 Feb 2026 12:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vprSw-0007B3-KR
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:24:00 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vprSq-00041X-EV
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770744232; x=1802280232;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=goQbTHbpJj/X7aRUqTZ29ddKOvBKXh/hEw47UFBBOts=;
 b=OC96HpH0CqXdllnktTjX3tpeXrkkwrPTraFGZdUNnxrUWvQJbyGx2gYA
 T5ChO5YkYQj2o9W4AlOxJJEh/7liSGVLM57e5qaEARyCqLUkYrwwcUhvd
 pLfxMO93d+OqPM/8p/8svXzz0weMDJDeRU/zZ4zMsNqBE2vLjUeXs8v3T
 tgnoiQuGNgvX+w2UX7s5oPoYhBfyleB5BLpQc24SxOEmli44y6XpFpuAC
 L0mP+na0b7bbP/4u/BCWzz/A2fLgaNpPa/1TIyIDypvHh0koUjLY704A0
 2RZLKZedxRxOQD6rW7M0nq/r3yv6Zal/76NoTrQ8Ikhxzk3qn1Dqk+1Bj A==;
X-CSE-ConnectionGUID: p7UIn8t9SkyHG7k5ItoK1Q==
X-CSE-MsgGUID: zBJawwu4RxG5psdtXfjoNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89470857"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89470857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:23:47 -0800
X-CSE-ConnectionGUID: PNdXXQYqTtmZtHFZAqdHbA==
X-CSE-MsgGUID: Gs7PhWrXTUup3WZXwgCJ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="234954590"
Received: from unknown (HELO [10.241.241.84]) ([10.241.241.84])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:23:47 -0800
Message-ID: <0d15e49d-3f92-4c0d-a574-3884930bf6f3@intel.com>
Date: Tue, 10 Feb 2026 09:23:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/11] target/i386: Increase MSR_BUF_SIZE and split
 KVM_[GET/SET]_MSRS calls
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-6-zide.chen@intel.com>
 <9ac55e27-7667-4b4a-a4bc-b0bdafdbb3b1@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <9ac55e27-7667-4b4a-a4bc-b0bdafdbb3b1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/9/2026 10:57 PM, Mi, Dapeng wrote:
> 
> On 1/29/2026 7:09 AM, Zide Chen wrote:
>> Newer Intel server CPUs support a large number of PMU MSRs.  Currently,
>> QEMU allocates cpu->kvm_msr_buf as a single-page buffer, which is not
>> sufficient to hold all possible MSRs.
>>
>> Increase MSR_BUF_SIZE to 8192 bytes, providing space for up to 511 MSRs.
>> This is sufficient even for the theoretical worst case, such as
>> architectural LBR with a depth of 64.
>>
>> KVM_[GET/SET]_MSRS is limited to 255 MSRs per call.  Raising this limit
>> to 511 would require changes in KVM and would introduce backward
>> compatibility issues.  Instead, split requests into multiple
>> KVM_[GET/SET]_MSRS calls when the number of MSRs exceeds the API limit.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2:
>> - No changes.
>>
>>  target/i386/kvm/kvm.c | 109 +++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 92 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 530f50e4b218..a2cf9b5df35d 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -98,9 +98,12 @@
>>  #define KVM_APIC_BUS_CYCLE_NS       1
>>  #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
>>  
>> -/* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
>> - * 255 kvm_msr_entry structs */
>> -#define MSR_BUF_SIZE 4096
>> +/* A 8192-byte buffer can hold the 8-byte kvm_msrs header, plus
>> + * 511 kvm_msr_entry structs */
>> +#define MSR_BUF_SIZE      8192
>> +
>> +/* Maximum number of MSRs in one single KVM_[GET/SET]_MSRS call. */
>> +#define KVM_MAX_IO_MSRS   255
>>  
>>  typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
>>  typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
>> @@ -3878,23 +3881,102 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
>>      }
>>  }
>>  
>> -static int kvm_buf_set_msrs(X86CPU *cpu)
>> +static int __kvm_buf_set_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
>>  {
>> -    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
>> +    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, msrs);
>>      if (ret < 0) {
>>          return ret;
>>      }
>>  
>> -    if (ret < cpu->kvm_msr_buf->nmsrs) {
>> -        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
>> +    if (ret < msrs->nmsrs) {
>> +        struct kvm_msr_entry *e = &msrs->entries[ret];
>>          error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
>>                       (uint32_t)e->index, (uint64_t)e->data);
>>      }
>>  
>> -    assert(ret == cpu->kvm_msr_buf->nmsrs);
>> +    assert(ret == msrs->nmsrs);
>> +    return ret;
>> +}
>> +
>> +static int __kvm_buf_get_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
>> +{
>> +    int ret;
>> +
>> +    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, msrs);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (ret < msrs->nmsrs) {
>> +        struct kvm_msr_entry *e = &msrs->entries[ret];
>> +        error_report("error: failed to get MSR 0x%" PRIx32,
>> +                     (uint32_t)e->index);
>> +    }
>> +
>> +    assert(ret == msrs->nmsrs);
>> +    return ret;
>> +}
>> +
>> +static int kvm_buf_set_or_get_msrs(X86CPU *cpu, bool is_write)
>> +{
>> +    struct kvm_msr_entry *entries = cpu->kvm_msr_buf->entries;
>> +    struct kvm_msrs *buf = NULL;
>> +    int current, remaining, ret = 0;
>> +    size_t buf_size;
>> +
>> +    buf_size = KVM_MAX_IO_MSRS * sizeof(struct kvm_msr_entry) +
>> +               sizeof(struct kvm_msrs);
>> +    buf = g_malloc(buf_size);
>> +
>> +    remaining = cpu->kvm_msr_buf->nmsrs;
>> +    current = 0;
>> +    while (remaining) {
>> +        size_t size;
>> +
>> +        memset(buf, 0, buf_size);
>> +
>> +        if (remaining > KVM_MAX_IO_MSRS) {
>> +            buf->nmsrs = KVM_MAX_IO_MSRS;
>> +        } else {
>> +            buf->nmsrs = remaining;
>> +        }
>> +
>> +        size = buf->nmsrs * sizeof(entries[0]);
>> +        memcpy(buf->entries, &entries[current], size);
>> +
>> +        if (is_write) {
>> +            ret = __kvm_buf_set_msrs(cpu, buf);
>> +        } else {
>> +            ret = __kvm_buf_get_msrs(cpu, buf);
>> +        }
>> +
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +
>> +        if (!is_write)
>> +            memcpy(&entries[current], buf->entries, size);
>> +
>> +        current += buf->nmsrs;
>> +        remaining -= buf->nmsrs;
>> +    }
>> +
>> +out:
>> +    g_free(buf);
>> +    return ret < 0 ? ret : cpu->kvm_msr_buf->nmsrs;
>> +}
>> +
>> +static int kvm_buf_set_msrs(X86CPU *cpu)
> 
> Better add inline.

Yes, thanks.

> 
> 
>> +{
>> +    kvm_buf_set_or_get_msrs(cpu, true);
>>      return 0;
> 
> why not directly return the return value of kvm_buf_set_or_get_msrs().

Yes, agreed.

> 
>>  }
>>  
>> +static int kvm_buf_get_msrs(X86CPU *cpu)
> 
> inline.

Yes, thanks.

> 
> Others look good to me.

