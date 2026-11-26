Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=InWx0Jhb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWc15-0001L3-6v; Thu, 26 Nov 2026 11:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWc0r-0001FI-7z
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWc0o-00008a-A6
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795709270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r+/T5sojzmwmGAddGK2jCTDPemGITbEtqr1SdPYTXzc=;
 b=InWx0Jhbbip4Xeyqa0cp++dRcHT9eS/ySF7LPlfL3UoWmF0luVeV61bnxNS4WfdRPx4V9x
 rMcxx3pNcYGtIKXdKC73iq1n/wsg3GM3McvkS3rgWF5zlFF4+3FunNGORhVEexNl8YiZDi
 Wkru3RZOYQtUb7CiDH89FYgzv/lwUQM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-vfCQRdY-PWWvDn5IoMS52w-1; Thu,
 26 Nov 2026 16:07:48 +0000
X-MC-Unique: vfCQRdY-PWWvDn5IoMS52w-1
X-Mimecast-MFC-AGG-ID: vfCQRdY-PWWvDn5IoMS52w_1795709267
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97051944B2A; Thu, 26 Nov 2026 16:07:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 132091956045; Thu, 26 Nov 2026 16:07:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com
Subject: [PATCH for-12.0] tests/qtest: Speed up qmp_fd_receive() by doing
 fewer systemcalls
Date: Thu, 26 Nov 2026 17:07:43 +0100
Message-ID: <20261126160743.276957-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qmp_fd_receive() currently reads each byte individually via recv()
from the socket. For tests that do a lot of traffic via QMP, this
can be a significant overhead. Unfortunately, we cannot easily use
a buffer for storing characters here, since we don't know the amount
of characters in the current QMP reply yet, and thus we might read
into the next reply already, i.e. the data that is required for the
next call to qmp_fd_receive() instead. A buffer would be required to
be stored on the caller side, and implementing this would be a major
rework in this library and the code using it.

So this patch follows a slightly different approach instead: Read the
bytes into a buffer with MSG_PEEK first - this does not remove the
bytes from the socket queue yet. Then we try to consume as many bytes
from the buffer as possible until a full response has been recognized
or the buffer has been fully consumed. At the end, we then can
finally remove the amount of consumed bytes from the socket queue.

This improvement especially speeds up the device-introspect-test in
thorough mode.

Before the change:

 $ export QTEST_QEMU_BINARY=./qemu-system-aarch64
 $ time tests/qtest/device-introspect-test -m thorough >/dev/null

 real	5m8,861s
 user	2m37,489s
 sys	2m33,150s

With this change included:

 $ export QTEST_QEMU_BINARY=./qemu-system-aarch64
 $ time tests/qtest/device-introspect-test -m thorough >/dev/null

 real	3m21,598s
 user	2m11,187s
 sys	1m11,032s

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqmp.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/libqmp.c b/tests/qtest/libqmp.c
index cd12bd26782..9dddeb1eed5 100644
--- a/tests/qtest/libqmp.c
+++ b/tests/qtest/libqmp.c
@@ -68,23 +68,27 @@ QDict *qmp_fd_receive(int fd)
     qmp.response = NULL;
     json_message_parser_init(&qmp.parser, qmp_response, &qmp, NULL);
     while (!qmp.response) {
-        ssize_t len;
-        char c;
+        ssize_t len, consumed;
+        char buf[512];
 
-        len = recv(fd, &c, 1, 0);
-        if (len == -1 && errno == EINTR) {
-            continue;
-        }
-
-        if (len == -1 || len == 0) {
+        /* Get copy of the available data without removing it from the queue */
+        len = RETRY_ON_EINTR(recv(fd, buf, sizeof(buf), MSG_PEEK));
+        if (len <= 0) {
             fprintf(stderr, "Broken pipe\n");
             abort();
         }
 
+        for (consumed = 0; consumed < len && !qmp.response; consumed++) {
+            json_message_parser_feed(&qmp.parser, &buf[consumed], 1);
+        }
+
         if (log) {
-            g_assert(write(2, &c, 1) == 1);
+            g_assert(write(2, buf, consumed) == consumed);
         }
-        json_message_parser_feed(&qmp.parser, &c, 1);
+
+        /* Remove the handled characters from the queue */
+        len = RETRY_ON_EINTR(recv(fd, buf, consumed, 0));
+        g_assert_cmpint(len, ==, consumed);
     }
     if (log) {
         g_assert(write(2, "\n", 1) == 1);
-- 
2.56.1


