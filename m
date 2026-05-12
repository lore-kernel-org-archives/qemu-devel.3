Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDCECD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuD9-0004pq-92; Tue, 12 May 2026 17:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCF-0002dT-Ac; Tue, 12 May 2026 16:59:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuC8-0004u1-KE; Tue, 12 May 2026 16:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=4szf9KeFaSpwBZSdaC/N9VtSabWOEteAg35uAYTXR3A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M15e3Dd9/AIOOJpIk6clOArH0vmpJ0i6DEfgw4wbB5Y5LmM/lvdeTcVeKA9+8lT2J
 8JsWCfh2muU1Edlf4kX5lNl+5AciTg45W2MDRKMKsJzQil0bhNdM6TYC8GaL5kalh/
 JD788PyIHO0dyzW2Zzrzy7dEjh2ZsGXihsZYb9pbUkQ+6yB7xrY119Y4S1/OXoXznY
 aXGuYU2QJq6Dz1F0k1ZWSeA8lbzH8kqcTZzMtPhLgmG5azeiZxDdXfDe5YDypoeGuE
 DSv3n2qwuLJg9TBzy34oDJG4KYTyJ1zAo2QlMoDcO4EM4rUKlnRGgGDaRQueQCGVLB
 v4iMCkIVvJjXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 400DF1AA2FA;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4D9DC3ABC6B;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sun Haoyu <shyliuli@aosc.io>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 046/107] linux-user: update select timeout writeback
Date: Tue, 12 May 2026 23:53:33 +0300
Message-ID: <20260512205437.360850-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Sun Haoyu <shyliuli@aosc.io>

The Linux kernel writes back the remaining timeout for select-family
syscalls in poll_select_finish(). If that writeback fails, it keeps
the original return value.

However, QEMU only writes back the timeout on success. If the writeback
fails, QEMU returns -TARGET_EFAULT. This can lose the remaining
timeout and change the return value.

Update do_select(), do_pselect6(), and do_ppoll() to always write back
the timeout to match the Linux kernel's behavior. If the timeout
writeback fails, keep the original return value.

Tested with the issue reproducer.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343
Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260320111647.138984-1-shyliuli@aosc.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 9b7d64686b82bb70315cc60e5630c70e27eef832)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3f61dd732c..44675076ca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1388,14 +1388,15 @@ static abi_long do_select(int n,
             return -TARGET_EFAULT;
         if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
             return -TARGET_EFAULT;
-
-        if (target_tv_addr) {
-            tv.tv_sec = ts.tv_sec;
-            tv.tv_usec = ts.tv_nsec / 1000;
-            if (copy_to_user_timeval(target_tv_addr, &tv)) {
-                return -TARGET_EFAULT;
-            }
-        }
+    }
+    if (target_tv_addr) {
+        tv.tv_sec = ts.tv_sec;
+        tv.tv_usec = ts.tv_nsec / 1000;
+        /*
+         * Like the kernel, we deliberately ignore possible
+         * failures writing back to the timeout struct.
+         */
+        copy_to_user_timeval(target_tv_addr, &tv);
     }
 
     return ret;
@@ -1523,14 +1524,16 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
         if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
             return -TARGET_EFAULT;
         }
+    }
+    if (ts_addr) {
+        /*
+         * Like the kernel, we deliberately ignore possible
+         * failures writing back to the timeout struct.
+         */
         if (time64) {
-            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
-            }
+            host_to_target_timespec64(ts_addr, &ts);
         } else {
-            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
-            }
+            host_to_target_timespec(ts_addr, &ts);
         }
     }
     return ret;
@@ -1600,15 +1603,15 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         if (set) {
             finish_sigsuspend_mask(ret);
         }
-        if (!is_error(ret) && arg3) {
+        if (arg3) {
+            /*
+             * Like the kernel, we deliberately ignore possible
+             * failures writing back to the timeout struct.
+             */
             if (time64) {
-                if (host_to_target_timespec64(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
+                host_to_target_timespec64(arg3, timeout_ts);
             } else {
-                if (host_to_target_timespec(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
+                host_to_target_timespec(arg3, timeout_ts);
             }
         }
     } else {
-- 
2.47.3


