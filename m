Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39DFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5f-0000X7-3a; Mon, 27 Apr 2026 17:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5a-0000Rk-Sb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:58 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5Y-0003XX-Ec
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA53960138;
 Mon, 27 Apr 2026 21:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19298C2BCB6;
 Mon, 27 Apr 2026 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323715;
 bh=vV5gAp6A1fV7/G4QQ1bgHmKV5IUIINSjN34lG8oX+zU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yeo0ZjaMJb2GEWJP4V57ou8vfN083sjcZWbN+sPoPAEyWIi6PP//d9l/kqriOIoUr
 mKrY5bwshXFAtQaN3ajiJfLoWgCsDWgHnJep/iGkHRZ8Ss4fyQBzsp+atu4iGA5oKl
 WQB1D/3Lnjgyp/MBlkmr+j3Ddbmuehslip1Upc7Qd+RYWCoj3/B8vvV7IumdaOUpKy
 pjbhDWsT2k2AD83nf2thyXrWMH0mEkZ9m6odNaTyiNRS9eOEcV2z7VjFtqB7u2ZGN4
 SzbdSxUzrq2ZZroBlEstwVld/WJNSUATSg+Ab8f31IhTNSoctlu08KXjXEZx9F+YZr
 vaX282PRs9TwQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 10/15] linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
Date: Mon, 27 Apr 2026 23:01:28 +0200
Message-ID: <20260427210133.6016-11-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
2.53.0


