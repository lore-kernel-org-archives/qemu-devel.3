Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E60D5CC85
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 10:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t65gR-0004F4-Db; Wed, 30 Oct 2024 06:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65gN-0004En-QZ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65gK-0004Bu-JN
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730283123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTtkACQcE6aGkMXLA65joLcqEGmhrrJxLsb8iryBfB0=;
 b=Dnq+v9djF8Zrl58ZiZ+L+7TiDqTVaDBKxESYK+7Jr90EUGDHeL0Xs7FQ8ZQmj6RXEo7MSg
 l6p+VSsMZy+0kvxEpP3nnwBKdYU646TnsXAgQJb0QY9zcFA8g7X60TNTh3Dnx2dZ4l3oG3
 LzC/6xLM7qpTO3qkfpZnHawpIbcTuqs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-qptckGkaM6e17JXWqASntw-1; Wed,
 30 Oct 2024 06:12:02 -0400
X-MC-Unique: qptckGkaM6e17JXWqASntw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50EA619560A5
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 10:12:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B28F19560A7; Wed, 30 Oct 2024 10:11:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] crypto: perform runtime check for hash/hmac support in
 gcrypt
Date: Wed, 30 Oct 2024 10:11:50 +0000
Message-ID: <20241030101150.3023300-3-berrange@redhat.com>
In-Reply-To: <20241030101150.3023300-1-berrange@redhat.com>
References: <20241030101150.3023300-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

gcrypto has the ability to dynamically disable hash/hmac algorithms
at runtime, so QEMU must perform a runtime check.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-gcrypt.c | 2 +-
 crypto/hmac-gcrypt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 22ddf394ec..2c8325869a 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -40,7 +40,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
 {
     if (alg < G_N_ELEMENTS(qcrypto_hash_alg_map) &&
         qcrypto_hash_alg_map[alg] != GCRY_MD_NONE) {
-        return true;
+        return gcry_md_test_algo(qcrypto_hash_alg_map[alg]) == 0;
     }
     return false;
 }
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 19990cb6ed..181b376572 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -37,7 +37,7 @@ bool qcrypto_hmac_supports(QCryptoHashAlgo alg)
 {
     if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
         qcrypto_hmac_alg_map[alg] != GCRY_MAC_NONE) {
-        return true;
+        return gcry_mac_test_algo(qcrypto_hmac_alg_map[alg]) == 0;
     }
 
     return false;
-- 
2.46.0


