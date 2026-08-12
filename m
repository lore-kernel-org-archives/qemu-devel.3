Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8CAC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhq-0007gX-0b; Wed, 12 Aug 2026 16:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhn-0007dT-RK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhm-0001Gb-FO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D69D9600AF;
 Wed, 12 Aug 2026 20:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DDE1F000E9;
 Wed, 12 Aug 2026 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567061;
 bh=dicr7kXHpKoGDmwM+D7ifwOf8SSs+dBKXD26tHCiMFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Suz+ewCooaxaEByR04MDrvYe/ffK9eT613QeB7sMoAb12/nPX3xxVQba906cpV8lA
 9cDm9YIfIUzTLJGabpSWlMFT+o1xCauuOG2hl/Mk68jKrYbYAzlW6PfHq5qoEANHZ8
 eh5JQeWCfwntGOp6JPi3oSyrZ40zUeyNQ39yHM7r45fYLD/zUx9NJ3awfoxUX5N8PD
 n1W44aIjH3ePWSjScINKhegI2WgDZCAAlBXSilwQ+hzGrG2or6qLsJbV5Ep/0prM5B
 x0cLePxFabT4aQYdQQ8ZLeivXOix3XDf+eLG53S0Aq0vlMvu6/GPGQWKHcQwSapKt+
 I6grWsYxR4p3g==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 7/7] linux-user/sh4: write the floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:25 +0200
Message-ID: <20260812203725.10694-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Write an NT_FPREGSET note for SH4, matching struct user_fpu_struct
from arch/sh/include/asm/user.h: fr0-fr15, xf0-xf15, fpscr, fpul.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/elfload.c    | 10 ++++++++++
 linux-user/sh4/target_elf.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index f03ce49e7d..41601626ca 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -52,6 +52,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     return hwcap;
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUSH4State *env)
+{
+    for (int i = 0; i < 16; i++) {
+        r->fpregs[i] = tswap32(env->fregs[i]);
+        r->xfpregs[i] = tswap32(env->fregs[16 + i]);
+    }
+    r->fpscr = tswap32(env->fpscr);
+    r->fpul = tswap32(env->fpul);
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
     for (int i = 0; i < 16; i++) {
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index 3fcb63d409..5923022036 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -25,4 +25,16 @@ typedef struct target_elf_gregset_t {
     struct target_pt_regs pt;
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches struct user_fpu_struct from arch/sh/include/asm/user.h.
+ */
+typedef struct target_elf_fpregset_t {
+    uint32_t fpregs[16];
+    uint32_t xfpregs[16];
+    uint32_t fpscr;
+    uint32_t fpul;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


