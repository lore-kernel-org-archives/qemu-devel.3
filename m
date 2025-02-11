Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F754C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmV8-00036r-Pj; Tue, 11 Feb 2025 04:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1thmUu-0002Pd-Er
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1thmUs-00034Y-JC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739265839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDe69REBwANjG/ksvGk7MhbAEdcoWWDQGF+7LC7014Q=;
 b=HUNNcJqfoCncDpgW+6FY6BblHx/uw6fNsuIezQDvfQiEj/2sinfGD33ZpDeUU7HIgQexpW
 +BSt2Wo7ZZ6UWjI1RE7zcBSjVUZY7gicYxjW1n9DpAdbZuawD5T6fr7PdtSTkjeC+QROHI
 xSevWmLY6HUAFb6j/mfmzbow3e3rLBE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-xOqvmH6xPlG0jkKY0UEuBQ-1; Tue,
 11 Feb 2025 04:23:56 -0500
X-MC-Unique: xOqvmH6xPlG0jkKY0UEuBQ-1
X-Mimecast-MFC-AGG-ID: xOqvmH6xPlG0jkKY0UEuBQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDAC5180036F; Tue, 11 Feb 2025 09:23:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8896F180087B; Tue, 11 Feb 2025 09:23:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A69A21800618; Tue, 11 Feb 2025 10:23:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 17/23] hw/uefi: add uefi-vars-sysbus device
Date: Tue, 11 Feb 2025 10:23:15 +0100
Message-ID: <20250211092324.965440-18-kraxel@redhat.com>
In-Reply-To: <20250211092324.965440-1-kraxel@redhat.com>
References: <20250211092324.965440-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/uefi/var-service-sysbus.c | 89 ++++++++++++++++++++++++++++++++++++
 hw/uefi/meson.build          |  3 +-
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/var-service-sysbus.c

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
new file mode 100644
index 000000000000..1815c0b8d27f
--- /dev/null
+++ b/hw/uefi/var-service-sysbus.c
@@ -0,0 +1,89 @@
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
index d280881f457a..cf2d26e9bf9a 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -6,7 +6,8 @@ if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
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


