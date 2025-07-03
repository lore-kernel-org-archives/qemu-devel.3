Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68713C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJfx-0003S4-PA; Thu, 03 Jul 2025 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJfv-0003RW-1K
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:08:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJfs-0008PR-PQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:08:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso51570385ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751548103; x=1752152903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c7q84lOxk7cn1+c3FhfPl7tYc+qnJ6dVDhuJq7mfJR0=;
 b=CX0Rz2zGjTamq7uP4POyB4EoMZF1wHOWYObulR3o6MO4n6vHHwZOI85//Kz9/8lqNM
 p64chazOoeznuqJhqx9vxCayzl6O6UsagNCoI5gQ2lBKle3JcyLuIP2fm65men+JH6By
 VNdXWY4D84NYxh0Z7ih9ULLMLiFQMyJL8M8MzIMHbnuttGY8k+usE4KaHHW9175fDgpF
 ypgdp6tj9Nz4Lzs/Ny7Gw2pKcSBaUUCEAa8M/GK1dclBF8faBoR6V4XbYQWNINCbIb+l
 QbFEWHh423TOzFPT0XOIZcY4AM+yWWhPbrDfksS2YqSMwZXPnK/6tJnQa8T9koS0P9+0
 wyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751548103; x=1752152903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7q84lOxk7cn1+c3FhfPl7tYc+qnJ6dVDhuJq7mfJR0=;
 b=tbxjpqf9jsHB4GpaAp6JYBo3ktTEPBl/2lDGWWGsmuiwCYC9f5tGLqUwU3Rxt9OW+x
 FDIQb5IL/89Wh8rtlrzc+6tgg2BFF56zupTa8hAfNDyDguus5Wt1pJrRbLU3AExLhNOc
 ZVWSNQfAy4qV5anM7lsp4gERzYkT1YERKJCF4VxjdVv8PLSEKKAqfFibnmJmUBTYVWY6
 yAW7c70GhaXgNtBSVwQm81JziSW1oAJ/8bt+0Y7wbSISthiAvsolPz3UdMV1CEUjstR+
 W5HrCp00nWtpLnK2jCK9vvkh3Z18zdDbw08hvWiWC/vY4Uy/PXyqWPiqv/U5m7uj02pd
 1imA==
X-Gm-Message-State: AOJu0YwSJF71QJ1ImIUeBjLxke0u9uJaOwZTCgXESXqjKgldK+B/Dgzp
 L0P/XGnJVFUTuKMWhVae4Xbl03jh3FKBClxwevFAdtREmCFRDXibaFJwS4yZH6Ys6p1+Ae86zMN
 aG6TL
X-Gm-Gg: ASbGncu9tQ2m7/lLV9sZnyGXJnlRALCnTLerfzKgqFk17VrhDw0wQR1OyFsnWAvTw8M
 ICs6wNIKS3PWk6OffFm4jTvEhUkZTbBU3tBCgrPmtbZBXU++j4LhoGJHEiDbuihWOeLi+Xx7tQd
 cbuBLk867LcS8yAwXj5yNHXh7NTO5KW1FZ/1P8dSQ+d3pV3rOFEYKy5PDGrBB4EbAqKF2s+m7vk
 7dNj8gJtLx2kCJbTlC7fIi5Y3MmwX0a8q+Pqne+4X+mZQr7lf2B3lr3rvLHDTztMPhJd+Mc+KJl
 3zKdIjNUe+mcl1awd96c9rUc0gsMuf+/QhkOH5ghiM2gM7QICeP3jUhmRipDRZg6ZhK+w3wgqYZ
 MUB7Wln1cyxdyXNI=
X-Google-Smtp-Source: AGHT+IGzrM7tqUbYUKaz6A/Vj3kRVE7sV9ivu52U5awECN8dAh6SRKgvoV3kt9SgZImlg50wFMMk6Q==
X-Received: by 2002:a17:902:f542:b0:231:e331:b7df with SMTP id
 d9443c01a7336-23c7a271f2emr36073225ad.29.1751548102548; 
 Thu, 03 Jul 2025 06:08:22 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c7041sm159483145ad.229.2025.07.03.06.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 06:08:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] target/riscv: implement MonitorDef HMP API
Date: Thu,  3 Jul 2025 10:08:15 -0300
Message-ID: <20250703130815.1592493-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

The MonitorDef API is related to two HMP monitor commands: 'p' and 'x':

(qemu) help p
print|p /fmt expr -- print expression value (use $reg for CPU register access)
(qemu) help x
x /fmt addr -- virtual memory dump starting at 'addr'

For x86, one of the few targets that implements it, it is possible to
print the PC register value with $pc and use the PC value in the 'x'
command as well.

Those 2 commands are hooked into get_monitor_def(), called by
exp_unary() in hmp.c. The function tries to fetch a reg value in two
ways: by reading them directly via a target_monitor_defs array or using
a target_get_monitor_def() helper. In RISC-V we have *A LOT* of
registers and this number will keep getting bigger, so we're opting out
of an array declaration.

We're able to retrieve all regs but vregs because the API only fits an
uint64_t and vregs have 'vlen' size that are bigger than that.

With this patch we can do things such as:

- print CSRs and use their val in expressions:
(qemu) p $mstatus
0xa000000a0
(qemu) p $mstatus & 0xFF
0xa0

- dump the next 10 insn from virtual memory starting at x1 (ra):

(qemu) x/10i $ra
0xffffffff80958aea:  a9bff0ef          jal                     ra,-1382                # 0xffffffff80958584
0xffffffff80958aee:  10016073          csrrsi                  zero,sstatus,2
0xffffffff80958af2:  60a2              ld                      ra,8(sp)
0xffffffff80958af4:  6402              ld                      s0,0(sp)
0xffffffff80958af6:  0141              addi                    sp,sp,16
0xffffffff80958af8:  8082              ret
0xffffffff80958afa:  10016073          csrrsi                  zero,sstatus,2
0xffffffff80958afe:  8082              ret
0xffffffff80958b00:  1141              addi                    sp,sp,-16
0xffffffff80958b02:  e422              sd                      s0,8(sp)
(qemu)

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h            |   1 +
 target/riscv/riscv-qmp-cmds.c | 148 ++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..487884c42c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -576,6 +576,7 @@ static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
 extern const char * const riscv_int_regnames[];
 extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
+extern const char * const riscv_rvv_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8ba8aa0d5f..2c8c74bbe4 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,6 +31,10 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
+#include "qemu/ctype.h"
+#include "qemu/qemu-print.h"
+#include "monitor/hmp.h"
+#include "monitor/hmp-target.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "cpu-qom.h"
@@ -240,3 +244,147 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
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
+        g_autofree char *reg_name = g_strdup(reg_names[i]);
+        char *reg1 = strtok(reg_name, "/");
+        char *reg2 = strtok(NULL, "/");
+
+        if (strcasecmp(reg1, name) == 0 ||
+            (reg2 && strcasecmp(reg2, name) == 0)) {
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
+        g_autofree char *reg_name = g_strdup(riscv_fpr_regnames[i]);
+        char *reg1 = strtok(reg_name, "/");
+        char *reg2 = strtok(NULL, "/");
+
+        if (strcasecmp(reg1, name) == 0 ||
+            (reg2 && strcasecmp(reg2, name) == 0)) {
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
+        if (!riscv_has_ext(env, RVV)) {
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
-- 
2.49.0


