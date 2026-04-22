Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C702DFA1FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFejO-0007x4-Mp; Wed, 22 Apr 2026 17:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wFejM-0007vq-3k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:03:32 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wFejK-0006yA-59
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776891810; x=1808427810;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CjXMm9O9HgEbazVGNENiF7rUYZhQt66j+C1SKcZ9yJc=;
 b=QiP2QhRQ7KixKnLg9Xs1v60cVlmbB6ER6cG05YGZb8D01GnueJ0IMqF/
 GDLvmFs6/9CCNLfqXKgzRsH+306OagC+kvLil1WTO8S56XvagRRdIdPrW
 ZErtihH+yPEMWdgYRxVsGq57VUlf/dcx8V4jsN7+aDfRm3RofQeFDP+Yx
 3ELj/khhtNAbPJk+frqp/JM7CDMFtJ6YCC+mrGoOkjmiG7Bo0SMaHg12D
 w2uqAsA+6MCVyuBbBti5vYRDHDmPw41cSKpodVU6ktu2oiskwwWKdsCnS
 fjM4F5xyr2UG1+HNcfkov7Q9MkzvwkPIPeLA5WyIClbKzLC88QgBFTTU8 A==;
X-CSE-ConnectionGUID: iRwHB2AYQ06ISQKARqL63w==
X-CSE-MsgGUID: 9EAAhmJJTAWuovuAyj2hyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77917717"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="77917717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 14:03:27 -0700
X-CSE-ConnectionGUID: JFHHzxPrScKv5+EVEyoQHg==
X-CSE-MsgGUID: Yl6Xr6X/SAOmXBMsJdwUmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="228120888"
Received: from unknown (HELO [10.241.241.111]) ([10.241.241.111])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 14:03:26 -0700
Message-ID: <be9cf7a9-4793-4bd4-b91e-cc9e0b6696a4@intel.com>
Date: Wed, 22 Apr 2026 14:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-12-zide.chen@intel.com> <aeiE9ZZ5AE+uMgmN@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aeiE9ZZ5AE+uMgmN@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 4/22/2026 1:21 AM, Zhao Liu wrote:
> Hi Zide,
> 
> On Wed, Mar 04, 2026 at 10:07:10AM -0800, Zide Chen wrote:
>> Date: Wed, 4 Mar 2026 10:07:10 -0800
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
>> X-Mailer: git-send-email 2.53.0
>>
>> Similar to lbr-fmt, target/i386 does not support multi-bit CPU
>> properties, so the PEBS record format cannot be exposed as a
>> user-visible CPU feature.
>>
>> Add a pebs-fmt option to allow users to specify the PEBS format via the
>> command line.  Since the PEBS state is part of the vmstate, this option
>> is considered migratable.
>>
>> We do not support PEBS record format 0.  Although it is a valid format
>> on some very old CPUs, it is unlikely to be used in practice.  This
>> allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
>> migratable=off.
>>
>> If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
>> clear the PEBS-related bits in IA32_PERF_CAPABILITIES.
>>
>> If migratable=on on PEBS capable host and pmu is enabled:
>> - PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
>> - PEBS is enabled if pebs-fmt is set to the same value as the host.
>>
>> When migratable=off, the behavior is similar, except that omitting
>> the pebs-fmt option does not disable PEBS.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> ...
> 
>>      if (user_req != -1) {
>> +        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
>> +            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);
>> +            return false;
>> +        }
>> +
> 
> This is a general code path to check user_req != -1... but
> 
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index 1d0047d037c7..60bf3899852a 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>      }
>>  
>>      cpu->lbr_fmt = -1;
>> +    cpu->pebs_fmt = -1;
> 
> -1 is only set for KVM, so other accelerators have lbr_fmt=0 by default.
> 
> This will cause make check fail:
> 
> stderr:
> qemu-system-x86_64: vPMU: pebs is unsupported without Debug Store
> Broken pipe
> ../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> 
> (test program exited with status code -6)
> 
> So I think the initialization should be placed in the general code path
> as well (x86_cpu_initfn()) - and move lbr_fmt initialization back to
> general x86 codes.

Yes, the related changes in patch 9/13 should be reverted.

> 
> Thanks,
> Zhao
> 


