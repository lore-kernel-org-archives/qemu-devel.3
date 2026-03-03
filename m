Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DED7EB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxENd-00052B-U8; Mon, 02 Mar 2026 20:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vxENH-0004zE-Gs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vxENE-00088T-Py
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:35 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_6tsNqZpGuMWAA--.9795S3;
 Tue, 03 Mar 2026 09:16:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx_8JfNqZpFmpNAA--.16102S9;
 Tue, 03 Mar 2026 09:16:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 7/8] target/loongarch: Add host CPU model in kvm mode
Date: Tue,  3 Mar 2026 08:51:00 +0800
Message-Id: <20260303005101.3561064-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260303005101.3561064-1-gaosong@loongson.cn>
References: <20260303005101.3561064-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8JfNqZpFmpNAA--.16102S9
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Host CPU model is basically the same with max CPU model, except Product
ID and CPU model name. With host CPU model, Product ID comes from
cpucfg0 and CPU model comes from /proc/cpuinfo.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 0b4f3b06e6..37950456b4 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -458,6 +458,97 @@ static void loongarch_max_initfn(Object *obj)
     }
 }
 
+#if defined(CONFIG_KVM)
+static int read_cpuinfo(const char *field, char *value, int len)
+{
+    FILE *f;
+    int ret = -1;
+    int field_len = strlen(field);
+    char line[512];
+
+    f = fopen("/proc/cpuinfo", "r");
+    if (!f) {
+        return -1;
+    }
+
+    do {
+        if (!fgets(line, sizeof(line), f)) {
+            break;
+        }
+        if (!strncmp(line, field, field_len)) {
+            strncpy(value, line, len);
+            ret = 0;
+            break;
+        }
+    } while (*line);
+
+    fclose(f);
+
+    return ret;
+}
+
+static uint64_t get_host_cpu_model(void)
+{
+    char line[512];
+    char *ns;
+    static uint64_t cpuid;
+
+    if (cpuid) {
+        return cpuid;
+    }
+
+    if (read_cpuinfo("Model Name", line, sizeof(line))) {
+        return 0;
+    }
+
+    ns = strchr(line, ':');
+    if (!ns) {
+        return 0;
+    }
+
+    ns = strstr(ns, "Loongson-");
+    if (!ns) {
+        return 0;
+    }
+
+    ns += strlen("Loongson-");
+    memccpy((void *)&cpuid, ns, 0, 8);
+    return cpuid;
+}
+
+static uint32_t get_host_cpucfg(int number)
+{
+    unsigned int data = 0;
+
+#ifdef __loongarch__
+    asm volatile("cpucfg %[val], %[reg]"
+                 : [val] "=r" (data)
+                 : [reg] "r" (number)
+                 : "memory");
+#endif
+
+    return data;
+}
+
+static void loongarch_host_initfn(Object *obj)
+{
+    uint32_t data;
+    uint64_t cpuid;
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    loongarch_max_initfn(obj);
+    data = get_host_cpucfg(0);
+    if (data) {
+        cpu->env.cpucfg[0] = data;
+    }
+
+    cpuid = get_host_cpu_model();
+    if (cpuid) {
+        cpu->env.cpu_id = cpuid;
+    }
+}
+#endif
+
 static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 {
     uint8_t tlb_ps;
@@ -811,6 +902,9 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
+#if defined(CONFIG_KVM)
+    DEFINE_LOONGARCH_CPU_TYPE(64, "host", loongarch_host_initfn),
+#endif
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.52.0


