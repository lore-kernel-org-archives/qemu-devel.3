Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB231C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2II-0006vs-Lw; Mon, 19 May 2025 11:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IB-0006t2-NS
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:39 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I9-0005Tx-88
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:39 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id AD57B180EA3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:25 +0200 (CEST)
Received: (qmail 1509 invoked by uid 990); 19 May 2025 15:20:25 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:25 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v5 12/25] target/microblaze: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:52 +0200
Message-ID: <06617de4780ef33abf7a04b108ed8aff70a96eea.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99814) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=mYTOuQ7uLH2zInBP9Ap2kCAJ9tif03ZHga/PRE+sxLo=;
 b=k7x8eLsnWw175rZ0XfGvpiIB3e+O6nrNQsFpt7FMbQYJrnpkxTcOZSjBk5xQ66zscRSb2+xeKy
 LoYlIxCFEZ9BsPgV9OHz7+fisljGF0yL4aTTPTayR/RI3meQmHoiZiu3su2a/49wY5KkgW7ROSs9
 MdkNazio3241IXyyXnbqeVNAu+Ak2vC2nYRUTbQUb6drV7lD4BLWEv5FkdobmI/K+wuiu5ZYCLJm
 F6BOy4796CVyubhqkUE1cuZ1xmg6lJOzohpXS34KVUq+1OZ5WGHGAD7eYYW08ETu5fqBw9AIvQkU
 HoelB9UI1WjR/qStDkW2Kf9HJiyJC9//xKkJCm+z626+QKN6qkio5SdinrAXeEMn85JPUZaN7FuP
 LGUSQZl9e0QmC3F2jFZvxAn7ejLyYujfuZOSCTAcfobVWEdewpLHdefJOXzO8QtpH8hJJDzH6V0P
 BCQi2bBliiLEBA1XIWG95ksRVL2v27FbXyt5e8w74zoJpe94XXXo1nBEJfg7SvMSpRGfYHgq5FUE
 RRW9MNy8B+5tcWhdJ1WKNUoxnjPa06MgSb9lR4NzoaPEDKLrd3ccjfCu7BAyVjUeh8tdEGbDkx6L
 UY17bhndtYKKqZ8V8+fUXDZlpz5VkjZ8XUTZMRLf6XMlrOUMBHglQKgliBgNebJBLjtsEktmI3kr
 A=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/microblaze/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 9203192483..27283c5dc4 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -26,6 +26,7 @@
 #include "exec/target_page.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
+#include "qemu/plugin.h"
 
 #ifndef CONFIG_USER_ONLY
 static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
@@ -109,6 +110,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     CPUMBState *env = &cpu->env;
     uint32_t t, msr = mb_cpu_read_msr(env);
     bool set_esr;
+    uint64_t last_pc = env->pc;
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
@@ -213,6 +215,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
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
2.49.0


