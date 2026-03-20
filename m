Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9941B1093179
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 05:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3SrF-0000GG-OL; Fri, 20 Mar 2026 01:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w3SrE-0000Fu-EH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 01:57:16 -0400
Received: from relay3.mymailcheap.com ([217.182.119.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w3SrC-0007UY-Gw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 01:57:16 -0400
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 152433EC16;
 Fri, 20 Mar 2026 05:57:11 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id CE138400D5;
 Fri, 20 Mar 2026 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1773986230; bh=8eN7yNUG5kqkKBltS86n2uvYxdqFwVQ25wpBZnY3VFs=;
 h=From:To:Cc:Subject:Date:From;
 b=JYROJUhg63ZBN9Wc8yb756DnMpMvgdm4rtgmxwGOYbL3yA+E8kz5cbGNqfD1F5Wmc
 tIE7x+20HIw5gQMGsWfajNi63I4wWfnBrcjTi66sghJIvq4kT0BVMyz6N8A4FoaG/y
 DuitnJMvoMd5gAWvzRp2zw1tIE4Sq869S7gM/Aoc=
Received: from ArchLinux-desktop (unknown [113.200.174.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0EB0941347;
 Fri, 20 Mar 2026 05:57:04 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@linaro.org, peter.maydell@linaro.org,
 Sun Haoyu <shyliuli@aosc.io>
Subject: [PATCH v2] linux-user: update select timeout writeback
Date: Fri, 20 Mar 2026 13:57:00 +0800
Message-ID: <20260320055700.44715-1-shyliuli@aosc.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: CE138400D5
X-Spamd-Result: default: False [1.20 / 10.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
 R_SPF_ALLOW(-0.10)[+mx]; MIME_GOOD(-0.10)[text/plain];
 LOCAL_OUTBOUND(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[aosc.io:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=217.182.119.157; envelope-from=shyliuli@aosc.io;
 helo=relay3.mymailcheap.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Sun Haoyu <shyliuli@aosc.io>
From:  Sun Haoyu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343

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

Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
---
Changes since v1:
- write back the timeout in all cases
- handle do_select() too
- keep the original return value if timeout writeback fails

 linux-user/syscall.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 064bc604c9..877a3b8bb6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1394,13 +1394,12 @@ static abi_long do_select(int n,
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
+    }
+    if (target_tv_addr) {
+        tv.tv_sec = ts.tv_sec;
+        tv.tv_usec = ts.tv_nsec / 1000;
+        if (copy_to_user_timeval(target_tv_addr, &tv)) {
+            return ret;
         }
     }
 
@@ -1529,16 +1528,18 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
         if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
             return -TARGET_EFAULT;
         }
+    }
+    if (ts_addr) {
         if (time64) {
-            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
+            if (host_to_target_timespec64(ts_addr, &ts)) {
+                return ret;
             }
         } else {
-            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
+            if (host_to_target_timespec(ts_addr, &ts)) {
+                return ret;
             }
         }
-    }
+     }
     return ret;
 }
 #endif
@@ -1606,14 +1607,14 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         if (set) {
             finish_sigsuspend_mask(ret);
         }
-        if (!is_error(ret) && arg3) {
+        if (arg3) {
             if (time64) {
                 if (host_to_target_timespec64(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
+                    return ret;
                 }
             } else {
                 if (host_to_target_timespec(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
+                    return ret;
                 }
             }
         }
-- 
2.53.0

