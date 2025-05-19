Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FB2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2II-0006vg-0Y; Mon, 19 May 2025 11:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IF-0006ur-8F
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:43 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I9-0005Ty-8C
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:42 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 02663180EA5
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:26 +0200 (CEST)
Received: (qmail 1522 invoked by uid 990); 19 May 2025 15:20:25 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:25 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v5 13/25] target/mips: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:53 +0200
Message-ID: <7e602c496a873fd55713eab740543683b69c98eb.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999338) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=gF8ZpJS8y9Bbk8U6lfy6v84ed6luIVNRS7iWh3mugkA=;
 b=hCLggOgeqbceKTwet6LKHJpsaY+ahwjZgqG61Z/jzZXnq39ycvAoNpIiDGXg+3fVhPEDqlvYO6
 F/Es5gee1Ntb0HVLrZbaScFM7CSPhxHDUhn5f4WKCrs7gUMOQDf2fWrGOZXcd+mBTz3fGCt3K+MG
 WncSHD0WQdlS2vK3F9YGqKVsutR3UypXWxlX260L8e2ShfPCBXO6dSjOlSf4LyYftwYCtW2Ew5ln
 k6L+SQ/powH8x6P2mdaHaJWNTDUm1ESvYP7ih9p78hmawz7iKQHNZ77zoqU03jJeskNf0l6cjMZY
 dbjfOdrmk6itaxFU4Dbp/3cUzi4bQNpLMFqrvejYitSKoxEIP0Q857kLMhkjcdH1L6eZ8ehyM9f0
 03d4qYuljZsuQHaQqP805Ba6OY2P82oFpp/02rXQLmBZXDgqYewQQABMsKeCy6l3bUXjv2kFg+X2
 7S4CedCaJfGgs9D6syPsLICUE1E68CTR0LkjBji7pVqGlnNR8bvBZHMT1SJbYt0PUrQExyVQqop/
 WNqSL+c96a5YCg0+KrUrEYcC3i9Y5idn8EKV1rXSeuiCfNVFY0DhLofWP5DNewru0TF8QOVbi0iC
 1ll7foVAS+dpUp+U/JzQifGDloTk4PZ7SpWZD2/whTJFOlwpXLK/edbpBpgjdkYcQRSbQ2Hvi1Ty
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

This change places hooks for MIPS targets. We consider the exceptions
NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
exceptions.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index eccaf3624c..abc4d9fef0 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 
 #include "cpu.h"
 #include "internal.h"
@@ -1034,6 +1035,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     bool update_badinstr = 0;
     target_ulong offset;
     int cause = -1;
+    uint64_t last_pc = env->active_tc.PC;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && cs->exception_index != EXCP_EXT_INTERRUPT) {
@@ -1052,6 +1054,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         cs->exception_index = EXCP_NONE;
         mips_semihosting(env);
         env->active_tc.PC += env->error_code;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_DSS:
         env->CP0_Debug |= 1 << CP0DB_DSS;
@@ -1336,6 +1339,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
                  env->CP0_Status, env->CP0_Cause, env->CP0_BadVAddr,
                  env->CP0_DEPC);
     }
+    switch (cs->exception_index) {
+    case EXCP_NMI:
+    case EXCP_EXT_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
     cs->exception_index = EXCP_NONE;
 }
 
-- 
2.49.0


