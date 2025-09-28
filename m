Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76158CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2n4e-0007Rh-8B; Sun, 28 Sep 2025 04:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v2n4V-0007MX-0p
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v2n4I-00026w-26
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:53 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxH9Mo9thoRssPAA--.33363S3;
 Sun, 28 Sep 2025 16:47:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8Eg9tho32y5AA--.23975S7;
 Sun, 28 Sep 2025 16:47:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 05/13] target/loongarch: Fix page size set issue with CSR_STLBPS
Date: Sun, 28 Sep 2025 16:47:20 +0800
Message-Id: <20250928084728.1972177-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250928084728.1972177-1-maobibo@loongson.cn>
References: <20250928084728.1972177-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8Eg9tho32y5AA--.23975S7
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When modify register CSR_STLBPS, the page size should come from
input parameter rather than old value.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h        | 1 +
 target/loongarch/tcg/csr_helper.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..1a311bf06a 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -106,6 +106,7 @@ FIELD(CSR_PWCH, DIR4_WIDTH, 18, 6)
 
 #define LOONGARCH_CSR_STLBPS         0x1e /* Stlb page size */
 FIELD(CSR_STLBPS, PS, 0, 5)
+FIELD(CSR_STLBPS, RESERVE, 5, 27)
 
 #define LOONGARCH_CSR_RVACFG         0x1f /* Reduced virtual address config */
 FIELD(CSR_RVACFG, RBITS, 0, 4)
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 0d99e2c92b..eb60fefa82 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -26,13 +26,14 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
      * The real hardware only supports the min tlb_ps is 12
      * tlb_ps=0 may cause undefined-behavior.
      */
-    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    uint8_t tlb_ps = FIELD_EX64(val, CSR_STLBPS, PS);
     if (!check_ps(env, tlb_ps)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attempted set ps %d\n", tlb_ps);
     } else {
         /* Only update PS field, reserved bit keeps zero */
-        env->CSR_STLBPS = FIELD_DP64(old_v, CSR_STLBPS, PS, tlb_ps);
+        val = FIELD_DP64(val, CSR_STLBPS, RESERVE, 0);
+        env->CSR_STLBPS = val;
     }
 
     return old_v;
-- 
2.43.5


