Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8A60A3806
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx4-0004SX-Rx; Fri, 13 Nov 2026 03:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvw-0003BM-UD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:47:05 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvu-0007WC-OM
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:56 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id DC4A97804;
 Fri, 13 Nov 2026 14:16:42 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 23/26] target/loongarch: add LVZ CSRs
Date: Fri, 13 Nov 2026 16:45:38 +0800
Message-ID: <36191830c74f33c78e3b92c1d79330ce919ed1bb.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add gstat, gtlbc and gintc definitions and corresponding helpers.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/csr_helper.c             | 53 +++++++++++++++++++
 target/loongarch/tcg/helper.h                 |  3 ++
 .../tcg/insn_trans/trans_privileged.c.inc     |  3 ++
 3 files changed, 59 insertions(+)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index f5b6a3d1f9..c48b328540 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -217,3 +217,56 @@ target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env,
     sys->CSR_PWCH = val;
     return old_v;
 }
+
+target_ulong HELPER(csrwr_gstat)(CPULoongArchState *env,
+                                target_ulong val, uint32_t vm_level)
+{
+    CPUSysState *sys = get_sys(env, VM_LEVEL0);
+    int64_t old_v = sys->CSR_GSTAT;
+    uint8_t old_gid = FIELD_EX64(sys->CSR_GSTAT, CSR_GSTAT, GID);
+
+    sys->CSR_GSTAT = FIELD_DP64(sys->CSR_GSTAT, CSR_GSTAT, PVM,
+                                 FIELD_EX64(val, CSR_GSTAT, PVM));
+    sys->CSR_GSTAT = FIELD_DP64(sys->CSR_GSTAT, CSR_GSTAT, GID,
+                                 FIELD_EX64(val, CSR_GSTAT, GID));
+
+    if (old_gid != FIELD_EX64(sys->CSR_GSTAT, CSR_GSTAT, GID)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    return old_v;
+}
+
+target_ulong HELPER(csrwr_gtlbc)(CPULoongArchState *env,
+                                target_ulong val, uint32_t vm_level)
+{
+    CPUSysState *sys = get_sys(env, VM_LEVEL0);
+    int64_t old_v = sys->CSR_GTLBC;
+    uint8_t old_use_tgid = FIELD_EX64(old_v, CSR_GTLBC, USETGID);
+    uint8_t old_tgid = FIELD_EX64(old_v, CSR_GTLBC, TGID);
+
+    sys->CSR_GTLBC = val;
+    if (old_use_tgid != FIELD_EX64(sys->CSR_GTLBC, CSR_GTLBC, USETGID) ||
+        old_tgid != FIELD_EX64(sys->CSR_GTLBC, CSR_GTLBC, TGID)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    return old_v;
+}
+
+target_ulong HELPER(csrwr_gintc)(CPULoongArchState *env,
+                                target_ulong val, uint32_t vm_level)
+{
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+    CPUSysState *guest = get_sys(env, VM_LEVEL1);
+    int64_t old_v = host->CSR_GINTC;
+    uint8_t hwis = FIELD_EX64(val, CSR_GINTC, HWIS);
+    /* TODO: hwip and hwic support */
+
+    host->CSR_GINTC = val & 0xffff00;
+    guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 2, 8,
+                                 hwis);
+
+    return old_v;
+}
+
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 1c15e7544a..63d37a00b0 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -106,6 +106,9 @@ DEF_HELPER_3(csrwr_tcfg, i64, env, tl, i32)
 DEF_HELPER_3(csrwr_ticlr, i64, env, tl, i32)
 DEF_HELPER_3(csrwr_pwcl, i64, env, tl, i32)
 DEF_HELPER_3(csrwr_pwch, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_gstat, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_gtlbc, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_gintc, i64, env, tl, i32)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index cfcd234340..384580c988 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -88,6 +88,9 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
+    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
+    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
+    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
 }
 #undef SET_CSR_FUNC
 
-- 
2.56.0


