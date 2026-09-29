Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80242CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXmf-00071g-5o; Tue, 29 Sep 2026 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1xBXmc-000718-Sy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1xBXma-0002rg-F0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790688124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iooU9FN5TIubzv7f6r7MGbmOFAuzxVs8SmVrAUE2K3M=;
 b=IJCZtf8MIvKUEOVhxgZyS+XI52rYOpaoiYjhhjOMlN99srNMlVVAxYN0LWdrypMXYZz98y
 /2ZQqn8Tw9izi48+KLX0uip2fbwZyWFrDS76THA2gUAftGGY7iQpezD2UV9SShm/JjZwwk
 jQBw1RnWeAXzKEnYNZDsfVS/D2mYcfc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-R0yXyohXMSSA1E91Re4yFQ-1; Tue,
 29 Sep 2026 09:22:03 -0400
X-MC-Unique: R0yXyohXMSSA1E91Re4yFQ-1
X-Mimecast-MFC-AGG-ID: R0yXyohXMSSA1E91Re4yFQ_1790688122
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09491954B27; Tue, 29 Sep 2026 13:22:01 +0000 (UTC)
Received: from jmarcin-thinkpadt14gen5.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DBDA768; Tue, 29 Sep 2026 13:22:00 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Add option to VMSD to synchronize CPU right after
 loading
Date: Tue, 29 Sep 2026 15:21:46 +0200
Message-ID: <20260929132150.2215007-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

Previously, the post init CPU synchronization with the accelerator, like
KVM, was performed in the bottom half of the POSTCOPY_RUN command
handler. However, this causes several problems.

First issue is that if CPU synchronization fails, the destination QEMU
crashes. However, it is too late to recover the source side as the
response to special PING has been already sent, and both sides are
already in the POSTCOPY_ACTIVE state.

By moving synchronization before responding, if the machine crashes, the
response is never sent and the source side can resume from the
POSTCOPY_DEVICE state.

Second issue is caused when migration is paused due to a network
failure or user command right after transitioning to the POSTCOPY_ACTIVE
state and the CPU synchronization causes a page fault. This page fault
blocks the CPU and the main QEMU threads and cannot be resolved until
postcopy migration is recovered. However, as libvirt also tries to
execute 'cont' QMP command at this time (destination side transitions
from POSTCOPY_DEVICE to POSTCOPY_ACTIVE), it will also halt waiting for
the response from the blocked main QEMU thread, unaware of the fact that
the migration is paused and needs to be recovered. Thus, it will wait
indefinitely and never report postcopy migration error.

This patch adds an option to VMSD that identifies devices that require
CPU post init synchronization and runs synchronization for those device
after they are loaded.

This moved CPU synchronization right to the device load and if this CPU
synchronization fails, or the network fails during it, the source side
can safely transition from POSTCOPY_DEVICE to a FAILED state.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
This patch an alternative approach to my previous RFC patch [1] that is
in my opinion less hacky and also pretty minimal.

[1]: https://lore.kernel.org/r/20260423154525.10292-1-jmarcin@redhat.com/
---
 include/migration/vmstate.h  | 6 ++++++
 migration/savevm.c           | 5 -----
 migration/vmstate.c          | 6 ++++++
 target/alpha/machine.c       | 1 +
 target/arm/machine.c         | 1 +
 target/avr/machine.c         | 1 +
 target/hexagon/machine.c     | 1 +
 target/hppa/machine.c        | 1 +
 target/i386/machine.c        | 1 +
 target/loongarch/machine.c   | 1 +
 target/m68k/cpu.c            | 1 +
 target/microblaze/machine.c  | 1 +
 target/mips/system/machine.c | 1 +
 target/or1k/machine.c        | 1 +
 target/ppc/machine.c         | 1 +
 target/riscv/machine.c       | 1 +
 target/s390x/machine.c       | 1 +
 target/sh4/cpu.c             | 1 +
 target/sparc/machine.c       | 1 +
 target/xtensa/cpu.c          | 1 +
 20 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2901877308..60ddeacdd5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -298,6 +298,12 @@ struct VMStateDescription {
      */
 
     bool early_setup;
+    /*
+     * This VMSD describes a CPU which requires synchronization with an
+     * accelerator after it's loaded. Can be set to true only if the device
+     * described by this VMSD is of type CPU.
+     */
+    bool cpu_sync;
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
diff --git a/migration/savevm.c b/migration/savevm.c
index 4b590ea672..d7153912b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2235,8 +2235,6 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
      */
-    cpu_synchronize_all_post_init();
-
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cpu-synced");
 
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
@@ -3217,8 +3215,6 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
         }
     }
 
-    cpu_synchronize_all_post_init();
-
     return ret;
 }
 
@@ -3233,7 +3229,6 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
         return ret;
     }
 
-    cpu_synchronize_all_post_init();
     return 0;
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 24004565bf..80a23f8943 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -19,6 +19,7 @@
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "system/hw_accel.h"
 #include "trace.h"
 
 static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
@@ -449,6 +450,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
         return false;
     }
 
+    if (vmsd->cpu_sync) {
+        CPUState *cpu = CPU(opaque);
+        cpu_synchronize_post_init(cpu);
+    }
+
     trace_vmstate_load_state_success(vmsd->name);
     return true;
 }
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index dcba5d441b..2b72159f06 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -82,6 +82,7 @@ static const VMStateField vmstate_cpu_fields[] = {
 
 const VMStateDescription vmstate_alpha_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = vmstate_cpu_fields,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 53a2734d25..cdc9003866 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1247,6 +1247,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_arm_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
diff --git a/target/avr/machine.c b/target/avr/machine.c
index 8064a7214a..9232c98e72 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -99,6 +99,7 @@ static const VMStateInfo vms_eind = {
 
 const VMStateDescription vms_avr_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index 179b6f53a2..23548639a7 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -21,6 +21,7 @@ static int hexagon_cpu_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_hexagon_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = hexagon_cpu_post_load,
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 6a143cf8df..bfc286caaa 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -224,6 +224,7 @@ static const VMStateField vmstate_cpu_fields[] = {
 
 const VMStateDescription vmstate_hppa_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = vmstate_cpu_fields,
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8d69d7e25e..ced3c9a2ac 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1806,6 +1806,7 @@ static const VMStateDescription vmstate_apx = {
 
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 12,
     .minimum_version_id = 11,
     .pre_save = cpu_pre_save,
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 931a5ca5ba..e6deddce58 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -210,6 +210,7 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 4,
     .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc2..28bc7bdd71 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -638,6 +638,7 @@ const VMStateDescription vmstate_68040_spregs = {
 
 static const VMStateDescription vmstate_m68k_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index f930ff8609..63c8816582 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -101,6 +101,7 @@ static const VMStateField vmstate_cpu_fields[] = {
 
 const VMStateDescription vmstate_mb_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = vmstate_cpu_fields,
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index bd1e4002cf..536d98f3c4 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -374,6 +374,7 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 21,
     .minimum_version_id = 21,
     .post_load = cpu_post_load,
diff --git a/target/or1k/machine.c b/target/or1k/machine.c
index 2d5ca16c51..abf11a37a5 100644
--- a/target/or1k/machine.c
+++ b/target/or1k/machine.c
@@ -133,6 +133,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_openrisc_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = cpu_post_load,
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 569536bd02..33b46d6f3c 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -733,6 +733,7 @@ static const VMStateDescription vmstate_bhrb = {
 
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 5,
     .minimum_version_id = 5,
     .pre_save = cpu_pre_save,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffce..f96f5b4dfb 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -497,6 +497,7 @@ static const VMStateDescription vmstate_mseccfg = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = 12,
     .minimum_version_id = 12,
 #ifdef CONFIG_KVM
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index b44fba43f1..411d563e25 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -256,6 +256,7 @@ static const VMStateDescription vmstate_diag318 = {
 
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .post_load = cpu_post_load,
     .pre_save = cpu_pre_save,
     .version_id = 4,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d..c9c724551b 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -285,6 +285,7 @@ static void superh_cpu_initfn(Object *obj)
 #ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_sh_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .unmigratable = 1,
 };
 
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 0d5d79b5e7..a45071b09a 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -227,6 +227,7 @@ static int cpu_pre_save(void *opaque)
 
 const VMStateDescription vmstate_sparc_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .version_id = SPARC_VMSTATE_VER,
     .minimum_version_id = SPARC_VMSTATE_VER,
     .pre_save = cpu_pre_save,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab70..c431450e58 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -298,6 +298,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 #ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_xtensa_cpu = {
     .name = "cpu",
+    .cpu_sync = true,
     .unmigratable = 1,
 };
 
-- 
2.55.0


