Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFF2C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCuPl-0000SK-JE; Thu, 08 May 2025 02:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCuPj-0000Lz-Lz
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:07:23 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCuPh-00074S-Cn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746684441; x=1778220441;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Qte4g6HU1cpPKEtHY+ftF7OvqZ8I3aqZV10Jxir+zgU=;
 b=HOwtT++hXObADB+7V/eWGakQsiGxPlm9HeCDXH8q9vzMatOM1695If08
 fJfl3vnNFFF06na7emmZ5NnkHXRsYVeCrIfNFSFeC9RxVACyJo8oVlttT
 ZHKxZwg0tjYRjG27eM+9CFuWGgK44gyV7xx6kZXgcSFZIgVMh27rPGKdw
 gCASBO8kObodd0lK8qXDGXE9EwKPg7C2biR1CRVUhncuNlJwfrJXduTqz
 KfMTVA4YMN8ZjN6E/pmHp0fNw3jcTV8pkesAPdEzDAA4AGExd0sZpoT7f
 Rg1KtF4bjPAeRAZvs8j6b+x6pDaf4OJ3TPzFZ3KTnaYIri946mXLvV8mj Q==;
X-CSE-ConnectionGUID: 9cdiLe4BRxe5LnshzrBc2Q==
X-CSE-MsgGUID: eUadjvACS9mCbsSUpMVRKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48558979"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="48558979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:07:16 -0700
X-CSE-ConnectionGUID: wbfLIoGyT8GpDo1ah0Bz2A==
X-CSE-MsgGUID: GMO6LJV0QkiJfsi9KQyYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="135890112"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:07:13 -0700
Message-ID: <f50ae307-4e64-45c5-8971-1331eabe2b99@intel.com>
Date: Thu, 8 May 2025 14:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-29-xiaoyao.li@intel.com> <aA+YKOdDq+62U2dR@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aA+YKOdDq+62U2dR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/28/2025 11:00 PM, Zhao Liu wrote:
> On Tue, Apr 01, 2025 at 09:01:38AM -0400, Xiaoyao Li wrote:
>> Date: Tue,  1 Apr 2025 09:01:38 -0400
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH v8 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
>> X-Mailer: git-send-email 2.34.1
>>
>> TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request
>> termination. KVM translates such request into KVM_EXIT_SYSTEM_EVENT with
>> type of KVM_SYSTEM_EVENT_TDX_FATAL.
>>
>> Add hanlder for such exit. Parse and print the error message, and
>> terminate the TD guest in the handler.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v8:
>>   - update to the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL;
>>
>> Changes in v6:
>>   - replace the patch " i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>"
>>     in v5;
>> ---
>>   target/i386/kvm/kvm.c      | 10 +++++++++
>>   target/i386/kvm/tdx-stub.c |  5 +++++
>>   target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h      |  2 ++
>>   4 files changed, 62 insertions(+)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 7de5014051eb..a76f34537908 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -6128,6 +6128,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>       case KVM_EXIT_HYPERCALL:
>>           ret = kvm_handle_hypercall(run);
>>           break;
>> +    case KVM_EXIT_SYSTEM_EVENT:
>> +        switch (run->system_event.type) {
>> +        case KVM_SYSTEM_EVENT_TDX_FATAL:
>> +            ret = tdx_handle_report_fatal_error(cpu, run);
>> +            break;
>> +        default:
>> +            ret = -1;
>> +            break;
>> +        }
>> +        break;
>>       default:
>>           fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>>           ret = -1;
>> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
>> index 7748b6d0a446..720a4ff046ee 100644
>> --- a/target/i386/kvm/tdx-stub.c
>> +++ b/target/i386/kvm/tdx-stub.c
>> @@ -13,3 +13,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
>>   {
>>       return -EINVAL;
>>   }
>> +
>> +int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>> +{
>> +    return -EINVAL;
>> +}
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index f8953f598584..74b7e3ac85fe 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -607,6 +607,51 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
>>       return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
>>   }
>>   
>> +int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>> +{
>> +    uint64_t error_code = run->system_event.data[R_R12];
>> +    uint64_t reg_mask = run->system_event.data[R_ECX];
>> +    char *message = NULL;
>> +    uint64_t *tmp;
>> +
>> +    if (error_code & 0xffff) {
>> +        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
>> +                     error_code);
>> +        return -1;
>> +    }
>> +
>> +/*
>> + * Only 8 registers can contain valid ASCII byte stream to form the fatal
>> + * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
>> + */
>> +#define TDX_FATAL_MESSAGE_MAX        64
> 
> At least, for this macro, and TDX_REPORT_FATAL_ERROR_GPA_VALID in later
> patch, could we move these simple macro definitions out of the function?
> 
> This could improve the readability for this one function.

To me, it's common that put the one-off MACRO right before the line it 
is used.

Anyway, it's not a big deal to move them out of the function. So I will 
move them for your preference.

>> +    if (reg_mask) {
>> +        message = g_malloc0(TDX_FATAL_MESSAGE_MAX + 1);
>> +        tmp = (uint64_t *)message;
>> +
>> +#define COPY_REG(REG)                               \
>> +    do {                                            \
>> +        if (reg_mask & BIT_ULL(REG)) {              \
>> +            *(tmp++) = run->system_event.data[REG]; \
>> +        }                                           \
>> +    } while (0)
>> +
>> +        COPY_REG(R_R14);
>> +        COPY_REG(R_R15);
>> +        COPY_REG(R_EBX);
>> +        COPY_REG(R_EDI);
>> +        COPY_REG(R_ESI);
>> +        COPY_REG(R_R8);
>> +        COPY_REG(R_R9);
>> +        COPY_REG(R_EDX);
>> +        *((char *)tmp) = '\0';
>> +    }
>> +#undef COPY_REG
>> +
>> +    error_report("TD guest reports fatal error. %s", message ? : "");
>> +    return -1;
>> +}
>> +
> 
> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


