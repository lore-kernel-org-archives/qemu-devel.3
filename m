Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C6606A337
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJDT-0000Y9-Sm; Tue, 17 Nov 2026 08:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDS-0000Xp-Ju
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:18 -0500
Received: from atcsqr.andestech.com ([220.128.198.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDQ-0003tD-Op
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:18 -0500
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 6AHDQo8A073911
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2026 21:26:50 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 21:26:50 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Nov
 2026 21:26:50 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu@processmission.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v1 2/2] target/riscv: Write zero into mtinst/htinst for
 SSPUSH/SSPOPCHK faults
Date: Tue, 17 Nov 2026 21:26:38 +0800
Message-ID: <20261117132638.1452474-3-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117132638.1452474-1-alvinga@andestech.com>
References: <20261117132638.1452474-1-alvinga@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 6AHDQo8A073911
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
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The privileged spec defines transformed instructions for standard
virtual-machine load/store instructions which do not include SSPUSH and
SSPOPCHK. The spec also says: "If a synchronous trap occurs for a
standard instruction for which no transformation has been defined, the
trap instruction register shall be written with zero".

So mtinst and htinst should be zero for SSPUSH and SSPOPCHK
faults. The previous implementation only compares opcode and funct3,
which is not enough to distinguish SSPUSH and SSPOPCHK from
virtual-machine load/store instructions. Now we compare opcode, funct3
and funct7 together.

Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/instmap.h        | 15 ++++++++++++++-
 target/riscv/tcg/cpu_helper.c | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index bddcf313df..107e7c5a83 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -170,6 +170,8 @@ enum {
 };
 
 #define MASK_OP_SYSTEM(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
+#define MASK_OP_SYSTEM_FUNCT3_FUNCT7(op)   \
+    (MASK_OP_MAJOR(op) | (op & (0x7 << 12)) | (op & (0x7F << 25)))
 enum {
     OPC_RISC_ECALL       = OPC_RISC_SYSTEM | (0x0 << 12),
     OPC_RISC_EBREAK      = OPC_RISC_SYSTEM | (0x0 << 12),
@@ -187,7 +189,18 @@ enum {
     OPC_RISC_CSRRSI      = OPC_RISC_SYSTEM | (0x6 << 12),
     OPC_RISC_CSRRCI      = OPC_RISC_SYSTEM | (0x7 << 12),
 
-    OPC_RISC_HLVHSV      = OPC_RISC_SYSTEM | (0x4 << 12),
+    /* HLV.B and HLV.BU */
+    OPC_RISC_HLVB        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x30 << 25),
+    /* HLV.H, HLV.HU and HLVX.HU */
+    OPC_RISC_HLVH        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x32 << 25),
+    /* HLV.W, HLV.WU and HLVX.WU */
+    OPC_RISC_HLVW        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x34 << 25),
+    OPC_RISC_HLVD        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x36 << 25),
+
+    OPC_RISC_HSVB        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x31 << 25),
+    OPC_RISC_HSVH        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x33 << 25),
+    OPC_RISC_HSVW        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x35 << 25),
+    OPC_RISC_HSVD        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x37 << 25),
 };
 
 #define MASK_OP_FP_LOAD(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 94e385261b..9a1ce61a2f 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2100,11 +2100,23 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
             access_size = 1 << GET_FUNCT3(insn);
             break;
         case OPC_RISC_SYSTEM:
-            if (MASK_OP_SYSTEM(insn) == OPC_RISC_HLVHSV) {
+            switch (MASK_OP_SYSTEM_FUNCT3_FUNCT7(insn)) {
+            case OPC_RISC_HLVB:
+            case OPC_RISC_HLVH:
+            case OPC_RISC_HLVW:
+            case OPC_RISC_HLVD:
+            case OPC_RISC_HSVB:
+            case OPC_RISC_HSVH:
+            case OPC_RISC_HSVW:
+            case OPC_RISC_HSVD:
                 xinsn = insn;
                 access_rs1 = GET_RS1(insn);
                 access_size = 1 << ((GET_FUNCT7(insn) >> 1) & 0x3);
                 access_size = 1 << access_size;
+                break;
+            default:
+                /* Not a transformed instruction, e.g., SSPUSH and SSPOPCHK. */
+                break;
             }
             break;
         default:
-- 
2.43.0


