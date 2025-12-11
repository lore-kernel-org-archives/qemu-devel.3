Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978EBD41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeJw-0007Iy-Gb; Thu, 11 Dec 2025 05:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJk-0007Dr-Jc
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJj-0005Xq-1Z
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765450478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hvxJ/XDHbHBWxofzfAF2WgNz6WnMLxtPZ7iycniK4k=;
 b=Rv+bKuAAzZJ4XCQwR7EpiNIEH9Hmue5cyRfRBlFVg8JTkhpRX/Q/K2i1WzsYZeio0WCq7D
 SlDs3FAHR48mgZmAmKI3nUpGfW4eq5g9GagJUW2rZEQSLbltyWlXiZ0nbvwReZJff02KyL
 x72HelEA4De5BMa10ZzoG3YbRc+jtb4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-DElPi9aJOo-D4nHuGZ7m_w-1; Thu,
 11 Dec 2025 05:54:27 -0500
X-MC-Unique: DElPi9aJOo-D4nHuGZ7m_w-1
X-Mimecast-MFC-AGG-ID: DElPi9aJOo-D4nHuGZ7m_w_1765450465
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E0F2180028B; Thu, 11 Dec 2025 10:54:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551543000229; Thu, 11 Dec 2025 10:54:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1D9231800DD3; Thu, 11 Dec 2025 11:54:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 3/5] igvm: move file load to complete callback
Date: Thu, 11 Dec 2025 11:54:17 +0100
Message-ID: <20251211105419.3573449-4-kraxel@redhat.com>
In-Reply-To: <20251211105419.3573449-1-kraxel@redhat.com>
References: <20251211105419.3573449-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  5 +++++
 backends/igvm-cfg.c            | 18 ++++++++++++++++++
 backends/igvm.c                |  9 ++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index e0452080b127..d378d682b0fb 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -12,6 +12,8 @@
 #include "qemu/typedefs.h"
 #include "qom/object.h"
 
+#include <igvm/igvm.h>
+
 struct IgvmCfg {
     ObjectClass parent_class;
 
@@ -21,7 +23,10 @@ struct IgvmCfg {
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


