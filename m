Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D40ECD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNG-00035y-TU; Wed, 10 Apr 2024 03:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMV-0001m7-12; Wed, 10 Apr 2024 03:27:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMT-0004ns-90; Wed, 10 Apr 2024 03:27:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C80715D69E;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6BC79B02DE;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191786 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 46/87] target/hppa: fix access_id check
Date: Wed, 10 Apr 2024 10:22:19 +0300
Message-Id: <20240410072303.4191455-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

PA2.0 provides 8 instead of 4 PID registers.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240319161921.487080-4-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit ae157fc25053917830c3b581bc282f906e6d95d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 4fcc612754..3a34c4f748 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -152,6 +152,49 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
     return ent;
 }
 
+#define ACCESS_ID_MASK 0xffff
+
+/* Return the set of protections allowed by a PID match. */
+static int match_prot_id_1(uint32_t access_id, uint32_t prot_id)
+{
+    if (((access_id ^ (prot_id >> 1)) & ACCESS_ID_MASK) == 0) {
+        return (prot_id & 1
+                ? PAGE_EXEC | PAGE_READ
+                : PAGE_EXEC | PAGE_READ | PAGE_WRITE);
+    }
+    return 0;
+}
+
+static int match_prot_id32(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
+static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+        r = match_prot_id_1(access_id, env->cr[i] >> 32);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
                               HPPATLBEntry **tlb_entry)
@@ -224,29 +267,30 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         break;
     }
 
+    /*
+     * No guest access type indicates a non-architectural access from
+     * within QEMU.  Bypass checks for access, D, B, P and T bits.
+     */
+    if (type == 0) {
+        goto egress;
+    }
+
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
-        /* If bits [31:1] match, and bit 0 is set, suppress write.  */
-        int match = ent->access_id * 2 + 1;
-
-        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
-            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
-            prot &= PAGE_READ | PAGE_EXEC;
-            if (type == PAGE_WRITE) {
-                ret = EXCP_DMPI;
-                goto egress;
-            }
+        int access_prot = (hppa_is_pa20(env)
+                           ? match_prot_id64(env, ent->access_id)
+                           : match_prot_id32(env, ent->access_id));
+        if (unlikely(!(type & access_prot))) {
+            /* Not allowed -- Inst/Data Memory Protection Id Fault. */
+            ret = type & PAGE_EXEC ? EXCP_IMP : EXCP_DMPI;
+            goto egress;
         }
-    }
-
-    /* No guest access type indicates a non-architectural access from
-       within QEMU.  Bypass checks for access, D, B and T bits.  */
-    if (type == 0) {
-        goto egress;
+        /* Otherwise exclude permissions not allowed (i.e WD). */
+        prot &= access_prot;
     }
 
     if (unlikely(!(prot & type))) {
-        /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
         ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
-- 
2.39.2


