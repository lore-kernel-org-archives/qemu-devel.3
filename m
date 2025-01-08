Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DD0E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeAG-0004Cz-Ez; Wed, 08 Jan 2025 17:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAF-0004Cc-BT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:35 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAD-0006PI-W4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B240DA41C22;
 Wed,  8 Jan 2025 22:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A285FC4CEDF;
 Wed,  8 Jan 2025 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736373873;
 bh=7sDAkRnZ08OkWc2JgsOLVf4mCXc++peN2aQFHOAIuw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HqczRGbLXIaTr9rTWeYPuKzI3drQreAfJKSGrl5rTmcSHnOBDcSCTdIGCaghyhMKR
 IkT6y+Zdj4yj5Uc2BaP5Eicoy4o2V49taGzPzBrD8/jOg6MhBFR9eSG0aV/53LpDaX
 U1us910LyVlhm4oAVGcn3JmCTiMWP+7QMEk3MQjZJiMkqmSOV6rirOBGlPwRDE3G+j
 /UNxnMTxeaTZinGJLSQADKPHdzraSmlSoeaFlYJoqLCgAYBu9wmo/4zGVqhN9f0ARw
 Cu5m40pHxaTB1SFY8otZ7Vv+MBiRy0sWDnxtVpinysaxfVae1cxS/5QcWQ0oFokZTT
 oOAZEhLsZ5BdQ==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v2 4/6] linux-user: netlink: Add emulation of IP_MULTICAST_IF
Date: Wed,  8 Jan 2025 23:04:20 +0100
Message-ID: <20250108220422.169967-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108220422.169967-1-deller@kernel.org>
References: <20250108220422.169967-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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


