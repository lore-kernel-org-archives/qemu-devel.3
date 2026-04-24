Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFEEFED3DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIa0-0000sP-CV; Fri, 24 Apr 2026 11:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGIZw-0000r7-Jc
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:36:28 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGIZt-0005QR-3v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:36:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AD09408CA;
 Fri, 24 Apr 2026 15:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18180C19425;
 Fri, 24 Apr 2026 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777044976;
 bh=Zm8Avroy565IPT/Xg1OhyVcsPSLIbJh/bHpAg/LHQFM=;
 h=From:To:Cc:Subject:Date:From;
 b=fVWj9sBJDC7vguAVrI+xdzU05Jj1aMuTeR71g9Wi323fLTx3ckJGwHQOXQZWnufpj
 Vchvm61u+a1Kz6fA6nfvT3G65aXMJNhRc6Dl4ptJewW5E/QJyG1riB8YPS0h7Sjy+v
 qJg5tVo6tlKs2k9IeFH4vWTrRIr8Ug8Kw8sqgrd1SY9E2AXpVDco2efYh5lEOWq5jr
 VWSGcz2Kcv/sC6lX0K4dl2YUK1CYuW2LL3kCrdnyqLXJIUE6VfhABF48YlrOzwFo7+
 d+kf/aOvXiV4dkpY3Vkxb/wJVfKEhWx6TFFKC1M6vDP/tq58LWSHOBJGb0nLu4VSxu
 6r+rp36oJ8/OA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Peter Hartley <peter@talesfromthearmchair.net>
Subject: [PATCH] linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
Date: Fri, 24 Apr 2026 17:36:00 +0200
Message-ID: <20260424153600.46116-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Peter Hartley noticed, that in the qemu code the imr_ifindex member of
struct target_ip_mreq needs to be of type "int" instead of "long", which
is what the Linux kernel uses on all architectures.

Adjust the type accordingly, and add a QEMU_BUILD_BUG_ON() checker to
prevent such issues in the future.

This change should fix multicast issues when using hosts and guests with
different endianess or bit size.

Reported-by: Peter Hartley <peter@talesfromthearmchair.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2553
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c      | 2 ++
 linux-user/syscall_defs.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 910a4da0a6..4594909242 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2161,6 +2161,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 
             QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
                               sizeof(struct target_ip_mreq));
+            QEMU_BUILD_BUG_ON(sizeof(struct ip_mreqn) !=
+                              sizeof(struct target_ip_mreqn));
 
             if (optname == IP_MULTICAST_IF) {
                 min_size = sizeof(struct in_addr);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 138ce6abb1..b8511439da 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -210,7 +210,7 @@ struct target_ip_mreq {
 struct target_ip_mreqn {
     struct target_in_addr imr_multiaddr;
     struct target_in_addr imr_address;
-    abi_long imr_ifindex;
+    abi_int imr_ifindex;
 };
 
 struct target_ip_mreq_source {
-- 
2.53.0


