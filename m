Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384CBCF07A0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 04:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sykb1-0005Jt-Vm; Thu, 10 Oct 2024 00:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kunwuchan@kernel>) id 1syj9o-0004JH-Kb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 22:44:04 -0400
Received: from [116.128.244.171] (helo=kernel)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kunwuchan@kernel>) id 1syj9l-0002of-NY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 22:44:04 -0400
Received: by kernel (Postfix, from userid 1000)
 id 3782A5808B8; Thu, 10 Oct 2024 10:35:09 +0800 (CST)
From: Kunwu <chentao@kylinos.cn>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	Kunwu <chentao@kylinos.cn>
Subject: [PATCH] tests/unit: Add a assert for
 test_io_channel_unix_listen_cleanup
Date: Thu, 10 Oct 2024 10:34:55 +0800
Message-ID: <20241010023455.40831-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 116.128.244.171 (deferred)
Received-SPF: none client-ip=116.128.244.171; envelope-from=kunwuchan@kernel;
 helo=kernel
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FSL_HELO_NON_FQDN_1=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HELO_NO_DOMAIN=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Oct 2024 00:16:11 -0400
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

Calling bind without checking return value. Add a assert for it.

Signed-off-by: Kunwu <chentao@kylinos.cn>
---
 tests/unit/test-io-channel-socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-io-channel-socket.c b/tests/unit/test-io-channel-socket.c
index b964bb202d..dc7be96e9c 100644
--- a/tests/unit/test-io-channel-socket.c
+++ b/tests/unit/test-io-channel-socket.c
@@ -506,7 +506,7 @@ static void test_io_channel_unix_listen_cleanup(void)
 {
     QIOChannelSocket *ioc;
     struct sockaddr_un un;
-    int sock;
+    int sock, ret = 0;
 
 #define TEST_SOCKET "test-io-channel-socket.sock"
 
@@ -519,7 +519,9 @@ static void test_io_channel_unix_listen_cleanup(void)
     un.sun_family = AF_UNIX;
     snprintf(un.sun_path, sizeof(un.sun_path), "%s", TEST_SOCKET);
     unlink(TEST_SOCKET);
-    bind(sock, (struct sockaddr *)&un, sizeof(un));
+    ret = bind(sock, (struct sockaddr *)&un, sizeof(un));
+    g_assert_cmpint(ret, ==, 0);
+
     ioc->fd = sock;
     ioc->localAddrLen = sizeof(ioc->localAddr);
     getsockname(sock, (struct sockaddr *)&ioc->localAddr,
-- 
2.43.0


