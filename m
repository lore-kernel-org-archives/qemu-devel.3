Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F52CED276
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56h-0008FX-Vd; Tue, 08 Oct 2024 03:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56d-0008EG-Da
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56Z-0005e7-C6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5qDNf8+IrhquVFi5LvNIKf7o6gKUDyZjUqvCZq79r4=;
 b=HWMpOtnrlgA4pU+D8j0cB+apK90W99nVBM1pmAbfpMt9lPzosTMt3ho+SN2Nz+ChurgLKP
 9oIOp28SJa9sCriJG2VYr4C+bBmZm/bfxb2HxcILNA1fCjHr3wI/Sl1F+33GWQD5FBSIE4
 7Qxl4ACBzMnSohisXbkGE0CdLY+QYY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-4yRJQcLqOvmlOsVYoSOF5Q-1; Tue,
 08 Oct 2024 03:57:58 -0400
X-MC-Unique: 4yRJQcLqOvmlOsVYoSOF5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B84BC195608B; Tue,  8 Oct 2024 07:57:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 696A8300018D; Tue,  8 Oct 2024 07:57:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 10/16] crypto/hash-glib: Remove old hash API functions
Date: Tue,  8 Oct 2024 09:57:17 +0200
Message-ID: <20241008075724.2772149-11-clg@redhat.com>
In-Reply-To: <20241008075724.2772149-1-clg@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

Removes old hash implement-ion in the GLib hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ clg: - Fixed spelling in commit log ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/hash-glib.c | 53 ----------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 783283facc18..02a6ec1edf9f 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -44,58 +44,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
     return false;
 }
 
-
-static int
-qcrypto_glib_hash_bytesv(QCryptoHashAlgo alg,
-                         const struct iovec *iov,
-                         size_t niov,
-                         uint8_t **result,
-                         size_t *resultlen,
-                         Error **errp)
-{
-    int i, ret;
-    GChecksum *cs;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    cs = g_checksum_new(qcrypto_hash_alg_map[alg]);
-
-    for (i = 0; i < niov; i++) {
-        g_checksum_update(cs, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[alg]);
-    if (ret < 0) {
-        error_setg(errp, "%s",
-                   "Unable to get hash length");
-        goto error;
-    }
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        goto error;
-    }
-
-    g_checksum_get_digest(cs, *result, resultlen);
-
-    g_checksum_free(cs);
-    return 0;
-
- error:
-    g_checksum_free(cs);
-    return -1;
-}
-
-
 static
 QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgo alg,
                                    Error **errp)
@@ -159,7 +107,6 @@ int qcrypto_glib_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_glib_hash_bytesv,
     .hash_new      = qcrypto_glib_hash_new,
     .hash_update   = qcrypto_glib_hash_update,
     .hash_finalize = qcrypto_glib_hash_finalize,
-- 
2.46.2


