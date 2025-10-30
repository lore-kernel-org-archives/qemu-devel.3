Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A4CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyu-0001dZ-3n; Thu, 30 Oct 2025 10:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyq-0001ZF-Pz
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyc-0001gY-0h
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAZEG03ZQWoQ1rAmFed0mIn2oPfoyTflGi5QHhoCFX8=;
 b=G00qpNrQ1/bGI0FBKrE1rvmjsFiNVqAS4jYpSEy+ag0zCGnJskKiSY8RBzBs9vpxt7xBio
 AZMJJphW7LH2Pz25ckOsWUfrXu8hNLBagvR5vBu6B4n5zXd8yIcUct0RP8nVfvvsh1P4Fk
 vL5zsXGUzP0Ppa4A8E69GQzBA6tl8qU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-ac8s4WDCM7-8KQzk3tc-mg-1; Thu,
 30 Oct 2025 10:50:00 -0400
X-MC-Unique: ac8s4WDCM7-8KQzk3tc-mg-1
X-Mimecast-MFC-AGG-ID: ac8s4WDCM7-8KQzk3tc-mg_1761835799
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8671956078; Thu, 30 Oct 2025 14:49:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0668E30001A1; Thu, 30 Oct 2025 14:49:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 15/21] crypto: make TLS credentials structs private
Date: Thu, 30 Oct 2025 14:49:21 +0000
Message-ID: <20251030144927.2241109-16-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Now that the TLS session code no longer needs to look at the TLS
credential structs, they can be made private.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsanon.c |  3 +++
 crypto/tlscredspriv.h | 15 ---------------
 crypto/tlscredspsk.c  |  5 +++++
 crypto/tlscredsx509.c |  6 ++++++
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 0a728ccbf6..69ed1d792a 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -31,6 +31,9 @@
 
 #include <gnutls/gnutls.h>
 
+struct QCryptoTLSCredsAnon {
+    QCryptoTLSCreds parent_obj;
+};
 
 static int
 qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
index 4e6dffa22f..69dac02437 100644
--- a/crypto/tlscredspriv.h
+++ b/crypto/tlscredspriv.h
@@ -37,21 +37,6 @@ struct QCryptoTLSCreds {
     QCryptoTLSCredsBox *box;
 };
 
-struct QCryptoTLSCredsAnon {
-    QCryptoTLSCreds parent_obj;
-};
-
-struct QCryptoTLSCredsPSK {
-    QCryptoTLSCreds parent_obj;
-    char *username;
-};
-
-struct QCryptoTLSCredsX509 {
-    QCryptoTLSCreds parent_obj;
-    bool sanityCheck;
-    char *passwordid;
-};
-
 #ifdef CONFIG_GNUTLS
 
 int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 5568f1ad0c..e437985260 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -31,6 +31,11 @@
 
 #include <gnutls/gnutls.h>
 
+struct QCryptoTLSCredsPSK {
+    QCryptoTLSCreds parent_obj;
+    char *username;
+};
+
 static int
 lookup_key(const char *pskfile, const char *username, gnutls_datum_t *key,
            Error **errp)
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index ef31ea664c..2fc0872627 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -33,6 +33,12 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
 
+struct QCryptoTLSCredsX509 {
+    QCryptoTLSCreds parent_obj;
+    bool sanityCheck;
+    char *passwordid;
+};
+
 
 static int
 qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t cert,
-- 
2.51.1


