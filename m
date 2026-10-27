Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C1606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 02:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLX5y-0000VU-3X; Mon, 26 Oct 2026 22:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLX5v-0000V8-6f; Mon, 26 Oct 2026 22:39:23 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLX5s-0003AU-Gm; Mon, 26 Oct 2026 22:39:22 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jDF7L6PhYz8Xrrg;
 Tue, 27 Oct 2026 10:39:10 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69R2d0WA024955;
 Tue, 27 Oct 2026 10:39:00 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Tue, 27 Oct 2026 10:39:01 +0800
X-Zmail-TransId: 3e816ae00ec5027-4d79f
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
Date: Tue, 27 Oct 2026 10:37:22 +0800
Message-ID: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69R2d0WA024955
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 27 Oct 2026 10:39:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE00ECE.001/4jDF7L6PhYz8Xrrg
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MMU_USER_IDX is defined as 3, but the RISC-V user-mode MMU index
is MMUIdx_U, which is 0. This macro is used by the generic
cpu_mmu_index() for CONFIG_USER_ONLY builds and must match
riscv_env_mmu_index(), so fix the value to 0.

Fixes: dc5bd18fa572 ("RISC-V CPU Core Definition")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
Changes in v3:
- Keep the MMU_USER_IDX macro because cpu_mmu_index() needs it.
- Link to v2: https://lore.kernel.org/qemu-devel/20261026031144.631964-1-wang.yechao255@zte.com.cn/

Changes in v2:
- Adjust the patch descriptions and rebased on riscv-to-apply.next.
- Link to v1: https://lore.kernel.org/qemu-devel/20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn/

 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..aaf16231de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -180,7 +180,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define RISCV_IMPLIED_EXTS_RULE_END -1
 
-#define MMU_USER_IDX 3
+#define MMU_USER_IDX 0   /* MMUIdx_U */
 
 #if !defined(CONFIG_USER_ONLY)
 #include "tcg/pmp.h"
-- 
2.27.0


