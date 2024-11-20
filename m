Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97666D6E2CE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7r-00021J-6q; Wed, 20 Nov 2024 02:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7p-00020Q-I6; Wed, 20 Nov 2024 02:27:45 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7m-00080p-DJ; Wed, 20 Nov 2024 02:27:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com F16AEE0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1732087656;
 bh=bXAXM8qRTOfOTAxsT3cQ9smxjO2LyssIB37CUGRuvKs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=psO7wffdCgpK+PLIiBA9YK5GV1gu1hkH+eY/VsG3rCz5lVX14qSdjsRVktxbbx9vW
 9oVWWX5VxH1Cdh63MYBhRWRP3YFEoQTFJ5EFHKSKESMKnd3cxKZZOMX8Ytrn7NTxU2
 y3lU6+HZ0mWD8UtymE2ZotP2e08owXpABaaa2NcTlR99jb8gt/jzDtT2uqt6EMTP07
 JTPtWhn08Dr1n+duFXxLEGYeMTlEsPFKo2+QdENDSdBeqhnHSMnvPNOVXPn2unS+/K
 4PBLrnDGgJFbZ/JmawAqACkHIdDVg9nEHZf7Dklq0hEvt65H4harMktonbd0yxXBnH
 HYeAVQi4DnUOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1732087656;
 bh=bXAXM8qRTOfOTAxsT3cQ9smxjO2LyssIB37CUGRuvKs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=DNzlTj3Df4KGz3rAZXyV8kNIpbIRhTGVWyRQOrh1dFjgQhyX8YHfG+AaJGgyMiEG0
 cIxkQAKBA0aihV8UpGl5goBy0nxbs55HCb8QpVXAHnYTVS9E1/Hqd4vo3ySVdIF952
 Omb0CYbEADnIDLTPrIYET+m08STNh1na2kMRO8AoOEbEIpgcEnrAULCGF+n403h9O8
 eqPTIp40KotEwdXV79tWceDtAUjwaATgG1vGJrPxuZdn22+lvv6IOogUgIONo9T6af
 5KwLg0ItnwyMsz4c3tLHQLCsTeZynmBdiUNJttbI2sNTsHww5815FT/JoLJxn+v9rg
 EMTL/KfLj51/A==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v7 1/2] target/riscv: Add RISC-V CSR qtest support
Date: Wed, 20 Nov 2024 10:27:11 +0300
Message-ID: <20241120072712.65302-2-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120072712.65302-1-ivan.klokov@syntacore.com>
References: <20241120072712.65302-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Acked-by: Fabiano Rosas <farosas@suse.de>
---
 hw/riscv/riscv_hart.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c | 27 +++++++++++++++++++++
 tests/qtest/libqtest.h | 14 +++++++++++
 3 files changed, 96 insertions(+)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 613ea2aaa0..22cc8ae31f 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -21,6 +21,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
+#include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
@@ -42,6 +44,55 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+#ifndef CONFIG_USER_ONLY
+static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
+{
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
+    CPURISCVState *env = &cpu->env;
+
+    int ret = RISCV_EXCP_NONE;
+    if (strcmp(cmd, "get_csr") == 0) {
+        ret = riscv_csrr(env, csrno, (target_ulong *)val);
+    } else if (strcmp(cmd, "set_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
+                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    }
+
+    g_assert(ret == RISCV_EXCP_NONE);
+}
+
+static bool csr_qtest_callback(CharBackend *chr, gchar **words)
+{
+    if (strcmp(words[0], "csr") == 0) {
+
+        uint64_t cpu;
+        uint64_t val;
+        int rc, csr;
+
+        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
+        g_assert(rc == 0);
+        rc = qemu_strtoi(words[3], NULL, 0, &csr);
+        g_assert(rc == 0);
+        rc = qemu_strtou64(words[4], NULL, 0, &val);
+        g_assert(rc == 0);
+        csr_call(words[1], cpu, csr, &val);
+
+        qtest_send_prefix(chr);
+        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
+
+        return true;
+    }
+
+    return false;
+}
+
+static void riscv_cpu_register_csr_qtest_callback(void)
+{
+    static GOnce once;
+    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
+}
+#endif
+
 static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
                                char *cpu_type, Error **errp)
 {
@@ -59,6 +110,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
+#ifndef CONFIG_USER_ONLY
+    riscv_cpu_register_csr_qtest_callback();
+#endif
+
     for (n = 0; n < s->num_harts; n++) {
         if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
             return;
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 817fd7aac5..43bfa496e9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1202,6 +1202,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
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
index beb96b18eb..b516a16bd4 100644
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
+ * Call an RISC-V CSR read/write function
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


