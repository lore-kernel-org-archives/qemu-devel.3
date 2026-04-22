Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B54F9B5F7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTtb-00042U-7a; Wed, 22 Apr 2026 05:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTtX-00041T-MQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTtW-0007nS-8Z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776850157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXM0BYtBJ+OU81xkYbvynrY9rWrN/LL+9+zViB+eWHw=;
 b=PJgqzkr2svlW+yrLNiU+hxHmCFWaLQAi2A7/ljaph5ahLWqejFH/qMFXFQdZXyxRNJ6hrE
 fgbWeXnlAf/4Panhw289sauVl188rOJWMyWMtdyeAH051zr/MrULaTL1frCXZLmTpRj2vC
 XPqKMYqVNQJP4IaeregVVIdIgGVc6l8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-znAoKh2pNuOPJ1ZJUlF9xQ-1; Wed,
 22 Apr 2026 05:29:13 -0400
X-MC-Unique: znAoKh2pNuOPJ1ZJUlF9xQ-1
X-Mimecast-MFC-AGG-ID: znAoKh2pNuOPJ1ZJUlF9xQ_1776850153
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D81171800370; Wed, 22 Apr 2026 09:29:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49FFF180047F; Wed, 22 Apr 2026 09:29:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2C7971801022; Wed, 22 Apr 2026 11:29:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PATCH 1/6] hw/uefi: fix buffer overruns
Date: Wed, 22 Apr 2026 11:29:04 +0200
Message-ID: <20260422092910.444997-2-kraxel@redhat.com>
In-Reply-To: <20260422092910.444997-1-kraxel@redhat.com>
References: <20260422092910.444997-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The buffer size checks do not consider the mm_header size, simliar to
CVE-2026-5744.  Factor out the repeated size check to a small helper
function, fix the check, update all places to use the new helper.

Fixes: CVE-2026-41435
Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 5e3907118d4b..24e6516a9cc0 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -297,6 +297,17 @@ static size_t uefi_vars_mm_error(mm_header *mhdr, mm_variable *mvar,
     return sizeof(*mvar);
 }
 
+static bool check_buffer_size(uefi_vars_state *uv, uint64_t length)
+{
+    /* uefi_vars_cmd_mm() checks that */
+    g_assert(uv->buf_size >= sizeof(mm_header));
+
+    if (uv->buf_size - sizeof(mm_header) < length) {
+        return false;
+    }
+    return true;
+}
+
 static size_t uefi_vars_mm_get_variable(uefi_vars_state *uv, mm_header *mhdr,
                                         mm_variable *mvar, void *func)
 {
@@ -344,7 +355,7 @@ static size_t uefi_vars_mm_get_variable(uefi_vars_state *uv, mm_header *mhdr,
     if (uadd64_overflow(length, va->data_size, &length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -414,7 +425,7 @@ uefi_vars_mm_get_next_variable(uefi_vars_state *uv, mm_header *mhdr,
     }
 
     length = sizeof(*mvar) + sizeof(*nv) + var->name_size;
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -605,7 +616,7 @@ static size_t uefi_vars_mm_variable_info(uefi_vars_state *uv, mm_header *mhdr,
     uint64_t length;
 
     length = sizeof(*mvar) + sizeof(*vi);
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -626,7 +637,7 @@ uefi_vars_mm_get_payload_size(uefi_vars_state *uv, mm_header *mhdr,
     uint64_t length;
 
     length = sizeof(*mvar) + sizeof(*ps);
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
-- 
2.53.0


