Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAB606AA2F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dYPZEgwe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr4r-00064b-Pv; Mon, 02 Nov 2026 07:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4q-000644-N5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4p-0001Ob-4e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1+LpcslGBEliiOMWoZSSQNfVGm/yD8sVMN11d+3YvA=;
 b=dYPZEgweSa4Bsgo959QFh9/KfO1bGQv4LlWVTC1vclu41BulKVb6lQym9CsmpymYlHNVF4
 IJgfnVko2vesjO3hE8Tp8/14BNfKAweA12VtweJIAsIIclFQr/lnHaLH/mv0lrFJa86ogQ
 izSycGXiJ5okCjabJKpt+628mYyJZ7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-p7PHSDIoMEadnvdvJxi3og-1; Mon,
 02 Nov 2026 07:23:47 -0500
X-MC-Unique: p7PHSDIoMEadnvdvJxi3og-1
X-Mimecast-MFC-AGG-ID: p7PHSDIoMEadnvdvJxi3og_1793622227
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73CE1954117; Mon,  2 Nov 2026 12:23:46 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F01BC1800480; Mon,  2 Nov 2026 12:23:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/4] crypto: set default initializer hmac/hash arrays to -1
Date: Mon,  2 Nov 2026 12:23:40 +0000
Message-ID: <20261102122343.3348956-2-berrange@redhat.com>
In-Reply-To: <20261102122343.3348956-1-berrange@redhat.com>
References: <20261102122343.3348956-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The default static array initializer of 0 is not suitable for
the glib hash/hmac backends, as G_CHECKSUM_MD5 has a value of
0. Instead elements must be initialized to -1, but remembering
todo that as new algorithms are defined is errorprone. The
SM3 algorithm initializer is missing, leading to it being
mapped to MD5. This could potentially be a security flaw through
use of the wrong (much weaker) hashing algorithm, if a further
bug elsewhere didn't mask the issue.

Set a default array initializer so unlisted algorithms are
always set to -1 instead of 0.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4786
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-glib.c | 3 +--
 crypto/hmac-glib.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 809cef98aee..d915430f459 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -26,13 +26,12 @@
 
 
 static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
+    [0 ... QCRYPTO_HASH_ALGO__MAX - 1] = -1,
     [QCRYPTO_HASH_ALGO_MD5] = G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALGO_SHA1] = G_CHECKSUM_SHA1,
-    [QCRYPTO_HASH_ALGO_SHA224] = -1,
     [QCRYPTO_HASH_ALGO_SHA256] = G_CHECKSUM_SHA256,
     [QCRYPTO_HASH_ALGO_SHA384] = G_CHECKSUM_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = G_CHECKSUM_SHA512,
-    [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
 };
 
 gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 1f17769c1c7..4453e0d5f06 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -18,13 +18,11 @@
 #include "hmacpriv.h"
 
 static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
+    [0 ... QCRYPTO_HASH_ALGO__MAX - 1] = -1,
     [QCRYPTO_HASH_ALGO_MD5] = G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALGO_SHA1] = G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALGO_SHA256] = G_CHECKSUM_SHA256,
     [QCRYPTO_HASH_ALGO_SHA512] = G_CHECKSUM_SHA512,
-    [QCRYPTO_HASH_ALGO_SHA224] = -1,
-    [QCRYPTO_HASH_ALGO_SHA384] = -1,
-    [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
 };
 
 typedef struct QCryptoHmacGlib QCryptoHmacGlib;
-- 
2.56.0


