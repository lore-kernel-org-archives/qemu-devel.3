Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0599CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwr6-0007ip-4V; Fri, 15 May 2026 14:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqb-0007My-F4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:21 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqR-0001SU-HL
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4copfV3KOUSGQI/wq6tJqErp7sDw4BebeHasptGS1lM=; b=WGHEM3MhkP6TFf/
 iBKJ1eYTaD7jnU7W0hM2/m1i/UjJBcmuxQlNm126Bcn3mKtMntYOG5QovAnLovQM2TaGZbs7pD79O
 /eCIQyuYNThQgcW+JpP3xrgh5uphegVWuSTpw2znBQcX/tspkMnz1eXpDYqj9vuo0Hhai/t+ZeZy1
 hA=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 27/27] target/riscv: Fix pmp.h/cpu.h circular inclusion
Date: Fri, 15 May 2026 20:04:37 +0200
Message-ID: <20260515180437.23620-28-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

pmp.h is only needed and included for system mode, however relevant
macros (MAX_RISCV_PMPS, OLD_MAX_RISCV_PMPS, MIN_RISCV_PMP_GRANULARITY)
are required unconditionally by cpu.c, and so are defined in cpu.h.
pmp.h then defines pmp_table_t depending on these macros and so requires
cpu.h, and cpu.h in turn uses pmp_table_t resulting in circular
inclusion.

Move PMP macros to pmp.h and only exose PMP properties in system mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 4 ----
 target/riscv/pmp.h | 4 +++-
 target/riscv/cpu.c | 6 ++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ad5d23ee6b..4bd24c15c5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -180,10 +180,6 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MMU_USER_IDX 3
 
-#define MAX_RISCV_PMPS (64)
-#define OLD_MAX_RISCV_PMPS (16)
-#define MIN_RISCV_PMP_GRANULARITY 4
-
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
 #endif
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index eae305ac6f..4c95c2767a 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,7 +22,9 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
-#include "cpu.h"
+#define MAX_RISCV_PMPS (64)
+#define OLD_MAX_RISCV_PMPS (16)
+#define MIN_RISCV_PMP_GRANULARITY 4
 
 typedef enum {
     PMP_READ  = 1 << 0,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 753f92307f..36f9570f2d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1127,7 +1127,9 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
+#ifndef CONFIG_USER_ONLY
     cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
+#endif
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1550,6 +1552,7 @@ static const PropertyInfo prop_mmu = {
     .set = prop_mmu_set,
 };
 
+#ifndef CONFIG_USER_ONLY
 static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -1658,6 +1661,7 @@ static const PropertyInfo prop_pmp_granularity = {
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
 };
+#endif /* !CONFIG_USER_ONLY */
 
 static int priv_spec_from_str(const char *priv_spec_str)
 {
@@ -2666,9 +2670,11 @@ static const Property riscv_cpu_properties[] = {
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
     {.name = "mmu", .info = &prop_mmu},
+#ifndef CONFIG_USER_ONLY
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
     {.name = "pmp-granularity", .info = &prop_pmp_granularity},
+#endif
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
-- 
2.52.0


