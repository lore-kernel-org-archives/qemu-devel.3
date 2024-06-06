Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC032C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3p9-0003hI-P8; Wed, 05 Jun 2024 23:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ot-0003Xb-H4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ol-0003mk-Gp
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso409894b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644574; x=1718249374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0va1mHnZfjZEpAwkwYedRlpjIR4vW0RMlDktvC8XHk=;
 b=hxRI3vtG3eYQe7ZslDzJdYctwVrXJTDxkFqhyTf94o8GkvHHBax+8H3hiWu6f9N3ql
 RcUcN9bM/3vs2nthFpe+q7J03SXbfWo6STGFrYIexigANpqvV967aru2sHT97kAyEobe
 WykuNcQXclPqFuoBHeN0sTNnVzZj2zlwYDUcjs61KhAjwcEzQTwdx4tPlX22cd121SE4
 MhXlnssUJ0prGqNkk0knCljpPUs6dHozG01F9iNko5NjMBatvJlv4A9ga2qTbPXOdJ4Q
 Us7BN3jiTp/9DGs3gJP4iTgWF1l7DYXzZq6aAk2Q2dhxYatlKCQ6oz+NcSnSzvPQn3zd
 vgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644574; x=1718249374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0va1mHnZfjZEpAwkwYedRlpjIR4vW0RMlDktvC8XHk=;
 b=gxsD24Q2n9jlNTum6p9ni1VznHjWzHPGo/qB942T+gVwqsPrypHbpH9Q6zNVWtVPmB
 50a//AqxbCC48xW2w0aBL3w6WKWIKDaXuXbbmel7070V+PtMrlKViCVwpX1V2a1eNgxl
 IDmLNEZrrzG0Lbm7GvbH94CAdtqzp1W5pW4IJmjd7rwqzo7KGVauegCwogy5slp+IgHq
 UBjq9l9OWDKZE5upT5/GaBQStXouZm5cZ5Lh1qDwtZkWNPFCmj6YtTWu4Yh6i+HHLrx/
 7H2LHKdjc56/HtlSZM3p2s4H2R/nPRwM4tgI8dTp6qro8frrJE8UKR+GDmBXPayFydz8
 vwzQ==
X-Gm-Message-State: AOJu0Yy8dI7Qg8jCAr66E+/+okG9iig4W1m404Y2eqNlQm/DdCMMQ+rM
 GjZhdD+jJg09IKQr1YPDj64T/5c5P7PlKjepU8Z0CyFoLv4RvGKV1zIBct8L3vFRYH2PEAHLGKu
 9
X-Google-Smtp-Source: AGHT+IG8QghlIhxlrF3MNixl4/JjrrIYn5B4JAsENBBcnb8o5qcQGWH8toGYXV3Raa1ni9I880K20A==
X-Received: by 2002:a05:6a20:2588:b0:1ad:999b:de34 with SMTP id
 adf61e73a8af0-1b2b710b89bmr6077641637.38.1717644574142; 
 Wed, 05 Jun 2024 20:29:34 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 7/9] target/i386: Implement TCGCPUOps for plugin register
 reads
Date: Wed,  5 Jun 2024 20:29:24 -0700
Message-Id: <20240606032926.83599-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


