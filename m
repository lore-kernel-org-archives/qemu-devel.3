Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77BCC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHoiQ-0004jQ-SY; Wed, 21 May 2025 15:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1uHoiO-0004ik-Am; Wed, 21 May 2025 15:02:56 -0400
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1uHoiM-0004mB-3S; Wed, 21 May 2025 15:02:56 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1747854169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gbo7c8K7ZQW1KsUAQVl9YazIunWDHbR+34oXLOE67OM=;
 b=NeLXob/mo++FupiN9iUyB9N+4YcJh3pzi+G04gcKyCIWnK2zFXw7rOsCiNSY1BU0wZpugH
 boDpUT/PTmhtf3+aPLiKKshFY05rx8Px69549HWh7a5NzTr4/6rnB2OyLNT7EtjJFuwYr0
 +sxL0l6GwUq3EbFVmT3CUa6FvQ9Je3E=
From: Oliver Upton <oliver.upton@linux.dev>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH] target/arm: Ignore SCTLR_EL2.EnSCXT when !ELIsInHost()
Date: Wed, 21 May 2025 12:02:28 -0700
Message-Id: <20250521190228.3921172-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b0;
 envelope-from=oliver.upton@linux.dev; helo=out-176.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Using an EL2 that enables SCXTNUM_ELx for guests while disabling the
feature for the host generates erroneous traps to EL2 when running under
TCG.

Fix the issue by only evaluating SCTLR_EL2.EnSCXT when ELIsInHost().

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 target/arm/helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7631210287..83d4236417 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7389,16 +7389,16 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
     int el = arm_current_el(env);
+    uint64_t sctlr;
 
-    if (el == 0 && !((hcr & HCR_E2H) && (hcr & HCR_TGE))) {
-        if (env->cp15.sctlr_el[1] & SCTLR_TSCXT) {
-            if (hcr & HCR_TGE) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-            return CP_ACCESS_TRAP_EL1;
+    sctlr = el_is_in_host(env, el) ? env->cp15.sctlr_el[2] :
+            env->cp15.sctlr_el[1];
+
+    if (el == 0 && (sctlr & SCTLR_TSCXT)) {
+        if (hcr & HCR_TGE) {
+            return CP_ACCESS_TRAP_EL2;
         }
-    } else if (el < 2 && (env->cp15.sctlr_el[2] & SCTLR_TSCXT)) {
-        return CP_ACCESS_TRAP_EL2;
+        return CP_ACCESS_TRAP_EL1;
     }
     if (el < 2 && arm_is_el2_enabled(env) && !(hcr & HCR_ENSCXT)) {
         return CP_ACCESS_TRAP_EL2;
-- 
2.39.5


