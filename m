Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3951CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 19:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5qSq-0008J2-Fp; Mon, 06 Oct 2025 15:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v5qSo-0008Iq-Uq
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 15:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v5qSn-0006dX-7E
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 15:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759777294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i4SiicJfoLpQWUBun5rd/A5eC/bV+HBz9zrYe3OLdqs=;
 b=TwFHAYMr5suWhYMPP3Z2ST6rehBSv/X5rgOnKqsX3CrrGycOfD+F6QtuLls0i/2BXo5jie
 WUbJlCzqzjD6d2ZRuHzvkt1nFww2pz1wM0PSmmuFRXPO8PGm0UB99P20WUJt9lbLMAol1A
 jdBEmGubqUEpJtkb1On7TI9xb8ix1LY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-4wzRnpufN8q93gfYNcAf_A-1; Mon,
 06 Oct 2025 15:01:32 -0400
X-MC-Unique: 4wzRnpufN8q93gfYNcAf_A-1
X-Mimecast-MFC-AGG-ID: 4wzRnpufN8q93gfYNcAf_A_1759777291
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6798D1800378
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 19:01:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8F2C18004D8; Mon,  6 Oct 2025 19:01:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH] crypto: propagate Error object on premature termination
Date: Mon,  6 Oct 2025 20:01:26 +0100
Message-ID: <20251006190126.4159590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The way that premature termination was handled in TLS connections was
changed to handle an ordering problem during graceful shutdown in the
migration code.

Unfortunately one of the codepaths returned -1 to indicate an error
condition, but failed to set the 'errp' parameter.

This broke error handling in the qio_channel_tls_handshake function,
as the QTask callback would no longer see that an error was raised.
As a result, the client will go on to try to use the already closed
TLS connection, resulting in misleading errors.

This was evidenced in the I/O test 233 which showed changes such as

-qemu-nbd: Certificate does not match the hostname localhost
+qemu-nbd: Failed to read initial magic: Unable to read from socket: Connection reset by peer

Fixes: 7e0c22d585581b8083ffdeb332ea497218665daf
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c |  8 +++++---
 io/channel-tls.c    | 13 +++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index ac38c2121d..8c0bf457ad 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -569,8 +569,6 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
             return QCRYPTO_TLS_SESSION_ERR_BLOCK;
-        } else if (ret == GNUTLS_E_PREMATURE_TERMINATION) {
-            return QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION;
         } else {
             if (session->rerr) {
                 error_propagate(errp, session->rerr);
@@ -580,7 +578,11 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
                            "Cannot read from TLS channel: %s",
                            gnutls_strerror(ret));
             }
-            return -1;
+            if (ret == GNUTLS_E_PREMATURE_TERMINATION) {
+                return QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION;
+            } else {
+                return -1;
+            }
         }
     }
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 1fbed4be0c..70fad38d18 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -368,6 +368,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
                                      int flags,
                                      Error **errp)
 {
+    ERRP_GUARD();
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
     size_t i;
     ssize_t got = 0;
@@ -384,13 +385,13 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
             } else {
                 return QIO_CHANNEL_ERR_BLOCK;
             }
-        } else if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION) {
-            if (qio_channel_tls_allow_premature_termination(tioc, flags)) {
-                ret = 0;
-            } else {
-                return -1;
-            }
         } else if (ret < 0) {
+            if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION &&
+                qio_channel_tls_allow_premature_termination(tioc, flags)) {
+                error_free(*errp);
+                *errp = NULL;
+                return got;
+            }
             return -1;
         }
         got += ret;
-- 
2.50.1


