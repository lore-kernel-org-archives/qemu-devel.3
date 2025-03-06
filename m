Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C5BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqERX-0000Vx-0c; Thu, 06 Mar 2025 11:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tqERP-0000SQ-Pz
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:51:27 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tqERO-0006SN-12
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741279882; x=1772815882;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=t5t5Nl/GCwwxsBlhYyIbhXilnqn1z2pq64UN4JmmvKs=;
 b=klUvz9vwnciou3qu7Lpcy2Pwd+iA/81rt3WjfFUbn7cRTjMV/AisVrRM
 1JwJh5xxhIDvia7GM4z5iqllAQZja6x53NVyGyanYo/qeD0TZSNG371Of
 mLkDW4Vmxyi+zJjjjkktsTX/8xxqXtGmgYt7fGDvUYqVZjah+/IXIPgoQ
 uj9sH2o6V3qei8TzFqHN7N2T2Yuj4iNeVaIWXNVkXFZ5lvJs/ZNeU1oIO
 NQEz/+1R09C9fSf+SPNRq+7M2nW0Y4k8F6nUdZ4oUhXldUnNQYmBEUbQZ
 7vo9QLEAS4XkdBwRS6d0qZQ98dR1qvzVzFkrW27ddb2FVX2AKERwI/Efz g==;
X-CSE-ConnectionGUID: WgBpjR6lQdiUz8Bmkn+w2A==
X-CSE-MsgGUID: IGNuupelQu+XTTCCWUjPow==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42437512"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="42437512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 08:51:13 -0800
X-CSE-ConnectionGUID: FqAaO7kKSX2E1FgjkyNM7A==
X-CSE-MsgGUID: JqrwuYLvTBmHnewNyznwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="123662659"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 08:51:11 -0800
Message-ID: <84abfe3b-babd-41de-b527-dc9644bcff4e@intel.com>
Date: Fri, 7 Mar 2025 00:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i386: Adjust CPUID_EXT_PDCM based on enable_pmu at
 realization
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Dongli Zhang <dongli.zhang@oracle.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
 <Z8nL0eLE/trEtlNd@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z8nL0eLE/trEtlNd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/7/2025 12:22 AM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
>> First, it's not a good practice that values in env->features[] cannot be
>> directly used for guest CPUID in void cpu_x86_cpuid(), but require further
>> adjustment there. env->features[] are supposed to be finalized at cpu
>> realization, so that after it env->features[] is reliable.
>>
>> Second, there is one dependency entry relates to CPUID_EXT_PDCM in
>> feature_dependencies[]. QEMU needs to get correct value of
>> CPUID_EXT_PDCM in env->features[] to ensure applying the dependencies
>> correctly.
> 
> I agree that this is a very good idea, especially since PDCM has a
> dependency entry.
> 
> "pmu" is totally a property rather than a feature bit, which makes the
> dependency relationships in the code complex. Therefore, I think it's
> worth having a series to clarify the dependencies of pmu as much as
> possible.
> 
> I remember Dapeng/Zide also have fixes for pmu dependencies, and if
> possible, I could help you combine this series with others' cleanups.

The reason I sent out this small series quickly is mainly for Dongli to 
as a reference.

In fact, there are mess on LBR enabling that it checks enable_pmu 
everytime with CPUID_7_0_EDX_ARCH_LBR as well as 
CPUID_8000_0022_EAX_PERFMON_V2. That's on my WIP list to clean it up.

I think I need to check if they are duplicated with Dapeng/Zide's series.

> Additionally, I think patch 1 and patch 2 can be merged together. Do you
> agree?

IMHO, they stand as their own. I'll leave it to Paolo to make the decision.

> Thanks,
> Zhao
> 


