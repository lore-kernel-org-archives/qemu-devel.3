Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250EEC4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xh-00068L-Vi; Sun, 11 Feb 2024 07:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xe-00067E-AA
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xa-0006F8-4c
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 144D560C55;
 Sun, 11 Feb 2024 12:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D69C43390;
 Sun, 11 Feb 2024 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654556;
 bh=7qAJa6D5seczT2BjZtyKXdtgQQtPHSe7FBlQvtuMc80=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ifwv/5ELJWXvSE/S90wBR28h0NrRJxQSrIBx4cqgFtMNMP9LzgnJh4MQsE9R7ucDM
 lTq3U96OtbF+0HVTyYGlGKg0RlRhyP+0Xsm6/4QZQnel10tN5SuF6+UTj+nADhaksp
 8Zw+CNalGYpA+CSOGPSWWxLDbUtj6IovDSR4kQlqv2J8mS6dL9upNer7wHDv1PzQN4
 wdI14V8tQlEYnQt1wKWa/BZ42FIz8hz/NMi4r7IRii2Qk6R3fuxFzXe+1PoAl0YGor
 JEYfbmv4rOl5P+AW016E+RlRua1Fhr+qfEIgvSoiD/FldoerhN8QOLe992UmF3jEZj
 4IiVgfjnflqUQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 02/12] target/hppa: Add "diag 0x101" for console output support
Date: Sun, 11 Feb 2024 13:28:59 +0100
Message-ID: <20240211122909.5807-3-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

For debugging purposes at the early stage of the bootup process,
the SeaBIOS-hppa firmware sometimes needs to output characters to the
serial console. Note that the serial console is the default output
method for parisc machines.

At this stage PCI busses and other devices haven't been initialized
yet. So, SeaBIOS-hppa will not be able to find the correct I/O ports
for the serial ports yet.

Instead, add an emulation for the "diag 0x101" opcode to assist here.
Without any other dependencies, SeaBIOS-hppa can then load the character
to be printed in register %r26 and issue the diag assembly instruction.

The qemu diag_console_output() helper function will then print
that character to the first serial port.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 +
 target/hppa/sys_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c  |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 20698f68ed..1bdbcd8f98 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -103,4 +103,5 @@ DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tl, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_1(diag_btlb, void, env)
+DEF_HELPER_1(diag_console_output, void, env)
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index a59245eed3..4a31748342 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -23,6 +23,8 @@
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "chardev/char-fe.h"
 
 void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 {
@@ -109,3 +111,37 @@ void HELPER(rfi_r)(CPUHPPAState *env)
     helper_getshadowregs(env);
     helper_rfi(env);
 }
+
+#ifndef CONFIG_USER_ONLY
+/*
+ * diag_console_output() is a helper function used during the initial bootup
+ * process of the SeaBIOS-hppa firmware.  During the bootup phase, addresses of
+ * serial ports on e.g. PCI busses are unknown and most other devices haven't
+ * been initialized and configured yet.  With help of a simple "diag" assembler
+ * instruction and an ASCII character code in register %r26 firmware can easily
+ * print debug output without any dependencies to the first serial port and use
+ * that as serial console.
+ */
+void HELPER(diag_console_output)(CPUHPPAState *env)
+{
+    CharBackend *serial_backend;
+    Chardev *serial_port;
+    unsigned char c;
+
+    /* find first serial port */
+    serial_port = serial_hd(0);
+    if (!serial_port) {
+        return;
+    }
+
+    /* get serial_backend for the serial port */
+    serial_backend = serial_port->be;
+    if (!serial_backend ||
+        !qemu_chr_fe_backend_connected(serial_backend)) {
+        return;
+    }
+
+    c = (unsigned char)env->gr[26];
+    qemu_chr_fe_write(serial_backend, &c, sizeof(c));
+}
+#endif
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 08d09d50d7..53ec57ee86 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4411,6 +4411,12 @@ static bool trans_diag(DisasContext *ctx, arg_diag *a)
         gen_helper_diag_btlb(tcg_env);
         return nullify_end(ctx);
     }
+    if (a->i == 0x101) {
+        /* print char in %r26 to first serial console, used by SeaBIOS-hppa */
+        nullify_over(ctx);
+        gen_helper_diag_console_output(tcg_env);
+        return nullify_end(ctx);
+    }
 #endif
     qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
     return true;
-- 
2.43.0


