Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C80C5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy4R1-0000Tx-Td; Sun, 23 Aug 2026 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4R0-0000Tp-HA
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:24:10 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4Qy-0001e5-Vh
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787477049; x=1819013049;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IelsqnBOvxhCL8J8K8c1AsA7S6o9JNKpAOXHCvwiBk8=;
 b=h7Pks4CcPtVK2VNtO567NKX27P1nHF+cKaTxeYXpA6m5vDz34k/CtNL9
 Sh6k9C2/wPGxtPUvh0lBzL9PwwKzay2zEDmOWvx0KSZvq4q7fVuFttOrF
 OU/BQtcnoJ62RbK2OBEb3e0+F+C5477Q/BnJmJNN/QGpa8uQB6ADrdGhH
 4wpMPMd6MjNgj8UIhO4UAM5eabafAAc2mkWH6V40G2hsk8ErC+UzB0DnN
 yl1bdYGk2gLgO1WoN8pJBnOmDUrDxCr3zAptMpGGy7XzEG+QV7cBu3vge
 MAkV2iKtyYPK7nsW5xe8H/VsTY7KU+z8RHRFcdcEJFVEs74gg1WYcGRff Q==;
X-CSE-ConnectionGUID: bdXm+JbtQOS/siXK3U5PnA==
X-CSE-MsgGUID: hMSOW8jLQBqvfVAWF4IIFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87969325"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="87969325"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 02:24:06 -0700
X-CSE-ConnectionGUID: znbtUwrPQZubnGB8V1ed7g==
X-CSE-MsgGUID: ffEmwVWmTE2LHGQLuG/Umw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="266780240"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa007.jf.intel.com with ESMTP; 23 Aug 2026 02:24:04 -0700
Date: Sun, 23 Aug 2026 17:24:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 9/9] target/i386: Use AMD ucode-rev default for Hygon
Message-ID: <aoq8M9lQKGywIOIu@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-10-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-10-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Aug 10, 2026 at 04:29:56PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:56 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 9/9] target/i386: Use AMD ucode-rev default for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> QEMU currently gives named Hygon Dhyana CPUs the non-AMD default
> ucode-rev value, 0x100000000.  That is the Intel/KVM-VMX-shaped
> encoding, where the visible revision is in the high 32 bits.
> 
> Linux reads MSR 0x8b for Hygon CPUs through the AMD patch-level path,
> using MSR_AMD64_PATCH_LEVEL and storing the low 32 bits as
> cpuinfo_x86.microcode.  With the old QEMU default, a Dhyana guest sees
> microcode revision 0.
> 
> Use the AMD/KVM-SVM-shaped default, 0x01000065, for Hygon on this
> specific MSR 0x8b default path.  This does not route Hygon through AMD
> microcode loading and does not claim that Hygon CPUs are otherwise
> identical to AMD CPUs.
> 
> Preserve migration ABI through the vendor CPU ABI compatibility gate used
> by this Hygon bug-fix group.  pc-11.0 and older machine types leave that
> gate off, so they retain the previous ucode-rev default.  Explicit
> user-provided ucode-rev values still override the default.
> 
> Add qtest coverage for the new default, the compatibility cases, and an
> explicit user override.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c                   |  8 ++++++--
>  tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> +         * Hygon uses the AMD patch-level MSR 0x8b encoding, where the visible
> +         * microcode revision is in the low 32 bits.

I feel like this description is redundant regarding the commit message
is already self-explanatory. Adding one for each vendor might clutter
the comments.

Others, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


