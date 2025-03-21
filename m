Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32D4C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTKF-0006CZ-9E; Thu, 20 Mar 2025 23:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvTKC-0006Al-Tt
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:45:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvTK9-0002NE-MJ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:45:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGrY4NxnSJ2fAA--.8555S3;
 Fri, 21 Mar 2025 11:45:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfR4Nxn+j9XAA--.61233S5;
 Fri, 21 Mar 2025 11:45:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] target/loongarch: fix bad shift in check_ps()
Date: Fri, 21 Mar 2025 11:45:21 +0800
Message-Id: <20250321034521.2425622-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250321034521.2425622-1-maobibo@loongson.cn>
References: <20250321034521.2425622-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfR4Nxn+j9XAA--.61233S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Song Gao <gaosong@loongson.cn>

In expression 1ULL << tlb_ps, left shifting by more than 63 bits has
undefined behavior. The shift amount, tlb_ps, is as much as 64. check
"tlb_ps >=64" to fix.

Resolves: Coverity CID 1593475

Fixes: d882c284a3 ("target/loongarch: check tlb_ps")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/internals.h      |  2 +-
 target/loongarch/tcg/csr_helper.c |  2 +-
 target/loongarch/tcg/tlb_helper.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1cd959a766..9fdc3059d8 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -43,7 +43,7 @@ enum {
     TLBRET_PE = 7,
 };
 
-bool check_ps(CPULoongArchState *ent, int ps);
+bool check_ps(CPULoongArchState *ent, uint8_t ps);
 
 extern const VMStateDescription vmstate_loongarch_cpu;
 
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 379c71e741..6a7a65c860 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -115,7 +115,7 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
-    int shift, ptbase;
+    uint8_t shift, ptbase;
     int64_t old_v = env->CSR_PWCL;
 
     /*
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 646dbf59de..bd8081e886 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -19,12 +19,12 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
-bool check_ps(CPULoongArchState *env, int tlb_ps)
+bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
-     if (tlb_ps > 64) {
-         return false;
-     }
-     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
+    if (tlb_ps >= 64) {
+        return false;
+    }
+    return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
 }
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-- 
2.43.5


