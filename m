Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA4D2B932
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KYR-0002E6-8y; Tue, 05 Nov 2024 09:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1t8KYP-0002Co-Ca; Tue, 05 Nov 2024 09:29:09 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1t8KYN-0005h1-1w; Tue, 05 Nov 2024 09:29:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 4DF35E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1730816942;
 bh=FvLYxDA9L4kmzboyaMeczncHiQAjrCCgWCcQ6OBp3qA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=bCexo5zwoZGkwhWwbb4iW0w1Ni1f12kfBtUSP43lvEqnWOtFXl7EpLYoY5ldX+AjY
 ojd9TNNZGqLCb5LYv7K9+2qL73OSuvhivPfjJmYXeqA9EYPaZ2OIaV5qWL8i/AI2e1
 VYMMX+vrjTc8n/+lh9tstFbD3YTHW25+Sqd1PUqUtNs5yd0if3Uof/+4SZZoWX713S
 55bmjWFCV95WfXtAuTkkNzY/E0h7r+DJbLhx5NhgLQL9tnzfeNbG/M+hRi0CJ7yAH5
 z1aaQrsKjFo4aBIkjxcKUp/I5+0CP/GhW+dqTirxEZ8QlVYL89rpmp7IQTgpTqnDu2
 eTb4AgLKB9RkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1730816942;
 bh=FvLYxDA9L4kmzboyaMeczncHiQAjrCCgWCcQ6OBp3qA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=J/zzDTaYSGma+EpZoVwROYAOKJ8fpfjsy6Uswk+nLSCjdVu3ZK4vS4Uts9+B1YZQr
 fQqCTkncgIy2RD+9IsljTZX8NtfqoMvE6q+SETB8Vb+xKjjOHRGkkLdPkdnS7hpheR
 5thNz4C9s0NRhM16G0mYcsbmCOWoMd1ab8MNGMEfjtF9HVTS2E00+h7i6yzhCgH7jd
 6Jh7WSP9dv7TCIWmc68kXTqLJR4I+1xn1SBR8PkGlLoy740MfT971NvzSsZcOZ69e8
 tOypCj1PGf3d1T4YtGqUzb+GX158tlS7dNpikimaL5uluxOGMlanU5wFZrspqF8k64
 aLhQO2+tRxs8g==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v5 1/2] target/riscv: Add RISC-V CSR qtest support
Date: Tue, 5 Nov 2024 17:28:39 +0300
Message-ID: <20241105142840.59617-2-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105142840.59617-1-ivan.klokov@syntacore.com>
References: <20241105142840.59617-1-ivan.klokov@syntacore.com>
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
---
 hw/riscv/riscv_hart.c  | 65 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c | 27 ++++++++++++++++++
 tests/qtest/libqtest.h | 14 +++++++++
 3 files changed, 106 insertions(+)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 613ea2aaa0..e65a1a28a1 100644
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
@@ -42,6 +44,66 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+#ifndef CONFIG_USER_ONLY
+static uint64_t csr_call(char *cmd, uint64_t cpu_num, int csrno,
+                                uint64_t *val)
+{
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
+    CPURISCVState *env = &cpu->env;
+
+    int ret = RISCV_EXCP_NONE;
+    if (strcmp(cmd, "get_csr") == 0) {
+        ret = riscv_csrr(env, csrno, (target_ulong *)val);
+    } else if (strcmp(cmd, "set_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    }
+
+    if (ret == RISCV_EXCP_NONE) {
+        ret = 0;
+    } else {
+        g_assert_not_reached();
+    }
+
+    return ret;
+}
+
+static bool csr_qtest_callback(CharBackend *chr, gchar **words)
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
+static void riscv_cpu_register_csr_qtest_callback(void)
+{
+    static gsize reinit_done;
+    if (g_once_init_enter(&reinit_done)) {
+        qtest_set_command_cb(csr_qtest_callback);
+
+        g_once_init_leave(&reinit_done, 1);
+    }
+}
+#endif
+
 static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
                                char *cpu_type, Error **errp)
 {
@@ -49,6 +111,9 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
     qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
+#ifndef CONFIG_USER_ONLY
+    riscv_cpu_register_csr_qtest_callback();
+#endif
     return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
 }
 
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9d07de1fbd..661f7f0e84 100644
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


