Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B57C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 06:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJSaX-00034O-Cq; Tue, 18 Jun 2024 02:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sJSaV-00033X-An; Tue, 18 Jun 2024 02:45:03 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sJSaQ-00082T-PM; Tue, 18 Jun 2024 02:45:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com ECA87C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1718693092;
 bh=bCk5UV72/y1u3YfDWUuusjXVkiwl1txmDjFBn5QeU/w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=J+Lvt4YJs4hATKcY415S0jEtscFXsYEUVltmucCqka/IpkiPb4thZNrQWOPtaM1QY
 YfFg4sHJWBIkwSW5d8uqmynb5no0VEza3Uuo4b/PrnVpV/yMY1t6MCgLthKGIgzbHX
 w7UCRNWj/DDLu5vd3FsLkFekZd+rO8h0uASYiL0ytSvHr2s2/+u4pWg4ssblFrnQtI
 fXRF6lbJmUP+QJEjBl129JrBfIpqxgcFPThzE4BsedUJx7WrXAv5E4QYE0ni+0hIaK
 Xhqn93WNDoxGenvxgRGVKlHBP568d+LKR6xbrV33ijUQnO6aJgg2fxcyPV/CtFxky8
 c9k8ZcyjCidsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1718693092;
 bh=bCk5UV72/y1u3YfDWUuusjXVkiwl1txmDjFBn5QeU/w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pk4sXfTS4I97lXAwrq0/lAFJPkyV2Z67fWsMjDTwfE8TyV+gwGzKbUNSZIApq5JYt
 /VrpCqgY+lt+lwST7gaLeWSSlV9hej2+0EdTkduosFc5Mv1QgJy20N9/aaVDE4Yy/9
 2dg6Vn0mzj0AWIzQXg/dZXC9fU1x9QYCbhy8HrtmL4gBM4FigXhVFsLcbWR+nv1qNc
 2xXNU06U2YrUVrNyu4yzR0VcfV57NH7mNBjQAUWlCbwomxveXY/NWmyduM6gd8blJD
 qEvi807wU/fQS91umlUcWmmGJIuJr5kUIU4YRyflekSe1ZmcD4qc3ly6rPI9hkB5L7
 UHTGijBLteykQ==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v2 1/2] Add RISC-V CSR qtest support
Date: Tue, 18 Jun 2024 09:44:42 +0300
Message-ID: <20240618064443.6474-2-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618064443.6474-1-ivan.klokov@syntacore.com>
References: <20240618064443.6474-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The RISC-V architecture supports the creation of custom
CSR-mapped devices. It would be convenient to test them in the same way
as MMIO-mapped devices. To do this, a new call has been added
to read/write CSR registers.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
---
 target/riscv/cpu.c             | 13 +++++++++
 target/riscv/cpu.h             |  3 +++
 target/riscv/csr.c             | 49 +++++++++++++++++++++++++++++++++-
 tests/qtest/libqos/csr.c       | 42 +++++++++++++++++++++++++++++
 tests/qtest/libqos/csr.h       | 16 +++++++++++
 tests/qtest/libqos/meson.build |  3 +++
 tests/qtest/libqtest.c         | 27 +++++++++++++++++++
 tests/qtest/libqtest.h         | 14 ++++++++++
 8 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/libqos/csr.c
 create mode 100644 tests/qtest/libqos/csr.h

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69a08e8c2c..f1df0f4de0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1149,6 +1149,16 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 }
 
+static void riscv_cpu_register_csr_qtest_callback(void)
+{
+    static gsize reinit_done;
+    if (g_once_init_enter(&reinit_done)) {
+        qtest_set_command_cb(csr_qtest_callback);
+
+        g_once_init_leave(&reinit_done, 1);
+    }
+}
+
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1175,6 +1185,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
+    /* register callback for csr qtests */
+    riscv_cpu_register_csr_qtest_callback();
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6fe0d712b4..6d4bbec53c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -32,6 +32,8 @@
 #include "cpu_cfg.h"
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
+#include "qemu/cutils.h"
+#include "sysemu/qtest.h"
 
 typedef struct CPUArchState CPURISCVState;
 
@@ -813,6 +815,7 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+bool csr_qtest_callback(CharBackend *chr, gchar **words);
 
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..82540ae5dc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -29,7 +29,7 @@
 #include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-
+#include "tests/qtest/libqtest.h"
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -4549,6 +4549,53 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static uint64_t csr_call(char *cmd, uint64_t cpu_num, int csrno,
+                                uint64_t *val)
+{
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
+    CPURISCVState *env = &cpu->env;
+
+    int ret = RISCV_EXCP_NONE;
+    if (strcmp(cmd, "get_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, (target_ulong *)val, 0, 0);
+
+    } else if (strcmp(cmd, "set_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    }
+
+    if (ret == RISCV_EXCP_NONE) {
+        ret = 0;
+    }
+
+    return ret;
+}
+
+bool csr_qtest_callback(CharBackend *chr, gchar **words)
+{
+    if (strcmp(words[0], "csr") == 0) {
+
+        uint64_t res, cpu;
+
+        uint64_t val;
+        int rc, csr;
+
+        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
+        g_assert(rc == 0);
+        rc = qemu_strtoi(words[3], NULL, 0, &csr);
+        g_assert(rc == 0);
+        rc = qemu_strtou64(words[4], NULL, 0, &val);
+        g_assert(rc == 0);
+        res = csr_call(words[1], cpu, csr, &val);
+
+        qtest_send_prefix(chr);
+        qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_ulong)val);
+
+        return true;
+    }
+
+    return false;
+}
+
 /*
  * Control and Status Register function table
  * riscv_csr_operations::predicate() must be provided for an implemented CSR
diff --git a/tests/qtest/libqos/csr.c b/tests/qtest/libqos/csr.c
new file mode 100644
index 0000000000..2dc52fc442
--- /dev/null
+++ b/tests/qtest/libqos/csr.c
@@ -0,0 +1,42 @@
+/*
+ * QTest RISC-V CSR driver
+ *
+ * Copyright (c) 2024 Syntacore
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "csr.h"
+
+static uint64_t qcsr_call(QTestState *qts, const char *name, uint64_t cpu,
+                           int csrno, uint64_t *val)
+{
+    uint64_t res = 0;
+
+    res = qtest_csr_call(qts, name, cpu, csrno, val);
+
+    return res;
+}
+
+int qcsr_get_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val)
+{
+    int res;
+
+    res = qcsr_call(qts, "get_csr", cpu, csrno, val);
+
+    return res;
+}
+
+int qcsr_set_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val)
+{
+    int res;
+
+    res = qcsr_call(qts, "set_csr", cpu, csrno, val);
+
+    return res;
+}
diff --git a/tests/qtest/libqos/csr.h b/tests/qtest/libqos/csr.h
new file mode 100644
index 0000000000..d953735fe8
--- /dev/null
+++ b/tests/qtest/libqos/csr.h
@@ -0,0 +1,16 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBQOS_CSR_H
+#define LIBQOS_CSR_H
+
+int qcsr_get_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val);
+
+int qcsr_set_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val);
+
+
+#endif /* LIBQOS_CSR_H */
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 558eb4c24b..a944febbd8 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -25,6 +25,9 @@ libqos_srcs = files(
         # usb
         'usb.c',
 
+        #riscv csr
+        'csr.c',
+
         # qgraph devices:
         'e1000e.c',
         'i2c.c',
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 18e2f7f282..4667d8d873 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1200,6 +1200,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
     return 0;
 }
 
+static void qtest_rsp_csr(QTestState *s, uint64_t *val)
+{
+    gchar **args;
+    uint64_t ret;
+    int rc;
+
+    args = qtest_rsp_args(s, 3);
+
+    rc = qemu_strtou64(args[1], NULL, 16, &ret);
+    g_assert(rc == 0);
+    rc = qemu_strtou64(args[2], NULL, 16, val);
+    g_assert(rc == 0);
+
+    g_strfreev(args);
+}
+
+uint64_t qtest_csr_call(QTestState *s, const char *name,
+                         uint64_t cpu, int csr,
+                         uint64_t *val)
+{
+    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
+                    name, cpu, csr, *val);
+
+    qtest_rsp_csr(s, val);
+    return 0;
+}
+
 void qtest_add_func(const char *str, void (*fn)(void))
 {
     gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18eb..a3336a0ea4 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -575,6 +575,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
                          uint32_t nargs, uint64_t args,
                          uint32_t nret, uint64_t ret);
 
+/**
+ * qtest_csr_call:
+ * @s: #QTestState instance to operate on.
+ * @name: name of the command to call.
+ * @cpu: hart number.
+ * @csr: CSR number.
+ * @val: Value for reading/writing.
+ *
+ * Call an CSR function
+ */
+uint64_t qtest_csr_call(QTestState *s, const char *name,
+                         uint64_t cpu, int csr,
+                         unsigned long *val);
+
 /**
  * qtest_bufread:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


