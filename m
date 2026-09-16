Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A45C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4a-0002OS-Jp; Wed, 16 Sep 2026 06:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2r-0006pJ-R9; Wed, 16 Sep 2026 06:39:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2p-00024Z-I4; Wed, 16 Sep 2026 06:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=c2rAGWS7JxMAnopiTe5LZGWIF4QdSHDKyal4nZrn0Ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=q7ji3mH/TJXL0rKx/o0TPrfl4zdYsDI1+p4V1Sbj6iFEc6FEmQSwmJfr0Lx5Ce08m
 kQuWRDlN4IGFJc9Dps9XklU7T6o1xxbzJPQOTLeRb5L6wdF4QczNT7HGQ/u4Y/SRK6
 4OtqM4ZOgx8jd4jT8Isu2IuV7cWGrwxsCogbdJlgL2UMWmR88Xwv/mcOa1FQGB2gD7
 7jJh17c74JadGdGW2QUWT8T4S8QvBegCwsl7xwsHAgdKiB/EH746JeWRAozXx2Qhia
 Ebtwom9oeZMFzEdgWjp1yN/4M2SgajNM+yNvGl8LXf27YlQGhk26XjQW4O7EEwnNAH
 LE78t2PuyfvXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 249361D5815;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E30DC429F72;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C3D025A821; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 "Andrew S. Rightenburg" <andrew@rail5.org>, Song Gao <17746591750@163.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 32/56] target/loongarch: Fix SWI interrupt delivery
 via CSR_ESTAT
Date: Wed, 16 Sep 2026 13:35:50 +0300
Message-ID: <20260916103622.684817-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
request state. As a result, software interrupts could be observed as pending
in CSR.ESTAT while no interrupt exception was taken.

Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the behavior of
loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock (BQL), so
take the BQL while calling cpu_interrupt().

Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:  Song Gao <17746591750@163.com>
Message-ID: <20260806120315.1059413-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit dd9641cb140d6e2c297f8d87c7875409e42319b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa8..7bc77cf67ec 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -57,12 +57,29 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
+{
+    CPULoongArchState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    CPUSysState *sys = env_sys(env);
+
+    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
+        if (!FIELD_EX64(old, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    } else {
+        if (FIELD_EX64(old, CSR_ESTAT, IS)) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
     CPUSysState *sys = env_sys(env);
+    uint64_t old;
 
     if (irq < 0 || irq >= N_IRQS) {
         return;
@@ -71,12 +88,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
+        old = sys->CSR_ESTAT;
         sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
+        loongarch_cpu_update_irq(cpu, old);
     }
 }
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e01dbed40f6..0b670f94661 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void loongarch_constant_timer_cb(void *opaque);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7dc33bc1802..155482efc69 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -106,6 +106,16 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
 
     /* Only IS[1:0] can be written */
     sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
+    /*
+     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
+     * Make sure the CPU interrupt request state tracks the pending bits,
+     * matching the behavior of loongarch_cpu_set_irq().
+     */
+    if (sys->CSR_ESTAT != old_v) {
+        bql_lock();
+        loongarch_cpu_update_irq(env_archcpu(env), old_v);
+        bql_unlock();
+    }
 
     return old_v;
 }
-- 
2.47.3


