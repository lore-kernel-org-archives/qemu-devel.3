Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADD3D3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaR1-0001wt-Ti; Thu, 11 Dec 2025 01:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQT-0001jI-Fh
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:22 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQR-00067P-QO
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435520; x=1796971520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QcNeiWPBJTnDHD4bocxcHnPK2Herab7VuYPe0hXd1Ec=;
 b=QpM+wsZ46pN9c3X+cvn3jP6pGSnVXyMG8fJJGu370QOi8gZsj6OxdIFu
 /QpwM9rph2pkOukG0w1upLUZdRFTEYsMIBtBQuH74wHtpSIUAT82kyoJT
 c8u2WkJgR4q9Za2f2ibGGxZtfrjAbWGUfm/jIlGqVBllhxDG73ZqNgBwN
 pWYkYRxesEX32CbqcHndPIJ1eyGkxFp/lfgkWXVaN+V8cjV/tLgXosyux
 guCG4FWbgL1MWDnHvWptzftXHaP7IE/ib/T5753sVgoMBzfZb7dJmPMpz
 KTgiSTyhTwrKeiqNoqrk2KiXzVdqgPGZ7PNAb0HkKxqG6SvnrBlxEsGri A==;
X-CSE-ConnectionGUID: MnHF+OCQT6iFGsIE1+qWlg==
X-CSE-MsgGUID: oHaH4iC7SKGUx+ids2Qzaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584435"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584435"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:19 -0800
X-CSE-ConnectionGUID: ZxeGGYAaRgWHAdhTim1vjw==
X-CSE-MsgGUID: sqYc29jNS3GluWcNGbyJzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196494962"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:15 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/9] i386/cpu: Cache EGPRs in CPUX86State
Date: Thu, 11 Dec 2025 15:09:36 +0800
Message-Id: <20251211070942.3612547-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211070942.3612547-1-zhao1.liu@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

From: Zide Chen <zide.chen@intel.com>

Expend general registers array "regs" of CPUX86State to cache entended
GPRs.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Extend "regs" array instead of a new array.
---
 target/i386/cpu.h          |  7 +++++--
 target/i386/xsave_helper.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 932982bd5dd6..9bf5d0b41efe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1664,12 +1664,15 @@ typedef struct {
     uint64_t mask;
 } MTRRVar;
 
+#define CPU_NB_EREGS64 32
 #define CPU_NB_REGS64 16
 #define CPU_NB_REGS32 8
 
 #ifdef TARGET_X86_64
+#define CPU_NB_EREGS CPU_NB_EREGS64
 #define CPU_NB_REGS CPU_NB_REGS64
 #else
+#define CPU_NB_EREGS CPU_NB_REGS32
 #define CPU_NB_REGS CPU_NB_REGS32
 #endif
 
@@ -1901,7 +1904,7 @@ typedef struct CPUCaches {
 
 typedef struct CPUArchState {
     /* standard registers */
-    target_ulong regs[CPU_NB_REGS];
+    target_ulong regs[CPU_NB_EREGS];
     target_ulong eip;
     target_ulong eflags; /* eflags register. During CPU emulation, CC
                         flags and DF are set to zero because they are
@@ -1958,7 +1961,7 @@ typedef struct CPUArchState {
     float_status mmx_status; /* for 3DNow! float ops */
     float_status sse_status;
     uint32_t mxcsr;
-    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32] QEMU_ALIGNED(16);
+    ZMMReg xmm_regs[CPU_NB_EREGS] QEMU_ALIGNED(16);
     ZMMReg xmm_t0 QEMU_ALIGNED(16);
     MMXReg mmx_t0;
 
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef5..bab22587320d 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -140,6 +140,14 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 
         memcpy(tiledata, &env->xtiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset && buflen) {
+        XSaveAPX *apx = buf + e->offset;
+
+        memcpy(apx, &env->regs[CPU_NB_REGS],
+               sizeof(env->regs[CPU_NB_REGS]) * (CPU_NB_EREGS - CPU_NB_REGS));
+    }
 #endif
 }
 
@@ -275,5 +283,13 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
 
         memcpy(&env->xtiledata, tiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset) {
+        const XSaveAPX *apx = buf + e->offset;
+
+        memcpy(&env->regs[CPU_NB_REGS], apx,
+               sizeof(env->regs[CPU_NB_REGS]) * (CPU_NB_EREGS - CPU_NB_REGS));
+    }
 #endif
 }
-- 
2.34.1


