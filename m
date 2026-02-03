Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1462CE7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8w-0008RB-Lw; Tue, 03 Feb 2026 07:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8d-0007ti-Qf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8c-0007gT-9p
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiiY6hdAG4pbuPdzjGdEJ5gQuntuGsJCEg5mBLcgkBI=;
 b=b6E7Zitmk0Mlk8bXHLHXg236tf/yhtM5PsFn8bs/NM8hdzMQgN3ur4lWhZMOfMnAQbAs9e
 sOnePn31pIdPXwjbsCzSDStolvup5VKdGIfsfTTg0w+zLZuKHBWtjp/wb5t4hyZMO5tG0/
 HJbO/OI+Lg3+IGnT8sllBE4J38MfC40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-F-2lWMMIOTunCZmJ-JDT_g-1; Tue,
 03 Feb 2026 07:04:06 -0500
X-MC-Unique: F-2lWMMIOTunCZmJ-JDT_g-1
X-Mimecast-MFC-AGG-ID: F-2lWMMIOTunCZmJ-JDT_g_1770120245
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6738F1956054; Tue,  3 Feb 2026 12:04:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8C81800947; Tue,  3 Feb 2026 12:04:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7ED951826269; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 14/17] igvm: Refactor qigvm_parameter_insert
Date: Tue,  3 Feb 2026 13:03:39 +0100
Message-ID: <20260203120343.656961-15-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use qigvm_find_param_entry() also in qigvm_parameter_insert().
This changes behavior: Processing now stops after the first parameter
entry found. That is OK, because we expect only one matching entry
anyway.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260130054714.715928-7-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index ea3f9d6b008f..ffd1c325b661 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -476,31 +476,31 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
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
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
 
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


