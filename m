Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF9ED6EC15
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH29R-0003Lb-Um; Fri, 29 Nov 2024 09:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29P-0003Ka-EF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:19 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29O-0005zX-25
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 743ECA43F22;
 Fri, 29 Nov 2024 14:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4FC4CECF;
 Fri, 29 Nov 2024 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732891149;
 bh=7sDAkRnZ08OkWc2JgsOLVf4mCXc++peN2aQFHOAIuw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jidt8OSla1P65EUfuP36JDekth5omNY9/fCGgLtWiAnP4ohyWbq/WW5qzQk9VqcJs
 55+Pwa5/oHknTHSsf8BtId1MHVfObnaypdomcDTY3oMsFL62PsZcwSKCh/c3kQwNED
 6QHWC8dG68Qo4c4uhRFTAIhZE68W7Zg/3vGt4mg20JmMwAxse3/8/7cAlWYFrR02/b
 j2PHpLDj5QAeLZ9sMqqORfS1JL/Zqe2WXmK9YssdCXFLpVFPTpjG46hdCZfhGCI+XU
 QlElqKeWEo/9go6B/lGxTSA4DARWSC8c07s8idyIQKgicClgU5ryqNSUAj3TnotAUQ
 KvnpzA63OqqqA==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 4/6] linux-user: netlink: Add emulation of IP_MULTICAST_IF
Date: Fri, 29 Nov 2024 15:38:59 +0100
Message-ID: <20241129143901.11291-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129143901.11291-1-deller@kernel.org>
References: <20241129143901.11291-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


