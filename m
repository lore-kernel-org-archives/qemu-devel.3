Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJCiY+n6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNULu-0008I1-V5; Sun, 01 Nov 2026 07:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNULK-0007zT-39
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNULG-0003Zm-9g
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26/s8sEZNBXIsx5Wr5/GaGGm1a/rnBlrK+go4bjG/jM=;
 b=HJCiY+n6VZzFCFsecILlMOTlyhk+edMI325bNxccPRh80Q5dAPfAtbsbvSD57IW90Ojtqw
 J0YQ3iNfE1za+7Tx1+U9TynCnUp0snDivVtJ755vvvoEGfh3ltbWGbq/zX8mlzXGD6aCYK
 /MZZ7/WvJaj/U6ubDYyaw2OPucok1eQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-RgYkRBRxMlaEYdh-f6Phyg-1; Sun,
 01 Nov 2026 07:07:14 -0500
X-MC-Unique: RgYkRBRxMlaEYdh-f6Phyg-1
X-Mimecast-MFC-AGG-ID: RgYkRBRxMlaEYdh-f6Phyg_1793534833
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D09921956059; Sun,  1 Nov 2026 12:07:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D95941956088; Sun,  1 Nov 2026 12:07:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:42 +0400
Subject: [GIT PULL 9/9] io: report a warning when a file channel is created
 from a stdio fd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-9-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VuyJ8aQWu3Y1CNMB49n9YLvC65L+XUt0Y2YzxF4G9po=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytO5p4HMacBhWGptP4SYrvtyOuWVu27308JR
 yPfndzAVPmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5UntD/9SVyznw1LeLXHVaRiVqi5u2m5pUtDxoW76lIuWTW5k+Y2M8YtxpYnTWXVB8Q5AosnWy+q
 CYJnJ2lPezEN7WC4yIE7u7nRs0c9iXo3SOyCjXig4uUagwkcenEVbB1ilMvPx+pU2YHNGLi3x9j
 3WADIGn/efNGucmJanE8IO8TvhWaU/+SIDI7B7lx1s8XZtPd7+2coSd6q1ekWSicMVhMqMmJ9Ef
 Q3YbkZw6QGsON2H4urZaGzpJptFDO66lGNFwy4DkLdwfzEj4Ztt0nTZOmf1wMkp5fc3IzRbAvXl
 jdKP8NeMPHx3A9+XYsWvpUjuXcJnRf08G6WNKXQEQBNNskvHndm79zQ25qruWj6BGE5UbuW64Ls
 PVvCWYrPnsdvFPTzomlTd6liXbisEWKbWvQyYOjGCoTNJHWiLbJ1oU8XcQsNWKxi39X4LcfRHAm
 Cdmx0GD2HaMRmJB5KC9jOECIIECALkLJDkDlqcr4PRSKVuLhqiG0qRPX0MyFMhs295YoQAvnaNL
 xHj603iEtWAFdo9N1esEFL6WQzY3ZxoPLdDgRHhInWa3L4ceTEQvR5XDHg0wOflpSyCZa2CjMPs
 o2ZnOZ4/0GmpDOJO2xCdWOgaNZcM8N127gcq5idDGEschR/gfCoBbusCoJ482SLPpQimiykcLco
 b74j02ovfvpCQnw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Filip Hejsek <filip.hejsek@gmail.com>

A channel closes its fd when the last reference to it is dropped.
Closing stdio fds is typically unwanted, so warn when they are passed to
qio_channel_file_new_fd().

Change the documentation of qio_channel_file_new_fd() to explicitly say
that passing stdio descriptors is incorrect.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261017-fix-stdio-close-v3-2-cfff0122a2a4@gmail.com>
---
 include/io/channel-file.h | 12 ++++++++----
 io/channel-file.c         |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index d373a4e44d9d..6a6776ff8e79 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -58,10 +58,14 @@ struct QIOChannelFile {
  * should be used instead, as this provides greater
  * functionality and cross platform portability.
  *
- * The channel will own the passed in file descriptor
- * and will take responsibility for closing it, so the
- * caller must not close it. If appropriate the caller
- * should dup() its FD before opening the channel.
+ * The channel will own the file descriptor that was
+ * passed to it and will take responsibility for closing
+ * it. This means the caller must not close it, and must
+ * not pass in descriptors that will remain in use after
+ * the channel is destroyed. In particular, @fd must
+ * not be one of the stdin/stdout/stderr descriptors. If
+ * requiring a channel to wrap a descriptor that should
+ * remain open, use qio_channel_file_new_dupfd() instead.
  *
  * Returns: the new channel object
  */
diff --git a/io/channel-file.c b/io/channel-file.c
index 5cef75a67c62..4c9da6619b9b 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,6 +23,7 @@
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
@@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
 {
     QIOChannelFile *ioc;
 
+    if (fd <= STDERR_FILENO) {
+        warn_report("potential bug: creating a channel from stdio fd %d; "
+                    "the fd will be closed when the channel is destroyed", fd);
+    }
+
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
     ioc->fd = fd;

-- 
2.56.0.116.g6de20f6092dc


