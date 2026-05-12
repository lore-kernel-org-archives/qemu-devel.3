Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C67CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuHB-0005d6-8N; Tue, 12 May 2026 17:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFC-0000o8-OB; Tue, 12 May 2026 17:02:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuF6-0007SE-Jr; Tue, 12 May 2026 17:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=1/TSLzjAVYRRv/xzNNyBNBSMJT7PrimQSolihAgh+ZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uc86UziMEtirRkNjKJFenKAxX715FRnwXU49Lo9mMxt+AymtP5Da6gmKgcYLvPDy9
 Z9S6ehUTU+vLK7PbcZHDZVWFFxh145HIOdhZkXr9oqKwmJAtamapv9rMubGIJYpgLH
 E5voQmQTfY4hNih1UA0sGAHMzOEkMwaLPh+qmIjuzBxkXYONKKNsu4QvJDHq6PB2op
 5XGrtVKhlfnHR9hdt6fRmVhxDtTvy0iOiNiSE/eTiPLbEfP7qNSfawLOKTRStDFaKt
 SeXyCFHu7W8T4TGIiLLlMwkwOAUcBqf1Igy7eO76y9icTkWj2Xs/5eRC7OktHBdZbN
 ABn9BXqPsFnRQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7424D1AA319;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82AF53ABC8A;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 077/107] linux-user: Add setsockopt() for
 SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date: Tue, 12 May 2026 23:54:04 +0300
Message-ID: <20260512205437.360850-77-mjt@tls.msk.ru>
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
(cherry picked from commit edb4588309a753dea40f338fb8e02e3cfc2eed70)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ea1711ff95..d2c98b7237 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1147,7 +1147,6 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
-#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
 static inline abi_long copy_from_user_timeval64(struct timeval *tv,
                                                 abi_ulong target_tv_addr)
 {
@@ -1164,7 +1163,6 @@ static inline abi_long copy_from_user_timeval64(struct timeval *tv,
 
     return 0;
 }
-#endif
 
 static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
                                               const struct timeval *tv)
@@ -2395,6 +2393,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
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


