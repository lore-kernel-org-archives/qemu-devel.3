Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82768C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhn-0007aL-B7; Wed, 12 Aug 2026 16:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhk-0007Tm-DA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:40 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhi-0001FD-Sw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:40 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 018A043D16;
 Wed, 12 Aug 2026 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712121F000E9;
 Wed, 12 Aug 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567057;
 bh=b1gjecfvURvkgSi1nzn8dMG1W4cgP5DdTO5dvb8Q3ZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RvApI3vznDrY/f5yxclAA+tvuyepxu/Mqp57EeMwhXJENktKjHp0eeFdYcV7ac79w
 0GSPGL3sZJea5gPxg2uZIU6GtEM7sz6VwyA3+vvlHwPzYMZUmaBRqWlDK5RDGOUA7F
 5WXBecJtjGMrJfcVXITJQ/fwFjMsq0ZEoRF5VNR31sId6HdHA1OBvgLh8vbIS5DsjD
 z8dHmbnbjAtnxwAayJPdimS4gphl6vxwuYCiFXLNPtHSJoaV2LD5uU8Nyx43xdG7h9
 mEYlTPi9Qq7sTeLXiRtndqTOOgADPp2D9Iddtf3/NYhhlFgQ4aTe/co6oMw0ZGCJ6A
 X5CSOWXHc5h5w==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 5/7] linux-user/hppa: write the floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:23 +0200
Message-ID: <20260812203725.10694-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

Write an NT_FPREGSET note for HPPA, matching the kernel's
elf_fpregset_t layout (ELF_NFPREG = 32): fr0-fr31 as 64-bit values.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/hppa/elfload.c    | 7 +++++++
 linux-user/hppa/target_elf.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index ff4301b2ed..dd5b0b380e 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -17,6 +17,13 @@ const char *get_elf_platform(CPUState *cs)
     return "PARISC";
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUArchState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->fr[i]);
+    }
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
 {
     int i;
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 22547b1437..4357873aff 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -39,4 +39,13 @@ typedef struct target_elf_gregset_t {
 #define STACK_ALIGNMENT         64
 #define VDSO_HEADER             "vdso.c.inc"
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 32): fr0-fr31.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


