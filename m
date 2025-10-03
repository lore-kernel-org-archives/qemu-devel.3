Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D457CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSq-0006zx-6t; Thu, 02 Oct 2025 23:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSm-0006yS-2v
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSb-0001BB-8f
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-78127433a32so1363025b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462072; x=1760066872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYQCJcXuY+7yUPJSpLnB3TDifS4Q7SIz9JpD/nzZR+w=;
 b=ddxSOq9dgetQ45T+EcU8vFpX8XKVGmySg1ku1q3ogMRxT2LrllJovvKqBpDbo8P6uV
 IglV5Ufn4nhNBz6UTerTZEA78cyNzwvVejm0/tkPJzxGX6Kh9isp5woyEuHZC67II3GG
 NJxEEvJrQSAzItO+OykEe/cBAEIQD3HxOzO731rD/fm4rIp740VXnI65QBXvDEXtnf4/
 XVpTRA+cQblCDYVeDL50LdKIXbF9k1JqobYb2yhXPLYFV07ECYlFfrsxva/PFhrFBUB2
 MJokAl4F8YtkOAnJTMXSfMfTGDEE6U9FT21CBfTfw3PK2qDlUkM76nP+Snxq+FBlTAU2
 e0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462072; x=1760066872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYQCJcXuY+7yUPJSpLnB3TDifS4Q7SIz9JpD/nzZR+w=;
 b=Yx/SLokrkLEjAGkgBRrLf/GD3/OxGM4sKgq9nnnbxF+XhE1I/Z2Dtlxni8ZJolJLwQ
 5tnE23duPxBePYfJeDuiH92+kmH6f93ObgGUZ+F4H+diGKONdGiQJqevyt5sf6P2zRRC
 PPkalQ31KRyL7aUI+V+U5afy/d4Ty5hWkI1ehBoz3rXer+1+OYTE8/4L1uewenhImCCM
 aukb/ojSISNOHangHSgsQO7iCcJwMjNhvznmYVTZ7OcNCrS/czULtm+iCc1c8ZLXBzfe
 k3E5B4Be4dE4ZIQPGAkNrXtSkyab5w+U/FtI65woZYJoBvzsTraX3fmlpJ/evPlsEjiW
 jxBA==
X-Gm-Message-State: AOJu0Yxt0TdzpsdQEzLyt5wmk+nR3cpxN3QMVtDLNWhnzwOzc6FrQKfZ
 8lEMRo70rA2HxLHpHQrO+eqRYJu5UNR+HuEP6UNKwJ630SWcUQdSVfIM+ZQzIQ==
X-Gm-Gg: ASbGncvB0a3Jt9HWPH0T+8RkUO6iTqKT/66PvHE4u1EzGcn8g9RXRg3GnrdUszsfGsR
 8dLkEcNcAIe259M+fuGdgB9dOq/FRMciizizg1GzIv4jkci+Jg+0ivwuPK4ba8BMFJQLdXD3usI
 tFKwQ2wo74FNAcsahCM0Rd7tiXxQMtr8yqhg2yPyyLJobAX75nbI7LWKZTduWz6ZXGQorA95Dpi
 hp5+2ioeXLn8uOheGP2Idyh7Eq/NVWDbYkzAxT7mHdCpULOIDHyo7Od9pqwENBGPmRQHij9Ubcu
 Rhpn0cezoA3zjJ7uqevOUfwkbr6Mg5AkTcgXogESn7nxe9+kZnxidYU1q++eFSW+5QjeFqrzQdz
 7acJ2eSUnS6S9okxAGnRuumEyJ1LG9eqR348q2x6w2ztgcH+QUB5mxGKvkRyfDPPlvk6BeM+A+b
 02Rv4ieucLuRKBavvPgdbk0XqwD24iZYA0wXTC7xpQfWxdC6rhSXueWUVw2euVFI0=
X-Google-Smtp-Source: AGHT+IFNa3t0AhnvZTvDEn3RIguBUdQWlE4FZNYEpZVI65wOte8z77xww26O31VykOqmRFS98a+2mw==
X-Received: by 2002:a05:6a21:338b:b0:2fa:52a0:e838 with SMTP id
 adf61e73a8af0-32b62095839mr2063247637.36.1759462071555; 
 Thu, 02 Oct 2025 20:27:51 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/26] target/riscv: implement MonitorDef HMP API
Date: Fri,  3 Oct 2025 13:26:56 +1000
Message-ID: <20251003032718.1324734-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250703130815.1592493-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |   1 +
 target/riscv/riscv-qmp-cmds.c | 148 ++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..738e68fa6e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -592,6 +592,7 @@ static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
 extern const char * const riscv_int_regnames[];
 extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
+extern const char * const riscv_rvv_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8a1856c50e..b63de8dd45 100644
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
2.51.0


