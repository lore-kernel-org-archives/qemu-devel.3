Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AE7CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzY4m-0002kT-Ik; Fri, 19 Sep 2025 06:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzY4k-0002jD-Ix
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzY4c-0007St-TN
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758276636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9nlTIL7ZY2QP2JpaM3AjUsx9DJ5uQxWhvcKzd0L4ZE=;
 b=E9mkJwexw/kDd3iXKW7oR7SOrKxwcpOF80uU9oVw6eWVV9JLPGTJAO3esv5VUikx26DQlp
 1OoZhqnXOk2lPokRvKo7u8QN8piHnh0uNLzCwJZ2lMGYSzufFjs4EFAGbq06TGtHIlHAbM
 5wkQrHHmqCafB5MG0BJdIZ+3zQ4tiMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-OCCRD-d2N-2LTgQfTIZ_nw-1; Fri,
 19 Sep 2025 06:10:34 -0400
X-MC-Unique: OCCRD-d2N-2LTgQfTIZ_nw-1
X-Mimecast-MFC-AGG-ID: OCCRD-d2N-2LTgQfTIZ_nw_1758276633
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6E318002C8
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 10:10:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E52CC1800446; Fri, 19 Sep 2025 10:10:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/6] crypto: switch to newer gnutls API for distinguished
 name
Date: Fri, 19 Sep 2025 11:10:21 +0100
Message-ID: <20250919101022.1491007-6-berrange@redhat.com>
In-Reply-To: <20250919101022.1491007-1-berrange@redhat.com>
References: <20250919101022.1491007-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The new API automatically allocates the right amount of memory
to hold the distinguished name, avoiding the need to loop and
realloc.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 86d407a142..0f86d1393f 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -409,20 +409,14 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
         }
 
         if (i == 0) {
-            size_t dnameSize = 1024;
-            session->peername = g_malloc(dnameSize);
-        requery:
-            ret = gnutls_x509_crt_get_dn(cert, session->peername, &dnameSize);
+            gnutls_datum_t dname = {};
+            ret = gnutls_x509_crt_get_dn2(cert, &dname);
             if (ret < 0) {
-                if (ret == GNUTLS_E_SHORT_MEMORY_BUFFER) {
-                    session->peername = g_realloc(session->peername,
-                                                  dnameSize);
-                    goto requery;
-                }
                 error_setg(errp, "Cannot get client distinguished name: %s",
                            gnutls_strerror(ret));
                 goto error;
             }
+            session->peername = (char *)g_steal_pointer(&dname.data);
             if (session->authzid) {
                 bool allow;
 
-- 
2.50.1


