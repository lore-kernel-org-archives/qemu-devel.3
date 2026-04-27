Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAF5FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5h-0000Xv-Ai; Mon, 27 Apr 2026 17:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5f-0000XW-QM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:02:03 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5e-0003YH-4i
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:02:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 711EB60139;
 Mon, 27 Apr 2026 21:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B85C19425;
 Mon, 27 Apr 2026 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323721;
 bh=srPndtwvrTUYJ7OM9qm9DxiqBEi9dXm+PHtlQXIamDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ePPn5YXJZ/w9UGEFV9qLj668RejUU+yjDjPWcCZLzkVCz50nW3cy2FnOFQOGI09IL
 /ZOtN+GFBP7fnhsJtJAmztmdtsL2DkEEdbpzBOVFmmjOGQAL7HmO3JNjf+5PlRbvGZ
 xWlVlnyKGKgKtCE0ueKcqnI7qHK1uD56o+bsoPh6wlr4SIN/33m0wFxl0ntwZLWn85
 84KQ+yJ0aTMKw4N4jFxvkbw/KMu+PQ1xIXthZTiM20k+VgQKZNzUdfD8paL7KzyIUV
 zPzcPI0q3yGiQNkrG5U0NDr0G0faJ+uogsH3FjJ+10NXUm67o8V3BDpmIRlMddMBFc
 ieCVM4jVJSBGA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 13/15] linux-user: Use abi_int for imr_ifindex in ip_mreqn
 struct
Date: Mon, 27 Apr 2026 23:01:31 +0200
Message-ID: <20260427210133.6016-14-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
index 6967306be4..5799769f83 100644
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


