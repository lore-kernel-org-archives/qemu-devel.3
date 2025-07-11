Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995ACC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua98M-0008KH-HL; Fri, 11 Jul 2025 04:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8zb-0000J7-HD; Fri, 11 Jul 2025 04:20:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8zZ-0004Va-1m; Fri, 11 Jul 2025 04:20:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 108A51356E7;
 Fri, 11 Jul 2025 11:17:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 06ABC23FA5C;
 Fri, 11 Jul 2025 11:17:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 28/39] target/loongarch: fix vldi/xvldi raise wrong
 error
Date: Fri, 11 Jul 2025 11:16:24 +0300
Message-ID: <20250711081745.1785806-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
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

From: Song Gao <gaosong@loongson.cn>

on qemu we got an aborted error
**
ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
Aborted (core dumped)
but on 3A600/3A5000 we got a "Illegal instruction" error.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971

Fixes: 29bb5d727ff ("target/loongarch: Implement vldi")
 Cc: qemu-stable@nongnu.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit c2a2e1ad2a749caa864281b1d4dc3f16c3f344f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index d6f0560349..78730029cb 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
 static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
 {
     int mode;
-    uint64_t data, t;
+    uint64_t data = 0, t;
 
     /*
      * imm bit [11:8] is mode, mode value is 0-12.
@@ -3570,17 +3570,26 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
         }
         break;
     default:
-        generate_exception(ctx, EXCCODE_INE);
         g_assert_not_reached();
     }
     return data;
 }
 
+static bool check_valid_vldi_mode(arg_vldi *a)
+{
+   return  extract32(a->imm, 8, 4) <= 12;
+}
+
 static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
 {
     int sel, vece;
     uint64_t value;
 
+    if (!check_valid_vldi_mode(a)) {
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
+
     if (!check_vec(ctx, oprsz)) {
         return true;
     }
-- 
2.47.2


