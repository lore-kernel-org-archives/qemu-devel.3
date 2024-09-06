Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D56CE7B17
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZMI-0001oY-3y; Fri, 06 Sep 2024 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smZMF-0001ep-GG
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smZMB-0002bh-US
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725630632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d4MsmNKS/7EZf8XIEgHQlb2WF1zbBHv4I5sZjk66ijc=;
 b=Urfd0LSb+u72JsHbRuNp2Icm64Ojzt12t3vPawy85lfZUGE4Hdrcf2498LYJDUz46KMWbl
 WfKxiLjKN6MTxL5OqgGA8OfnT5LqDLt7wBGaAiJ574a6ILlnKm3wiSE3AhxfVOBKLs8IlM
 BMKAYpw3a5EJiu/78L/Ji+1EStJKt/E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-LinJ26L_NByRo5yvP771wA-1; Fri,
 06 Sep 2024 09:50:29 -0400
X-MC-Unique: LinJ26L_NByRo5yvP771wA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 191E219560A5; Fri,  6 Sep 2024 13:50:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B5883000236; Fri,  6 Sep 2024 13:50:21 +0000 (UTC)
Date: Fri, 6 Sep 2024 14:50:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v6 3/8] crypto: Introduce x509 utils
Message-ID: <ZtsImlL43_dzUTp9@redhat.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-4-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905195735.16911-4-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 06, 2024 at 01:57:30AM +0600, Dorjoy Chowdhury wrote:
> An utility function for getting fingerprint from X.509 certificate
> has been introduced. Implementation only provided using gnutls.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  crypto/meson.build          |  4 ++
>  crypto/x509-utils.c         | 75 +++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h | 22 +++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 crypto/x509-utils.c
>  create mode 100644 include/crypto/x509-utils.h


> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgorithm alg,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    int ret;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm");
> +        return -1;
> +    }
> +
> +    if (result == NULL) {
> +        error_setg(errp, "No valid buffer given");
> +        return -1;
> +    }
> +
> +    gnutls_x509_crt_init(&crt);
> +
> +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +    if (*resultlen < ret) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than hash %d",
> +                   *resultlen, ret);
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_x509_crt_get_fingerprint(crt,
> +                                        qcrypto_to_gnutls_hash_alg_map[alg],
> +                                        result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get fingerprint from certificate");
> +        goto cleanup;
> +    }
> +
> +    return 0;
> +
> + cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return -1;
> +}

This fails to call gnutls_x509_crt_deinit in the success path.

I'm going to squash in the following change:


diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 593eb8968b..6e157af76b 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -31,7 +31,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       size_t *resultlen,
                                       Error **errp)
 {
-    int ret;
+    int ret = -1;
+    int hlen;
     gnutls_x509_crt_t crt;
     gnutls_datum_t datum = {.data = cert, .size = size};
 
@@ -52,11 +53,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         goto cleanup;
     }
 
-    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
-    if (*resultlen < ret) {
+    hlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+    if (*resultlen < hlen) {
         error_setg(errp,
                    "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
+                   *resultlen, hlen);
         goto cleanup;
     }
 
@@ -67,9 +68,9 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         goto cleanup;
     }
 
-    return 0;
+    ret = 0;
 
  cleanup:
     gnutls_x509_crt_deinit(crt);
-    return -1;
+    return ret;
 }



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


