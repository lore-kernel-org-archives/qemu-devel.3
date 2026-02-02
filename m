Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB3DE7FDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzuo-0003So-Ph; Mon, 02 Feb 2026 14:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzum-0003JV-Mt; Mon, 02 Feb 2026 14:48:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzul-0003Nj-0Q; Mon, 02 Feb 2026 14:48:52 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 696721850AB;
 Mon, 02 Feb 2026 22:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1C25635B28D;
 Mon, 02 Feb 2026 22:46:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhijin Zeng <zengzhijin@linux.spacemit.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 25/69] tcg/riscv: Fix TCG_REG_TMP0 clobber in
 tcg_gen_dup{m, i}
Date: Mon,  2 Feb 2026 22:45:48 +0300
Message-ID: <20260202194638.939438-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

TCG_REG_TMP0 may be used by set_vtype* to load the vtype
parameter, so delay any other use of TCG_REG_TMP0 until
the correct vtype has been installed.

Cc: qemu-stable@nongnu.org
Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
Reported-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit af6db3b71310ea63a018d517ba7d79e4e014db62)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f7e1ca5a56..ec13d8fee9 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1151,7 +1151,7 @@ static void tcg_out_addsub2(TCGContext *s,
 }
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-                                   TCGReg dst, TCGReg src)
+                            TCGReg dst, TCGReg src)
 {
     set_vtype_len_sew(s, type, vece);
     tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);
@@ -1159,29 +1159,34 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, TCGReg base, intptr_t offset)
+                             TCGReg dst, TCGReg base, intptr_t offset)
 {
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    set_vtype_len_sew(s, type, vece);
     tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
-    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
+    return true;
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, int64_t arg)
+                             TCGReg dst, int64_t arg)
 {
     /* Arg is replicated by VECE; extract the highest element. */
     arg >>= (-8 << vece) & 63;
 
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    if (arg == 0 || arg == -1) {
+        set_vtype_len(s, type);
+    } else {
+        set_vtype_len_sew(s, type, vece);
+    }
+
     if (arg >= -16 && arg < 16) {
-        if (arg == 0 || arg == -1) {
-            set_vtype_len(s, type);
-        } else {
-            set_vtype_len_sew(s, type, vece);
-        }
         tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
-        return;
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+        tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
     }
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
-    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static const struct {
-- 
2.47.3


