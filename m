Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22DACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuWt-0000FO-4t; Tue, 12 May 2026 17:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuWr-000056-Ix; Tue, 12 May 2026 17:20:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuWp-00007l-Ms; Tue, 12 May 2026 17:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619498; bh=favLerJjkR8u+IyO/lTJe1+072vjucbVd6lRH37CS3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BnwyEBQgITOrIPoUacjPPudMEtVB94B84GECWJR50N7AtbyRbiLFpS2VfY1d0L8uE
 fIDUSjMq5ZSFm/uu/xzDH6ifov2wOMOCPisessddCKYgX59jxHtzuFTppd+TF+FZWu
 WSpOVyOh/9DCS1PzTvPFnWHnmshZmHnCaKkHdXduIqATpyeI6DMge/yiDqVtWZrZfW
 veUkwb1mT9e6QpC+rhQTPV/vTVxC7jHibl6w5ZWNsVOjeVxGoAChXD29iIvDYh3Gmz
 YVUKyjOaUUU8cvy9IBQvuQbSBj5e9e4XuR6hbBpf+/MYYspVP/wgcLLxtsMQzclQRu
 ySc2lh5tQlnZQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8AB881AA3E4;
 Tue, 12 May 2026 23:58:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 993B83ABD3C;
 Tue, 12 May 2026 23:58:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 25/58] linux-user: Add setsockopt() for
 SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date: Tue, 12 May 2026 23:57:46 +0300
Message-ID: <20260512205820.361821-25-mjt@tls.msk.ru>
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

Add handlers for both sockopts which use 64-bit time_t from userspace.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/885
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit edb4588309a753dea40f338fb8e02e3cfc2eed70)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8e96cc26db..751e6eabe5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1143,7 +1143,6 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
-#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
 static inline abi_long copy_from_user_timeval64(struct timeval *tv,
                                                 abi_ulong target_tv_addr)
 {
@@ -1160,7 +1159,6 @@ static inline abi_long copy_from_user_timeval64(struct timeval *tv,
 
     return 0;
 }
-#endif
 
 static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
                                               const struct timeval *tv)
@@ -2391,6 +2389,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                                 &tv, sizeof(tv)));
                 return ret;
         }
+        case TARGET_SO_RCVTIMEO_NEW:
+        case TARGET_SO_SNDTIMEO_NEW:
+        {
+                struct timeval tv;
+
+                if (optlen != sizeof(struct target__kernel_sock_timeval)) {
+                    return -TARGET_EINVAL;
+                }
+
+                if (copy_from_user_timeval64(&tv, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET,
+                                optname == TARGET_SO_RCVTIMEO_NEW ?
+                                    SO_RCVTIMEO : SO_SNDTIMEO,
+                                &tv, sizeof(tv)));
+                return ret;
+        }
         case TARGET_SO_ATTACH_FILTER:
         {
                 struct target_sock_fprog *tfprog;
-- 
2.47.3


