Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5271B108B8F1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Xr0-0000Ok-6l; Fri, 20 Mar 2026 07:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w3Xqz-0000OZ-0C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:17:21 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w3Xqx-0007RI-DO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:17:20 -0400
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id F100C3EB10;
 Fri, 20 Mar 2026 11:17:17 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id 1A9D9400D6;
 Fri, 20 Mar 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1774005436; bh=NF1N6jWbPBNkzq6/LF2CnCQ6R2bO0g8QTIr3v8BHue8=;
 h=From:To:Cc:Subject:Date:From;
 b=mmGeQf/821aI2i/ym+7bvemsjwNvUU72PI/wL+OlkRDMI8FI+i2+PCtyQ9laRP2gP
 F4M6BAc85YpwdIPV6j4wk/1LRDw+jeNXvbTdhI0h7FtExC5tMzXYETCeyy3SfhgodT
 iLzt43dDpc9ArM47OcHC9ZfdCbtEyXVUCOpJaM1Y=
Received: from ArchLinux-desktop (unknown [113.200.174.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2E27C41140;
 Fri, 20 Mar 2026 11:17:07 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@linaro.org, peter.maydell@linaro.org,
 Sun Haoyu <shyliuli@aosc.io>
Subject: [PATCH v3] linux-user: update select timeout writeback
Date: Fri, 20 Mar 2026 19:16:47 +0800
Message-ID: <20260320111647.138984-1-shyliuli@aosc.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 1A9D9400D6
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
Received-SPF: pass client-ip=149.56.97.132; envelope-from=shyliuli@aosc.io;
 helo=relay1.mymailcheap.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
Changes since v2:
  - move the Resolves: tag above Signed-off-by
  - ignore timeout writeback failures directly(to match kernel) and add comments
  - fix indentation in do_pselect6()
 linux-user/syscall.c | 45 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 064bc604c9..0a0c2fa1eb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1394,14 +1394,15 @@ static abi_long do_select(int n,
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
@@ -1529,14 +1530,16 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
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
@@ -1606,15 +1609,15 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
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
2.53.0


