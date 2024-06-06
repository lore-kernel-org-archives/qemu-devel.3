Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995AAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3ox-0003Xa-9C; Wed, 05 Jun 2024 23:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3op-0003WX-QL
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:40 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003mP-35
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-60585faa69fso288548a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644572; x=1718249372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1FZU7Kp9GU8lGWAPo6y4bl6njrrndV/cpVZs+Mkosw=;
 b=x67uD4W+1y2aOKlgboCNVpW9hFsdk+K/3ddKqS8YZg2DUJW0vzPcaKwjwlBrB8Yejo
 cy0FpUomk8nxsJcGtHcpUarcJs8xKZyoXnRIKuKVe6UlDx3OqQMY6T5pSrBehmGk4fHi
 HAz7yrae3sR8ClqoAq2todt6zdca2CQaFtA6REQH5JOkVvSQSaUUMPU4A7X1QjBHAgnQ
 34ktXe7ClJXfhwaH5ffT+cyL84fvHpRqPaLIBsq59tBbnyRLO0AlwpfT6I2qCWICOhyU
 o5H572MrueyPOndkWZsGL81RbGG0f3WdaB2pPWRjKd64FtUEmerGfhVnuaoS8WjaksXW
 emyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644572; x=1718249372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1FZU7Kp9GU8lGWAPo6y4bl6njrrndV/cpVZs+Mkosw=;
 b=o/nX/B2lAP5zrhxw/LjmXyDC27iuiKyYli2kTojcImkJ8YwNnTPHL78naryFcmjfjk
 29i+FX8WS1TdK2gazp+yFfTICr38DXoqA5+XFDokuVy+811ZZ0CmRx6m6jexDorKqORI
 XkLAafEIdn2KJ70PKng8EzgV/WSGGvMRsmqVe36ZxLfI7MZjnwca1u1Zpe9R0NaGXDCC
 evAuG7VN0vA0JR8oNPD0OFCU+JMYxQK3kPv3WzKZnXTaEQ6kwNcKl/EbKIDxNduPPYJB
 U4Xmy+r0Rk2wWTMVljZRvzDRHhzAU+bNagTJCOauhcJFxYY6EmlEfirWSJBVaESRhJIX
 FHGw==
X-Gm-Message-State: AOJu0Yw0ylCs69Q+yXkW8Fk8ryzYZFKRGQVZJrWzgy+MBgy/elXO1Dnd
 2iz7APaszh7tHN0AxoXMpVArCA38YBhejS9Qjo8UR8+mwGAGONibKOFQJLQYsD2MYTMMuP8z6JL
 V
X-Google-Smtp-Source: AGHT+IEk5AsTa41OfRjGB4VRNuL/CAWkmr9Bk8pWl65xUH1SwhRRYsfpgycR7kJVewbHjtGz8GNYQQ==
X-Received: by 2002:a17:90a:8809:b0:2c2:12d:fa01 with SMTP id
 98e67ed59e1d1-2c2999b294bmr1992971a91.11.1717644571470; 
 Wed, 05 Jun 2024 20:29:31 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 4/9] plugins: Introduce TCGCPUOps callbacks for mid-tb
 register reads
Date: Wed,  5 Jun 2024 20:29:21 -0700
Message-Id: <20240606032926.83599-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Certain target registers are not updated continuously within
the translation block.  For normal exception handling we use
unwind info to re-generate the correct value when required.
Leverage that same info for reading those registers for plugins.

All targets will need updating for these new callbacks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 14 ++++++++++++++
 plugins/api.c                 | 36 +++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 099de3375e..b34f999e78 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -53,6 +53,20 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /**
+     * @plugin_need_unwind_for_reg:
+     * True if unwind info needed for reading reg.
+     */
+    bool (*plugin_need_unwind_for_reg)(CPUState *cpu, int reg);
+    /**
+     * @plugin_unwind_read_reg:
+     * Like CPUClass.gdb_read_register, but for registers that require
+     * regeneration using unwind info, like in @restore_state_to_opc.
+     */
+    int (*plugin_unwind_read_reg)(CPUState *cpu, GByteArray *buf, int reg,
+                                  const TranslationBlock *tb,
+                                  const uint64_t *data);
+
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
diff --git a/plugins/api.c b/plugins/api.c
index 5a0a7f8c71..53127ed9ee 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -40,10 +40,12 @@
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
+#include "tcg/insn-start-words.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/translator.h"
 #include "disas/disas.h"
+#include "hw/core/tcg-cpu-ops.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/ram_addr.h"
@@ -526,9 +528,39 @@ GArray *qemu_plugin_get_registers(void)
 
 int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
-    g_assert(current_cpu);
+    CPUState *cs;
+    uintptr_t ra;
+    int regno;
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
+    assert(current_cpu);
+    cs = current_cpu;
+    ra = cs->neg.plugin_ra;
+    regno = GPOINTER_TO_INT(reg);
+
+    /*
+     * When plugin_ra is 0, we have no unwind info.  This will be true for
+     * TB callbacks that happen before any insns of the TB have started.
+     */
+    if (ra) {
+        const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+
+        /*
+         * For plugins in the middle of the TB, we may need to locate
+         * and use unwind data to reconstruct a register value.
+         * Usually this required for the PC, but there may be others.
+         */
+        if (tcg_ops->plugin_need_unwind_for_reg &&
+            tcg_ops->plugin_need_unwind_for_reg(cs, regno)) {
+            uint64_t data[TARGET_INSN_START_WORDS];
+            const TranslationBlock *tb;
+
+            tb = cpu_unwind_state_data(cs, ra, data);
+            assert(tb);
+            return tcg_ops->plugin_unwind_read_reg(cs, buf, regno, tb, data);
+        }
+    }
+
+    return gdb_read_register(cs, buf, regno);
 }
 
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
-- 
2.34.1


