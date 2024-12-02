Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1266CE69E88
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC56-0005lE-D2; Mon, 02 Dec 2024 14:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4u-0005jW-Qn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:29 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4s-0001xs-8i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:27 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 9BC911813A1
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:14 +0100 (CET)
Received: (qmail 7226 invoked by uid 990); 2 Dec 2024 19:27:14 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:14 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [RFC PATCH v3 08/11] target/mips: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:26:49 +0100
Message-ID: <5a165b308d75718e185806607df583596270181d.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.996924) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.596924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=G/yQbucoo3BelvfnOkzi6vySBLKkOgQVCeL/JBJq6fE=;
 b=E0lpN0r8ej55GoeN4hA2gPFBKwaX8gsPLd87N3F7+7pZsvxfbb3LCwJ4ppCogJIxRO9V4p6j0N
 psM0WACp0VdYpr3JglN1eWymPHtgzwAcard//031dZPcZoCQ07giptwhnjj0EiMrZM1tMIbPxMcO
 GJ5EWcC66yI5o5WLVkJAspj1kTO9NcSz699daxmD7LNU2GarJIetAKZV7Z2RfEYi2a3Nhb+ft9cs
 252Ua/QouPqjr1tNaGtnyO+hAVHvXmyrMPgLs03Jg/40O2QpcePNNBLIos8XnO8lJUtHHvk2k8P0
 sKxIbHOWa0HM+v/QTgQksaCYqw3UtU0jMu7zEdVTSEir/ObtfDa8u3NUUhOMRMXm1wVkmY2JWG+a
 bszGhgl74/quRt2tUBgC8vxYM0LESQVyqWa/bwQbtbSLcc0y2YLDOp7S77TT5bgn6lxThRsDRDMz
 tjIZSm1H9lJg1Zh7IS4nrVFcRA1XQGjhDcPvhkys8743ZpJ4107iXA8hx4xeuN95yo2QfhLpZS0K
 8ju8qNN4sThDprCkHum+eo4bC0W4yYE2NmTtDQ566KnwctLqYEuubIJd0OdomrsLcjpFdTvsgFMw
 ssr9uoidTWdFFEI/kAPZhLNZOAsJ/k631WvNowtyBoFZQVXcO2H55RasN5Dx8Li4OnG4w7SlLRJ6
 o=
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

This change places hooks for MIPS targets.
---
 target/mips/tcg/sysemu/tlb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e98bb95951..2b19975d53 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 
 #include "cpu.h"
 #include "internal.h"
@@ -1033,6 +1034,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     bool update_badinstr = 0;
     target_ulong offset;
     int cause = -1;
+    uint64_t last_pc = env->active_tc.PC;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && cs->exception_index != EXCP_EXT_INTERRUPT) {
@@ -1051,6 +1053,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         cs->exception_index = EXCP_NONE;
         mips_semihosting(env);
         env->active_tc.PC += env->error_code;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->active_tc.PC);
         return;
     case EXCP_DSS:
         env->CP0_Debug |= 1 << CP0DB_DSS;
@@ -1335,6 +1338,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
                  env->CP0_Status, env->CP0_Cause, env->CP0_BadVAddr,
                  env->CP0_DEPC);
     }
+    switch (cs->exception_index) {
+    case EXCP_NMI:
+    case EXCP_EXT_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->active_tc.PC);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->active_tc.PC);
+    }
     cs->exception_index = EXCP_NONE;
 }
 
-- 
2.45.2


