Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2467C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKak-0007iv-KL; Thu, 04 Jul 2024 07:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKai-0007bu-C7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:32 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKab-0002tZ-Dg
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:32 -0400
X-ASG-Debug-ID: 1720092315-086e2311061449f0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id 8NWS5QDzayiQXxoU (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 04 Jul 2024 19:25:15 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:14 +0800
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:14 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: EwanHai <ewanhai-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for Zhaoxin CPUs
Date: Thu, 4 Jul 2024 07:25:11 -0400
X-ASG-Orig-Subj: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin CPUs
Message-ID: <20240704112511.184257-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1720092315
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1065
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127153
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Zhaoxin CPUs handle the CMPLegacy bit in the same way
as Intel CPUs. This patch simplifies the existing logic by
using the IS_XXX_CPU macro and includes checks for Zhaoxin
vendor to align their behavior with Intel.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a3747fc487..c52a4cf3ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6945,9 +6945,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
          * So don't set it here for Intel to make Linux guests happy.
          */
         if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
+            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
                 *ecx |= 1 << 1;    /* CmpLegacy bit */
             }
         }
-- 
2.34.1


