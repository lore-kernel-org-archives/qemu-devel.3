Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE49FE51EE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCZA-00022q-J8; Fri, 24 Apr 2026 05:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYc-0001gE-3e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:43 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYa-0001IF-3n
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FB5B43608;
 Fri, 24 Apr 2026 09:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D28C19425;
 Fri, 24 Apr 2026 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777021838;
 bh=cQzNia5iIs98QU3S98d56+5fy6iOaBKc7DxBiJL8XuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kJg77udjhvb0yl/JDivr19wUKaZ75I4DDYVUVi4muZL1DFGHU64u1ykfHdpft9EB9
 R1SaBgPHrX/zoRIwoR8RurahBIFyGUc4toQQEfGk6HWxai+GI4Y6h8B2qKwfCMErH3
 bQLJuQNji5SFihsrZSE27ZbCQy4Mzo5xDSicz6P8lxITnS/MxZnOJx6TFjKuh3T8MT
 aDkZQOQ5DekrJxH7rMYQmACFASoowKmVxUfdviyjS/dQdXcV6I/c29oB0BE3qyp14Y
 iLomwyRhFouA77oEW4x2523IVn3FW8xgEOHEvY1PLaqVh0wm5Un9EBikHJcn7K6njv
 U2fwTE1qFBzYw==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 4/4] linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
Date: Fri, 24 Apr 2026 11:08:50 +0200
Message-ID: <20260424091024.23495-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091024.23495-1-deller@kernel.org>
References: <20260424091024.23495-1-deller@kernel.org>
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

Add handlers for both sockopts which use 64-bit time_t from userspace.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/885
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7bd5ad548b..a75dbceb5c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2621,7 +2621,8 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         /* These don't just return a single integer */
         case TARGET_SO_PEERNAME:
             goto unimplemented;
-        case TARGET_SO_RCVTIMEO: {
+        case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_RCVTIMEO_NEW: {
             struct timeval tv;
             socklen_t tvlen;
 
@@ -2641,11 +2642,17 @@ get_timeout:
             if (ret < 0) {
                 return ret;
             }
-            if (len > sizeof(struct target_timeval)) {
-                len = sizeof(struct target_timeval);
-            }
-            if (copy_to_user_timeval(optval_addr, &tv)) {
-                return -TARGET_EFAULT;
+            if (len == sizeof(struct target__kernel_sock_timeval)) {
+                if (copy_to_user_timeval64(optval_addr, &tv)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (len >= sizeof(struct target_timeval)) {
+                    len = sizeof(struct target_timeval);
+                    if (copy_to_user_timeval(optval_addr, &tv)) {
+                        return -TARGET_EFAULT;
+                    }
+                }
             }
             if (put_user_u32(len, optlen)) {
                 return -TARGET_EFAULT;
@@ -2653,6 +2660,7 @@ get_timeout:
             break;
         }
         case TARGET_SO_SNDTIMEO:
+        case TARGET_SO_SNDTIMEO_NEW:
             optname = SO_SNDTIMEO;
             goto get_timeout;
         case TARGET_SO_PEERCRED: {
-- 
2.53.0


