Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF3E7718E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 12:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQQe8-0001gP-2l; Wed, 25 Dec 2024 07:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tQQe3-0001fh-Fc; Wed, 25 Dec 2024 07:37:47 -0500
Received: from m.syntacore.com ([178.249.69.228] helo=pmg.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tQQe1-0002DJ-4p; Wed, 25 Dec 2024 07:37:46 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by pmg.syntacore.com (Proxmox) with ESMTP id 0CA98B41C31;
 Wed, 25 Dec 2024 15:37:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=m; bh=pHaxb9Bw6SAt+eDqP7iVb05
 eLRvGqYUfW5Rr1Sj1opI=; b=PZy0ottuxrSw6oENWxEREx3ACGtH513UHwjjU1k
 Rv0xnan5HkkDs0Z6hnoJ9/tdBYzkTwaY1koAMQkkcjOinTFovlr04KpQdSggZgwI
 mNc74Z0+K8Q9zrLEqzg0JF12Dd5qtPT23hhOUQNm7G8Psj4rjij4H7LWbCMaQCWo
 de3mXHNcAMSeDnIS4OwRW1r553MP3reBmV1VismqaMYLvssXd/3IfRg5ebEqpEGU
 yBNK4sA0rakeid3x7nwLZmQsR0V+0XpPAKMSgnpq7JaN3FNJTNSWek16vI/zvv3A
 n/84p8WcF8nOTF3cJg42000nZseIKI3sBLQVyoSf0gL0v0g==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 by pmg.syntacore.com (Proxmox) with ESMTPS id ECE64B412D4;
 Wed, 25 Dec 2024 15:37:34 +0300 (MSK)
Received: from VirtualBox.corp.yadro.com (172.22.3.83) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Dec 2024 15:36:41 +0300
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [PATCH v8 1/2] target/riscv: Add RISC-V CSR qtest support
Date: Wed, 25 Dec 2024 15:37:17 +0300
Message-ID: <20241225123718.45991-2-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241225123718.45991-1-ivan.klokov@syntacore.com>
References: <20241225123718.45991-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.3.83]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=ivan.klokov@syntacore.com; helo=pmg.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv_hart.c  | 56 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c | 27 ++++++++++++++++++++
 tests/qtest/libqtest.h | 14 +++++++++++
 3 files changed, 97 insertions(+)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index bc9ffdd2d4..b8151682c0 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -22,6 +22,9 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "system/reset.h"
+#include "qemu/cutils.h"
+#include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/qdev-properties.h"
@@ -41,6 +44,55 @@ static void riscv_harts_cpu_reset(void *opaque)
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
@@ -58,6 +110,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
+#ifndef CONFIG_USER_ONLY
+    riscv_cpu_register_csr_qtest_callback();
+#endif
+
     for (n = 0; n < s->num_harts; n++) {
         if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
             return;
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 8de5f1fde3..4bc9643aad 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1218,6 +1218,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
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
index f23d80e9e5..cd35e11d4c 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -600,6 +600,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
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



