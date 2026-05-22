Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277E1CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXla-0000La-UU; Fri, 22 May 2026 17:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXlU-0008Rn-TT; Fri, 22 May 2026 17:50:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXlS-0003Vk-ML; Fri, 22 May 2026 17:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=qG6ii2l7hCb7dAKBoB+JAL6Fy6hY5WJKV7Caap/hyCY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eB9N9JhTr+2X7rHiMxf6mb0yJF8j6BFgbwZJZlIevS9P7edPsL/Zo94TEejieuEsK
 w5TRjIXPwMj2SzT56Xg7DQwtiQ7srqRlEqGS5nUfYgahqZ2QAOe20ZWeVH1LB80gdd
 NdWWN++y2Q7I8UrR8PYR4DpBbYhXcxI+f376y0CeX1YGcVekti1T5JUr4cjqmLuJkc
 E2U5D1r6WhKWSNDNVkGHYq1WqFJ/GBhQs+tWxEDsnGyh8ICg9f7dmTu9CaD2oBsSwO
 sZZeVez+UyU4hDLicpBs5q3ueRRDjaTh4tYuJfOvoMqBQ8PyHFSB4JRMDr8G6yrQPL
 67lN0CtGr+TFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E7261AFB6B;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66EFF3B71BA;
 Sat, 23 May 2026 00:49:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 117/149] hw/uefi: avoid possibly unaligned
 variable_auth_2 struct field access
Date: Sat, 23 May 2026 00:48:49 +0300
Message-ID: <20260522214923.807017-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Copy data to stack-allocated struct before accessing it
to make sure it is properly aligned.

Fixes: CVE-2026-41440
Fixes: f1488fac0584 ("hw/uefi: add var-service-auth.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-7-kraxel@redhat.com>
(cherry picked from commit b4680c02b8e838c75691656ee2c4450b454d1ca7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index fba5a0956a..795f2f54e4 100644
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
index f17ad6872f..c859743e86 100644
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
2.47.3


