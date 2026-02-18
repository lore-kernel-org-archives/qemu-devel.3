Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00C7E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdYE-0005rH-CN; Wed, 18 Feb 2026 04:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY7-0005fB-EN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY4-0002c1-UP
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P711JUZohZYM6XVXyNdXgl24oh4bLjBt/RSlf+hZbe4=;
 b=MDFLqMwHwgbLREn5Q0wKTy7K28XBK57Ty3dhQ4oKBvmqFhsYdAuMLxSeiFNK/Jpu1D0di0
 n5h0Bpxyd91CGJ/n1Z133VLN4xpB2OsxeTWnXua+whihIp5S64CxCrk2RT4vdLooK9MhWj
 nmORLs8EU+8lFjQtWzdP7FPsnrloQeU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-4ZcQsdriOe66ITAEZYrHzQ-1; Wed,
 18 Feb 2026 04:08:40 -0500
X-MC-Unique: 4ZcQsdriOe66ITAEZYrHzQ-1
X-Mimecast-MFC-AGG-ID: 4ZcQsdriOe66ITAEZYrHzQ_1771405719
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A544E18001F9; Wed, 18 Feb 2026 09:08:39 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.226.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 248B319560AD; Wed, 18 Feb 2026 09:08:39 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 7EC8A68B173; Wed, 18 Feb 2026 09:59:45 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 1/2] igvm: Add NULL checks for igvm_get_buffer()
Date: Wed, 18 Feb 2026 09:59:44 +0100
Message-ID: <20260218085945.1050788-2-kraxel@redhat.com>
In-Reply-To: <20260218085945.1050788-1-kraxel@redhat.com>
References: <20260218085945.1050788-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Oliver Steffen <osteffen@redhat.com>

According to the documentation we are supposed to do a null-pointer
check on the buffers returned by igvm_get_buffer() (part of the IGVM C
library).
Add these checks in the IGVM backend.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260212154114.1119944-1-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index b01a19ba46..3b5edf1521 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -152,9 +152,17 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
                 (int)header_handle);
             return -1;
         }
-        header_data = igvm_get_buffer(ctx->file, header_handle) +
-                      sizeof(IGVM_VHS_VARIABLE_HEADER);
-        result = handlers[handler].handler(ctx, header_data, errp);
+        header_data = igvm_get_buffer(ctx->file, header_handle);
+        if (header_data != NULL) {
+            header_data += sizeof(IGVM_VHS_VARIABLE_HEADER);
+            result = handlers[handler].handler(ctx, header_data, errp);
+        } else {
+            error_setg(errp,
+                    "IGVM: No buffer for handle %d: "
+                    "(type 0x%X)",
+                    header_handle, type);
+            result = -1;
+        }
         igvm_free_buffer(ctx->file, header_handle);
         return result;
     }
@@ -316,6 +324,11 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
                 return -1;
             }
             data = igvm_get_buffer(ctx->file, data_handle);
+            if (data == NULL) {
+                error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
+                igvm_free_buffer(ctx->file, data_handle);
+                return -1;
+            }
             memcpy(&region[page_index * page_size], data, data_size);
             igvm_free_buffer(ctx->file, data_handle);
         }
@@ -426,6 +439,11 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
     }
 
     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    if (data == NULL) {
+        error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
+        result = -1;
+        goto exit;
+    }
 
     if (ctx->machine_state->cgs) {
         result = ctx->cgsc->set_guest_state(
@@ -441,6 +459,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         result = -1;
     }
 
+exit:
     igvm_free_buffer(ctx->file, data_handle);
     if (result < 0) {
         return result;
@@ -778,9 +797,15 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
             }
             platform =
                 (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
-                                                                header_handle) +
-                                                sizeof(
-                                                    IGVM_VHS_VARIABLE_HEADER));
+                                                                header_handle));
+            if (platform == NULL) {
+                error_setg(errp, "IGVM: No buffer for handle %d", header_handle);
+                igvm_free_buffer(ctx->file, header_handle);
+                return -1;
+            }
+
+            platform = (IGVM_VHS_SUPPORTED_PLATFORM *)((void *)platform
+                                        + sizeof(IGVM_VHS_VARIABLE_HEADER));
             if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
                 ctx->machine_state->cgs) {
                 if (ctx->cgsc->check_support(
-- 
2.53.0


