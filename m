Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D55C79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOO-0003RX-Fi; Sun, 06 Sep 2026 13:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GON-0003QT-BJ
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOK-00005J-65
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TYpvM27APlCXaHYgzlxm1fs8WWfNqpBYwIFZDE/1HA=;
 b=fxUN1GQXbfeTf9WZaeO/G4BwY2Nny4X0OBuBweShHS18T6e6L56AvUe6iKAN2fTRyaPxxx
 gPMCw4AgjZX8/KL0Wo5yCw+jIq/MJ7DoV4FnmLQzj0g8iGqePT8ezrwC9JCs5yi+8S1l88
 cNN5mvXAmqolHzi7lxwVrjGRTg+brGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-lDNrr5uqMd-Qwu-ynDiy0A-1; Sun,
 06 Sep 2026 13:10:45 -0400
X-MC-Unique: lDNrr5uqMd-Qwu-ynDiy0A-1
X-Mimecast-MFC-AGG-ID: lDNrr5uqMd-Qwu-ynDiy0A_1788714644
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E99481955DC9; Sun,  6 Sep 2026 17:10:43 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 206431955F08; Sun,  6 Sep 2026 17:10:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/40] tests/qtest/aspeed-hace-utils: Replace g_printerr() with
 g_test_skip()
Date: Sun,  6 Sep 2026 19:09:48 +0200
Message-ID: <20260906171021.26568-8-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Skip a cipher unsupported by the crypto backend with g_test_skip() from
the test, instead of not registering it and printing a TAP "# skip" line,
so the qtest does not assume TAP output.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260831050213.381443-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 260eec043c73..d20562fac9cc 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -1248,11 +1248,18 @@ static void aspeed_test_crypto(const void *data)
 {
     const AspeedCryptoTest *c = data;
     const CryptTest *t = &crypt_tests[c->index];
-    QTestState *s = qtest_init(c->machine);
+    QTestState *s;
     uint8_t out[64];
     uint8_t iv[16];
     size_t iv_off;
 
+    if (!qcrypto_cipher_supports(t->alg, t->mode)) {
+        g_test_skip("cipher not supported by the crypto backend");
+        return;
+    }
+
+    s = qtest_init(c->machine);
+
     g_assert_cmpuint(t->len, <=, sizeof(out));
 
     /* Encrypt: ptext -> ctext */
@@ -1284,10 +1291,17 @@ static void aspeed_test_crypto_gcm(const void *data)
 {
     const AspeedCryptoTest *c = data;
     const CryptTest *t = &crypt_tests[c->index];
-    QTestState *s = qtest_init(c->machine);
+    QTestState *s;
     uint8_t out[64];
     uint8_t tag[16];
 
+    if (!qcrypto_cipher_supports(t->alg, t->mode)) {
+        g_test_skip("cipher not supported by the crypto backend");
+        return;
+    }
+
+    s = qtest_init(c->machine);
+
     g_assert_cmpuint(t->len, <=, sizeof(out));
 
     /* Encrypt: ptext -> ctext, then check the authentication tag. */
@@ -1318,12 +1332,6 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
             continue;
         }
 
-        if (!qcrypto_cipher_supports(crypt_tests[i].alg,
-                                     crypt_tests[i].mode)) {
-            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);
-            continue;
-        }
-
         path = g_strdup_printf("%s/hace/crypto/%s", prefix,
                                crypt_tests[i].name);
         t = g_new0(AspeedCryptoTest, 1);
-- 
2.55.0


