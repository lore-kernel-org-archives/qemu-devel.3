Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473DCD2C56A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GkL-0007bq-Qf; Tue, 22 Oct 2024 11:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkI-0007SA-G8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkG-0004xe-U2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bupRsxA4PxPcQKR0C/4MvsGIj4c44qcPAmQ0QpoES/c=;
 b=ccyrwUMo/T3C497oLZC1Qg+rRwwSEn6yJjFaZFT4eMl+8DApT7gsH0euqIOQohnGi43ixG
 2NyaHtyCXVCsPEG09YQ63GuM7fcJaIKPDZLfJ0CTwnKBKlg2M1/lq56/LC1HcsRXxfdh87
 Y8h83lPa3QQH0kPHz/pcjTVHEiPeT24=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-DwLAbmNBOX6FwWkaBsaq5g-1; Tue,
 22 Oct 2024 11:24:24 -0400
X-MC-Unique: DwLAbmNBOX6FwWkaBsaq5g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11D4E195422E; Tue, 22 Oct 2024 15:24:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF78E1956046; Tue, 22 Oct 2024 15:24:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 01/14] crypto: Remove unused DER string functions
Date: Tue, 22 Oct 2024 16:24:02 +0100
Message-ID: <20241022152415.1632556-2-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qcrypto_der_encode_octet_str_begin and _end have been unused
since they were added in
  3b34ccad66 ("crypto: Support DER encodings")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/der.c | 13 -------------
 crypto/der.h | 22 ----------------------
 2 files changed, 35 deletions(-)

diff --git a/crypto/der.c b/crypto/der.c
index ebbecfc3fe..81367524c3 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -408,19 +408,6 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
     qcrypto_der_encode_prim(ctx, tag, src, src_len);
 }
 
-void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx)
-{
-    uint8_t tag = QCRYPTO_DER_TAG(QCRYPTO_DER_TAG_CLASS_UNIV,
-                                  QCRYPTO_DER_TAG_ENC_PRIM,
-                                  QCRYPTO_DER_TYPE_TAG_OCT_STR);
-    qcrypto_der_encode_cons_begin(ctx, tag);
-}
-
-void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx)
-{
-    qcrypto_der_encode_cons_end(ctx);
-}
-
 size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx)
 {
     return ctx->root.dlen;
diff --git a/crypto/der.h b/crypto/der.h
index f4ba6da28a..bcfa4a2495 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -242,28 +242,6 @@ void qcrypto_der_encode_null(QCryptoEncodeContext *ctx);
 void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
                                   const uint8_t *src, size_t src_len);
 
-/**
- * qcrypto_der_encode_octet_str_begin:
- * @ctx: the encode context.
- *
- * Start encoding a octet string, All fields between
- * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
- * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUENCE as OCTET STRING.
- */
-void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
-
-/**
- * qcrypto_der_encode_octet_str_end:
- * @ctx: the encode context.
- *
- * Finish encoding a octet string, All fields between
- * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
- * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUENCE as OCTET STRING.
- */
-void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx);
-
 /**
  * qcrypto_der_encode_ctx_buffer_len:
  * @ctx: the encode context.
-- 
2.46.0


