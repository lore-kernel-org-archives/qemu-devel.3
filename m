Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3F3F532C6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 01:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4qmM-0005Fj-JY; Mon, 23 Mar 2026 21:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w4qmL-0005FR-Dl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 21:41:57 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w4qmJ-0000CL-Nw
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 21:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774316516; x=1805852516;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=4uYzw0wRWAXMPw2w2BODq+C0SO3JOe+prJS++LAEf3I=;
 b=Ce3Z87yOHR2UreJuuKmJqwUur3uvsS4CXXGXEnfCsfSXajahiiVYa9as
 kU9SdxUYxjYKrxJKTsSBuEDRug3PeMFfu+7r+IrkSlCYWfAcue7gdxn9c
 fjJ8V+LIXw1fCSKeF5TjKV6icdlVlGSGOPDps5p3XZ+vpjjsl6WqPuMlG
 5A+E46WfIs1xpqtc8z92ktMtWWvabhy9W1f9WshTUNQZRKST/PBTCv1Y1
 8t+IG2nC8CTl8ak9mtc5L5toqRReAapVIspXqEqVEyjeQiAgyr8fAhQ0N
 +Z+ARrbenX7PjEmyC56CEnLa2EcGeOzb8teg3ypf1R/WOM9mTrz8V3ss6 Q==;
X-CSE-ConnectionGUID: kzpAg5ZITaapy9DWweASgQ==
X-CSE-MsgGUID: HeKqiPGcTTClsK23XiqPfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75232671"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75232671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 18:41:54 -0700
X-CSE-ConnectionGUID: FKPil9sNQHCLOd3plzDHYg==
X-CSE-MsgGUID: tQxsydxuS/yTZ8vj+ZpD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219784743"
Received: from unknown (HELO [10.239.158.22]) ([10.239.158.22])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 18:41:53 -0700
Message-ID: <7c0b5249-8868-47cd-8581-fbf82cdc7472@intel.com>
Date: Tue, 24 Mar 2026 09:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 65/77] i386/tdx: Fetch and validate CPUID of TD guest
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-66-pbonzini@redhat.com>
 <758d7f2c-938f-49cb-89fc-980fc8e020b2@weilnetz.de>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <758d7f2c-938f-49cb-89fc-980fc8e020b2@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/23/2026 4:45 PM, Stefan Weil wrote:
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index e35983ad9bd..e474abf3a60 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -766,6 +766,106 @@ static uint32_t 
>> tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
>>       return value;
>>   }
>> +static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
>> +{
>> +    struct kvm_cpuid2 *fetch_cpuid;
>> +    int size = KVM_MAX_CPUID_ENTRIES;
>> +    Error *local_err = NULL;
>> +    int r;
>> +
>> +    do {
>> +        error_free(local_err);
>> +        local_err = NULL;
>> +
>> +        fetch_cpuid = g_malloc0(sizeof(*fetch_cpuid) +
>> +                                sizeof(struct kvm_cpuid_entry2) * size);
>> +        fetch_cpuid->nent = size;
>> +        r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, 
>> &local_err);
>> +        if (r == -E2BIG) {
>> +            g_free(fetch_cpuid);
>> +            size = fetch_cpuid->nent;
> 
> I don't understand this code, and CodeQL on GitHub reports a use after 
> free here (and I think it is right).

Thanks for your report!

I just sent a fix for it: 
https://lore.kernel.org/all/20260324012313.1580760-1-xiaoyao.li@intel.com/




