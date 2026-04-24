Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D14EFE51EE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCZ5-0001s7-Nh; Fri, 24 Apr 2026 05:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYb-0001eR-1W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYZ-0001I9-Fq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 314D242B6F;
 Fri, 24 Apr 2026 09:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E4AC2BCB4;
 Fri, 24 Apr 2026 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777021837;
 bh=JU1AMRxW1eiOJq992p/F16ioLlLN+qktUdFJFEi5Yrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gTnVQGD7b0ouwTeZSzziADKDkf6VfugEy2MaVxbIDwysiwGRa7cK0aNQKVFofnwVS
 Cb+5pHKzUUcFOiUXGx3IiJpqvaQehenhCrKvoiIVrH/mfgymqQdM+T8KALXvFCmgSt
 aNoW1e1CCS44pSPo62ZlpMx8Oiu7ZqxlHz4AfUmmiNt08XFHr1YJ1se094ZatOa79I
 d2WjBEIqh25wArQPBh66oBbxWGkoD2DkN5eHlNGzR5/aRj9iVUpGbPs7uwv+3DhUGl
 KjIBc/PH/diW6GfOp2DUye5Ul1mjzuL77q4cjNA2zbdkAP/MEHD2euEuDHLOgVvr/8
 1qGpHoDIW2icA==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/4] linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
Date: Fri, 24 Apr 2026 11:08:49 +0200
Message-ID: <20260424091024.23495-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091024.23495-1-deller@kernel.org>
References: <20260424091024.23495-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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
 linux-user/syscall.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 077ecb7554..7bd5ad548b 100644
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
2.53.0


