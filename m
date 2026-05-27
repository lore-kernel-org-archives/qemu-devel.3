Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D2BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSAsR-0003Si-D5; Wed, 27 May 2026 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSAsD-0003Rg-1a
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:48:27 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSAsA-0001qK-GU
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779875302; x=1811411302;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PHMKaNBqL4XM/ZCqlJQJlX9naT3bGTmTWlk8uaJ0aQ4=;
 b=RJs1Ijm+jq5YuVMvtfVou+Je8txFrogrScx/pAZ4WrAeXcy/XA2clr9y
 GBi3cqrykIrGxxIuD06KcHD3734Hr97oIzGtCKvaFRR1OU/xEHcenfjOS
 /3iJIoOpsLI4ClyNvoO+NQsRKCqPHsVZX4J7RzToy8hxUpKz8QGD/q0o4
 HITWPFiOysPPfUqHgNpF/ZFMLaBdCOYArbTl5UfGpYiVgfO4/ynnx5H1j
 +48PspHAB/0GmxObjfpEWCYyGV2r8uRzTJjWjsaTXs83f654+DyxAUOgE
 u3o4XEuUgMOgMOK7xiMzV8orfjqpb0IkRZ/Lrx9VsCr93GcjLSRtqSn+j A==;
X-CSE-ConnectionGUID: 86rASzT2RPiPloUHLQUR8Q==
X-CSE-MsgGUID: i0P8q9mqQFmk3rJgVDGnmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98275831"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="98275831"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:48:17 -0700
X-CSE-ConnectionGUID: d41eWYKeTxW9qdxYsn6bRw==
X-CSE-MsgGUID: OE+u8L4URWGQBbl6VlOAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="239584559"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:48:15 -0700
Message-ID: <7a9fe710-679e-4366-9eeb-3aba148773d7@intel.com>
Date: Wed, 27 May 2026 17:48:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] RFC: hw/virtio: start virtio-mem guest_memfd
 regions as shared
To: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com> <agTjb3M8ElUAlfp1@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <agTjb3M8ElUAlfp1@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
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

On 5/14/2026 4:47 AM, Peter Xu wrote:
> On Mon, May 04, 2026 at 04:30:19PM +0400, Marc-André Lureau wrote:
>> In TDX guests, virtio-mem plug/unplug/re-plug fails because
>> kvm_set_phys_mem() unconditionally sets KVM memory attributes to
>> PRIVATE for all guest_memfd regions. On re-plug, the PRIVATE->PRIVATE
>> transition is a no-op, so KVM doesn't re-AUG pages and the guest's
>> TDG.MEM.PAGE.ACCEPT fails.
> 
> Know little on TDX, please bare with me..
> 
> I saw KVM does a seamcall to ADD or AUG whenever a new EPT pte is set, via
> this path:
> 
>          __tdp_mmu_set_spte_atomic
>          set_external_spte_present
>          tdx_sept_set_private_spte <------
> 
> On unplug, I'm expecting with your prior patches, gmem pages will be
> truncated properly, so they'll be all gone.
> 
> Then, qemu does replug -> guest gets that event, start access page -> EPT
> violation, KVM resolving page fault with __tdp_mmu_set_spte_atomic() (per
> above) and a new page -> triggering AUG (not ADD, since it's post-boot).
> 
> Could you elaborate here why AUG is missing in the first place?

Peter, you analysis is correct.

The reason why plug -> unplug -> re-plug fails, is QEMU fails to discard 
the private memory so that KVM doesn't zap the private mapping. When 
re-plug and guest re-accepts, KVM doesn't get involved. Not discard the 
private memory on unplug leads to another issue that the private memory 
is still accessible to the guest.

But patch 11 fixes this. Patch 11 should be enough and we don't need 
this patch. For guest kernel side, we need to ensure the guest kernel 
accepts the new plugged memory, and no "start-shared" trick is required.

BTW, "start-shared" memory for coco is not something good. It violates 
the contract that all the memory for Coco VM is initial private 
(accepted or unaccepted) from EFI spec. We probably should avoid 
introducing exception unless we have to.

