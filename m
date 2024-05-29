Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45DC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxe-0004ah-0e; Wed, 29 May 2024 06:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxb-0004Z7-Kx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxV-00036J-4a
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umqyx+sqblUVWcxcj/vmKXhAQlU/X72R57z6brOfNs4=;
 b=XwKlYdonD2PHr4QY66QmIvAwQUIFZ7fG7I5gIaW/XLEkB8J4s3J7r3eZrSMm61GKXSVl2g
 vLi3lTJgjHkNir+hK7qVxZ+StnSBLBEZti2XHpjOODfZIDS6gQwSwqIfwm4h28NZL8RAs/
 iy/ZSdqfrHlqus6/b5pOGQmBm9nirxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-MsaHgxpIOm6RFbSPOgVt6A-1; Wed, 29 May 2024 06:55:02 -0400
X-MC-Unique: MsaHgxpIOm6RFbSPOgVt6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 569EB185A780;
 Wed, 29 May 2024 10:55:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41B97105480A;
 Wed, 29 May 2024 10:55:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 04/22] target/s390x: Record separate PER bits in TB flags
Date: Wed, 29 May 2024 12:54:36 +0200
Message-ID: <20240529105454.1149225-5-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Record successful-branching, instruction-fetching, and
store-using-real-address.  The other PER bits are not used
during translation.  Having checked these at translation time,
we can remove runtime tests from the helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240502054417.234340-5-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu.h             | 44 ++++++++++++++++++++++++----------
 target/s390x/cpu.c             | 22 +++++++++++++----
 target/s390x/tcg/misc_helper.c | 21 +++++++---------
 target/s390x/tcg/translate.c   | 10 ++++----
 4 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1bb723a9d3..d6b75ad0e0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -342,19 +342,32 @@ extern const VMStateDescription vmstate_s390_cpu;
 
 /* tb flags */
 
-#define FLAG_MASK_PSW_SHIFT     31
-#define FLAG_MASK_PER           (PSW_MASK_PER    >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_DAT           (PSW_MASK_DAT    >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_ASC           (PSW_MASK_ASC    >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_64            (PSW_MASK_64     >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_32            (PSW_MASK_32     >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_PSW           (FLAG_MASK_PER | FLAG_MASK_DAT | FLAG_MASK_PSTATE \
-                                | FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
-
-/* we'll use some unused PSW positions to store CR flags in tb flags */
-#define FLAG_MASK_AFP           (PSW_MASK_UNUSED_2 >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_VECTOR        (PSW_MASK_UNUSED_3 >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_PSW_SHIFT             31
+#define FLAG_MASK_32                    0x00000001u
+#define FLAG_MASK_64                    0x00000002u
+#define FLAG_MASK_AFP                   0x00000004u
+#define FLAG_MASK_VECTOR                0x00000008u
+#define FLAG_MASK_ASC                   0x00018000u
+#define FLAG_MASK_PSTATE                0x00020000u
+#define FLAG_MASK_PER_IFETCH_NULLIFY    0x01000000u
+#define FLAG_MASK_DAT                   0x08000000u
+#define FLAG_MASK_PER_STORE_REAL        0x20000000u
+#define FLAG_MASK_PER_IFETCH            0x40000000u
+#define FLAG_MASK_PER_BRANCH            0x80000000u
+
+QEMU_BUILD_BUG_ON(FLAG_MASK_32 != PSW_MASK_32 >> FLAG_MASK_PSW_SHIFT);
+QEMU_BUILD_BUG_ON(FLAG_MASK_64 != PSW_MASK_64 >> FLAG_MASK_PSW_SHIFT);
+QEMU_BUILD_BUG_ON(FLAG_MASK_ASC != PSW_MASK_ASC >> FLAG_MASK_PSW_SHIFT);
+QEMU_BUILD_BUG_ON(FLAG_MASK_PSTATE != PSW_MASK_PSTATE >> FLAG_MASK_PSW_SHIFT);
+QEMU_BUILD_BUG_ON(FLAG_MASK_DAT != PSW_MASK_DAT >> FLAG_MASK_PSW_SHIFT);
+
+#define FLAG_MASK_PSW           (FLAG_MASK_DAT | FLAG_MASK_PSTATE | \
+                                 FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
+#define FLAG_MASK_CR9           (FLAG_MASK_PER_BRANCH | FLAG_MASK_PER_IFETCH)
+#define FLAG_MASK_PER           (FLAG_MASK_PER_BRANCH | \
+                                 FLAG_MASK_PER_IFETCH | \
+                                 FLAG_MASK_PER_IFETCH_NULLIFY | \
+                                 FLAG_MASK_PER_STORE_REAL)
 
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
@@ -431,6 +444,11 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 #define PER_CR9_CONTROL_TRANSACTION_SUPRESS     0x00400000
 #define PER_CR9_CONTROL_STORAGE_ALTERATION      0x00200000
 
+QEMU_BUILD_BUG_ON(FLAG_MASK_PER_BRANCH != PER_CR9_EVENT_BRANCH);
+QEMU_BUILD_BUG_ON(FLAG_MASK_PER_IFETCH != PER_CR9_EVENT_IFETCH);
+QEMU_BUILD_BUG_ON(FLAG_MASK_PER_IFETCH_NULLIFY !=
+                  PER_CR9_EVENT_IFETCH_NULLIFICATION);
+
 /* PER bits from the PER CODE/ATMID/AI in lowcore */
 #define PER_CODE_EVENT_BRANCH          0x8000
 #define PER_CODE_EVENT_IFETCH          0x4000
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a8428b5a1e..2bbeaca36e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -325,8 +325,10 @@ static void s390_cpu_reset_full(DeviceState *dev)
 #include "hw/core/tcg-cpu-ops.h"
 
 void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+                          uint64_t *cs_base, uint32_t *pflags)
 {
+    uint32_t flags;
+
     if (env->psw.addr & 1) {
         /*
          * Instructions must be at even addresses.
@@ -335,15 +337,27 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
         env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
     }
+
     *pc = env->psw.addr;
     *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+
+    flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->psw.mask & PSW_MASK_PER) {
+        flags |= env->cregs[9] & (FLAG_MASK_PER_BRANCH |
+                                  FLAG_MASK_PER_IFETCH |
+                                  FLAG_MASK_PER_IFETCH_NULLIFY);
+        if ((env->cregs[9] & PER_CR9_EVENT_STORE) &&
+            (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
+            flags |= FLAG_MASK_PER_STORE_REAL;
+        }
+    }
     if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
+        flags |= FLAG_MASK_AFP;
     }
     if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
+        flags |= FLAG_MASK_VECTOR;
     }
+    *pflags = flags;
 }
 
 static const TCGCPUOps s390_tcg_ops = {
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 0482442458..3f94f71437 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -627,18 +627,16 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
 
 void HELPER(per_branch)(CPUS390XState *env, uint64_t from, uint64_t to)
 {
-    if ((env->cregs[9] & PER_CR9_EVENT_BRANCH)) {
-        if (!(env->cregs[9] & PER_CR9_CONTROL_BRANCH_ADDRESS)
-            || get_per_in_range(env, to)) {
-            env->per_address = from;
-            env->per_perc_atmid = PER_CODE_EVENT_BRANCH | get_per_atmid(env);
-        }
+    if (!(env->cregs[9] & PER_CR9_CONTROL_BRANCH_ADDRESS)
+        || get_per_in_range(env, to)) {
+        env->per_address = from;
+        env->per_perc_atmid = PER_CODE_EVENT_BRANCH | get_per_atmid(env);
     }
 }
 
 void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
 {
-    if ((env->cregs[9] & PER_CR9_EVENT_IFETCH) && get_per_in_range(env, addr)) {
+    if (get_per_in_range(env, addr)) {
         env->per_address = addr;
         env->per_perc_atmid = PER_CODE_EVENT_IFETCH | get_per_atmid(env);
 
@@ -659,12 +657,9 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
 
 void HELPER(per_store_real)(CPUS390XState *env)
 {
-    if ((env->cregs[9] & PER_CR9_EVENT_STORE) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
-        /* PSW is saved just before calling the helper.  */
-        env->per_address = env->psw.addr;
-        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
-    }
+    /* PSW is saved just before calling the helper.  */
+    env->per_address = env->psw.addr;
+    env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
 }
 #endif
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4c3ff1931b..de98115c4d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -346,7 +346,7 @@ static void per_branch(DisasContext *s, bool to_next)
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_i64(gbea, s->base.pc_next);
 
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
         TCGv_i64 next_pc = to_next ? tcg_constant_i64(s->pc_tmp) : psw_addr;
         gen_helper_per_branch(tcg_env, gbea, next_pc);
     }
@@ -357,7 +357,7 @@ static void per_branch_cond(DisasContext *s, TCGCond cond,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
         TCGLabel *lab = gen_new_label();
         tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
 
@@ -656,7 +656,7 @@ static void gen_op_calc_cc(DisasContext *s)
 
 static bool use_goto_tb(DisasContext *s, uint64_t dest)
 {
-    if (unlikely(s->base.tb->flags & FLAG_MASK_PER)) {
+    if (unlikely(s->base.tb->flags & FLAG_MASK_PER_BRANCH)) {
         return false;
     }
     return translator_use_goto_tb(&s->base, dest);
@@ -4409,7 +4409,7 @@ static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
 
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
         update_psw_addr(s);
         gen_helper_per_store_real(tcg_env);
     }
@@ -6323,7 +6323,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
         TCGv_i64 addr = tcg_constant_i64(s->base.pc_next);
         gen_helper_per_ifetch(tcg_env, addr);
     }
-- 
2.45.1


