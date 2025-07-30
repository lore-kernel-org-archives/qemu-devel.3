Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE22C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhBbf-0007bi-4Q; Wed, 30 Jul 2025 14:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh9PE-0007yA-8R
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 12:12:01 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh9PB-0001GO-Av
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 12:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753891909; x=1785427909;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ls2Pw+FhsvgTdynanivPEcpa+MN4Udxf0Zt0SNSP0k0=;
 b=H/sAJdzxFf4ccYVC3TQQOZlrqYz+41bx1qWkbYDGqxiXECRIkqzxz3tA
 8bTUgE6YKCAjV/3tmyv5qsylpQXMIPgvnY2zIH0211zGhVlmmvMkMktc/
 8CZtkVhrUoYXENUWu4Kk92DecF91eu9YAU+8wZE8eXm5siwZoqLVJTR25
 W7Ih151/dfiqdik+TDqhKmwd40YNMFt7fHN2pCUEgSNGTH8p3M4Ih9mb8
 Q9R8x1mFA+/Yf7C4jtIt6qUUU8wIumT6CSUcBei6BGpVF/e3Zuw9dfU6b
 T7Ke0Y4gJ18YsVnaNrRTDAhvGgvwlFy4hSoFkVi9y/pRXLOUg/925rkIy A==;
X-CSE-ConnectionGUID: 4UPAKWXfSWyM3NgW+Yj01w==
X-CSE-MsgGUID: OTnObn1tQ6eZp0tVExL3BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55268909"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="55268909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 09:11:46 -0700
X-CSE-ConnectionGUID: clwCpGQATTODnZf79mKz2Q==
X-CSE-MsgGUID: AS4L2/TySYuz1MARVeV9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162616459"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 09:11:44 -0700
Message-ID: <e5bde045-01b6-4f81-bc25-fd4312de7fe8@intel.com>
Date: Thu, 31 Jul 2025 00:11:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com> <aInTujVM5hr6/cJw@intel.com>
 <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com> <aIo4MxukAiY0OSGE@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aIo4MxukAiY0OSGE@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.3, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/30/2025 11:20 PM, Zhao Liu wrote:
>>>> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
>>>
>>> It is worth mentioning in the commit message that directly sharing
>>> MemoryRegion in CPUAddressSpace is safe.
>>
>> It's unnecessary to me. It's common that different Address space share the
>> same (root) memory region. e.g., for address space 0 for the cpu, though
>> what passed in is cpu->memory, they all point to system_memory.
> 
> For cpu->memory, there's the "object_ref(OBJECT(cpu->memory))" in
> cpu_exec_initfn().
> 
> But this case doesn't need to increase ref count like cpu->memory, since
> memory_region_ref() provides protection and it's enough.
> 
> This is the difference.
> 
> So it sounds like now it's more necessary to clarify this, no?
> 

clarify why smram_as_root doesn't need to be object_ref()'ed explicitly 
like what cpu_exec_initfn() does for cpu->memory?

As you saide,

cpu_address_space_init()
   -> address_space_init()
      -> memory_region_ref()

it already ensures the ref count is increased.

Why cpu_exec_initfn() increases the refcount of cpu->memory, is totally 
unrelated to cpu_address_space_init().

