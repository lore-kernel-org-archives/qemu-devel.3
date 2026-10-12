Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B04CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjc-0003Gk-LJ; Mon, 12 Oct 2026 16:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjb-0003Fr-4x
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjY-000370-9m
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKZrJu+twhFunpUI45CErSVoUvBk7Udb42xrEtfVE2E=;
 b=e3MQkzDREy3MShtzF8bFpKgYmSyZuKslvD0O1CSkx1hboNn9dTsteZY6sM4vRmTLB27OA2
 NewkFc0k8CRnkCchM76JKsJETvp37UDQ+lhxuCRK7vDrA2KeN3j2EQsFsfkMvWKSfCFmQ2
 u7Fz4c1UmYHr0RbJTayDgMlGVchB2IY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-VLEZrFocN5-Ajz3dC40vQQ-1; Mon,
 12 Oct 2026 20:34:51 +0000
X-MC-Unique: VLEZrFocN5-Ajz3dC40vQQ-1
X-Mimecast-MFC-AGG-ID: VLEZrFocN5-Ajz3dC40vQQ_1791837287
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 504B21805A04; Mon, 12 Oct 2026 20:34:47 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46E36180034C; Mon, 12 Oct 2026 20:34:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:05 +0400
Subject: [PATCH v2 02/10] gdbstub: fix next register base after register gaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-2-6f95a2e139a9@redhat.com>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
In-Reply-To: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8490;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ri9Rl/LneKo4cjIH4ioWidVWFgxWvtouXvNPBu0fgWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURAGkVBboAS3BAn2EZW2B61PTypez/IBL6UV
 0mcagD0NNuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQAAKCRDa6OEJdZac
 5ajyEACew1iGJpAfcYsBHUqVgF6CER/zy+vuNVRBDue1f93Q653g2QDhc45fMwXci4ksgdSsprk
 S4YmNh/fsztn2G2NGOc8vLdkVHQhyBcYI9SiyajNZRi9YjY6KeZZJuG+YziVPGcGvEeB5Pl+PIG
 OmFw9+/d0wu9iY4EOivJKP58UaQPNIax9d39iyYTios4kB0qI5WaUdzFBhdGNaQ2o1x1Drya7BC
 61k+jGWrqDIWtA1fLxnZW/06hAvtK4T0CC5EAG19DCxxy6Fekw2YJncDMthbW1NgcwcLZbKcmiJ
 OlzC+Ghp6Vjd/wGmnmZWRK7hicxwi+VORW6cOzYdUyX8/zUDbUXN7TDyg9rJ5jSYOG8j/yXi2rX
 qSJIrmWJK9pHcOOj6mTtPS9aeiC/B9PSKJdTWt9xMHgWBH75KbJCa5gB8zSNm23YzSA7KV4DbBH
 1tq7VPZvB+0tz40v7Cu6oyf4phJOaFR8SetRcX67fSHnKi4Y4sAOocFHedz4RL2pT+HzjpPRxnY
 2fWxtMDd/r6hEQl2EUU45Rtv8SV03fnEFJf5YVBNGG6EoDATvTSTw9u1zeuuQ5f9EwWpMI1DPWY
 J/WbbUDbkFGw4ytKv09a7S/sWyWHdc0kuacc2MKOxVtLldrt4Jb2Nky7Vdkdo1PJoRx5tmjasX6
 kMInJgd49we6dXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit b3e88abb200c ("gdbstub: Consider GDBFeature::base_reg in
gdb_register_coprocessor()") identified that register numbers may
have gaps. We also need to adjust the next base_reg correctly
to avoid overlapping registers. Rename the field to be more
explicit about its usage.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 gdbstub/gdbstub.c      | 13 ++++++-------
 include/hw/core/cpu.h  |  2 +-
 target/arm/gdbstub.c   |  8 +++++---
 target/arm/gdbstub64.c | 10 ++++++----
 target/ppc/gdbstub.c   |  2 +-
 target/riscv/gdbstub.c |  9 ++++++---
 target/xtensa/cpu.c    |  2 +-
 7 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0a328b0dd488..0ce871d74929 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -605,13 +605,13 @@ void gdb_init_cpu(CPUState *cpu)
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
-        cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
+        cpu->gdb_next_base_reg = cpu->gdb_num_g_regs = feature->num_regs;
     } else {
-        cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
+        cpu->gdb_next_base_reg = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
 
     trace_gdbxml_init_cpu(object_get_typename(OBJECT(cpu)), cpu->cpu_index,
-                          cpu->gdb_num_regs, cpu->gdb_num_g_regs,
+                          cpu->gdb_next_base_reg, cpu->gdb_num_g_regs,
                           cc->gdb_num_core_regs);
 }
 
@@ -621,7 +621,7 @@ void gdb_register_coprocessor(CPUState *cpu,
 {
     GDBRegisterState *s;
     guint i;
-    int base_reg = cpu->gdb_num_regs;
+    int base_reg = cpu->gdb_next_base_reg;
 
     for (i = 0; i < cpu->gdb_regs->len; i++) {
         /* Check for duplicates.  */
@@ -639,7 +639,7 @@ void gdb_register_coprocessor(CPUState *cpu,
     gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
 
     /* Add to end of list.  */
-    cpu->gdb_num_regs += feature->num_regs;
+    cpu->gdb_next_base_reg = base_reg + feature->num_regs;
 }
 
 void gdb_unregister_coprocessor_all(CPUState *cpu)
@@ -651,7 +651,7 @@ void gdb_unregister_coprocessor_all(CPUState *cpu)
     g_array_free(cpu->gdb_regs, true);
 
     cpu->gdb_regs = NULL;
-    cpu->gdb_num_regs = 0;
+    cpu->gdb_next_base_reg = 0;
     cpu->gdb_num_g_regs = 0;
 }
 
@@ -2522,4 +2522,3 @@ void gdb_create_default_process(GDBState *s)
     process->attached = false;
     process->target_xml = NULL;
 }
-
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 328e30045ce1..02212f555c2e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -521,7 +521,7 @@ struct CPUState {
     struct CPUJumpCache *tb_jmp_cache;
 
     GArray *gdb_regs;
-    int gdb_num_regs;
+    int gdb_next_base_reg;
     int gdb_num_g_regs;
     QTAILQ_ENTRY(CPUState) node;
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index d6e29c4cf467..e5cbe4d951ef 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -555,19 +555,21 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
         gdb_register_coprocessor(cs, mve_gdb_get_reg, mve_gdb_set_reg,
                                  gdb_find_static_feature("arm-m-profile-mve.xml"));
     }
+    GDBFeature *feature =
+        arm_gen_dynamic_sysreg_feature(cs, cs->gdb_next_base_reg);
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs));
+                             feature);
 
 #ifdef CONFIG_TCG
     if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
         gdb_register_coprocessor(cs,
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
-            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs));
+            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_next_base_reg));
 #ifndef CONFIG_USER_ONLY
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             gdb_register_coprocessor(cs,
                 arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
-                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs));
+                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_next_base_reg));
         }
 #endif
     }
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 0c3e5b30bd6a..cf5b95b54641 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -885,7 +885,8 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     CPUState *cs = CPU(cpu);
     if (isar_feature_aa64_sve(&cpu->isar) ||
         isar_feature_aa64_sme(&cpu->isar)) {
-        GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
+        GDBFeature *feature =
+            arm_gen_dynamic_svereg_feature(cs, cs->gdb_next_base_reg);
         gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                  aarch64_gdb_set_sve_reg, feature);
     } else {
@@ -896,7 +897,7 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 
     if (isar_feature_aa64_sme(&cpu->isar)) {
         GDBFeature *sme_feature =
-            arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
+            arm_gen_dynamic_smereg_feature(cs, cs->gdb_next_base_reg);
         gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
                                  aarch64_gdb_set_sme_reg, sme_feature);
         if (isar_feature_aa64_sme2(&cpu->isar)) {
@@ -927,7 +928,8 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 #endif
 
     /* All AArch64 CPUs have at least TPIDR */
+    GDBFeature *tls_feature =
+        arm_gen_dynamic_tls_feature(cs, cs->gdb_next_base_reg);
     gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
-                             aarch64_gdb_set_tls_reg,
-                             arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs));
+                             aarch64_gdb_set_tls_reg, tls_feature);
 }
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 4d622c5cad59..ec25c541c685 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -206,7 +206,7 @@ static void gdb_gen_spr_feature(CPUState *cs)
 
     gdb_feature_builder_init(&builder, &pcc->gdb_spr,
                              "org.qemu.power.spr", "power-spr.xml",
-                             cs->gdb_num_regs);
+                             cs->gdb_next_base_reg);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 9abbf5bcdf0e..f279f4ab2461 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -348,9 +348,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  gdb_find_static_feature("riscv-32bit-fpu.xml"));
     }
     if (cpu->cfg.ext_zve32x) {
+        GDBFeature *feature =
+            ricsv_gen_dynamic_vector_feature(cs, cs->gdb_next_base_reg);
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
-                                 riscv_gdb_set_vector,
-                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs));
+                                 riscv_gdb_set_vector, feature);
     }
 
 #ifdef CONFIG_TCG
@@ -373,8 +374,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     if (cpu->cfg.ext_zicsr) {
+        GDBFeature *feature =
+            riscv_gen_dynamic_csr_feature(cs, cs->gdb_next_base_reg);
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs));
+                                 feature);
     }
 #endif
 }
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707a..48863a1859d4 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -263,7 +263,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    cs->gdb_num_regs = xcc->config->gdb_regmap.num_regs;
+    cs->gdb_next_base_reg = xcc->config->gdb_regmap.num_regs;
 
     qemu_init_vcpu(cs);
 

-- 
2.56.0.116.g6de20f6092dc


