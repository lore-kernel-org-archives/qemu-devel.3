Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AABDC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Xu-0000Mn-GJ; Tue, 12 Mar 2024 08:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VV-0005Mo-Uz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VT-0000s9-FW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V47akZkB3MNNJPOVhp+e0c7sV+XYzBjWKfYo7JWtsuc=;
 b=M23zDx1EPjpc/Mgo4ggBl46oOLGro7HjC2jqq7W7ULTWFX/I7qGK7HAz9fzmofVm8plcGs
 eLS2xwbVJ2LQBeL5YqTCDrzgPgMlrD/qXfWXZizWmFxleC/WiYfS+V8HYnlHcoBAETGTl4
 xbHE72RqAp3ismFe7DNmOWpkilzBDYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-0plU7JbWPmSiAZsOXp7tsQ-1; Tue, 12 Mar 2024 08:45:18 -0400
X-MC-Unique: 0plU7JbWPmSiAZsOXp7tsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4C880026F;
 Tue, 12 Mar 2024 12:45:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C9CD492BC4;
 Tue, 12 Mar 2024 12:45:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 53/55] target/tricore: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Tue, 12 Mar 2024 13:43:37 +0100
Message-ID: <20240312124339.761630-54-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20240129164514.73104-28-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/tricore/cpu.c       | 24 +++++-------------------
 target/tricore/gdbstub.c   |  6 ++----
 target/tricore/helper.c    |  3 +--
 target/tricore/translate.c |  3 +--
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 682fc290ac..a9af73aeb5 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -36,52 +36,38 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
 
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    env->PC = value & ~(target_ulong)1;
+    cpu_env(cs)->PC = value & ~(target_ulong)1;
 }
 
 static vaddr tricore_cpu_get_pc(CPUState *cs)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    return env->PC;
+    return cpu_env(cs)->PC;
 }
 
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->PC = tb->pc;
+    cpu_env(cs)->PC = tb->pc;
 }
 
 static void tricore_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    env->PC = data[0];
+    cpu_env(cs)->PC = data[0];
 }
 
 static void tricore_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(obj);
-    CPUTriCoreState *env = &cpu->env;
 
     if (tcc->parent_phases.hold) {
         tcc->parent_phases.hold(obj);
     }
 
-    cpu_state_reset(env);
+    cpu_state_reset(cpu_env(cs));
 }
 
 static bool tricore_cpu_has_work(CPUState *cs)
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index e8f8e5e6ea..f9309c5e27 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -106,8 +106,7 @@ static void tricore_cpu_gdb_write_csfr(CPUTriCoreState *env, int n,
 
 int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
 
     if (n < 16) { /* data registers */
         return gdb_get_reg32(mem_buf, env->gpr_d[n]);
@@ -121,8 +120,7 @@ int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 649373a9cb..6d9e80cc0c 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -67,8 +67,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                           MMUAccessType rw, int mmu_idx,
                           bool probe, uintptr_t retaddr)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 278c514ab0..c45e1d992e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -95,8 +95,7 @@ enum {
 
 void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     uint32_t psw;
     int i;
 
-- 
2.44.0


