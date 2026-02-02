Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64860E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn279-0005h0-IE; Mon, 02 Feb 2026 17:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn25u-0004ry-J4; Mon, 02 Feb 2026 17:08:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn25t-0002bS-7F; Mon, 02 Feb 2026 17:08:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8271D1852B7;
 Tue, 03 Feb 2026 01:07:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61AD635B3CA;
 Tue, 03 Feb 2026 01:08:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 10/56] linux-user: allow null `pathname` for
 statx()/fstatat()
Date: Tue,  3 Feb 2026 01:07:15 +0300
Message-ID: <20260202220805.945271-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
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

From: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>

Since Linux 6.11, the path argument may be NULL.

Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
perform the appropiate syscall and let the host's kernel handle null `pathname`.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
(cherry picked from commit 82ae60c8b5cb98d610056a1e2d0ba72e9ef7907c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..ee7c34027e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12141,9 +12141,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             int dirfd = arg1;
             int flags = arg3;
 
-            p = lock_user_string(arg2);
-            if (p == NULL) {
-                return -TARGET_EFAULT;
+            p = NULL;
+            /* Since Linux 6.11, the path argument may be NULL */
+            if (arg2 != 0) {
+                p = lock_user_string(arg2);
+                if (p == NULL) {
+                    return -TARGET_EFAULT;
+                }
             }
 #if defined(__NR_statx)
             {
-- 
2.47.3


