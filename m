Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6D3EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkk-0005P7-FS; Wed, 04 Mar 2026 13:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkg-0005MM-1K
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:18 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkc-0004eH-JZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648115; x=1804184115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B0G4zOn0Aq8wL+6thBXZpp/WgAVLsoCHdMf7+BmI3vw=;
 b=UKbocwRMsFAB+EKWZZYm/QSRRZzypJS3s3KrnpraEX2Uaj8lB3EHnpnQ
 a0kTn0jrquwhWnvwYGgt/ISJyUv8keD4scI75mdqM/n1maV4YFanrQZIj
 +2J3cfOo4++5aXJXIvqoJVlsrAp8aYphjkveA8lIHA56lryILCOKA1rHV
 pqAxNMB0XmjaWSxfj/uJxqTNhniV8PFiMV7CkC0vaPGOBCLOi8xLALNMb
 Ub8tHwVDBisOqYF3LoJjBweYfAp9FGs/sk2zvMFcprwUzsx7Ssy2ubPrM
 zsT860G0oWXuzhOX9I5wLMeKnMd1WdjGUUf62GgTLvQAC+cJUeM5ui8pi A==;
X-CSE-ConnectionGUID: xBydKoMoQ0e9LsiD2hz03Q==
X-CSE-MsgGUID: WoxUXGMVRui795AXOAwXrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909272"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:05 -0800
X-CSE-ConnectionGUID: p5I6NyclTCmZ4If9YJ49nQ==
X-CSE-MsgGUID: festpwoYQguhSWKRf0ptYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542769"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:04 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
Date: Wed,  4 Mar 2026 10:07:00 -0800
Message-ID: <20260304180713.360471-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
(bit 11), is deprecated and has been superseded by LBR and Intel PT.

KVM yields control of this bit to userspace since KVM commit
9fc222967a39 ("KVM: x86: Give host userspace full control of
MSR_IA32_MISC_ENABLES").

However, QEMU does not set this bit, which allows guests to write the
BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
this may lead to unexpected MSR access errors.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Add two Reviewed-by.

V2:
- Address review comments.
- Remove mention of VMState version_id from the commit message.
---
 target/i386/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f222a0c9fe0..016fb1b30bbd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -474,8 +474,11 @@ typedef enum X86Seg {
 
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
-#define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
+#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     | \
+                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
2.53.0


