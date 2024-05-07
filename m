Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F00C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPc-0003k4-V5; Tue, 07 May 2024 04:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPO-0003TI-J8; Tue, 07 May 2024 04:42:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPK-0003Dr-K6; Tue, 07 May 2024 04:42:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CBB7864BC9;
 Tue,  7 May 2024 11:42:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BD398C85B2;
 Tue,  7 May 2024 11:42:29 +0300 (MSK)
Received: (nullmailer pid 1026527 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [Stable-8.2.4 05/16] linux-user: do_setsockopt: fix
 SOL_ALG.ALG_SET_KEY
Date: Tue,  7 May 2024 11:42:04 +0300
Message-Id: <20240507084226.1026455-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This setsockopt accepts zero-lengh optlen (current qemu implementation
does not allow this).  Also, there's no need to make a copy of the key,
it is enough to use lock_user() (which accepts zero length already).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2197
Fixes: f31dddd2fc "linux-user: Add support for setsockopt() option SOL_ALG"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-2-mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 04f6fb897a5aeb3e356a7b889869c9962f9c16c7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c75e3b4e..2b1a3ee094 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2277,18 +2277,13 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         switch (optname) {
         case ALG_SET_KEY:
         {
-            char *alg_key = g_malloc(optlen);
-
+            char *alg_key = lock_user(VERIFY_READ, optval_addr, optlen, 1);
             if (!alg_key) {
-                return -TARGET_ENOMEM;
-            }
-            if (copy_from_user(alg_key, optval_addr, optlen)) {
-                g_free(alg_key);
                 return -TARGET_EFAULT;
             }
             ret = get_errno(setsockopt(sockfd, level, optname,
                                        alg_key, optlen));
-            g_free(alg_key);
+            unlock_user(alg_key, optval_addr, optlen);
             break;
         }
         case ALG_SET_AEAD_AUTHSIZE:
-- 
2.39.2


