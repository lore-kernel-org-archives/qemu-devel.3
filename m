Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F5CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Nzi-0006Y0-3V; Thu, 16 Oct 2025 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Nzf-0006Xd-5b
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9NzU-0001EL-IO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760621153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kOLRyuKs++0RiVEeUipv4OUAS1imZkhhXiB6IuStEz0=;
 b=XRpvLBacCsx6nyHldyxSx6Xee2TNL8dPVEOzQZfxEAYty7V6eazc4gSK5uZiMjgbxoE5cY
 ryFgFUzSs0oYWFsBLRURTOa1Bobdcqp9C1VC9Q9HMXNcOKHoVXrwRX21jx9WYt+5Cxxrls
 pyXcW7+oXFgQzpIBgn23mcfQ425mE28=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-30YR9ZVYOJWcKYbPuz05ew-1; Thu,
 16 Oct 2025 09:25:51 -0400
X-MC-Unique: 30YR9ZVYOJWcKYbPuz05ew-1
X-Mimecast-MFC-AGG-ID: 30YR9ZVYOJWcKYbPuz05ew_1760621151
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA2A195609E
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 13:25:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B645300019F; Thu, 16 Oct 2025 13:25:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests: use macros for registering char tests for sockets
Date: Thu, 16 Oct 2025 14:25:48 +0100
Message-ID: <20251016132548.1654627-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test-char.c has a couple of helper macros for registering tests that
need to be repeated for both IP and UNIX sockets. One test case was not
using the macro though.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-char.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index f30a39f61f..3c9f0a68e8 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1969,19 +1969,17 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
                          &client7 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
-                         &client8 ##name, char_socket_client_dupid_test)
+                         &client8 ##name, char_socket_client_dupid_test); \
+    g_test_add_data_func("/char/socket/server/two-clients/" # name,     \
+                         addr, char_socket_server_two_clients_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
         SOCKET_CLIENT_TEST(tcp, &tcpaddr);
-        g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
-                             char_socket_server_two_clients_test);
     }
 #ifndef WIN32
     SOCKET_SERVER_TEST(unix, &unixaddr);
     SOCKET_CLIENT_TEST(unix, &unixaddr);
-    g_test_add_data_func("/char/socket/server/two-clients/unix", &unixaddr,
-                         char_socket_server_two_clients_test);
 #endif
 
     g_test_add_func("/char/udp", char_udp_test);
-- 
2.50.1


