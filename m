Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0AACD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPa-0005p3-1i; Sat, 06 Jun 2026 01:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPX-0005eg-Na
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPV-0008Oa-Ng
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrHGxvWCZFyP9F/U9uEn3LFLHsakCxnRmQhrxq0JqIM=;
 b=XA2KaCogFnlaHtpO1qrkBYCcji7TE2fqHHgQRB3T4M79p8orn8DUXftvXQgNl3kTZ4plPB
 OTMfboVFsALJcJ9OiZa9U8NOgG0BfFbulgJgXNxf1SAHCc3PHBC052B+dNHopFoHf20WAn
 k/bO/X0U1rZVpf4188rYJsKr32pM4uk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-zVBi4th0M0SN4YLRYvbZmg-1; Sat,
 06 Jun 2026 01:17:27 -0400
X-MC-Unique: zVBi4th0M0SN4YLRYvbZmg-1
X-Mimecast-MFC-AGG-ID: zVBi4th0M0SN4YLRYvbZmg_1780723046
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 881B219560A3
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25D8127A; Sat,  6 Jun 2026 05:17:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:52 +0400
Subject: [GIT PULL v2 20/23] target/riscv: fix general_user_opts hash table
 leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-20-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=9672;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HxjHARniAbZ71B0WPuGb8+FlvpnOsoMgTb+xCutausA=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGojrPWjWXFS+LLANXzBhceNeydolH995wH2wv7RaE8uqGpGc
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqI6z1AAoJENro4Ql1lpzlhoYP/iN5
 SkHyiV56MKqKuvg0gx1oMbNm7a2tQlmzy20iOwpTjY9Xt42kCLichODMUKdtsswKKtD+IbWjzUw
 s89m6oD/9JDKIaHQ7rtfWaPLP+K1ZIgw1xZiZvNm5Xqy0xeZk64LN1MF5R8eibD7GXSQ7F5aUaW
 XX6qS0UMd/rkU2znEe7HVIabbbAnonw9qKM0/c9i+0n115om3QSyTJdqAG6GMpi1dtYynUtS6LE
 hRp9pRmYBWbZCffTzEqh+RqWxYK8CgluaYsFUvyobQ3x7epwx3/LuXbSZ8zDucdfjaUujiQPFjm
 1bapgtSigQFvzX+1zQVEpp+6/LrMSYGC8bTsm7Gw4mPjKaqwTGyCEtNVe5/0PB+DMdkTKGco7+A
 xq0bodjqaGGkjydTma0D58tQU8xdg6p3NW5zXl7I7eHU9KZd8WN+RbYvGjz90ZOBtK2TYFFAP6m
 pKQTrxJA1y2FwgJM/0mE0RSkqyVKDQQWCSW7YBCDl2J+q4kFGpVDyWEYsxmsEAxz2JH/Lzi3x+R
 qin3MEiYUGtZAL2MpsBVJPIa0+nQBvgU8Qqf+vYmvU0kr1r8dOvMg1y6YGKUsp/PSWvYwo4XiEf
 XvyMX8vtVvaB4zWx0ExXoXIcpnSo3UMBRn0etS+vXvWRoH4YC4tzknEu0yZegHhXQPUi8P1BgRw
 UxLnS
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The global general_user_opts hash table is recreated on every
riscv_cpu_init() call, leaking the previous one.

Furthermore, the CPU settings should be associated with their instance
and not global.

Add a finalize() to free associated instances.

Fixes: d167a2247ede ("target/riscv: move 'pmu-mask' and 'pmu-num' to riscv_cpu_properties[]")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h         |  3 ++-
 target/riscv/cpu.c         | 53 ++++++++++++++++++++++++++++------------------
 target/riscv/kvm/kvm-cpu.c |  8 +++----
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7e..f7d8a08c087 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,6 +547,7 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    GHashTable *user_options;
     const GPtrArray *decoders;
 };
 
@@ -620,7 +621,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
-bool riscv_cpu_option_set(const char *optname);
+bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b4809..57000983edd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
+#include "qemu/timer.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
@@ -59,18 +60,16 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
 }
 
-/* Hash that stores general user set numeric options */
-static GHashTable *general_user_opts;
-
-static void cpu_option_add_user_setting(const char *optname, uint32_t value)
+static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optname,
+                                        uint32_t value)
 {
-    g_hash_table_insert(general_user_opts, (gpointer)optname,
+    g_hash_table_insert(cpu->user_options, (gpointer)optname,
                         GUINT_TO_POINTER(value));
 }
 
-bool riscv_cpu_option_set(const char *optname)
+bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname)
 {
-    return g_hash_table_contains(general_user_opts, optname);
+    return g_hash_table_contains(cpu->user_options, optname);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1126,7 +1125,7 @@ static void riscv_cpu_init(Object *obj)
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
-    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
+    cpu->user_options = g_hash_table_new(g_str_hash, g_str_equal);
 
     /*
      * The timer and performance counters extensions were supported
@@ -1291,7 +1290,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
 
     warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
     cpu->cfg.pmu_mask = pmu_mask;
-    cpu_option_add_user_setting("pmu-mask", pmu_mask);
+    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
 }
 
 static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
@@ -1333,7 +1332,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmu_mask = value;
 }
 
@@ -1365,7 +1364,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.mmu = value;
 }
 
@@ -1397,7 +1396,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp = value;
 }
 
@@ -1437,7 +1436,7 @@ static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp_regions = value;
 }
 
@@ -1475,7 +1474,7 @@ static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp_granularity = value;
 }
 
@@ -1548,7 +1547,7 @@ static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, priv_version);
+    cpu_option_add_user_setting(cpu, name, priv_version);
     cpu->env.priv_ver = priv_version;
 }
 
@@ -1582,7 +1581,7 @@ static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, VEXT_VERSION_1_00_0);
+    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1625,7 +1624,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.vlenb = value >> 3;
 }
 
@@ -1666,7 +1665,7 @@ static void prop_elen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.elen = value;
 }
 
@@ -1702,7 +1701,7 @@ static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cbom_blocksize = value;
 }
 
@@ -1738,7 +1737,7 @@ static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cbop_blocksize = value;
 }
 
@@ -1774,7 +1773,7 @@ static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cboz_blocksize = value;
 }
 
@@ -2834,6 +2833,17 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
     DEFINE_RISCV_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
+static void riscv_cpu_instance_finalize(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+#ifndef CONFIG_USER_ONLY
+    g_clear_pointer(&cpu->pmu_timer, timer_free);
+    g_clear_pointer(&cpu->pmu_event_ctr_map, g_hash_table_destroy);
+#endif
+    g_clear_pointer(&cpu->user_options, g_hash_table_destroy);
+}
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -2841,6 +2851,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_finalize = riscv_cpu_instance_finalize,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 17ba38403a3..53d88339c13 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2034,7 +2034,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicbom &&
-        riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
+        riscv_cpu_option_set(cpu, kvm_cbom_blocksize.name)) {
 
         reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cbom_blocksize.kvm_reg_id);
@@ -2053,7 +2053,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicboz &&
-        riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
+        riscv_cpu_option_set(cpu, kvm_cboz_blocksize.name)) {
 
         reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cboz_blocksize.kvm_reg_id);
@@ -2072,7 +2072,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicbop &&
-        riscv_cpu_option_set(kvm_cbop_blocksize.name)) {
+        riscv_cpu_option_set(cpu, kvm_cbop_blocksize.name)) {
 
         reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cbop_blocksize.kvm_reg_id);
@@ -2091,7 +2091,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     /* Users are setting vlen, not vlenb */
-    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
+    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set(cpu, "vlen")) {
         if (!kvm_v_vlenb.supported) {
             error_setg(errp, "Unable to set 'vlenb': register not supported");
             return;

-- 
2.54.0


