Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE21CE7FDD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8j-0007wT-Le; Tue, 03 Feb 2026 07:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8T-0007jp-IM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8S-0007eo-13
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2yAZjsvESraEcG8eDAOsyuG+02DfRy5k2L12yW5XDU=;
 b=U528B35sTX/UkSlnUpsfLTNmv35e5ZwzOo537upw8nX6xF0AZNBjsqINPq4jiXb05VllZF
 hz4wHIiIIjZhs2e4GrvKFL1hIaFe5mXKIM1Aa49TcLHL3cfJHUhe5s4RLaVR0wkocOfeA6
 /Gs33QmKdHaUe6yuFME5iG05eYtu0CM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-9rXH_ywQNcKrvCavLQOqmA-1; Tue,
 03 Feb 2026 07:03:56 -0500
X-MC-Unique: 9rXH_ywQNcKrvCavLQOqmA-1
X-Mimecast-MFC-AGG-ID: 9rXH_ywQNcKrvCavLQOqmA_1770120235
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0904C1955F34; Tue,  3 Feb 2026 12:03:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9A81956053; Tue,  3 Feb 2026 12:03:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DDA2D1800639; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
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
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 06/17] igvm: move file load to complete callback
Date: Tue,  3 Feb 2026 13:03:31 +0100
Message-ID: <20260203120343.656961-7-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add UserCreatableClass->complete callback function for igvm-cfg object.

Move file loading and parsing of the igvm file from the process function
to the new complete() callback function.  Keep the igvm file loaded
after processing, release it in finalize() instead, so we parse it only
once.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260126123755.357378-4-kraxel@redhat.com>
---
 include/system/igvm-internal.h |  5 +++++
 backends/igvm-cfg.c            | 18 ++++++++++++++++++
 backends/igvm.c                |  9 ++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index ac9e5683cc63..171cec8d0f6c 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -13,6 +13,8 @@
 #include "qom/object.h"
 #include "hw/core/resettable.h"
 
+#include <igvm/igvm.h>
+
 struct IgvmCfg {
     ObjectClass parent_class;
 
@@ -22,7 +24,10 @@ struct IgvmCfg {
      *           format.
      */
     char *filename;
+    IgvmHandle file;
     ResettableState reset_state;
 };
 
+IgvmHandle qigvm_file_init(char *filename, Error **errp);
+
 #endif
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index e0df3eaa8efd..4014062e0f22 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -53,6 +53,13 @@ static void igvm_reset_exit(Object *obj, ResetType type)
     trace_igvm_reset_exit(type);
 }
 
+static void igvm_complete(UserCreatable *uc, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(uc);
+
+    igvm->file = qigvm_file_init(igvm->filename, errp);
+}
+
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
                                    { TYPE_USER_CREATABLE },
                                    { TYPE_RESETTABLE_INTERFACE },
@@ -62,6 +69,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
 {
     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
+    UserCreatableClass *uc = USER_CREATABLE_CLASS(oc);
 
     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
     object_class_property_set_description(oc, "file",
@@ -73,14 +81,24 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     rc->phases.enter = igvm_reset_enter;
     rc->phases.hold = igvm_reset_hold;
     rc->phases.exit = igvm_reset_exit;
+
+    uc->complete = igvm_complete;
 }
 
 static void igvm_cfg_init(Object *obj)
 {
+    IgvmCfg *igvm = IGVM_CFG(obj);
+
+    igvm->file = -1;
     qemu_register_resettable(obj);
 }
 
 static void igvm_cfg_finalize(Object *obj)
 {
+    IgvmCfg *igvm = IGVM_CFG(obj);
+
     qemu_unregister_resettable(obj);
+    if (igvm->file >= 0) {
+        igvm_free(igvm->file);
+    }
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index fbb8300b6d01..a01e01a12a60 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -869,7 +869,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static IgvmHandle qigvm_file_init(char *filename, Error **errp)
+IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
     g_autofree uint8_t *buf = NULL;
@@ -898,10 +898,11 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     QIgvm ctx;
 
     memset(&ctx, 0, sizeof(ctx));
-    ctx.file = qigvm_file_init(cfg->filename, errp);
-    if (ctx.file < 0) {
+    if (cfg->file < 0) {
+        error_setg(errp, "No IGVM file loaded.");
         return -1;
     }
+    ctx.file = cfg->file;
 
     /*
      * The ConfidentialGuestSupport object is optional and allows a confidential
@@ -992,7 +993,5 @@ cleanup_parameters:
     g_free(ctx.id_auth);
 
 cleanup:
-    igvm_free(ctx.file);
-
     return retval;
 }
-- 
2.52.0


