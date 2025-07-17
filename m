Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8322C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLG9-0003Vu-PP; Thu, 17 Jul 2025 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0Y-0001rZ-GA; Thu, 17 Jul 2025 05:34:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0W-0001oW-ME; Thu, 17 Jul 2025 05:34:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 84EB9137CED;
 Thu, 17 Jul 2025 12:34:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 695D72491E7;
 Thu, 17 Jul 2025 12:34:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Geoffrey Thomas <geofft@ldpreload.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 45/65] linux-user: Hold the fd-trans lock across fork
Date: Thu, 17 Jul 2025 12:33:41 +0300
Message-ID: <20250717093412.728292-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Geoffrey Thomas <geofft@ldpreload.com>

If another thread is holding target_fd_trans_lock during a fork,
then the lock becomes permanently locked in the child and the
emulator deadlocks at the next interaction with the fd-trans table.
As with other locks, acquire the lock in fork_start() and release
it in fork_end().

Cc: qemu-stable@nongnu.org
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Fixes: c093364f4d91 "fd-trans: Fix race condition on reallocation of the translation table."
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2846
Buglink: https://github.com/astral-sh/uv/issues/6105
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250314124742.4965-1-geofft@ldpreload.com>
(cherry picked from commit e4e839b2eeea5745c48ce47144c7842eb7cd455f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index 910faaf237..e14f96059c 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -36,6 +36,16 @@ static inline void fd_trans_init(void)
     qemu_mutex_init(&target_fd_trans_lock);
 }
 
+static inline void fd_trans_prefork(void)
+{
+    qemu_mutex_lock(&target_fd_trans_lock);
+}
+
+static inline void fd_trans_postfork(void)
+{
+    qemu_mutex_unlock(&target_fd_trans_lock);
+}
+
 static inline TargetFdDataFunc fd_trans_target_to_host_data(int fd)
 {
     if (fd < 0) {
diff --git a/linux-user/main.c b/linux-user/main.c
index e2ec5970be..2cd867491b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,12 +149,14 @@ void fork_start(void)
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
     gdbserver_fork_start();
+    fd_trans_prefork();
 }
 
 void fork_end(pid_t pid)
 {
     bool child = pid == 0;
 
+    fd_trans_postfork();
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
-- 
2.47.2


