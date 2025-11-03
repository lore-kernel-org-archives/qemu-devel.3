Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0240CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFumO-0006AX-Vg; Mon, 03 Nov 2025 08:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFumM-00067T-7c
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFumC-0004RL-LP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXlhMf24msb4QmxjXAJv263wvcrp1Cy7Eu1TPVgVg50=;
 b=P7moU19mhuUrzHTEpO2cL0ThoRuMap10JLaAW+r4xavC6cmKRDfChLLBKnQTONpzQOpZNN
 +0fnHdIHvckILRDeEKpBIhZwxkM/T+MlKovmzaiNgqpKZmxmTPRK1IE+ENCj9qL1yw0fMU
 VJKGSSNu2hqgE+Ry9V12wSC61wGctf8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-MHp1WjQPOzaXDf_QWIsTiw-1; Mon,
 03 Nov 2025 08:39:10 -0500
X-MC-Unique: MHp1WjQPOzaXDf_QWIsTiw-1
X-Mimecast-MFC-AGG-ID: MHp1WjQPOzaXDf_QWIsTiw_1762177149
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AA351954B0D; Mon,  3 Nov 2025 13:39:09 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BFCC1800576; Mon,  3 Nov 2025 13:39:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 12/32] crypto: remove redundant parameter checking CA certs
Date: Mon,  3 Nov 2025 13:37:06 +0000
Message-ID: <20251103133727.423041-13-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The only caller of qcrypto_tls_creds_check_authority_chain always
passes 'true' for the 'isCA' parameter. The point of this method
is to check the CA chani, so no other value would ever make sense.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index db2b74bafa..847fd4d9fa 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -315,7 +315,6 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         unsigned int ncacerts,
                                         const char *cacertFile,
                                         bool isServer,
-                                        bool isCA,
                                         Error **errp)
 {
     gnutls_x509_crt_t cert_to_check = certs[ncerts - 1];
@@ -356,7 +355,7 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
              */
             return qcrypto_tls_creds_check_cert(
                 creds, cert_to_check, cacertFile,
-                isServer, isCA, errp);
+                isServer, true, errp);
         }
         for (int i = 0; i < ncacerts; i++) {
             if (gnutls_x509_crt_check_issuer(cert_to_check,
@@ -370,7 +369,7 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
         }
 
         if (qcrypto_tls_creds_check_cert(creds, cert_issuer, cacertFile,
-                                         isServer, isCA, errp) < 0) {
+                                         isServer, true, errp) < 0) {
             return -1;
         }
 
@@ -534,7 +533,7 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
                                                 certs, ncerts,
                                                 cacerts, ncacerts,
                                                 cacertFile, isServer,
-                                                true, errp) < 0) {
+                                                errp) < 0) {
         goto cleanup;
     }
 
-- 
2.51.1


