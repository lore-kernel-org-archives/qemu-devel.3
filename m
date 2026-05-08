Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08181CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHvy-0007HE-EW; Fri, 08 May 2026 05:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvs-0007Fp-Da
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvp-0000dT-9M
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778234140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXPgRyhka1iUgbT+spcMP/7bRVi6wwqH8SQF2ppJD+E=;
 b=U+1H5vbORdQj/xewxIuAhNUrBVpYgPOEJxehyADTapSmZ7bFbcE4h+HPVNb4oD36dZqsZ9
 2YYgao+VBp6PthjR09aMs5hagHaH/Gog5MX6UkPDGsHl6brwxw5ITBqHgHFg58Sx7eBJG8
 BCAhNPcbkFmn7yDcGbmU1WTeuqfa1YI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-DYHtpAk8PaqU_eJ6Vfo_ZA-1; Fri,
 08 May 2026 05:55:36 -0400
X-MC-Unique: DYHtpAk8PaqU_eJ6Vfo_ZA-1
X-Mimecast-MFC-AGG-ID: DYHtpAk8PaqU_eJ6Vfo_ZA_1778234135
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C16D11956062; Fri,  8 May 2026 09:55:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.50.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81C59300019F; Fri,  8 May 2026 09:55:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D80541800D52; Fri, 08 May 2026 11:55:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PULL 6/6] hw/uefi: avoid possibly unaligned variable_auth_2 struct
 field access
Date: Fri,  8 May 2026 11:55:31 +0200
Message-ID: <20260508095531.570979-7-kraxel@redhat.com>
In-Reply-To: <20260508095531.570979-1-kraxel@redhat.com>
References: <20260508095531.570979-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Copy data to stack-allocated struct before accessing it
to make sure it is properly aligned.

Fixes: CVE-2026-41440
Fixes: f1488fac0584 ("hw/uefi: add var-service-auth.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-7-kraxel@redhat.com>
---
 hw/uefi/var-service-auth.c  | 21 ++++++++++++---------
 hw/uefi/var-service-pkcs7.c | 18 +++++++++++-------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index fba5a0956a57..795f2f54e4ab 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -180,9 +180,10 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
                                             void *data,
                                             uint64_t data_offset)
 {
-    variable_auth_2 *auth = data;
+    variable_auth_2 auth;
     uefi_variable *siglist;
 
+    memcpy(&auth, data, sizeof(auth));
     if (custom_mode_is_active(uv)) {
         /* no authentication in custom mode */
         return EFI_SUCCESS;
@@ -193,7 +194,7 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
         return EFI_SUCCESS;
     }
 
-    if (auth->hdr_length == 24) {
+    if (auth.hdr_length == 24) {
         /* no signature (auth->cert_data is empty) */
         return EFI_SECURITY_VIOLATION;
     }
@@ -218,23 +219,25 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
 efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
                                   mm_variable_access *va, void *data)
 {
-    variable_auth_2 *auth = data;
+    variable_auth_2 auth;
     uint64_t data_offset;
     efi_status status;
 
-    if (va->data_size < sizeof(*auth)) {
+    if (va->data_size < sizeof(auth)) {
         return EFI_SECURITY_VIOLATION;
     }
-    if (uadd64_overflow(sizeof(efi_time), auth->hdr_length, &data_offset)) {
+    memcpy(&auth, data, sizeof(auth));
+
+    if (uadd64_overflow(sizeof(efi_time), auth.hdr_length, &data_offset)) {
         return EFI_SECURITY_VIOLATION;
     }
     if (va->data_size < data_offset) {
         return EFI_SECURITY_VIOLATION;
     }
 
-    if (auth->hdr_revision != 0x0200 ||
-        auth->hdr_cert_type != WIN_CERT_TYPE_EFI_GUID ||
-        !qemu_uuid_is_equal(&auth->guid_cert_type, &EfiCertTypePkcs7Guid)) {
+    if (auth.hdr_revision != 0x0200 ||
+        auth.hdr_cert_type != WIN_CERT_TYPE_EFI_GUID ||
+        !qemu_uuid_is_equal(&auth.guid_cert_type, &EfiCertTypePkcs7Guid)) {
         return EFI_UNSUPPORTED;
     }
 
@@ -255,7 +258,7 @@ efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
     }
 
     /* checks passed, set variable data */
-    var->time = auth->timestamp;
+    var->time = auth.timestamp;
     if (va->data_size - data_offset > 0) {
         var->data = g_malloc(va->data_size - data_offset);
         memcpy(var->data, data + data_offset, va->data_size - data_offset);
diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index f17ad6872fd2..c859743e8677 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -21,17 +21,20 @@
  */
 static gnutls_datum_t *build_signed_data(mm_variable_access *va, void *data)
 {
-    variable_auth_2 *auth = data;
-    uint64_t data_offset = sizeof(efi_time) + auth->hdr_length;
+    variable_auth_2 auth;
+    uint64_t data_offset;
     uint16_t *name = (void *)va + sizeof(mm_variable_access);
     gnutls_datum_t *sdata;
     uint64_t pos = 0;
 
+    memcpy(&auth, data, sizeof(auth));
+    data_offset = sizeof(efi_time) + auth.hdr_length;
+
     sdata = g_new(gnutls_datum_t, 1);
     sdata->size = (va->name_size - 2
                    + sizeof(QemuUUID)
                    + sizeof(va->attributes)
-                   + sizeof(auth->timestamp)
+                   + sizeof(auth.timestamp)
                    + va->data_size - data_offset);
     sdata->data = g_malloc(sdata->size);
 
@@ -48,8 +51,8 @@ static gnutls_datum_t *build_signed_data(mm_variable_access *va, void *data)
     pos += sizeof(va->attributes);
 
     /* TimeStamp */
-    memcpy(sdata->data + pos, &auth->timestamp, sizeof(auth->timestamp));
-    pos += sizeof(auth->timestamp);
+    memcpy(sdata->data + pos, &auth.timestamp, sizeof(auth.timestamp));
+    pos += sizeof(auth.timestamp);
 
     /* Variable Content */
     memcpy(sdata->data + pos, data + data_offset, va->data_size - data_offset);
@@ -105,11 +108,12 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
 
 static gnutls_datum_t *build_pkcs7(void *data)
 {
-    variable_auth_2 *auth = data;
+    variable_auth_2 auth;
     gnutls_datum_t *pkcs7;
 
+    memcpy(&auth, data, sizeof(auth));
     pkcs7 = g_new(gnutls_datum_t, 1);
-    pkcs7->size = auth->hdr_length - 24;
+    pkcs7->size = auth.hdr_length - 24;
     pkcs7->data = g_malloc(pkcs7->size);
     memcpy(pkcs7->data, data + 16 + 24, pkcs7->size);
 
-- 
2.54.0


