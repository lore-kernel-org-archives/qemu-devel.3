Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D748C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7sm-0006wz-Ky; Sun, 25 May 2025 05:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7sk-0006w3-TB; Sun, 25 May 2025 05:43:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7sj-0004Xz-4v; Sun, 25 May 2025 05:43:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 076BF124DDC;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DF5F1215F04;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 42/62] target/riscv: rvv: Apply vext_check_input_eew to
 vrgather instructions to check mismatched input EEWs encoding constraint
Date: Sun, 25 May 2025 12:42:25 +0300
Message-Id: <20250525094246.174612-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
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

From: Max Chou <max.chou@sifive.com>

According to the v spec, a vector register cannot be used to provide source
operands with more than one EEW for a single instruction.
The vs1 EEW of vrgatherei16.vv is 16.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 629c2a8dd7506e1cb9b6b7127604641632ac453f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e630f8661e..4a0c9fbeff 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -379,6 +379,35 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
     return ret;
 }
 
+/*
+ * Check whether a vector register is used to provide source operands with
+ * more than one EEW for the vector instruction.
+ * Returns true if the instruction has valid encoding
+ * Returns false if encoding violates the mismatched input EEWs constraint
+ */
+static bool vext_check_input_eew(DisasContext *s, int vs1, uint8_t eew_vs1,
+                                 int vs2, uint8_t eew_vs2, int vm)
+{
+    bool is_valid = true;
+    int8_t emul_vs1 = eew_vs1 - s->sew + s->lmul;
+    int8_t emul_vs2 = eew_vs2 - s->sew + s->lmul;
+
+    /* When vm is 0, vs1 & vs2(EEW!=1) group can't overlap v0 (EEW=1) */
+    if ((vs1 != -1 && !require_vm(vm, vs1)) ||
+        (vs2 != -1 && !require_vm(vm, vs2))) {
+        is_valid = false;
+    }
+
+    /* When eew_vs1 != eew_vs2, check whether vs1 and vs2 are overlapped */
+    if ((vs1 != -1 && vs2 != -1) && (eew_vs1 != eew_vs2) &&
+        is_overlapped(vs1, 1 << MAX(emul_vs1, 0),
+                      vs2, 1 << MAX(emul_vs2, 0))) {
+        is_valid = false;
+    }
+
+    return is_valid;
+}
+
 static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 {
     return require_vm(vm, vd) &&
@@ -3449,6 +3478,7 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
@@ -3461,6 +3491,7 @@ static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
     int8_t emul = MO_16 - s->sew + s->lmul;
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, MO_16, a->rs2, s->sew, a->vm) &&
            (emul >= -3 && emul <= 3) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, emul) &&
@@ -3480,6 +3511,7 @@ static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, -1, MO_64, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2) &&
-- 
2.39.5


