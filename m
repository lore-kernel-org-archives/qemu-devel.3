Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CDDCF34B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjMf-0007Rr-0I; Wed, 19 Nov 2025 09:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjMa-0007Qp-Je
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:40:53 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjMY-0004jb-EQ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763563250; x=1795099250;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oMXwx0PydHtSpd9OnbK/M5rqZw9fBWu4Gfmy98aF95s=;
 b=JezuZ4wTNlHoyojaDX/E/otSU7CoKhSd3sEjyK8K0WM8J0ykNO4Zv6DG
 8HvzKfDivZrQ2IdgPC2WAqfuKPtMOfh7vushNbWgmsIlf2554ghTfn3QV
 Bb+4brHdcggBTjoRoni5N72rHArH/OEbJLguS7128QOzues8P1MjbppX3
 p0JtTtwTWVogKPDqIPBs0ukidHltk11hRru7fEvFfrG/AtgeeWTan5guJ
 uPILv0oarNyv9uakFOBPY2lIaQd0kWZhD9YZxI9znWCZfvWDzJZ4h7gW2
 OfGSxSK8+qUEP+CNL7eEYA2B1NUvd1V7KmyyImWSec3IrYpibet4yYnh7 A==;
X-CSE-ConnectionGUID: regF+nPsSjGumLbbSQTJBA==
X-CSE-MsgGUID: 3DENtuEVTj+6D29AHsZsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91081965"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="91081965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:40:45 -0800
X-CSE-ConnectionGUID: lOVDX7ElTTK195rQ2ehMVA==
X-CSE-MsgGUID: K15QOysqTc2nDwUc/xeoLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191322467"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.78])
 ([10.124.240.78])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:40:42 -0800
Message-ID: <82fd0bb7-c97e-49a6-9967-43f66bda035f@intel.com>
Date: Wed, 19 Nov 2025 22:40:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] kvm: Allow kvm_guest_memfd_supported for non-private
 use case
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-3-peterx@redhat.com>
 <9614d727-97bf-4a50-be13-6754952bec96@intel.com> <aRZI1O18HAHcxaFV@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aRZI1O18HAHcxaFV@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/14/2025 5:08 AM, Peter Xu wrote:
> On Fri, Oct 24, 2025 at 10:30:19AM +0800, Xiaoyao Li wrote:
>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>> index 68cd33ba9735..73f04eb589ef 100644
>> --- a/accel/stubs/kvm-stub.c
>> +++ b/accel/stubs/kvm-stub.c
>> @@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t
>> flags, Error **errp)
>>   {
>>       return -ENOSYS;
>>   }
>> +
>> +bool kvm_private_memory_attribute_supported(void)
>> +{
>> +    return false;
>> +}
> 
> Hmm, I found that your this patch seems newer than the one you pushed here:
> 
> https://github.com/intel-staging/qemu-tdx/tree/lxy/gmem-mmap-poc
> 
> Do you want to push it once more to make it latest?

I rebase it to the latest QMEU master:

https://github.com/intel-staging/qemu-tdx/tree/lxy/gmem-mmap-poc-v2

> Thanks,
> 


