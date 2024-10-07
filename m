Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38552CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtEJ-0004R8-No; Mon, 07 Oct 2024 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEB-00049q-Mq; Mon, 07 Oct 2024 15:17:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEA-00043n-2i; Mon, 07 Oct 2024 15:17:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2DF3996241;
 Mon,  7 Oct 2024 22:16:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0708914F722;
 Mon,  7 Oct 2024 22:16:55 +0300 (MSK)
Received: (nullmailer pid 2592715 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 05/32] crypto: avoid leak of ctx when bad cipher mode
 is given
Date: Mon,  7 Oct 2024 22:16:22 +0300
Message-Id: <20241007191654.2592616-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Fixes: Coverity CID 1546884
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 586ac2c67d707c2588766c5195d94fa553cc25af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 42b39e18a2..766de036ba 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -734,16 +734,19 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 #ifdef CONFIG_CRYPTO_SM4
     case QCRYPTO_CIPHER_ALG_SM4:
         {
-            QCryptoNettleSm4 *ctx = g_new0(QCryptoNettleSm4, 1);
+            QCryptoNettleSm4 *ctx;
+            const QCryptoCipherDriver *drv;
 
             switch (mode) {
             case QCRYPTO_CIPHER_MODE_ECB:
-                ctx->base.driver = &qcrypto_nettle_sm4_driver_ecb;
+                drv = &qcrypto_nettle_sm4_driver_ecb;
                 break;
             default:
                 goto bad_cipher_mode;
             }
 
+            ctx = g_new0(QCryptoNettleSm4, 1);
+            ctx->base.driver = drv;
             sm4_set_encrypt_key(&ctx->key[0], key);
             sm4_set_decrypt_key(&ctx->key[1], key);
 
-- 
2.39.5


