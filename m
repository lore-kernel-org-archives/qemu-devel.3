Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52067D1269D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 11:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkgg-0007Wn-Em; Wed, 03 Dec 2025 06:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkgd-0007W5-27
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 06:06:19 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkgX-00089J-Lx
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 06:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764759974; x=1796295974;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=S3zEWqt2WDEkieWuJEpVZ1iQbEtIUwDQynod8PDBc3g=;
 b=DSsoQ7sA9W3/kYUddWKgm4FEdTiEshd4L3hvaNBrouwWHo+cwN2JVmPV
 yv4lYFtpHpU4vc5H8sAchAordMz3lmS2cIuvTzTANaXtme3Wmu/Lk+oUr
 2ktVZjbH/uSNnGhD1GsVYgfxeRw5XbwfVT1LUhBPKpY5nSGODAMw2+oXP
 UG/wbLjfGiSG5rBQRmdYbT72nemEzW+5CK9f2EIM2LU1ilvjDrTk2WuHq
 8AjV0XkGLIhVLADFeJ2ibHZyAyAQb7iotp1jSxuZpACB6VT9kN7gviYJe
 M0bRlL2l6mVCbxGnmfbtoRX2PwHPRqTjImY9/sdfmJrfg4WNBLf8D7/TM w==;
X-CSE-ConnectionGUID: yHtlGBrMTcCXBU3oDNwwYA==
X-CSE-MsgGUID: 08ba8TO/SNedgziex0IzFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66689642"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="66689642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 03:06:09 -0800
X-CSE-ConnectionGUID: wASkKCcpQsqcOhweGoPbNA==
X-CSE-MsgGUID: KEkZEq7HQUaxDAuMoZMxDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="195065351"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 03 Dec 2025 03:06:05 -0800
Date: Wed, 3 Dec 2025 19:30:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 06/23] i386/kvm: Initialize x86_ext_save_areas[] based
 on KVM support
Message-ID: <aTAfaIPST8skLrUs@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
 <20251118034231.704240-7-zhao1.liu@intel.com>
 <5675fe47-f8ca-468a-abb6-449c88030a5f@redhat.com>
 <aS/uGsU39/ZbXDij@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS/uGsU39/ZbXDij@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > Can you move the call to kvm_cpu_xsave_init() after
> > x86_cpu_enable_xsave_components()?  Is it used anywhere before the CPU is
> > running?
> 
> Yes, this is an "ugly" palce. I did not fully defer the initialization
> of the xstate array earlier also because I observed that both HVF and
> TCG have similar xsave initialization interfaces within their accelerator's
> cpu_instance_init() function.
> 
> I think it might be better to do the same thing for HVF & TCG as well
> (i.e., defer xstate initialization). Otherwise, if we only modify QEMU
> KVM logic, it looks a bit fragmented... What do you think?

Ah, kvm_arch_get_supported_cpuid() currently caches the obtained CPUID.
Delaying xstate initialization would require refreshing the previously
cached old CPUID... This makes the cost of delaying xstate
initialization higher, and I think this way becames not appropriate.

Either keep the current different ways, or back to use host_cpuid for
everything :( . Which do you think is better?

Regards,
Zhao


