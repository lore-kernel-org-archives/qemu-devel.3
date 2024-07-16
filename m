Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A7BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWg-0000NQ-IK; Tue, 16 Jul 2024 11:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWT-00006b-Th
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:26 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWO-0007SD-S0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721145321; x=1752681321;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B5vJZl3GqGpi4ZMN7bXhTOBiKFTJgl07sNS3UgXe2sI=;
 b=j8Er6cVeAZPu47Zpfq8kUmytK6UOS5rK7zJLMzswHY7AzANi5S74QNnA
 blk+NdvJkgwq3LRc3OWQXTBIY5v6m420YK45kfEi8yMn8jnlKTHtSa5dJ
 r2CprWeFemu7M773Eq95hrdR0N553GsxxJ+/pi3wWkjNWjiGgdi1HMWkv
 bwBlCNVlZ1VY7Ws0r8bAXU0UHnTMT7QvoZdjvIjokG5RcJLIKsPhHMHDb
 VxfqznAZ8EQ3CW47qn/HWgsRXfWlTuEtMr4WSRR+FWkTCkqMeIhX4dYIR
 NKjuAs2xtB6EYEmgWKXjirNNHdgploGBJ7h0PD+62xsXgEEjMjl4xv4JA A==;
X-CSE-ConnectionGUID: MPHF9G6YTyK61C5KK4TVzQ==
X-CSE-MsgGUID: dk47ehrwS8idmB9VYiVpWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18743737"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="18743737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 08:55:01 -0700
X-CSE-ConnectionGUID: 2Us6OEw8Rd6FZEhJVEzsuw==
X-CSE-MsgGUID: 5U/udOlBQVeQubgAu3I7zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50788355"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 08:54:58 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 5/9] target/i386/kvm: Drop workaround for
 KVM_X86_DISABLE_EXITS_HTL typo
Date: Wed, 17 Jul 2024 00:10:11 +0800
Message-Id: <20240716161015.263031-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

The KVM_X86_DISABLE_EXITS_HTL typo has been fixed in commit
77d361b13c19 ("linux-headers: Update to kernel mainline commit
b357bf602").

Drop the related workaround.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64e54beac7b3..4aae4ffc9ccd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2728,10 +2728,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     if (enable_cpu_pm) {
         int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
-/* Work around for kernel header with a typo. TODO: fix header and drop. */
-#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
-#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
-#endif
         if (disable_exits) {
             disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                               KVM_X86_DISABLE_EXITS_HLT |
-- 
2.34.1


