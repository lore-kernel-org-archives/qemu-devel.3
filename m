Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C92D64061
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenH-0001Ge-OS; Tue, 16 Dec 2025 18:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen5-0001CU-DT
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen3-0006m4-J3
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FzpOcrVYjNzEtYgsWqtDXWI5lGWknI6VeBb0xQgmtOw=; b=QnxwhycABv+XnoF
 8pDtw0Ukid1fVaNi9wKNJ1CeGDuLXrRG1eyiijDiHejGl4cY4X7rrhi0h079q+9P5WD8mdRz+WX6c
 OJAKzWSEY79NgWBCwpiF0ezOuX9PUShivvIGmkQZdUx+D39Aq0UJ6j7w5sRCLAfVuJx4QENuVXYD8
 v8=;
Date: Wed, 17 Dec 2025 00:51:15 +0100
Subject: [PATCH 10/14] target/riscv: Move riscv_pmu_read_ctr() to internal
 csr.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-10-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The function depends on target_ulong and is via the pmu.h header exposed
to hw/riscv, this function is only used internally in pmu.c and csr.c,
so move it to the internal csr.h header.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/csr.h | 3 +++
 target/riscv/pmu.h | 2 --
 target/riscv/pmu.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 3752a0ef43..e6a6f2e85f 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -90,4 +90,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 
+/* PMU CSRs */
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+                                  bool upper_half, uint32_t ctr_idx);
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 3853d0e262..ca40cfeed6 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -36,7 +36,5 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 708f2ec7aa..9701c8cba6 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -22,6 +22,7 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
+#include "target/riscv/csr.h"
 #include "exec/icount.h"
 #include "system/device_tree.h"
 

-- 
2.51.0


