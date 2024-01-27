Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB19C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 20:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTpIa-0006bw-St; Sat, 27 Jan 2024 15:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rTpIZ-0006bo-JQ
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 15:29:07 -0500
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rTpIW-00013M-GM
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 15:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=1HIHiy7HMlvUkBbOEZVtp0yJrw7WkvidplMYQpfeo0g=; b=ZgEzhubJbhHWvDf2LyzhhcFC8j
 YNrgfABR3Xvz44v7jtg+aTgIjdQeitYVUVmTjFB+bKnqQ2zuJMFMVtCp29A4cldR5LbmitjOIM0pM
 mPi6bRqH29q4xbQMSfwYK+204Ufm9q9qlwUCduYUqSirC0BPBzn473IsTnVEhYHSS8f2fYMN0DL66
 2PcuYzqGLCqUj07v5VaOm0oNp4m3Hh79AROf9mxoR6iyWMna2Nhgh/QLGv668mBJrcrKv003YTjYl
 ou2ZvDQK818O2hMZyIBBo8V9wpEqySQMCYnJVhWJVKmM/QTYdtz78Cdom7nNROrMJjQ+Ce2AmxdXe
 22foXR1Q==;
Received: from p578ec111.dip0.t-ipconnect.de ([87.142.193.17]
 helo=shark.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1rTpIS-0037zj-2P; Sat, 27 Jan 2024 21:29:00 +0100
From: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
Subject: [PATCH v2] target/arm: fix exception syndrome for AArch32 bkpt insn
Date: Sat, 27 Jan 2024 21:27:58 +0100
Message-Id: <20240127202758.3326381-1-jan.kloetzke@kernkonzept.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=jan.kloetzke@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Debug exceptions that target AArch32 Hyp mode are reported differently
than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
such exceptions need to be either converted to a prefetch abort
(breakpoints, vector catch) or a data abort (watchpoints).

Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
---
v2:
 * Refactor watchpoint syndrome rewriting
 * Drop ARM_EL_ISV from watchpoint syndrome

 target/arm/helper.c   | 18 ++++++++++++++++++
 target/arm/syndrome.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 945d8571a6..a0041aa0ec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11015,6 +11015,24 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     }
 
     if (env->exception.target_el == 2) {
+        /* Debug exceptions are reported differently on AArch32 */
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_BREAKPOINT:
+        case EC_BREAKPOINT_SAME_EL:
+        case EC_AA32_BKPT:
+        case EC_VECTORCATCH:
+            env->exception.syndrome = syn_insn_abort(arm_current_el(env) == 2,
+                                                     0, 0, 0x22);
+            break;
+        case EC_WATCHPOINT:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT);
+            break;
+        case EC_WATCHPOINT_SAME_EL:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT_SAME_EL);
+            break;
+        }
         arm_cpu_do_interrupt_aarch32_hyp(cs);
         return;
     }
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 1a49767479..3244e0740d 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -25,6 +25,8 @@
 #ifndef TARGET_ARM_SYNDROME_H
 #define TARGET_ARM_SYNDROME_H
 
+#include "qemu/bitops.h"
+
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
     EC_UNCATEGORIZED          = 0x00,
@@ -80,6 +82,7 @@ typedef enum {
     SME_ET_InactiveZA,
 } SMEExceptionType;
 
+#define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
@@ -94,6 +97,11 @@ static inline uint32_t syn_get_ec(uint32_t syn)
     return syn >> ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
+{
+    return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
+}
+
 /*
  * Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
-- 
2.39.2


