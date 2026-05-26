Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830FDCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt7a-0008Q5-Q9; Tue, 26 May 2026 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wRt7X-0008PP-34
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:51:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wRt7U-0002Wu-Jf
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:51:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FF3060128;
 Tue, 26 May 2026 14:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F51F00A3A;
 Tue, 26 May 2026 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779807058;
 bh=RzAg/z9ESTOIfX4D/3KjFmD6FehyVHYLgvenUfGbwos=;
 h=From:To:Cc:Subject:Date;
 b=RT/iy7YSGnjbGk+fpPKrZVFFslu0CmAA3lLFSXjYh+8OwdZ95QBAMK/KssXQHDLy5
 K2ekP3yayM80QN/gQlemlUDAeA7SjL9PaCVpDVJ8hP8M0HdaXM0oNyJCot85spf7iS
 ftPXQ2mxRcQQ1fwvn3VSh+U61JhMyxMYxkGMgqKQdLPU6c7VCArHbLhxRnAiYJ8xvt
 S9eK1dlyziP5YaIPNa/fLQgGs1ANH2apvlt+NGBicvge5grcryx2/igF0M82RTugj0
 lriyU3HwMAba4ciCMY/XauYveQUOLTnM4J7xnFK71eXNkcjnEvvM61GLkvk5DR4Eqn
 5/xFCKrFSiG5A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] linux-user: Implement finer grained madivse() syscall
Date: Tue, 26 May 2026 16:50:48 +0200
Message-ID: <20260526145049.7239-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

From: Helge Deller <deller@gmx.de>

Although most madvise() values are hints, some are important and are
checked by userspace, especially by security-relevant applications like
BoringSLL.  So, return -EINVAL for those functions which we don't emulate.

Signed-off-by: Helge Deller <deller@gmx.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3489
---
 linux-user/mmap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4b7b3e5cc..50916c29a5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1282,7 +1282,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
     case TARGET_MADV_KEEPONFORK:    /* parisc */
         advice = MADV_KEEPONFORK;
         break;
-    /* we do not care about the other MADV_xxx values yet */
+    /* all other MADV_xxx values are the same across architectures */
     }
 
     /*
@@ -1307,6 +1307,19 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_NORMAL:
+    case MADV_RANDOM:
+    case MADV_SEQUENTIAL:
+    case MADV_WILLNEED:
+    case MADV_DOFORK:
+    case MADV_FREE:
+    case MADV_COLD:
+    case MADV_PAGEOUT:
+        ret = 0; /* OK */
+        break;
+    case MADV_REMOVE:
+        ret = -EOPNOTSUPP;
+        break;
     case MADV_DONTDUMP:
         page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
         break;
@@ -1324,6 +1337,23 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
                 page_reset_target_data(start, start + len - 1);
             }
         }
+        break;
+    case MADV_DONTFORK:
+    case MADV_MERGEABLE:
+    case MADV_UNMERGEABLE:
+    case MADV_HWPOISON:
+    case MADV_HUGEPAGE:
+    case MADV_NOHUGEPAGE:
+    case MADV_COLLAPSE:
+    case MADV_POPULATE_READ:
+    case MADV_POPULATE_WRITE:
+    case -1:    /* BoringSSL uses -1 to check if the environment is broken */
+        ret = -EINVAL;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice);
+        ret = -EINVAL; /* not yet known advise */
+        break;
     }
     mmap_unlock();
 
-- 
2.54.0


