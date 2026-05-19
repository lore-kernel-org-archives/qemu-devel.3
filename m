Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65A3CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPGFP-0003ho-TL; Tue, 19 May 2026 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGFB-0003fy-RU
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGFA-0001Vc-6h
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779180961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SI4QuBLtZHs0J7Ga2vw3XAw/52+dzlqNrGzzneYN/4=;
 b=MIA8G/Uf08Qj5PnjJJnICmWCeLDEFvPx/eejwZV8Yvn3BxeSadESNs3yH8RX3bocx9sIBf
 UfaQrb6qw+efeiyGxCUysUPHAQYzYMDmqli2Vvgm9pAVe+g54tf1lTVdLEe+m08b2pq3cm
 SXMCDkYo/z4hwvlE7OOfWV53jFnQEHw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-YOacHz2UOyuZV_CdlXTrJA-1; Tue,
 19 May 2026 04:55:58 -0400
X-MC-Unique: YOacHz2UOyuZV_CdlXTrJA-1
X-Mimecast-MFC-AGG-ID: YOacHz2UOyuZV_CdlXTrJA_1779180957
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA39219560B4; Tue, 19 May 2026 08:55:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD84319560A2; Tue, 19 May 2026 08:55:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E21E418007A4; Tue, 19 May 2026 10:55:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/2] hw/uefi: check auth.hdr_length minimum size
Date: Tue, 19 May 2026 10:55:53 +0200
Message-ID: <20260519085554.944458-2-kraxel@redhat.com>
In-Reply-To: <20260519085554.944458-1-kraxel@redhat.com>
References: <20260519085554.944458-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

auth.hdr_length maximum is already checked (against buffer size).  The
header has some fixed fields which are included in the header length, so
there also is a minimum size which must be verified.  Add a check for
that.  Fixes possible integer underflow.

While being at it replace the magic number '24' with sizeof calculations
for better code documentation.

Fixes: CVE-2026-8341
Fixes: f1488fac0584 ("hw/uefi: add var-service-auth.c")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260512060523.17493-1-kraxel@redhat.com>
---
 hw/uefi/var-service-auth.c  | 5 ++++-
 hw/uefi/var-service-pkcs7.c | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 795f2f54e4ab..f3dc9c6ca608 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -194,7 +194,7 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
         return EFI_SUCCESS;
     }
 
-    if (auth.hdr_length == 24) {
+    if (auth.hdr_length == (sizeof(auth) - sizeof(auth.timestamp))) {
         /* no signature (auth->cert_data is empty) */
         return EFI_SECURITY_VIOLATION;
     }
@@ -228,6 +228,9 @@ efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
     }
     memcpy(&auth, data, sizeof(auth));
 
+    if (auth.hdr_length < (sizeof(auth) - sizeof(auth.timestamp))) {
+        return EFI_SECURITY_VIOLATION;
+    }
     if (uadd64_overflow(sizeof(efi_time), auth.hdr_length, &data_offset)) {
         return EFI_SECURITY_VIOLATION;
     }
diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index c859743e8677..8a1f1395a2fb 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -113,9 +113,9 @@ static gnutls_datum_t *build_pkcs7(void *data)
 
     memcpy(&auth, data, sizeof(auth));
     pkcs7 = g_new(gnutls_datum_t, 1);
-    pkcs7->size = auth.hdr_length - 24;
+    pkcs7->size = auth.hdr_length - (sizeof(auth) - sizeof(auth.timestamp));
     pkcs7->data = g_malloc(pkcs7->size);
-    memcpy(pkcs7->data, data + 16 + 24, pkcs7->size);
+    memcpy(pkcs7->data, data + sizeof(auth), pkcs7->size);
 
     wrap_pkcs7(pkcs7);
 
-- 
2.54.0


