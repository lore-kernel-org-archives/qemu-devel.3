Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA3C5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhl-0007U5-9b; Wed, 12 Aug 2026 16:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhj-0007S4-0n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:39 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhh-0001Ee-6M
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:38 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C26B41FEF;
 Wed, 12 Aug 2026 20:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1231F000E9;
 Wed, 12 Aug 2026 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567054;
 bh=ML/9EklhVG178lADzV1R1N47WRV27fg9z6lhzVxQorI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HVaxFSlQirX5Nu445Pc6el51L47g3qsmk18CRmDFpObXA0JnakLublNSkAO3v7Mho
 xaSaoCoGk2a4bwqBS1D8zXwzgJeLXTQq4onLUgbWtEY+0DaDxcDMtPkOQs109lNROP
 u0+I5qyJh17DYoTXJ9NzcuRC/dJSlzwTHXNzA67sJUZ81zOKJQ5EbQrB61JhAQWSO5
 pwOIbz0gcysM6iRBBn2bzhmmrKHr5PXBF9iQcIzI9BgCYrDirUrnW9ccAZy2KdP/ZR
 C+sCpf7BNXyUPwvZ5gGdaxSX3DDFwLbzhwPUBhh3rN8j0kBKfPzddKgmgHKO5d/B/r
 0+C17OGde7Q+Q==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 3/7] linux-user/alpha: write the floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:21 +0200
Message-ID: <20260812203725.10694-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

A guest core carried only the general-purpose registers, so a debugger
opening one reported every floating-point register as unavailable --
including the arguments of the function that crashed.

Implement HAVE_ELF_CORE_FPREGS for Alpha: define target_elf_fpregset_t
to match the kernel's layout ($f0-$f30 plus the control register in the
slot $f31 would occupy) and fill it from elf_core_copy_fpregs().

Checked with lldb on a core from a program that faults with live values
in $f16 and $f17: both read back correctly, as does the control register.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/alpha/elfload.c    | 10 ++++++++++
 linux-user/alpha/target_elf.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 7be9e466b6..c2517516ad 100644
--- a/linux-user/alpha/elfload.c
+++ b/linux-user/alpha/elfload.c
@@ -32,3 +32,13 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "ev67";
 }
+
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUAlphaState *env)
+{
+    int i;
+
+    for (i = 0; i < 31; i++) {
+        r->fpr[i] = tswap64(env->fir[i]);
+    }
+    r->fpcr = tswap64(cpu_alpha_load_fpcr((CPUAlphaState *)env));
+}
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index dd90c6f783..5efe7f3174 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -19,6 +19,17 @@
  *   r0-r30 at indices 0-30, pc at 31, ps at 32.
  * r31 (hardwired zero) is not stored; pc occupies index 31.
  */
+/*
+ * The floating-point note holds $f0 through $f30 and then the control
+ * register in the slot $f31 would occupy; $f31 reads as zero.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[31];    /* $f0-$f30 */
+    uint64_t fpcr;       /* the slot for $f31 */
+} target_elf_fpregset_t;
+
 typedef struct target_elf_gregset_t {
     abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
     abi_ulong pc;        /* program counter           [31]    */
-- 
2.54.0


