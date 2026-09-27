Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB8EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRc-00061l-BZ; Sun, 27 Sep 2026 06:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRD-0005tb-II; Sun, 27 Sep 2026 06:48:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRC-00010Q-1V; Sun, 27 Sep 2026 06:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=uP+om5gBEQvUnVDuPANeoovrK9XF3HWwiHpLiIgYkjs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HGRf4UxvtclVyVhwRJs3Ezbcd3HtFUqG8/RR4QaljsdztLqvpIa3CE9gvvRrN2JWF
 vXBEbgSedI56HbrgEChdOEURX0k7irwdHjHijCNTz98qVtD4dzfNniVEM+HV8LGeBY
 8mv6u2PRRfavQoVT4U0JJcY3euX6SzKz0fcFqla6ZqSpoqMTHzf14rOGgQgfqNv80E
 H2lGi0UWL8g8yBSmNmTN+EK+E8/904ML/LRJJoGIvcA5AOb/dG9PDC7gtIB8Z95RbZ
 wqvL1kQJdx4D3YPLEMn3nuGfNHcZgYVHsKRCQCTqUn4tFB1Ku5/2zTxy+btspTwDzZ
 NXRMI+mPHMH8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 631601D8B59;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60574432160;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 46C725E76A; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Miao Wang <shankerwangmiao@gmail.com>,
 Xianglai Li <lixianglai@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 58/92] target/loongarch: Fix data race in CSR_ESTAT
Date: Sun, 27 Sep 2026 13:47:34 +0300
Message-ID: <20260927104821.196183-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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

The CSR_ESTAT register of a CPU can be read and written by both the
CPU thread and other threads (e.g., the interrupt controller thread).
Currently the possible readers and writers of CSR_ESTAT are:

The access from the CPU thread is not synchronized with the access from
other threads, which may lead to data races. The above readers and
writers shall all run on the corresponding CPU thread except for
loongarch_cpu_set_irq(). To fix this, the access to CSR_ESTAT in
loongarch_cpu_set_irq() is moved to the CPU thread by using
async_run_on_cpu().

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   Xianglai Li <lixianglai@loongson.cn>
(cherry picked from commit 1d3e5a4b37fbee0505ddc99a0316d31422a9ac42)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7bc77cf67ec..bf7f8078110 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -74,13 +74,26 @@ void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
     }
 }
 
-void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
 {
-    LoongArchCPU *cpu = opaque;
-    CPULoongArchState *env = &cpu->env;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
+    int irq, level;
     uint64_t old;
 
+    irq = data.host_int & ~BIT(31);
+    level = (data.host_int >> 31) & 1;
+    old = sys->CSR_ESTAT;
+    sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
+    loongarch_cpu_update_irq(cpu, old);
+}
+
+void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+{
+    LoongArchCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
     if (irq < 0 || irq >= N_IRQS) {
         return;
     }
@@ -88,9 +101,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-        old = sys->CSR_ESTAT;
-        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        loongarch_cpu_update_irq(cpu, old);
+        irq |= (level & 1) << 31;
+        async_run_on_cpu(cs, loongarch_cpu_self_set_irq,
+                         RUN_ON_CPU_HOST_INT(irq));
     }
 }
 
-- 
2.47.3


