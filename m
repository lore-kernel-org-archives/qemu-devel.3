Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D4CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0xu-0007Bz-CN; Thu, 08 Oct 2026 23:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vy-0004hu-2t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:11 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vw-0005m1-Br
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:09 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 325E6DFE8;
 Fri, 09 Oct 2026 08:35:56 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 19/23] target/loongarch: add LVZ CSRs
Date: Fri,  9 Oct 2026 11:05:15 +0800
Message-ID: <abde9ec73f3e76479d42733da54716f5c2312fc5.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Add gstat, gtlbc and gintc definitions and corresponding helpers.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/csr_helper.c             | 53 +++++++++++++++++++
 target/loongarch/tcg/helper.h                 |  3 ++
 .../tcg/insn_trans/trans_privileged.c.inc     |  3 ++
 3 files changed, 59 insertions(+)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7ef0032f5d..f113097046 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -217,3 +217,56 @@ target_ulong helper_csrwr_pwch(CPULoongArchState *env,
     sys->CSR_PWCH = val;
     return old_v;
 }
+
+target_ulong helper_csrwr_gstat(CPULoongArchState *env,
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
+target_ulong helper_csrwr_gtlbc(CPULoongArchState *env,
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
+target_ulong helper_csrwr_gintc(CPULoongArchState *env,
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
index bce5f46dc2..84eaee208c 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -104,6 +104,9 @@ DEF_HELPER_3(csrwr_tcfg, i64, env, tl, i32)
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
index 139dbd6e2a..37b7ef13dc 100644
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
2.55.0


