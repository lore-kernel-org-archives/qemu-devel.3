Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD963FF8870
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5d-0000WV-AW; Mon, 27 Apr 2026 17:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5c-0000US-4b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:02:00 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5a-0003Xr-GV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 84F86408CB;
 Mon, 27 Apr 2026 21:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0049C2BCB5;
 Mon, 27 Apr 2026 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323717;
 bh=9XG9CSjH8eRrdK70JCXl+tYP+K497/Yv9bzjW1OONfA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vOgd8LqqU4Ai550EcX4O1YzXwDtmmHmoxTkbcGtaC4N5Wp63GCSMBCkZEtgmVC/qM
 GlHrc0HCTNoUkSGFbAk084pL7j54dVx+/sdHI7EcxW49sk42suR4ylwkZ7hOedwob4
 UdvFPL9jmNJeNGvoyndn0B/uM/f7m69ahxgX53EIYpjtvo+VMMTX3DK0kb6rI24rLO
 qgxg5k/MG5q2Kl6SodUoupETVUIjS2u7DXZHvqVm45DCMR6/cwuwx0QdtHKoIwDd5B
 uQoMP7kSpkb1DKmI0u7YQXXGtH4CHDm4GAT2VFZ+w+8Uwh1n0gU/nPLArGl3WXxunw
 TUunFbgm2O4xA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 11/15] linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
Date: Mon, 27 Apr 2026 23:01:29 +0200
Message-ID: <20260427210133.6016-12-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
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
index 751e6eabe5..d0390e04b4 100644
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


