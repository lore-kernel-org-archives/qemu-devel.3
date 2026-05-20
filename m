Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B117CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgfV-0005El-16; Wed, 20 May 2026 09:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfM-00058V-Rf; Wed, 20 May 2026 09:08:52 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfL-00014v-Bg; Wed, 20 May 2026 09:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cj6oQu99qlT+ng8cCZL1pS084vd5sqJeB9Q1HBsySxY=; b=nVD4C3mwDYOQxKp
 pvwsHdJ2zczzBbWZzuionfXy6YLXnSnH45cewaTLJa8XupfU3XaR9csGwKZo+kx49e+1Oc72DzKZF
 ycRWwAKOE8roWffcU1tx/N6Cgbn7JxW3d5Whcxd7jjfDDBThQxYIlaGSZqAB683glg3I898YhOCSR
 Y0=;
Date: Wed, 20 May 2026 15:13:02 +0200
Subject: [PATCH v3 10/14] target/riscv: Move riscv_pmu_read_ctr() to
 internal csr.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-10-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=1894;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=UHPJHt603MYE3TzTjqLvo5+3X3IdFPMsGqDODtT/NBg=;
 b=4AE8JW/uNun1zIPb9tmwmk5wC+xnPtPpmUc6BTKr/72KTG8XOTV2l6E0asjedn+aMnnEFs4FP
 4eYpYdhFgz3CjUy003ghCGbdwXUnC0ADMNc6wZM0rgOkC5xV0bIuRjf
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The function depends on target_ulong and is via the pmu.h header exposed
to hw/riscv, this function is only used internally in pmu.c and csr.c,
so move it to the internal csr.h header.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/csr.h | 3 +++
 target/riscv/pmu.h | 2 --
 target/riscv/pmu.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index c791260f83..0454898bb7 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -99,4 +99,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 
+/* PMU CSRs */
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+                                  bool upper_half, uint32_t ctr_idx);
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index b4f1e469a2..273d8f3f94 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -36,7 +36,5 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3444400bd2..4b7be6164e 100644
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
2.52.0


