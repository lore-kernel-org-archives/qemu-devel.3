Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7B2D232FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 09:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8VC-0006tN-JW; Fri, 09 Jan 2026 04:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ve8V9-0006sU-5B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:09:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ve8V3-0008U0-BS
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:09:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2695B17C2D1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:08:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B0F9B348AB3;
 Fri, 09 Jan 2026 12:09:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 1/2] linux-user: cleanup epoll_pwait ifdeff'ery
Date: Fri,  9 Jan 2026 12:09:36 +0300
Message-ID: <20260109090937.599881-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109090937.599881-1-mjt@tls.msk.ru>
References: <20260109090937.599881-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All linux targets these days have epoll_pwait system call
(while some miss epoll_wait, which is less generic).  And
all linux targets definitely has one or another epoll_*wait*
system call - so whole code block dealing with this system
call should always be present.

Remove the now-unneeded ifdef'fery.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..d89c36382e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13615,13 +13615,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
 #if defined(TARGET_NR_epoll_wait)
     case TARGET_NR_epoll_wait:
 #endif
-#if defined(TARGET_NR_epoll_pwait)
     case TARGET_NR_epoll_pwait:
-#endif
     {
         struct target_epoll_event *target_ep;
         struct epoll_event *ep;
@@ -13646,7 +13643,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
 
         switch (num) {
-#if defined(TARGET_NR_epoll_pwait)
         case TARGET_NR_epoll_pwait:
         {
             sigset_t *set = NULL;
@@ -13666,7 +13662,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             }
             break;
         }
-#endif
 #if defined(TARGET_NR_epoll_wait)
         case TARGET_NR_epoll_wait:
             ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
@@ -13690,8 +13685,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         g_free(ep);
         return ret;
     }
-#endif
-#endif
+#endif /* CONFIG_EPOLL */
 #ifdef TARGET_NR_prlimit64
     case TARGET_NR_prlimit64:
     {
-- 
2.47.3


