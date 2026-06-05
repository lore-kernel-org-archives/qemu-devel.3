Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF60CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPr0-0006TF-Ex; Fri, 05 Jun 2026 04:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqy-0006ST-Mt
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqu-0004hj-Hw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:32 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Axp3i6hyJqu+MQAA--.21658S3;
 Fri, 05 Jun 2026 16:24:26 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S10;
 Fri, 05 Jun 2026 16:24:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 08/14] target/loongarch: Use sys_state in csr_helper.c when
 accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:46 +0800
Message-ID: <20260605082552.175336-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S10
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw13Ww13XrWkXr13CFyfAFc_yoW7ArykpF
 WIkry2kr45K3yDC3Z3Gas8Kr15Xr47Kw1xXa1Ikry2ya45Jr93WrW8Xw4xKF4DA3y5ur40
 ya4DZ3W0yrW7XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
 XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07j6sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

When accessing CSR registers in file csr_helper.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
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


