Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06132C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 03:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhK20-0007B7-VF; Wed, 30 Jul 2025 23:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uhK1n-0006w1-Ex
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:32:23 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uhK1l-00068d-M8
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753932742; x=1785468742;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wyy8M9uIb41oscpjrXe5IcTgIHR4M7jQvPOqDV45LUo=;
 b=ZAgk0glGH8U1vianAp1yi1khs1lquNYqJQbXuSHNC5HKb/4qeHUUfggE
 QScx7AhQHC8q6cUS6IazR8iII0WYkt2Mz4OvMBQyaLoLz2IGsXybFQRLw
 Qvb5SZidgoc50VcbSMJm1L6Qnow+96jAgPKTuF8GqWsFO6pqBGOdCEZKm
 ZJR3rOCYB89yhkvPdqYinG7pOPX0c4WvosCG8L0+RMQn+HOaUymTVD/Ws
 fnqwfjBZ81A+Q+NGzXPOkKJc5nOtp6LQytGSf+Ks1REFyCdjGDnakFRMb
 BkuJg1QJPBiT0rHG2YJj7Amc/7DzeQ6OpkLaVoErZKr393QqSM8eVWlb4 A==;
X-CSE-ConnectionGUID: KDwH83BJSfidI4p9ZwzOvQ==
X-CSE-MsgGUID: SP6yYpajSR+SHcTOsC2oeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56334930"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="56334930"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:32:20 -0700
X-CSE-ConnectionGUID: v0cErpfXQEOy5I2CIscNhQ==
X-CSE-MsgGUID: od41BN2gSFmIEZYaXfl+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="167372162"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 30 Jul 2025 20:32:18 -0700
Date: Thu, 31 Jul 2025 11:53:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Message-ID: <aIro0jw/CjMssy/v@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com>
 <aInTujVM5hr6/cJw@intel.com>
 <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com>
 <aIo4MxukAiY0OSGE@intel.com>
 <e5bde045-01b6-4f81-bc25-fd4312de7fe8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bde045-01b6-4f81-bc25-fd4312de7fe8@intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 31, 2025 at 12:11:41AM +0800, Xiaoyao Li wrote:
> Date: Thu, 31 Jul 2025 00:11:41 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
> 
> On 7/30/2025 11:20 PM, Zhao Liu wrote:
> > > > > +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
> > > > 
> > > > It is worth mentioning in the commit message that directly sharing
> > > > MemoryRegion in CPUAddressSpace is safe.
> > > 
> > > It's unnecessary to me. It's common that different Address space share the
> > > same (root) memory region. e.g., for address space 0 for the cpu, though
> > > what passed in is cpu->memory, they all point to system_memory.
> > 
> > For cpu->memory, there's the "object_ref(OBJECT(cpu->memory))" in
> > cpu_exec_initfn().
> > 
> > But this case doesn't need to increase ref count like cpu->memory, since
> > memory_region_ref() provides protection and it's enough.
> > 
> > This is the difference.
> > 
> > So it sounds like now it's more necessary to clarify this, no?
> > 
> 
> clarify why smram_as_root doesn't need to be object_ref()'ed explicitly like
> what cpu_exec_initfn() does for cpu->memory?

When you're referring cpu->memory, you should aware where's the
difference and why you don't need do the same thing.

This is necessary for a clear commit message, and it also allows more
eyes to check whether it is correct and whether there are any potential
problems. Providing details is always beneficial.

> As you saide,
> 
> cpu_address_space_init()
>   -> address_space_init()
>      -> memory_region_ref()
> 
> it already ensures the ref count is increased.

Yes, this is what I mean.

> Why cpu_exec_initfn() increases the refcount of cpu->memory, is
> totally unrelated to cpu_address_space_init().
  ^^^^^^^^^^^^^^^^^

The validity of cpu->memory must be guaranteed, as this is a prerequisite
for everything else. And isn't it mainly related with the CPU address
space??

It can be said that because the pointer to system_memory needs to be
cached in CPUState, such a ref is useful, thereby ensuring the safety
of the next address space stuff.



