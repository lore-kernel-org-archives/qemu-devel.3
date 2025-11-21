Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA81ECFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcsJ-00073o-3o; Fri, 21 Nov 2025 20:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbk6-0008BF-5j; Fri, 21 Nov 2025 19:44:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbi3-0007B2-LJ; Fri, 21 Nov 2025 19:44:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E26916CA53;
 Fri, 21 Nov 2025 21:44:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0D323321C8F;
 Fri, 21 Nov 2025 21:44:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 24/81] target/i386: clear CPU_INTERRUPT_SIPI for all
 accelerators
Date: Fri, 21 Nov 2025 21:43:23 +0300
Message-ID: <20251121184424.1137669-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
Fixes: 1e8a7c403a7 ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", in 10.0.x)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3178
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d5e1d2dea11b803ba9121fc12d3c1662b79ad941)
(Mjt: context fix due to missing v10.1.0-119-g87511341c30d
 "add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 531a340b37..caebd64da1 100644
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
index f251286eb3..e77fb752c2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5637,6 +5637,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 04e5f7e637..396c59661d 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -704,6 +704,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         cpu->halted = false;
     }
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 41fb8c5a4e..7a95198dc4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1624,6 +1624,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-- 
2.47.3


