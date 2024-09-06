Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F450CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX0o-0005IL-QT; Fri, 06 Sep 2024 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX0S-00042E-G5; Fri, 06 Sep 2024 07:20:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX0Q-0008Px-Nb; Fri, 06 Sep 2024 07:20:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02F898C4B6;
 Fri,  6 Sep 2024 14:12:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0E95413371F;
 Fri,  6 Sep 2024 14:13:29 +0300 (MSK)
Received: (nullmailer pid 353772 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 69/69] target/hppa: Fix PSW V-bit packaging in
 cpu_hppa_get for hppa64
Date: Fri,  6 Sep 2024 14:13:18 +0300
Message-Id: <20240906111324.353230-69-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While adding hppa64 support, the psw_v variable got extended from 32 to 64
bits.  So, when packaging the PSW-V bit from the psw_v variable for interrupt
processing, check bit 31 instead the 63th (sign) bit.

This fixes a hard to find Linux kernel boot issue where the loss of the PSW-V
bit due to an ITLB interruption in the middle of a series of ds/addc
instructions (from the divU milicode library) generated the wrong division
result and thus triggered a Linux kernel crash.

Link: https://lore.kernel.org/lkml/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: qemu-stable@nongnu.org # v8.2+
(cherry picked from commit ead5078cf1a5f11d16e3e8462154c859620bcc7e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in target/hppa/helper.c due to lack of
 v9.0.0-688-gebc9401a4067 "target/hppa: Split PSW X and B into their own field")

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a072d0bb63..9c42431d72 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -188,7 +188,7 @@ typedef struct CPUArchState {
 
     target_ulong psw;        /* All psw bits except the following:  */
     target_ulong psw_n;      /* boolean */
-    target_long psw_v;       /* in most significant bit */
+    target_long psw_v;       /* in bit 31 */
 
     /* Splitting the carry-borrow field into the MSB and "the rest", allows
      * for "the rest" to be deleted when it is unused, but the MSB is in use.
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 9d217d051c..6c14994921 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     }
 
     psw |= env->psw_n * PSW_N;
-    psw |= (env->psw_v < 0) * PSW_V;
+    psw |= ((env->psw_v >> 31) & 1) * PSW_V;
     psw |= env->psw;
 
     return psw;
-- 
2.39.2


