Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DB6CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtAw-0006mW-97; Tue, 09 Jun 2026 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAj-0006kN-9b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAg-0004v7-FK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:00 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx9Ojt4idqhDUSAA--.42436S3;
 Tue, 09 Jun 2026 17:54:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S10;
 Tue, 09 Jun 2026 17:54:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 08/14] target/loongarch: Use sys_state in csr_helper.c when
 accessing CSR registers
Date: Tue,  9 Jun 2026 17:28:18 +0800
Message-Id: <20260609092824.227250-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S10
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

When accessing CSR registers in file csr_helper.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605082552.175336-9-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/csr_helper.c | 55 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index cd35ca93c7..7dc33bc180 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -20,7 +20,8 @@
 
 target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
 {
-    int64_t old_v = env->CSR_STLBPS;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_STLBPS;
 
     /*
      * The real hardware only supports the min tlb_ps is 12
@@ -33,7 +34,7 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
     } else {
         /* Only update PS field, reserved bit keeps zero */
         val = FIELD_DP64(val, CSR_STLBPS, RESERVE, 0);
-        env->CSR_STLBPS = val;
+        sys->CSR_STLBPS = val;
     }
 
     return old_v;
@@ -42,17 +43,18 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
 target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 {
     int64_t v;
+    CPUSysState *sys = env_sys(env);
 
-    if (env->CSR_TLBRERA & 0x1) {
-        v = env->CSR_TLBRBADV;
+    if (sys->CSR_TLBRERA & 0x1) {
+        v = sys->CSR_TLBRBADV;
     } else {
-        v = env->CSR_BADV;
+        v = sys->CSR_BADV;
     }
 
     if ((v >> 63) & 0x1) {
-        v = env->CSR_PGDH;
+        v = sys->CSR_PGDH;
     } else {
-        v = env->CSR_PGDL;
+        v = sys->CSR_PGDL;
     }
 
     return v;
@@ -61,10 +63,11 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
 {
     LoongArchCPU *lac = env_archcpu(env);
+    CPUSysState *sys = env_sys(env);
 
-    env->CSR_CPUID = CPU(lac)->cpu_index;
+    sys->CSR_CPUID = CPU(lac)->cpu_index;
 
-    return env->CSR_CPUID;
+    return sys->CSR_CPUID;
 }
 
 target_ulong helper_csrrd_tval(CPULoongArchState *env)
@@ -77,16 +80,17 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
 target_ulong helper_csrrd_msgir(CPULoongArchState *env)
 {
     int irq, new;
+    CPUSysState *sys = env_sys(env);
 
-    irq = find_first_bit((unsigned long *)env->CSR_MSGIS, 256);
+    irq = find_first_bit((unsigned long *)sys->CSR_MSGIS, 256);
     if (irq < 256) {
-        clear_bit(irq, (unsigned long *)env->CSR_MSGIS);
-        new = find_first_bit((unsigned long *)env->CSR_MSGIS, 256);
+        clear_bit(irq, (unsigned long *)sys->CSR_MSGIS);
+        new = find_first_bit((unsigned long *)sys->CSR_MSGIS, 256);
         if (new < 256) {
             return irq;
         }
 
-        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
+        sys->CSR_ESTAT = FIELD_DP64(sys->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
     } else {
         /* bit 31 set 1 for no invalid irq */
         irq = BIT(31);
@@ -97,21 +101,23 @@ target_ulong helper_csrrd_msgir(CPULoongArchState *env)
 
 target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
 {
-    int64_t old_v = env->CSR_ESTAT;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_ESTAT;
 
     /* Only IS[1:0] can be written */
-    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, 0, 2, val);
+    sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
 
     return old_v;
 }
 
 target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
 {
-    int64_t old_v = env->CSR_ASID;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_ASID;
 
     /* Only ASID filed of CSR_ASID can be written */
-    env->CSR_ASID = deposit64(env->CSR_ASID, 0, 10, val);
-    if (old_v != env->CSR_ASID) {
+    sys->CSR_ASID = deposit64(sys->CSR_ASID, 0, 10, val);
+    if (old_v != sys->CSR_ASID) {
         tlb_flush(env_cpu(env));
     }
     return old_v;
@@ -120,7 +126,8 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
 target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
 {
     LoongArchCPU *cpu = env_archcpu(env);
-    int64_t old_v = env->CSR_TCFG;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_TCFG;
 
     cpu_loongarch_store_constant_timer_config(cpu, val);
 
@@ -143,7 +150,8 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
     uint8_t shift, ptbase;
-    int64_t old_v = env->CSR_PWCL;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_PWCL;
 
     /*
      * The real hardware only supports 64bit PTE width now, 128bit or others
@@ -160,14 +168,15 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
          qemu_log_mask(LOG_GUEST_ERROR,
                       "Attempted set ptbase 2^%d\n", ptbase);
     }
-    env->CSR_PWCL = val;
+    sys->CSR_PWCL = val;
     return old_v;
 }
 
 target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
 {
     uint8_t has_ptw;
-    int64_t old_v = env->CSR_PWCH;
+    CPUSysState *sys = env_sys(env);
+    int64_t old_v = sys->CSR_PWCH;
 
     val = FIELD_DP64(val, CSR_PWCH, RESERVE, 0);
     has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
@@ -175,6 +184,6 @@ target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
         val = FIELD_DP64(val, CSR_PWCH, HPTW_EN, 0);
     }
 
-    env->CSR_PWCH = val;
+    sys->CSR_PWCH = val;
     return old_v;
  }
-- 
2.54.0


