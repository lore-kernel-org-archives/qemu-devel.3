Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE18C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1XG-0007eP-Np; Tue, 12 Mar 2024 08:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VK-0004eP-9w
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VG-0000bR-6g
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5lHu+U43t6L8WpuhAtWEE4Tx07L6LU4E0h1kK66uE8=;
 b=Si13aIjSDiKuG3i9Z36FMlcvK64UhZ9DFEv8QhMp8yhJ1UZC1QSucqsLbZJ5EQxgxRr/HV
 IsRSwv3e73WRAsmCNjwyVx12hnnh4lWgi3jGcZNY1lCmai/cmokveydmgLTNDDTIadPx+4
 tL3m381zUjHL4q9vPDhkoM5glnpLLuo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-KL6iIMSfNnWewChIA9WDSA-1; Tue,
 12 Mar 2024 08:45:04 -0400
X-MC-Unique: KL6iIMSfNnWewChIA9WDSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3633D1C41A19;
 Tue, 12 Mar 2024 12:45:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C8B8492BC4;
 Tue, 12 Mar 2024 12:45:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 44/55] target/m68k: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:28 +0100
Message-ID: <20240312124339.761630-45-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-17-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/m68k/cpu.c       | 33 +++++++++++----------------------
 target/m68k/gdbstub.c   |  6 ++----
 target/m68k/helper.c    |  6 ++----
 target/m68k/m68k-semi.c |  6 ++----
 target/m68k/op_helper.c | 11 +++--------
 target/m68k/translate.c |  3 +--
 6 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9cc1de567f..7c8efbb42c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -74,9 +74,8 @@ static void m68k_unset_feature(CPUM68KState *env, int feature)
 static void m68k_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    M68kCPU *cpu = M68K_CPU(cs);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     floatx80 nan = floatx80_default_nan(NULL);
     int i;
 
@@ -122,8 +121,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char *cpu_model)
 
 static void m5206_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
@@ -132,8 +130,7 @@ static void m5206_cpu_initfn(Object *obj)
 /* Base feature set, including isns. for m68k family */
 static void m68000_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_M68K);
     m68k_set_feature(env, M68K_FEATURE_USP);
@@ -147,8 +144,7 @@ static void m68000_cpu_initfn(Object *obj)
  */
 static void m68010_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68000_cpu_initfn(obj);
     m68k_set_feature(env, M68K_FEATURE_M68010);
@@ -168,8 +164,7 @@ static void m68010_cpu_initfn(Object *obj)
  */
 static void m68020_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68010_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68010);
@@ -199,8 +194,7 @@ static void m68020_cpu_initfn(Object *obj)
  */
 static void m68030_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68020_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68020);
@@ -226,8 +220,7 @@ static void m68030_cpu_initfn(Object *obj)
  */
 static void m68040_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
@@ -247,8 +240,7 @@ static void m68040_cpu_initfn(Object *obj)
  */
 static void m68060_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68040_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68040);
@@ -261,8 +253,7 @@ static void m68060_cpu_initfn(Object *obj)
 
 static void m5208_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_APLUSC);
@@ -274,8 +265,7 @@ static void m5208_cpu_initfn(Object *obj)
 
 static void cfv4e_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_B);
@@ -288,8 +278,7 @@ static void cfv4e_cpu_initfn(Object *obj)
 
 static void any_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_B);
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 1e5f033a12..15547e2313 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -23,8 +23,7 @@
 
 int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     if (n < 8) {
         /* D0-D7 */
@@ -50,8 +49,7 @@ int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 44b245884e..1a475f082a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -906,8 +906,7 @@ txfail:
 
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     hwaddr phys_addr;
     int prot;
     int access_type;
@@ -955,8 +954,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType qemu_access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int access_type;
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index b4ffb70f8b..546cff2246 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -77,8 +77,7 @@ static int host_to_gdb_errno(int err)
 
 static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     target_ulong args = env->dregs[1];
     if (put_user_u32(ret, args) ||
@@ -95,8 +94,7 @@ static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 
 static void m68k_semi_u64_cb(CPUState *cs, uint64_t ret, int err)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     target_ulong args = env->dregs[1];
     if (put_user_u32(ret >> 32, args) ||
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 956e76eb5f..125f6c1b08 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -441,10 +441,7 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
 
 void m68k_cpu_do_interrupt(CPUState *cs)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
-
-    do_interrupt_all(env, 0);
+    do_interrupt_all(cpu_env(cs), 0);
 }
 
 static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
@@ -457,8 +454,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     cpu_restore_state(cs, retaddr);
 
@@ -511,8 +507,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     if (interrupt_request & CPU_INTERRUPT_HARD
         && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d7d5ff4300..6ae3df43bc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6100,8 +6100,7 @@ static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
 
 void m68k_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     int i;
     uint16_t sr;
     for (i = 0; i < 8; i++) {
-- 
2.44.0


