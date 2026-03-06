Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204AEF513ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLZH-0005Hh-Dw; Thu, 05 Mar 2026 22:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLZG-0005HY-Na
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:09:34 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLZE-0001Hd-Mm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772766571; x=1804302571;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LYj3xVqXBi2J7Efjkcv9Cxc9JLd6L4uoKCTZQxPc7dU=;
 b=YiQCOrsg8hiUKcTrNyOYxofvJgBn/ZzCnXf7DlotzwgaJxBpgdmne6y6
 uJdBFs6Sxn5LvEnjjICo7iCWtEn5neUheKqEZylAbpIrGbhoWsdWZ7xv1
 EznQSOcFoEug84ZCbgZv0IV/asjevybhJ1X5JqIj589vN7jYexLQcYOn6
 LqroYFro7BZHcX0tv8c9Imj2enck99g/6ceXlqnP4YHDNyOP3XsCXc04r
 8QmaRyYSKOfLxWWrPoUHYX7f3dAx+XJyjWLwtWI572JKyWaZeW/dL4n+t
 aoYpMoHxAvkY03yJAdrarHcz4laxA37sBIKQyP8/HH+86vA2kRBPDUAVV w==;
X-CSE-ConnectionGUID: /kBaIq8yTz+i9CvZRxONrQ==
X-CSE-MsgGUID: UZZxHOccS7y9+dSPCNb7fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84955009"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84955009"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:09:27 -0800
X-CSE-ConnectionGUID: wZHDxNX4SF6XZRTor3gUtg==
X-CSE-MsgGUID: WB5o8Q1mTZ6+FiAh9AjHlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="219016666"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:09:25 -0800
Message-ID: <198db4f2-4aec-4930-97bf-ed0c3418083e@linux.intel.com>
Date: Fri, 6 Mar 2026 11:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/13] target/i386: Increase MSR_BUF_SIZE and split
 KVM_[GET/SET]_MSRS calls
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 3/5/2026 2:07 AM, Zide Chen wrote:
> Newer Intel server CPUs support a large number of PMU MSRs.  Currently,
> QEMU allocates cpu->kvm_msr_buf as a single-page buffer, which is not
> sufficient to hold all possible MSRs.
>
> Increase MSR_BUF_SIZE to 8192 bytes, providing space for up to 511 MSRs.
> This is sufficient even for the theoretical worst case, such as
> architectural LBR with a depth of 64.
>
> KVM_[GET/SET]_MSRS is limited to 255 MSRs per call.  Raising this limit
> to 511 would require changes in KVM and would introduce backward
> compatibility issues.  Instead, split requests into multiple
> KVM_[GET/SET]_MSRS calls when the number of MSRs exceeds the API limit.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - Address Dapeng's comments.
> ---
>  target/i386/kvm/kvm.c | 110 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 18 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 39a67c58ac22..4ba54151320f 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -97,9 +97,12 @@
>  #define KVM_APIC_BUS_CYCLE_NS       1
>  #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
>  
> -/* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
> - * 255 kvm_msr_entry structs */
> -#define MSR_BUF_SIZE 4096
> +/* A 8192-byte buffer can hold the 8-byte kvm_msrs header, plus
> + * 511 kvm_msr_entry structs */
> +#define MSR_BUF_SIZE      8192
> +
> +/* Maximum number of MSRs in one single KVM_[GET/SET]_MSRS call. */
> +#define KVM_MAX_IO_MSRS   255
>  
>  typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
>  typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
> @@ -4016,21 +4019,99 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
>      }
>  }
>  
> -static int kvm_buf_set_msrs(X86CPU *cpu)
> +static int __kvm_buf_set_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
>  {
> -    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
> +    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, msrs);
>      if (ret < 0) {
>          return ret;
>      }
>  
> -    if (ret < cpu->kvm_msr_buf->nmsrs) {
> -        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
> +    if (ret < msrs->nmsrs) {
> +        struct kvm_msr_entry *e = &msrs->entries[ret];
>          error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
>                       (uint32_t)e->index, (uint64_t)e->data);
>      }
>  
> -    assert(ret == cpu->kvm_msr_buf->nmsrs);
> -    return 0;
> +    assert(ret == msrs->nmsrs);
> +    return ret;
> +}
> +
> +static int __kvm_buf_get_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
> +{
> +    int ret;
> +
> +    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, msrs);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (ret < msrs->nmsrs) {
> +        struct kvm_msr_entry *e = &msrs->entries[ret];
> +        error_report("error: failed to get MSR 0x%" PRIx32,
> +                     (uint32_t)e->index);
> +    }
> +
> +    assert(ret == msrs->nmsrs);
> +    return ret;
> +}
> +
> +static int kvm_buf_set_or_get_msrs(X86CPU *cpu, bool is_write)
> +{
> +    struct kvm_msr_entry *entries = cpu->kvm_msr_buf->entries;
> +    struct kvm_msrs *buf = NULL;
> +    int current, remaining, ret = 0;
> +    size_t buf_size;
> +
> +    buf_size = KVM_MAX_IO_MSRS * sizeof(struct kvm_msr_entry) +
> +               sizeof(struct kvm_msrs);
> +    buf = g_malloc(buf_size);
> +
> +    remaining = cpu->kvm_msr_buf->nmsrs;
> +    current = 0;
> +    while (remaining) {
> +        size_t size;
> +
> +        memset(buf, 0, buf_size);
> +
> +        if (remaining > KVM_MAX_IO_MSRS) {
> +            buf->nmsrs = KVM_MAX_IO_MSRS;
> +        } else {
> +            buf->nmsrs = remaining;
> +        }
> +
> +        size = buf->nmsrs * sizeof(entries[0]);
> +        memcpy(buf->entries, &entries[current], size);
> +
> +        if (is_write) {
> +            ret = __kvm_buf_set_msrs(cpu, buf);
> +        } else {
> +            ret = __kvm_buf_get_msrs(cpu, buf);
> +        }
> +
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        if (!is_write)
> +            memcpy(&entries[current], buf->entries, size);
> +
> +        current += buf->nmsrs;
> +        remaining -= buf->nmsrs;
> +    }
> +
> +out:
> +    g_free(buf);
> +    return ret < 0 ? ret : cpu->kvm_msr_buf->nmsrs;
> +}
> +
> +static inline int kvm_buf_set_msrs(X86CPU *cpu)
> +{
> +    return kvm_buf_set_or_get_msrs(cpu, true);
> +}
> +
> +static inline int kvm_buf_get_msrs(X86CPU *cpu)
> +{
> +    return kvm_buf_set_or_get_msrs(cpu, false);
>  }
>  
>  static void kvm_init_msrs(X86CPU *cpu)
> @@ -4066,7 +4147,7 @@ static void kvm_init_msrs(X86CPU *cpu)
>      if (has_msr_ucode_rev) {
>          kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
>      }
> -    assert(kvm_buf_set_msrs(cpu) == 0);
> +    kvm_buf_set_msrs(cpu);
>  }
>  
>  static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
> @@ -4959,18 +5040,11 @@ static int kvm_get_msrs(X86CPU *cpu)
>          }
>      }
>  
> -    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
> +    ret = kvm_buf_get_msrs(cpu);
>      if (ret < 0) {
>          return ret;
>      }
>  
> -    if (ret < cpu->kvm_msr_buf->nmsrs) {
> -        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
> -        error_report("error: failed to get MSR 0x%" PRIx32,
> -                     (uint32_t)e->index);
> -    }
> -
> -    assert(ret == cpu->kvm_msr_buf->nmsrs);
>      /*
>       * MTRR masks: Each mask consists of 5 parts
>       * a  10..0: must be zero

