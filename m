Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BACF65FF
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLrO-0007bM-9K; Mon, 26 Jan 2026 07:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLr5-0001YJ-4W
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLr3-0004d4-AR
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769431084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3jwtFLrRsoSD7kJHtLbFVxmVb0Jk1JceBA+qOlBQYs=;
 b=XHewMATZMyg8sT3IVerEBWEGNgf8iDJF+wq5CKXqn8WESM8S6F2AR72s9Ncrcd3W+Vxkr9
 sSSBPMHTzdYVb6aPpe7RlGnzCxLxXv0aWomjuqHAqzuRD9hGmOPQOhYNyXWfcToT23zDX1
 x4lVY0Ciko/WE1KKoXsaCRMyasXp//o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-aOnVLEx_NO2jUcUDTOxdOA-1; Mon,
 26 Jan 2026 07:38:03 -0500
X-MC-Unique: aOnVLEx_NO2jUcUDTOxdOA-1
X-Mimecast-MFC-AGG-ID: aOnVLEx_NO2jUcUDTOxdOA_1769431082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 320EE18005B6; Mon, 26 Jan 2026 12:38:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C06F1800240; Mon, 26 Jan 2026 12:38:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C749B18000A9; Mon, 26 Jan 2026 13:37:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/5] igvm: make igvm-cfg object resettable
Date: Mon, 26 Jan 2026 13:37:52 +0100
Message-ID: <20260126123755.357378-3-kraxel@redhat.com>
In-Reply-To: <20260126123755.357378-1-kraxel@redhat.com>
References: <20260126123755.357378-1-kraxel@redhat.com>
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

Add TYPE_RESETTABLE_INTERFACE to interfaces.  Register callbacks for the
reset phases.  Add trace points for logging and debugging.  No
functional change, that will come in followup patches.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/system/igvm-internal.h |  2 ++
 backends/igvm-cfg.c            | 35 +++++++++++++++++++++++++++++++++-
 backends/trace-events          |  5 +++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 475a29bbf3d7..ac9e5683cc63 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -11,6 +11,7 @@
 
 #include "qemu/typedefs.h"
 #include "qom/object.h"
+#include "hw/core/resettable.h"
 
 struct IgvmCfg {
     ObjectClass parent_class;
@@ -21,6 +22,7 @@ struct IgvmCfg {
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
index e1992ba12f04..62a2f6cc72d0 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,8 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+
+# igvm-cfg.c
+igvm_reset_enter(int type) "type=%u"
+igvm_reset_hold(int type) "type=%u"
+igvm_reset_exit(int type) "type=%u"
-- 
2.52.0


