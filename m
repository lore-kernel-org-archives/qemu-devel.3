Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641E4D46C18
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnB-0008Ke-QV; Wed, 28 Jan 2026 18:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnA-0008J8-VL
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:44 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEn8-0001ir-6H
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642262; x=1801178262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cDOJd1yKGHPrdejhdewjiE4LxByY8+m66Yja9TVYMFo=;
 b=CFDKwq0mB75hASA+uPM/o15X6VsjRMsLIhXtpApoQ6BRYEMBpYhANBFf
 JuQTEKQu4fuB/wM90B4tEUihCuxveKmI8kbrKt6HoJ4Qj/p+V5pOBpOmX
 ZB2lcIbLxIofm4mGmtMoNY+uxnD4jMUvSqdiZ946PXxPoHHyGUCy0kJgR
 GVwCbecSaWntVZ/O9D2AQa1V//LEW8YUi/RzdypOxvOKITD17QgM2qfDx
 ZdZeuIpT466xeQxg+4ddqWJYTt2cJQdzl2c4FbkM5Kw/mginGGtByiJUW
 PeAGUCwq7PogYPmGRJ91HBPJjvRju4mEGGgrTM8B97/bVBRPgYmW0/eve Q==;
X-CSE-ConnectionGUID: clOX/zQGSw+wNNT6AaZFzQ==
X-CSE-MsgGUID: Qpm0qEpNRoSb8RZyvT/wGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462310"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462310"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:37 -0800
X-CSE-ConnectionGUID: thiR9T5xQ02UQxzDyTEXYA==
X-CSE-MsgGUID: BuWH7TluS5mABVm+PPRu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001760"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:36 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
Date: Wed, 28 Jan 2026 15:09:38 -0800
Message-ID: <20260128231003.268981-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
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

KVM yields control of the above mentioned bit to userspace since KVM
commit 9fc222967a39 ("KVM: x86: Give host userspace full control of
MSR_IA32_MISC_ENABLES").

However, QEMU does not set this bit, which allows guests to write the
BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
this may lead to unexpected MSR access errors.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Address Dapeng's comments.
- Remove mention of VMState version_id from the commit message.

 target/i386/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2bbc977d9088..f02812bfd19f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -474,8 +474,11 @@ typedef enum X86Seg {
 
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
-#define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
+#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
+                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
2.52.0


