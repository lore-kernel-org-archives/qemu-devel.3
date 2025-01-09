Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BCDE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 03:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tViyD-0008ST-NK; Wed, 08 Jan 2025 22:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViyC-0008S5-5W; Wed, 08 Jan 2025 22:12:28 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViyA-0001Ho-E3; Wed, 08 Jan 2025 22:12:27 -0500
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 5092jXYk028556;
 Thu, 9 Jan 2025 10:45:33 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5092j0DH027816
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 10:45:00 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 9 Jan 2025
 10:45:00 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v9 4/8] target/riscv: Add support for IOPMP
Date: Thu, 9 Jan 2025 10:44:37 +0800
Message-ID: <20250109024441.3283671-5-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20250109024441.3283671-1-ethan84@andestech.com>
References: <20250109024441.3283671-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5092jXYk028556
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Ethan Chen <ethan84@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  3 +++
 target/riscv/cpu_cfg.h    |  2 ++
 target/riscv/cpu_helper.c | 18 +++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8d5120106..212e522ed7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2798,6 +2798,9 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+
+    DEFINE_PROP_BOOL("iopmp", RISCVCPU, cfg.iopmp, false),
+    DEFINE_PROP_UINT32("iopmp_rrid", RISCVCPU, cfg.iopmp_rrid, 0),
 };
 
 #if defined(TARGET_RISCV64)
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a1457ab4f4..c5d5e1a77d 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -175,6 +175,8 @@ struct RISCVCPUConfig {
     bool pmp;
     bool debug;
     bool misa_w;
+    bool iopmp;
+    uint32_t iopmp_rrid;
 
     bool short_isa_string;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f62b21e182..926ae38684 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1599,9 +1599,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
-                     prot, mmu_idx, tlb_size);
-        return true;
+        if (cpu->cfg.iopmp) {
+            /*
+             * Do not align address on early stage because IOPMP needs origin
+             * address for permission check.
+             */
+            tlb_set_page_with_attrs(cs, address, pa,
+                                    (MemTxAttrs)
+                                        {
+                                          .requester_id = cpu->cfg.iopmp_rrid,
+                                        },
+                                    prot, mmu_idx, tlb_size);
+        } else {
+            tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+                         prot, mmu_idx, tlb_size);
+        }
     } else if (probe) {
         return false;
     } else {
-- 
2.34.1


