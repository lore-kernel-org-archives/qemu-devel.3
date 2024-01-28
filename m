Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF587C47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9H2-0006PI-DV; Sun, 28 Jan 2024 12:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9GY-00060A-4m; Sun, 28 Jan 2024 12:48:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9GW-0000K1-4L; Sun, 28 Jan 2024 12:48:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D0B39480E4;
 Sun, 28 Jan 2024 20:48:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5231C6D50D;
 Sun, 28 Jan 2024 20:47:57 +0300 (MSK)
Received: (nullmailer pid 811329 invoked by uid 1000);
 Sun, 28 Jan 2024 17:47:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 30/30] target/xtensa: fix OOB TLB entry access
Date: Sun, 28 Jan 2024 20:47:43 +0300
Message-Id: <20240128174747.811264-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240128204652@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240128204652@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Max Filippov <jcmvbkbc@gmail.com>

r[id]tlb[01], [iw][id]tlb opcodes use TLB way index passed in a register
by the guest. The host uses 3 bits of the index for ITLB indexing and 4
bits for DTLB, but there's only 7 entries in the ITLB array and 10 in
the DTLB array, so a malicious guest may trigger out-of-bound access to
these arrays.

Change split_tlb_entry_spec return type to bool to indicate whether TLB
way passed to it is valid. Change get_tlb_entry to return NULL in case
invalid TLB way is requested. Add assertion to xtensa_tlb_get_entry that
requested TLB way and entry indices are valid. Add checks to the
[rwi]tlb helpers that requested TLB way is valid and return 0 or do
nothing when it's not.

Cc: qemu-stable@nongnu.org
Fixes: b67ea0cd7441 ("target-xtensa: implement memory protection options")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20231215120307.545381-1-jcmvbkbc@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 604927e357c2b292c70826e4ce42574ad126ef32)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index fa66e8e867..c4b4df4d74 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -226,22 +226,31 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
  * Split TLB address into TLB way, entry index and VPN (with index).
  * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
  */
-static void split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t *wi, uint32_t *ei)
+static bool split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
+                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         *wi = v & (dtlb ? 0xf : 0x7);
-        split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+        if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
+            split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+            return true;
+        } else {
+            return false;
+        }
     } else {
         *vpn = v & REGION_PAGE_MASK;
         *wi = 0;
         *ei = (v >> 29) & 0x7;
+        return true;
     }
 }
 
 static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
                                               unsigned wi, unsigned ei)
 {
+    const xtensa_tlb *tlb = dtlb ? &env->config->dtlb : &env->config->itlb;
+
+    assert(wi < tlb->nways && ei < tlb->way_size[wi]);
     return dtlb ?
         env->dtlb[wi] + ei :
         env->itlb[wi] + ei;
@@ -254,11 +263,14 @@ static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
     uint32_t wi;
     uint32_t ei;
 
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    if (pwi) {
-        *pwi = wi;
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        if (pwi) {
+            *pwi = wi;
+        }
+        return xtensa_tlb_get_entry(env, dtlb, wi, ei);
+    } else {
+        return NULL;
     }
-    return xtensa_tlb_get_entry(env, dtlb, wi, ei);
 }
 
 static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
@@ -484,7 +496,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+
+        if (entry) {
+            return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+        } else {
+            return 0;
+        }
     } else {
         return v & REGION_PAGE_MASK;
     }
@@ -493,7 +510,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
-    return entry->paddr | entry->attr;
+
+    if (entry) {
+        return entry->paddr | entry->attr;
+    } else {
+        return 0;
+    }
 }
 
 void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
@@ -501,7 +523,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        if (entry->variable && entry->asid) {
+        if (entry && entry->variable && entry->asid) {
             tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
@@ -539,8 +561,9 @@ void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
     uint32_t vpn;
     uint32_t wi;
     uint32_t ei;
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    }
 }
 
 /*!
-- 
2.39.2


