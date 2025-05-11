Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C6FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WL-0006kb-UY; Sun, 11 May 2025 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WG-0006Tk-38
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:04 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WD-0006q1-Dq
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:03 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id C4B83180015
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:49 +0200 (CEST)
Received: (qmail 26068 invoked by uid 990); 11 May 2025 13:14:49 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:49 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v4 12/23] target/microblaze: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:04 +0200
Message-ID: <0c84a3b15a4272e61efa98a834c0252a5db02c06.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99848) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=mYTOuQ7uLH2zInBP9Ap2kCAJ9tif03ZHga/PRE+sxLo=;
 b=iWC+PlZeiZ+ymP0tcT7MYjVIo/E4E3NlgJRMy3myOegUqjhVBqaDOZi9efmvZZm1bvey6UwUV9
 mGn6R5r1qj8CD/OQa1/och5h3exGkIM4Do91KRrAZlMJh7ZlFYshbYl+TOIvlME5A15G2VaFl52O
 3IXkEQz7afUfY7jfO81zG+aVkg2sPSLIN2e/0dEaeWX/RPzPmUia83J2Dtw3+neG5QXczINr+Vcd
 S8IZSFU87QDsQy3HkyZoqwS1+ilwIKWqHUYyvG+crEJ47Zg+q4DlXqhNtoqYP+9f/bx9cpSlUkjx
 ufcIGbapYhcYFm1DW4Tj65EjFPG8JMWU8SLkibjcl7aAgM9cP+JX04wyBtrygqwbX1vIG7xuUJNb
 EwUyGDqwngQM8cvhPRj9Ex/tPgglg2twN9II3pjaDhmRJ8AxzgWIuX9kj/hwe+fuVAIaI3kwo+FT
 bWyaFykTnhVhOM5f8MdEFvZhUPjssIrzqLcf61mKXr25Lpu8giJxe0FVo3GjLM2TA/8Cjb9Gr3wJ
 JON24cShOFtzPZcIIuZO5BobgUAez4NXolWkMIYlPzFzJJgoAZXLT2//xEk2EjiFUH48gf2AZMUF
 cnQtNlFJC+mmdTWypvt43ym3XZrs36rK7ukg+KNJuVkv8wXE379ZN4EOXVvCPnQdu6xSnJ/NwclT
 k=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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


