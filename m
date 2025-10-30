Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE5CCCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENPW-0001WK-G4; Thu, 30 Oct 2025 03:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vENPV-0001W8-80
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:49:29 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vENPP-0007bI-C7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761810564; x=1793346564;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Szu2ncxMiLUlf2GC40cy5q3sz58bfwptORK6njewzRU=;
 b=eoUamih4ykdvyOTEeOVQO+64Z5vq7UoBO4zoUMujGOw7txCqj6P8xnA0
 buZleYKZibMSMslUYX/vn61mO0mI3Yu3J36W0UESv2XYNnCMTGRZhsEvr
 CTZPo+S80JEFZXCIFUeP7nDZqofMcmMiGH+T6U9FwklbLpR1lPLZ4i2Oa
 GDCXZKQQ+U34Cp8QJwyLCvECMsxGWrEg7kaE69OQgcIthibgJm05y3yU/
 qnWx/9t8Ixci7M115VNJhr9WNYzg8nMGg+2mjg0jU3PU7WaQvmObzBURz
 3Gpfli9YXTulQUVLvX2I/Ty/xAhTxLqkeCxA75didiTrwF4PC/ju/SMVX A==;
X-CSE-ConnectionGUID: UE9H2jqPTdidU4fsn9ZlLQ==
X-CSE-MsgGUID: phbzVRdtRlGI7Wc9sQ8NUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81362249"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="81362249"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 00:49:19 -0700
X-CSE-ConnectionGUID: KuQIGK/5T3+oDMkahxPEOg==
X-CSE-MsgGUID: ++c518b/QRSQW8mdS44mXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="191051792"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 00:49:17 -0700
Message-ID: <57d3c5b2-8b07-41ee-bf41-a9eac16eb6da@intel.com>
Date: Thu, 30 Oct 2025 15:49:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/18] i386/kvm/cpu: Init SMM cpu address space for
 hotplugged CPUs
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-3-pbonzini@redhat.com>
 <fc683f6e-9d03-4e7d-bcd2-638c53daed7d@tls.msk.ru>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <fc683f6e-9d03-4e7d-bcd2-638c53daed7d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.576, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/30/2025 3:36 PM, Michael Tokarev wrote:
> On 10/28/25 20:34, Paolo Bonzini wrote:
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> The SMM cpu address space is initialized in a machine_init_done
>> notifier. It only runs once when QEMU starts up, which leads to the
>> issue that for any hotplugged CPU after the machine is ready, SMM
>> cpu address space doesn't get initialized.
>>
>> Fix the issue by initializing the SMM cpu address space in x86_cpu_plug()
>> when the cpu is hotplugged.
>>
>> Fixes: 591f817d819f ("target/i386: Define enum X86ASIdx for x86's 
>> address spaces")
> 
> How this commit can be fixing 591f817d819f, while technically
> 591f817d819f is a no-op, - it changed 0s and 1s in a few places
> to symbolic names with the same 0s and 1s.
> 
> It seems the "Fixes" commit should be something else.
> The way it is now, it's confusing.

It should be

   0516f4b70264 ("i386/cpu: Enable SMM cpu address space under KVM")

Sorry for my carelessness. Is there a way to remedy as the patch has 
been merged into the master?

> Thanks,
> 
> /mjt
> 


