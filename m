Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVZo-00063O-Ca; Thu, 14 Aug 2025 06:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVZm-000632-O6
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:52:54 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVZc-0000ru-OC
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:52:54 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 6395E233B3;
 Thu, 14 Aug 2025 13:52:41 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] linux-user: prevent NULL dereference in
 do_sendrecvmsg_locked()
Date: Thu, 14 Aug 2025 13:52:08 +0300
Message-ID: <20250814105236.13344-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Denis Rastyogin <gerben@altlinux.org>

fd_trans_target_to_host_data() in do_sendrecvmsg_locked() may be
called when msg.msg_iov is NULL, for example when sending with
MSG_MORE and no actual iovec data is present. Dereferencing
msg.msg_iov in this case would lead to a NULL pointer access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Alexey Appolonov <alexey@altlinux.org>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59b2080b98..c7e6c53f08 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3300,7 +3300,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
     msg.msg_iov = vec;
 
     if (send) {
-        if (fd_trans_target_to_host_data(fd)) {
+        if (fd_trans_target_to_host_data(fd) && msg.msg_iov->iov_len) {
             void *host_msg;
 
             host_msg = g_malloc(msg.msg_iov->iov_len);
-- 
2.42.2


