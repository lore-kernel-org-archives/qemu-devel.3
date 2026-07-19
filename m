Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB6C44520
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMGL-0007Vb-33; Sun, 19 Jul 2026 03:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGI-0007Tu-Fb
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:34 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGE-00054V-7n
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784447283;
 bh=p5117I2X0BDpEQLindw53jpxrdPty0kND9gp4KaUWXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M8jtb1Z4XNM1jQAPmGcuv6zyXpmHsegA5bo7mLIFZE3ekIpgu28KmA72sXqVV5oEE
 wYtI3ftIdbP+YxaA1z6an+/33qcNAXWTI5E+xpKHhNJx3FsdAR/BGjEuy1sg0ddjfU
 2/wx7ZUkb5Vj83a3BRJxGz2d2RieIxFDoGTTpRl1R/EsXCTqphKPjYqSxODSgaPJ55
 +8Vj/S6JsW2q/hSQCO+E4iY/Ez7UjPr89gs6sZMm8bW2s+V4PvKop3LZ4RyXjIvLrE
 6UbTEgkPjPSHj8WpJSAb8gcnWp4NGDOFAdLLunG8WFfX2wCsx/V13Ra+VPuUHik9ZR
 xs8/7O6ujcf/w==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 89DF62FF409;
 Sun, 19 Jul 2026 07:48:03 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id E33FC37C925;
 Sun, 19 Jul 2026 15:47:32 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH 1/3] contrib/plugins/dlcall: correct the syscall number claim,
 note the data model
Date: Sun, 19 Jul 2026 15:47:28 +0800
Message-Id: <20260719074730.1520517-2-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
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

The comment claimed every Linux ABI keeps its syscall numbers well below the
minimum, and that the minimum is all N has to satisfy. Neither holds.

MIPS O32 bases its numbering at 4000, so the default 4096 is its getpriority.
Raising N does not rescue it either, because O32 answers numbers its table does
not define with ENOSYS before the filter runs, which leaves no number that is
both free and reachable on that ABI. arm32 bounds N from above too, with ENOSYS
or SIGILL past ARM_NR_BASE. Say all of this, so the number can be chosen with
the target in mind.

guest_base == 0 is not the only requirement either. Host pointers are written
back through the caller's out pointers, so the guest must match the host's
pointer width and endianness. Fold that into the existing warning.

Also assert the two out pointers that lacked it, and point at Lorelei for
argument marshalling, callbacks and variadic functions.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 contrib/plugins/dlcall.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/dlcall.c b/contrib/plugins/dlcall.c
index 9d2230b2d1..b624735e62 100644
--- a/contrib/plugins/dlcall.c
+++ b/contrib/plugins/dlcall.c
@@ -10,7 +10,8 @@
  * nothing about how a library is thunked. Any toolchain can implement the
  * userspace side. Lorelei is one end-to-end implementation (guest/host
  * runtimes plus a thunk compiler that generates thunks from a library's
- * headers):
+ * headers), and how it handles argument marshalling, callbacks and variadic
+ * functions can serve as a reference:
  * https://github.com/rover2024/lorelei
  *
  * See docs/about/emulation.rst|Dynamic Linking Call for details and examples.
@@ -20,12 +21,13 @@
  * execution in the QEMU host process. It is NOT a sandbox and provides no
  * isolation; only load it for guests you fully trust.
  *
- * WARNING: requires guest_base == 0, which is qemu-user's default. Pointer
- * operands are dereferenced as host addresses directly, and the invoked host
- * functions dereference guest pointers with no address translation, so guest
- * and host must share a single address space. A non-zero guest_base (e.g. set
- * via -B/-R) would make every pointer off by guest_base and hit unrelated
- * host memory.
+ * WARNING: requires guest_base == 0, which is qemu-user's default, and a
+ * guest whose pointer width and endianness match the host's. Pointer operands
+ * are dereferenced as host addresses directly, and the invoked host functions
+ * dereference guest pointers with no address translation, so guest and host
+ * must share a single address space and agree on how a pointer is stored. A
+ * non-zero guest_base (e.g. set via -B/-R) would make every pointer off by
+ * guest_base and hit unrelated host memory.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -46,8 +48,18 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  *
  * It defaults to DLCALL_SYSCALL_DEFAULT and can be overridden at load time
  * with the "syscall_num=N" argument. To avoid hijacking a real syscall the
- * guest might issue, N must be at least DLCALL_SYSCALL_MIN: every Linux ABI
- * keeps its syscall numbers well below this; numbers from here up are free.
+ * guest might issue, N must be at least DLCALL_SYSCALL_MIN, which most Linux
+ * ABIs keep their syscall numbers well below.
+ *
+ * N also has to reach the filter at all, which bounds it from above in a
+ * target specific way: arm32 answers anything past ARM_NR_BASE (0xf0000) with
+ * ENOSYS or SIGILL before do_syscall() runs, while aarch64 has no such bound.
+ *
+ * MIPS O32 bases its numbering at 4000, so the default is a real syscall there
+ * (getpriority). Raising N does not help either, because O32 rejects numbers
+ * its table does not define, again before the filter runs, which leaves no
+ * number that is both free and reachable on that ABI. Its N32 and N64 ABIs
+ * base at 6000 and 5000 and have no such gate, so they are unaffected.
  */
 enum {
     DLCALL_SYSCALL_DEFAULT = 4096,
@@ -168,6 +180,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
         case DLCALL_ID_FREE_LIBRARY: {
             void *handle = (void *) a2;
             int *ret_ptr = (int *) a3;
+            assert(ret_ptr);
             *ret_ptr = dlclose(handle);
             *sysret = 0;
             break;
@@ -176,6 +189,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
         /* Get the last error message for a library event. */
         case DLCALL_ID_GET_LIBRARY_ERROR: {
             const char **error_ptr = (const char **) a2;
+            assert(error_ptr);
             *error_ptr = dlerror();
             *sysret = 0;
             break;
-- 
2.34.1


