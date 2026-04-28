Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BBFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 21:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHqGU-0001NP-Eo; Tue, 28 Apr 2026 17:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHqGS-0001NC-Vn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 17:46:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHqGQ-0002RA-W0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 17:46:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D7F4143AFD;
 Tue, 28 Apr 2026 21:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D414C2BCAF;
 Tue, 28 Apr 2026 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777412792;
 bh=fUbUBNOS+gTd8SfUVwl+U29Q6KEI5N2CjiBhvCbj49U=;
 h=From:To:Cc:Subject:Date:From;
 b=MFV8gaR6hgWnDQI1ScvT+fZ74vt1iNqbp8scngknORj6GilZyl4R7oEGLKeKfHRQn
 8OiCsVRUBG51894hCqXeSmG8WECZF/KPjUKgrifvabdtJe4S10c2bX3c38qUzdb4n5
 ZeM80sainkrmJAAIEk3egoUnsnSuEQqc/A8g1+A2gY3NW8JBomBgV97lCfVO88qTLn
 3V2FZZn1jhHT5b7WQDObu5MNJN6j9ZcLlcbcU2EbIQUwnfuDJ+u6dBxJyfCbNWnH85
 lAyVC1MFRDE93C6PvSQIVT5M3LUsLb9XW1Xwa1YzcZ8OpaALor8HN6Xhu86fQ/ReiH
 c9BkQGBorwmHA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Allow getsockopt() with NULL optval address
Date: Tue, 28 Apr 2026 23:46:26 +0200
Message-ID: <20260428214626.13329-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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


