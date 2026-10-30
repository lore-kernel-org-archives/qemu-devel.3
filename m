Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8653606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqHDROvr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAD-0002If-De; Fri, 30 Oct 2026 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMo9c-00025E-WF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMo9a-0007Fu-AH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793372664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3RYicfA4Pw7ib/W99AxB190i0s6VxYIiej6qMSywHE=;
 b=iqHDROvr4rxKGtHVfZXojwVdUaMk8FBD+OCkRyhez+niY470WosNfcVCu15R+lo/ZNdrnj
 MqNDUrkdYn/vmp/H5C6ylPXXCMoCjGdX+baQ0Lw3FFDkHFE5YTNcaVRqqg1+M/DK45gPH+
 ghtD6DBMjFLWdnJQs3lrK6w7rEQVogs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-o_NKKE3pP7qVhJveVTm5kQ-1; Fri,
 30 Oct 2026 11:04:18 -0400
X-MC-Unique: o_NKKE3pP7qVhJveVTm5kQ-1
X-Mimecast-MFC-AGG-ID: o_NKKE3pP7qVhJveVTm5kQ_1793372657
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE961800742
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:17 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1CC31956088; Fri, 30 Oct 2026 15:04:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] crypto: unconditionally report SM3 hash length
Date: Fri, 30 Oct 2026 15:04:12 +0000
Message-ID: <20261030150413.2999685-3-berrange@redhat.com>
In-Reply-To: <20261030150413.2999685-1-berrange@redhat.com>
References: <20261030150413.2999685-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Callers may query the hash digest length before getting to the
code path that performs hashing, which is where the lack of
support for SM3 in the backend will be reported.

Reporting a hash length of 0 is liable to cause divide by zero
errors in callers.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4786
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index 6ffb88bf541..42a0a8ec56f 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -33,9 +33,7 @@ static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_SHA384]    = QCRYPTO_HASH_DIGEST_LEN_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512]    = QCRYPTO_HASH_DIGEST_LEN_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
-#ifdef CONFIG_CRYPTO_SM3
-    [QCRYPTO_HASH_ALGO_SM3] = QCRYPTO_HASH_DIGEST_LEN_SM3,
-#endif
+    [QCRYPTO_HASH_ALGO_SM3]       = QCRYPTO_HASH_DIGEST_LEN_SM3,
 };
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgo alg)
-- 
2.56.0


