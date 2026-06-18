Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B27CD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa83S-0007NM-5G; Thu, 18 Jun 2026 04:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wa83Q-0007N7-K7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:24:52 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wa83O-0007Jx-PU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781771070;
 bh=BQwNv/IW6Xp9zpFDvysADuQmwzDnxneMEJ6If4fKsxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JzB7koNNm12f5CSoUPm1r3HrnHijMdYi6rERZKkvdjv+OBh0tocMM7ByN3srpjl4P
 7EQm3a0ZE05TukfWSHDfgDRMT0zmh4onPMuWVqdu+S3b8dETClWuqpPFppU24taY3j
 Dl7gv8EzgoMnbcFJkwLfA6Y1TqisRHsqtBHuL9K9zjqLhvGkCo8cdp1Wc+A5B1R3st
 /DjaBK+NJvf4VjEco8VglchwX453r9UuScoMCLPXtTPG2fWcpf65rJkOp0OPFqJuMC
 9w5m3zhsNWNMluohooSsrp8x8bHj94rNU64Tvv+3NeAEYrrcPZT4LyIIDpGmBadhtw
 g3cfFqAidXplg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 8AA832FF557;
 Thu, 18 Jun 2026 08:24:30 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 59D1C37C969;
 Thu, 18 Jun 2026 16:24:29 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v2 1/1] plugins: use int64_t for the syscall filter return
 value
Date: Thu, 18 Jun 2026 16:24:26 +0800
Message-Id: <20260618082426.790315-2-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618082426.790315-1-functioner@sjtu.edu.cn>
References: <20260618082426.790315-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The syscall return value passed back through the syscall filter
callback is semantically signed: negative values encode errno codes.
Declaring the sysret pointer as uint64_t * is therefore misleading and
forces callers to launder the value through an unsigned temporary.

Change the sysret pointer to int64_t * across the public plugin API
typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
implementation in plugins/core.c, the linux-user caller, and the
in-tree example plugins.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
v2: rebased onto current master. The syscall callbacks now take a
    userdata argument, so the filter signatures were adjusted to keep
    that while changing only the sysret type. No functional change.
---
 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d8d4b37384..3e913cd89c 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -871,7 +871,7 @@ typedef bool
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
-                                        uint64_t *sysret,
+                                        int64_t *sysret,
                                         void *userdata);
 
 /**
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9356ee836a..9c2ec8ceae 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -172,7 +172,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret);
+                                uint64_t a8, int64_t *sysret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -288,7 +288,7 @@ static inline bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     return false;
 }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fbe357b7e0..d257fb9ca9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14619,7 +14619,7 @@ static bool send_through_syscall_filters(CPUState *cpu, int num,
                                          abi_long arg7, abi_long arg8,
                                          abi_long *sysret)
 {
-    uint64_t sysret64 = 0;
+    int64_t sysret64 = 0;
     bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
                                                     arg3, arg4, arg5, arg6,
                                                     arg7, arg8, &sysret64);
diff --git a/plugins/core.c b/plugins/core.c
index 4b55aacd2d..1113bfe567 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -573,7 +573,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 7c78f182f0..76b2efc61b 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret, void *userdata)
+                                int64_t *sysret, void *userdata)
 {
     if (num == MAGIC_SYSCALL) {
         if (a1 == SETPC) {
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index a28d108784..debec9f09b 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -176,7 +176,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret, void *userdata)
+                                int64_t *sysret, void *userdata)
 {
     /* Special syscall to test the filter functionality. */
     if (num == 4096 && a1 == 0x66CCFF) {
-- 
2.34.1


