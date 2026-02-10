Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE27E94619
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplrM-0003l3-LV; Tue, 10 Feb 2026 06:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vplrL-0003ke-Nr
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vplrK-0007Lw-28
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770722685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+P+r8J1Ki0gjCmax5Qvp7m+UKxoCgT5HwqLkgCdBAU=;
 b=jNw0zy1txwivZrR4MH6myeLRRHpulzlpjvAAi5hjkTyeIjUbLV0Va6+MndpTtM5oKsXTTt
 R53IWrjYT2vGb9mS2NMXd5JVNTtcGVFO5M8YbTNYM7xiM9nSHokTqL6VSqQo7y+z9V+hAF
 MgPfJesEO29pWYt/rqZZUM5ge0raqU8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-KLLloTtcODyObOuwRKDASQ-1; Tue,
 10 Feb 2026 06:24:44 -0500
X-MC-Unique: KLLloTtcODyObOuwRKDASQ-1
X-Mimecast-MFC-AGG-ID: KLLloTtcODyObOuwRKDASQ_1770722683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 299881800465
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 11:24:43 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown [10.44.32.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46A7418003F5; Tue, 10 Feb 2026 11:24:40 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH 1/1] igvm: Add NULL checks for igvm_get_buffer()
Date: Tue, 10 Feb 2026 12:24:36 +0100
Message-ID: <20260210112436.315197-2-osteffen@redhat.com>
In-Reply-To: <20260210112436.315197-1-osteffen@redhat.com>
References: <20260210112436.315197-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

According to the documentation we are supposed to do a null-pointer
check on the buffers returned by igvm_get_buffer() (part of the IGVM C
library).
Add these checks in the IGVM backend.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c | 86 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index b01a19ba46..049cb36891 100644
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
@@ -316,7 +324,13 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
                 return -1;
             }
             data = igvm_get_buffer(ctx->file, data_handle);
-            memcpy(&region[page_index * page_size], data, data_size);
+            if (data != NULL) {
+                memcpy(&region[page_index * page_size], data, data_size);
+            } else {
+                error_setg(errp, "IGVM: No buffer for handle %d: ", data_handle);
+                igvm_free_buffer(ctx->file, data_handle);
+                return -1;
+            }
             igvm_free_buffer(ctx->file, data_handle);
         }
     }
@@ -426,6 +440,11 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
     }
 
     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    if (data == NULL) {
+        error_setg(errp, "IGVM: No buffer for handle %d: ", data_handle);
+        result = -1;
+        goto exit;
+    }
 
     if (ctx->machine_state->cgs) {
         result = ctx->cgsc->set_guest_state(
@@ -441,6 +460,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         result = -1;
     }
 
+exit:
     igvm_free_buffer(ctx->file, data_handle);
     if (result < 0) {
         return result;
@@ -778,33 +798,39 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
             }
             platform =
                 (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
-                                                                header_handle) +
-                                                sizeof(
-                                                    IGVM_VHS_VARIABLE_HEADER));
-            if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
-                ctx->machine_state->cgs) {
-                if (ctx->cgsc->check_support(
-                        CGS_PLATFORM_SEV_ES, platform->platform_version,
-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
-                    compatibility_mask_sev_es = platform->compatibility_mask;
-                }
-            } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
-                       ctx->machine_state->cgs) {
-                if (ctx->cgsc->check_support(
-                        CGS_PLATFORM_SEV, platform->platform_version,
-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
-                    compatibility_mask_sev = platform->compatibility_mask;
+                                                                header_handle));
+            if (platform != NULL) {
+                platform = (IGVM_VHS_SUPPORTED_PLATFORM *)((void *)platform
+                                            + sizeof(IGVM_VHS_VARIABLE_HEADER));
+                if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
+                    ctx->machine_state->cgs) {
+                    if (ctx->cgsc->check_support(
+                            CGS_PLATFORM_SEV_ES, platform->platform_version,
+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
+                        compatibility_mask_sev_es = platform->compatibility_mask;
+                    }
+                } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
+                        ctx->machine_state->cgs) {
+                    if (ctx->cgsc->check_support(
+                            CGS_PLATFORM_SEV, platform->platform_version,
+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
+                        compatibility_mask_sev = platform->compatibility_mask;
+                    }
+                } else if ((platform->platform_type ==
+                            IGVM_PLATFORM_TYPE_SEV_SNP) &&
+                        ctx->machine_state->cgs) {
+                    if (ctx->cgsc->check_support(
+                            CGS_PLATFORM_SEV_SNP, platform->platform_version,
+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
+                        compatibility_mask_sev_snp = platform->compatibility_mask;
+                    }
+                } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
+                    compatibility_mask = platform->compatibility_mask;
                 }
-            } else if ((platform->platform_type ==
-                        IGVM_PLATFORM_TYPE_SEV_SNP) &&
-                       ctx->machine_state->cgs) {
-                if (ctx->cgsc->check_support(
-                        CGS_PLATFORM_SEV_SNP, platform->platform_version,
-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
-                    compatibility_mask_sev_snp = platform->compatibility_mask;
-                }
-            } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
-                compatibility_mask = platform->compatibility_mask;
+            } else {
+                error_setg(errp, "IGVM: No buffer for handle %d: ", header_handle);
+                igvm_free_buffer(ctx->file, header_handle);
+                return -1;
             }
             igvm_free_buffer(ctx->file, header_handle);
         }
-- 
2.53.0


