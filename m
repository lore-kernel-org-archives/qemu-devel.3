Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E321C27C65
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbWO-0000rL-J5; Mon, 10 Jun 2024 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGbWM-0000oB-8s
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGbWK-0006fg-UX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718012455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUt3RNcFP+1N+/OC3xkgYtbO9gKaPqJrN1h7+4a60yE=;
 b=edoV/6+KDK9Q/IOClGdfMESHu5p538qAAhy4qUksIRHHiI4VUfquUmYQkS1kmPALes/HIX
 /ZyF0kaYjiWHql8zXuuzjvQBHzTgHavhbysH54q5WPqYuwJOxfDbo3ikvbi4YVltyK3OQO
 Cj92UoDyJPBeHn8ixfXUCOMD8HMRQ8Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-i_ve-vPEN9WQxmjBm-n6bg-1; Mon,
 10 Jun 2024 05:40:54 -0400
X-MC-Unique: i_ve-vPEN9WQxmjBm-n6bg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F3219560B4
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:40:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 155D730000C3; Mon, 10 Jun 2024 09:40:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] crypto: avoid leak of ctx when bad cipher mode is given
Date: Mon, 10 Jun 2024 10:40:48 +0100
Message-ID: <20240610094049.851127-2-berrange@redhat.com>
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

This fixes Coverity CID-1546884

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-nettle.c.inc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
2.45.1


