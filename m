Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E27CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcgM-0000k1-Aq; Tue, 13 Oct 2026 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgG-0000hk-Tc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgD-0006Nd-QY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791898593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AW/WBkKw5EkC9vO5AaCWZlEGN2rI9RmHy1AePPOAqEg=;
 b=hlstTdFXYZpJfHNuKnhXn5Jx6rIyDj3dFCM35/Fo66qoQ5VHTxwGNqJtP28EdkGhezl0tC
 o9xqDz3DskbvQe1H9XPc3pQnYWm73qmfEsfQinVfLfjcIjvy/bv6u046q9bRCsdG7lm/tF
 VVdl/FWbKj6jxnlBROcWYwJQG/zq3IQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-aGFTmcCnOaiSosM2tobe6w-1; Tue,
 13 Oct 2026 13:36:31 +0000
X-MC-Unique: aGFTmcCnOaiSosM2tobe6w-1
X-Mimecast-MFC-AGG-ID: aGFTmcCnOaiSosM2tobe6w_1791898590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7952318009EA; Tue, 13 Oct 2026 13:36:30 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39E2A1956041; Tue, 13 Oct 2026 13:36:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/4] Revert "crypto: add tracing & warning about GNUTLS
 countermeasures"
Date: Tue, 13 Oct 2026 14:36:21 +0100
Message-ID: <20261013133622.993935-4-berrange@redhat.com>
In-Reply-To: <20261013133622.993935-1-berrange@redhat.com>
References: <20261013133622.993935-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 0db6f798024ea6f57ecf2020209b761b50a01d71.

The workaround for the GNUTLS bug was not correct and it was
decided to rely on GNUTLS being patched by distros instead,
or users manually disabling use of the problematic ciphers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c | 11 -----------
 crypto/trace-events |  1 -
 2 files changed, 12 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index b343d1a5956..9450c83d9c3 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "qemu/thread.h"
 #include "crypto/tlssession.h"
 #include "crypto/tlscredsanon.h"
@@ -572,20 +571,10 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
          * only have to protect against automatic rekeying
          * which doesn't trigger with CHACHA20
          */
-        trace_qcrypto_tls_session_parameters(
-            session,
-            session->requireThreadSafety,
-            gnutls_protocol_get_version(session->handle),
-            cipher);
-
         if (session->requireThreadSafety &&
             gnutls_protocol_get_version(session->handle) ==
             GNUTLS_TLS1_3 &&
             cipher != GNUTLS_CIPHER_CHACHA20_POLY1305) {
-            warn_report("WARNING: activating thread safety countermeasures "
-                        "for potentially broken GNUTLS with TLS1.3 cipher=%d",
-                        cipher);
-            trace_qcrypto_tls_session_bug1717_workaround(session);
             session->lockEnabled = true;
         }
 #endif
diff --git a/crypto/trace-events b/crypto/trace-events
index 771f9b8a6e8..9905ea261a9 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -23,7 +23,6 @@ qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
 qcrypto_tls_session_check_x509_dn(void *session, const char *dname) "TLS session check x509 distinguished name session=%p dname=%s"
 qcrypto_tls_session_parameters(void *session, int threadSafety, int protocol, int cipher) "TLS session parameters session=%p threadSafety=%d protocol=%d cipher=%d"
-qcrypto_tls_session_bug1717_workaround(void *session) "TLS session bug1717 workaround session=%p"
 
 # tls-cipher-suites.c
 qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
-- 
2.56.0


