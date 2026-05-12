Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58CCCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuH7-0005Um-0I; Tue, 12 May 2026 17:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFc-0001Hc-8L; Tue, 12 May 2026 17:02:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFZ-0007TN-8G; Tue, 12 May 2026 17:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=Oxnn/p4hWsGbo0BtdSTt1klBit61xfYZcqMMePjFsvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YDAMNwObEz144sBcVM7BVMD1L/4Q+uEul090gzgg/qdbhsRO25QRjtMoVuZ9j9VkY
 i9qtIHp3zYWF2lgB1P8W+lnV9lHA1MIiSC4UEH75irn+0X0UojplIHHRgWmnXXW9bF
 Ae7o4n+a2F0KjxyZGelho/Mm7Gy+IXhhLedEfwnkz7sm+locs81rtCOM6+UykIl8uC
 vgeCk9kjg4xnkGN/N5+VxbjQ+4OOjNL9zIrgkfrs8hRNhXV2XwyiHqbLQwlNNyAl4I
 4hlMWkhMV+vsVl6w7WgBbXJzTdGjNlUzM9CeExXAHLIdTNdbzX8FxOLNJKZgopUCo6
 XuBhCUxTtyv+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D48B1AA31B;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9AA123ABC8C;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 079/107] linux-user: Fix CLONE_PARENT_SETTID when
 using fork-like clone
Date: Tue, 12 May 2026 23:54:06 +0300
Message-ID: <20260512205437.360850-79-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit b03a6ac6fa5d7775b9f912fa5c39f7b92388c6a2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 76b655da2b..b8b256c430 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6918,8 +6918,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                the child process gets its own copy of the lock.  */
             if (flags & CLONE_CHILD_SETTID)
                 put_user_u32(sys_gettid(), child_tidptr);
-            if (flags & CLONE_PARENT_SETTID)
-                put_user_u32(sys_gettid(), parent_tidptr);
             ts = get_task_state(cpu);
             if (flags & CLONE_SETTLS)
                 cpu_set_tls (env, newtls);
@@ -6927,6 +6925,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 ts->child_tidptr = child_tidptr;
         } else {
             cpu_clone_regs_parent(env, flags);
+            if (flags & CLONE_PARENT_SETTID)
+                put_user_u32(ret, parent_tidptr);
             if (flags & CLONE_PIDFD) {
                 int pid_fd = 0;
 #if defined(__NR_pidfd_open) && defined(TARGET_NR_pidfd_open)
-- 
2.47.3


