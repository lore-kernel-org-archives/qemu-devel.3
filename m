Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3171C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulj-0005Uu-Ju; Tue, 13 Aug 2024 12:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulg-0005Ik-BD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulT-00019W-IC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so39860335e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567974; x=1724172774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6mdvqGapAT8l5astMkQBnS/stJvWmHqNyjlZgMMHLw=;
 b=SiZperWCRy7n1DH3aF5j3MYI7S3kaUsVuHk1Ax6Wg9yX0H42qFnJfJs8EOhxNxTZT3
 D1ClNf/Dp7jAUr9meFCddQZ+MC5PBXwQgfG9qeqfXyeoXiSDKaMGg9vhGuSRzjOKSI0e
 XABI2ZK+W5Pu8bVAG7h+aZG0fpn2va0xInpPAeROG0EzgWkazRaHgtbaXij/7JxyiPv4
 lWdc42gYcwJ0pbZ4t89cghpPAXmFOlNQuztrSLzHc/K44mghbWAFn+BiVFs/Sby17xju
 k3+7WLSW3WQ6+T1iIIKGtMIOeJ4nRIRE1jbfWPOGWdj2Onhh7xH2ZfOo21dx7s8Jstdx
 xbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567974; x=1724172774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6mdvqGapAT8l5astMkQBnS/stJvWmHqNyjlZgMMHLw=;
 b=iBHBsraaiijsMyWRdqvuz4Sf4ibo/p+4zy3TYvvBkILhtW4lCDUnGKxZEUhYxqus5v
 TyFtmZ2HcD/MYNGGUeZVeUaRsghISMUQBH9Oct4A0ZoCLkYc3XTPqQKEY1BID7VK49lx
 G+08oTcKv1aa/nOTiiom4xt+psa8CNTDNV7YQN4VkuZRoBXpjRyUA09JGw5kMQ0jorUR
 sO51D8/8RSXk5F8lujgl6LVY4ejVRZKkvlr8X92W7iA9QocniBDD0zWCC4Obulez6MNo
 tGl0xDW9rOe4Hds6/NK/Nwqv5g0g8DLmMaaIGO5OOCIshsjifxWDwwYiNoqLxW02hXR5
 HZNg==
X-Gm-Message-State: AOJu0YxE4kU3e9TZ+9OnK1nXmjs3EtS3CoQya/SVPVcwZ4S+sp04+1k2
 0cf6QUT0hz8OOyCTzsTKud7kPEvsAkr/DQ/i3cVNE745rcCFMwNRWAks2bTAghipdGLj2tzYJPw
 B
X-Google-Smtp-Source: AGHT+IHRwOMlEIkQgoDUHLkrCCNpL5EJ1vpsBbnzFY9e+BEJswjiu+DDUnL/x3pU4kTnoLgVHwtOvQ==
X-Received: by 2002:a5d:490f:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-371777696edmr162735f8f.13.1723567973727; 
 Tue, 13 Aug 2024 09:52:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 02/10] target/s390: Convert CPU to Resettable interface
Date: Tue, 13 Aug 2024 17:52:42 +0100
Message-Id: <20240813165250.2717650-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert the s390 CPU to the Resettable interface.  This is slightly
more involved than the other CPU types were (see commits
9130cade5fc22..d66e64dd006df) because S390 has its own set of
different kinds of reset with different behaviours that it needs to
trigger.

We handle this by adding these reset types to the Resettable
ResetType enum.  Now instead of having an underlying implementation
of reset that is s390-specific and which might be called either
directly or via the DeviceClass::reset method, we can implement only
the Resettable hold phase method, and have the places that need to
trigger an s390-specific reset type do so by calling
resettable_reset().

The other option would have been to smuggle in the s390 reset
type via, for instance, a field in the CPU state that we set
in s390_do_cpu_initial_reset() etc and then examined in the
reset method, but doing it this way seems cleaner.

The motivation for this change is that this is the last caller
of the legacy device_class_set_parent_reset() function, and
removing that will let us clean up some glue code that we added
for the transition to three-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested with 'make check' and 'make check-avocado' only. The
descriptions of the reset types are borrowed from the commit
message of f5ae2a4fd8d573cfeba; please check them as I haven't
got a clue what s390 does ;-)
---
 docs/devel/reset.rst    | 10 ++++++++++
 include/hw/resettable.h |  2 ++
 target/s390x/cpu.h      | 21 ++++-----------------
 target/s390x/cpu.c      | 38 +++++++++++++++++---------------------
 target/s390x/sigp.c     |  8 ++------
 5 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 9746a4e8a0b..ed41e09f16d 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -44,6 +44,16 @@ The Resettable interface handles reset types with an enum ``ResetType``:
   value on each cold reset, such as RNG seed information, and which they
   must not reinitialize on a snapshot-load reset.
 
+``RESET_TYPE_S390_CPU_NORMAL``
+  This is only used for S390 CPU objects; it clears interrupts, stops
+  processing, and clears the TLB, but does not touch register contents.
+
+``RESET_TYPE_S390_CPU_INITIAL``
+  This is only used for S390 CPU objects; it does everything
+  ``RESET_TYPE_S390_CPU_NORMAL`` does and also clears the PSW, prefix,
+  FPC, timer and control registers. It does not touch gprs, fprs or acrs.
+
+
 Devices which implement reset methods must treat any unknown ``ResetType``
 as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
 existing code we need to change if we add more types in future.
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 7e249deb8b5..83b561fc830 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -36,6 +36,8 @@ typedef struct ResettableState ResettableState;
 typedef enum ResetType {
     RESET_TYPE_COLD,
     RESET_TYPE_SNAPSHOT_LOAD,
+    RESET_TYPE_S390_CPU_INITIAL,
+    RESET_TYPE_S390_CPU_NORMAL,
 } ResetType;
 
 /*
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d6b75ad0e08..6a644724038 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -177,19 +177,11 @@ struct ArchCPU {
     uint32_t irqstate_saved_size;
 };
 
-typedef enum cpu_reset_type {
-    S390_CPU_RESET_NORMAL,
-    S390_CPU_RESET_INITIAL,
-    S390_CPU_RESET_CLEAR,
-} cpu_reset_type;
-
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
+ * @parent_phases: The parent class' reset phase handlers.
  * @load_normal: Performs a load normal.
- * @cpu_reset: Performs a CPU reset.
- * @initial_cpu_reset: Performs an initial CPU reset.
  *
  * An S/390 CPU model.
  */
@@ -203,9 +195,8 @@ struct S390CPUClass {
     const char *desc;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
+    ResettablePhases parent_phases;
     void (*load_normal)(CPUState *cpu);
-    void (*reset)(CPUState *cpu, cpu_reset_type type);
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -872,16 +863,12 @@ static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
 
 static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->reset(cs, S390_CPU_RESET_NORMAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_NORMAL);
 }
 
 static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->reset(cs, S390_CPU_RESET_INITIAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
 }
 
 static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 0fbfcd35d83..4e41a3dff59 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -32,6 +32,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/resettable.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
 #include "sysemu/tcg.h"
@@ -162,23 +163,25 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 #endif
 }
 
-/* S390CPUClass::reset() */
-static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
+/* S390CPUClass Resettable reset_hold phase method */
+static void s390_cpu_reset_hold(Object *obj, ResetType type)
 {
-    S390CPU *cpu = S390_CPU(s);
+    S390CPU *cpu = S390_CPU(obj);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
-    DeviceState *dev = DEVICE(s);
 
-    scc->parent_reset(dev);
+    if (scc->parent_phases.hold) {
+        scc->parent_phases.hold(obj, type);
+    }
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     switch (type) {
-    case S390_CPU_RESET_CLEAR:
+    default:
+        /* RESET_TYPE_COLD: power on or "clear" reset */
         memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
         /* fall through */
-    case S390_CPU_RESET_INITIAL:
+    case RESET_TYPE_S390_CPU_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
                offsetof(CPUS390XState, start_normal_reset_fields) -
@@ -203,7 +206,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
        /* fall through */
-    case S390_CPU_RESET_NORMAL:
+    case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
         memset(&env->start_normal_reset_fields, 0,
                offsetof(CPUS390XState, end_reset_fields) -
@@ -212,20 +215,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         env->pfault_token = -1UL;
         env->bpbc = false;
         break;
-    default:
-        g_assert_not_reached();
     }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
     if (kvm_enabled()) {
         switch (type) {
-        case S390_CPU_RESET_CLEAR:
+        default:
             kvm_s390_reset_vcpu_clear(cpu);
             break;
-        case S390_CPU_RESET_INITIAL:
+        case RESET_TYPE_S390_CPU_INITIAL:
             kvm_s390_reset_vcpu_initial(cpu);
             break;
-        case S390_CPU_RESET_NORMAL:
+        case RESET_TYPE_S390_CPU_NORMAL:
             kvm_s390_reset_vcpu_normal(cpu);
             break;
         }
@@ -315,12 +316,6 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void s390_cpu_reset_full(DeviceState *dev)
-{
-    CPUState *s = CPU(dev);
-    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
-}
-
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -383,15 +378,16 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     S390CPUClass *scc = S390_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(scc);
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
     device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
-    device_class_set_parent_reset(dc, s390_cpu_reset_full, &scc->parent_reset);
+    resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
+                                       &scc->parent_phases);
 
-    scc->reset = s390_cpu_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
     cc->mmu_index = s390x_cpu_mmu_index;
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ad0ad61177d..1c99ec88009 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -251,24 +251,20 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
 
 static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->reset(cs, S390_CPU_RESET_INITIAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->reset(cs, S390_CPU_RESET_NORMAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_COLD);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.34.1


