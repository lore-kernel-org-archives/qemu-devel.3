Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21414C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 07:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tipkM-0006mC-VD; Fri, 14 Feb 2025 02:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tipkL-0006lK-7m
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 02:04:21 -0500
Received: from smtp.forwardemail.net ([149.28.215.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tipkJ-0001AE-8x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 02:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-257304d8b2; t=1739516658;
 bh=zT8diQUURgdIJgjQnriXhC653AD7d39Of5taPLgOoro=;
 b=Flz2Li8i0KUCmxkRzq3W7OJG+HmPUwSiAXX5w+mq9TvRy1fpoixpiNwVsW9FGE43ut7PvcMr9
 tHYNJmBLwuxatB+iPRQ9+ivCtxs8t794+sw7oYCwyjR4vYRXwkwsEb5K/NkBkT12eXpygeltSB0
 T5lzAajwlnjuqpq1/EFyJ2E=
X-Forward-Email-ID: 67aeeaedb8354098fb49d511
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Mikael Szreder <git@miszr.win>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mikael Szreder <git@miszr.win>
Subject: [PATCH v2] target/sparc: Fix gdbstub incorrectly handling registers
 f32-f62
Date: Fri, 14 Feb 2025 08:03:43 +0100
Message-ID: <20250214070343.11501-1-git@miszr.win>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=149.28.215.223;
 envelope-from=SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM14=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The gdbstub implementation for the Sparc architecture would
incorrectly calculate the the floating point register offset.
This resulted in, for example, registers f32 and f34 to point to
the same value.

The issue was caused by the confusion between even register numbers
and even register indexes. For example, the register index of f32 is 64
and f34 is 65.

Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
Signed-off-by: Mikael Szreder <git@miszr.win>
---
 target/sparc/gdbstub.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef..134617fb23 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -79,8 +79,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
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
@@ -173,8 +178,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
2.48.1


