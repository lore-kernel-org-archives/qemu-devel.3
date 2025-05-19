Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14DAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IS-00070D-5r; Mon, 19 May 2025 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2II-0006vz-8f
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:46 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IA-0005UO-Mr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:45 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4384C180EA7
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:26 +0200 (CEST)
Received: (qmail 1537 invoked by uid 990); 19 May 2025 15:20:26 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:26 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v5 14/25] target/openrisc: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:54 +0200
Message-ID: <37da15321ffd8f3aa41ad2dadd591cc1f179feb1.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.998926) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.598926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=92gsDAb/F7BMOSszWmofaaZf2P8bUL8jYBMcs0mlQQY=;
 b=EtZe+BQNAi3YZyMhuzHVn1omoOpi2DAR1/ht3xdBTz5MIM4wfgkzdtVoDnDPy7kWYEjgrRoE/F
 B00pRXU1QKGjG3JOJ2rzHhWAeLyyYE1IAyZKE4pwfBHu8HUMlyUOeKy/8ePCFvGxvCPT4yer5uc0
 3pDTSBrGkJ+QdWvzy7KIIwJkLolo+2AkZY+pqNonVW/6Gg2TE0j4XZQu7/Yn92mNos38jbYxb1KP
 DAN6JEiVQCQtdzwGNy+dO3j71dSm8o4w64lHdZLvKbPkl8FAp6kR9Ue7AdE8/CbpFJSNdeX9XaDr
 k6WZFh9WY5cDKLk7goK0mXilKelMV7FC8LkmR7CyiSl1Jsa2u/0wKHqq9pNOuvf4ryJQkq9JyjVx
 gTuRt18mXZz22c+r5aey39Kbnv2FdkCGRLRmpVLpSVeEv5nP1QQGbfALfcKNO2Gz+8/9OVJOgWJG
 8trmWhKJyEsr+9pScM6fmE8j90lNC7U4Ch23Eho5n0m00e7nozOLBnwBcHyrGbzMmjreNGCIAZg3
 7C8XE83kRGlaoH1SbdvrfkmEdy2bLbjPZIHt0bYW733azTNdyYh/UHO/x9DHdmtE3LJv1FnS25Zd
 BKYr9Uo1pn56Q51YwSDuNh/W6h82j4J5xzqQpVmjqmo5vhh2Ip6acLwUMluOxPIvdde1qutA25Nd
 E=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

This change places hooks for OpenRISC targets. We treat anything other
than resets, timer and device interrupts as exceptions.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/openrisc/interrupt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 486823094c..08f0ed9b89 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -25,11 +25,13 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/loader.h"
 #endif
+#include "qemu/plugin.h"
 
 void openrisc_cpu_do_interrupt(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
     int exception = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     env->epcr = env->pc;
 
@@ -98,6 +100,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
     }
 
+    switch (exception) {
+    case EXCP_RESET:
+    case EXCP_TICK:
+    case EXCP_INT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     cs->exception_index = -1;
 }
 
-- 
2.49.0


