Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF65C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 03:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbtQN-0004gP-Ct; Sat, 25 Jan 2025 22:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tbtQK-0004gB-SI
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 22:35:00 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tbtQI-0007d9-CW
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 22:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737862498; x=1769398498;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AxH/KOjNZ7bGqZuAZbGbffqbSslE+PDxCx1zDr03ZS4=;
 b=E4yXKNuzDgvr6Tcb0IwDRQeceiMqTgbM28HfMbQr9dINMk5w2iRsg0Nf
 liPMib5QSCUMqHHubhnqL7gGscvHaovNnAJZpWa/wFRrTbY8d0YmpmyCf
 Y1oPzzrOND5YOTNSHnE9JfxAMcVbntjcyUkjVtpW1wKLaWpBzrPT1jxWf
 FfkwCI5qJaDEJNZA0y8ZfDkgNKNnprZxCCIRhjJk4hWzgHZAVxHq+7l36
 QBt5ZbLgQ2RYa3T5T1V2JVuz7QnizsLMel6uqKtbYOZT9lHNd6XgaBXtG
 paeuAQcHQOghmj/J/clin1ZvaeojdSwNYDYD1lOnqflyE3j9beyrAT4bU g==;
X-CSE-ConnectionGUID: +QF6AiE6SDWGpJWoqniKHg==
X-CSE-MsgGUID: x86jSWgWS/270fvcTduYIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="37611636"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; d="scan'208";a="37611636"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 19:34:53 -0800
X-CSE-ConnectionGUID: LP9krpO0Rt6/x9mLgNPCXg==
X-CSE-MsgGUID: Hmg03IfQRwyvDtewIGau1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; d="scan'208";a="113126474"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by orviesa004.jf.intel.com with ESMTP; 25 Jan 2025 19:34:50 -0800
Date: Sun, 26 Jan 2025 11:34:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z5WtRYSf7cjqITXH@yilunxu-OptiPlex-7050>
References: <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
 <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050> <Z5O4BSCjlhhu4rrw@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5O4BSCjlhhu4rrw@x1n>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Definitely not suggesting to install an invalid pointer anywhere.  The
> mapped pointer will still be valid for gmem for example, but the fault
> isn't.  We need to differenciate two things (1) virtual address mapping,
> then (2) permission and accesses on the folios / pages of the mapping.
> Here I think it's okay if the host pointer is correctly mapped.
> 
> For your private MMIO use case, my question is if there's no host pointer
> to be mapped anyway, then what's the benefit to make the MR to be ram=on?
> Can we simply make it a normal IO memory region?  The only benefit of a

The guest access to normal IO memory region would be emulated by QEMU,
while private assigned MMIO requires guest direct access via Secure EPT.

Seems the existing code doesn't support guest direct access if
mr->ram == false:

static void kvm_set_phys_mem(KVMMemoryListener *kml,
                             MemoryRegionSection *section, bool add)
{
    [...]

    if (!memory_region_is_ram(mr)) {
        if (writable || !kvm_readonly_mem_allowed) {
            return;
        } else if (!mr->romd_mode) {
            /* If the memory device is not in romd_mode, then we actually want
             * to remove the kvm memory slot so all accesses will trap. */
            add = false;
        }
    }

    [...]

    /* register the new slot */
    do {

        [...]

        err = kvm_set_user_memory_region(kml, mem, true);
    }
}

> ram=on MR is, IMHO, being able to be accessed as RAM-like.  If there's no
> host pointer at all, I don't yet understand how that helps private MMIO
> from working.

I expect private MMIO not accessible from host, but accessible from
guest so has kvm_userspace_memory_region2 set. That means the resolving
of its PFN during EPT fault cannot depends on host pointer.

https://lore.kernel.org/all/20250107142719.179636-1-yilun.xu@linux.intel.com/

Thanks,
Yilun

> 
> Thanks,
> 
> -- 
> Peter Xu
> 

