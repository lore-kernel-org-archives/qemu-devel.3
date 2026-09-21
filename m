Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4EC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8h8T-0002k1-Sg; Mon, 21 Sep 2026 12:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x8h8S-0002jt-8G
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 12:44:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x8h8P-000732-1K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 12:44:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 7788CC09AB;
 Mon, 21 Sep 2026 19:44:45 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:126::1:23])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id iidWON1XjeA0-C2hX9359; Mon, 21 Sep 2026 19:44:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790009084;
 bh=ctlTJMRaGQ2Xv/+KT0Ox90raocjkW4/61p06QO57KEg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=DlvsTD1IbUmE7xGfy9y1ZrTestMsXpClMi9Z43eTNqZyv+yyvijzmGunH+ln8Sfsh
 1VpA1W/GzYow1X8t/KjYqzA4StoEBSYSVyu2KKTjPDN7+BEoaUktl4Nl1M6MRvKlP+
 MG7P0w1wJCJFF4IR0BfG/pe1itgCDa4EWwR0GRbA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	pbonzini@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH] kvm: turn fprintf into error_report
Date: Mon, 21 Sep 2026 19:44:42 +0300
Message-ID: <20260921164442.1137615-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Main benefit: ability to print timestamps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 accel/kvm/kvm-all.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a84..d271699db87 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -300,7 +300,7 @@ static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
         return slot;
     }
 
-    fprintf(stderr, "%s: no free slot available\n", __func__);
+    error_report("%s: no free slot available", __func__);
     abort();
 }
 
@@ -1702,8 +1702,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             mem->flags = 0;
             err = kvm_set_user_memory_region(kml, mem, false);
             if (err) {
-                fprintf(stderr, "%s: error unregistering slot: %s\n",
-                        __func__, strerror(-err));
+                error_report("%s: error unregistering slot: %s",
+                             __func__, strerror(-err));
                 abort();
             }
             start_addr += slot_size;
@@ -1730,8 +1730,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
-            fprintf(stderr, "%s: error registering slot: %s\n", __func__,
-                    strerror(-err));
+            error_report("%s: error registering slot: %s", __func__,
+                         strerror(-err));
             abort();
         }
 
@@ -2024,8 +2024,8 @@ static void kvm_mem_ioeventfd_add(MemoryListener *listener,
                                data, true, int128_get64(section->size),
                                match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
-                __func__, strerror(-r), -r);
+        error_report("%s: error adding ioeventfd(%d): %s (%d)",
+                     __func__, fd, strerror(-r), -r);
         abort();
     }
 }
@@ -2042,8 +2042,8 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
                                data, false, int128_get64(section->size),
                                match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
-                __func__, strerror(-r), -r);
+        error_report("%s: error deleting ioeventfd(%d): %s (%d)",
+                     __func__, fd, strerror(-r), -r);
         abort();
     }
 }
@@ -2060,8 +2060,8 @@ static void kvm_io_ioeventfd_add(MemoryListener *listener,
                               data, true, int128_get64(section->size),
                               match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
-                __func__, strerror(-r), -r);
+        error_report("%s: error adding ioeventfd(%d): %s (%d)",
+                     __func__, fd, strerror(-r), -r);
         abort();
     }
 }
@@ -2079,8 +2079,8 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
                               data, false, int128_get64(section->size),
                               match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
-                __func__, strerror(-r), -r);
+        error_report("%s: error deleting ioeventfd(%d): %s (%d)",
+                     __func__, fd, strerror(-r), -r);
         abort();
     }
 }
@@ -2143,7 +2143,7 @@ int kvm_set_irq(KVMState *s, int irq, int level)
     event.irq = irq;
     ret = kvm_vm_ioctl(s, s->irq_set_ioctl, &event);
     if (ret < 0) {
-        perror("kvm_set_irq");
+        error_report("kvm_set_irq: %s", strerror(-ret));
         abort();
     }
 
@@ -2581,7 +2581,7 @@ static int do_kvm_irqchip_create(KVMState *s)
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
         ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
         if (ret < 0) {
-            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
+            error_report("Enable kernel irqchip failed: %s", strerror(-ret));
             exit(1);
         }
     } else {
@@ -2589,7 +2589,7 @@ static int do_kvm_irqchip_create(KVMState *s)
     }
 
     if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
-        fprintf(stderr, "kvm: irqfd not implemented\n");
+        error_report("kvm: irqfd not implemented");
         exit(1);
     }
 
@@ -2605,7 +2605,7 @@ static int do_kvm_irqchip_create(KVMState *s)
         }
     }
     if (ret < 0) {
-        fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
+        error_report("Create kernel irqchip failed: %s", strerror(-ret));
         exit(1);
     }
 
@@ -3136,15 +3136,14 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
     int i;
 
-    fprintf(stderr, "KVM internal error. Suberror: %d\n",
-            run->internal.suberror);
+    error_report("KVM internal error. Suberror: %d", run->internal.suberror);
 
     for (i = 0; i < run->internal.ndata; ++i) {
-        fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
-                i, (uint64_t)run->internal.data[i]);
+        error_printf("extra data[%d]: 0x%016"PRIx64"\n",
+                     i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
-        fprintf(stderr, "emulation failure\n");
+        error_printf("emulation failure\n");
         if (!kvm_arch_stop_on_emulation_error(cpu)) {
             cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
             return EXCP_INTERRUPT;
@@ -3315,13 +3314,13 @@ static void kvm_eat_signals(CPUState *cpu)
     do {
         r = sigtimedwait(&waitset, &siginfo, &ts);
         if (r == -1 && !(errno == EAGAIN || errno == EINTR)) {
-            perror("sigtimedwait");
+            error_report("sigtimedwait: %s", strerror(errno));
             exit(1);
         }
 
         r = sigpending(&chkset);
         if (r == -1) {
-            perror("sigpending");
+            error_report("sigpending: %s", strerror(errno));
             exit(1);
         }
     } while (sigismember(&chkset, SIG_IPI));
@@ -3490,14 +3489,13 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
-                fprintf(stderr, "error: kvm run failed %s\n",
-                        strerror(-run_ret));
+                error_report("kvm run failed: %s", strerror(-run_ret));
 #ifdef TARGET_PPC
                 if (run_ret == -EBUSY) {
-                    fprintf(stderr,
-                            "This is probably because your SMT is enabled.\n"
-                            "VCPU can only run on primary threads with all "
-                            "secondary threads offline.\n");
+                    error_printf("This is probably because your SMT is "
+                                 "enabled.\n"
+                                 "VCPU can only run on primary threads with all "
+                                 "secondary threads offline.\n");
                 }
 #endif
                 ret = -1;
@@ -3533,8 +3531,8 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = EXCP_INTERRUPT;
             break;
         case KVM_EXIT_UNKNOWN:
-            fprintf(stderr, "KVM: unknown exit, hardware reason %" PRIx64 "\n",
-                    (uint64_t)run->hw.hardware_exit_reason);
+            error_report("KVM: unknown exit, hardware reason %" PRIx64,
+                         (uint64_t)run->hw.hardware_exit_reason);
             ret = -1;
             break;
         case KVM_EXIT_INTERNAL_ERROR:
@@ -3978,7 +3976,7 @@ void kvm_init_cpu_signals(CPUState *cpu)
         r = kvm_set_signal_mask(cpu, &set);
     }
     if (r) {
-        fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
+        error_report("kvm_set_signal_mask: %s", strerror(-r));
         exit(1);
     }
 }
-- 
2.43.0


