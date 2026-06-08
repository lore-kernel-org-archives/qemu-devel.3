Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA607CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbn4-0001vm-Fi; Mon, 08 Jun 2026 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbn1-0001uB-QD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmz-0007sp-Ry
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id EFB49202949;
 Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com, Luigi Leonardi <leonardi@redhat.com>
Subject: [RFC PATCH 08/10] qdev: Add plane property
Date: Mon,  8 Jun 2026 17:21:07 +0200
Message-ID: <20260608152109.356783-9-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joerg Roedel <joerg.roedel@amd.com>

Add a property to track the plane into which the qdev needs to inject
IRQs.

Co-developed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 hw/core/qdev.c                      | 26 ++++++++++++++++++++++++++
 include/hw/core/qdev.h              |  4 ++++
 tests/unit/test-qdev-global-props.c |  5 +++++
 tests/unit/test-qdev.c              |  5 +++++
 4 files changed, 40 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6f2..73d18fc0d639 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -662,6 +662,28 @@ static bool device_get_hotplugged(Object *obj, Error **errp)
     return dev->hotplugged;
 }
 
+static void device_get_plane(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    uint8_t value = dev->plane;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void device_set_plane(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    dev->plane = value;
+}
+
 static void device_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -674,6 +696,7 @@ static void device_initfn(Object *obj)
     dev->instance_id_alias = -1;
     dev->realized = false;
     dev->allow_unplug_during_migration = false;
+    dev->plane = qdev_default_plane();
 
     QLIST_INIT(&dev->gpios);
     QLIST_INIT(&dev->clocks);
@@ -796,6 +819,9 @@ static void device_class_init(ObjectClass *class, const void *data)
                                    device_get_hotplugged, NULL);
     object_class_property_add_link(class, "parent_bus", TYPE_BUS,
                                    offsetof(DeviceState, parent_bus), NULL, 0);
+    object_class_property_add(class, "plane", "uint8",
+                              device_get_plane, device_set_plane,
+                              NULL, NULL);
 }
 
 static void do_legacy_reset(Object *obj, ResetType type)
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 83ad1d5f1550..28d2efcbe455 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -295,6 +295,10 @@ struct DeviceState {
      * Used to prevent re-entrancy confusing things.
      */
     MemReentrancyGuard mem_reentrancy_guard;
+    /**
+     * @plane: Plane the device is assigned to.
+     */
+    uint8_t plane;
 };
 
 typedef struct DeviceListener DeviceListener;
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb902..2aca5bda22b9 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -71,6 +71,11 @@ static const TypeInfo subclass_type = {
     .parent = TYPE_STATIC_PROPS,
 };
 
+uint8_t qdev_default_plane(void)
+{
+    return 0;
+}
+
 /*
  * Initialize a fake machine, being prepared for future tests.
  *
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f4..6e3127b41afd 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -26,6 +26,11 @@ static const Property my_dev_props[] = {
                      qdev_prop_uint32, uint32_t),
 };
 
+uint8_t qdev_default_plane(void)
+{
+    return 0;
+}
+
 static void my_dev_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-- 
2.53.0


