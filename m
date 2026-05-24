Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212FECD5BC7
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8je-0006ZN-7z; Sun, 24 May 2026 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jd-0006Z3-7b
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jb-0005Xc-Ip
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8776E41A8C;
 Sun, 24 May 2026 13:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087C71F000E9;
 Sun, 24 May 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628754;
 bh=onghrVOPoumr7ZF+G1gVbfqOC70FeH6HaXRyKPpvS2g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UJ6wi9ebliFQ0Nn2qo5EkrwM9TvJra24ZTadSwvVYupXTJ9yZlAC2Ofet4voocx7T
 rvY+jIUES20bldJwv03QpDQgUWIktjmOdCJ4dKG3AJzCR19tScLWCAz7lk4OzaJpRc
 apX4BYhMwu6uqui/Ui8DHaTsFwCwGMBIxjq/ZFf8v5CLHsxBWP1cyN0SsIAmjEhmtA
 ccXQAw0Pg+pQXsGlzOm4AliZFYXS5LtR5D6mfAoedp23zkOjUwNl3Gs9HG0pmzmQlg
 I/uNsPEwhzw1D16MkMUyVLHxZGVralNYMX0F4NpcG5thniZn9m8+8mqjNEnNtTogf4
 QJyDg3niCaYow==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/6] linux-user/hppa: add coredump support
Date: Sun, 24 May 2026 15:19:03 +0200
Message-ID: <20260524131909.162990-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

Add HAVE_ELF_CORE_DUMP, target_elf_gregset_t (80 entries matching
arch/parisc/include/uapi/asm/ptrace.h), and elf_core_copy_regs().

The struct layout matches the kernel's struct user_regs_struct:
  gr[0..31]    at indices [0..31]   (PSW in gr[0])
  sr[0..7]     at indices [32..39]
  iaoq[0..1]   at indices [40..41]  (instruction address queue)
  iasq[0..1]   at indices [42..43]
  sar          at index   [44]      (shift amount / CR11)
  iir          at index   [45]      (interrupt instruction register)
  isr          at index   [46]      (interrupt space register)
  ior          at index   [47]      (interrupt offset register)
  ipsw         at index   [48]      (interrupt PSW / CR22)
  cr0          at index   [49]      (recovery counter)
  cr24_31[8]   at indices [50..57]
  cr8_15[6]    at indices [58..63]
  pad[16]      at indices [64..79]

elf_core_copy_regs() saves GRs, IAOQ (front/back), and SAR.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/hppa/elfload.c    | 13 +++++++++++++
 linux-user/hppa/target_elf.h | 21 +++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 7f7ece6dc1..3354e1b840 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -16,6 +16,19 @@ const char *get_elf_platform(CPUState *cs)
     return "PARISC";
 }
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
+{
+    int i;
+
+    memset(r, 0, sizeof(*r));
+    for (i = 0; i < 32; i++) {
+        r->gr[i] = tswapal(env->gr[i]);
+    }
+    r->iaoq[0] = tswapal(env->iaoq_f);
+    r->iaoq[1] = tswapal(env->iaoq_b);
+    r->sar     = tswapal(env->cr[CR_SAR]);
+}
+
 bool init_guest_commpage(void)
 {
     /* If reserved_va, then we have already mapped 0 page on the host. */
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 76930c9369..e1c5033242 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -12,6 +12,27 @@
 #define ELF_MACHINE             EM_PARISC
 
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches struct user_regs_struct from arch/parisc/include/uapi/asm/ptrace.h.
+ * ELF_NGREG = 80; register indices match those used by libunwind and gdb.
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong gr[32];      /* gr[0..31]; PSW in gr[0]            [0..31] */
+    abi_ulong sr[8];       /* space registers                    [32..39] */
+    abi_ulong iaoq[2];     /* instruction address offset         [40..41] */
+    abi_ulong iasq[2];     /* instruction address space          [42..43] */
+    abi_ulong sar;         /* shift amount register (CR11)       [44] */
+    abi_ulong iir;         /* interrupt instruction register     [45] */
+    abi_ulong isr;         /* interrupt space register           [46] */
+    abi_ulong ior;         /* interrupt offset register          [47] */
+    abi_ulong ipsw;        /* interrupt PSW (CR22)               [48] */
+    abi_ulong cr0;         /* recovery counter                   [49] */
+    abi_ulong cr24_31[8];  /* cr24..cr31                         [50..57] */
+    abi_ulong cr8_15[6];   /* cr8, cr9, cr12, cr13, cr10, cr15  [58..63] */
+    abi_ulong pad[16];     /* pad to 80 elements                 [64..79] */
+} target_elf_gregset_t;
 
 #define LO_COMMPAGE             0
 #define STACK_GROWS_DOWN        0
-- 
2.54.0


