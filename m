Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B30E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06Z-0005iG-C1; Wed, 18 Dec 2024 14:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06V-0005gh-Dv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06T-0001cU-5a
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD9A85C5E98;
 Wed, 18 Dec 2024 19:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C578C4CECD;
 Wed, 18 Dec 2024 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734551577;
 bh=7sDAkRnZ08OkWc2JgsOLVf4mCXc++peN2aQFHOAIuw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BEhk+RJ/xBnRrQoGxpCxeqo0IPwMk/x8LmMegqZMZhtxqzsNL0YwbWVyVYaw6XoXO
 m/3b/oNyqJaBV3CbQNRexB6nUulgGSkURMy2DEBGAzNtzwlLLve8RRsu7u0kYuq5B7
 b7u2NMGM3Hw8aKe7v0ejtCMQEQy8NK6SfFpaWzZ9ClUhzwy5HOjSyUbxkZ0icIoeYV
 M52gOHledHl2mKZ8gR4x4S9A4Hw6606VJw312CrW1MkFqe18hmkTYhSqLmtmaQ/piC
 b5xRXWgqFoQ6xJ1ZgMUqvCfTqeinNCZT/KTejOZSDL6TU5Bfxy+yPte1kNrRjIMIDz
 826YMlm9dJkEQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 4/6] linux-user: netlink: Add emulation of IP_MULTICAST_IF
Date: Wed, 18 Dec 2024 20:52:45 +0100
Message-ID: <20241218195247.5459-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218195247.5459-1-deller@kernel.org>
References: <20241218195247.5459-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Share code with IP_ADD_MEMBERSHIP/IP_DROP_MEMBERSHIP.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
-- 
2.47.0


