Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3DCE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3cn-00088E-3y; Tue, 07 Jan 2025 02:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3cP-0007wH-VR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:03:14 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3cN-0004zO-0s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736233391; x=1767769391;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p7jd2YJglQZEF/n7cYU/XBni6ira8+uSNT520OdyVM4=;
 b=PFU/JC8+vve/ur2XWLFv7z8WfYOkbtMtu2lmEbbSASmTVTdIcWbZOjVO
 187L7JnqCcMQj+tcaB4CYe5MRH2oXEucTcQTVw9eIK28YEho9QJowbZBi
 i5XZkjiA6ZGAgGeE6O70dIEZPD4XQHDJzmKrsRyIrO4C6o2/gha1D13YD
 k31PIF+jfXhiaxgSiQ8413hwY0a63SH8tza7KI4P9vaug6Xw21MFsqW1c
 9YsT/kkBjDiXwKjNLh9BMeFYNF24XkT22DABk9ITnbcrg9fRZZTyX5+im
 s0mOkWLxfw9/zUoFXU8Q3gf3jMZkYj+skwCBoc1wGMmV3R9UAzQn+Uwai g==;
X-CSE-ConnectionGUID: 66UW83y5Thm4svrUYYDQog==
X-CSE-MsgGUID: cG6vB8PWSQCacK4TPwKYdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40172134"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="40172134"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:03:06 -0800
X-CSE-ConnectionGUID: cKw0qahtRoK4x2Xu3ETOOA==
X-CSE-MsgGUID: CvKENtPiQ+u+XoL4x7D0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="102570702"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:03:03 -0800
Message-ID: <16703283-6f1e-412d-a362-5331ed32d28a@intel.com>
Date: Tue, 7 Jan 2025 15:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT
 against threads_per_core
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-8-xiaoyao.li@intel.com> <Z25gSWzeVNLqIAPc@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z25gSWzeVNLqIAPc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/27/2024 4:07 PM, Zhao Liu wrote:
> On Thu, Dec 19, 2024 at 06:01:22AM -0500, Xiaoyao Li wrote:
>> Date: Thu, 19 Dec 2024 06:01:22 -0500
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH v2 07/10] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT
>>   against threads_per_core
>> X-Mailer: git-send-email 2.34.1
>>
>> Now it changes to use env->topo_info.threads_per_core and doesn't depend
>> on qemu_init_vcpu() anymore. Drop the comment of the order dependency on
>> qemu_init_vcpu() and hoist code to put it together with other feature
>> checking.
> 
> The comment was dropped in patch 6. You could move such description to
> there.

Obviously, I didn't take care of the patch split and reorder.

I tent to move the dropping of the comment from patch 6 to this one.

>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index d41768648ab9..fd59da5d445d 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -7880,6 +7880,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>        */
>>       cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
>>   
>> +    /*
>> +     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
>> +     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
>> +     * based on inputs (sockets,cores,threads), it is still better to give
>> +     * users a warning.
>> +     */
>> +    if (IS_AMD_CPU(env) &&
>> +        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
>> +        env->nr_threads > 1) {
> 
> Typo, env->topo_info.threads_per_core.

Thanks for catching it.

>> +            warn_report_once("This family of AMD CPU doesn't support "
>> +                             "hyperthreading(%d). Please configure -smp "
>> +                             "options properly or try enabling topoext "
>> +                             "feature.", env->nr_threads);
>> +    }
>> +
>>       /* For 64bit systems think about the number of physical bits to present.
>>        * ideally this should be the same as the host; anything other than matching
>>        * the host can cause incorrect guest behaviour.


