Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E33BC02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 05:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tep6D-00006U-H8; Mon, 03 Feb 2025 00:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tep0Q-0005ex-Hs; Mon, 03 Feb 2025 00:28:23 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tep0N-0006h9-UL; Mon, 03 Feb 2025 00:28:21 -0500
DKIM-Signature: a=rsa-sha256; bh=poFhMeLRXnQt45Hgwi4heYrRECsNY8bbkOpUuq+Av/k=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1738560491; v=1;
 b=q4Tf9Xs1mellGBetelYNSUN9v/YKKlJT7fUPAZozcyQMxIMCXCE2OgCYTb7g/VQj6a9GWSCN
 WYS11ync9CHXOeph9JPIS+2M02CAH/9nfr/SBjwSeyQBdAeJIMh+JWxFvnoU0VDm5BMC+EjM1Lg
 dJT4lEQN4xYyPZRCPFBU7W+vO2zspdQ55lKuNsklfxDC46LtJ4HNIgeuDU0YBduA6YVt7oTuFuL
 4j80eSv+EXwFQKvyStEchlUGIBtV95IWZKfvb724L5eSFlgiPqK+1nGULyu6MWcUyH6P+RRl11P
 xdkBCeix4t4g+QM5LwiP+VEkwhP7LQAeISbR/6ptUkoaw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 9760F200D0;
 Mon, 03 Feb 2025 05:28:11 +0000 (UTC)
From: ~yuming <yuming@git.sr.ht>
Date: Thu, 16 Jan 2025 10:40:31 +0800
Subject: [PATCH qemu v2] target/riscv: Check ext_zca for misaligned return
 address of mret/sret.
MIME-Version: 1.0
Message-ID: <173856049155.9683.4580810619712230382-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~yuming <yumin686@andestech.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yu-Ming Chang <yumin686@andestech.com>

We only check RVC to allow 16-bit aligned return addreses. This will
cause issues when only ext_zca is enabled without RVC: 16-bit
instructions are allowed, but 16-bit aligned return address are not.
We should also check ext_zca to permit 16-bit aligned return addresses.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
---
The v2 has been updated to provide more explanation.

 target/riscv/op_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..891002f954 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -269,8 +269,10 @@ target_ulong helper_sret(CPURISCVState *env)
     }
 
     target_ulong retpc = env->sepc;
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {
+        if ((retpc & 0x3) != 0) {
+            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        }
     }
 
     if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
@@ -328,8 +330,10 @@ target_ulong helper_mret(CPURISCVState *env)
     }
 
     target_ulong retpc = env->mepc;
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {
+        if ((retpc & 0x3) != 0) {
+            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        }
     }
 
     uint64_t mstatus = env->mstatus;
-- 
2.45.3

