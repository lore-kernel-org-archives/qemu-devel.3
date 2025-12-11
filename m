Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CD4D3E786
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTcPI-00029y-K3; Thu, 11 Dec 2025 03:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTcPG-00029k-QH
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:52:14 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTcPE-0000LF-BW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765443132; x=1796979132;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=47CtsqOCElRhQmwQBHGB+RMzeDpuMiMvxyN/PDZE120=;
 b=S7BbGU/Eq0DlaILL8ejW35MXCAoJ9y+D5hef774iRy0b+FTGaUb7gsk8
 hyHatviKagWTpMLu3tkW7KhsztFY9h+8lU92igGyeh75gpeCYeKPEPixP
 memg23Dln3nI/464K9LEiALFD6zxfchk+7nNXbLhrKLdxLpGrGV4Qv2EQ
 oySMXP/cQeDCa7b9Tw4puoVORgGa6ZOh8TSiYp0Wk0PzxE0egm+/BTnLh
 NUakTC1LWJ7tSihD6hwc7tsYq+143Obw42dsfmIGI14hp/n7Nz4oIpMNT
 5j7Jp8ODTs/R/uwluvahXY/L/WtSOA24k3tZYriLbMvhHXBwe7Cc1tegD w==;
X-CSE-ConnectionGUID: vYE1Yg6mTN2/tiucU8q/EA==
X-CSE-MsgGUID: GzjU0fF+TsCambwboKv9gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78040209"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="78040209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 00:52:10 -0800
X-CSE-ConnectionGUID: /V9HF3OLSmCSmmHQwhc3Qg==
X-CSE-MsgGUID: X3anHFyqQiSYQddwcOI5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196757073"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 11 Dec 2025 00:52:07 -0800
Date: Thu, 11 Dec 2025 17:16:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v2 0/9] i386/cpu: Support APX for KVM
Message-ID: <aTqMBtkOxx6mZhn+@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
 <16e0fc49-0cdf-4e54-b692-5f58e18c747b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e0fc49-0cdf-4e54-b692-5f58e18c747b@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 11, 2025 at 09:08:33AM +0100, Paolo Bonzini wrote:
> Date: Thu, 11 Dec 2025 09:08:33 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2 0/9] i386/cpu: Support APX for KVM
> 
> On 12/11/25 08:09, Zhao Liu wrote:
> > Hi,
> > 
> > This series adds APX (Advanced Performance Extensions) support in QEMU
> > to enable APX in Guest based on KVM (RFC v1 [1]).
> > 
> > This series is based on CET v5:
> > 
> > https://lore.kernel.org/qemu-devel/20251211060801.3600039-1-zhao1.liu@intel.com/
> > 
> > And you can also find the code here:
> > 
> > https://gitlab.com/zhao.liu/qemu/-/commits/i386-all-for-dmr-v2.1-12-10-2025
> > 
> > Compared with v1 [2], v2 adds:
> >   * HMP support ("print" & "info registers").
> >   * gdbstub support.
> > 
> > Thanks for your review!
> 
> Great, thanks!  Just one question, should the CPUID feature be "apx" or
> "apxf" (and therefore CPUID_7_1_EDX_APXF)?  I can fix that myself of course.

Good point! I didn't realize this.

1) Per APX spec:

(APX adds) CPUID Enumeration for APX_F (APX Foundation).

2) And gcc also use apx_f:

https://codebrowser.dev/gcc/gcc/config/i386/cpuid.h.html#_M/bit_APX_F

3) ...and we already have "avx512f".

So you're right, I should use "apxf" and CPUID_7_1_EDX_APXF.

Since APX CPUID appears in several patches, I can respin a new version
quickly.

Thanks,
Zhao



