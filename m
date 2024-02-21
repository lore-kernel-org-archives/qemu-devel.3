Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05590C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoNu-0000XC-3N; Wed, 21 Feb 2024 10:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcoJv-0000sX-2c; Wed, 21 Feb 2024 10:15:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcmLz-0004p2-KD; Wed, 21 Feb 2024 08:09:42 -0500
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TfxQp0br0z1xnml;
 Wed, 21 Feb 2024 21:08:02 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id C4CF31A0172;
 Wed, 21 Feb 2024 21:09:24 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 21:09:24 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 03/22] target/arm: Add PSTATE.ALLINT
Date: Wed, 21 Feb 2024 13:08:04 +0000
Message-ID: <20240221130823.677762-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221130823.677762-1-ruanjinjie@huawei.com>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ALLINT bit in PSTATE is used to mask all IRQ or FIQ interrupts.

Place this in its own field within ENV, as that will
make it easier to reset from within TCG generated code.

With the change to pstate_read/write, exception entry
and return are automatically handled.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu.c | 3 +++
 target/arm/cpu.h | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5fa86bc8d5..5e5978c302 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1104,6 +1104,9 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     if (cpu_isar_feature(aa64_bti, cpu)) {
         qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
     }
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        qemu_fprintf(f, "  ALLINT=%d", (psr & PSTATE_ALLINT) >> 13);
+    }
     qemu_fprintf(f, "%s%s%s",
                  (hcr & HCR_NV) ? " NV" : "",
                  (hcr & HCR_NV1) ? " NV1" : "",
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 63f31e0d98..f9646dbbfb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -224,6 +224,7 @@ typedef struct CPUArchState {
      *    semantics as for AArch32, as described in the comments on each field)
      *  nRW (also known as M[4]) is kept, inverted, in env->aarch64
      *  DAIF (exception masks) are kept in env->daif
+     *  ALLINT (all IRQ or FIQ interrupts masks) are kept in env->allint
      *  BTYPE is kept in env->btype
      *  SM and ZA are kept in env->svcr
      *  all other bits are stored in their correct places in env->pstate
@@ -261,6 +262,7 @@ typedef struct CPUArchState {
     uint32_t btype;  /* BTI branch type.  spsr[11:10].  */
     uint64_t daif; /* exception masks, in the bits they are in PSTATE */
     uint64_t svcr; /* PSTATE.{SM,ZA} in the bits they are in SVCR */
+    uint64_t allint; /* All IRQ or FIQ interrupt mask, in the bit in PSTATE */
 
     uint64_t elr_el[4]; /* AArch64 exception link regs  */
     uint64_t sp_el[4]; /* AArch64 banked stack pointers */
@@ -1543,6 +1545,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define PSTATE_D (1U << 9)
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_SSBS (1U << 12)
+#define PSTATE_ALLINT (1U << 13)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
@@ -1555,7 +1558,8 @@ FIELD(VTCR, SL2, 33, 1)
 #define PSTATE_N (1U << 31)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
-#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
+#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE | \
+                            PSTATE_ALLINT)
 /* Mode values for AArch64 */
 #define PSTATE_MODE_EL3h 13
 #define PSTATE_MODE_EL3t 12
@@ -1595,7 +1599,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
     ZF = (env->ZF == 0);
     return (env->NF & 0x80000000) | (ZF << 30)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3)
-        | env->pstate | env->daif | (env->btype << 10);
+        | env->pstate | env->allint | env->daif | (env->btype << 10);
 }
 
 static inline void pstate_write(CPUARMState *env, uint32_t val)
@@ -1604,6 +1608,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
     env->NF = val;
     env->CF = (val >> 29) & 1;
     env->VF = (val << 3) & 0x80000000;
+    env->allint = val & PSTATE_ALLINT;
     env->daif = val & PSTATE_DAIF;
     env->btype = (val >> 10) & 3;
     env->pstate = val & ~CACHED_PSTATE_BITS;
-- 
2.34.1


