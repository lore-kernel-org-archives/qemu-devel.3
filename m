Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A53CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuo1-0001VT-Ak; Mon, 03 Nov 2025 08:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunq-0001JN-PD
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunb-0004k5-A8
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCxLqJi7xD0AWowsjNt3hTZd2yiQP9cWMIJ/7CpO5+A=;
 b=JTYetYYRhw0jf48194H9szeBbZ/igBXK7W/GT4lmPa+eRq++wN6olS3RO1VWEyUEaU2ob8
 NUWcGtC7w7+Umu1u+r/+yFFTmwTZ4akrihrqozOgz2vMKb8RsvT/NvFUrO/OnmSgi7aE60
 uPd1jFuMmQFSi1WGOGvfxdmacTNKk9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-JqWFa9mANMuAuFQ08JG_TQ-1; Mon,
 03 Nov 2025 08:40:37 -0500
X-MC-Unique: JqWFa9mANMuAuFQ08JG_TQ-1
X-Mimecast-MFC-AGG-ID: JqWFa9mANMuAuFQ08JG_TQ_1762177236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34B231955F29; Mon,  3 Nov 2025 13:40:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19BB41800451; Mon,  3 Nov 2025 13:40:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 26/32] crypto: make TLS credentials structs private
Date: Mon,  3 Nov 2025 13:37:20 +0000
Message-ID: <20251103133727.423041-27-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsanon.c |  5 ++++-
 crypto/tlscredspriv.h | 15 ---------------
 crypto/tlscredspsk.c  |  5 +++++
 crypto/tlscredsx509.c |  6 ++++++
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 0a728ccbf6..646574d6ae 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -27,11 +27,14 @@
 #include "trace.h"
 
 
+struct QCryptoTLSCredsAnon {
+    QCryptoTLSCreds parent_obj;
+};
+
 #ifdef CONFIG_GNUTLS
 
 #include <gnutls/gnutls.h>
 
-
 static int
 qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
                             Error **errp)
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
index 5568f1ad0c..8879c84ea7 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -27,6 +27,11 @@
 #include "trace.h"
 
 
+struct QCryptoTLSCredsPSK {
+    QCryptoTLSCreds parent_obj;
+    char *username;
+};
+
 #ifdef CONFIG_GNUTLS
 
 #include <gnutls/gnutls.h>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 388ddb7f0e..397ff4caa9 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -28,6 +28,12 @@
 #include "trace.h"
 
 
+struct QCryptoTLSCredsX509 {
+    QCryptoTLSCreds parent_obj;
+    bool sanityCheck;
+    char *passwordid;
+};
+
 #ifdef CONFIG_GNUTLS
 
 #include <gnutls/gnutls.h>
-- 
2.51.1


