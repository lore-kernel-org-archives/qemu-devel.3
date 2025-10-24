Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F02CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHif-00060x-Qh; Fri, 24 Oct 2025 09:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHiK-0005bn-2q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHiI-0004pa-9i
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761312013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Aun0N/wVasItP7YaAzv4+UXwONU7Qt1vFFTlbtlkBk=;
 b=CJqy6GVFsf8XUObyxcJNRrYPkiwqQOh3n7DG2Qx/8bcQXZrBTnQaTykLEYg8oI23k+gAox
 YqY3vjWgRCmNxDRq3s0V5ZPSKnrH+ElDQLSDk5AqUKa8g/o19CJdNfHQzqxSY/BPP1nt6H
 gEAHy6cRQm/HIgacGzgWaxVtti/XyDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-MBUUOKeJPE-8SoSlRZ6pDw-1; Fri,
 24 Oct 2025 09:20:11 -0400
X-MC-Unique: MBUUOKeJPE-8SoSlRZ6pDw-1
X-Mimecast-MFC-AGG-ID: MBUUOKeJPE-8SoSlRZ6pDw_1761312011
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD1D1800C36; Fri, 24 Oct 2025 13:20:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6611D19540EB; Fri, 24 Oct 2025 13:20:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 13/13] crypto: switch to newer gnutls API for distinguished name
Date: Fri, 24 Oct 2025 14:19:37 +0100
Message-ID: <20251024131937.56673-14-berrange@redhat.com>
In-Reply-To: <20251024131937.56673-1-berrange@redhat.com>
References: <20251024131937.56673-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The new API automatically allocates the right amount of memory
to hold the distinguished name, avoiding the need to loop and
realloc.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 8c0bf457ad..92fe4f0380 100644
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


