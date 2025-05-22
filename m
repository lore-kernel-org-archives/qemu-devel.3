Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC8DC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 04:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHxMR-0007Dg-CR; Thu, 22 May 2025 00:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenz.hetterich@cispa.de>)
 id 1uHvNG-0008Ue-HW
 for qemu-devel@nongnu.org; Wed, 21 May 2025 22:09:34 -0400
Received: from xmailer.gwdg.de ([134.76.10.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenz.hetterich@cispa.de>)
 id 1uHvNE-0006UV-Eh
 for qemu-devel@nongnu.org; Wed, 21 May 2025 22:09:34 -0400
Received: from mbx19-sub-04.um.gwdg.de ([10.108.142.69] helo=email.gwdg.de)
 by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (GWDG Mailer) (envelope-from <lorenz.hetterich@cispa.de>)
 id 1uHvMy-000QY4-1U; Thu, 22 May 2025 04:09:16 +0200
Received: from lorenz-IdeaPad-5-15ALC05.fritz.box (10.250.9.199) by
 MBX19-SUB-04.um.gwdg.de (10.108.142.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 22 May 2025 04:09:16 +0200
From: Lorenz Hetterich <lorenz.hetterich@cispa.de>
To: <qemu-devel@nongnu.org>
CC: Song Gao <gaosong@loongson.cn>, Lorenz Hetterich
 <lorenz.hetterich@cispa.de>
Subject: [PATCH] check loongarch64 vldi immediates Resolves:
 https://gitlab.com/qemu-project/qemu/-/issues/2971 Signed-off-by: Lorenz
 Hetterich <lorenz.hetterich@cispa.de>
Date: Thu, 22 May 2025 04:08:37 +0200
Message-ID: <20250522020837.9080-1-lorenz.hetterich@cispa.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: MBX19-GWD-08.um.gwdg.de (10.108.142.61) To
 MBX19-SUB-04.um.gwdg.de (10.108.142.69)
X-Virus-Scanned: (clean) by clamav
Received-SPF: pass client-ip=134.76.10.29;
 envelope-from=lorenz.hetterich@cispa.de; helo=xmailer.gwdg.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 May 2025 00:16:44 -0400
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

---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index dff92772ad..5589a9e865 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3460,6 +3460,16 @@ TRANS(xvmskltz_d, LASX, gen_xx, gen_helper_vmskltz_d)
 TRANS(xvmskgez_b, LASX, gen_xx, gen_helper_vmskgez_b)
 TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
 
+static bool vldi_check_value(DisasContext *ctx, uint32_t imm)
+{
+    if (((imm >> 8) & 0xf) > 12) {
+        generate_exception(ctx, EXCCODE_INE);
+        return false;
+    }
+    return true;
+}
+
+
 #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
 
 static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
@@ -3588,6 +3598,9 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     sel = (a->imm >> 12) & 0x1;
 
     if (sel) {
+        if (!vldi_check_value(ctx, a->imm)) {
+            return true;
+        }
         value = vldi_get_value(ctx, a->imm);
         vece = MO_64;
     } else {
-- 
2.43.0


