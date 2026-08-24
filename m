Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFF9C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNPT-00084I-03; Mon, 24 Aug 2026 01:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNPR-0007z7-Vo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:39:50 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNPQ-0008Nw-DP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787549988; x=1819085988;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=t9jSKFqj4qNlGtrhWAFP8eR/NFKt57x0hrrGS9wN5fI=;
 b=UhgJ3HUPeGSNLMtN4frLj1wbDa+aHJPrHX/+CjUTgqf01U/CscE3cVj4
 aKnahXpuMlMl9PWRC0/CL8d/wuGmuxMF/C/cEf1aQmCkKdgVejXEj+I/z
 UPuSD0WzuKNtEfxRmN+pRpeeo+Vwd6VYkLDmNdQ2N4GampJ0gfHpcOrDT
 9z8Aw8XHLVCG6HzkW68ngRVl8GR3XEpITBD6MpGJAqur4k+ZDWORU0idO
 kNOYfmn8Y7ydCjlJVPMJ4N2to5WxEvAcnebebL6dwuEAXKRJm/jueoowg
 YsFoguKVMpLgtcx4JmcVZUeEgDjapjRhJjWVz5qA6Oj/gvW4uBwui0bxO w==;
X-CSE-ConnectionGUID: EtMN9xWGQbyULWstAUs0ag==
X-CSE-MsgGUID: mH1Tu9M6QH+TwABKD0GNNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="75530624"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="75530624"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 22:39:45 -0700
X-CSE-ConnectionGUID: DsviJ1zBQia1Im1JhQnMYA==
X-CSE-MsgGUID: hXwX0MFFQl2ra9FQer2WTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="263187285"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2026 22:39:43 -0700
Date: Mon, 24 Aug 2026 13:39:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 06/10] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <aovZHhGT9nRfbb+C@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-7-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-7-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Mon, Aug 24, 2026 at 12:53:10PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:10 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 06/10] target/i386/kvm: Use AMD PMU MSR paths for Hygon
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
>  target/i386/kvm/kvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


