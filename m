Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D1CED63A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKiS-0004sc-OR; Tue, 18 Nov 2025 07:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiQ-0004qE-5R
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiN-0005GQ-Jl
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763468502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+q4FqU/Ou5+SNOeFkEvfBlC9qK8d7rE4gamtvT02qs=;
 b=dRTagY81y6qNwmVd6xljlsHaaj7+AnK1A+4PMtcLaI33LiyVLcJhdt+xWFLpRmGVZYF4F8
 RCWuow5znyYr0kB2Dm3fE0kGDnxqZCrY1uE85N3w09aLlROvhmej9dXYSZSoYJki1grwST
 Ep1BChKoudsAPSIn+q/IltMlTAepZuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-QWx1JxzCN3GIGU5dr0mODA-1; Tue,
 18 Nov 2025 07:21:41 -0500
X-MC-Unique: QWx1JxzCN3GIGU5dr0mODA-1
X-Mimecast-MFC-AGG-ID: QWx1JxzCN3GIGU5dr0mODA_1763468500
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 495BA1800452; Tue, 18 Nov 2025 12:21:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.167])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D846195419F; Tue, 18 Nov 2025 12:21:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 781C6182C026; Tue, 18 Nov 2025 13:21:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/4] igvm: move file load to complete callback
Date: Tue, 18 Nov 2025 13:21:30 +0100
Message-ID: <20251118122133.1695767-3-kraxel@redhat.com>
In-Reply-To: <20251118122133.1695767-1-kraxel@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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
to the to the new complete callback function.  Keep the igvm file loaded
instead of releasing it after processing, so we parse it only once.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-cfg.h |  3 +++
 include/system/igvm.h     |  1 +
 backends/igvm-cfg.c       | 10 ++++++++++
 backends/igvm.c           |  9 ++++-----
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 312f77c092b0..7dc48677fd99 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -15,6 +15,8 @@
 #include "qom/object.h"
 #include "hw/resettable.h"
 
+#include <igvm/igvm.h>
+
 typedef struct IgvmCfg {
     ObjectClass parent_class;
 
@@ -24,6 +26,7 @@ typedef struct IgvmCfg {
      *           format.
      */
     char *filename;
+    IgvmHandle file;
     ResettableState reset_state;
 } IgvmCfg;
 
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 48ce20604259..ec2538daa0e1 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -16,6 +16,7 @@
 #include "system/igvm-cfg.h"
 #include "qapi/error.h"
 
+IgvmHandle qigvm_file_init(char *filename, Error **errp);
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
                       bool onlyVpContext, Error **errp);
 
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 4e3ef88ffc27..08501a67e58e 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -52,6 +52,13 @@ static void igvm_reset_exit(Object *obj, ResetType type)
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
@@ -61,6 +68,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
 {
     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
+    UserCreatableClass *uc = USER_CREATABLE_CLASS(oc);
 
     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
     object_class_property_set_description(oc, "file",
@@ -72,6 +80,8 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     rc->phases.enter = igvm_reset_enter;
     rc->phases.hold = igvm_reset_hold;
     rc->phases.exit = igvm_reset_exit;
+
+    uc->complete = igvm_complete;
 }
 
 static void igvm_cfg_init(Object *obj)
diff --git a/backends/igvm.c b/backends/igvm.c
index 905bd8d98994..05d197fdfe85 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -867,7 +867,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static IgvmHandle qigvm_file_init(char *filename, Error **errp)
+IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
     g_autofree uint8_t *buf = NULL;
@@ -896,10 +896,11 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     QIgvm ctx;
 
     memset(&ctx, 0, sizeof(ctx));
-    ctx.file = qigvm_file_init(cfg->filename, errp);
-    if (ctx.file < 0) {
+    if (!cfg->file) {
+        error_setg(errp, "No IGVM file loaded.");
         return -1;
     }
+    ctx.file = cfg->file;
 
     /*
      * The ConfidentialGuestSupport object is optional and allows a confidential
@@ -990,7 +991,5 @@ cleanup_parameters:
     g_free(ctx.id_auth);
 
 cleanup:
-    igvm_free(ctx.file);
-
     return retval;
 }
-- 
2.51.1


