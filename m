Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891FFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OK-00029i-AS; Fri, 10 Oct 2025 04:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OI-00029O-Dv
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O8-00018H-WE
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehK5KRXCiUTeLGRom/AV7O2rUmdoOhUIvkIjSYXTaw4=;
 b=bZCnZphnZs6AxNij/nbzjSFjHm8EFsg3KQXIfIZu695d0fDSgJo5eHT3YL4A1G/qjw1B7H
 Rb0VOlYc4HQFKLVvESuDEnWO5NoPPbM4Rk3FIrcvmQsc+mqGvCc2cMcGy7nSAMpB5BMaky
 uAL7gTzwR5aYg7MMmLh9qCRrtniMmkI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-VfZd5VAhO9WV5ULh8Kqd2w-1; Fri,
 10 Oct 2025 04:22:04 -0400
X-MC-Unique: VfZd5VAhO9WV5ULh8Kqd2w-1
X-Mimecast-MFC-AGG-ID: VfZd5VAhO9WV5ULh8Kqd2w_1760084523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95D9C19560BB; Fri, 10 Oct 2025 08:22:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 291D21800452; Fri, 10 Oct 2025 08:22:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/9] target/s390x: Reduce s390_store_status() scope
Date: Fri, 10 Oct 2025 10:21:42 +0200
Message-ID: <20251010082145.576222-8-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

s390_store_status() is only called within sigp.c,
move it and the SigpSaveArea structure definition
there where it belongs, with other SIGP handling
code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251002091132.65703-9-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h |  2 --
 target/s390x/helper.c         | 67 ----------------------------------
 target/s390x/sigp.c           | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a49dca94a75..9691366ec91 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -323,8 +323,6 @@ void s390x_cpu_timer(void *opaque);
 void s390_handle_wait(S390CPU *cpu);
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 84321e1d68e..184428c6d9d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -24,7 +24,6 @@
 #include "gdbstub/helpers.h"
 #include "qemu/timer.h"
 #include "hw/s390x/ioinst.h"
-#include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/runstate.h"
@@ -182,69 +181,3 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
                               wp_flags, NULL);
     }
 }
-
-typedef struct SigpSaveArea {
-    uint64_t    fprs[16];                       /* 0x0000 */
-    uint64_t    grs[16];                        /* 0x0080 */
-    PSW         psw;                            /* 0x0100 */
-    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
-    uint32_t    prefix;                         /* 0x0118 */
-    uint32_t    fpc;                            /* 0x011c */
-    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
-    uint32_t    todpr;                          /* 0x0124 */
-    uint64_t    cputm;                          /* 0x0128 */
-    uint64_t    ckc;                            /* 0x0130 */
-    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
-    uint32_t    ars[16];                        /* 0x0140 */
-    uint64_t    crs[16];                        /* 0x0384 */
-} SigpSaveArea;
-QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
-
-int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
-{
-    static const uint8_t ar_id = 1;
-    SigpSaveArea *sa;
-    hwaddr len = sizeof(*sa);
-    int i;
-
-    /* For PVMs storing will occur when this cpu enters SIE again */
-    if (s390_is_pv()) {
-        return 0;
-    }
-
-    sa = cpu_physical_memory_map(addr, &len, true);
-    if (!sa) {
-        return -EFAULT;
-    }
-    if (len != sizeof(*sa)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
-    }
-    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
-    sa->psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(&cpu->env));
-    sa->prefix = cpu_to_be32(cpu->env.psa);
-    sa->fpc = cpu_to_be32(cpu->env.fpc);
-    sa->todpr = cpu_to_be32(cpu->env.todpr);
-    sa->cputm = cpu_to_be64(cpu->env.cputm);
-    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
-    for (i = 0; i < 16; ++i) {
-        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
-    }
-
-    cpu_physical_memory_unmap(sa, len, 1, len);
-
-    return 0;
-}
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 1464be76983..2487acdb49e 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -19,6 +19,7 @@
 #include "system/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
+#include "target/s390x/kvm/pv.h"
 
 QemuMutex qemu_sigp_mutex;
 
@@ -126,6 +127,73 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+typedef struct SigpSaveArea {
+    uint64_t    fprs[16];                       /* 0x0000 */
+    uint64_t    grs[16];                        /* 0x0080 */
+    PSW         psw;                            /* 0x0100 */
+    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
+    uint32_t    prefix;                         /* 0x0118 */
+    uint32_t    fpc;                            /* 0x011c */
+    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
+    uint32_t    todpr;                          /* 0x0124 */
+    uint64_t    cputm;                          /* 0x0128 */
+    uint64_t    ckc;                            /* 0x0130 */
+    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
+    uint32_t    ars[16];                        /* 0x0140 */
+    uint64_t    crs[16];                        /* 0x0384 */
+} SigpSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
+
+#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
+static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
+{
+    static const uint8_t ar_id = 1;
+    SigpSaveArea *sa;
+    hwaddr len = sizeof(*sa);
+    int i;
+
+    /* For PVMs storing will occur when this cpu enters SIE again */
+    if (s390_is_pv()) {
+        return 0;
+    }
+
+    sa = cpu_physical_memory_map(addr, &len, true);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (len != sizeof(*sa)) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (store_arch) {
+        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
+    }
+    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
+    sa->psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(&cpu->env));
+    sa->prefix = cpu_to_be32(cpu->env.psa);
+    sa->fpc = cpu_to_be32(cpu->env.fpc);
+    sa->todpr = cpu_to_be32(cpu->env.todpr);
+    sa->cputm = cpu_to_be64(cpu->env.cputm);
+    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+
+    return 0;
+}
+
 static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
-- 
2.51.0


