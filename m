Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB92CFB43C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxeWR-0005J1-SZ; Sun, 06 Oct 2024 23:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeWP-0005Im-So; Sun, 06 Oct 2024 23:34:57 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeWM-00064w-VJ; Sun, 06 Oct 2024 23:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728272090; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=QFlizzQXd2Vzk0KL2AZvVmfiBZ91I9MAYtLOcFJEyXA=;
 b=H3Nnf3k6u9vD4HKXcHaNtIekmBka9aktT/KK+j0tA47QEnI+XnseZ+qPsvSGAjLMKIHwuuGYaSGQA8rNMnXi1mHoe8wsRpKI0373RaL+4yQNq3Za/Z/6AV+luLRbfKOYnBUUlSFZyoMgH7a6rSlJ6m1Tj0V2oqJgZunIvi6f2Wc=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLRZQe_1728272088) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:34:49 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 1/7] target/riscv: Fix sstatus read and write
Date: Mon,  7 Oct 2024 11:33:54 +0800
Message-Id: <20241007033400.50163-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Sstatus is SXLEN bits in length and always has the layout determined by
the SXL configuration, regardless of the current XLEN.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Fixes: b550f89457 (target/riscv: Compute mstatus.sd on demand)
Fixes: f310df58bd (target/riscv: Enable uxl field write)
---
 target/riscv/csr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..b33cc1ec23 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2893,7 +2893,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
 {
     uint64_t mask = sstatus_v1_10_mask;
     uint64_t sstatus = env->mstatus & mask;
-    if (env->xl != MXL_RV32 || env->debugger) {
+    if (riscv_cpu_sxl(env) != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
 
@@ -2905,11 +2905,10 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     target_ulong mask = (sstatus_v1_10_mask);
-    if (env->xl != MXL_RV32 || env->debugger) {
+    if (riscv_cpu_sxl(env) != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
-    /* TODO: Use SXL not MXL. */
-    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
+    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -2918,7 +2917,7 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
 {
     target_ulong mask = (sstatus_v1_10_mask);
 
-    if (env->xl != MXL_RV32 || env->debugger) {
+    if (riscv_cpu_sxl(env) != MXL_RV32 || env->debugger) {
         if ((val & SSTATUS64_UXL) != 0) {
             mask |= SSTATUS64_UXL;
         }
-- 
2.43.0


