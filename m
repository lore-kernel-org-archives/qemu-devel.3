Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ADAC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxS-0002Wf-6Q; Tue, 23 Jul 2024 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJws-0001Bu-Np
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwo-0001Cz-LY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:18 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39a14247eddso315675ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758145; x=1722362945;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iERzhBKroDxEdhIs7F3pdJn/htP75xFz5hRc3MKZk4Y=;
 b=DlFapkaRc8OVmTFV1je8J7+vV78R4l8gpedwQXWXo71KBYOJ/z5beG1o6SnE8GHGEg
 DJSCxY6nJ7ycZIPWhxV0RpfaWrk5CnpLSYiKktTguqGOQXyHZ23Qchj93ILxiiHywAHb
 RAhzwpWmdw5Zk9c+ZCYtq8X37hhfaMJ7p4ZGOu9B5uURW3p/N6zYqRT+kfRzqozYkA6e
 1vk9mWmCoaOiD6EhbLfI8dsIzGc7ZAUuT32J8imNd7d0qpCMAfFHjEEI+x5BrP/VCTLK
 /RZb5vb/AyjSxCtV0pnWDTRf8i5lE9yOTYOkJG12T4DDvrs7t/vVVhRybfDOzpDNkFVj
 4c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758145; x=1722362945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iERzhBKroDxEdhIs7F3pdJn/htP75xFz5hRc3MKZk4Y=;
 b=BX1zXaB9ulLjuWaCrFqrRWvkTBYVd/BXcb7Gldr7U56a3Xq/jTQxz2kRIW/FHsvQ0c
 /gYHAOpq3zFSaL24AzhZhGuSV/jiqpXiLy1N59Cy2DiJtxPZ8Jf3SykXgkAQZBI6Ap/b
 ZMBV0GM7qjVJJ4T8XeeQHGWRTs2iA2C+o1xwKyGryVlzLnFtTL0oiWEnvjjm+0vWzdZP
 gzoVofeReJdXo+ZffvCIN50Dx0ZIUTqsdlwhOnYmxmowoF4BQvN8aWOjRWUnpwscX9Fz
 Mq1mLnFSc2BzgI3sjqI5J78iB1iORxV5PWVqfB93C73T8P3al1gwCKZ64W0l4yQbvz+X
 HDtw==
X-Gm-Message-State: AOJu0Yx+zzozt4w5U5LcWOCyqDJ9KANvVLlocfjzneV8CK9HplQoVQAb
 tX89T6E83xmXQNSRmrqWLEvlbdNo1iP7mQvYoF3jaJi2sYpFF5jnTL5SeghM2vLLS7fjFx+eD0I
 Zf/E=
X-Google-Smtp-Source: AGHT+IH8IJQGqhfqRcpsRu/nnra5WdISHNm+D6A2wiX5QGDYVJ+wORToh5HUSIK/Un0Ey+bKdczxrQ==
X-Received: by 2002:a05:6e02:1a87:b0:382:325c:f7bd with SMTP id
 e9e14a558f8ab-39a0e379111mr26868585ab.10.1721758145388; 
 Tue, 23 Jul 2024 11:09:05 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/14] bsd-user:Add AArch64 improvements and signal handling
 functions
Date: Tue, 23 Jul 2024 12:07:19 -0600
Message-ID: <20240723180725.99114-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Added get_ucontext_sigreturn function to check processor state ensuring current execution mode is EL0 and no flags
indicating interrupts or exceptions are set.
Updated AArch64 code to use CF directly without reading/writing the entire processor state, improving efficiency.
Changed FP data structures to use Int128 instead of __uint128_t, leveraging QEMU's generic mechanism for referencing this type.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-9-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c             | 20 +++++++++++++++++++-
 bsd-user/aarch64/target_arch_cpu.h    |  7 ++-----
 bsd-user/aarch64/target_arch_reg.h    |  2 +-
 bsd-user/aarch64/target_arch_signal.h |  2 +-
 bsd-user/qemu.h                       |  3 +++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 13faac8ce60..6bc73a798f3 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 
 /*
- * Compare to sendsig() in sys/arm64/arm64/machdep.c
+ * Compare to sendsig() in sys/arm64/arm64/exec_machdep.c
  * Assumes that target stack frame memory is locked.
  */
 abi_long set_sigtramp_args(CPUARMState *regs, int sig,
@@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
 
     return err;
 }
+
+/* Compare to sys_sigreturn() in  arm64/arm64/machdep.c */
+abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_sf,
+                                abi_ulong *target_uc)
+{
+    uint32_t pstate = pstate_read(regs);
+
+    *target_uc = 0;
+
+    if ((pstate & PSTATE_M) != PSTATE_MODE_EL0t  ||
+        (pstate & (PSTATE_F | PSTATE_I | PSTATE_A | PSTATE_D)) != 0) {
+        return -TARGET_EINVAL;
+    }
+
+    *target_uc = target_sf;
+
+    return 0;
+}
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 5c150bb7e9c..b288e0d069b 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -48,7 +48,6 @@ static inline void target_cpu_loop(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     int trapnr, ec, fsc, si_code, si_signo;
     uint64_t code, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8;
-    uint32_t pstate;
     abi_long ret;
 
     for (;;) {
@@ -88,18 +87,16 @@ static inline void target_cpu_loop(CPUARMState *env)
              * The carry bit is cleared for no error; set for error.
              * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
              */
-            pstate = pstate_read(env);
             if (ret >= 0) {
-                pstate &= ~PSTATE_C;
+                env->CF = 0;
                 env->xregs[0] = ret;
             } else if (ret == -TARGET_ERESTART) {
                 env->pc -= 4;
                 break;
             } else if (ret != -TARGET_EJUSTRETURN) {
-                pstate |= PSTATE_C;
+                env->CF = 1;
                 env->xregs[0] = -ret;
             }
-            pstate_write(env, pstate);
             break;
 
         case EXCP_INTERRUPT:
diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
index 5c7154f0c18..b53302e7f7a 100644
--- a/bsd-user/aarch64/target_arch_reg.h
+++ b/bsd-user/aarch64/target_arch_reg.h
@@ -31,7 +31,7 @@ typedef struct target_reg {
 } target_reg_t;
 
 typedef struct target_fpreg {
-    __uint128_t     fp_q[32];
+    Int128          fp_q[32];
     uint32_t        fp_sr;
     uint32_t        fp_cr;
 } target_fpreg_t;
diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
index df171733166..bff752a67ab 100644
--- a/bsd-user/aarch64/target_arch_signal.h
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -49,7 +49,7 @@ struct target_gpregs {
 };
 
 struct target_fpregs {
-    __uint128_t fp_q[32];
+    Int128      fp_q[32];
     uint32_t    fp_sr;
     uint32_t    fp_cr;
     uint32_t    fp_flags;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 9d2fc7148eb..3736c417860 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -17,6 +17,9 @@
 #ifndef QEMU_H
 #define QEMU_H
 
+#include <sys/param.h>
+
+#include "qemu/int128.h"
 #include "cpu.h"
 #include "qemu/units.h"
 #include "exec/cpu_ldst.h"
-- 
2.45.1


