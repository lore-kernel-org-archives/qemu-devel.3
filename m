Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F47C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqmj-0001Lf-Hm; Tue, 25 Feb 2025 03:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmqmg-0001LO-Cr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:59:22 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmqmd-0000mU-TO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740473960; x=1772009960;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3hFp0w9TkaXMLYZrzh0OCU8rpuvN6ak09O3UKp4MH3E=;
 b=Y+MU5QMQnsXS0UKMApFQIisqTlv+hXkjhNzoLWMOf2EpQgydviJEaSjd
 0Twv5AqfGGKnLXaXgJ64IbgmTCm+pNkY+tmiTqp/bfslBbRAcAiy+0uM9
 jSIm7Mkqd6KAobI9ewrQaTbV3XN2PykvqV4Igp+DXegNs2+5yMjS+JC5f
 ebFy2IkNdtCYuf2YR6DtkOyAb8+QrQZvjgOCQoZVPY3rPQua07qiRDpMB
 Ig9QlboXOjUI1kC95lfsXMj5w54qyS9gNn7PQGl0qJrk3ayZAReMoyRPl
 diF0hhbL73WZePKBVc7tG9sPCfQR10TbdEeuSEvrd4V6z04fiaqG9m0Gv w==;
X-CSE-ConnectionGUID: 1yCf7ESFRx2U3ryiwSYhjA==
X-CSE-MsgGUID: AdgfiGs5SSOYtdQo+xKcXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41524936"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="41524936"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:59:17 -0800
X-CSE-ConnectionGUID: e/mlfnbsQxaOc6uYbdXHhQ==
X-CSE-MsgGUID: vrgv+H7RS5GI+jCCUnlI3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116181922"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:59:12 -0800
Message-ID: <f4549022-8304-4838-9482-aa19769f8c19@intel.com>
Date: Tue, 25 Feb 2025 16:59:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/52] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: armbru@redhat.com, berrange@redhat.com, chenhuacai@kernel.org,
 eblake@redhat.com, imammedo@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 mtosatti@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-devel@nongnu.org, rick.p.edgecombe@intel.com,
 zhao1.liu@intel.com
References: <08bf7f3061459af5f05fabf0d3796b77d8034587.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <08bf7f3061459af5f05fabf0d3796b77d8034587.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On 2/19/2025 3:21 AM, Francesco Lavra wrote:
> On Fri, 24 Jan 2025 08:20:01 -0500, Xiaoyao Li wrote:
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 4ff94860815d..bd212abab865 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -10,17 +10,122 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>>   
>>   #include "hw/i386/x86.h"
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +static struct kvm_tdx_capabilities *tdx_caps;
> 
> Instead of a static variable, this should be a member of the TdxGuest
> struct.

I don't think so.

tdx_caps is reported from KVM, which indicates what XFAM/Attributes and 
configurable CPUID bits that can be configured for a TD under the KVM.

It's not the specific properties of the TD.

So I would keep it as it.

