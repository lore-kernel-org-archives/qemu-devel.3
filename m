Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C53CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 10:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqs6n-0005HN-Ak; Sun, 31 Mar 2024 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6P-0005Ch-JM
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6N-0000zD-Sd
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1CF25A832;
 Sun, 31 Mar 2024 13:09:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A3A99A7B17;
 Sun, 31 Mar 2024 13:07:40 +0300 (MSK)
Received: (nullmailer pid 2724218 invoked by uid 1000);
 Sun, 31 Mar 2024 10:07:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 3/4] linux-user/syscall: do_setsockopt(): make ip_mreq_source
 local to the place where it is used
Date: Sun, 31 Mar 2024 13:07:36 +0300
Message-Id: <20240331100737.2724186-4-mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 733a2b91e9..988b6422fb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2049,7 +2049,6 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 {
     abi_long ret;
     int val;
-    struct ip_mreq_source *ip_mreq_source;
 
     switch(level) {
     case SOL_TCP:
@@ -2116,6 +2115,9 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IP_UNBLOCK_SOURCE:
         case IP_ADD_SOURCE_MEMBERSHIP:
         case IP_DROP_SOURCE_MEMBERSHIP:
+        {
+            struct ip_mreq_source *ip_mreq_source;
+
             if (optlen != sizeof (struct target_ip_mreq_source))
                 return -TARGET_EINVAL;
 
@@ -2126,7 +2128,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq_source, optlen));
             unlock_user (ip_mreq_source, optval_addr, 0);
             break;
-
+        }
         default:
             goto unimplemented;
         }
-- 
2.39.2


