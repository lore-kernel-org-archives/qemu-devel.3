Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FADD2D8DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfv6-0004gb-Cu; Tue, 27 Jan 2026 05:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfv4-0004WP-IX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfv3-0005D7-1V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769508212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lU8cfl9gCDqNxnMilRoV/PVgA412LlMd5AfMzj0nBzw=;
 b=WL4RTxYdhpYbe4ltkamwmldY9YOUtb5yyT3PcGXKrtl0sP6EfZ3tcpCqX4UMOixp+ln0rO
 95wBpl73kNU3dbuVeLJbCE8i7URxORDR2moYYIGizVR89AXGG3isoQvzOjfHpScnd13pg6
 UZVeykWEHVwplvyNNXRK6QWFaG8pB+I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-tdPfesTPMxOheGj8B1vzHg-1; Tue,
 27 Jan 2026 05:03:30 -0500
X-MC-Unique: tdPfesTPMxOheGj8B1vzHg-1
X-Mimecast-MFC-AGG-ID: tdPfesTPMxOheGj8B1vzHg_1769508209
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 145F11800614; Tue, 27 Jan 2026 10:03:29 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.44.34.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D67C180066A; Tue, 27 Jan 2026 10:03:23 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v5 4/6] igvm: Refactor qigvm_parameter_insert
Date: Tue, 27 Jan 2026 11:02:55 +0100
Message-ID: <20260127100257.1074104-5-osteffen@redhat.com>
In-Reply-To: <20260127100257.1074104-1-osteffen@redhat.com>
References: <20260127100257.1074104-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
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

Use qigvm_find_param_entry() also in qigvm_parameter_insert().
This changes behavior: Processing now stops after the first parameter
entry found. That is OK, because we expect only one matching entry
anyway.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 213c9d337e..0a0092fb55 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -513,31 +513,31 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
         return 0;
     }
 
-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
-    {
-        if (param_entry->index == param->parameter_area_index) {
-            region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
-                                          ctx->current_header_index, errp);
-            if (!region) {
-                return -1;
-            }
-            memcpy(region, param_entry->data, param_entry->size);
-            g_free(param_entry->data);
-            param_entry->data = NULL;
-
-            /*
-             * If a confidential guest support object is provided then use it to
-             * set the guest state.
-             */
-            if (ctx->cgs) {
-                result = ctx->cgsc->set_guest_state(param->gpa, region,
-                                                    param_entry->size,
-                                                    CGS_PAGE_TYPE_UNMEASURED, 0,
-                                                    errp);
-                if (result < 0) {
-                    return -1;
-                }
-            }
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
+                                    ctx->current_header_index, errp);
+    if (!region) {
+        return -1;
+    }
+    memcpy(region, param_entry->data, param_entry->size);
+    g_free(param_entry->data);
+    param_entry->data = NULL;
+
+    /*
+     * If a confidential guest support object is provided then use it to
+     * set the guest state.
+     */
+    if (ctx->cgs) {
+        result = ctx->cgsc->set_guest_state(param->gpa, region,
+                                            param_entry->size,
+                                            CGS_PAGE_TYPE_UNMEASURED, 0,
+                                            errp);
+        if (result < 0) {
+            return -1;
         }
     }
     return 0;
-- 
2.52.0


