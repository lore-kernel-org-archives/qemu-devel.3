Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E200C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5P-0008Ff-As; Tue, 16 Apr 2024 00:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5N-0008C0-5E
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5K-0007Aa-St
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so30376775ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240377; x=1713845177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGHcSo147SgN6rnFLSb3VGek6gUZYoiow/EIARfgQaI=;
 b=qnvBKeqvUCwKHGbcCgTHflcOR52tZpqyQ3ziHizT+ldJO9Z2Xe72jluHKDGdjStJPX
 2lVqogXRpVUiU3Nrl3iVM5AmaS/P7Dl4VKd0GwFBG0xqsDO3Nc/NHy4YPn6GZmYYtPUv
 ZgUQ8ofPQfp9mFnSzz5huoXWdWzSJUaMVdy5KcKu0PCdpUYDvsL/GggYmkWrQJt9K11y
 6Fw7QXaiqWidt6V+HJkx4bg0+rYFk6dm7/rPGNSCwmTJLwH4g1ucFOPezP6NCemyLx19
 VtVBQ7iI4TiXU84Z7ng4QblT42b44e0wwkI9DTbjKhuyDbGoa2GFxPhwLyzSWI9+JtY9
 v4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240377; x=1713845177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGHcSo147SgN6rnFLSb3VGek6gUZYoiow/EIARfgQaI=;
 b=cx9bqepdFcVCV54jYIZnzyIUloNCnf5hbGxXt7F6/AwbxwZKvkwzVUyAfQ/x15usfV
 tGzFkd0MIYHGmIcuZEFD7JK10a/87HP0INZ7Gziz1dXrG23onB1VxaZWVTlgorx/cJ/W
 bGyzDBsGJhFfkvexaUmM9P9tWPMY3Kro/g4v8ZOasAinSU1tHefauI5ebThTgLpxQEIi
 6d5JEMyHTRZDgaQylw9XDViwqgXEy1i7F8bSoZRuC67CAIjhzEBT5GCnQbU7XK8tp8iW
 Gcv8WBgNsWXViUzvMSwOzWRbFx0NbI3F/U1sm3XI1BoAN50CRWk04j/XREIwQzVXSwxH
 V78A==
X-Gm-Message-State: AOJu0YzYPeMDB1MdfmF6tAM1g0qbLgsdDBZF8fRY6cp1ZkZU6+t+EyEq
 cDqJnsGHHP7IxIlBfMqVDwYi0MgDj0I4dsewgpJSUPg/ICYPDRhVPeSw62PpzWjEk9xqzaDNM36
 n
X-Google-Smtp-Source: AGHT+IFHSl4pIJ3RQk0j5ij5rqS3i2lJqANY3IMNaWQosD3WTiI19+ZfVg5NraQMgWrTXuEhdSsacQ==
X-Received: by 2002:a17:903:41c7:b0:1e3:ce12:ef77 with SMTP id
 u7-20020a17090341c700b001e3ce12ef77mr1256616ple.11.1713240377293; 
 Mon, 15 Apr 2024 21:06:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 7/7] target/i386: Implement TCGCPUOps for plugin register reads
Date: Mon, 15 Apr 2024 21:06:09 -0700
Message-Id: <20240416040609.1313605-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/tcg-cpu.c | 72 ++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e..2370053df2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -22,9 +22,11 @@
 #include "helper-tcg.h"
 #include "qemu/accel.h"
 #include "hw/core/accel-cpu.h"
-
+#include "gdbstub/helpers.h"
+#include "gdb-internal.h"
 #include "tcg-cpu.h"
 
+
 /* Frob eflags into and out of the CPU temporary format.  */
 
 static void x86_cpu_exec_enter(CPUState *cs)
@@ -61,38 +63,74 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
     }
 }
 
-static void x86_restore_state_to_opc(CPUState *cs,
-                                     const TranslationBlock *tb,
-                                     const uint64_t *data)
+static uint64_t eip_from_unwind(CPUX86State *env, const TranslationBlock *tb,
+                                uint64_t data0)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    int cc_op = data[1];
     uint64_t new_pc;
 
     if (tb_cflags(tb) & CF_PCREL) {
         /*
-         * data[0] in PC-relative TBs is also a linear address, i.e. an address with
-         * the CS base added, because it is not guaranteed that EIP bits 12 and higher
-         * stay the same across the translation block.  Add the CS base back before
-         * replacing the low bits, and subtract it below just like for !CF_PCREL.
+         * data[0] in PC-relative TBs is also a linear address,
+         * i.e. an address with the CS base added, because it is
+         * not guaranteed that EIP bits 12 and higher stay the
+         * same across the translation block.  Add the CS base
+         * back before replacing the low bits, and subtract it
+         * below just like for !CF_PCREL.
          */
         uint64_t pc = env->eip + tb->cs_base;
-        new_pc = (pc & TARGET_PAGE_MASK) | data[0];
+        new_pc = (pc & TARGET_PAGE_MASK) | data0;
     } else {
-        new_pc = data[0];
+        new_pc = data0;
     }
     if (tb->flags & HF_CS64_MASK) {
-        env->eip = new_pc;
-    } else {
-        env->eip = (uint32_t)(new_pc - tb->cs_base);
+        return new_pc;
     }
+    return (uint32_t)(new_pc - tb->cs_base);
+}
 
+static void x86_restore_state_to_opc(CPUState *cs,
+                                     const TranslationBlock *tb,
+                                     const uint64_t *data)
+{
+    CPUX86State *env = cpu_env(cs);
+    CCOp cc_op;
+
+    env->eip = eip_from_unwind(env, tb, data[0]);
+
+    cc_op = data[1];
     if (cc_op != CC_OP_DYNAMIC) {
         env->cc_op = cc_op;
     }
 }
 
+static bool x86_plugin_need_unwind_for_reg(CPUState *cs, int reg)
+{
+    return reg == IDX_IP_REG || reg == IDX_FLAGS_REG;
+}
+
+static int x86_plugin_unwind_read_reg(CPUState *cs, GByteArray *buf, int reg,
+                                      const TranslationBlock *tb,
+                                      const uint64_t *data)
+{
+    CPUX86State *env = cpu_env(cs);
+    CCOp cc_op;
+
+    switch (reg) {
+    case IDX_IP_REG:
+        return gdb_get_regl(buf, eip_from_unwind(env, tb, data[0]));
+
+    case IDX_FLAGS_REG:
+        cc_op = data[1];
+        if (cc_op == CC_OP_DYNAMIC) {
+            cc_op = env->cc_op;
+        }
+        return gdb_get_reg32(buf, cpu_compute_eflags_ccop(env, cc_op));
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
@@ -110,6 +148,8 @@ static const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
+    .plugin_need_unwind_for_reg = x86_plugin_need_unwind_for_reg,
+    .plugin_unwind_read_reg = x86_plugin_unwind_read_reg,
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-- 
2.34.1


