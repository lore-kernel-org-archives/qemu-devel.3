Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13355C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 09:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttNbu-0002pb-Jk; Sat, 15 Mar 2025 05:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbf-0002du-9N; Sat, 15 Mar 2025 05:14:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbc-0007l2-3M; Sat, 15 Mar 2025 05:14:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE593FFBB5;
 Sat, 15 Mar 2025 12:13:45 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6B911CAD4E;
 Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9C49055A32; Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikael Szreder <git@miszr.win>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 04/27] target/sparc: Fix gdbstub incorrectly handling
 registers f32-f62
Date: Sat, 15 Mar 2025 12:14:15 +0300
Message-Id: <20250315091439.657371-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Mikael Szreder <git@miszr.win>

The gdbstub implementation for the Sparc architecture would
incorrectly calculate the the floating point register offset.
This resulted in, for example, registers f32 and f34 to point to
the same value.

The issue was caused by the confusion between even register numbers
and even register indexes. For example, the register index of f32 is 64
and f34 is 65.

Cc: qemu-stable@nongnu.org
Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
Signed-off-by: Mikael Szreder <git@miszr.win>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250214070343.11501-1-git@miszr.win>
(cherry picked from commit 7a74e468089a58756b438d31a2a9a97f183780d7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 5d1e808e8c..2bbc494d81 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -80,8 +80,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
     }
     if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
     }
     switch (n) {
     case 80:
@@ -174,8 +179,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         return 4;
     } else if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        env->fpr[(n - 32) / 2].ll = tmp;
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        env->fpr[(n - 64) + 16].ll = tmp;
     } else {
         switch (n) {
         case 80:
-- 
2.39.5


