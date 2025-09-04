Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0123CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGsM-0003c7-Kq; Thu, 04 Sep 2025 16:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGsI-0003b2-Tx
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:07 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGs9-0000jm-56
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:06 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id B963F60C21
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:22 +0200 (CEST)
Received: (qmail 32681 invoked by uid 990); 4 Sep 2025 20:47:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:22 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v6 12/25] target/microblaze: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:49 +0200
Message-ID: <829dc282fcf037d44681ba88be4dd9e17c644376.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.998444) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.598444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=rM5JX9zlQ9WGxAYK3Aunbsrp/Za/oYwP9iC2VqK2Yd4=;
 b=msxdpSIb4Yu+2qhO55qz2NfIUnZ3CxlanAcRPoz7BPA/tG1uuW1lyYmU98KwDj6hnB0UZzz1x3
 fQV4lG416C0zaq/anFAtfODdbca5+0d8xvsAf4l2n8ya5Z/5SJ/u7dJ4K1pf3PT6L8s0XY++x6Gd
 rrcph09Sm5/avtWShMAd3CEeUiQaWpz15qCfn8GKBUP3EdiGSWkJZQb9co7SvgKtzI65fV/4vPkv
 Hol1ZXdKhczd5Srp9jx5LgFdPKq9huUVHp6aX7WK2fgSQLlgtbtBM8H32oyvAd6ocMX9q//yWbsa
 MZpkT2YFPy76EcBiuiVZZw3gBIcWjE+4X4kRBXaW/rk3zFB8KBcWOuxwyDn4fWB6gVYpAwVplyUh
 e3aN1fqpC7h3gHcbDJqb31Z94n65xVoElqdfYpMfQH8kfSv7eKGdvHzRu01caUVzg3fEqPyGGzoC
 a454d531gJaGaew0IlSJwbytjxuG2Y4bcvn64oEZLawNNr+uOs5vM1blZvssAk7yRqO471vnbTUE
 Hj9gMVGF4li3gW//MPKNyxdBvbf0rh7BD2ti1Xw1/801XrRntMina+O75rnshlWXu2uPXnYEeIUw
 h+3cPlAdhXgHpJ2UuVOQUD8Bft/TPnaztSHLsVk0SwI8Fv4VInZdJaOVy8CZxMX6/i+gJ9EkgL+s
 8=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index ef0e2f973f..d66eab6e4b 100644
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


