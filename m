Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED857F9B5F6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTtg-00045E-1B; Wed, 22 Apr 2026 05:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTte-00044p-Ur
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTtd-0007pD-IT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776850164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQ81jDtxmHW5yOUxb8N6HXBRdoL8rvnU1AKzIe2hTls=;
 b=RsTZ3IjXtCCa+f/p6KKnapnBXsBzeGgtLWzw6alEwynpJdj7s+pwCn4p3VQedrvnxBbLox
 hbYHr15kwNu4gP9bTr9/pQt35DHUyO+ijwkOhnFACIOO1OxM4QRgcVdOQcgntsVpOzeMO3
 +Sney3AHuoLD363TTjgJULwEXQg/z+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-eAP9D6Q0N8qPww87yH8u9A-1; Wed,
 22 Apr 2026 05:29:21 -0400
X-MC-Unique: eAP9D6Q0N8qPww87yH8u9A-1
X-Mimecast-MFC-AGG-ID: eAP9D6Q0N8qPww87yH8u9A_1776850160
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6B419560AA; Wed, 22 Apr 2026 09:29:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C81203000C15; Wed, 22 Apr 2026 09:29:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 774DC1801033; Wed, 22 Apr 2026 11:29:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PATCH 6/6] hw/uefi: avoid possibly unaligned variable_auth_2 struct
 field access
Date: Wed, 22 Apr 2026 11:29:09 +0200
Message-ID: <20260422092910.444997-7-kraxel@redhat.com>
In-Reply-To: <20260422092910.444997-1-kraxel@redhat.com>
References: <20260422092910.444997-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/uefi/var-service-auth.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index fba5a0956a57..0d17691804df 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -218,23 +218,25 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
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
 
@@ -255,7 +257,7 @@ efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
     }
 
     /* checks passed, set variable data */
-    var->time = auth->timestamp;
+    var->time = auth.timestamp;
     if (va->data_size - data_offset > 0) {
         var->data = g_malloc(va->data_size - data_offset);
         memcpy(var->data, data + data_offset, va->data_size - data_offset);
-- 
2.53.0


