Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07812CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvYF-0007Tl-OD; Thu, 06 Nov 2025 03:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vGvY7-0007SP-Vj
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:40:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vGvY4-00082k-QH
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:40:55 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxxtAQXwxpVp8fAA--.1879S3;
 Thu, 06 Nov 2025 16:40:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+QPXwxpWXIpAQ--.58753S3;
 Thu, 06 Nov 2025 16:40:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/loongarch: Add host CPU model in kvm mode
Date: Thu,  6 Nov 2025 16:40:43 +0800
Message-Id: <20251106084043.2453749-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251106084043.2453749-1-maobibo@loongson.cn>
References: <20251106084043.2453749-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+QPXwxpWXIpAQ--.58753S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Host CPU model is basically the same with max CPU model, except Product
ID and CPU model name. With host CPU model, Product ID comes from
cpucfg0 and CPU model comes from /proc/cpuinfo.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8b8723a343..c7f52adeb9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -429,6 +429,97 @@ static void loongarch_max_initfn(Object *obj)
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
@@ -780,6 +871,9 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
+#if defined(CONFIG_KVM)
+    DEFINE_LOONGARCH_CPU_TYPE(64, "host", loongarch_host_initfn),
+#endif
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.39.3


