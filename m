Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD76CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGm-0003Yi-9R; Tue, 12 May 2026 17:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFX-0001Ga-W6; Tue, 12 May 2026 17:02:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFW-0007T1-8X; Tue, 12 May 2026 17:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=8qtCYuQfI++Z6qR7z8uRfyCP0yY4AcPXt1QMjS9zDdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H9rE72WjZxIz52gGyBrenKeArtUaj4P6AxDobMrfFG3v0xsud/jwMSaloLfk+FGE9
 M8dVytFhJ3VYbdCXEzfQgLU2cLvEexcvoKYxyZ3iWqX/f7R2Y8qrS8f2LyZCirkJ5x
 XxiN51G+rnweyt8a8A+gusEiA/z4nhpGy6R2PmlGJvjG6Uq3dRpbSqpj5Ds3I/Px0j
 fITq4Y55eje4MIkmYoHQjiJgZzTOxXHhSGajjNZbNwpT4xs/w10CcA/Y2kXKd9PLis
 PwO+DO0bSdYev0QzTWkquBuO+S1yhrVe6+OwRx+9jP2TGnijb4tBAFFAzt5q+RlkzS
 waUZeh/CbHRFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 800A91AA31A;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E5653ABC8B;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 078/107] linux-user: Add getsockopt() for
 SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date: Tue, 12 May 2026 23:54:05 +0300
Message-ID: <20260512205437.360850-78-mjt@tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Add handlers for both sockopts which use 64-bit time_t from userspace.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/885
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 07c7decaa54a83bd1656b2645074380714b83374)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d2c98b7237..76b655da2b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2625,7 +2625,8 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         /* These don't just return a single integer */
         case TARGET_SO_PEERNAME:
             goto unimplemented;
-        case TARGET_SO_RCVTIMEO: {
+        case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_RCVTIMEO_NEW: {
             struct timeval tv;
             socklen_t tvlen;
 
@@ -2645,11 +2646,17 @@ get_timeout:
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
@@ -2657,6 +2664,7 @@ get_timeout:
             break;
         }
         case TARGET_SO_SNDTIMEO:
+        case TARGET_SO_SNDTIMEO_NEW:
             optname = SO_SNDTIMEO;
             goto get_timeout;
         case TARGET_SO_PEERCRED: {
-- 
2.47.3


