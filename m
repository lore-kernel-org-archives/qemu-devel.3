Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62053CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUQ86-0001vP-K2; Tue, 02 Jun 2026 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wUQ83-0001uy-EV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:30:03 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wUQ80-00086R-Ut
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780410601; x=1811946601;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=L8YvFqkbXkY7MI1XsMXx3zHKnn1Htm+nUPc96z5Ivj8=;
 b=bz8wtDT38zrZXqqnB9dDsme/wwPWsJewu8aCTeNkOQbKrM6UlmsisflV
 H3rOz9HrwMuxEycbUUCYLnMRYhq3xty1tA+ViCruc77NP/AGVuEeeimZx
 ZPeoGOazbHfOGcVt+AT7NqqtUQ2Z9yOpANcvMJ8Scq07YhnYTqz/7foPF
 Gw5xQsLm5/3LibQKpvPD0sa6NdKRVH/u1/5MpaoKSRwRKD1ZtNhSV/clz
 FcxcursOWCgmA68kkhvkVcZyObIloedWOmrRaV5j0OoTDbMPsdSivqexj
 IUz+5I5S0qq6tcsmHM18/R3dVrL1TP1UV8tAi7u0hY8lhnzgRyx4lFbZy A==;
X-CSE-ConnectionGUID: gJKI7wwoT0CH+21NSCFADQ==
X-CSE-MsgGUID: gbXzF2vjRFqkYBqSalXFxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81322085"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81322085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 07:29:57 -0700
X-CSE-ConnectionGUID: khykwD04Th2ct3q+BmLO7w==
X-CSE-MsgGUID: KGffe6TNR02l2X7RYGAPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="267789128"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18])
 ([10.124.240.18])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 07:29:55 -0700
Message-ID: <9133b329-fdee-45f6-b3c8-53d764e6e7fd@intel.com>
Date: Tue, 2 Jun 2026 22:29:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] RFC: hw/virtio: start virtio-mem guest_memfd
 regions as shared
To: "David Hildenbrand (Arm)" <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com> <agTjb3M8ElUAlfp1@x1.local>
 <7a9fe710-679e-4366-9eeb-3aba148773d7@intel.com>
 <d8cbf284-7f42-4892-b50d-b21bbe91b874@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d8cbf284-7f42-4892-b50d-b21bbe91b874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 6/2/2026 9:50 PM, David Hildenbrand (Arm) wrote:
> On 5/27/26 11:48, Xiaoyao Li wrote:
>> On 5/14/2026 4:47 AM, Peter Xu wrote:
>>> On Mon, May 04, 2026 at 04:30:19PM +0400, Marc-André Lureau wrote:
>>>> In TDX guests, virtio-mem plug/unplug/re-plug fails because
>>>> kvm_set_phys_mem() unconditionally sets KVM memory attributes to
>>>> PRIVATE for all guest_memfd regions. On re-plug, the PRIVATE->PRIVATE
>>>> transition is a no-op, so KVM doesn't re-AUG pages and the guest's
>>>> TDG.MEM.PAGE.ACCEPT fails.
>>>
>>> Know little on TDX, please bare with me..
>>>
>>> I saw KVM does a seamcall to ADD or AUG whenever a new EPT pte is set, via
>>> this path:
>>>
>>>           __tdp_mmu_set_spte_atomic
>>>           set_external_spte_present
>>>           tdx_sept_set_private_spte <------
>>>
>>> On unplug, I'm expecting with your prior patches, gmem pages will be
>>> truncated properly, so they'll be all gone.
>>>
>>> Then, qemu does replug -> guest gets that event, start access page -> EPT
>>> violation, KVM resolving page fault with __tdp_mmu_set_spte_atomic() (per
>>> above) and a new page -> triggering AUG (not ADD, since it's post-boot).
>>>
>>> Could you elaborate here why AUG is missing in the first place?
>>
>> Peter, you analysis is correct.
>>
>> The reason why plug -> unplug -> re-plug fails, is QEMU fails to discard the
>> private memory so that KVM doesn't zap the private mapping. When re-plug and
>> guest re-accepts, KVM doesn't get involved. Not discard the private memory on
>> unplug leads to another issue that the private memory is still accessible to the
>> guest.
>>
>> But patch 11 fixes this. Patch 11 should be enough and we don't need this patch.
>> For guest kernel side, we need to ensure the guest kernel accepts the new
>> plugged memory, and no "start-shared" trick is required.
>>
>> BTW, "start-shared" memory for coco is not something good. It violates the
>> contract that all the memory for Coco VM is initial private (accepted or
>> unaccepted) from EFI spec. We probably should avoid introducing exception unless
>> we have to.
>>
> 
> Sorry, I have to double check: you are saying we do not need this patch, and
> instead the guest has to do the right thing after plugging memory?

right, that's what I meant.

Whether the initial state of the (re-)hotplugged virtio-mem is shared or 
private doesn't matter. Guest has to try to accept it before using it as 
private memory. If guest hits the re-accept error, which means the 
memory has not been taken off at the previous unplug and means the 
memory is actually always available to the guest.

What matters is the host VMM needs to ensure the memory is actually 
unplug'ed on the unplug operation, which is achieved by the patch 11 in 
this series.



