Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8BC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXcNP-00030a-Jl; Wed, 07 Feb 2024 02:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXcNK-00030C-K1; Wed, 07 Feb 2024 02:29:42 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXcNH-0005J7-N7; Wed, 07 Feb 2024 02:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707290979; x=1738826979;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=R6i7FzqJCnCBtJzO+03UpWfVgEb5vjz0+B9CDvFCyQE=;
 b=fJe6n9kZ+e6eazmC43Hzsgw7NN3Tmwn56LDICBxcfs6DMJYrG0+3nESr
 p6NxvREcAKUIdpe9fcrryMGvD9vj0SwLU4iIkdkM7IqoMX+XMbabQ1AZI
 Xe03fD+ZFa29l+avYwJ2eVRA5FBtiyfw8sx8ElZ9+lodPea73pSt3uCTR
 Hm1OczYFAZj3kzpcn4p6VIAtTLwZjI2NOW/SR9ZtuGE4Gv3WcsNVaGsBQ
 YYhhHffJK0JvOzski1EcqSjx2sLoGL2/R1XJ4Q9qenmj+FKGuYY4KRfSJ
 wbDsb7sxK5yNcqwW1EzAMco+tZtwwlFGbXUIvdnoGu3WliBGkO9HGqjYN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23408080"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; d="scan'208";a="23408080"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 23:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1489994"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 23:29:29 -0800
Message-ID: <b4bcdbf6-244b-41e0-9650-04b8410323d1@intel.com>
Date: Wed, 7 Feb 2024 15:29:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Confidential Guest Support: Introduce kvm_init()
 and kvm_reset() virtual functions
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20240206082852.3333299-1-xiaoyao.li@intel.com>
 <ZcI_5IbCltQbqhIz@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZcI_5IbCltQbqhIz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/6/2024 10:19 PM, Daniel P. Berrangé wrote:
> On Tue, Feb 06, 2024 at 03:28:48AM -0500, Xiaoyao Li wrote:
>> This series is inspired and suggested by Daniel:
>> https://lore.kernel.org/qemu-devel/ZbfoQsEuv6_zwl3b@redhat.com/
>>
>> Currently, different confidential VMs in different architectures have
>> their own specific *_kvm_init() (and some have *_kvm_reset()) exposed
>> for KVM stuff when it's a confidential VM. e.g., sev_kmv_init() for x86
>> SEV, pef_kvm_init() and pef_kvm_reset() for PPC PEF, and s390_pv_init()
>> for s390 PV VMs.
>>
>> Introduce a generic .kvm_init() and .kvm_reset() functions in
>> ConfidentialGuestSupportClass, so that different cgs technologies in
>> different architectures can implement their own, while common interface
>> of cgs can be used.
>>
>> This RFC implements two helper functions confidential_guest_kvm_init()
>> and confidential_guest_kvm_reset() in Patch 1. In the following patches,
>> they are called in arch specific implementation. X86 will benefit more
>> for the generic implementation when TDX support is added.
>>
>> There is one step forward possible, that calling
>> confidential_guest_kvm_init() before kvm_arch_init() in kvm_int() in
>> accel/kvm/kvm-all.c. This way, each arch doesn't need to call in their
>> arch specific code.
>>
>> X86 fits it, however I'm not sure if ppc and s390 fit it as well.
>> Because currently, ppc calls it in machine->init()
>> and s390 calls in MachineClass->init(). I'm not sure if there is any
>> order dependency.
> 
> IIUC that s390 call is still a machine->init method, rather than
> class init.

I double check the code again. Only struct MachineClass has .init() 
function defined. And I find both ppc and s390 calls the 
confidential_guest_kvm_init() (or their specific cgs kvm_init()) inside 
their machine_class->init().

> I think this series is nice, but its up to the KVM maintainers
> to decide...
> 
> 
> With regards,
> Daniel


