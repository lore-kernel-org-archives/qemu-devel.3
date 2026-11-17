Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DF606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJDV-0000YW-Ei; Tue, 17 Nov 2026 08:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDS-0000Xw-TB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:18 -0500
Received: from atcsqr.andestech.com ([220.128.198.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDQ-0003tH-RF
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:18 -0500
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 6AHDQnNs073909
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2026 21:26:49 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 21:26:49 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Nov
 2026 21:26:48 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu@processmission.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v1 1/2] target/riscv: Write zero into mtinst/htinst for
 SSAMOSWAP faults
Date: Tue, 17 Nov 2026 21:26:37 +0800
Message-ID: <20261117132638.1452474-2-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117132638.1452474-1-alvinga@andestech.com>
References: <20261117132638.1452474-1-alvinga@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 6AHDQnNs073909
Received-SPF: pass client-ip=220.128.198.184;
 envelope-from=alvinga@andestech.com; helo=Atcsqr.andestech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The privileged spec defines transformed instructions for standard AMO
instructions which do not include SSAMOSWAP. The spec also says: "If a
synchronous trap occurs for a standard instruction for which no
transformation has been defined, the trap instruction register shall
be written with zero".

So mtinst and htinst should be zero for SSAMOSWAP faults. The previous
implementation only compares opcode which is not enough to distinguish
SSAMOSWAP from standard AMO instructions. This commit further compares
it with funct5.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4721
Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/instmap.h        | 2 ++
 target/riscv/tcg/cpu_helper.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index f877530576..bddcf313df 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -165,6 +165,8 @@ enum {
     OPC_RISC_AMOMAX      = OPC_RISC_ATOMIC | (0x14 << 27),
     OPC_RISC_AMOMINU     = OPC_RISC_ATOMIC | (0x18 << 27),
     OPC_RISC_AMOMAXU     = OPC_RISC_ATOMIC | (0x1C << 27),
+
+    OPC_RISC_SSAMOSWAP   = OPC_RISC_ATOMIC | (0x09 << 27),
 };
 
 #define MASK_OP_SYSTEM(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..94e385261b 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2078,9 +2078,12 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
         /* Transform 32bit (or wider) instructions */
         switch (MASK_OP_MAJOR(insn)) {
         case OPC_RISC_ATOMIC:
-            xinsn = insn;
-            access_rs1 = GET_RS1(insn);
-            access_size = 1 << GET_FUNCT3(insn);
+            /* Exclude SSAMOSWAP.W and SSAMOSWAP.D */
+            if (MASK_OP_ATOMIC_NO_AQ_RL_SZ(insn) != OPC_RISC_SSAMOSWAP) {
+                xinsn = insn;
+                access_rs1 = GET_RS1(insn);
+                access_size = 1 << GET_FUNCT3(insn);
+            }
             break;
         case OPC_RISC_LOAD:
         case OPC_RISC_FP_LOAD:
-- 
2.43.0


