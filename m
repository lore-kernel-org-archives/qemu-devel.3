Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DC2E7AD41
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 06:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYeqy-00042V-Ck; Thu, 25 Dec 2025 01:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqt-00041v-5Y
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqr-00020G-Jq
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAF0A178B39;
 Thu, 25 Dec 2025 09:28:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 666C7340638;
 Thu, 25 Dec 2025 09:29:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/2] gdbstub: unlink the unix socket before bind()
Date: Thu, 25 Dec 2025 09:29:19 +0300
Message-ID: <20251225062919.685146-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225062919.685146-1-mjt@tls.msk.ru>
References: <20251225062919.685146-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is another variant of doing what v9.2.0-1561-gfccb744f41c6
"gdbstub: Try unlinking the unix socket before binding" did, but
that commit introduced dependency on qemu-sockets.c which is
more problematic for statically-linked qemu-user binaries.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 gdbstub/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5e920a9b51..a2327c6135 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -337,6 +337,7 @@ static int gdbserver_open_socket(const char *path)
 
     sockaddr.sun_family = AF_UNIX;
     pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
+    unlink(sockaddr.sun_path);
     ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
     if (ret < 0) {
         perror("bind socket");
-- 
2.47.3


