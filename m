Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59854FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreN-0001kb-Ob; Mon, 04 May 2026 07:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdz-0001OO-49
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdx-0001UR-4y
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Nacj50LPwl+uBll+r6QnniZ9uS9YJmwxauJLN2L6nE=;
 b=bC/0fQNOyWn4GgAWrzwW8fd+FNw58veT3Rn6+zMVdAAO3PdzTASlpV0vlmlzxxR/Dx+Wsz
 L7VJ6caNGVnf54G5++OwDPYgJ8y/F0CRXjEAmR3N2QYn+TavNm1oqg9UkbJ25dKrzCfv6M
 MAjxtwUAc+Qah8GUS9eWCZym2v6Adw8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-stn6ZXEuPpWW9eg6w9dbpg-1; Mon,
 04 May 2026 07:39:18 -0400
X-MC-Unique: stn6ZXEuPpWW9eg6w9dbpg-1
X-Mimecast-MFC-AGG-ID: stn6ZXEuPpWW9eg6w9dbpg_1777894758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28A7195608C
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B7291800446; Mon,  4 May 2026 11:39:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:30 +0400
Subject: [PATCH v2 42/46] target/riscv: fix general_user_opts hash table leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-42-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9180;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GjCZY+GZGV2ac+w3QLM0yqTi7RE9xdyPxBERvh9403I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRu2hLIppNgBuAIu/zuHxJf1Tg3X2buL/5+N
 ujKKWaShuqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5RKAEACp6Alx6d/pM78suhudt9UMj97s4LvtWt8MkeFagR6xt4G7RZ3MVz+HuBkDXLbWD7Pvgcj
 O0YxVLsFy9eqE5OvtknFydi5U+nQNmjmoG2EWZL91vKTZh/2rvPCzgEDw2KVgKk+j9I87EXhI9n
 iLfpXdsOpakIPOGkOb4CTO91RZ/hf/xl8ICQCMuC5ai7tFlgbg7y15puUCnnrqEWchRABWU0VBo
 wG/LHWPHhmrnSakVIKiDUSNka0sWGVp0X+iyB8IvOmJJIP+Xh+8x6F61/Y3EsecQ/66o6pIeW5c
 zumjzhIQMWlSr8kimPTXaVWoXehx49o5lENa9k1b9OwhXMHtyN+/nlIyN4+bRGMrAKgm3TxouV3
 m+O0QOfNL+WWb4wl8U7/onVbf20Ubidw+H6BlBf3zcnXzhs75lljIMWI88uMARCUHNY8k3sylUE
 vtI7dOvoWyJpQN9a0Yk7ZSZkzEnJivkRzcujw/jD09qknwO6No4yNMggMIqd7nN/zwqzkfwhnQg
 I+MRm+mtP4xBcFU/03IcFunSWf5Zd1E3gE2kkPc7iZf3OBAQBnjdSt5VvOFUmtRwBm29JOllDIt
 CueeNSYgP50xydbJVD5uzfHTpyrmo6AZYySWGR2Ss14ywrXEl3jagpygNonsFXm1RAuBFRamjoO
 NQ0bw61kX2gt3Eg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h         |  3 ++-
 target/riscv/cpu.c         | 51 +++++++++++++++++++++++++++-------------------
 target/riscv/kvm/kvm-cpu.c |  6 +++---
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81c41e34296..55a26aeb5be 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -546,6 +546,7 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    GHashTable *user_options;
     const GPtrArray *decoders;
 };
 
@@ -619,7 +620,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
-bool riscv_cpu_option_set(const char *optname);
+bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37d..be9a3ac13e7 100644
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
@@ -1103,7 +1102,7 @@ static void riscv_cpu_init(Object *obj)
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
-    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
+    cpu->user_options = g_hash_table_new(g_str_hash, g_str_equal);
 
     /*
      * The timer and performance counters extensions were supported
@@ -1453,7 +1452,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
 
     warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
     cpu->cfg.pmu_mask = pmu_mask;
-    cpu_option_add_user_setting("pmu-mask", pmu_mask);
+    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
 }
 
 static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
@@ -1495,7 +1494,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmu_mask = value;
 }
 
@@ -1527,7 +1526,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.mmu = value;
 }
 
@@ -1559,7 +1558,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp = value;
 }
 
@@ -1599,7 +1598,7 @@ static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp_regions = value;
 }
 
@@ -1637,7 +1636,7 @@ static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.pmp_granularity = value;
 }
 
@@ -1710,7 +1709,7 @@ static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, priv_version);
+    cpu_option_add_user_setting(cpu, name, priv_version);
     cpu->env.priv_ver = priv_version;
 }
 
@@ -1744,7 +1743,7 @@ static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, VEXT_VERSION_1_00_0);
+    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1787,7 +1786,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.vlenb = value >> 3;
 }
 
@@ -1828,7 +1827,7 @@ static void prop_elen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.elen = value;
 }
 
@@ -1864,7 +1863,7 @@ static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cbom_blocksize = value;
 }
 
@@ -1900,7 +1899,7 @@ static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cbop_blocksize = value;
 }
 
@@ -1936,7 +1935,7 @@ static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(name, value);
+    cpu_option_add_user_setting(cpu, name, value);
     cpu->cfg.cboz_blocksize = value;
 }
 
@@ -2974,6 +2973,15 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
     DEFINE_RISCV_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
+static void riscv_cpu_instance_finalize(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    g_clear_pointer(&cpu->pmu_timer, timer_free);
+    g_clear_pointer(&cpu->pmu_event_ctr_map, g_hash_table_destroy);
+    g_clear_pointer(&cpu->user_options, g_hash_table_destroy);
+}
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -2981,6 +2989,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_finalize = riscv_cpu_instance_finalize,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0c..e0241870ada 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2025,7 +2025,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicbom &&
-        riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
+        riscv_cpu_option_set(cpu, kvm_cbom_blocksize.name)) {
 
         reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cbom_blocksize.kvm_reg_id);
@@ -2044,7 +2044,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicboz &&
-        riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
+        riscv_cpu_option_set(cpu, kvm_cboz_blocksize.name)) {
 
         reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cboz_blocksize.kvm_reg_id);
@@ -2063,7 +2063,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     /* Users are setting vlen, not vlenb */
-    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
+    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set(cpu, "vlen")) {
         if (!kvm_v_vlenb.supported) {
             error_setg(errp, "Unable to set 'vlenb': register not supported");
             return;

-- 
2.54.0


