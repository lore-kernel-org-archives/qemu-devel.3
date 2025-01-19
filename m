Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65E9C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 04:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZN7x-0005Ub-Oo; Sat, 18 Jan 2025 23:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7w-0005U3-8r
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:36 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7u-0003XO-Ih
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3B144A40221;
 Sun, 19 Jan 2025 04:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1BCC4CEE2;
 Sun, 19 Jan 2025 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737261693;
 bh=UoKNIg1BVV2B35JmDx3qsOSk4IWWs53EChpYtm/qpbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tkQwfM+xaJ5JDOCzXlLwXBLILhYw//05iRlgT0DOkyUlHi3lYdH+fLeOAsYQw7bQN
 8q7iXy/YjVhfO1hOuUNWRKYUmsqhR/4uG5OEg5vo0xjoDqEAtH5L3v/GXrTHtXf/5Y
 i1hfN9qJPXbOGzfr/NbfAY4QTuGleW0iJBljZDUew6mPOpT7Ddw+zus1BTb08h7Oql
 uWPwrizfKCyvSfRqgxuh3Mxbv8oCSmPj1LaMyD6/r0us6RzMGFJZ6CCOMRgZVJmQyo
 J3xSkl8duxrKnk8WPo+931fQNYobeu374XLz+BCQ9+oQhPloxXhNtJJoUY9ugzw35v
 f+1a1lrqp/6fQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v3 4/6] linux-user: netlink: Add emulation of IP_MULTICAST_IF
Date: Sun, 19 Jan 2025 05:41:20 +0100
Message-ID: <20250119044122.9637-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250119044122.9637-1-deller@kernel.org>
References: <20250119044122.9637-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Add IP_MULTICAST_IF and share the code with IP_ADD_MEMBERSHIP / IP_DROP_MEMBERSHIP.
Sharing the code makes sense, because the manpage of ip(7)  says:

IP_MULTICAST_IF (since Linux 1.2)
      Set the local device for a multicast socket.  The argument
      for setsockopt(2) is an ip_mreqn or (since Linux 3.5)
      ip_mreq structure similar to IP_ADD_MEMBERSHIP, or an
      in_addr structure.  (The kernel determines which structure
      is being passed based on the size passed in optlen.)  For
      getsockopt(2), the argument is an in_addr structure.

Signed-off-by: Helge Deller <deller@gmx.de>

v2: (based on feedback by Laurent Vivier)
- refined commit message and restructure the copying of ip_mreqn fields

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bbe2560927..4360543e20 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             }
             ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
             break;
+        case IP_MULTICAST_IF:
         case IP_ADD_MEMBERSHIP:
         case IP_DROP_MEMBERSHIP:
         {
             struct ip_mreqn ip_mreq;
             struct target_ip_mreqn *target_smreqn;
+            int min_size;

             QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
                               sizeof(struct target_ip_mreq));

-            if (optlen < sizeof (struct target_ip_mreq) ||
+            if (optname == IP_MULTICAST_IF) {
+                min_size = sizeof(struct in_addr);
+            } else {
+                min_size = sizeof(struct target_ip_mreq);
+            }
+            if (optlen < min_size ||
                 optlen > sizeof (struct target_ip_mreqn)) {
                 return -TARGET_EINVAL;
             }
@@ -2149,7 +2156,9 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                 return -TARGET_EFAULT;
             }
             ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
-            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+            if (optlen >= sizeof(struct target_ip_mreq)) {
+                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+            }
             if (optlen == sizeof(struct target_ip_mreqn)) {
                 ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
                 optlen = sizeof(struct ip_mreqn);
---
 linux-user/syscall.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index df8609b4d8..6ee02383da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             }
             ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
             break;
+        case IP_MULTICAST_IF:
         case IP_ADD_MEMBERSHIP:
         case IP_DROP_MEMBERSHIP:
         {
             struct ip_mreqn ip_mreq;
             struct target_ip_mreqn *target_smreqn;
+            int min_size;
 
             QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
                               sizeof(struct target_ip_mreq));
 
-            if (optlen < sizeof (struct target_ip_mreq) ||
+            if (optname == IP_MULTICAST_IF) {
+                min_size = sizeof(struct in_addr);
+            } else {
+                min_size = sizeof(struct target_ip_mreq);
+            }
+            if (optlen < min_size ||
                 optlen > sizeof (struct target_ip_mreqn)) {
                 return -TARGET_EINVAL;
             }
@@ -2149,13 +2156,14 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                 return -TARGET_EFAULT;
             }
             ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
-            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
-            if (optlen == sizeof(struct target_ip_mreqn)) {
-                ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
-                optlen = sizeof(struct ip_mreqn);
+            if (optlen >= sizeof(struct target_ip_mreq)) {
+                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+                if (optlen >= sizeof(struct target_ip_mreqn)) {
+                    __put_user(target_smreqn->imr_ifindex, &ip_mreq.imr_ifindex);
+                    optlen = sizeof(struct ip_mreqn);
+                }
             }
             unlock_user(target_smreqn, optval_addr, 0);
-
             ret = get_errno(setsockopt(sockfd, level, optname, &ip_mreq, optlen));
             break;
         }
-- 
2.47.0


