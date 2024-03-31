Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E244BCD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 10:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqs6d-0005FN-Ks; Sun, 31 Mar 2024 06:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6M-0005CO-Qk
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rqs6K-0000y9-VK
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 06:07:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DB1A5A830;
 Sun, 31 Mar 2024 13:09:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4C45DA7B15;
 Sun, 31 Mar 2024 13:07:40 +0300 (MSK)
Received: (nullmailer pid 2724212 invoked by uid 1000);
 Sun, 31 Mar 2024 10:07:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH v2 1/4] linux-user/syscall: do_setsockopt: fix
 SOL_ALG.ALG_SET_KEY
Date: Sun, 31 Mar 2024 13:07:34 +0300
Message-Id: <20240331100737.2724186-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240331100737.2724186-1-mjt@tls.msk.ru>
References: <20240331100737.2724186-1-mjt@tls.msk.ru>
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
---
 linux-user/syscall.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

v2: fix commit message wording

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e12d969c2e..5c7728cfd4 100644
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


