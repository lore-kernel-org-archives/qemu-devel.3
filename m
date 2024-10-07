Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D27CFB43C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 04:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxfMM-0005u4-Pm; Mon, 07 Oct 2024 00:28:38 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxf8B-0004T6-E2; Mon, 07 Oct 2024 00:18:06 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxf3H-0001F5-0Q; Mon, 07 Oct 2024 00:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728274124; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=kbhkNAflIjFQzxSp5wJZlmlVvimUd8ZzBB1vDppvOYU=;
 b=aMrY0s3tAX+LO3MXgHiFjMW701ZOYBnED1sHZpd6+DIS357/w7lbAeKXQugHS8+/b9e9JmKkFFf+0VEhsh4Q+3OGplnKYoNd2YWF/v3sPGIEDx6HChibdiOSK9Tr8IrwQwm27BxrBgi+POme7GWnsZ5SIS3+GhyQS0Sz42mkvzI=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLZQ7U_1728274122) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 12:08:43 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 6/7] target/riscv: Reset SXL and UXL according to sxl32
Date: Mon,  7 Oct 2024 11:33:59 +0800
Message-Id: <20241007033400.50163-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

When boot a 32-bit system, sxl and uxl should be set to 1 by OpenSBI. However,
OpenSBI does not support this feature.

We temporarily force QEMU reset SXL and UXL to MXL_RV32 when sxl32 is enabled.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index baf8fba467..9dbbb1ca77 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -933,8 +933,17 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
          * The reset status of SXL/UXL is undefined, but mstatus is WARL
          * and we must ensure that the value after init is valid for read.
          */
-        env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, env->misa_mxl);
-        env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, env->misa_mxl);
+        if (cpu->cfg.sxl32) {
+            env->mstatus = set_field(env->mstatus, MSTATUS64_SXL,
+                                      MXL_RV32);
+            env->mstatus = set_field(env->mstatus, MSTATUS64_UXL,
+                                      MXL_RV32);
+        } else {
+            env->mstatus = set_field(env->mstatus, MSTATUS64_SXL,
+                                      env->misa_mxl);
+            env->mstatus = set_field(env->mstatus, MSTATUS64_UXL,
+                                      env->misa_mxl);
+        }
         if (riscv_has_ext(env, RVH)) {
             env->vsstatus = set_field(env->vsstatus,
                                       MSTATUS64_SXL, env->misa_mxl);
-- 
2.43.0


