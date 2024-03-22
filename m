Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AEAC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbkW-0008QR-8O; Fri, 22 Mar 2024 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rnbkT-0008Px-CJ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:03:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rnbkO-0004Kr-Vi
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:03:41 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxJ+hxV_1lyWkcAA--.47514S3;
 Fri, 22 Mar 2024 18:03:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTRNsV_1lE95hAA--.59909S3; 
 Fri, 22 Mar 2024 18:03:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] target/loongarch: Fix qemu-system-loongarch64 assert
 failed with the option '-d int'
Date: Fri, 22 Mar 2024 18:03:23 +0800
Message-Id: <20240322100323.1973836-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240322100323.1973836-1-gaosong@loongson.cn>
References: <20240322100323.1973836-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTRNsV_1lE95hAA--.59909S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

qemu-system-loongarch64 assert failed with the option '-d int',
the helper_idle() raise an exception EXCP_HLT, but the exception name is undefined.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240321123606.1704900-1-gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 74 +++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f6ffb3aadb..203a349055 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -45,33 +45,45 @@ const char * const fregnames[32] = {
     "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
 };
 
-static const char * const excp_names[] = {
-    [EXCCODE_INT] = "Interrupt",
-    [EXCCODE_PIL] = "Page invalid exception for load",
-    [EXCCODE_PIS] = "Page invalid exception for store",
-    [EXCCODE_PIF] = "Page invalid exception for fetch",
-    [EXCCODE_PME] = "Page modified exception",
-    [EXCCODE_PNR] = "Page Not Readable exception",
-    [EXCCODE_PNX] = "Page Not Executable exception",
-    [EXCCODE_PPI] = "Page Privilege error",
-    [EXCCODE_ADEF] = "Address error for instruction fetch",
-    [EXCCODE_ADEM] = "Address error for Memory access",
-    [EXCCODE_SYS] = "Syscall",
-    [EXCCODE_BRK] = "Break",
-    [EXCCODE_INE] = "Instruction Non-Existent",
-    [EXCCODE_IPE] = "Instruction privilege error",
-    [EXCCODE_FPD] = "Floating Point Disabled",
-    [EXCCODE_FPE] = "Floating Point Exception",
-    [EXCCODE_DBP] = "Debug breakpoint",
-    [EXCCODE_BCE] = "Bound Check Exception",
-    [EXCCODE_SXD] = "128 bit vector instructions Disable exception",
-    [EXCCODE_ASXD] = "256 bit vector instructions Disable exception",
+struct TypeExcp {
+    int32_t exccode;
+    const char * const name;
+};
+
+static const struct TypeExcp excp_names[] = {
+    {EXCCODE_INT, "Interrupt"},
+    {EXCCODE_PIL, "Page invalid exception for load"},
+    {EXCCODE_PIS, "Page invalid exception for store"},
+    {EXCCODE_PIF, "Page invalid exception for fetch"},
+    {EXCCODE_PME, "Page modified exception"},
+    {EXCCODE_PNR, "Page Not Readable exception"},
+    {EXCCODE_PNX, "Page Not Executable exception"},
+    {EXCCODE_PPI, "Page Privilege error"},
+    {EXCCODE_ADEF, "Address error for instruction fetch"},
+    {EXCCODE_ADEM, "Address error for Memory access"},
+    {EXCCODE_SYS, "Syscall"},
+    {EXCCODE_BRK, "Break"},
+    {EXCCODE_INE, "Instruction Non-Existent"},
+    {EXCCODE_IPE, "Instruction privilege error"},
+    {EXCCODE_FPD, "Floating Point Disabled"},
+    {EXCCODE_FPE, "Floating Point Exception"},
+    {EXCCODE_DBP, "Debug breakpoint"},
+    {EXCCODE_BCE, "Bound Check Exception"},
+    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
+    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCP_HLT, "EXCP_HLT"},
 };
 
 const char *loongarch_exception_name(int32_t exception)
 {
-    assert(excp_names[exception]);
-    return excp_names[exception];
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
+        if (excp_names[i].exccode == exception) {
+            return excp_names[i].name;
+        }
+    }
+    return "Unknown";
 }
 
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
@@ -80,7 +92,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s)\n",
+    qemu_log_mask(CPU_LOG_INT, "%s: expection: %d (%s)\n",
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
@@ -154,22 +166,16 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     CPULoongArchState *env = cpu_env(cs);
     bool update_badinstr = 1;
     int cause = -1;
-    const char *name;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
 
     if (cs->exception_index != EXCCODE_INT) {
-        if (cs->exception_index < 0 ||
-            cs->exception_index >= ARRAY_SIZE(excp_names)) {
-            name = "unknown";
-        } else {
-            name = excp_names[cs->exception_index];
-        }
-
         qemu_log_mask(CPU_LOG_INT,
                      "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                     " TLBRERA " TARGET_FMT_lx " %s exception\n", __func__,
-                     env->pc, env->CSR_ERA, env->CSR_TLBRERA, name);
+                     " TLBRERA " TARGET_FMT_lx " exception: %d (%s)\n",
+                     __func__, env->pc, env->CSR_ERA, env->CSR_TLBRERA,
+                     cs->exception_index,
+                     loongarch_exception_name(cs->exception_index));
     }
 
     switch (cs->exception_index) {
-- 
2.25.1


