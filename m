Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0BCD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPr0-0006T0-33; Fri, 05 Jun 2026 04:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqy-0006S3-6g
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqt-0004hX-Eh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:31 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxnOm5hyJqsOMQAA--.44252S3;
 Fri, 05 Jun 2026 16:24:25 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S8;
 Fri, 05 Jun 2026 16:24:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 06/14] target/loongarch: Use sys_state in tlb_helper.c when
 accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:44 +0800
Message-ID: <20260605082552.175336-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S8
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ury7AFy3tFW8trykZryxWFX_yoW8GrykGo
 WxXa1rK3W5Ww4FvF1qvwn0q3W2qryDAanFkr1qyr45uay5KryqkryrGa40kw47CF1DWF4k
 JF12ga48Jr47ZF13l-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
 0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07jfl1kUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When accessing CSR registers in file tlb_helper.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 target/loongarch/tcg/tlb_helper.c | 137 +++++++++++++++++-------------
 1 file changed, 77 insertions(+), 60 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 892e0eb473..7623f4f9bd 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -36,16 +36,19 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
 
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
+    CPUSysState *sys = env_sys(env);
+
     if (tlb_ps >= 64) {
         return false;
     }
-    return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
+    return BIT_ULL(tlb_ps) & (sys->CSR_PRCFG2);
 }
 
 static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_error)
 {
     CPUState *cs = env_cpu(env);
+    CPUSysState *sys = env_sys(env);
 
     switch (tlb_error) {
     default:
@@ -62,7 +65,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
         } else if (access_type == MMU_INST_FETCH) {
             cs->exception_index = EXCCODE_PIF;
         }
-        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
+        sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         break;
     case TLBRET_INVALID:
         /* TLB match with no valid bit */
@@ -93,19 +96,19 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
     }
 
     if (tlb_error == TLBRET_NOMATCH) {
-        env->CSR_TLBRBADV = address;
+        sys->CSR_TLBRBADV = address;
         if (is_la64(env)) {
-            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
+            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
                                         VPPN, extract64(address, 13, 35));
         } else {
-            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
+            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_32,
                                         VPPN, extract64(address, 13, 19));
         }
     } else {
-        if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
-            env->CSR_BADV = address;
+        if (!FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
+            sys->CSR_BADV = address;
         }
-        env->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
+        sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
    }
 }
 
@@ -142,8 +145,9 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, tlb_g;
     uint8_t tlb_e;
+    CPUSysState *sys = env_sys(env);
 
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb = &env->tlb[index];
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
     if (!tlb_e) {
@@ -165,25 +169,26 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
+    CPUSysState *sys = env_sys(env);
 
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        csr_ps = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
         if (is_la64(env)) {
-            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
+            csr_vppn = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
         } else {
-            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
+            csr_vppn = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBRELO0;
-        lo1 = env->CSR_TLBRELO1;
+        lo0 = sys->CSR_TLBRELO0;
+        lo1 = sys->CSR_TLBRELO1;
     } else {
-        csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        csr_ps = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, PS);
         if (is_la64(env)) {
-            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
+            csr_vppn = FIELD_EX64(sys->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
         } else {
-            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
+            csr_vppn = FIELD_EX64(sys->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBELO0;
-        lo1 = env->CSR_TLBELO1;
+        lo0 = sys->CSR_TLBELO0;
+        lo1 = sys->CSR_TLBELO1;
     }
 
     context->ps = csr_ps;
@@ -198,6 +203,7 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
+    CPUSysState *sys = env_sys(env);
 
     csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
     csr_ps   = context->ps;
@@ -208,7 +214,7 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
 
     tlb->tlb_entry0 = lo0;
@@ -241,8 +247,9 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
     bool tlb_g;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
+    CPUSysState *sys = env_sys(env);
 
-    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
     stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
     compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
@@ -289,9 +296,10 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     int csr_asid;
     tlb_match func;
     LoongArchTLB *tlb;
+    CPUSysState *sys = env_sys(env);
 
     func = tlb_match_any;
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
     if (tlb) {
         *index = tlb - env->tlb;
@@ -304,20 +312,21 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 void helper_tlbsrch(CPULoongArchState *env)
 {
     int index, match;
+    CPUSysState *sys = env_sys(env);
 
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        match = loongarch_tlb_search(env, env->CSR_TLBREHI, &index);
+    if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        match = loongarch_tlb_search(env, sys->CSR_TLBREHI, &index);
     } else {
-        match = loongarch_tlb_search(env, env->CSR_TLBEHI, &index);
+        match = loongarch_tlb_search(env, sys->CSR_TLBEHI, &index);
     }
 
     if (match) {
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX, index);
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX, index);
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
         return;
     }
 
-    env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
+    sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
 }
 
 void helper_tlbrd(CPULoongArchState *env)
@@ -325,29 +334,30 @@ void helper_tlbrd(CPULoongArchState *env)
     LoongArchTLB *tlb;
     int index;
     uint8_t tlb_ps, tlb_e;
+    CPUSysState *sys = env_sys(env);
 
-    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     tlb = &env->tlb[index];
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
     if (!tlb_e) {
         /* Invalid TLB entry */
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
-        env->CSR_ASID  = FIELD_DP64(env->CSR_ASID, CSR_ASID, ASID, 0);
-        env->CSR_TLBEHI = 0;
-        env->CSR_TLBELO0 = 0;
-        env->CSR_TLBELO1 = 0;
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS, 0);
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
+        sys->CSR_ASID  = FIELD_DP64(sys->CSR_ASID, CSR_ASID, ASID, 0);
+        sys->CSR_TLBEHI = 0;
+        sys->CSR_TLBELO0 = 0;
+        sys->CSR_TLBELO1 = 0;
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, PS, 0);
     } else {
         /* Valid TLB entry */
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
-        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX,
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
+        sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX,
                                      PS, (tlb_ps & 0x3f));
-        env->CSR_TLBEHI = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
+        sys->CSR_TLBEHI = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
                                      R_TLB_MISC_VPPN_SHIFT;
-        env->CSR_TLBELO0 = tlb->tlb_entry0;
-        env->CSR_TLBELO1 = tlb->tlb_entry1;
+        sys->CSR_TLBELO0 = tlb->tlb_entry0;
+        sys->CSR_TLBELO1 = tlb->tlb_entry1;
     }
 }
 
@@ -380,10 +390,11 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
 
 void helper_tlbwr(CPULoongArchState *env)
 {
-    int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    CPUSysState *sys = env_sys(env);
+    int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
 
-    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
+    if (FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, NE)) {
         invalidate_tlb(env, index);
         return;
     }
@@ -400,10 +411,11 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
     uint16_t asid, tlb_asid, stlb_ps;
     LoongArchTLB *tlb;
     uint8_t tlb_e, tlb_g;
+    CPUSysState *sys = env_sys(env);
 
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
-    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
+    asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
         address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
@@ -461,15 +473,16 @@ void helper_tlbfill(CPULoongArchState *env)
     vaddr entryhi;
     int index, pagesize;
     MMUContext context;
+    CPUSysState *sys = env_sys(env);
 
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi = env->CSR_TLBREHI;
+    if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = sys->CSR_TLBREHI;
         /* Validity of pagesize is checked in helper_ldpte() */
-        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        pagesize = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
     } else {
-        entryhi = env->CSR_TLBEHI;
+        entryhi = sys->CSR_TLBEHI;
         /* Validity of pagesize is checked in helper_tlbrd() */
-        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        pagesize = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
     sptw_prepare_context(env, &context);
@@ -483,9 +496,10 @@ void helper_tlbclr(CPULoongArchState *env)
     LoongArchTLB *tlb;
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
+    CPUSysState *sys = env_sys(env);
 
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
+    index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
     if (index < LOONGARCH_STLB) {
         /* STLB. One line per operation */
@@ -515,8 +529,9 @@ void helper_tlbclr(CPULoongArchState *env)
 void helper_tlbflush(CPULoongArchState *env)
 {
     int i, index;
+    CPUSysState *sys = env_sys(env);
 
-    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
     if (index < LOONGARCH_STLB) {
         /* STLB. One line per operation */
@@ -711,6 +726,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint64_t val;
+    CPUSysState *sys = env_sys(env);
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -732,7 +748,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
         }
     }
 
-    badvaddr = env->CSR_TLBRBADV;
+    badvaddr = sys->CSR_TLBRBADV;
     base = base & palen_mask;
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
@@ -747,10 +763,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    CPUSysState *sys = env_sys(env);
     uint64_t pte_raw;
     uint64_t badv;
-    uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
-    uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t ptbase = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTBASE);
+    uint64_t ptwidth = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint8_t  ps;
@@ -796,7 +813,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             return;
         }
     } else {
-        badv = env->CSR_TLBRBADV;
+        badv = sys->CSR_TLBRBADV;
 
         base = base & palen_mask;
 
@@ -812,11 +829,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     }
 
     if (odd) {
-        env->CSR_TLBRELO1 = tmp0;
+        sys->CSR_TLBRELO1 = tmp0;
     } else {
-        env->CSR_TLBRELO0 = tmp0;
+        sys->CSR_TLBRELO0 = tmp0;
     }
-    env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
+    sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
 
 static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
-- 
2.54.0


