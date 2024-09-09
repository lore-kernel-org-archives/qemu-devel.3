Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0492ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfCr-0000g7-0f; Mon, 09 Sep 2024 10:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCa-0008NS-JC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCZ-0003Ki-8E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzSgkZRTe0ukTEfrZ3XtCYZUuRb9VVr70aYi3iC5M04=;
 b=Z+fNrwo707i69nL8IF9eAgyz9KVC51SnNUUsahM1ScZUhJfvuj/fXjYZkEvuESLMr0pWEI
 ZwJPQIkLNipg5/hp+UDHEsBDXm+Gsakz4OUBfUB8GakOY6RR7AE4JC6YrE3qPAsCogrwPq
 47HZ6ULhB+aesx3WOB2mVXajnH8saIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-k08X1KiJMVy1ZsjWQDBikg-1; Mon,
 09 Sep 2024 10:17:03 -0400
X-MC-Unique: k08X1KiJMVy1ZsjWQDBikg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FE27197701C; Mon,  9 Sep 2024 14:17:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72391956054; Mon,  9 Sep 2024 14:16:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 03/10] crypto: check gnutls & gcrypt support the requested
 pbkdf hash
Date: Mon,  9 Sep 2024 15:16:28 +0100
Message-ID: <20240909141635.1459701-4-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Both gnutls and gcrypt can be configured to exclude support for certain
algorithms via a runtime check against system crypto policies. Thus it
is not sufficient to have a compile time test for hash support in their
pbkdf implementations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/pbkdf-gcrypt.c | 2 +-
 crypto/pbkdf-gnutls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index a8d8e64f4d..bc0719c831 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -33,7 +33,7 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
-        return true;
+        return qcrypto_hash_supports(hash);
     default:
         return false;
     }
diff --git a/crypto/pbkdf-gnutls.c b/crypto/pbkdf-gnutls.c
index 2dfbbd382c..911b565bea 100644
--- a/crypto/pbkdf-gnutls.c
+++ b/crypto/pbkdf-gnutls.c
@@ -33,7 +33,7 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
-        return true;
+        return qcrypto_hash_supports(hash);
     default:
         return false;
     }
-- 
2.45.2


