Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75B6D41C1F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeJg-0007Bg-Mg; Thu, 11 Dec 2025 05:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJe-0007BK-1z
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJc-0005Wm-4I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765450469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+cJ8w1kBEnr2tvp6MvzGo5hAHspZAFdggzPGJtpZD4=;
 b=PEi2pepNoSCzfs/wOBllz68S9BHeTW0IvfYq8YI1FfvQ8thFWKuxmRsZA2CrA+/5RCCkFM
 q198SoVY0nO2LKlqcxZzY7+eJNZ4raPj5zo3pOk50Hbfm/duMFUFyOmhIvZDVd+0ZdxE4w
 uN3arkRHeR0KgA2sVmuNkgzq9z93urM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-0CQJvtZNMBizeGFVwDFPnA-1; Thu,
 11 Dec 2025 05:54:27 -0500
X-MC-Unique: 0CQJvtZNMBizeGFVwDFPnA-1
X-Mimecast-MFC-AGG-ID: 0CQJvtZNMBizeGFVwDFPnA_1765450466
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF1AF195DE48; Thu, 11 Dec 2025 10:54:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16CDA1953984; Thu, 11 Dec 2025 10:54:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 092251800848; Thu, 11 Dec 2025 11:54:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 2/5] igvm: make igvm-cfg object resettable
Date: Thu, 11 Dec 2025 11:54:16 +0100
Message-ID: <20251211105419.3573449-3-kraxel@redhat.com>
In-Reply-To: <20251211105419.3573449-1-kraxel@redhat.com>
References: <20251211105419.3573449-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add TYPE_RESETTABLE_INTERFACE to interfaces.  Register callbacks for the
reset phases.  Add trace points for logging and debugging.  No
functional change, that will come in followup patches.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/system/igvm-cfg.h      |  1 +
 include/system/igvm-internal.h |  1 +
 backends/igvm-cfg.c            | 35 +++++++++++++++++++++++++++++++++-
 backends/trace-events          |  5 +++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 6c07f3084082..b0380133b9a0 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -14,6 +14,7 @@
 
 #include "qemu/typedefs.h"
 #include "qom/object.h"
+#include "hw/resettable.h"
 
 typedef struct IgvmCfgClass {
     ObjectClass parent_class;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 475a29bbf3d7..e0452080b127 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -21,6 +21,7 @@ struct IgvmCfg {
      *           format.
      */
     char *filename;
+    ResettableState reset_state;
 };
 
 #endif
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 001c4dc93346..e0df3eaa8efd 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -17,6 +17,8 @@
 #include "system/reset.h"
 #include "qom/object_interfaces.h"
 
+#include "trace.h"
+
 static char *get_igvm(Object *obj, Error **errp)
 {
     IgvmCfg *igvm = IGVM_CFG(obj);
@@ -30,24 +32,55 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
     igvm->filename = g_strdup(value);
 }
 
+static ResettableState *igvm_reset_state(Object *obj)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return &igvm->reset_state;
+}
+
+static void igvm_reset_enter(Object *obj, ResetType type)
+{
+    trace_igvm_reset_enter(type);
+}
+
+static void igvm_reset_hold(Object *obj, ResetType type)
+{
+    trace_igvm_reset_hold(type);
+}
+
+static void igvm_reset_exit(Object *obj, ResetType type)
+{
+    trace_igvm_reset_exit(type);
+}
+
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
-                                   { TYPE_USER_CREATABLE }, { NULL })
+                                   { TYPE_USER_CREATABLE },
+                                   { TYPE_RESETTABLE_INTERFACE },
+                                   { NULL })
 
 static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
 {
     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
     object_class_property_set_description(oc, "file",
                                           "Set the IGVM filename to use");
 
     igvmc->process = qigvm_process_file;
+
+    rc->get_state = igvm_reset_state;
+    rc->phases.enter = igvm_reset_enter;
+    rc->phases.hold = igvm_reset_hold;
+    rc->phases.exit = igvm_reset_exit;
 }
 
 static void igvm_cfg_init(Object *obj)
 {
+    qemu_register_resettable(obj);
 }
 
 static void igvm_cfg_finalize(Object *obj)
 {
+    qemu_unregister_resettable(obj);
 }
diff --git a/backends/trace-events b/backends/trace-events
index 56132d3fd22b..45ac46dc2454 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,8 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+
+# igvm-cfg.c
+igvm_reset_enter(int type) "type=%u"
+igvm_reset_hold(int type) "type=%u"
+igvm_reset_exit(int type) "type=%u"
-- 
2.52.0


