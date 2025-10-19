Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB7CCD19F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9M-00020p-Cw; Sun, 19 Oct 2025 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9K-00020B-AS
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:46 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9I-0003Cv-8p
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:45 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 35A0060A8A
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:43 +0200 (CEST)
Received: (qmail 23310 invoked by uid 990); 19 Oct 2025 15:16:43 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:41 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v8 13/25] target/mips: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:02 +0200
Message-ID: <90f894e51477495903fc0594e6957c6b2b5c8bc4.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ------
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999991) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1)
X-Rspamd-Score: -6.099991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=4QCLeRlIzG5ENUNvx1SoYVdpQIbTNKVldgdxK9RZn7c=;
 b=PI5oKy+VVVtUVXV9gjnjBNypei+5MFhWt7OpSvoZxjOA3OjnmdJDI4kD0xjNhX6kzUlyTX95Ag
 4X2SZpe9W1VaiYOUBUSLNmoaKTpyGIYg16kHyR5+Uh6axmKSQ2bcG20zgHe/xUzrSLsKbOXqh46E
 Zng4Db1J1tgKumD9XqDvgUa9Dw+kwc35O/s8vUOmoENolSZcTJSupWCcT116oute6n8YX2jFpe09
 OoifMq57GNa/vX8w3Pvf3uhSDD0pbatyvxbR5ZLzdb3lmkRpoOI8s5Kq0yXoNtAlmWAF2FtaKPwc
 Pxpzx3/9pdJUQmPhhTU8xqQFYhy1dL3SzsDg5SQub0bpDFIEIqPgMrOmX0QHcGlCtFMu/D5brIf3
 KHM0/AUkyVXW/Fn59n99pXCmfhuBYjlFjP3o4GgRGsP58Y7jNtXwwxsAFclRMR5mn2+v28nGtM8O
 GwUUk7K+bHATr7fTtg5DPhj8VODfrs3y/lHwPLJ1HfGXf+4eI9GzGMXGCHQlTkYqQkmSSNoQonER
 JU6C6iVezgr28jd6B3lVdWrZ882D9TWzeCTSC7rpq47RftRpULRVvnJFFFYjCYgFukBvjkEMBXq2
 I6dBdqlnqCp4BIs8xwqtrxZ81V7WHK/DJsDs+v15dSF7mB+dyrO5XZlwIcTGlWIsnYwWkr04kruH
 4=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

This change places hooks for MIPS targets. We consider the exceptions
NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
exceptions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


