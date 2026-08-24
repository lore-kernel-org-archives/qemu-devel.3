Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8455EC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNOl-0007sF-Ba; Mon, 24 Aug 2026 01:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNOj-0007s6-8L
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:39:05 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNOh-0008Jx-K7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787549944; x=1819085944;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0Bsfa3a2i4uHH9RVZ07JPgXdXR2aVjd8JE0KUFLgrrg=;
 b=cnm87EdjjmzzZZphi8T+94kQ6dgw7EvjvZHkVix02Ye5K9Bepl00Z4Xn
 MUePVhN8L+AAsukAri37DX2BtzcGC3Dz0W6vow8fHLYXQF+xlvqhWNkF/
 Xaetfp7f7a7tweFwuNXuxwYlc2LvNcsJICjGmF4EWnWIcSeJwKqpeU4Yg
 nVGhC53VIsXS9kbaDbvbAu0osvJm/yxLnwwLN/y5y+KBrFixORDVMCMtY
 se3FnyD8gML/2W/a9VPRhXJNwXOLO6r/xNbS0vaiyrZD6d1i9HqRuViOz
 mCeHnw6XLquadK1s4BoyC3G3DK37LJRweBYlh1nucMngwsN4jZ5vAgcx+ A==;
X-CSE-ConnectionGUID: ZQos1k9WTDm2ubsoPxpEcA==
X-CSE-MsgGUID: ElevogmLRUmJSD7GbKlPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91667737"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="91667737"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 22:39:02 -0700
X-CSE-ConnectionGUID: /IxB/yekRSCZz7oMUwbGDg==
X-CSE-MsgGUID: cxQixFWGQ0S44HasKyWaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="290429884"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa002.fm.intel.com with ESMTP; 23 Aug 2026 22:38:59 -0700
Date: Mon, 24 Aug 2026 13:38:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
Message-ID: <aovY88W/XD0fQeTH@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-6-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-6-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 24, 2026 at 12:53:09PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:09 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
> X-Mailer: git-send-email 2.43.7
> 
> The Intel and Zhaoxin PMU architectures are compatible, while AMD uses
> a separate PMU CPUID/MSR layout.  KVM's PMU initialization, host/guest
> compatibility, and MSR save/restore paths open-code these vendor checks
> in several places.
> 
> Introduce X86PMUVendor and helpers that classify the existing CPU and
> host vendors by PMU architecture.  Use the classification consistently
> for the compatibility check, PMU initialization, and PMU MSR paths.
> 
> This is a refactoring with no functional change.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 72 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


