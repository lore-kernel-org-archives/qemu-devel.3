Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14941CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ63a-0005EZ-2P; Mon, 15 Jun 2026 08:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33u-0006n5-7Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:54 -0400
Received: from out-181.mta0.migadu.com ([91.218.175.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33s-0005Rd-AJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781513569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmGJOFjPLK/OVWREwAr5PuAPfPwrzXxVlFOvZAt5ZpA=;
 b=hBw5UvjIZGbg0tBdizXfLTe82aPBJscjJqgC8ZW/lBL6mPgp32PXsYEgwHRmE27KHcdbtv
 LjczFf+mNyIOWf4cFvsiFKUSb1hn9fqsD3o/p03Mqwdbv97HJSTIWEjezUEWawpTCfTFa1
 MyajRfmFF6yZPPHO813nzVuiLD9a71E=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] target/loongarch: Enable PV TLB flush advertisement to
 the guest
Date: Mon, 15 Jun 2026 16:52:14 +0800
Message-ID: <20260615085214.44526-3-cui.tao@linux.dev>
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
References: <20260615085214.44526-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.181; envelope-from=cui.tao@linux.dev;
 helo=out-181.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:04:32 -0400
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

From: Tao Cui <cuitao@kylinos.cn>

Probe the KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH VM-level capability and, when
the host supports it, advertise KVM_FEATURE_PV_TLB_FLUSH to the guest by
including it in the CPUCFG_KVM_FEATURE feature mask handed to the kernel.

This mirrors the existing PV IPI / steal-time enablement.  A new
kvm-pv-tlb-flush CPU property (on/off/auto, default auto) lets users
disable the feature, e.g. when migrating to a host that lacks it.

The feature is only advertised when the host actually supports it, so a
guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
service PV TLB flush requests (which would otherwise lead to stale TLBs).

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/cpu.h                |  2 ++
 target/loongarch/kvm/kvm.c            | 38 +++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c |  4 +--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..94e8f176f4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -300,6 +300,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_PMU,
     LOONGARCH_FEATURE_PV_IPI,
     LOONGARCH_FEATURE_STEALTIME,
+    LOONGARCH_FEATURE_PV_TLB_FLUSH,
     LOONGARCH_FEATURE_PTW,
 };
 
@@ -447,6 +448,7 @@ struct ArchCPU {
     OnOffAuto msgint;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
+    OnOffAuto kvm_pv_tlb_flush;
     int32_t socket_id;  /* socket-id of this CPU */
     int32_t core_id;    /* core-id of this CPU */
     int32_t thread_id;  /* thread-id of this CPU */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..f91c388bf3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -981,6 +981,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_PV_TLB_FLUSH:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     case LOONGARCH_FEATURE_PTW:
         attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
         attr.attr = KVM_LOONGARCH_VM_FEAT_PTW;
@@ -1150,6 +1156,20 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
         env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
     }
 
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_TLB_FLUSH);
+    if (cpu->kvm_pv_tlb_flush == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pv_tlb_flush' not supported by KVM host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->kvm_pv_tlb_flush != ON_OFF_AUTO_AUTO) {
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->pv_features |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
+    }
+
     if (object_dynamic_cast(OBJECT(ms), TYPE_LOONGARCH_VIRT_MACHINE)) {
         LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
@@ -1266,6 +1286,18 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     cpu->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static bool kvm_pv_tlb_flush_get(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->kvm_pv_tlb_flush != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_pv_tlb_flush_set(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->kvm_pv_tlb_flush = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
     cpu->lbt = ON_OFF_AUTO_AUTO;
@@ -1291,6 +1323,12 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(OBJECT(cpu), "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    cpu->kvm_pv_tlb_flush = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(OBJECT(cpu), "kvm-pv-tlb-flush",
+                             kvm_pv_tlb_flush_get, kvm_pv_tlb_flush_set);
+    object_property_set_description(OBJECT(cpu), "kvm-pv-tlb-flush",
+                                    "Set off to disable KVM PV TLB flush.");
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f053f22bb8..5f372d85a9 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -41,8 +41,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", "msgint",
-    "ptw", NULL
+    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time",
+    "kvm-pv-tlb-flush", "msgint", "ptw", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.43.0


