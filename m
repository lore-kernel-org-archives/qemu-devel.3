Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E826C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI13F-0007Vx-6T; Thu, 22 May 2025 04:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI13A-0007UY-Pq
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:12 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI138-0003Nu-Bw
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A497EA4BDFE;
 Thu, 22 May 2025 08:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B13C4CEE4;
 Thu, 22 May 2025 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747901588;
 bh=mH6lWprZNCprzCYvb030arSxaYfC8yISrfaAKMY3jr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s5K1pbSKi6aRhlFXDxm6yvh3ExHVlD7+JLXo4kHbTcuc0BU51nPVHpsV4lXsD1hbM
 JFMVBFqD4T/YFgYkkke3XCs6nKdXP5XrpXSAn9BSi31nOGvin5leQRyRsNp8HHVXUY
 ljkF/zVda/yMozcdMS+NPMh3LERSG73XgMpfdixR803FV5lOXhdVFy7oUD4GL+Dx6W
 xrQqvnxxEOawJExAbXI5wdPStTMSQJ0CfxXGtmOEDw5h04KKXhs991AAJ7Z/mGfyhw
 gTjGm8pM3tgEoDQTi8w42b/p7aaH/hU8buUTlJLwyJZaKPa0V9zyc48bxU5TFy58bt
 MESdky+2KnQsA==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 2/3] linux-user/hppa: Send proper si_code on SIGFPE exception
Date: Thu, 22 May 2025 10:12:56 +0200
Message-ID: <20250522081257.3409-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250522081257.3409-1-deller@kernel.org>
References: <20250522081257.3409-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 linux-user/hppa/cpu_loop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 890e758cd1..9abaad5ef8 100644
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
2.47.0


