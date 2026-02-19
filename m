Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD19E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9Zv-0008Ao-QN; Thu, 19 Feb 2026 14:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zt-000890-Va
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zr-0007gc-Us
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so8901165e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528841; x=1772133641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvBybZaQOehntUbYbK1xpImnMfrBKQskkJ+aEsHfauc=;
 b=pavp8s4ylzvF4iSSiGB+1mfk32AC9RmzpzxotHgqNK4sX1O2Q3gzmRhvL6kLi5YKx0
 4eyhwhshOA/S+AphcXaWsBv+rQKL6KYu4wppytOVYKaoMtgf1Q6MNTFpMviQ/xlQIyKr
 cvjh6VmzqCUMIcYOhTShbzRIJ1Hmu5glaCrbkdsnw5FZoZD3IROxSNWOdewN6yMtG/jK
 diFs7Iw4hgtlp9N78VJTy+VaH5zDZMxYCShYqJePo3PMWDzn9VN3QKo9+57ZviAbNvky
 CQd9/XtmgAR+y0mtI8VJpuCtPDd3tCOMPoY3TkRqi5zjaVN6J+IFPqL/1hNs3/9rVJ+G
 rAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528841; x=1772133641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uvBybZaQOehntUbYbK1xpImnMfrBKQskkJ+aEsHfauc=;
 b=uGB3uPDVF9q9PjbFFLuR8w2nmzC8r0mUWywgRvP3PkA1cSH95F8CoYFnF24bJcFJaw
 LoS/m2tSItGqBtZHFq8OgXXov9WC+QjGkvj4/8MfPNItePe9RVc+xdMQXTAMB28GAGcH
 rcXJ+0BlstNswbEZ26k6Uopja5l6IQqeQUOMaXtUfx9n75aKlsbm318JyVzEv75DaHVj
 K0N5CBIJ0WLOm9DLK6Ug49MY4iEVCfi3HChZgwDeDagK0AOgZuT6yhRaccozUjt5jpSe
 7z5haDxgl/mk2Hu4MABYfkTxdLtLMyqwCozHiYh+qbHLXeZvGe9Ra++MuG7Fu4tXIvtH
 66ww==
X-Gm-Message-State: AOJu0YwXpHqGEAfrVpp8/2KUCzUypjpZLZoegrJtVb5jaPfCaLjcNbrV
 3jccsVJ3ApkyPxtk35Ct7EjSI19x6/j5VN5DlHAShwLDlviUgsjGq0+gppv+Gvzx4KsNCmsVwih
 4e4W4gh/vaQ==
X-Gm-Gg: AZuq6aKYOrorV22WvVUOjbF1v0PKlv8W3XNXX6/M1NvkpxRZKTtOQGepFo1luy7dHUa
 BCzuiYZVS6TdnkxOviNDu3gUtBh0+8DZSYxDZnMWApXs+6i+JoG54XlWhPpoiBYlqmYzcz9nuEJ
 BcIz888PNwXXnhqX9L89c8SraO35BDc3HaEn04Yrs0M2BdUAwXS+ZQDZ4MVWFJ/sdEwmjT4eGoF
 piqd7dq9omCEyhI+kf9qMJM5mqo4kw4I1aQHULeggnS6j+LbnPHXg2LueFf5At9L+JX/VpH5/IZ
 wssjnAZXhrZZUuE4DLCwAGrdDYe7GM1vTLJESsf/VKcXC89sLYPuaYnHDiDhpaof1wmLhs8qgUP
 SIWJIFU0JFzCQUTexOvY/1IMY1dJ9kEb8tVfbwEpylasbw+lrJI+j9Fpn6Yq+LAkKuotSBGdl6l
 agrF/q8nqEmtgeO6+ET8CfWOZR+GQaI8yb4cZcW66GNiAI2mbpI+RK7gq/31qE4IeyKN1c80hJ
X-Received: by 2002:a05:600c:848a:b0:483:aa2:6bce with SMTP id
 5b1f17b1804b1-48379c00bf9mr261075655e9.30.1771528841107; 
 Thu, 19 Feb 2026 11:20:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac7csm48880138f8f.7.2026.02.19.11.20.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 06/50] target/riscv: Extract monitor-related code to
 monitor.c
Date: Thu, 19 Feb 2026 20:19:08 +0100
Message-ID: <20260219191955.83815-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Keep riscv-qmp-cmds.c for QMP, use monitor.c for HMP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/monitor.c        | 148 +++++++++++++++++++++++++++++++++
 target/riscv/riscv-qmp-cmds.c | 150 ----------------------------------
 2 files changed, 148 insertions(+), 150 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 478fd392ac6..ccb7eb44d02 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -19,6 +19,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
@@ -241,3 +243,149 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
 
     mem_info_svxx(mon, env);
 }
+
+/*
+ * We have way too many potential CSRs and regs being added
+ * regularly to register them in a static array.
+ *
+ * Declare an empty array instead, making get_monitor_def() use
+ * the target_get_monitor_def() API directly.
+ */
+const MonitorDef monitor_defs[] = { { } };
+const MonitorDef *target_monitor_defs(void)
+{
+    return monitor_defs;
+}
+
+static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
+                                 target_ulong *val, bool is_gprh)
+{
+    const char * const *reg_names;
+    target_ulong *vals;
+
+    if (is_gprh) {
+        reg_names = riscv_int_regnamesh;
+        vals = env->gprh;
+    } else {
+        reg_names = riscv_int_regnames;
+        vals = env->gpr;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
+            *val = vals[i];
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
+{
+    if (qemu_tolower(name[0]) != 'f') {
+        return false;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
+            *val = env->fpr[i];
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool reg_is_vreg(const char *name)
+{
+    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
+        return false;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    target_ulong val = 0;
+    uint64_t val64 = 0;
+    int i;
+
+    if (reg_is_ulong_integer(env, name, &val, false) ||
+        reg_is_ulong_integer(env, name, &val, true)) {
+        *pval = val;
+        return 0;
+    }
+
+    if (reg_is_u64_fpu(env, name, &val64)) {
+        *pval = val64;
+        return 0;
+    }
+
+    if (reg_is_vreg(name)) {
+        if (!riscv_cpu_cfg(env)->ext_zve32x) {
+            return -EINVAL;
+        }
+
+        qemu_printf("Unable to print the value of vector "
+                    "vreg '%s' from this API\n", name);
+
+        /*
+         * We're returning 0 because returning -EINVAL triggers
+         * an 'unknown register' message in exp_unary() later,
+         * which feels ankward after our own error message.
+         */
+        *pval = 0;
+        return 0;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
+        RISCVException res;
+        int csrno = i;
+
+        /*
+         * Early skip when possible since we're going
+         * through a lot of NULL entries.
+         */
+        if (csr_ops[csrno].predicate == NULL) {
+            continue;
+        }
+
+        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
+            continue;
+        }
+
+        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+
+        /*
+         * Rely on the smode, hmode, etc, predicates within csr.c
+         * to do the filtering of the registers that are present.
+         */
+        if (res == RISCV_EXCP_NONE) {
+            *pval = val;
+            return 0;
+        }
+    }
+
+    return -EINVAL;
+}
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f86..8a1856c50e0 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,10 +31,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
-#include "qemu/ctype.h"
-#include "qemu/qemu-print.h"
-#include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "cpu-qom.h"
@@ -244,149 +240,3 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-/*
- * We have way too many potential CSRs and regs being added
- * regularly to register them in a static array.
- *
- * Declare an empty array instead, making get_monitor_def() use
- * the target_get_monitor_def() API directly.
- */
-const MonitorDef monitor_defs[] = { { } };
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-
-static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
-                                 target_ulong *val, bool is_gprh)
-{
-    const char * const *reg_names;
-    target_ulong *vals;
-
-    if (is_gprh) {
-        reg_names = riscv_int_regnamesh;
-        vals = env->gprh;
-    } else {
-        reg_names = riscv_int_regnames;
-        vals = env->gpr;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = vals[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
-{
-    if (qemu_tolower(name[0]) != 'f') {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = env->fpr[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_vreg(const char *name)
-{
-    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
-    target_ulong val = 0;
-    uint64_t val64 = 0;
-    int i;
-
-    if (reg_is_ulong_integer(env, name, &val, false) ||
-        reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = val;
-        return 0;
-    }
-
-    if (reg_is_u64_fpu(env, name, &val64)) {
-        *pval = val64;
-        return 0;
-    }
-
-    if (reg_is_vreg(name)) {
-        if (!riscv_cpu_cfg(env)->ext_zve32x) {
-            return -EINVAL;
-        }
-
-        qemu_printf("Unable to print the value of vector "
-                    "vreg '%s' from this API\n", name);
-
-        /*
-         * We're returning 0 because returning -EINVAL triggers
-         * an 'unknown register' message in exp_unary() later,
-         * which feels ankward after our own error message.
-         */
-        *pval = 0;
-        return 0;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
-        RISCVException res;
-        int csrno = i;
-
-        /*
-         * Early skip when possible since we're going
-         * through a lot of NULL entries.
-         */
-        if (csr_ops[csrno].predicate == NULL) {
-            continue;
-        }
-
-        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
-            continue;
-        }
-
-        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-
-        /*
-         * Rely on the smode, hmode, etc, predicates within csr.c
-         * to do the filtering of the registers that are present.
-         */
-        if (res == RISCV_EXCP_NONE) {
-            *pval = val;
-            return 0;
-        }
-    }
-
-    return -EINVAL;
-}
-- 
2.52.0


