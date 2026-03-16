Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10D0EFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226a-00087x-FD; Mon, 16 Mar 2026 03:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2269-0007bO-WD; Mon, 16 Mar 2026 03:10:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2268-0007oI-37; Mon, 16 Mar 2026 03:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645003; bh=AcNMYIFDrEN54FI0tN/yss+Qg87nVMQ2Wyhg1uY/8v4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fTUFqLYZeTdXsf/bbzvYejIBTF22JvNTowKf6F2sLkqxZonUPxP5S6UhQuSgLtJM7
 /289IUYXOfse1Ry7R3omMbVsEr/SPOCHP0UDrEsidd1IfaIvatHbfe5D7hI2FO/8VA
 ylg1mT52VptGKH/+DvMKV0xBZXb6B6wPtFfxrypTSK5bKtdJSLGEJGYTflzPInxqup
 vF5dn5+s6gMzlmY+5yHTf2Eem8E6L0gSVHFXWADZ/VJH6r4//KWVETZ0G7/87bHael
 HsE7pipG1zIjXqiSCsq71DKIq0mjceBagUs+qH9BbCnxwRO6Npr0bRJWyS+AYwYpb9
 wxjgPtn7xavNA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E9A9193C2E;
 Mon, 16 Mar 2026 10:10:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 38932380056;
 Mon, 16 Mar 2026 10:10:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 12/14] linux-user: assume epoll is always present
Date: Mon, 16 Mar 2026 10:10:00 +0300
Message-ID: <20260316071005.91624-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

epoll is in linux since 2.6 (glibc 2.3.2).
epoll_init1 has been added in 2.6.27 (glibc 2.9).
There's no need to check for its presence, including all other
epoll-related syscalls.

Modern architectures don't have epoll_create(), only
epoll_create1(), so keep conditional around the former.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c      | 10 ++--------
 linux-user/syscall_defs.h |  3 ---
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1f28e7e93f..7832a1aba5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -73,9 +73,7 @@
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #endif
-#ifdef CONFIG_EPOLL
 #include <sys/epoll.h>
-#endif
 #ifdef CONFIG_ATTR
 #include "qemu/xattr.h"
 #endif
@@ -13732,16 +13730,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
@@ -13770,7 +13765,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
         return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
     }
-#endif
 
 #if defined(TARGET_NR_epoll_wait)
     case TARGET_NR_epoll_wait:
@@ -13856,7 +13850,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         g_free(ep);
         return ret;
     }
-#endif /* CONFIG_EPOLL */
+
 #ifdef TARGET_NR_prlimit64
     case TARGET_NR_prlimit64:
     {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 20d862fd8b..aac8b0c574 100644
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


