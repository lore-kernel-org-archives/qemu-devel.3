Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212BECD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8jk-0006aw-3V; Sun, 24 May 2026 09:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8ji-0006am-Mr
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:22 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jh-0005aV-9L
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C0E0600AE;
 Sun, 24 May 2026 13:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E91F000E9;
 Sun, 24 May 2026 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628760;
 bh=53stOSPzY4yCMB1+R3XmVCXAcTk/eugwWFbVqsrGjYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QGfnkduHbymEOrRqDyZn6b3oIM02JD+UywPTicCP0lcuaUbu+dqYxuYpjjGyt3h0U
 NIS//f2t/GniqKQW0TNbPrn81p4rNAzT+W0IPPv/SByobfm8belfh6KqQ9P4JWHFHK
 dFnWfrWxjj3iZ20TumFCqmdx1bfUMNUnR5suwKGYN4YD2GX52ca5Cuh3tRImApVOTI
 FaItXtPUAPI658oQx59Pdlqmvzqv8/dj6Ybr5iLA3qlFM4cWfJTXIJ/q+IIbJQYfMb
 jisolk5I6EvPJEVenZRGUthzyFHO8NrRqsrve4P96ikg4+HdlNrMNEtatOTizsHxaI
 WEuR7AEP/31BA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/6] linux-user/mips: use tswap32 in elf_core_copy_regs
Date: Sun, 24 May 2026 15:19:06 +0200
Message-ID: <20260524131909.162990-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matt Turner <mattst88@gmail.com>

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips/elfload.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 1a46e180cf..ce2c4514f3 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -135,16 +135,16 @@ const char *get_elf_base_platform(CPUState *cs)
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        r->pt.regs[i] = tswapl(env->active_tc.gpr[i]);
+        r->pt.regs[i] = tswap32(env->active_tc.gpr[i]);
     }
 
     r->pt.regs[26] = 0;
     r->pt.regs[27] = 0;
-    r->pt.lo = tswapl(env->active_tc.LO[0]);
-    r->pt.hi = tswapl(env->active_tc.HI[0]);
-    r->pt.cp0_epc = tswapl(env->active_tc.PC);
-    r->pt.cp0_badvaddr = tswapl(env->CP0_BadVAddr);
-    r->pt.cp0_status = tswapl(env->CP0_Status);
-    r->pt.cp0_cause = tswapl(env->CP0_Cause);
+    r->pt.lo = tswap32(env->active_tc.LO[0]);
+    r->pt.hi = tswap32(env->active_tc.HI[0]);
+    r->pt.cp0_epc = tswap32(env->active_tc.PC);
+    r->pt.cp0_badvaddr = tswap32(env->CP0_BadVAddr);
+    r->pt.cp0_status = tswap32(env->CP0_Status);
+    r->pt.cp0_cause = tswap32(env->CP0_Cause);
 }
 #endif
-- 
2.54.0


