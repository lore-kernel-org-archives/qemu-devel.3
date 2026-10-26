Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCB606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PhkyGGZv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNix-00085p-DO; Mon, 26 Oct 2026 12:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLNiv-00085A-W8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLNiu-000282-H1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793032739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQiqAd9NKHNfo3bX8ALWmk3xy+44NVyeqVoynxplce4=;
 b=PhkyGGZvVTUg0DHoNIwywfoJVqOA8JHiNIUpGZ5/1KFycuqnIgtusM6pkskdoR+fbmtxBp
 tbtsranxnHHPkouy2sR+j1u3slJpQ51szPRyV92I0a19LD2kmGtI6OcHnrblu65uTq/9oL
 /sp3BQAHHllkOFgvEvJRIofOhONcS20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-lZlClCrsMD2zNGhgsJHwxw-1; Mon,
 26 Oct 2026 12:38:57 -0400
X-MC-Unique: lZlClCrsMD2zNGhgsJHwxw-1
X-Mimecast-MFC-AGG-ID: lZlClCrsMD2zNGhgsJHwxw_1793032736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49B4C1800635; Mon, 26 Oct 2026 16:38:56 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C86F7767; Mon, 26 Oct 2026 16:38:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] qtest: don't close listener socket in
 qtest_socket_accept
Date: Mon, 26 Oct 2026 16:38:49 +0000
Message-ID: <20261026163849.1045894-3-berrange@redhat.com>
In-Reply-To: <20261026163849.1045894-1-berrange@redhat.com>
References: <20261026163849.1045894-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The listener FD passed into qtest_socket_accept should be
considered owned by the caller, and thus is is inappropriate
and unusual to close it in the method.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 50487739ef9..0f701679745 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -134,7 +134,6 @@ static int qtest_socket_accept(QTestState *s, int sock)
                    (void *)&timeout, sizeof(timeout))) {
         fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
                 __func__, strerror(errno));
-        close(sock);
         return -1;
     }
 
@@ -142,7 +141,7 @@ static int qtest_socket_accept(QTestState *s, int sock)
         if (!qtest_probe_child(s)) {
             fprintf(stderr,
                     "child process unexpectedly exited, skipping socket accept\n");
-            goto cleanup;
+            return -1;
         }
 
         addrlen = sizeof(addr);
@@ -156,9 +155,6 @@ static int qtest_socket_accept(QTestState *s, int sock)
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
     }
 
- cleanup:
-    close(sock);
-
     return ret;
 }
 
@@ -566,6 +562,8 @@ void qtest_connect(QTestState *s)
     unlink(socket_path);
     unlink(qmp_socket_path);
     g_assert(s->fd >= 0 && s->qmp_fd >= 0);
+    close(s->sock);
+    close(s->qmpsock);
     s->sock = s->qmpsock = -1;
     /* ask endianness of the target */
     s->big_endian = qtest_query_target_endianness(s);
@@ -675,6 +673,7 @@ QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
 
     *sock_fd = qtest_socket_accept(qts, sock_fd_init);
 
+    close(sock_fd_init);
     unlink(sock_path);
     g_free(sock_path);
     rmdir(sock_dir);
-- 
2.56.0


