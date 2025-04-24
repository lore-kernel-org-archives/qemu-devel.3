Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F82EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tEZ-0000Ee-Eh; Thu, 24 Apr 2025 05:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7tEW-0000DE-8n
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7tET-0002wS-1L
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:03 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxieB9CQpoXzzFAA--.20695S3;
 Thu, 24 Apr 2025 17:50:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx_cZ8CQpoIFeTAA--.43713S5;
 Thu, 24 Apr 2025 17:50:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org,
 --cc=richard.henderson@linaro.org, WANG Rui <wangrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 13/13] target/loongarch: Guard BCEQZ/BCNEZ instructions with FP
 feature
Date: Thu, 24 Apr 2025 17:28:49 +0800
Message-Id: <20250424092849.3985437-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424092849.3985437-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
 <20250424092849.3985437-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZ8CQpoIFeTAA--.43713S5
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

From: WANG Rui <wangrui@loongson.cn>

The BCEQZ and BCNEZ instructions depend on access to condition codes
from floating-point comparisons. Previously, these instructions were
unconditionally enabled for 64-bit targets.

This patch updates their translation to be gated under the `FP` feature
flag instead, ensuring they are only available when the floating-point
unit is present.

This improves correctness for CPUs lacking floating-point support.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250418082103.447780-3-wangrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_branch.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
index 221e5159db..f94c1f37ab 100644
--- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
 TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
 TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
 TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
-TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
-TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
+TRANS(bceqz, FP, gen_cz_bc, TCG_COND_EQ)
+TRANS(bcnez, FP, gen_cz_bc, TCG_COND_NE)
-- 
2.34.1


