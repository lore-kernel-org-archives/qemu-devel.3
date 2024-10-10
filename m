Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0927ACFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvc-0006x0-7y; Thu, 10 Oct 2024 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvb-0006wm-7M
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvZ-0004QH-HD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlcye8U6lIEWR6s8iqREBL6HF/0bNUW/INWT6JsYYlA=;
 b=ZSEW7qcaX7SPtcO0UuYJ/KkTQrJEZKBaEkIJgP6Nz1rNbEtpHlJAZATxUEBHXqnij5RRC3
 34fQj1+AC5u84msgFBgJ8r57xiNggrNitjpINeVKsNdMTe+9VuJaOnXT6yTPppUwtVrOMJ
 w3vQDKCSoeB5MOn/7iVu7f+YckCAZWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-wSnt-zyxMXqh5QKm8jNJFQ-1; Thu,
 10 Oct 2024 12:22:07 -0400
X-MC-Unique: wSnt-zyxMXqh5QKm8jNJFQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B91C41977307; Thu, 10 Oct 2024 16:22:06 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D15130001A3; Thu, 10 Oct 2024 16:22:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/17] util/iov: Introduce iov_send_recv_with_flags()
Date: Thu, 10 Oct 2024 17:20:13 +0100
Message-ID: <20241010162024.988284-7-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

In order to support a new update function, a flag needs to be passed
to the kernel via the socket send call (MSG_MORE) to notify it that
more data is to be expected to calculate the hash correctly.

Add a new iov helper for this purpose.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Split iov changes from original patch
       - Checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/iov.h | 27 +++++++++++++++++++++++++++
 util/iov.c         | 25 ++++++++++++++++++-------
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 63a1c01965..44f9db5cee 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -1,6 +1,7 @@
 /*
  * Helpers for using (partial) iovecs.
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2010 Red Hat, Inc.
  *
  * Author(s):
@@ -75,6 +76,32 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
 size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
                   size_t offset, int fillc, size_t bytes);
 
+/*
+ * Send/recv data from/to iovec buffers directly, with the provided
+ * socket flags.
+ *
+ * `offset' bytes in the beginning of iovec buffer are skipped and
+ * next `bytes' bytes are used, which must be within data of iovec.
+ *
+ *   r = iov_send_recv_with_flags(sockfd, sockflags, iov, iovcnt,
+ *                                offset, bytes, true);
+ *
+ * is logically equivalent to
+ *
+ *   char *buf = malloc(bytes);
+ *   iov_to_buf(iov, iovcnt, offset, buf, bytes);
+ *   r = send(sockfd, buf, bytes, sockflags);
+ *   free(buf);
+ *
+ * For iov_send_recv_with_flags() _whole_ area being sent or received
+ * should be within the iovec, not only beginning of it.
+ */
+ssize_t iov_send_recv_with_flags(int sockfd, int sockflags,
+                                 const struct iovec *iov,
+                                 unsigned iov_cnt, size_t offset,
+                                 size_t bytes,
+                                 bool do_send);
+
 /*
  * Send/recv data from/to iovec buffers directly
  *
diff --git a/util/iov.c b/util/iov.c
index 7e73948f5e..7777116123 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -3,6 +3,7 @@
  *
  * Copyright IBM, Corp. 2007, 2008
  * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  *
  * Author(s):
  *  Anthony Liguori <aliguori@us.ibm.com>
@@ -92,7 +93,8 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt)
 
 /* helper function for iov_send_recv() */
 static ssize_t
-do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
+do_send_recv(int sockfd, int flags, struct iovec *iov, unsigned iov_cnt,
+             bool do_send)
 {
 #ifdef CONFIG_POSIX
     ssize_t ret;
@@ -102,8 +104,8 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
     msg.msg_iovlen = iov_cnt;
     do {
         ret = do_send
-            ? sendmsg(sockfd, &msg, 0)
-            : recvmsg(sockfd, &msg, 0);
+            ? sendmsg(sockfd, &msg, flags)
+            : recvmsg(sockfd, &msg, flags);
     } while (ret < 0 && errno == EINTR);
     return ret;
 #else
@@ -114,8 +116,8 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
     ssize_t off = 0;
     while (i < iov_cnt) {
         ssize_t r = do_send
-            ? send(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, 0)
-            : recv(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, 0);
+            ? send(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, flags)
+            : recv(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, flags);
         if (r > 0) {
             ret += r;
             off += r;
@@ -144,6 +146,15 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
 ssize_t iov_send_recv(int sockfd, const struct iovec *_iov, unsigned iov_cnt,
                       size_t offset, size_t bytes,
                       bool do_send)
+{
+    return iov_send_recv_with_flags(sockfd, 0, _iov, iov_cnt, offset, bytes,
+                                    do_send);
+}
+
+ssize_t iov_send_recv_with_flags(int sockfd, int sockflags,
+                                 const struct iovec *_iov,
+                                 unsigned iov_cnt, size_t offset,
+                                 size_t bytes, bool do_send)
 {
     ssize_t total = 0;
     ssize_t ret;
@@ -192,11 +203,11 @@ ssize_t iov_send_recv(int sockfd, const struct iovec *_iov, unsigned iov_cnt,
             assert(iov[niov].iov_len > tail);
             orig_len = iov[niov].iov_len;
             iov[niov++].iov_len = tail;
-            ret = do_send_recv(sockfd, iov, niov, do_send);
+            ret = do_send_recv(sockfd, sockflags, iov, niov, do_send);
             /* Undo the changes above before checking for errors */
             iov[niov-1].iov_len = orig_len;
         } else {
-            ret = do_send_recv(sockfd, iov, niov, do_send);
+            ret = do_send_recv(sockfd, sockflags, iov, niov, do_send);
         }
         if (offset) {
             iov[0].iov_base -= offset;
-- 
2.46.0


