Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C76C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbWT-0000sd-Q7; Mon, 10 Jun 2024 05:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGbWS-0000s9-7b
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGbWQ-0006g6-Qr
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718012462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8RgAG7w9rR08cyfdDveILRgszvGjShq/rsPofql0Dgo=;
 b=E5123+wsUXpH1GJQFkpOudIVUbhOm3ngZS/E/6VJ/lnEnZsbuL6YiL82bau7JA1AZkwt6V
 1DzHMoknPGBABzbaubnT001s25drjGshKOnS4KgrwU411ba4KUUkj07t1uG0ai3h3jBvCr
 npLhWjEvDO8JcoNecS1ehSkRusvdr7I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-t0qa8bf8ND2OiuK3ce4ovg-1; Mon,
 10 Jun 2024 05:40:55 -0400
X-MC-Unique: t0qa8bf8ND2OiuK3ce4ovg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB50C1956094; Mon, 10 Jun 2024 09:40:54 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 936E630000C3; Mon, 10 Jun 2024 09:40:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] crypto: use consistent error reporting pattern for
 unsupported cipher modes
Date: Mon, 10 Jun 2024 10:40:49 +0100
Message-ID: <20240610094049.851127-3-berrange@redhat.com>
In-Reply-To: <20240610094049.851127-1-berrange@redhat.com>
References: <20240610094049.851127-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Not all paths in qcrypto_cipher_ctx_new() were correctly distinguishing
between valid user input for cipher mode (which should report a user
facing error), vs program logic errors (which should assert).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-nettle.c.inc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 766de036ba..2654b439c1 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -525,8 +525,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             case QCRYPTO_CIPHER_MODE_CTR:
                 drv = &qcrypto_nettle_des_driver_ctr;
                 break;
-            default:
+            case QCRYPTO_CIPHER_MODE_XTS:
                 goto bad_cipher_mode;
+            default:
+                g_assert_not_reached();
             }
 
             ctx = g_new0(QCryptoNettleDES, 1);
@@ -551,8 +553,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             case QCRYPTO_CIPHER_MODE_CTR:
                 drv = &qcrypto_nettle_des3_driver_ctr;
                 break;
-            default:
+            case QCRYPTO_CIPHER_MODE_XTS:
                 goto bad_cipher_mode;
+            default:
+                g_assert_not_reached();
             }
 
             ctx = g_new0(QCryptoNettleDES3, 1);
@@ -663,8 +667,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             case QCRYPTO_CIPHER_MODE_CTR:
                 drv = &qcrypto_nettle_cast128_driver_ctr;
                 break;
-            default:
+            case QCRYPTO_CIPHER_MODE_XTS:
                 goto bad_cipher_mode;
+            default:
+                g_assert_not_reached();
             }
 
             ctx = g_new0(QCryptoNettleCAST128, 1);
@@ -741,8 +747,12 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             case QCRYPTO_CIPHER_MODE_ECB:
                 drv = &qcrypto_nettle_sm4_driver_ecb;
                 break;
-            default:
+            case QCRYPTO_CIPHER_MODE_CBC:
+            case QCRYPTO_CIPHER_MODE_CTR:
+            case QCRYPTO_CIPHER_MODE_XTS:
                 goto bad_cipher_mode;
+            default:
+                g_assert_not_reached();
             }
 
             ctx = g_new0(QCryptoNettleSm4, 1);
-- 
2.45.1


