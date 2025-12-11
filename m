Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9094DD3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaQy-0001uY-M6; Thu, 11 Dec 2025 01:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQZ-0001kb-Gs
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:39 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQX-00067P-TC
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435527; x=1796971527;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CFa6/whO2jUKzVYTeIsLH5faSzFY4R8NNpzl+PRAX4Y=;
 b=a91xrcE4IZSwYY3DByU0DD1XLgKsaJSWiTSPFhrTFpapBXDa/lcKfn3R
 T6zCDBdRq7Oo/yjGaJDiPSIJVttPoCQ9UOHSnqZoSOQk5xYyXcqO40M7M
 1WuX+J4ulaIME8pnufn56KsVOhhm/VXxIhzF8WUsdFQSOnvIEzO+cHWex
 Pu//XyxZTgxsC6x6NLZ0yuYYcrCUCPcNBH/svr2kbPG2WkcoiYFlq5z6Z
 zHQa+Ml5mXdZ5tcyLU0uENDTgJWh5Pjk3o85A/JfCeCa1qoU+LSn99eGU
 /q0RBi5UBUnnhyvc7ALatfhIxbdjm/5NcnR/h7O4mDuQsm/fW+bGFGBey g==;
X-CSE-ConnectionGUID: mDoJryzfT8eH/cnneO3I1w==
X-CSE-MsgGUID: ultxyI1ZQGeG3+BfhEQAgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584459"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584459"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:26 -0800
X-CSE-ConnectionGUID: 4sJvJOJHQF2hRNS+dBsaMw==
X-CSE-MsgGUID: xBF87zguSUaD29drkk+LXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196494997"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:22 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 5/9] i386/cpu-dump: Dump entended GPRs for APX supported
 guest
Date: Thu, 11 Dec 2025 15:09:38 +0800
Message-Id: <20251211070942.3612547-6-zhao1.liu@intel.com>
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

Dump EGPRs when guest supports APX.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New patch.
---
 target/i386/cpu-dump.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 67bf31e0caaf..b51076f87115 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -354,8 +354,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
                      "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
                      "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
-                     "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
-                     "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                     "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n",
                      env->regs[R_EAX],
                      env->regs[R_EBX],
                      env->regs[R_ECX],
@@ -371,7 +370,32 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      env->regs[12],
                      env->regs[13],
                      env->regs[14],
-                     env->regs[15],
+                     env->regs[15]);
+
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APX) {
+            qemu_fprintf(f, "R16=%016" PRIx64 " R17=%016" PRIx64 " R18=%016" PRIx64 " R19=%016" PRIx64 "\n"
+                         "R20=%016" PRIx64 " R21=%016" PRIx64 " R22=%016" PRIx64 " R23=%016" PRIx64 "\n"
+                         "R24=%016" PRIx64 " R25=%016" PRIx64 " R26=%016" PRIx64 " R27=%016" PRIx64 "\n"
+                         "R28=%016" PRIx64 " R29=%016" PRIx64 " R30=%016" PRIx64 " R31=%016" PRIx64 "\n",
+                         env->regs[16],
+                         env->regs[17],
+                         env->regs[18],
+                         env->regs[19],
+                         env->regs[20],
+                         env->regs[21],
+                         env->regs[22],
+                         env->regs[23],
+                         env->regs[24],
+                         env->regs[25],
+                         env->regs[26],
+                         env->regs[27],
+                         env->regs[28],
+                         env->regs[29],
+                         env->regs[30],
+                         env->regs[31]);
+        }
+
+        qemu_fprintf(f, "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
                      env->eip, eflags,
                      eflags & DF_MASK ? 'D' : '-',
                      eflags & CC_O ? 'O' : '-',
-- 
2.34.1


