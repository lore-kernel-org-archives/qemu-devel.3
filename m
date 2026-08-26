Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D72C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAuX-0001wP-9h; Wed, 26 Aug 2026 06:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAuM-0001tw-QK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:02 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuJ-0003K6-Vm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:02 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 9018B7A17;
 Wed, 26 Aug 2026 16:00:54 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v4 01/14] target/loongarch: Define LVZ CSR fields
Date: Wed, 26 Aug 2026 18:30:05 +0800
Message-ID: <4e393c8c6f5d7d42ede6fa65fc94753bd8b14c17.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787739852.git.prcups@krgm.moe>
References: <cover.1787739852.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add LVZ CSR number and bit-field definitions for guest status,
configuration, interrupt, timer and guest TLB registers, preparing
the architectural constants needed by later LVZ CPU state, CSR and TCG
implementation patches.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-csr.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..438da43a79 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -224,4 +224,42 @@ FIELD(CSR_DBG, ECODE, 16, 6)
 #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
 #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
 
+/* LVZ (LoongArch Virtualization) CSRs */
+#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
+FIELD(CSR_GSTAT, VM, 0, 1)
+FIELD(CSR_GSTAT, PVM, 1, 1)
+FIELD(CSR_GSTAT, GIDBIT, 4, 6)
+FIELD(CSR_GSTAT, GID, 16, 8)
+
+#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
+FIELD(CSR_GCFG, MATP, 0, 4)
+FIELD(CSR_GCFG, MATC, 4, 2)
+FIELD(CSR_GCFG, TOPIP, 6, 1)
+FIELD(CSR_GCFG, TOPI, 7, 1)
+FIELD(CSR_GCFG, TOTIP, 8, 1)
+FIELD(CSR_GCFG, TOTI, 9, 1)
+FIELD(CSR_GCFG, TOEP, 10, 1)
+FIELD(CSR_GCFG, TOE, 11, 1)
+FIELD(CSR_GCFG, TOPP, 12, 1)
+FIELD(CSR_GCFG, TOP, 13, 1)
+FIELD(CSR_GCFG, TOHUP, 14, 1)
+FIELD(CSR_GCFG, TOHU, 15, 1)
+FIELD(CSR_GCFG, TOCIP, 16, 4)
+FIELD(CSR_GCFG, TOCI, 20, 2)
+FIELD(CSR_GCFG, GPMP, 23, 1)
+FIELD(CSR_GCFG, GPMNUM, 24, 3)
+
+#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
+FIELD(CSR_GINTC, HWIS, 0, 8)
+FIELD(CSR_GINTC, HWIP, 8, 8)
+FIELD(CSR_GINTC, HWIC, 16, 8)
+
+#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
+
+#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
+FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
+FIELD(CSR_GTLBC, USETGID, 12, 1)
+FIELD(CSR_GTLBC, TOTI, 13, 1)
+FIELD(CSR_GTLBC, TGID, 16, 8)
+
 #endif /* LOONGARCH_CPU_CSR_H */
-- 
2.55.0


