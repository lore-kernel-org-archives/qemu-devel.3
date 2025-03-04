Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0021C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRjP-0007dN-NJ; Tue, 04 Mar 2025 07:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhk-0004tX-OJ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhi-00074P-Oi
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2u9omNZBitCXUqKxUNmPV8npW4CggDgtLN2KruyGkQ=;
 b=M7KVrNn/PbyVY8yYYjIrTiA1j7fIDYtkIviCtg3yFUlyZPflKfQUJ1Cmreq1XkNTQdzcNU
 9hl3vcxkmza7g73VW9icwALJ6Nhh8xWWsN49NeC4gPU3JnZ2AjNbhfd6JdYLM5nZWuMgey
 9hWoN769WChEMiXznyn7Bjnk6pI3z+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-W4DTbsqDPQelac5JlWY1JA-1; Tue,
 04 Mar 2025 07:48:54 -0500
X-MC-Unique: W4DTbsqDPQelac5JlWY1JA-1
X-Mimecast-MFC-AGG-ID: W4DTbsqDPQelac5JlWY1JA_1741092533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7A001954201; Tue,  4 Mar 2025 12:48:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B15180087C; Tue,  4 Mar 2025 12:48:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 70E3B1800607; Tue, 04 Mar 2025 13:48:16 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 18/24] hw/uefi: add uefi-vars-sysbus device
Date: Tue,  4 Mar 2025 13:48:06 +0100
Message-ID: <20250304124815.591749-19-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds sysbus bindings for the variable service.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250225163031.1409078-19-kraxel@redhat.com>
---
 hw/uefi/var-service-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++
 hw/uefi/meson.build          |  3 +-
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/var-service-sysbus.c

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
new file mode 100644
index 000000000000..60072c8815cd
--- /dev/null
+++ b/hw/uefi/var-service-sysbus.c
@@ -0,0 +1,91 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - sysbus variant.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+
+#include "hw/uefi/var-service.h"
+#include "hw/uefi/var-service-api.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(uefi_vars_sysbus_state, UEFI_VARS_SYSBUS)
+
+struct uefi_vars_sysbus_state {
+    SysBusDevice parent_obj;
+    struct uefi_vars_state state;
+};
+
+static const VMStateDescription vmstate_uefi_vars_sysbus = {
+    .name = TYPE_UEFI_VARS_SYSBUS,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, uefi_vars_sysbus_state, 0,
+                       vmstate_uefi_vars, uefi_vars_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property uefi_vars_sysbus_properties[] = {
+    DEFINE_PROP_SIZE("size", uefi_vars_sysbus_state, state.max_storage,
+                     256 * 1024),
+    DEFINE_PROP_STRING("jsonfile", uefi_vars_sysbus_state, state.jsonfile),
+    DEFINE_PROP_BOOL("force-secure-boot", uefi_vars_sysbus_state,
+                     state.force_secure_boot, false),
+    DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_sysbus_state,
+                     state.disable_custom_mode, false),
+    DEFINE_PROP_BOOL("use-pio", uefi_vars_sysbus_state,
+                     state.use_pio, false),
+};
+
+static void uefi_vars_sysbus_init(Object *obj)
+{
+    uefi_vars_sysbus_state *uv = UEFI_VARS_SYSBUS(obj);
+
+    uefi_vars_init(obj, &uv->state);
+}
+
+static void uefi_vars_sysbus_reset(DeviceState *dev)
+{
+    uefi_vars_sysbus_state *uv = UEFI_VARS_SYSBUS(dev);
+
+    uefi_vars_hard_reset(&uv->state);
+}
+
+static void uefi_vars_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    uefi_vars_sysbus_state *uv = UEFI_VARS_SYSBUS(dev);
+    SysBusDevice *sysbus = SYS_BUS_DEVICE(dev);
+
+    sysbus_init_mmio(sysbus, &uv->state.mr);
+    uefi_vars_realize(&uv->state, errp);
+}
+
+static void uefi_vars_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uefi_vars_sysbus_realize;
+    dc->vmsd = &vmstate_uefi_vars_sysbus;
+    device_class_set_legacy_reset(dc, uefi_vars_sysbus_reset);
+    device_class_set_props(dc, uefi_vars_sysbus_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo uefi_vars_sysbus_info = {
+    .name          = TYPE_UEFI_VARS_SYSBUS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(uefi_vars_sysbus_state),
+    .instance_init = uefi_vars_sysbus_init,
+    .class_init    = uefi_vars_sysbus_class_init,
+};
+module_obj(TYPE_UEFI_VARS_SYSBUS);
+
+static void uefi_vars_sysbus_register_types(void)
+{
+    type_register_static(&uefi_vars_sysbus_info);
+}
+
+type_init(uefi_vars_sysbus_register_types)
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index e63708aa164f..91eb95f89e6d 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -8,7 +8,8 @@ if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
                          'var-service-auth.c',
                          'var-service-guid.c',
                          'var-service-utils.c',
-                         'var-service-policy.c'))
+                         'var-service-policy.c',
+                         'var-service-sysbus.c'))
   uefi_vars_ss.add(when: gnutls,
                    if_true: files('var-service-pkcs7.c'),
                    if_false: files('var-service-pkcs7-stub.c'))
-- 
2.48.1


