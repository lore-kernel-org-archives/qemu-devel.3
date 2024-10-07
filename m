Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA897CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxeWu-0005qZ-Ek; Sun, 06 Oct 2024 23:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeWs-0005mp-HD; Sun, 06 Oct 2024 23:35:26 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeWq-0006Hl-Gp; Sun, 06 Oct 2024 23:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728272121; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ZK8IihrJgq1aqOhIVgrYyLKYrkCn5+LTqtDMLZVNDLE=;
 b=UlOsrOp/8zigBhOhHmZ3KAYdNwk9VrcK8Ov7DgOmz7VvwCn3sLv3C58jgqtjcUtCCj3N5F5Alo8PlBB+Y2E1MWtIpsxetu3AIUKWMjegKiAFlnp6ylZCwKYt9qyNF+0igqWKdaKpdNNHCZN66DpdcNiEpsgy/onIiGDOvYq2In8=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLTm4l_1728272119) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:35:20 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v1 2/7] target/riscv: Fix satp read and write implicitly or
 explicitly.
Date: Mon,  7 Oct 2024 11:33:55 +0800
Message-Id: <20241007033400.50163-3-zhiwei_liu@linux.alibaba.com>
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

CSR satp is SXLEN bits in length and always has the $layout determined by
the SXL configuration, regardless of the current XLEN.

Only process CSR satp, as we still don't have a riscv_cpu_vsxl API
currently.

Added sxl32 property to control sxlen as 32 in s-mode for QEMU RV64.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Fixes: c7b9517188 (RISC-V: Implement modular CSR helper interface)
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu_cfg.h |  4 ++++
 target/riscv/csr.c     | 25 +++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..cdbd2afe29 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -173,6 +173,10 @@ struct RISCVCPUConfig {
     bool short_isa_string;
 
 #ifndef CONFIG_USER_ONLY
+    /*
+     * true when RV64 QEMU running with mxlen==64 but sxlen==32.
+     */
+    bool sxl32;
     RISCVSATPMap satp_mode;
 #endif
 };
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b33cc1ec23..93a5cf87ed 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1504,16 +1504,29 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
-    uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
+    uint64_t mode_supported = 0;
+    if (riscv_cpu_cfg(env)->sxl32 && (riscv_cpu_mxl(env) != MXL_RV32)) {
+        mode_supported = (1 << VM_1_10_MBARE) | (1 << VM_1_10_SV32);
+    } else {
+        mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
+    }
     return get_field(mode_supported, (1 << vm));
 }
 
 static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
-                                  target_ulong val)
+                                  target_ulong val, int csrno)
 {
     target_ulong mask;
     bool vm;
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
+    RISCVMXL xl;
+
+    if (csrno == CSR_SATP) {
+        xl = riscv_cpu_sxl(env);
+    } else {
+        xl = riscv_cpu_mxl(env);
+    }
+
+    if (xl == MXL_RV32) {
         vm = validate_vm(env, get_field(val, SATP32_MODE));
         mask = (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
     } else {
@@ -3316,7 +3329,7 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
 
-    env->satp = legalize_xatp(env, env->satp, val);
+    env->satp = legalize_xatp(env, env->satp, val, csrno);
     return RISCV_EXCP_NONE;
 }
 
@@ -3834,7 +3847,7 @@ static RISCVException read_hgatp(CPURISCVState *env, int csrno,
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->hgatp = legalize_xatp(env, env->hgatp, val);
+    env->hgatp = legalize_xatp(env, env->hgatp, val, csrno);
     return RISCV_EXCP_NONE;
 }
 
@@ -4116,7 +4129,7 @@ static RISCVException read_vsatp(CPURISCVState *env, int csrno,
 static RISCVException write_vsatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->vsatp = legalize_xatp(env, env->vsatp, val);
+    env->vsatp = legalize_xatp(env, env->vsatp, val, csrno);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.43.0


