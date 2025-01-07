Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF62E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBbF-0003Rk-L6; Tue, 07 Jan 2025 10:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBbC-0003Iw-BE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBbA-00059f-NV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGnGsQOQFsBzSvR/lTFsCrb437Mz82OmNftfJSgXau0=;
 b=PIPvLTGjeJQaGDEK0bka8FJurEWnIRqyCPiBnWnuQ9/9A5liQwyCDKEfG1oDD7X8IhC/yZ
 iOxuZIiWWYppXfnGeX259iq6Lux81dbrcjveKOgmftV83z/vxuP6HFkEZqrQm8d+ZC1/nD
 9j9a6+URWdVGWKrKjdZQJiif+vAoYLE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-BvgPxBInMhS-9gfSsLiTfQ-1; Tue,
 07 Jan 2025 10:34:25 -0500
X-MC-Unique: BvgPxBInMhS-9gfSsLiTfQ-1
X-Mimecast-MFC-AGG-ID: BvgPxBInMhS-9gfSsLiTfQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BB7C1979072; Tue,  7 Jan 2025 15:34:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 746F71956053; Tue,  7 Jan 2025 15:34:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AE7C51800604; Tue, 07 Jan 2025 16:33:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 18/21] hw/uefi: add uefi-vars-isa device
Date: Tue,  7 Jan 2025 16:33:45 +0100
Message-ID: <20250107153353.1144978-19-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This adds isa bindings for the variable service.

Usage: qemu-system-x86_64 -device uefi-vars-isa,jsonfile=/path/to/uefivars.json

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-isa.c | 91 +++++++++++++++++++++++++++++++++++++++
 hw/uefi/Kconfig           |  6 +++
 hw/uefi/meson.build       |  5 +++
 3 files changed, 102 insertions(+)
 create mode 100644 hw/uefi/var-service-isa.c

diff --git a/hw/uefi/var-service-isa.c b/hw/uefi/var-service-isa.c
new file mode 100644
index 000000000000..5d74395fe5f0
--- /dev/null
+++ b/hw/uefi/var-service-isa.c
@@ -0,0 +1,91 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - ISA variant for x64.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+
+#include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/uefi/var-service.h"
+#include "hw/uefi/var-service-api.h"
+
+#define TYPE_UEFI_VARS_ISA "uefi-vars-isa"
+OBJECT_DECLARE_SIMPLE_TYPE(uefi_vars_isa_state, UEFI_VARS_ISA)
+
+struct uefi_vars_isa_state {
+    ISADevice parent_obj;
+    struct uefi_vars_state state;
+};
+
+static const VMStateDescription vmstate_uefi_vars_isa = {
+    .name = "uefi-vars-isa",
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, uefi_vars_isa_state, 0,
+                       vmstate_uefi_vars, uefi_vars_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property uefi_vars_isa_properties[] = {
+    DEFINE_PROP_SIZE("size", uefi_vars_isa_state, state.max_storage,
+                     256 * 1024),
+    DEFINE_PROP_STRING("jsonfile", uefi_vars_isa_state, state.jsonfile),
+    DEFINE_PROP_BOOL("force-secure-boot", uefi_vars_isa_state,
+                     state.force_secure_boot, false),
+    DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_isa_state,
+                     state.disable_custom_mode, false),
+};
+
+static void uefi_vars_isa_init(Object *obj)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(obj);
+
+    uefi_vars_init(obj, &uv->state);
+}
+
+static void uefi_vars_isa_reset(DeviceState *dev)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(dev);
+
+    uefi_vars_hard_reset(&uv->state);
+}
+
+static void uefi_vars_isa_realize(DeviceState *dev, Error **errp)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(dev);
+    ISADevice *isa = ISA_DEVICE(dev);
+
+    isa_register_ioport(isa, &uv->state.mr, UEFI_VARS_IO_BASE);
+    uefi_vars_realize(&uv->state, errp);
+}
+
+static void uefi_vars_isa_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uefi_vars_isa_realize;
+    dc->vmsd = &vmstate_uefi_vars_isa;
+    device_class_set_legacy_reset(dc, uefi_vars_isa_reset);
+    device_class_set_props(dc, uefi_vars_isa_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo uefi_vars_isa_info = {
+    .name          = TYPE_UEFI_VARS_ISA,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(uefi_vars_isa_state),
+    .instance_init = uefi_vars_isa_init,
+    .class_init    = uefi_vars_isa_class_init,
+};
+module_obj(TYPE_UEFI_VARS_ISA);
+module_dep("hw-uefi-vars");
+
+static void uefi_vars_isa_register_types(void)
+{
+    type_register_static(&uefi_vars_isa_info);
+}
+
+type_init(uefi_vars_isa_register_types)
diff --git a/hw/uefi/Kconfig b/hw/uefi/Kconfig
index ca6c2bc46a96..feb9f6de5e30 100644
--- a/hw/uefi/Kconfig
+++ b/hw/uefi/Kconfig
@@ -1,3 +1,9 @@
 config UEFI_VARS
 	bool
         default y if X86_64 || AARCH64
+
+config UEFI_VARS_ISA
+	bool
+        default y
+        depends on UEFI_VARS
+        depends on ISA_BUS
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index cf2d26e9bf9a..0f191c436bcf 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -14,6 +14,11 @@ if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
   uefi_vars_ss.add(files('var-service-siglist.c'))
 endif
 
+uefi_vars_isa_ss = ss.source_set()
+uefi_vars_isa_ss.add(when: 'CONFIG_UEFI_VARS_ISA',
+                     if_true: files('var-service-isa.c'))
+
 modules += { 'hw-uefi' : {
     'vars'     : uefi_vars_ss,
+    'vars-isa' : uefi_vars_isa_ss,
 }}
-- 
2.47.1


