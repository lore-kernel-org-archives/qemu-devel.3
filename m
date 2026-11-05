Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAC606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXSc9LR8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6NT-0001Jw-Bw; Thu, 05 Nov 2026 17:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6NB-0001IG-8x
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:55:59 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6N8-0004W7-1R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:55:55 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64973413CE;
 Thu,  5 Nov 2026 22:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489F41F0089F;
 Thu,  5 Nov 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793919351;
 bh=OT5xRW8A58o2SKIBu0eKtKZMV1p43VIrNvyL5ye7+h0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YXSc9LR8Yc+heEgU40lOSqABtKhbq2XFVZBanvARkFK6/Jq49aNqnw2BeGG+5aits
 O/r7AubSZa1SolQS4K9UOR5C6SerUgOL+cFfWzjOkvgdyt5kUH4qHcw6+0InMWXGb2
 ghS43C4RyxoH3DWkGS7HsAArXf5zy4tQL0yyJD3B1Hot3ljQoLWzv0LHDxCu9VUTB4
 5H1I5RXY/Qacx4V1oxDhkbE57IW4I+G2pKf95FthqnWl7bFzSqhnbOzOmOfqqlEv3H
 OnIjh7gSi37aEZAanI8fY3mEp3mwmxmzlwaD6br/o8AZiLUGPfB8ieqybnnSeQleeI
 avjbOK91lCB3Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 1/2] linux-user: allow a zero-length getrandom with a NULL
 buffer
Date: Thu,  5 Nov 2026 23:55:45 +0100
Message-ID: <20261105225547.12848-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105225547.12848-1-deller@kernel.org>
References: <20261105225547.12848-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: TAKANO Mitsuhiro <takano32@gmail.com>

The kernel never looks at the buffer of a zero-length request, so
getrandom(NULL, 0, 0) returns 0.  qemu-user hands the request to
lock_user() unconditionally, and a NULL or otherwise unusable address
fails there with EFAULT even though nothing is copied.

read(), write(), pread64() and pwrite64() already special-case the
zero-length request; do the same here.  The address plays no part in it:
with a zero length it is never dereferenced, whatever value the caller
passes.

Fixes: f894efd19917 ("linux-user: add getrandom() syscall")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c                          |  8 ++++++++
 tests/tcg/multiarch/linux/linux-null-buffer.c | 19 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-null-buffer.c

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d85a193ef..59cbf5feaa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11456,6 +11456,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
     case TARGET_NR_getrandom:
+        if (arg2 == 0) {
+            /*
+             * A zero-length request has no buffer to lock, and the kernel
+             * never looks at the pointer for it, so pass the call through
+             * instead of failing on a NULL or otherwise unusable address.
+             */
+            return get_errno(getrandom(NULL, 0, arg3));
+        }
         p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
         if (!p) {
             return -TARGET_EFAULT;
diff --git a/tests/tcg/multiarch/linux/linux-null-buffer.c b/tests/tcg/multiarch/linux/linux-null-buffer.c
new file mode 100644
index 0000000000..6246e47707
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-null-buffer.c
@@ -0,0 +1,19 @@
+/*
+ * A zero-length getrandom() needs no valid buffer: the kernel never looks at
+ * the pointer, so getrandom(NULL, 0, 0) succeeds.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/random.h>
+
+int main(void)
+{
+    errno = 0;
+    assert(getrandom(NULL, 0, 0) == 0);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index e60a052700..8f2f57d9ab 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -57,6 +57,7 @@ tests += {
 # Linux tests
 tests += {
   multiarch/'linux/linux-madvise.c': {},
+  multiarch/'linux/linux-null-buffer.c': {},
   multiarch/'linux/linux-shmat-maps.c': {},
   multiarch/'linux/linux-shmat-null.c': {},
   multiarch/'linux/linux-sigrtminmax.c': {},
-- 
2.54.0


