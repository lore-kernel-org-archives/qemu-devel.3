Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5862D3E797
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaR0-0001wS-9P; Thu, 11 Dec 2025 01:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQd-0001ks-Mf
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:42 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQb-00067P-LU
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435530; x=1796971530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d4fEjjgjaO1Mc5bLnP4bPrihTztTGRnCptHhP/Q5vnk=;
 b=iX08s+ysVRKNyoYi5oVFC098OHiGwsWqHpIElrDgC+00VIzhruuu3DN1
 zuur7TgirBKX/bNx/3gr7Pr5YlFcODWevgDLR6O+9Jy28zAkpP8a6091D
 ZpS/9UjjmvsPLNzIXh1HbPk9i8hTCahgFv7Ah61dwk/gOE/Dnwx9q/MLb
 txKoLsdDQJqVTUmRD4OdWqKvG6078BChKuT8nC/jugrDfN07zIMD51Fyi
 rdb6S1Nm0FLWhzxmi60M/AfKN1C7AVsQ2LU/kOVHJ85js+4WrLDq6Imye
 tAhHwC4mJXBC90nrW4AmKpzbUouyLgPkyKu65gmuQEKkbn+vkHmyNytt9 Q==;
X-CSE-ConnectionGUID: oNR8QO6SQha6HkccsA9+og==
X-CSE-MsgGUID: sbpvM61jTFS4kPOrIBttUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584467"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584467"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:29 -0800
X-CSE-ConnectionGUID: 52B2NNYHQ4GOo6aL5RfDfw==
X-CSE-MsgGUID: P3rtpxZpSCCAnIq8CXohyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196495009"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 6/9] i386/monitor: Support EGPRs in hmp_print
Date: Thu, 11 Dec 2025 15:09:39 +0800
Message-Id: <20251211070942.3612547-7-zhao1.liu@intel.com>
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

Add EGPRs in monitor_defs[] to allow HMP to access EGPRs.

For example,

(qemu) print $r16

Since monitor_defs[] is used for read-only case, no need to consider
xstate synchronization issues that might be caused by modifying EGPRs
(like what gdbstub did).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New patch.
---
 target/i386/monitor.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index d2bb873d4947..99b32cb7b0f3 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -623,6 +623,22 @@ const MonitorDef monitor_defs[] = {
     { "r13", offsetof(CPUX86State, regs[13]) },
     { "r14", offsetof(CPUX86State, regs[14]) },
     { "r15", offsetof(CPUX86State, regs[15]) },
+    { "r16", offsetof(CPUX86State, regs[16]) },
+    { "r17", offsetof(CPUX86State, regs[17]) },
+    { "r18", offsetof(CPUX86State, regs[18]) },
+    { "r19", offsetof(CPUX86State, regs[19]) },
+    { "r20", offsetof(CPUX86State, regs[20]) },
+    { "r21", offsetof(CPUX86State, regs[21]) },
+    { "r22", offsetof(CPUX86State, regs[22]) },
+    { "r23", offsetof(CPUX86State, regs[23]) },
+    { "r24", offsetof(CPUX86State, regs[24]) },
+    { "r25", offsetof(CPUX86State, regs[25]) },
+    { "r26", offsetof(CPUX86State, regs[26]) },
+    { "r27", offsetof(CPUX86State, regs[27]) },
+    { "r28", offsetof(CPUX86State, regs[28]) },
+    { "r29", offsetof(CPUX86State, regs[29]) },
+    { "r30", offsetof(CPUX86State, regs[30]) },
+    { "r31", offsetof(CPUX86State, regs[31]) },
 #endif
     { "eflags", offsetof(CPUX86State, eflags) },
     { "eip", offsetof(CPUX86State, eip) },
-- 
2.34.1


