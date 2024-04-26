Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91538C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0IGs-0003dR-2J; Fri, 26 Apr 2024 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGp-0003cd-Fp
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGn-0006B7-AP
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714125209; x=1745661209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dbHgXYEF7kX6u5b8GXlmzpie+e+fbcRgQqzu6sj3a4E=;
 b=CKWP5U10V8bInzdemabY8QtI4mvFTVGh3hW+7xMnmELxbypAAQ/cK5eG
 i/trgiP7r+Su4QNQLsFx7yIns+/tzkP9Oip6HVSE/lTJvKSKQeal9Qlxq
 y3l4wisZ7ukckI5w7i7Hi/2k7Ne2mQSF8drFexRMdHf2XsHHCBlwg56O1
 lPxG5RzVbLwvIRSONv9sGreoGg4sEOWoTDM7EyaelgYTg6mKggH+sTdwL
 QFpmGonK/rOsDcSEUmGaX9XUh4LQNlWOr+SdjkMWGxbbH0xSwtnzzol9b
 I3H7E1SMhts63+xht0MgSQ9+w4jOJi48LZCb5Z8cY405TvXTRZM8eZSjL g==;
X-CSE-ConnectionGUID: r/y5o82RQ7Ki6xOPFhTxwg==
X-CSE-MsgGUID: vGfBvaVeSWqqd1Yr0qZp1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9707436"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9707436"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 02:53:29 -0700
X-CSE-ConnectionGUID: OE7Qb+3LS+qyruCuMTnl2g==
X-CSE-MsgGUID: xduA+Z6jRnO7PC9XvELYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; d="scan'208";a="25412339"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2024 02:53:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/6] target/i386/kvm: Drop workaround for
 KVM_X86_DISABLE_EXITS_HTL typo
Date: Fri, 26 Apr 2024 18:07:15 +0800
Message-Id: <20240426100716.2111688-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426100716.2111688-1-zhao1.liu@intel.com>
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
index ee0767e8f501..b3ce7da37947 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2692,10 +2692,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
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


