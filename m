Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2D9CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9H-0001zZ-Bd; Sun, 19 Oct 2025 11:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9F-0001z2-D6
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:41 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9D-0003CP-QF
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:41 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id AB3CA60A75
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:38 +0200 (CEST)
Received: (qmail 23227 invoked by uid 990); 19 Oct 2025 15:16:38 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:34 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v8 11/25] target/m68k: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:00 +0200
Message-ID: <5443bb9ab89d96f0f8670060734226f04d40a668.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999873) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=FRZ2j8rbmm/3ycj8ZP5YixYFG9zzEquVSOdWN5ofsr0=;
 b=qg2jRGMaQxgS4v8H3+1EeJkm+IB50WNekO6ukmyHdGuRdxcYUvG6S3dhKxTC9OqBVWsQth7iJ9
 UfPDX6kKpHEoJ0uDqc/7CUntmXTx3DJbxd/IjESRYggl+/Iwifbre8p64reXv4kWEIDuKOqZoQ7J
 7c27lSkc2V0h/OZkszQpBiJkeOBWv0/TlPvmvux12+QVVgTnCOY343uSOqjqqWOGWGUs/vDao03N
 KyIOzlWUieSX4QewVwjwennp95XeO+Sw9VMHJ38ETxih1OATZ42U6sFniqWz9w10SlJreJoRT8Hl
 747XehRdjohIsmZeGRM9HsNf4K3LtqG3EgwGJxM5wi/DKubl7TLkoijL+Rdq0j/4QsTfqQBMqbn7
 6JtWOYnBy/sxmWVjfHbJ6/Giqxftab8lpb8d9dPozhldtadX6NhqNOMdlz/2fZt1B+Sch8O97vtW
 0rC4qtMnsfNWK5ON9BsygmmS/LJNHncr7gqZHeMzU3m2/oP7W9R1eg1hFQCPsQKQ/9ZPiKv+I5GO
 sic6N64GfMjo/ySKijaiMOUoF3OrWbh9E9NVOWEch7mHyFQDZ/yOCSmvjBAhLkp982SQ0/aZot8l
 wcS10EXc+ErGkKMTB/VRbwku0lAU/mnj344gnCtKLTlWZM87dg+U1n2Z09si91ufW9AqhKmHYs/x
 k=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Motorola 68000 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/m68k/op_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af8..e9c20a8e03 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 
@@ -183,6 +184,21 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    case EXCP_SEMIHOSTING:
+        qemu_plugin_vcpu_hostcall_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+        break;
+    }
+}
+
 static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = env_cpu(env);
@@ -203,6 +219,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             return;
         case EXCP_SEMIHOSTING:
             do_m68k_semihosting(env, env->dregs[0]);
+            qemu_plugin_vcpu_hostcall_cb(cs, retaddr);
             return;
         }
     }
@@ -239,6 +256,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, retaddr);
 }
 
 static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
@@ -277,6 +296,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     uint32_t sp;
     uint32_t vector;
     uint16_t sr, oldsr;
+    uint64_t last_pc = env->pc;
 
     if (!is_hw) {
         switch (cs->exception_index) {
@@ -417,6 +437,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
-- 
2.49.1


