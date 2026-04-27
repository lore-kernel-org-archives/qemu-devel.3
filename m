Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEFEFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5g-0000Xs-Qn; Mon, 27 Apr 2026 17:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5f-0000XB-86
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:02:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5c-0003Y6-59
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:02:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D2D460138;
 Mon, 27 Apr 2026 21:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4CC19425;
 Mon, 27 Apr 2026 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323719;
 bh=z9prjR+BocYciwsUKoSOvL3HoAICSfSydNGV4GRnsv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WnOPnhM4B1ko9fyD8ARKNB5EjOOqmBTo637Opraic/e0moYWa2UX+G3yfg0Gp+Njy
 nOxzK0TLrO+siC0vSdSpzmzEhXGtmpSswl2SOYlHIPH+5KwJaQR3JmnbXGR9mObSmD
 b1mC0isdThXjAQCT/Yo2eQZFFz2TNUA/f/UBAaL1a8X/+6TFJQOWDBzUuW6wHVLx2z
 OfCAvS5zCG8bJKdlYr3bYKqIradgsKMfUgHGzYPGrWsrqVpx/+WJ9Qt1BOoRXaIJho
 HxH0+B6SU8vqJhQWvenfPXRJz6ECNJdUktexQ674qx+VMU2Gb5ca/btTrKulvf302A
 PehUlL/GKHchw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 12/15] linux-user: Fix CLONE_PARENT_SETTID when using
 fork-like clone
Date: Mon, 27 Apr 2026 23:01:30 +0200
Message-ID: <20260427210133.6016-13-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Helge Deller <deller@gmx.de>

The CLONE_PARENT_SETTID option requires the implementation to store the
child thread ID at the location pointed to by parent_tid in the parent's
memory.

Fix our implementation and move the code from the client side (where
fork returned 0), to the parent side and store the return value from the
fork call (which is the client TID) in the parent_tid pointer.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3340
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d0390e04b4..910a4da0a6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7050,8 +7050,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                the child process gets its own copy of the lock.  */
             if (flags & CLONE_CHILD_SETTID)
                 put_user_u32(sys_gettid(), child_tidptr);
-            if (flags & CLONE_PARENT_SETTID)
-                put_user_u32(sys_gettid(), parent_tidptr);
             ts = get_task_state(cpu);
             if (flags & CLONE_SETTLS)
                 cpu_set_tls (env, newtls);
@@ -7059,6 +7057,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 ts->child_tidptr = child_tidptr;
         } else {
             cpu_clone_regs_parent(env, flags);
+            if (flags & CLONE_PARENT_SETTID)
+                put_user_u32(ret, parent_tidptr);
             if (flags & CLONE_PIDFD) {
                 int pid_fd = 0;
 #if defined(__NR_pidfd_open) && defined(TARGET_NR_pidfd_open)
-- 
2.53.0


