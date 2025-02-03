Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073EBC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texnL-0003yO-Ve; Mon, 03 Feb 2025 09:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win>)
 id 1texnL-0003y1-1e
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:51:27 -0500
Received: from smtp.forwardemail.net ([149.28.215.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win>)
 id 1texnJ-0003ev-Co
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-257304d8b2; t=1738594283;
 bh=gUvwh0RgMZ3wKSGEks8B1WfeF+2/I/pFcs/U2KBAJ00=;
 b=GulDCRrW3Gnjf0vRT9i3szFAOesslg+2owSlMOI90sVPxeBsVfvUlrmFcn3MaPyIGshThU7sa
 Y30uEy/EYpvGcKjX6SXKk9yBgYpZODyNx6cJyBicU4BIOlNb87OTqOJvuCRN76ogDCJ0ANdzFmw
 25ExuMgDn2LQmvh/KpVi5sY=
X-Forward-Email-ID: 67a0d7e9514bf110fcaeeda0
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Mikael Szreder <git@miszr.win>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Mikael Szreder <git@miszr.win>
Subject: [PATCH] target/sparc: Fix gdbstub incorrectly handling registers
 f32-f62
Date: Mon,  3 Feb 2025 15:50:56 +0100
Message-ID: <20250203145056.83567-1-git@miszr.win>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=149.28.215.223;
 envelope-from=SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The gdbstub implementation for the Sparc architecture would incorectly
 calculate the the floating point register offset.
This would cause register pairs(eg f32,f33) to point to the same value.

Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
Signed-off-by: Mikael Szreder <git@miszr.win>
---
 target/sparc/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef..5578fa9813 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -80,7 +80,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     }
     if (n < 80) {
         /* f32-f62 (double width, even numbers only) */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
+        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
     }
     switch (n) {
     case 80:
@@ -174,7 +174,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 4;
     } else if (n < 80) {
         /* f32-f62 (double width, even numbers only) */
-        env->fpr[(n - 32) / 2].ll = tmp;
+        env->fpr[(n - 64) + 16].ll = tmp;
     } else {
         switch (n) {
         case 80:
-- 
2.48.1


