Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21279CFB43C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxeXT-0007CT-DK; Sun, 06 Oct 2024 23:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeXP-00072u-Up; Sun, 06 Oct 2024 23:36:01 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeXN-0006Ju-IV; Sun, 06 Oct 2024 23:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728272152; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=1NzQGwouVfdUIXxYtTl0qsxrrGtbt73O6bVWAN6aT1A=;
 b=ZiYyV/AoKDEcB//SGUV5UrMxIPHOhVvUe81zQw8OIZoCrjhfQUZ+4wyKx8B+/UFNpBUT3873OSvFQ39fZo6uBhd7aOR5k4v4321WhKh9pgASSpL8q3Fvzanmr+Ub4qnfoD+B1HtNrBBveDxozRu29+DVDS9mVBJbVGcU0gRdl1w=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLRa-D_1728272150) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:35:51 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 3/7] target/riscv: Read pte and satp based on SXL in PTW
Date: Mon,  7 Oct 2024 11:33:56 +0800
Message-Id: <20241007033400.50163-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
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

Satp and PTE are always SXLEN-bit. when SXLEN is 32,
read PTE as 4 bytes, and treat satp as SATP32.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 077f6d77c3..773789e02e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -851,7 +851,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 vm = get_field(env->vsatp, SATP64_MODE);
             }
         } else {
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
+            if (riscv_cpu_sxl(env) == MXL_RV32) {
                 base = (hwaddr)get_field(env->satp, SATP32_PPN) << PGSHIFT;
                 vm = get_field(env->satp, SATP32_MODE);
             } else {
@@ -972,7 +972,7 @@ restart:
             return TRANSLATE_PMP_FAIL;
         }
 
-        if (riscv_cpu_mxl(env) == MXL_RV32) {
+        if (riscv_cpu_sxl(env) == MXL_RV32) {
             pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
         } else {
             pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
-- 
2.43.0


