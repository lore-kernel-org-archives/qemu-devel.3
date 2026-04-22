Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430CAF9B5FE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFU3r-0000Dx-Jv; Wed, 22 Apr 2026 05:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wFU3p-0000DH-H0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:39:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wFU3l-00020P-Tu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776850794; x=1808386794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7Dmeclr4hWpb5oIW709HVPR9P1oYHCoekKlfeETO7nc=;
 b=if2rQdZ1d4fHg2haSCxhSUOk/6jcaY5EI6bzrE1UW7idOAzBi4a7ijZ0
 C+nTsfiiq5RPoN/Qi6JTOVv5YaOwEzt/QQsw2sw8dbX4T9OtgLjb95k45
 GwsSclBcUel4rxrb+nAae2050tyoRyRmDsEsAm6FZfN+Abl1QUtjhpBgy
 xZmHZWer9Okr5Nl8GByenzea/Wnitk5bLlCLogwiGMk0DwcXN7yUtguy0
 OZ+Wz6w5wFuZkUTX4zuuJ01OZbzEaBn7b1IW3oElw7t1O57+vYx3+jzoD
 4Ip2F8FNlt5S3I4qRDcF2S+sPB6FKCCEakH4UEGa0ZaBGkqEJeMjh5lbN w==;
X-CSE-ConnectionGUID: XqiSTpvjSCWOf3e3HMZQKw==
X-CSE-MsgGUID: 6yuxxTBRRHiOS/kYfM+78g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77503924"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77503924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:39:51 -0700
X-CSE-ConnectionGUID: X2fcTX03Rtq5mBwfFjHXCg==
X-CSE-MsgGUID: jmXs1IjLQgW9Z0pxJGBqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="236306754"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Apr 2026 02:39:49 -0700
Date: Wed, 22 Apr 2026 18:07:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
Message-ID: <aeid0QluufANcH59@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-2-zide.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304180713.360471-2-zide.chen@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 04, 2026 at 10:07:00AM -0800, Zide Chen wrote:
> Date: Wed, 4 Mar 2026 10:07:00 -0800
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
> X-Mailer: git-send-email 2.53.0
> 
> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
> (bit 11), is deprecated and has been superseded by LBR and Intel PT.

I'm not clear from which platform this bit will be set by default?

> KVM yields control of this bit to userspace since KVM commit
> 9fc222967a39 ("KVM: x86: Give host userspace full control of
> MSR_IA32_MISC_ENABLES").

If KVM won't support it, it's better to only configure for KVM.

> However, QEMU does not set this bit, which allows guests to write the
> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
> this may lead to unexpected MSR access errors.

But overall, this way is a bit user-unfriendly. For cases where CPUID
is unavailable, it would be more proper to check the KVM API to
determine whether support is available; making this change in userspace
feels a bit like applying the special patch for a corner case.

I found there's another patch where Paolo and Sean didn't want to make
such changes directly earlier on....
https://lore.kernel.org/qemu-devel/20220718032206.34488-1-zhenzhong.duan@intel.com/

Thanks,
Zhao


