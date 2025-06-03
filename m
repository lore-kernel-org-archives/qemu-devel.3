Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59938C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMI3e-0004Ri-Fj; Mon, 02 Jun 2025 23:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uMI3c-0004Ni-Et; Mon, 02 Jun 2025 23:11:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uMI3a-0007iR-75; Mon, 02 Jun 2025 23:11:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNHDQZz5odZYJAQ--.31647S3;
 Tue, 03 Jun 2025 11:11:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxj8XPZz5o0g4GAQ--.23246S2;
 Tue, 03 Jun 2025 11:11:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
Subject: [PATCH v2] target/loongarch: fix vldi/xvldi raise wrong error
Date: Tue,  3 Jun 2025 10:48:47 +0800
Message-Id: <20250603024847.350568-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8XPZz5o0g4GAQ--.23246S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

on qemu we got an aborted error
**
ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
Aborted (core dumped)
bu on 3A600/3A5000 we got a "Illegal instruction" error.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index dff92772ad..cadc00e75e 100644
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
@@ -3570,8 +3570,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
         }
         break;
     default:
-        generate_exception(ctx, EXCCODE_INE);
-        g_assert_not_reached();
+        data = -1;
     }
     return data;
 }
@@ -3579,7 +3578,12 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
 static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
 {
     int sel, vece;
-    uint64_t value;
+    uint64_t value = vldi_get_value(ctx, a->imm);
+
+    if (value == -1){
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
 
     if (!check_vec(ctx, oprsz)) {
         return true;
@@ -3588,7 +3592,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     sel = (a->imm >> 12) & 0x1;
 
     if (sel) {
-        value = vldi_get_value(ctx, a->imm);
         vece = MO_64;
     } else {
         value = ((int32_t)(a->imm << 22)) >> 22;
-- 
2.34.1


