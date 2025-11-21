Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA7ECF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdCM-0001f9-GB; Fri, 21 Nov 2025 21:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd5W-0003bd-MF; Fri, 21 Nov 2025 21:11:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd51-0003bx-OZ; Fri, 21 Nov 2025 21:10:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E61B16C6ED;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E591E32198A;
 Fri, 21 Nov 2025 16:52:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [Stable-10.1.3 21/76] linux-user: permit sendto() with NULL buf and 0
 len
Date: Fri, 21 Nov 2025 16:50:59 +0300
Message-ID: <20251121135201.1114964-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

If you pass sendto() a NULL buffer, this is usually an error
(causing an EFAULT return); however if you pass a 0 length then
we should not try to validate the buffer provided. Instead we
skip the copying of the user data and possible processing
through fd_trans_target_to_host_data, and call the host syscall
with NULL, 0.

(unlock_user() permits a NULL buffer pointer for "do nothing"
so we don't need to special case the unlock code.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3102
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251028142001.3011630-1-peter.maydell@linaro.org>
(cherry picked from commit 0db2de22fcbf90adafab9d9dd1fc8203c66bfa75)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..c236b28345 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3583,7 +3583,7 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
                           abi_ulong target_addr, socklen_t addrlen)
 {
     void *addr;
-    void *host_msg;
+    void *host_msg = NULL;
     void *copy_msg = NULL;
     abi_long ret;
 
@@ -3591,16 +3591,19 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
         return -TARGET_EINVAL;
     }
 
-    host_msg = lock_user(VERIFY_READ, msg, len, 1);
-    if (!host_msg)
-        return -TARGET_EFAULT;
-    if (fd_trans_target_to_host_data(fd)) {
-        copy_msg = host_msg;
-        host_msg = g_malloc(len);
-        memcpy(host_msg, copy_msg, len);
-        ret = fd_trans_target_to_host_data(fd)(host_msg, len);
-        if (ret < 0) {
-            goto fail;
+    if (len != 0) {
+        host_msg = lock_user(VERIFY_READ, msg, len, 1);
+        if (!host_msg) {
+            return -TARGET_EFAULT;
+        }
+        if (fd_trans_target_to_host_data(fd)) {
+            copy_msg = host_msg;
+            host_msg = g_malloc(len);
+            memcpy(host_msg, copy_msg, len);
+            ret = fd_trans_target_to_host_data(fd)(host_msg, len);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
     if (target_addr) {
-- 
2.47.3


