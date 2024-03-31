Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB26CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 10:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqs6Z-0005Ew-93; Sun, 31 Mar 2024 06:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6Q-0005Ck-F4
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6O-0000zC-QZ
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3AB45A831;
 Sun, 31 Mar 2024 13:09:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 71BF7A7B16;
 Sun, 31 Mar 2024 13:07:40 +0300 (MSK)
Received: (nullmailer pid 2724215 invoked by uid 1000);
 Sun, 31 Mar 2024 10:07:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/4] linux-user/syscall: do_setsockopt(): make ip_mreq local
 to the place it is used and inline target_to_host_ip_mreq()
Date: Sun, 31 Mar 2024 13:07:35 +0300
Message-Id: <20240331100737.2724186-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240331100737.2724186-1-mjt@tls.msk.ru>
References: <20240331100737.2724186-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

ip_mreq is declared at the beginning of do_setsockopt(), while
it is used in only one place.  Move its declaration to that very
place and replace pointer to alloca()-allocated memory with the
structure itself.

target_to_host_ip_mreq() is used only once, inline it.

This change also properly handles TARGET_EFAULT when the address
is wrong.

Note: optlen here refers to target struct size, while host
struct size can potentially be different.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5c7728cfd4..733a2b91e9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1615,24 +1615,6 @@ static abi_long do_pipe(CPUArchState *cpu_env, abi_ulong pipedes,
     return get_errno(ret);
 }
 
-static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
-                                              abi_ulong target_addr,
-                                              socklen_t len)
-{
-    struct target_ip_mreqn *target_smreqn;
-
-    target_smreqn = lock_user(VERIFY_READ, target_addr, len, 1);
-    if (!target_smreqn)
-        return -TARGET_EFAULT;
-    mreqn->imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
-    mreqn->imr_address.s_addr = target_smreqn->imr_address.s_addr;
-    if (len == sizeof(struct target_ip_mreqn))
-        mreqn->imr_ifindex = tswapal(target_smreqn->imr_ifindex);
-    unlock_user(target_smreqn, target_addr, 0);
-
-    return 0;
-}
-
 static inline abi_long target_to_host_sockaddr(int fd, struct sockaddr *addr,
                                                abi_ulong target_addr,
                                                socklen_t len)
@@ -2067,7 +2049,6 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 {
     abi_long ret;
     int val;
-    struct ip_mreqn *ip_mreq;
     struct ip_mreq_source *ip_mreq_source;
 
     switch(level) {
@@ -2111,15 +2092,26 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             break;
         case IP_ADD_MEMBERSHIP:
         case IP_DROP_MEMBERSHIP:
+        {
+            struct ip_mreqn ip_mreq;
+            struct target_ip_mreqn *target_smreqn;
+
             if (optlen < sizeof (struct target_ip_mreq) ||
                 optlen > sizeof (struct target_ip_mreqn))
                 return -TARGET_EINVAL;
 
-            ip_mreq = (struct ip_mreqn *) alloca(optlen);
-            target_to_host_ip_mreq(ip_mreq, optval_addr, optlen);
-            ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq, optlen));
-            break;
+            target_smreqn = lock_user(VERIFY_READ, optval_addr, optlen, 1);
+            if (!target_smreqn)
+                return -TARGET_EFAULT;
+            ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
+            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+            if (optlen == sizeof(struct target_ip_mreqn))
+                ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
+            unlock_user(target_smreqn, optval_addr, 0);
 
+            ret = get_errno(setsockopt(sockfd, level, optname, &ip_mreq, optlen));
+            break;
+        }
         case IP_BLOCK_SOURCE:
         case IP_UNBLOCK_SOURCE:
         case IP_ADD_SOURCE_MEMBERSHIP:
-- 
2.39.2


