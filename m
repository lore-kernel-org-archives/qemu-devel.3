Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5883CC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 06:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rarUR-0001LG-0S; Fri, 16 Feb 2024 01:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rarUP-0001Ky-3a
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:14:26 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rarUM-0006L6-W3
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:14:24 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 41G6E7Sw007706;
 Fri, 16 Feb 2024 14:14:07 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from alvinga-VirtualBox.andestech.com (10.0.13.68) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Fri, 16 Feb 2024 14:14:06 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger module
Date: Fri, 16 Feb 2024 14:13:29 +0800
Message-ID: <20240216061332.50229-2-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216061332.50229-1-alvinga@andestech.com>
References: <20240216061332.50229-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.13.68]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41G6E7Sw007706
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The RISC-V debug specification defines an optional CSR "tcontrol" within
the trigger module. This commit adds its read/write operations and
related bit-field definitions.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/csr.c      | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f52dce78ba..f9ae3e3025 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -364,6 +364,7 @@ struct CPUArchState {
     target_ulong tdata1[RV_MAX_TRIGGERS];
     target_ulong tdata2[RV_MAX_TRIGGERS];
     target_ulong tdata3[RV_MAX_TRIGGERS];
+    target_ulong tcontrol;
     target_ulong mcontext;
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..3b3a7a0fa4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -353,6 +353,7 @@
 #define CSR_TDATA2          0x7a2
 #define CSR_TDATA3          0x7a3
 #define CSR_TINFO           0x7a4
+#define CSR_TCONTROL        0x7a5
 #define CSR_MCONTEXT        0x7a8
 
 /* Debug Mode Registers */
@@ -900,6 +901,8 @@ typedef enum RISCVException {
 #define JVT_BASE                           (~0x3F)
 
 /* Debug Sdtrig CSR masks */
+#define TCONTROL_MTE                       BIT(3)
+#define TCONTROL_MPTE                      BIT(7)
 #define MCONTEXT32                         0x0000003F
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b9..816c530481 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3937,6 +3937,20 @@ static RISCVException read_tinfo(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_tcontrol(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val = env->tcontrol;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_tcontrol(CPURISCVState *env, int csrno,
+                                     target_ulong val)
+{
+    env->tcontrol = val & (TCONTROL_MPTE | TCONTROL_MTE);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcontext(CPURISCVState *env, int csrno,
                                     target_ulong *val)
 {
@@ -4861,6 +4875,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,    write_tdata    },
     [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
+    [CSR_TCONTROL]  =  { "tcontrol", debug, read_tcontrol, write_tcontrol },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
 
     /* User Pointer Masking */
-- 
2.34.1


