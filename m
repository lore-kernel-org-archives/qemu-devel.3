Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B9CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9K-0001zq-4h; Sun, 19 Oct 2025 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9I-0001zg-QC
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:45 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9G-0003Cg-0w
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:44 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id E1BD060A6C
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:40 +0200 (CEST)
Received: (qmail 23263 invoked by uid 990); 19 Oct 2025 15:16:40 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:38 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v8 12/25] target/microblaze: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:01 +0200
Message-ID: <fd9c79eca3e6c590fb630f948474e1186a9fabf7.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999978) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=qFu9MLqW24ZlXSD3Zd1xUyLRQOBol5YAEs1kPkA8RhI=;
 b=ZshoWq5yrMWVn12vhJxruBbNP01KdAaZPhcVE2qHXcKQ/pwqItXNSJYh4pDi6bfs2EhYcVGhtq
 apXqgSE7l1OAjnD51bjJsixnsu11dMfbs0O5zFgtW7sYQXRqpHxwtAomfk1CXORWUpRR5L2RekRg
 mwbvu3w9UtG1nTGNiR4tpX12YB/+QPorePAUw+ba5ilhgRX1bq9buFIiEra+8g1nOBJ4G3HhC9Qq
 JIEi0QN7CuK7CeV+CLxNz1LOnd5PnW+1bTwozpppzfa4ex9f7KNnyZa8p1kpAhqYuVr178iqX8fG
 7WvAonch/wF91/hEPvamr8j32EAs+ZoXy04wLCGmMOdr2ut7tLZLVCJMDxOulwHxQzDAHLwL49X+
 j3F0FQikVfshp00Se03gp4jGb9BSg6o/aVUCJ30NgPomYzyR1quqkzr7EChKFPfLnOqHI+fe1+jz
 mHYefJDAGwfStzb3cmTXrUnyV7ZY5VqMwafl4osPFI3JbzeVfPj/6hzS5I3E60j3zwzjK/8Phdgo
 SihlyO8DxGH0w0MIHtfseBaLil2qtnYz0UXRalKdJDuvEg+CuogL7Q55jyxpjXkhwS02wu1XOmdl
 0e/rLwT6URZ7a+fWYw2JrqsGf4LppZWihEfx39WYkcN8UI9GVIcPsvNDh+kMivs4KGObphij/+Ki
 U=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for MicroBlaze targets. This architecture
has one special "exception" for interrupts and no host calls.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/microblaze/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index cf577a7226..a1857b7217 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -27,6 +27,7 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 
 G_NORETURN
@@ -35,6 +36,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
 {
     CPUMBState *env = cpu_env(cs);
     uint32_t esr, iflags;
+    uint64_t last_pc = env->pc;
 
     /* Recover the pc and iflags from the corresponding insn_start.  */
     cpu_restore_state(cs, retaddr);
@@ -54,6 +56,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
     env->ear = addr;
     env->esr = esr;
     cs->exception_index = EXCP_HW_EXCP;
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
@@ -152,6 +155,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     CPUMBState *env = &cpu->env;
     uint32_t t, msr = mb_cpu_read_msr(env);
     bool set_esr;
+    uint64_t last_pc = env->pc;
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
@@ -256,6 +260,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->res_addr = RES_ADDR_NONE;
     env->iflags = 0;
 
+    if (cs->exception_index == EXCP_IRQ) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     if (!set_esr) {
         qemu_log_mask(CPU_LOG_INT,
                       "         to pc=%08x msr=%08x\n", env->pc, msr);
-- 
2.49.1


