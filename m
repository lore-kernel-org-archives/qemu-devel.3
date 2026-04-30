Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4AFCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILgN-0003ZR-8J; Thu, 30 Apr 2026 03:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgL-0003YY-40
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:33 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgJ-00013J-Ey
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AF94D61145;
 Thu, 30 Apr 2026 07:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D4CC2BCB4;
 Thu, 30 Apr 2026 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777533570;
 bh=2zHQrRG0goJ++Rc1kkqjW925uojIri28hDyU+Vdmp0E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DQNWEbmgiLeqf+qHyLRMuCeUJYh43dPEyOd7H+o/oqDKy2y4OhwfFHM7bblXV0Psm
 BD+SGyWt/1bRU7e644sTdQbdmF6ZjV4xX9vdC/b2WFcxW4ecKvz9gh1UJDkJZt0SeG
 au2indjQz6DKV0RijkTzTTq8aSkm1NT9ppTPwbUt1TjI++qmlbqI+2Em4aVDYnJYhX
 fudT1OYOgzSyNd7RgpZaqxH4vnOXEgbtVFipQaOX+mKPCGJk+1vh0Ajc4e31xOdtTn
 iHDpcdO3E8P8RQlSEr9nc53eSSPKxJDgh3HrJMAQlDcyywN5GKi/ZsYuGktc7lWKHk
 /cNI1jFmG2AFA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/4] linux-user: Allow getsockopt() with NULL optval address
Date: Thu, 30 Apr 2026 09:19:21 +0200
Message-ID: <20260430071922.15341-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430071922.15341-1-deller@kernel.org>
References: <20260430071922.15341-1-deller@kernel.org>
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

Some programs test availability of socket options by asking for the
value with an NULL optval address, which currenrly always trigger an
EFAULT in qemu.  Fix it by allowing a NULL address, in the same manner
as the Linux kernel on physical machines.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2390
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 linux-user/syscall.c | 50 +++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4594909242..d68edb7afd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2644,6 +2644,10 @@ get_timeout:
             if (ret < 0) {
                 return ret;
             }
+            /* special case: destination address is NULL, return 0 */
+            if (optval_addr) {
+                len = 0;
+            }
             if (len == sizeof(struct target__kernel_sock_timeval)) {
                 if (copy_to_user_timeval64(optval_addr, &tv)) {
                     return -TARGET_EFAULT;
@@ -2844,7 +2848,10 @@ get_timeout:
         }
         if (len > lv)
             len = lv;
-        if (len == 4) {
+        if (!optval_addr) {
+            /* writing to NULL does not give error */
+            len = 0;
+        } else if (len == 4) {
             if (put_user_u32(val, optval_addr))
                 return -TARGET_EFAULT;
         } else {
@@ -2877,18 +2884,24 @@ get_timeout:
                 return -TARGET_EINVAL;
             lv = sizeof(lv);
             ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+write_ret:
             if (ret < 0)
                 return ret;
-            if (len < sizeof(int) && len > 0 && val >= 0 && val < 255) {
+            if (!optval_addr) {
+                len = 0;
+            } else if (len < sizeof(int) && len > 0 && val >= 0 && val < 255) {
                 len = 1;
-                if (put_user_u32(len, optlen)
-                    || put_user_u8(val, optval_addr))
+                if (put_user_u8(val, optval_addr)) {
                     return -TARGET_EFAULT;
+                }
             } else {
                 if (len > sizeof(int))
                     len = sizeof(int);
-                if (put_user_u32(len, optlen)
-                    || put_user_u32(val, optval_addr))
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            if (put_user_u32(len, optlen)) {
                     return -TARGET_EFAULT;
             }
             break;
@@ -2939,20 +2952,7 @@ get_timeout:
                 return -TARGET_EINVAL;
             lv = sizeof(lv);
             ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
-            if (ret < 0)
-                return ret;
-            if (len < sizeof(int) && len > 0 && val >= 0 && val < 255) {
-                len = 1;
-                if (put_user_u32(len, optlen)
-                    || put_user_u8(val, optval_addr))
-                    return -TARGET_EFAULT;
-            } else {
-                if (len > sizeof(int))
-                    len = sizeof(int);
-                if (put_user_u32(len, optlen)
-                    || put_user_u32(val, optval_addr))
-                    return -TARGET_EFAULT;
-            }
+            goto write_ret;
             break;
         default:
             ret = -TARGET_ENOPROTOOPT;
@@ -2986,8 +2986,14 @@ get_timeout:
             if (ret < 0) {
                 return ret;
             }
-            if (put_user_u32(lv, optlen)
-                || put_user_u32(val, optval_addr)) {
+            if (optval_addr) {
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                lv = 0;
+            }
+            if (put_user_u32(lv, optlen)) {
                 return -TARGET_EFAULT;
             }
             break;
-- 
2.53.0


