Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F70BCFC5E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvz-0007Rq-1S; Thu, 10 Oct 2024 12:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvy-0007Qu-1l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvw-0004T4-L1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VWloR28x5LlrrjeHXM5rNK/TmM9ut1vbut5rV1y9TI=;
 b=E+hjDdcU+nhaXIXhjuIGmU67scS7djBMVLwdO4oLZck7teiOkj/RHAyYwDMIaWIp2+Q/mP
 WLkH98nfDLu3CnGhlpWk68XTG69rES0G4o6pWDqp6yynMEnW6AX3CeGwdIVOTW7srOhkQh
 vXBSV8DIt7ySMBnLQ1wnqY6NiwKrd6g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-TO1zahhzMzK7hEhE_eXDrw-1; Thu,
 10 Oct 2024 12:22:33 -0400
X-MC-Unique: TO1zahhzMzK7hEhE_eXDrw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DF51955BC9; Thu, 10 Oct 2024 16:22:32 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17D4D300019E; Thu, 10 Oct 2024 16:22:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/17] tests/unit: Add a assert for
 test_io_channel_unix_listen_cleanup
Date: Thu, 10 Oct 2024 17:20:24 +0100
Message-ID: <20241010162024.988284-18-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kunwu <chentao@kylinos.cn>

Calling bind without checking return value. Add a assert for it.

Signed-off-by: Kunwu <chentao@kylinos.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


