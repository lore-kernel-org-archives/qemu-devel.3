Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F8ED5B86B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 19:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEQK-00015G-NJ; Mon, 15 Dec 2025 14:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQH-0000zg-Mq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:39:57 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQF-0006XN-NR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=gSuMeTJCMlZsr1IIXsHN+X4CV1w2t/kQ/RlHUS2pMfI=; b=u11ssUHlc3pbS5N
 2GWjkLlgUdDOd1G552jGoYr4yg0Ebf1U/PoZ/Ny+O2IzC0EYM//Yzj4BOUgJFxI3KCdTLCi9XGCra
 ToB8363pJx8QPik1RYROO3vrWcqYE7mR3+vRO/b7uG2v+OOzHiU0VakB+c1wuV68JVJByTrIcaNMh
 Rg=;
Date: Mon, 15 Dec 2025 20:42:52 +0100
Subject: [PATCH v2 3/7] target/i386: Drop physical address range checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-phys_addr-v2-3-633aa1d922cd@rev.ng>
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

Since TARGET_PHYS_ADDR_SPACE_BITS is now fixed to 64 bits for all
targets we can remove range checks on cpu->phys_bits and
TCG_PHYS_ADDR_BITS.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/i386/tcg/helper-tcg.h | 2 --
 target/i386/cpu.c            | 9 +++------
 target/i386/kvm/kvm.c        | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index e41cbda407..f4b2ff740d 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -31,8 +31,6 @@
 # define TCG_PHYS_ADDR_BITS 36
 #endif
 
-QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
-
 /**
  * x86_cpu_do_interrupt:
  * @cpu: vCPU the interrupt is to be handled by.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..0eeceed7cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9435,12 +9435,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * accel-specific code in cpu_exec_realizefn.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        if (cpu->phys_bits &&
-            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
-            cpu->phys_bits < 32)) {
-            error_setg(errp, "phys-bits should be between 32 and %u "
-                             " (but is %u)",
-                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
+        if (cpu->phys_bits && cpu->phys_bits < 32) {
+            error_setg(errp, "phys-bits should be at least 32"
+                             " (but is %u)", cpu->phys_bits);
             return;
         }
         /*
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..edfff01d64 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4681,8 +4681,7 @@ static int kvm_get_msrs(X86CPU *cpu)
      */
 
     if (cpu->fill_mtrr_mask) {
-        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
-        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
+        assert(cpu->phys_bits <= 52);
         mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
     } else {
         mtrr_top_bits = 0;

-- 
2.51.0


