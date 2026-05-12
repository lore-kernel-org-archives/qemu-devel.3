Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E25CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuit-0004mJ-Ce; Tue, 12 May 2026 17:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuiN-00047M-Dn; Tue, 12 May 2026 17:32:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuhd-0002Fo-GK; Tue, 12 May 2026 17:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=gbm8nkzIZb3/sWf7kA6zr4NLx2XSe3RZeKjcEw48UgA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a6xMyPE+PlaXBz/4U7SZ3oR7Fw7X8jTPt4cWtbO9PHTAciaRNqZaDM9lnDHETZDjs
 se5IgB7u+X8WfNgIC7juz0sLUB97CGcwf3SXvoLJ1ueUKAhzEJR5lks4TijyoeTmvX
 ItcvQ2naE02DEdriEF+o7eqRplVeIbXd9Te/18arl3cGD+mhfPyD8sUnBWPXQ929Xf
 bpQ+iGfaPjp9XM32cfCFcRjWw++ze8B45qtQga8ILD0KFE/nmR8KZy1I/2spasDIx3
 JDYLXKXoEEwr7EyCFQYU8c1h2x/yDm1FXhucMBL43MRf3HzRlxQIXLGNd1yOZgKa7E
 6ACGW6LRAV0BQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C23E71AA3F4;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B36BF3ABD4C;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 41/58] linux-user: Allow getsockopt() with NULL optval
 address
Date: Tue, 12 May 2026 23:58:02 +0300
Message-ID: <20260512205820.361821-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit 08dc3e240fc00213c0eb29b71569dc0ca9301337)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


