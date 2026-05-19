Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9C6CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPL4s-0001UN-U4; Tue, 19 May 2026 10:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4s-0001Tr-2z
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:46 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4p-00077c-3R
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 78E2340D72;
 Tue, 19 May 2026 14:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA8C2BCB3;
 Tue, 19 May 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779199540;
 bh=NJ2IiKRcrXZDqlm0yyQvg6DRpQCePqd/EFPFnCOx9SA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HjPMCl0WNgDI0x3jT/y9rSzOvEWJ53gtjWpnLtYBeBz+gzoHoFaWU17Ij1oHqtzdf
 WCVBaPEHXsvKwruvL7Dc7YOAMFd36aBByC14wL+qulClcbQcwxD1m+gz0lSAuHi59B
 Gc2ZLVpG1LDTKyaJxPA8o/TcqBys+EocgcwqxX3hobsDdnNO7Jth6x//AoYmQYR1Le
 1nZqLyGc6K2ZQU4K5wWCXHj8L1c3MYN1ZqTVHX9AVkFdWdjyTIx4u1CeehIEIr6a+d
 mcsuhfkykNpNOT/gYEiPMAUaR7IwOyL9TwdeGEbeVWWUF4X9PAvqhNf1h1fBI2NHTs
 zTTHmSa4ZGEMA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/4] linux-user: Fix a memory leak when pthread_create fails
Date: Tue, 19 May 2026 16:05:31 +0200
Message-ID: <20260519140531.11931-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519140531.11931-1-deller@kernel.org>
References: <20260519140531.11931-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

From: Warner Losh <imp@bsdimp.com>

Fix one of the TODO items when creating a new thread: release the copied
cpu and free the task state.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 65bbeb8551..2d4a8aa182 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
         ret = pthread_create(&info.thread, &attr, clone_func, &info);
-        /* TODO: Free new CPU state if thread creation failed.  */
 
         sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
         pthread_attr_destroy(&attr);
@@ -7014,7 +7013,16 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             pthread_cond_wait(&info.cond, &info.mutex);
             ret = info.tid;
         } else {
+            errno = ret;
             ret = -1;
+            object_unparent(OBJECT(new_cpu));
+            object_unref(OBJECT(new_cpu));
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+            g_free(ts);
         }
         pthread_mutex_unlock(&info.mutex);
         pthread_cond_destroy(&info.cond);
-- 
2.54.0


