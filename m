Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604EFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLIA-0008Ur-Tt; Thu, 17 Jul 2025 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0c-0001t1-It; Thu, 17 Jul 2025 05:34:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0a-0001pA-1X; Thu, 17 Jul 2025 05:34:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A92E0137CEF;
 Thu, 17 Jul 2025 12:34:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8BDF62491E9;
 Thu, 17 Jul 2025 12:34:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 47/65] linux-user: Use qemu_set_cloexec() to mark
 pidfd as FD_CLOEXEC
Date: Thu, 17 Jul 2025 12:33:43 +0300
Message-ID: <20250717093412.728292-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In the linux-user do_fork() function we try to set the FD_CLOEXEC
flag on a pidfd like this:

    fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL) | FD_CLOEXEC);

This has two problems:
 (1) it doesn't check errors, which Coverity complains about
 (2) we use F_GETFL when we mean F_GETFD

Deal with both of these problems by using qemu_set_cloexec() instead.
That function will assert() if the fcntls fail, which is fine (we are
inside fork_start()/fork_end() so we know nothing can mess around
with our file descriptors here, and we just got this one from
pidfd_open()).

(As we are touching the if() statement here, we correct the
indentation.)

Coverity: CID 1508111
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250711141217.1429412-1-peter.maydell@linaro.org>
(cherry picked from commit d6390204c61e148488f034d1f79be35cd3318d93)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a8eea5dd52..3a25abfaca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6746,10 +6746,9 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 int pid_child = ret;
                 pid_fd = pidfd_open(pid_child, 0);
                 if (pid_fd >= 0) {
-                        fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL)
-                                               | FD_CLOEXEC);
+                    qemu_set_cloexec(pid_fd);
                 } else {
-                        pid_fd = 0;
+                    pid_fd = 0;
                 }
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
-- 
2.47.2


