Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E914D2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe1j-0008J3-Sn; Tue, 13 Jan 2026 08:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfe0u-00072T-K7; Tue, 13 Jan 2026 08:00:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfe0r-00014j-4z; Tue, 13 Jan 2026 08:00:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B980017D9E3;
 Tue, 13 Jan 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B378334C41A;
 Tue, 13 Jan 2026 16:00:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial 5/7] linux-user: assume epoll is always present
Date: Tue, 13 Jan 2026 16:00:06 +0300
Message-ID: <20260113130008.910240-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113130008.910240-1-mjt@tls.msk.ru>
References: <20260113130008.910240-1-mjt@tls.msk.ru>
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

epoll is in linux since 2.6. epoll_init1 has been
added in 2.6.27.  There's no need to check for its
presence, including all other epoll-related syscalls.

Modern architectures don't have epoll_create(), only
epoll_create1(), so keep conditional around the former.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c      | 10 ++--------
 linux-user/syscall_defs.h |  3 ---
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fad2bf3632..207c54db02 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -72,9 +72,7 @@
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #endif
-#ifdef CONFIG_EPOLL
 #include <sys/epoll.h>
-#endif
 #ifdef CONFIG_ATTR
 #include "qemu/xattr.h"
 #endif
@@ -13558,16 +13556,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_signalfd:
         return do_signalfd4(arg1, arg2, 0);
 #endif
-#if defined(CONFIG_EPOLL)
+
 #if defined(TARGET_NR_epoll_create)
     case TARGET_NR_epoll_create:
         return get_errno(epoll_create(arg1));
 #endif
-#if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
     case TARGET_NR_epoll_create1:
         return get_errno(epoll_create1(target_to_host_bitmask(arg1, fcntl_flags_tbl)));
-#endif
-#if defined(TARGET_NR_epoll_ctl)
     case TARGET_NR_epoll_ctl:
     {
         struct epoll_event ep;
@@ -13596,7 +13591,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
         return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
     }
-#endif
 
 #if defined(TARGET_NR_epoll_wait)
     case TARGET_NR_epoll_wait:
@@ -13682,7 +13676,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         g_free(ep);
         return ret;
     }
-#endif /* CONFIG_EPOLL */
+
 #ifdef TARGET_NR_prlimit64
     case TARGET_NR_prlimit64:
     {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cd9ff709b8..20e2e7deac 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2595,7 +2595,6 @@ struct target_drm_i915_getparam {
 #define FUTEX_CLOCK_REALTIME    256
 #define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
 
-#ifdef CONFIG_EPOLL
 #if defined(TARGET_X86_64)
 #define TARGET_EPOLL_PACKED QEMU_PACKED
 #else
@@ -2616,8 +2615,6 @@ struct target_epoll_event {
 
 #define TARGET_EP_MAX_EVENTS (INT_MAX / sizeof(struct target_epoll_event))
 
-#endif
-
 struct target_ucred {
     abi_uint pid;
     abi_uint uid;
-- 
2.47.3


