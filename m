Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EFDC83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 15:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmmq-0008GC-MJ; Fri, 18 Jul 2025 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeZ-00081C-4Y
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeX-0003tm-D3
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752851136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07b91aC/aI4E3jqLVjyomJbVeRNfXi6zLbmklxdTj2I=;
 b=be3esn0/y5MJ6tM3csO2u5VN92SybT73h6c8rBi8bj8F0ONJEMkgxGDrwcOsV2LeoZkuta
 dPyrEEhJGrnRPiqDYGiRrM1Yt9BW8bAEg038JftvP+58JN6TiWE2OXg4ehRpZ2HiuN18XD
 18oUqyas3TqYqUst/3/gLe3tWq9weH0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-AYGovDuQMHq716lmzrH1fQ-1; Fri,
 18 Jul 2025 11:05:32 -0400
X-MC-Unique: AYGovDuQMHq716lmzrH1fQ-1
X-Mimecast-MFC-AGG-ID: AYGovDuQMHq716lmzrH1fQ_1752851131
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A117A1956059; Fri, 18 Jul 2025 15:05:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BACF195609D; Fri, 18 Jul 2025 15:05:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 4/4] crypto: add tracing & warning about GNUTLS countermeasures
Date: Fri, 18 Jul 2025 16:05:14 +0100
Message-ID: <20250718150514.2635338-5-berrange@redhat.com>
In-Reply-To: <20250718150514.2635338-1-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We want some visibility on stderr when the GNUTLS thread
safety countermeasures are activated, to encourage people
to get the real fix deployed (once it exists). Some trace
points will also help if we see any further wierd crash
scenario we've not anticipated.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c | 10 ++++++++++
 crypto/trace-events |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 939f69bdb3..246cd6f7c0 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -615,10 +615,20 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
          * only have to protect against automatic rekeying
          * which doesn't trigger with CHACHA20
          */
+        trace_qcrypto_tls_session_parameters(
+            session,
+            session->requireThreadSafety,
+            gnutls_protocol_get_version(session->handle),
+            cipher);
+
         if (session->requireThreadSafety &&
             gnutls_protocol_get_version(session->handle) ==
             GNUTLS_TLS1_3 &&
             cipher != GNUTLS_CIPHER_CHACHA20_POLY1305) {
+            warn_report("WARNING: activating thread safety countermeasures "
+                        "for potentially broken GNUTLS with TLS1.3 cipher=%d",
+                        cipher);
+            trace_qcrypto_tls_session_bug1717_workaround(session);
             session->lockEnabled = true;
         }
 #endif
diff --git a/crypto/trace-events b/crypto/trace-events
index bccd0bbf29..d0e33427fa 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,6 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+qcrypto_tls_session_parameters(void *session, int threadSafety, int protocol, int cipher) "TLS session parameters session=%p threadSafety=%d protocol=%d cipher=%d"
+qcrypto_tls_session_bug1717_workaround(void *session) "TLS session bug1717 workaround session=%p"
 
 # tls-cipher-suites.c
 qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
-- 
2.50.1


