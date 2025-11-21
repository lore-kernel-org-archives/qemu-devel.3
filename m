Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE70CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdNE-0008T9-Vg; Fri, 21 Nov 2025 21:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdNA-0008S7-No; Fri, 21 Nov 2025 21:29:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdMQ-00071D-9l; Fri, 21 Nov 2025 21:29:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A76CD16C6EE;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E63932198B;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 22/76] target/i386: clear CPU_INTERRUPT_SIPI for all
 accelerators
Date: Fri, 21 Nov 2025 16:51:00 +0300
Message-ID: <20251121135201.1114964-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Similar to what commit df32e5c5 did for TCG; fixes boot with multiple
processors on WHPX and probably more accelerators

Fixes: df32e5c568c ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", 2025-10-14)
Fixes: cf8dff8d9f9 ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", in 10.1.x)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3178
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d5e1d2dea11b803ba9121fc12d3c1662b79ad941)
(Mjt: context fix due to missing v10.1.0-119-g87511341c30d
 "add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 17fce1d3cd..062d634aa6 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -447,6 +447,7 @@ int hvf_process_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7137b46be1..7a62eb728e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5656,6 +5656,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 92e3b8b2f4..533a0e93e6 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -706,6 +706,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         cpu->halted = false;
     }
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b72dcff3c8..bd5e23ef9a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1618,6 +1618,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-- 
2.47.3


