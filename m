Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC1D5B86C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 19:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEQM-00017s-1F; Mon, 15 Dec 2025 14:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQI-00012a-Vs
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:39:59 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQG-0006XD-2l
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Sl9uDZgG/YOVTATFnr0+sDvBRh8u9n6793uBQguCpQ4=; b=E3LoXV7lTePv57j
 2LFQ8eyH7kHm3poowHlyshVjqwvPcFfnYT01kR3oZc5Ab5H/hGiqulT74D57PFhBpBTe3go6UVGl3
 5aNwBj1V3473LbtJogjHai16UPI4g/iew7cDpR5zLrNy8TH0yxBqFIdYwzJWhQqx3l56Gr+SDbLq1
 1E=;
Date: Mon, 15 Dec 2025 20:42:50 +0100
Subject: [PATCH v2 1/7] target/alpha: Introduce
 alpha_phys_addr_space_bits()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-phys_addr-v2-1-633aa1d922cd@rev.ng>
References: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
In-Reply-To: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
a runtime function to correctly represent the size of the physical
address space for EV4-6 based on the current CPU version.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 linux-user/alpha/target_proc.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index da437ee0e5..6b491ffa3a 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -6,6 +6,27 @@
 #ifndef ALPHA_TARGET_PROC_H
 #define ALPHA_TARGET_PROC_H
 
+#include "qemu/osdep.h"
+#include "target/alpha/cpu.h"
+
+static uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
+{
+    switch (env->implver) {
+    case IMPLVER_2106x:
+        /* EV4 */
+        return 34;
+    case IMPLVER_21164:
+        /* EV5 */
+        return 40;
+    case IMPLVER_21264:
+    case IMPLVER_21364:
+        /* EV6 and EV7*/
+        return 44;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
     int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -57,7 +78,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
             "L1 Dcache\t\t: n/a\n"
             "L2 cache\t\t: n/a\n"
             "L3 cache\t\t: n/a\n",
-            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
+            model, TARGET_PAGE_SIZE, alpha_phys_addr_space_bits(cpu_env),
             max_cpus, num_cpus, cpu_mask);
 
     return 0;

-- 
2.51.0


