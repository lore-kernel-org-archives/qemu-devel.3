Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DCAC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJABW-0007j8-Vu; Sun, 25 May 2025 08:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJAA1-0004h6-6G; Sun, 25 May 2025 08:09:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9v-0003Ks-9M; Sun, 25 May 2025 08:08:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F77B124E54;
 Sun, 25 May 2025 15:08:17 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C0BD215FBB;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 34/59] target/riscv: rvv: Add CHECK arg to
 GEN_OPFVF_WIDEN_TRANS
Date: Sun, 25 May 2025 15:07:51 +0300
Message-Id: <20250525120818.273372-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Anton Blanchard <antonb@tenstorrent.com>

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit b0450a101d6c88789d0e8df2bcbef61bc7cd159a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 20b1cb127b..e630f8661e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2403,10 +2403,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 }
 
 /* OPFVF with WIDEN */
-#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 {                                                                \
-    if (opfvf_widen_check(s, a)) {                               \
+    if (CHECK(s, a)) {                                           \
         uint32_t data = 0;                                       \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
@@ -2422,8 +2422,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
     return false;                                                \
 }
 
-GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
 
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
@@ -2505,7 +2505,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
 
 /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
 GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
@@ -2530,10 +2530,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.39.5


