Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81EFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8Ae-0001zx-8x; Fri, 28 Jun 2024 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1sN8Ac-0001zo-F2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:45:30 -0400
Received: from out28-49.mail.aliyun.com ([115.124.28.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1sN8Aa-0000ln-P4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:45:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1466847|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0229282-0.000699653-0.976372;
 FP=12600308759697844946|1|1|6|0|-1|-1|-1;
 HT=maildocker-contentspam033070021165; MF=jiangzw@tecorigin.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.YCNrY5._1719567605; 
Received: from localhost.localdomain(mailfrom:jiangzw@tecorigin.com
 fp:SMTPD_---.YCNrY5._1719567605) by smtp.aliyun-inc.com;
 Fri, 28 Jun 2024 17:40:11 +0800
From: Zhiwei Jiang <jiangzw@tecorigin.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Zhiwei Jiang <jiangzw@tecorigin.com>
Subject: [PATCH] target/riscv: Fix the check with vector register multiples of
 LMUL
Date: Fri, 28 Jun 2024 09:40:03 +0000
Message-Id: <20240628094003.94182-1-jiangzw@tecorigin.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=115.124.28.49; envelope-from=jiangzw@tecorigin.com;
 helo=out28-49.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=unavailable autolearn_force=no
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

In the original extract32(val, 0, lmul) logic, when lmul is 2 and val is v10 or v12,
there is an issue with this check condition. I think a simple mod operation is sufficient.

Signed-off-by: Zhiwei Jiang <jiangzw@tecorigin.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3a3896ba06..e89b0f2b1e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -118,7 +118,7 @@ static bool require_nf(int vd, int nf, int lmul)
  */
 static bool require_align(const int8_t val, const int8_t lmul)
 {
-    return lmul <= 0 || extract32(val, 0, lmul) == 0;
+    return lmul <= 0 || val % lmul == 0;
 }
 
 /*
-- 
2.17.1


