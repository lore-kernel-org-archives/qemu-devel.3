Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C97CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxen2-0001zE-Sd; Sun, 06 Oct 2024 23:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxen0-0001ym-QM; Sun, 06 Oct 2024 23:52:06 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxemx-000814-UQ; Sun, 06 Oct 2024 23:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728273113; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=tPUaAwnZss3gUgr7WUV2NsDqMky9cJt0gFBrh9g2XyA=;
 b=e//bfv2ShLG7l0eOKaRgXJsCMg3n9ZI65jEbzuLFKfeI6evtk1ajhWbqJh4CGoAYA2YPovtIzN+5B4E9BhH9/3A4guuKntq3jvUarz1rcmOctZ/9Rj8jhXjg3ief/ipZZsORjrFhwAqjGWXqulx06sZDnrsFEsl0U4/0LOqIJg0=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLTtSb_1728273111) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:51:52 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 5/7] target/riscv: Enable 32-bit only registers for RV64
 with sxl32
Date: Mon,  7 Oct 2024 11:33:58 +0800
Message-Id: <20241007033400.50163-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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

Allow reading 32-bit only registers like timeh and stimecmph when
booting a 32-bit Linux kernel on RV64 when sxl32 is true.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 93a5cf87ed..c412ac8e31 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -161,7 +161,7 @@ skip_ext_pmu_check:
 
 static RISCVException ctr32(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_mxl(env) != MXL_RV32) {
+    if (env->xl != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -481,7 +481,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
 
 static RISCVException sstc_32(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_mxl(env) != MXL_RV32) {
+    if (env->xl != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-- 
2.43.0


