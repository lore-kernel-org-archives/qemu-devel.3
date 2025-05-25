Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC5BC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7uc-0001jT-M6; Sun, 25 May 2025 05:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7uY-0001Rq-8X; Sun, 25 May 2025 05:44:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7uW-0004oq-7w; Sun, 25 May 2025 05:44:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A884124DEF;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4EB1215F17;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 61/62] linux-user/hppa: Send proper si_code on SIGFPE
 exception
Date: Sun, 25 May 2025 12:42:44 +0300
Message-Id: <20250525094246.174612-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Improve the linux-user emulation to send the correct si_code depending
on overflow (TARGET_FPE_FLTOVF), underflow (TARGET_FPE_FLTUND), ...
Note that the hardware stores the relevant flags in FP exception
register #1, which is actually the lower 32-bits of the 64-bit fr[0]
register in qemu.

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit b4b49cf39dba5f993ad925f204cb820aacfc8e45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 23b38ff9b2..13f18d79ab 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -112,7 +112,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
 void cpu_loop(CPUHPPAState *env)
 {
     CPUState *cs = env_cpu(env);
-    abi_ulong ret;
+    abi_ulong ret, si_code = 0;
     int trapnr;
 
     while (1) {
@@ -169,7 +169,15 @@ void cpu_loop(CPUHPPAState *env)
             force_sig_fault(TARGET_SIGFPE, TARGET_FPE_CONDTRAP, env->iaoq_f);
             break;
         case EXCP_ASSIST:
-            force_sig_fault(TARGET_SIGFPE, 0, env->iaoq_f);
+            #define set_si_code(mask, val) \
+                if (env->fr[0] & mask) { si_code = val; }
+            set_si_code(R_FPSR_FLG_I_MASK, TARGET_FPE_FLTRES);
+            set_si_code(R_FPSR_FLG_U_MASK, TARGET_FPE_FLTUND);
+            set_si_code(R_FPSR_FLG_O_MASK, TARGET_FPE_FLTOVF);
+            set_si_code(R_FPSR_FLG_Z_MASK, TARGET_FPE_FLTDIV);
+            set_si_code(R_FPSR_FLG_V_MASK, TARGET_FPE_FLTINV);
+            #undef set_si_code
+            force_sig_fault(TARGET_SIGFPE, si_code, env->iaoq_f);
             break;
         case EXCP_BREAK:
             force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->iaoq_f);
-- 
2.39.5


