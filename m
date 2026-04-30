Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD43CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMD8-0000Nu-GG; Thu, 30 Apr 2026 03:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wIMD7-0000Nk-Gz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wIMD5-0008BV-NO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777535601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QN6oxhdaG1e6oVOmD8zndQhAQP2FRg6voFe19cp1A0w=;
 b=UHQZ/dDG9ju885kjwLTPaPVuEI2OsWkB/uUzJutkVRLcX17vIbNdWz8RClOyIcPaRjipZ4
 qhnWTNrXdzsC6xsi1sPsq7AnWNtw1sk/p/7yma9lzS9DymYTOD6dbguJz+nQD4jE6FArRj
 MmGJMeteIZw9xnO5TjhTTkU6yzH7K3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-NROr6hHLNoesQz8ofbcZ9g-1; Thu,
 30 Apr 2026 03:53:17 -0400
X-MC-Unique: NROr6hHLNoesQz8ofbcZ9g-1
X-Mimecast-MFC-AGG-ID: NROr6hHLNoesQz8ofbcZ9g_1777535596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A3E2195609F; Thu, 30 Apr 2026 07:53:16 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.33.1])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1348F19560A6; Thu, 30 Apr 2026 07:53:16 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 55F0575A5F7; Thu, 30 Apr 2026 09:53:13 +0200 (CEST)
Date: Thu, 30 Apr 2026 09:53:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: Re: [PATCH 6/6] hw/uefi: avoid possibly unaligned variable_auth_2
 struct field access
Message-ID: <afMKCwBB_Wqz7sIA@dobby.home.kraxel.org>
References: <20260422092910.444997-1-kraxel@redhat.com>
 <20260422092910.444997-7-kraxel@redhat.com>
 <aetATeu-Nbs1pjcP@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetATeu-Nbs1pjcP@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Apr 24, 2026 at 12:08:53PM +0200, Luigi Leonardi wrote:
> Hi Gerd,
> 
> > -    variable_auth_2 *auth = data;
> > +    variable_auth_2 auth;
> >     uint64_t data_offset;
> >     efi_status status;
> > 
> > -    if (va->data_size < sizeof(*auth)) {
> > +    if (va->data_size < sizeof(auth)) {
> >         return EFI_SECURITY_VIOLATION;
> >     }
> > -    if (uadd64_overflow(sizeof(efi_time), auth->hdr_length, &data_offset)) {
> > +    memcpy(&auth, data, sizeof(auth));
> > +
> > +    if (uadd64_overflow(sizeof(efi_time), auth.hdr_length, &data_offset)) {
> >         return EFI_SECURITY_VIOLATION;
> >     }

> From a quick `git grep` I can see the same pattern in
> `uefi_vars_check_auth_2_sb` and in file `hw/uefi/var-service-pkcs7.c`
> in functions `build_signed_data` and `build_pkcs7`.
> 
> Should these fixed as well?

Yes.  Incremental patch below.

take care,
  Gerd

From 6f8e7c7f46729edce44b6b55631fa485cb2a8452 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Apr 2026 09:50:57 +0200
Subject: [PATCH] fixup! hw/uefi: avoid possibly unaligned variable_auth_2
 struct field access

---
 hw/uefi/var-service-auth.c  |  5 +++--
 hw/uefi/var-service-pkcs7.c | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 0d17691804..795f2f54e4 100644
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
2.53.0


