Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABCDCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulu-0005dF-Av; Mon, 03 Nov 2025 08:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuls-0005bQ-Mo
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFull-0004Pv-Gt
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vB+z9X0RWqLhVPo+xQhEqFJ0ho+41w3tgdoPwu6fEfc=;
 b=brY8oROUe70S91fKXO8HmYg6QceTiDRg6PLgR645jHOVWZEq4H+BtRkLDQ2vCuUGPqF5dt
 +bMQjsT6jBk9+2iwxd0nRsESDhAiUE8DihWulOtCApd/XvbPxs844pxmXQC/55Maadli7n
 QU8tqkcwjJs7OKfb+xrNEtDOtphY/cw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-0u1huQr5OuuuyhG0MXkaYg-1; Mon,
 03 Nov 2025 08:38:43 -0500
X-MC-Unique: 0u1huQr5OuuuyhG0MXkaYg-1
X-Mimecast-MFC-AGG-ID: 0u1huQr5OuuuyhG0MXkaYg_1762177122
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30E2C1956096; Mon,  3 Nov 2025 13:38:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72FBB1800451; Mon,  3 Nov 2025 13:38:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 08/32] crypto: unconditionally enable gnutls XTS support
Date: Mon,  3 Nov 2025 13:37:02 +0000
Message-ID: <20251103133727.423041-9-berrange@redhat.com>
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

The XTS support required 3.6.8 which is older than our min
required version now.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-gnutls.c.inc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc
index b9450d48b0..a8263fff6d 100644
--- a/crypto/cipher-gnutls.c.inc
+++ b/crypto/cipher-gnutls.c.inc
@@ -23,10 +23,6 @@
 
 #include <gnutls/crypto.h>
 
-#if GNUTLS_VERSION_NUMBER >= 0x030608
-#define QEMU_GNUTLS_XTS
-#endif
-
 bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
                              QCryptoCipherMode mode)
 {
@@ -44,7 +40,6 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
         default:
             return false;
         }
-#ifdef QEMU_GNUTLS_XTS
     case QCRYPTO_CIPHER_MODE_XTS:
         switch (alg) {
         case QCRYPTO_CIPHER_ALGO_AES_128:
@@ -53,7 +48,6 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
         default:
             return false;
         }
-#endif
     default:
         return false;
     }
@@ -241,7 +235,6 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
     int err;
 
     switch (mode) {
-#ifdef QEMU_GNUTLS_XTS
     case QCRYPTO_CIPHER_MODE_XTS:
         switch (alg) {
         case QCRYPTO_CIPHER_ALGO_AES_128:
@@ -254,7 +247,6 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
             break;
         }
         break;
-#endif
 
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
-- 
2.51.1


