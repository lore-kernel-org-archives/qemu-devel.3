Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BCCD35E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8VMO-0001CQ-G5; Tue, 05 Nov 2024 21:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8VMH-0001Bs-UT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:01:22 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8VMF-00010D-EA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730858479; x=1762394479;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OCdsTvS2i4OgPF2aSQUzB0Sr7iZca5HzkvtLjQfKFAA=;
 b=SHS5qSlpLhgmHso5fBsQn+VCjEvEi+GZnrdwq7/en6Ua0c2+TikvZVKR
 MdPs+eLvVAWutST7S1I8iolRdIkHwnmVofUQCZRqMMMPYNXnP58WtdUhx
 2gwVL14ygSU8Fehy+8t75TJwG1UVnyeNqjgL9dRxJO5th4x6x88J66euK
 3lpq+HlNV2JffG3NN51yGb00CItw5solYJl1vvukHyn5dtMCY3dpa9Qri
 wO7YihtFgKtc/j9C12a9kyR8zIFcRJkRGkvAxpz+RYhekR/SKR44e3ns4
 jYiFEstAYpdLxQIe3i4ad6CuWPWzXS2wLQBTf2CCUDgMx1vCcXdwdCw6s A==;
X-CSE-ConnectionGUID: LIqruzyVSM2fyoUJ8sEu3w==
X-CSE-MsgGUID: ZYDvcjMaQOyTR7PQCeGaxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34564878"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="34564878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:01:12 -0800
X-CSE-ConnectionGUID: 8hAthuPTRTeD8o14Dc9J/Q==
X-CSE-MsgGUID: oSaLmyWZRhyhjp8Sy642cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="84213238"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:01:07 -0800
Message-ID: <c0ef6c19-756e-43f3-8342-66b032238265@intel.com>
Date: Wed, 6 Nov 2024 10:01:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/6/2024 4:51 AM, Edgecombe, Rick P wrote:
> +Tony
> 
> On Tue, 2024-11-05 at 01:23 -0500, Xiaoyao Li wrote:
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    X86CPU *x86cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86cpu->env;
>> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>> +    int r = 0;
>> +
>> +    QEMU_LOCK_GUARD(&tdx_guest->lock);
>> +    if (tdx_guest->initialized) {
>> +        return r;
>> +    }
>> +
>> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>> +
>> +    r = setup_td_xfam(x86cpu, errp);
>> +    if (r) {
>> +        return r;
>> +    }
>> +
>> +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
>> +    tdx_filter_cpuid(&init_vm->cpuid);
>> +
>> +    init_vm->attributes = tdx_guest->attributes;
>> +    init_vm->xfam = tdx_guest->xfam;
>> +
>> +    do {
>> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
>> +    } while (r == -EAGAIN);
> 
> KVM_TDX_INIT_VM can also return EBUSY. This should check for it, or KVM should
> standardize on one for both conditions. In KVM, both cases handle
> TDX_RND_NO_ENTROPY, but one tries to save some of the initialization for the
> next attempt. I don't know why userspace would need to differentiate between the
> two cases though, which makes me think we should just change the KVM side.

I remember I tested retrying on the two cases and no surprise showed.

I agree to change KVM side to return -EAGAIN for the two cases.

>> +    if (r < 0) {
>> +        error_setg_errno(errp, -r, "KVM_TDX_INIT_VM failed");
>> +        return r;
>> +    }
>> +
>> +    tdx_guest->initialized = true;
>> +
>> +    return 0;
>> +}
> 


