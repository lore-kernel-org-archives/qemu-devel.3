Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846D5C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy4ZK-0002ty-A9; Sun, 23 Aug 2026 05:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4ZE-0002te-7f
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:32:41 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4ZC-00033w-G6
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787477558; x=1819013558;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=01RrAipA0GaR7ET5aVOCa94Ac18sfLeoD/WThIyyHPA=;
 b=J2zJGq5C0Tb+kYLpNQxoZtrsX3CgMsUPz7ECG6rrgrxcgReuPqX1Xmdw
 6c1AAO0yBNN886JwjeDWAdpM57j2qjcAu0x8q6e0dSLYqMorRIeZjYLEM
 SZXH9iafjlz1bYh8QTtKr2Hza9tgOSEl9tQ+xygZeOT/Ad2mbT3kk7d8n
 jRzx2iC9qqvnxLL1WA/J2dPBTPOvk4WpyTyAEKvr+l4MWhOAol/zDQVs+
 AA9pC3q5LprHL7hrBbYJKWfJ4v9oJwUEGgVJhCAAZtR1DK8eJvLc34jpV
 hlbjH0ErWhfGh/jjr3vsp2lP1qRSleNvuU6AFelisaz1q/L5+NSlrT5Ml A==;
X-CSE-ConnectionGUID: thJVhCKISkSIcHB66P85OQ==
X-CSE-MsgGUID: RDzkFGxRS0GKf0XQCxGErA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87817148"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="87817148"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 02:32:35 -0700
X-CSE-ConnectionGUID: EdXeU6IdRTqNDDN0fpCR1A==
X-CSE-MsgGUID: CTLnzO+WR7OmLLr7xaXXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="270946660"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa005.jf.intel.com with ESMTP; 23 Aug 2026 02:32:33 -0700
Date: Sun, 23 Aug 2026 17:32:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <aoq+MK8Vbvr1wA2c@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-6-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-6-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Mon, Aug 10, 2026 at 04:29:52PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:52 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
> layout.  Hygon guests that enable PMU and request AMD PMU CPUID
> features such as perfctr-core need QEMU's KVM PMU setup and MSR state
> paths to use that layout too.
> 
> The relevant QEMU KVM PMU paths are currently restricted to
> AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
> information initialization, and AMD PMU MSR save/restore.  For a Hygon
> Dhyana guest with pmu=on, the compatibility check reports vPMU as
> unsupported solely because the guest vendor is HygonGenuine rather than
> AuthenticAMD.  If the VM continues, QEMU still skips AMD PMU setup and
> never saves or restores the AMD PMU MSRs for the Hygon guest.
> 
> Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
> paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
> hosts for guests using that layout.  This intentionally allows the PMU
> compatibility check to pass for AMD-host/Hygon-guest and
> Hygon-host/AMD-guest combinations.
> 
> This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
> Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
> state may still be dropped because older QEMU did not write that state
> back through the AMD PMU MSR KVM paths for Hygon guests.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 73 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 17 deletions(-)

The code looks good to me! It would be even better if this could be
split into two patches - one dedicated to refactoring the vendor checks
first, and another to add Hygon as a new AMD-compatible vendor.

This would make it easier for maintainers to review, and the current
commit message would more directly correspond to the Hygon-specific
changes. :)

Thanks,
Zhao


