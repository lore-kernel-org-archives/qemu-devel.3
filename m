Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B740D33A21
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OUv-0001hD-QC; Tue, 05 Nov 2024 13:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUm-0001aG-TE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUk-0008Ie-Do
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730832097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJ6Z0szKx6L5vCZfW8ecoUItF23p16W3gTxV5UL2PgU=;
 b=VImLix8pakIv9nPpQEpFWKS/luo+/Ba9oHTWjVrZ/KQ0Q+9JZY7F0IX8mhuWlnV+sDij9Z
 8Fm9HjSuHYMMdreQZ5eE+To0CpCvVZyxPqphldvzpLRx8ArJWcLNrbnvf6DJFZQwiOpd3g
 REGedoEP72vYceSBsh9y4msy725MaOc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-lke3qSwVPTiZRo6FeWTUhg-1; Tue,
 05 Nov 2024 13:41:36 -0500
X-MC-Unique: lke3qSwVPTiZRo6FeWTUhg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7001219560B4; Tue,  5 Nov 2024 18:41:35 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E891D19560A2; Tue,  5 Nov 2024 18:41:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 4/4] crypto: perform runtime check for hash/hmac support in
 gcrypt
Date: Tue,  5 Nov 2024 18:41:15 +0000
Message-ID: <20241105184115.381511-5-berrange@redhat.com>
In-Reply-To: <20241105184115.381511-1-berrange@redhat.com>
References: <20241105184115.381511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-gcrypt.c | 2 +-
 crypto/hmac-gcrypt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 476b748195..af61c4e75d 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -43,7 +43,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
 {
     if (alg < G_N_ELEMENTS(qcrypto_hash_alg_map) &&
         qcrypto_hash_alg_map[alg] != GCRY_MD_NONE) {
-        return true;
+        return gcry_md_test_algo(qcrypto_hash_alg_map[alg]) == 0;
     }
     return false;
 }
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 090fe01c1e..5273086eb9 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -40,7 +40,7 @@ bool qcrypto_hmac_supports(QCryptoHashAlgo alg)
 {
     if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
         qcrypto_hmac_alg_map[alg] != GCRY_MAC_NONE) {
-        return true;
+        return gcry_mac_test_algo(qcrypto_hmac_alg_map[alg]) == 0;
     }
 
     return false;
-- 
2.46.0


