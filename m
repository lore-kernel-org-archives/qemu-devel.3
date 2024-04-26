Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0F2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0IGi-0003b7-Ae; Fri, 26 Apr 2024 05:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGe-0003YF-KW
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:20 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGd-0006AG-37
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714125199; x=1745661199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e+wzAqKxUeDUa8pgRYNdxpSqCSHlDsBB3q4TuojcMl4=;
 b=icOwCLYZvW1uqq+PcLBNnj9NkzZWPg7WgzFwZTxjPuHIxbqWK7MPwpuY
 yhiDeYZrj1KMszNImXoApNygrLCjl1/J0TVy5tea2rMS8z8VxXQhkP2xy
 R7DoI/lNO8F9D+Qs5husEewY+fQPrYOhzys5opkST98TQASvuJ6K85EeP
 S/rQL+VT/aIHm9vModpC+jO3PwP/zt6pDDCW3kInIV8em5+ykuu2nFU45
 Leu9Utr6+QnCpzmCYR/H/pQ3OPyu0uQQ68zingRTomKEt5n+HwFAPLnVm
 oANTgDuVz8FTCoqpdN2dAQH0+lBFB6vpknM5SI+OZRFDTsVrE+H2LhLLG A==;
X-CSE-ConnectionGUID: bBKLPSUMQXSges7hGfq37A==
X-CSE-MsgGUID: RtAnJG3KS3e97IGn/Gc5Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9707405"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9707405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 02:53:18 -0700
X-CSE-ConnectionGUID: 9bVs7V2VS4GVZosEHzSEng==
X-CSE-MsgGUID: NtGGV9tXTFuXChK71Hdowg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; d="scan'208";a="25412319"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2024 02:53:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/6] target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
 MSR_KVM_SYSTEM_TIME definitions
Date: Fri, 26 Apr 2024 18:07:11 +0800
Message-Id: <20240426100716.2111688-3-zhao1.liu@intel.com>
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

These 2 MSRs have been already defined in the kvm_para header
(standard-headers/asm-x86/kvm_para.h).

Remove QEMU local definitions to avoid duplication.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d9e03891113f..b2c52ec9561f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -79,9 +79,6 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-#define MSR_KVM_WALL_CLOCK  0x11
-#define MSR_KVM_SYSTEM_TIME 0x12
-
 /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
-- 
2.34.1


