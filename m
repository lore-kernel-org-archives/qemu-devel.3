Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A01CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGsA-0003X0-7F; Thu, 04 Sep 2025 16:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGs5-0003Up-ON
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:54 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGru-0000jl-Fu
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:53 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 0EDFF60C25
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:23 +0200 (CEST)
Received: (qmail 32695 invoked by uid 990); 4 Sep 2025 20:47:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:22 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v6 13/25] target/mips: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:50 +0200
Message-ID: <f3896fee60c263aaa4890094ec0d1acc39da8595.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999457) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=OlzwuS+WIxAXgxczYmiujNr+qRwzPT++tEanqWOCdss=;
 b=ZD8NYTi7AtXcoScJ9i8MdXgh/bbe2TJuvLnwA0JZxTf7WRsOKZgMsq/4NmqPh90QD7iBea74Gj
 NN1NZyGL5rXXzWyvjNFj8ngTCq+/ANPn/deYt4io3HJyXwmhCAEmutzcO65STpszUsyTSHUdSBVb
 IyGZxnvOkE16xHgXKUkhvaVHxH1vH3kFtoxbA5+/uXFijG8/mceRqCJo7hmbWbT4Galcz2tCg+5n
 lTCZ9U/LZygWCp6azZsIduwnhXt1d0k2dfggLQzAlSlHE8PQI4CCBrOAhEJyknCGKi3ycaqn7TzG
 zEjP/TKl/BPrGrYw3defH765ylh4OnhJWzXagCxCJOMEi5Fa0+83OaMxcZb6/tRTJ6iDqH7XbPGP
 aU7t+NfNB6z4+3WPdD8CKHeem4NOyO8vxruh9b2Odm0KFdPVPa8WfrLiGUFm6npOcvQR9MewUoHY
 h1HxBbn2eHVioPqukiTlIX3dowofY5kC8/wW30EEXwZVwaUUuo1+H8lu+eWdCp081hNnkifoNd0a
 fjQFVNkpH39hOZhaldiSP/u9ZrUsLmQiGX4xgfgo813XPX3lWOu5Wa0sogN9ggbtDtZwRt/vwCHF
 ypCf1D5246WlZUaYhyt1feDiEx/RZYbZzcDupPUaxi1i+AszntZz4+D8bKF+HXjEwQV3hf/v7hcJ
 Q=
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

This change places hooks for MIPS targets. We consider the exceptions
NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
exceptions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 1e8901556d..566924b079 100644
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
2.49.1


