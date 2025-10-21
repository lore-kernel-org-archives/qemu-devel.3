Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C7ECCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIZ-0002RQ-1B; Tue, 21 Oct 2025 16:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIR-0002AG-CL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIN-0001FL-HS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:31 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so4405531f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079763; x=1761684563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gp0SFofvlzLiW3dkCN7ra8y38q/vsb0gHhtDpLv4noc=;
 b=Mvyqty+GhRglsIb1FWhJ7jssuelM8I9ZVJw0q6+4sfatwkeVBpdeWR7NS9HDgVBSdk
 UT7NiSCltAMM+Dtfx/0/psy6gNgSG4k8K6t2Vvtoiinp7CAY3XJ2oX8Uf6NTgVvwuptP
 /uRZg12hCoq02dR2AggdNPB2gqb2gQ2u9jP2UIn4Ke4+b46WbClpWwhS++qRp3XGESBH
 EX/oJpGotI4bGt2frgVOkEaiAbS02Li2/ZYK7l+i+qJQIz4E9W3oQwJ9A/mMmhlHTprr
 CUHFa+Q7br0pUbFb5YitnFsLFd6DU3wp2yHo0HlDOk1jT4zGTDOQ84zpZjTwXT9zjk1o
 T79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079763; x=1761684563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp0SFofvlzLiW3dkCN7ra8y38q/vsb0gHhtDpLv4noc=;
 b=uGKjy22km5gwyuvOjo5f9qByByIyJAoaw0PlDSZ35VQv2HzGxAGWRymb+m7FzY5Nsx
 H0/NcBQUqesxj46AWMBcu4zeam68nOQhRyMtgWCQggk6EiqqpfPGqX4vTFyyJ0Rp08D9
 vwuvMGSnfZ053fAC+u6FG5NzpbfznWOEqsxrE5q5Q0MwbtGrb2VRB4wbUpZ0xytYjYth
 YmiejgI2Jf2WdFNYl9Yif3Q2dmia88axl6atetQs3ENkxU4B5R6HiNiiMyRBt2E6KDtm
 4EbTT3K7QV7Gw+I3gb7imG4m/Kx8pGRzJZ7Ksqe9qYi0qX0II1mXdiUSK34DC+UqeJDz
 1ecg==
X-Gm-Message-State: AOJu0YzacyUCnaOMq4/iCM6pNROB8y1a1PCCAdnet8d/8dtWyd9RyCjW
 Nuf0lR0By+A/rKypoI97emUQ35/aywGeUIe/nnvsRvjaXHbvX9GwHxl/OfSqN5/yhVZQwvL7/la
 prJPK6AE=
X-Gm-Gg: ASbGncukc6t/r4LDir9/5Nz1RYJt5wKijGtgIZuXKcx3//7V3OIdn1qFaH1hfuewvwu
 sNeFvA8FAGcnqMtUY4wvTixfXdo1A4xDfaCoNorx+hbi3XfvIAqSETklqDhim4c1FwdBi+rzg7E
 Nzb3D8kHpCcJ+IhGeIC6+YGK9jHIrrc713zNNrw9ze+xyJd/JvW/QchBB4rGl6f/6u/tYv2CrWo
 3eo+M2PuW5RDQTOv5wWP/ufNkK5sZTQXZD5N/p3IvV5mhX82riyLi+wOKo44z+MZPazLz1ezkK4
 96PmyqQc0zeciJ3RQyDyxTVKey0/okg/6VEw2Wydmcc/Z+24TCZB+bd215Fr+H68PEYo/UUSJB2
 //N0PccNxjuGoggVYTlSSYe5t3nxR/lCbAI3XpoSvW0JxbO5+Olf7eZyV0ysrGuSue/WV/n7/xk
 sIlJC7ZUyULlUiEPtYSoZec71k8ADXE5zGuJ+ictTACoOSsB0O5GHOJXfTKnET
X-Google-Smtp-Source: AGHT+IF5LnOj5cOOQSSWYM2xjgH8HwaNF8uXxD7Dhmw+zm8aHZnqUGt5hp/qK3oWs6CtkqYtu+qDnQ==
X-Received: by 2002:a05:6000:2209:b0:428:3ef4:9a0d with SMTP id
 ffacd0b85a97d-4283ef49ed1mr8043771f8f.49.1761079762440; 
 Tue, 21 Oct 2025 13:49:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm21843389f8f.47.2025.10.21.13.49.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/45] hw/i386/apic: Prefer APICCommonState over DeviceState
Date: Tue, 21 Oct 2025 22:46:44 +0200
Message-ID: <20251021204700.56072-31-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Makes the APIC API more type-safe by resolving quite a few APIC_COMMON
downcasts.

Like PICCommonState, the APICCommonState is now a public typedef while staying
an abstract datatype.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/apic.h           | 33 +++++------
 include/hw/i386/apic_internal.h  |  7 +--
 target/i386/cpu.h                |  5 +-
 target/i386/kvm/kvm_i386.h       |  2 +-
 target/i386/whpx/whpx-internal.h |  4 +-
 hw/i386/kvm/apic.c               |  3 +-
 hw/i386/vapic.c                  |  2 +-
 hw/i386/x86-cpu.c                |  2 +-
 hw/intc/apic.c                   | 97 +++++++++++++-------------------
 hw/intc/apic_common.c            | 56 +++++++-----------
 target/i386/cpu-apic.c           | 18 +++---
 target/i386/cpu-dump.c           |  2 +-
 target/i386/cpu.c                |  2 +-
 target/i386/kvm/kvm.c            |  2 +-
 target/i386/whpx/whpx-apic.c     |  3 +-
 15 files changed, 98 insertions(+), 140 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index eb606d60760..871f1428885 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -1,28 +1,29 @@
 #ifndef APIC_H
 #define APIC_H
 
+typedef struct APICCommonState APICCommonState;
 
 /* apic.c */
 void apic_set_max_apic_id(uint32_t max_apic_id);
-int apic_accept_pic_intr(DeviceState *s);
-void apic_deliver_pic_intr(DeviceState *s, int level);
-void apic_deliver_nmi(DeviceState *d);
-int apic_get_interrupt(DeviceState *s);
-int cpu_set_apic_base(DeviceState *s, uint64_t val);
-uint64_t cpu_get_apic_base(DeviceState *s);
-bool cpu_is_apic_enabled(DeviceState *s);
-void cpu_set_apic_tpr(DeviceState *s, uint8_t val);
-uint8_t cpu_get_apic_tpr(DeviceState *s);
-void apic_init_reset(DeviceState *s);
-void apic_sipi(DeviceState *s);
-void apic_poll_irq(DeviceState *d);
-void apic_designate_bsp(DeviceState *d, bool bsp);
-int apic_get_highest_priority_irr(DeviceState *dev);
+int apic_accept_pic_intr(APICCommonState *s);
+void apic_deliver_pic_intr(APICCommonState *s, int level);
+void apic_deliver_nmi(APICCommonState *s);
+int apic_get_interrupt(APICCommonState *s);
+int cpu_set_apic_base(APICCommonState *s, uint64_t val);
+uint64_t cpu_get_apic_base(APICCommonState *s);
+bool cpu_is_apic_enabled(APICCommonState *s);
+void cpu_set_apic_tpr(APICCommonState *s, uint8_t val);
+uint8_t cpu_get_apic_tpr(APICCommonState *s);
+void apic_init_reset(APICCommonState *s);
+void apic_sipi(APICCommonState *s);
+void apic_poll_irq(APICCommonState *s);
+void apic_designate_bsp(APICCommonState *s, bool bsp);
+int apic_get_highest_priority_irr(APICCommonState *s);
 int apic_msr_read(int index, uint64_t *val);
 int apic_msr_write(int index, uint64_t val);
-bool is_x2apic_mode(DeviceState *d);
+bool is_x2apic_mode(APICCommonState *s);
 
 /* pc.c */
-DeviceState *cpu_get_current_apic(void);
+APICCommonState *cpu_get_current_apic(void);
 
 #endif
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 429278da618..4a62fdceb4e 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -22,6 +22,7 @@
 #define QEMU_APIC_INTERNAL_H
 
 #include "cpu.h"
+#include "hw/i386/apic.h"
 #include "system/memory.h"
 #include "qemu/timer.h"
 #include "target/i386/cpu-qom.h"
@@ -125,8 +126,6 @@
 #define VAPIC_ENABLE_BIT                0
 #define VAPIC_ENABLE_MASK               (1 << VAPIC_ENABLE_BIT)
 
-typedef struct APICCommonState APICCommonState;
-
 #define TYPE_APIC_COMMON "apic-common"
 typedef struct APICCommonClass APICCommonClass;
 DECLARE_OBJ_CHECKERS(APICCommonState, APICCommonClass,
@@ -203,8 +202,8 @@ typedef struct VAPICState {
 extern bool apic_report_tpr_access;
 
 bool apic_next_timer(APICCommonState *s, int64_t current_time);
-void apic_enable_tpr_access_reporting(DeviceState *d, bool enable);
-void apic_enable_vapic(DeviceState *d, hwaddr paddr);
+void apic_enable_tpr_access_reporting(APICCommonState *s, bool enable);
+void apic_enable_vapic(APICCommonState *s, hwaddr paddr);
 
 void vapic_report_tpr_access(DeviceState *dev, CPUState *cpu, target_ulong ip,
                              TPRAccess access);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ce948861a76..d0da9bfe58c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -27,6 +27,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/memop.h"
+#include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
@@ -2349,7 +2350,7 @@ struct ArchCPU {
 
     /* in order to simplify APIC support, we leave this pointer to the
        user */
-    struct DeviceState *apic_state;
+    APICCommonState *apic_state;
     struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
     Notifier machine_done;
 
@@ -2830,7 +2831,7 @@ bool cpu_svm_has_intercept(CPUX86State *env, uint32_t type);
 
 /* apic.c */
 void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
-void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
+void apic_handle_tpr_access_report(APICCommonState *s, target_ulong ip,
                                    TPRAccess access);
 
 /* Special values for X86CPUVersion: */
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 5f83e8850a2..5c908fdd6a5 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -56,7 +56,7 @@ bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
 
-void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
+void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic);
 void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_has_x2apic_api(void);
diff --git a/target/i386/whpx/whpx-internal.h b/target/i386/whpx/whpx-internal.h
index 6633e9c4ca3..2dcad1f5650 100644
--- a/target/i386/whpx/whpx-internal.h
+++ b/target/i386/whpx/whpx-internal.h
@@ -5,6 +5,8 @@
 #include <winhvplatform.h>
 #include <winhvemulation.h>
 
+#include "hw/i386/apic.h"
+
 typedef enum WhpxBreakpointState {
     WHPX_BP_CLEARED = 0,
     WHPX_BP_SET_PENDING,
@@ -44,7 +46,7 @@ struct whpx_state {
 };
 
 extern struct whpx_state whpx_global;
-void whpx_apic_get(DeviceState *s);
+void whpx_apic_get(APICCommonState *s);
 
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
 
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1be9bfe36e9..82355f04631 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -60,9 +60,8 @@ static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic
     kvm_apic_set_reg(kapic, 0x3e, s->divide_conf);
 }
 
-void kvm_get_apic_state(DeviceState *dev, struct kvm_lapic_state *kapic)
+void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
 {
-    APICCommonState *s = APIC_COMMON(dev);
     int i, v;
 
     if (kvm_has_x2apic_api() && s->apicbase & MSR_IA32_APICBASE_EXTD) {
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 0c1c92c4793..f1089f0a7c8 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -490,7 +490,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ulong ip,
 }
 
 typedef struct VAPICEnableTPRReporting {
-    DeviceState *apic;
+    APICCommonState *apic;
     bool enable;
 } VAPICEnableTPRReporting;
 
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index c876e6709e0..1a86a853d5f 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -86,7 +86,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     return intno;
 }
 
-DeviceState *cpu_get_current_apic(void)
+APICCommonState *cpu_get_current_apic(void)
 {
     if (current_cpu) {
         X86CPU *cpu = X86_CPU(current_cpu);
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index c7680338563..cb35c80c75b 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -181,10 +181,8 @@ static void apic_local_deliver(APICCommonState *s, int vector)
     }
 }
 
-void apic_deliver_pic_intr(DeviceState *dev, int level)
+void apic_deliver_pic_intr(APICCommonState *s, int level)
 {
-    APICCommonState *s = APIC(dev);
-
     if (level) {
         apic_local_deliver(s, APIC_LVT_LINT0);
     } else {
@@ -301,10 +299,8 @@ static void apic_deliver_irq(uint32_t dest, uint8_t dest_mode,
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
 }
 
-bool is_x2apic_mode(DeviceState *dev)
+bool is_x2apic_mode(APICCommonState *s)
 {
-    APICCommonState *s = APIC(dev);
-
     return s->apicbase & MSR_IA32_APICBASE_EXTD;
 }
 
@@ -388,15 +384,12 @@ static void apic_set_tpr(APICCommonState *s, uint8_t val)
     }
 }
 
-int apic_get_highest_priority_irr(DeviceState *dev)
+int apic_get_highest_priority_irr(APICCommonState *s)
 {
-    APICCommonState *s;
-
-    if (!dev) {
+    if (!s) {
         /* no interrupts */
         return -1;
     }
-    s = APIC_COMMON(dev);
     return get_highest_priority_int(s->irr);
 }
 
@@ -458,22 +451,19 @@ static int apic_irq_pending(APICCommonState *s)
 static void apic_update_irq(APICCommonState *s)
 {
     CPUState *cpu;
-    DeviceState *dev = (DeviceState *)s;
 
     cpu = CPU(s->cpu);
     if (!qemu_cpu_is_self(cpu)) {
         cpu_interrupt(cpu, CPU_INTERRUPT_POLL);
     } else if (apic_irq_pending(s) > 0) {
         cpu_interrupt(cpu, CPU_INTERRUPT_HARD);
-    } else if (!apic_accept_pic_intr(dev) || !pic_get_output(isa_pic)) {
+    } else if (!apic_accept_pic_intr(s) || !pic_get_output(isa_pic)) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
     }
 }
 
-void apic_poll_irq(DeviceState *dev)
+void apic_poll_irq(APICCommonState *s)
 {
-    APICCommonState *s = APIC(dev);
-
     apic_sync_vapic(s, SYNC_FROM_VAPIC);
     apic_update_irq(s);
 }
@@ -516,7 +506,7 @@ static void apic_eoi(APICCommonState *s)
 
 static bool apic_match_dest(APICCommonState *apic, uint32_t dest)
 {
-    if (is_x2apic_mode(&apic->parent_obj)) {
+    if (is_x2apic_mode(apic)) {
         return apic->initial_apic_id == dest;
     } else {
         return apic->id == (uint8_t)dest;
@@ -550,7 +540,7 @@ static void apic_get_broadcast_bitmask(uint32_t *deliver_bitmask,
     for (i = 0; i < max_apics; i++) {
         apic_iter = local_apics[i];
         if (apic_iter) {
-            bool apic_in_x2apic = is_x2apic_mode(&apic_iter->parent_obj);
+            bool apic_in_x2apic = is_x2apic_mode(apic_iter);
 
             if (is_x2apic_broadcast && apic_in_x2apic) {
                 apic_set_bit(deliver_bitmask, i);
@@ -642,27 +632,24 @@ static void apic_startup(APICCommonState *s, int vector_num)
     cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_SIPI);
 }
 
-void apic_sipi(DeviceState *dev)
+void apic_sipi(APICCommonState *s)
 {
-    APICCommonState *s = APIC(dev);
-
     if (!s->wait_for_sipi)
         return;
     cpu_x86_load_seg_cache_sipi(s->cpu, s->sipi_vector);
     s->wait_for_sipi = 0;
 }
 
-static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
+static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
                          uint8_t delivery_mode, uint8_t vector_num,
                          uint8_t trigger_mode, uint8_t dest_shorthand)
 {
-    APICCommonState *s = APIC(dev);
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
     g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
     uint32_t current_apic_id;
 
-    if (is_x2apic_mode(dev)) {
+    if (is_x2apic_mode(s)) {
         current_apic_id = s->initial_apic_id;
     } else {
         current_apic_id = s->id;
@@ -709,18 +696,15 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
 
 static bool apic_check_pic(APICCommonState *s)
 {
-    DeviceState *dev = (DeviceState *)s;
-
-    if (!apic_accept_pic_intr(dev) || !pic_get_output(isa_pic)) {
+    if (!apic_accept_pic_intr(s) || !pic_get_output(isa_pic)) {
         return false;
     }
-    apic_deliver_pic_intr(dev, 1);
+    apic_deliver_pic_intr(s, 1);
     return true;
 }
 
-int apic_get_interrupt(DeviceState *dev)
+int apic_get_interrupt(APICCommonState *s)
 {
-    APICCommonState *s = APIC(dev);
     int intno;
 
     /* if the APIC is installed or enabled, we let the 8259 handle the
@@ -752,9 +736,8 @@ int apic_get_interrupt(DeviceState *dev)
     return intno;
 }
 
-int apic_accept_pic_intr(DeviceState *dev)
+int apic_accept_pic_intr(APICCommonState *s)
 {
-    APICCommonState *s = APIC(dev);
     uint32_t lvt0;
 
     if (!s)
@@ -788,20 +771,18 @@ static void apic_timer(void *opaque)
 
 static int apic_register_read(int index, uint64_t *value)
 {
-    DeviceState *dev;
     APICCommonState *s;
     uint32_t val;
     int ret = 0;
 
-    dev = cpu_get_current_apic();
-    if (!dev) {
+    s = cpu_get_current_apic();
+    if (!s) {
         return -1;
     }
-    s = APIC(dev);
 
     switch(index) {
     case 0x02: /* id */
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             val = s->initial_apic_id;
         } else {
             val = s->id << 24;
@@ -828,14 +809,14 @@ static int apic_register_read(int index, uint64_t *value)
         val = 0;
         break;
     case 0x0d:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             val = s->extended_log_dest;
         } else {
             val = s->log_dest << 24;
         }
         break;
     case 0x0e:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             val = 0;
             ret = -1;
         } else {
@@ -902,14 +883,14 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
 
 int apic_msr_read(int index, uint64_t *val)
 {
-    DeviceState *dev;
+    APICCommonState *s;
 
-    dev = cpu_get_current_apic();
-    if (!dev) {
+    s = cpu_get_current_apic();
+    if (!s) {
         return -1;
     }
 
-    if (!is_x2apic_mode(dev)) {
+    if (!is_x2apic_mode(s)) {
         return -1;
     }
 
@@ -943,20 +924,18 @@ static void apic_send_msi(MSIMessage *msi)
 
 static int apic_register_write(int index, uint64_t val)
 {
-    DeviceState *dev;
     APICCommonState *s;
 
-    dev = cpu_get_current_apic();
-    if (!dev) {
+    s = cpu_get_current_apic();
+    if (!s) {
         return -1;
     }
-    s = APIC(dev);
 
     trace_apic_register_write(index, val);
 
     switch(index) {
     case 0x02:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             return -1;
         }
 
@@ -979,14 +958,14 @@ static int apic_register_write(int index, uint64_t val)
         apic_eoi(s);
         break;
     case 0x0d:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             return -1;
         }
 
         s->log_dest = val >> 24;
         break;
     case 0x0e:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             return -1;
         }
 
@@ -1005,20 +984,20 @@ static int apic_register_write(int index, uint64_t val)
         uint32_t dest;
 
         s->icr[0] = val;
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             s->icr[1] = val >> 32;
             dest = s->icr[1];
         } else {
             dest = (s->icr[1] >> 24) & 0xff;
         }
 
-        apic_deliver(dev, dest, (s->icr[0] >> 11) & 1,
+        apic_deliver(s, dest, (s->icr[0] >> 11) & 1,
                      (s->icr[0] >> 8) & 7, (s->icr[0] & 0xff),
                      (s->icr[0] >> 15) & 1, (s->icr[0] >> 18) & 3);
         break;
     }
     case 0x31:
-        if (is_x2apic_mode(dev)) {
+        if (is_x2apic_mode(s)) {
             return -1;
         }
 
@@ -1053,7 +1032,7 @@ static int apic_register_write(int index, uint64_t val)
     case 0x3f: {
         int vector = val & 0xff;
 
-        if (!is_x2apic_mode(dev)) {
+        if (!is_x2apic_mode(s)) {
             return -1;
         }
 
@@ -1063,7 +1042,7 @@ static int apic_register_write(int index, uint64_t val)
          * - Trigger mode: 0 (Edge)
          * - Delivery mode: 0 (Fixed)
          */
-        apic_deliver(dev, 0, 0, APIC_DM_FIXED, vector, 0, 1);
+        apic_deliver(s, 0, 0, APIC_DM_FIXED, vector, 0, 1);
 
         break;
     }
@@ -1102,14 +1081,14 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
 
 int apic_msr_write(int index, uint64_t val)
 {
-    DeviceState *dev;
+    APICCommonState *s;
 
-    dev = cpu_get_current_apic();
-    if (!dev) {
+    s = cpu_get_current_apic();
+    if (!s) {
         return -1;
     }
 
-    if (!is_x2apic_mode(dev)) {
+    if (!is_x2apic_mode(s)) {
         return -1;
     }
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 394fe020134..ec9e978b0b4 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -35,12 +35,11 @@
 
 bool apic_report_tpr_access;
 
-int cpu_set_apic_base(DeviceState *dev, uint64_t val)
+int cpu_set_apic_base(APICCommonState *s, uint64_t val)
 {
     trace_cpu_set_apic_base(val);
 
-    if (dev) {
-        APICCommonState *s = APIC_COMMON(dev);
+    if (s) {
         APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
         /* Reset possibly modified xAPIC ID */
         s->id = s->initial_apic_id;
@@ -50,10 +49,9 @@ int cpu_set_apic_base(DeviceState *dev, uint64_t val)
     return 0;
 }
 
-uint64_t cpu_get_apic_base(DeviceState *dev)
+uint64_t cpu_get_apic_base(APICCommonState *s)
 {
-    if (dev) {
-        APICCommonState *s = APIC_COMMON(dev);
+    if (s) {
         trace_cpu_get_apic_base((uint64_t)s->apicbase);
         return s->apicbase;
     } else {
@@ -62,52 +60,43 @@ uint64_t cpu_get_apic_base(DeviceState *dev)
     }
 }
 
-bool cpu_is_apic_enabled(DeviceState *dev)
+bool cpu_is_apic_enabled(APICCommonState *s)
 {
-    APICCommonState *s;
-
-    if (!dev) {
+    if (!s) {
         return false;
     }
 
-    s = APIC_COMMON(dev);
-
     return s->apicbase & MSR_IA32_APICBASE_ENABLE;
 }
 
-void cpu_set_apic_tpr(DeviceState *dev, uint8_t val)
+void cpu_set_apic_tpr(APICCommonState *s, uint8_t val)
 {
-    APICCommonState *s;
     APICCommonClass *info;
 
-    if (!dev) {
+    if (!s) {
         return;
     }
 
-    s = APIC_COMMON(dev);
     info = APIC_COMMON_GET_CLASS(s);
 
     info->set_tpr(s, val);
 }
 
-uint8_t cpu_get_apic_tpr(DeviceState *dev)
+uint8_t cpu_get_apic_tpr(APICCommonState *s)
 {
-    APICCommonState *s;
     APICCommonClass *info;
 
-    if (!dev) {
+    if (!s) {
         return 0;
     }
 
-    s = APIC_COMMON(dev);
     info = APIC_COMMON_GET_CLASS(s);
 
     return info->get_tpr(s);
 }
 
-void apic_enable_tpr_access_reporting(DeviceState *dev, bool enable)
+void apic_enable_tpr_access_reporting(APICCommonState *s, bool enable)
 {
-    APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     apic_report_tpr_access = enable;
@@ -116,26 +105,22 @@ void apic_enable_tpr_access_reporting(DeviceState *dev, bool enable)
     }
 }
 
-void apic_enable_vapic(DeviceState *dev, hwaddr paddr)
+void apic_enable_vapic(APICCommonState *s, hwaddr paddr)
 {
-    APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     s->vapic_paddr = paddr;
     info->vapic_base_update(s);
 }
 
-void apic_handle_tpr_access_report(DeviceState *dev, target_ulong ip,
+void apic_handle_tpr_access_report(APICCommonState *s, target_ulong ip,
                                    TPRAccess access)
 {
-    APICCommonState *s = APIC_COMMON(dev);
-
     vapic_report_tpr_access(s->vapic, CPU(s->cpu), ip, access);
 }
 
-void apic_deliver_nmi(DeviceState *dev)
+void apic_deliver_nmi(APICCommonState *s)
 {
-    APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     info->external_nmi(s);
@@ -193,16 +178,14 @@ uint32_t apic_get_current_count(APICCommonState *s)
     return val;
 }
 
-void apic_init_reset(DeviceState *dev)
+void apic_init_reset(APICCommonState *s)
 {
-    APICCommonState *s;
     APICCommonClass *info;
     int i;
 
-    if (!dev) {
+    if (!s) {
         return;
     }
-    s = APIC_COMMON(dev);
     s->tpr = 0;
     s->spurious_vec = 0xff;
     s->log_dest = 0;
@@ -233,13 +216,12 @@ void apic_init_reset(DeviceState *dev)
     }
 }
 
-void apic_designate_bsp(DeviceState *dev, bool bsp)
+void apic_designate_bsp(APICCommonState *s, bool bsp)
 {
-    if (dev == NULL) {
+    if (s == NULL) {
         return;
     }
 
-    APICCommonState *s = APIC_COMMON(dev);
     if (bsp) {
         s->apicbase |= MSR_IA32_APICBASE_BSP;
     } else {
@@ -262,7 +244,7 @@ static void apic_reset_common(DeviceState *dev)
     s->vapic_paddr = 0;
     info->vapic_base_update(s);
 
-    apic_init_reset(dev);
+    apic_init_reset(s);
 }
 
 static const VMStateDescription vmstate_apic_common;
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 242a05fdbe9..564c1288e47 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -41,34 +41,31 @@ APICCommonClass *apic_get_class(Error **errp)
 
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
 {
-    APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
 
     if (!apic_class) {
         return;
     }
 
-    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
+    cpu->apic_state = APIC_COMMON(object_new_with_class(OBJECT_CLASS(apic_class)));
     object_property_add_child(OBJECT(cpu), "lapic",
                               OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
 
     /* TODO: convert to link<> */
-    apic = APIC_COMMON(cpu->apic_state);
-    apic->cpu = cpu;
-    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
+    cpu->apic_state->cpu = cpu;
+    cpu->apic_state->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
 
     /*
      * apic_common_set_id needs to check if the CPU has x2APIC
-     * feature in case APIC ID >= 255, so we need to set apic->cpu
+     * feature in case APIC ID >= 255, so we need to set cpu->apic_state->cpu
      * before setting APIC ID
      */
-    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
+    qdev_prop_set_uint32(DEVICE(cpu->apic_state), "id", cpu->apic_id);
 }
 
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
 {
-    APICCommonState *apic;
     static bool apic_mmio_map_once;
 
     if (cpu->apic_state == NULL) {
@@ -77,12 +74,11 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
     qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
 
     /* Map APIC MMIO area */
-    apic = APIC_COMMON(cpu->apic_state);
     if (!apic_mmio_map_once) {
         memory_region_add_subregion_overlap(get_system_memory(),
-                                            apic->apicbase &
+                                            cpu->apic_state->apicbase &
                                             MSR_IA32_APICBASE_BASE,
-                                            &apic->io_memory,
+                                            &cpu->apic_state->io_memory,
                                             0x1000);
         apic_mmio_map_once = true;
      }
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index a72ed93bd2f..67bf31e0caa 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -291,7 +291,7 @@ static void dump_apic_interrupt(const char *name, uint32_t *ireg_tab,
 void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 {
     X86CPU *cpu = X86_CPU(cs);
-    APICCommonState *s = APIC_COMMON(cpu->apic_state);
+    APICCommonState *s = cpu->apic_state;
     if (!s) {
         qemu_printf("local apic state not available\n");
         return;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 455caff6b23..0a66e1fec93 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8789,7 +8789,7 @@ void x86_cpu_after_reset(X86CPU *cpu)
     }
 
     if (cpu->apic_state) {
-        device_cold_reset(cpu->apic_state);
+        device_cold_reset(DEVICE(cpu->apic_state));
     }
 #endif
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 309f043373c..f7a6ef650af 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5029,7 +5029,7 @@ static int kvm_get_mp_state(X86CPU *cpu)
 
 static int kvm_get_apic(X86CPU *cpu)
 {
-    DeviceState *apic = cpu->apic_state;
+    APICCommonState *apic = cpu->apic_state;
     struct kvm_lapic_state kapic;
     int ret;
 
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index e1ef6d4e6d4..afcb25843b5 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -151,9 +151,8 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
     }
 }
 
-void whpx_apic_get(DeviceState *dev)
+void whpx_apic_get(APICCommonState *s)
 {
-    APICCommonState *s = APIC_COMMON(dev);
     CPUState *cpu = CPU(s->cpu);
     struct whpx_lapic_state kapic;
 
-- 
2.51.0


