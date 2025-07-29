Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E7BC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdPg-0005kJ-M2; Tue, 29 Jul 2025 02:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdPX-0005h9-NF
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:02:04 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdPT-0004b6-7F
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753768919; x=1785304919;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=t0pUYIob5f7VMPDuNAJgp+dbhC1o7MpeWlAMU+/hhmI=;
 b=n+bEJlnjoB097PnWPenU7MdC1Gz+ATcTTNKsR+qJoSDjVMWTuC5QQL86
 WBtk/xw1ckwlJw7M/7VkfiEGkzT4xafAfXIOIEqb8E/5L5Rk8q7jT4lNe
 GkkOClXQ2FN44Jmvfw83RF/7ceejg+LW5KytWoPg4YpOqxneTQM3NHTbE
 mWTJ1EtXanXLHx1CBbTG2sHMtb9JtKabwS97PVSperhmurdtykeQYZwhy
 U5gN5QO8sUgPitPw4K7Dtlsxb3NWoA4YKEoTU7rlJ8DaFf4jyOEJ+iv0k
 Ug+bVhFFK+c1GnTJ/BsJ5waMHDQB2fZEKuzLix8asiqLqXd5Kbqr1ERQd g==;
X-CSE-ConnectionGUID: oKqQBTT/QKm6JBX7pfsr6A==
X-CSE-MsgGUID: 6Dt9wJ7OSn2p8ny182WwoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67383360"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="67383360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 23:01:56 -0700
X-CSE-ConnectionGUID: IvaqX746RNOzvT4Pi/+tuQ==
X-CSE-MsgGUID: V2eBLvQoT6aqOmda9Kmeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="161874027"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 23:01:54 -0700
Message-ID: <256c721c-8846-4c5a-9535-0047d83264de@intel.com>
Date: Tue, 29 Jul 2025 14:01:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
To: Zhao Liu <zhao1.liu@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
 <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
 <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com> <aGeO2zCKep7StDA8@intel.com>
 <cf64058e-e5a2-4cf2-9851-92925553e72c@intel.com>
 <6C44AD09-0675-4277-93C2-DB3647EC54C2@yandex-team.ru>
 <aIei/i7+MHM2s3EZ@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aIei/i7+MHM2s3EZ@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/29/2025 12:19 AM, Zhao Liu wrote:
> Hi Kirill,
> 
> On Mon, Jul 28, 2025 at 05:44:25PM +0300, Kirill Martynov wrote:
>> Date: Mon, 28 Jul 2025 17:44:25 +0300
>> From: Kirill Martynov <stdcalllevi@yandex-team.ru>
>> Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for
>>   softmmu
>> X-Mailer: Apple Mail (2.3826.600.51.1.1)
>>
>> Hi Xiaoyao!
>> Hi Zhao!
>>
>> Xiaoyao,
>> I tested the patch you provided, it works smoothly, easy to apply. Nothing to complain about.
>>
>> Zhao,
>> I also tried your approach (extend cpu_address_space_init with AddressSpace parameter)
>> First, it crashed in malloc with error:
>> malloc(): unaligned tcache chunk detected
>> After a little investigation I resized cpu->cpu_ases array, so it can fit second element and
>> it started working. However, it looks like that function cpu_address_space_destroy needs
>> some adjustment, because now it treats cpu->cpu_ases elements as dynamically allocated and
>> destroys them with g_free() and passing &smram_address_space to cpu_address_space_init()
>> in register_smram_listener() could lead to a problem since it is statically allocated in binary.
> 
> Thanks for testing. Yes, resize related details are needed, which were
> I missed. These 2 patches essentially are all about adding SMM CPU
> address space for KVM, like TCG did.
> 
>> So, my question now, what should I do?

I just sent the formal version [*], could you please help verify if it 
resolve your problem?

(If you can share the step how to reproduce the original problem, I can 
test myself)

[*] 
https://lore.kernel.org/all/20250729054023.1668443-2-xiaoyao.li@intel.com/

> I still believe we should update cpu_address_space_init() and remove its
> outdated assumptions about KVM first.
> 
> Moreover, users should have control over the added address spaces (I
> think this is why num_ases should be set before
> cpu_address_space_init()), and quietly updating num_ases is not a good
> idea.
> 
> The question of whether to reuse smram_address_space for the CPU is
> flexible. At least TCG doesn't reuse the same SMM space, and there's
> already cpu_as_root (and cpu_as_mem!) in X86CPU. 

For i386 tcg, it allocates each CPU 3 MemoryRegions: cpu_as_root, 
cpu_as_mem and smram for SMM. While for i386 kvm, it allocates global 
MemoryRegions: smram_as_root and smram_as_mem and get smram from 
resolving "/machine/smram".

yeah, this seems something we can cleanup if there were not specific 
reason for TCG to have different MemoryRegion each CPU. I don't have 
bandwidth to investigate it further.

> There are also some
> cleanup things worth considering, such as how to better handle the TCG
> memory listener in cpu_address_space_init() - KVM also has the similar
> logic. If possible, I can help you further refine this fix and clean up
> other related stuff in one goes as well.
> 
> Thanks,
> Zhao
> 


