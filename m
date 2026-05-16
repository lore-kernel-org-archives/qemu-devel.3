Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331A6CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xj-0001ta-9b; Sat, 16 May 2026 04:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xe-0001ke-LE
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xc-0007wk-8k
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiVpfAURbMJRJexkrYsuy4LkqPOHmyGZglcMijYKadc=;
 b=bCEKM+NsKw7YnOEqNSp7g5YHPLuXdOIjCBPrmIWsbQpooqOFK9qKjPmI254ZcHnFsGVFcF
 HG/wGUd4Ux4OIxFxZBGHqj7a2bVWMl3qryeMBUsfvGjb98k/0pdKsQsoDtuDUpMOJSI52P
 gQAYWbroxEw82q3xTlrTRbLHHfc7nHY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673--FK4itS0Opiy58xzXe_mLg-1; Sat,
 16 May 2026 04:01:19 -0400
X-MC-Unique: -FK4itS0Opiy58xzXe_mLg-1
X-Mimecast-MFC-AGG-ID: -FK4itS0Opiy58xzXe_mLg_1778918478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 856D5195608C
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:18 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 696F318001E8; Sat, 16 May 2026 08:01:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:20 +0400
Subject: [PATCH v3 21/24] target/riscv: fix general_user_opts hash table leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-21-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9216;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HSJyUZRh3kfWl1FGVv9/24mNwb8SAbISnT1vB5tCT84=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPsT5NozCdEiIsJd4E4gjhtTQkulw1iJIsz
 IpvbLtpEUSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5dpyEACQcxXZcLVtrP16I659NG4Bb9PFTyKxZKLfmI8cG6HhqreCjUjMeuLMex395i3nDL2ozcH
 O5tUR6jJeNt9OFPsL1vdXjMfRAK0+Kda69LR49opoN723D0hT9qXqoWQBWt7BrVRHaogMvST1SV
 DYGIQKQRK++4er9eavhTYFrrUO1dGKm4ZZcArUMSx6Jc/DY9jQVq1uh8AvKrWdqZAd8rT0XCa1/
 Rm58l0fKhWlgf/ncNyHR7lRw1+Ruk4R2F5oioxfDtF3DKPcpYLURq3qlsXizgLYsx4H6YF1L7bu
 Kz1toSTrCHbTGKBzom7D2brggz9PnKMirIvLqOsk3Gd/lfvmViBus4qYR6hh86U7C+05nn4zeDZ
 OrtkMd9DDl1hHtkldm3p+gLbPL6RZupXud0H52HgNQVqSC1+NprCU8SxPMvVC4koq3o2gpBk7Sb
 itKact8TRbPB4BCUhY7nJlA+oIbn1pxZa1nGfdCo86cDdp/Pro0sujqhnOfYg3WFDePyeIHmUc/
 V8QA4vSu1J4t18EBpmqdecRNTCnbCk8IR+FRYRyO6BRRnYSzH082RxPTFj9NXSrd3TAMDPKNNnf
 o6gWS7l2DKEHlA3yRTMZysWOW1DDM4gfZkrkN0jTnWU+sZctaYkyX/V1V10VKG3tWehxfbSjqYt
 tYERm/x5QMYCQhw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.c         | 53 ++++++++++++++++++++++++++++------------------
 target/riscv/kvm/kvm-cpu.c |  6 +++---
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fae839cade4..86a38a7288b 100644
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
index 506a018d52b..bbdc9d8f5de 100644
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
 
@@ -2975,6 +2974,17 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
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
@@ -2982,6 +2992,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


