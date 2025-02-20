Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D4CC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Iw-0006j7-KD; Thu, 20 Feb 2025 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9It-0006hh-Di
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Ir-0008Ag-JO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso7725155e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068492; x=1740673292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M19e+PGxgu5DfWMvIvwAvmoG0R/0pv2CefKQQu63HT4=;
 b=oTFbHNhAal/M9V+GrNnp9g0iRvVAVtLiwrl6uxUJIja1vHWVJgI+FXKyd0vkAO/dLK
 6Yf2MeOLVnJun5YrH9szFbg+7AjLpWf6qjv33qeC6/cc/OCFue9BmGekiphe6m5JAjQ5
 Rr1FNKTHlDNM2CrZJsFojjAWMXY6yv+uDVl/KYB/yh8QOyRC1bGjJ4FwE3ue4dM8UzG3
 9yH6Oug5MqdqMa35y/xcpbUwWvLNMBx9mmAuy7wYNqhSkNJ5Ut0G481dof+Lxr70YtDk
 2r4d2sus2ZCNbhs3RohqRjfryqOSgU/VZ0FfVhN1vBxKi1MyloWqKvkBQu8yQ5jyAVrr
 FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068492; x=1740673292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M19e+PGxgu5DfWMvIvwAvmoG0R/0pv2CefKQQu63HT4=;
 b=g8BQBwFycE0scV8y0sHVE6VpyCDv7FXB8byDNfunZdem/EQD1W9NLIv6GWBmWdVYJC
 HhKp0iEzcYBS4nkJBAkfL5Jx/r8alj48iRQNbxCJyot21w8k5fNZxXHYeOd/hfXUJehh
 RzH031dPhclVhu8bTDOYSLoCLAHySMGYtYlWHbhtqhJFBHomkHc6Z/eeZDF36WYFz9Y7
 5ohn574tRjS5Y9xB8cRgTaqtb3ONlZAgTmGCR5sG2UDTVlAqXfo3BAOGN1Pn9S0L+djo
 0KL43yo1kkaGLCqQHAgVRuM5fQPBaGIrIa0RluQnnz9FckvgeRi7SwR9jLeIKR34JtBD
 lvJg==
X-Gm-Message-State: AOJu0YyoGz5QzyVUu6em2zh3ELHPTkd14PsTMGkfdn2VZpo2fgQz1onA
 DpMUTgH160xTjweuRBvd9npdG65rmjyjoCkTwq5L9Bu0LJ5sxmJUG2xC/ckdbL8f46Fc3ZyBPHi
 Q
X-Gm-Gg: ASbGncvxfvokeCzF5UU0ivUJwEtM1u9XBlTpi4YTSoYBfwWeIO3aUEWpU9BHin6Uj/L
 gqkN5RLV214ydhDCCizBag0IdNa9oslaPAE1fevq73Y/Xf+Zn9cVt2b7yqf0IN5WOMFcBdZrsy3
 pxH+5BIUKhJfPW3URe1g5J/F5phcJOKHmhZ62VqFkSKal1HrTGqifH5EjFtQYv0fdAUhyFkp3pS
 G/jTNWi5h7C6ESaZ10Dz2MFBwwjsdlJ+WlF2X95xZDkfmprulRdzQZVOtxraIbuW6/nfMDlLpnS
 Rfga3cJQuuFTr0TrHWCm6Q==
X-Google-Smtp-Source: AGHT+IHbPhqHk8i/Y60pZB29JwQY1LSdObS/TiQ51OmMXXrI3CYHL9GpYlxCHVoiWDL4nlygIv/jyQ==
X-Received: by 2002:a05:600c:4ed4:b0:439:a25a:1686 with SMTP id
 5b1f17b1804b1-439a25a1819mr33723965e9.25.1740068492068; 
 Thu, 20 Feb 2025 08:21:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be
 Monitor traps
Date: Thu, 20 Feb 2025 16:20:46 +0000
Message-ID: <20250220162123.626941-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In system register access pseudocode the common pattern for
AArch32 registers with access traps to EL3 is:

at EL1 and EL2:
  if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR == 1) then
     AArch64.AArch32SystemAccessTrap(EL3, 0x03);
  elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();
at EL3:
  if (PSTATE.M != M32_Monitor) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();

(taking as an example the ERRIDR access pseudocode).

This implements the behaviour of (in this case) SCR.TERR that
"Accesses to the specified registers from modes other than Monitor
mode generate a Monitor Trap exception" and of SCR_EL3.TERR that
"Accesses of the specified Error Record registers at EL2 and EL1
are trapped to EL3, unless the instruction generates a higher
priority exception".

In QEMU we don't implement this pattern correctly in two ways:
 * in access_check_cp_reg() we turn the CP_ACCESS_TRAP_EL3 into
   an UNDEF, not a trap to Monitor mode
 * in the access functions, we check trap bits like SCR.TERR
   only when arm_current_el(env) < 3 -- this is correct for
   AArch64 EL3, but misses the "trap non-Monitor-mode execution
   at EL3 into Monitor mode" case for AArch32 EL3

In this commit we fix the first of these two issues, by
making access_check_cp_reg() handle CP_ACCESS_TRAP_EL3
as a Monitor trap. This is a kind of exception that we haven't
yet implemented(!), so we need a new EXCP_MON_TRAP for it.

This diverges from the pseudocode approach, where every access check
function explicitly checks for "if EL3 is AArch32" and takes a
monitor trap; if we wanted to be closer to the pseudocode we could
add a new CP_ACCESS_TRAP_MONITOR and make all the accessfns use it
when appropriate.  But because there are no non-standard cases in the
pseudocode (i.e.  where either it raises a Monitor trap that doesn't
correspond to an AArch64 SystemAccessTrap or where it raises a
SystemAccessTrap that doesn't correspond to a Monitor trap), handling
this all in one place seems less likely to result in future bugs
where we forgot again about this special case when writing an
accessor.

(The cc of stable here is because "hw/intc/arm_gicv3_cpuif: Don't
downgrade monitor traps for AArch32 EL3" which is also cc:stable
will implicitly use the new EXCP_MON_TRAP code path.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-6-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 11 +++++++++++
 target/arm/tcg/op_helper.c | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6f6cf5c888b..83ceaa58c2c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -62,6 +62,7 @@
 #define EXCP_NMI            26
 #define EXCP_VINMI          27
 #define EXCP_VFNMI          28
+#define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4a0db087dd0..2bf39a2051d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9684,6 +9684,7 @@ void arm_log_exception(CPUState *cs)
             [EXCP_NMI] = "NMI",
             [EXCP_VINMI] = "Virtual IRQ NMI",
             [EXCP_VFNMI] = "Virtual FIQ NMI",
+            [EXCP_MON_TRAP] = "Monitor Trap",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -10250,6 +10251,16 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         mask = CPSR_A | CPSR_I | CPSR_F;
         offset = 0;
         break;
+    case EXCP_MON_TRAP:
+        new_mode = ARM_CPU_MODE_MON;
+        addr = 0x04;
+        mask = CPSR_A | CPSR_I | CPSR_F;
+        if (env->thumb) {
+            offset = 2;
+        } else {
+            offset = 4;
+        }
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1161d301b71..1ba727e8e9f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -758,6 +758,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     CPAccessResult res = CP_ACCESS_OK;
     int target_el;
+    uint32_t excp;
 
     assert(ri != NULL);
 
@@ -851,8 +852,18 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     }
 
  fail:
+    excp = EXCP_UDEF;
     switch (res & ~CP_ACCESS_EL_MASK) {
     case CP_ACCESS_TRAP:
+        /*
+         * If EL3 is AArch32 then there's no syndrome register; the cases
+         * where we would raise a SystemAccessTrap to AArch64 EL3 all become
+         * raising a Monitor trap exception. (Because there's no visible
+         * syndrome it doesn't matter what we pass to raise_exception().)
+         */
+        if ((res & CP_ACCESS_EL_MASK) == 3 && !arm_el_is_aa64(env, 3)) {
+            excp = EXCP_MON_TRAP;
+        }
         break;
     case CP_ACCESS_TRAP_UNCATEGORIZED:
         /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
@@ -888,7 +899,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         g_assert_not_reached();
     }
 
-    raise_exception(env, EXCP_UDEF, syndrome, target_el);
+    raise_exception(env, excp, syndrome, target_el);
 }
 
 const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
-- 
2.43.0


