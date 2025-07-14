Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHj9-0004wh-A7; Mon, 14 Jul 2025 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6D-0006a6-DD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6A-0003JY-Cb
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0DW657PuEuVKjB0hxciKKT0eQfi++HEcWHyzhRvOag=;
 b=Uzh0tEZNfHEOZm/ySI5GbjBUCxnKOu2oR8UeTayiKnXrWvyn1gVu56FWt4LAxY0lrCmqiE
 w6U/XDbn5gkNd/QJCGaqL+54nlfyDyl7XKUq/O84pEyUZSGCmZ6T/JprN9gK/pxSlO3gxh
 fAwvBhngyOhdIandpw6HEEm0K9sU8lI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-6YZXFW-1Pmm3AA4UjAhicA-1; Mon,
 14 Jul 2025 07:11:49 -0400
X-MC-Unique: 6YZXFW-1Pmm3AA4UjAhicA-1
X-Mimecast-MFC-AGG-ID: 6YZXFW-1Pmm3AA4UjAhicA_1752491508
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F3D118002ED; Mon, 14 Jul 2025 11:11:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 427A219560A3; Mon, 14 Jul 2025 11:11:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Andrew Keesler <ankeesler@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/13] hw/display: Allow injection of virtio-gpu EDID name
Date: Mon, 14 Jul 2025 15:10:33 +0400
Message-ID: <20250714111039.4150419-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Andrew Keesler <ankeesler@google.com>

Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
Identification Data) is propagated by QEMU such that a virtual display
presents legitimate metadata (e.g., name, serial number, preferred
resolutions, etc.) to its connected guest.

This change adds the ability to specify the EDID name for a particular
virtio-vga display. Previously, every virtual display would have the same
name: "QEMU Monitor". Now, we can inject names of displays in order to test
guest behavior that is specific to display names. We provide the ability to
inject the display name from the frontend since this is guest visible
data. Furthermore, this makes it clear where N potential display outputs
would get their name from (which will be added in a future change).

Note that we have elected to use a struct here for output data for
extensibility - we intend to add per-output fields like resolution in a
future change.

It should be noted that EDID names longer than 12 bytes will be truncated
per spec (I think?).

Testing: verified that when I specified 2 outputs for a virtio-gpu with
edid_name set, the names matched those that I configured with my vnc
display.

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA"
              },
              {
                 "name":"BBB"
              }
            ]}'

Signed-off-by: Andrew Keesler <ankeesler@google.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250709121126.2946088-2-ankeesler@google.com>
---
 qapi/virtio.json                    | 18 ++++++++++--
 include/hw/display/edid.h           |  2 ++
 include/hw/qdev-properties-system.h |  5 ++++
 include/hw/virtio/virtio-gpu.h      |  3 ++
 hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c        | 27 ++++++++++++++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 73df718a26..5e658a7033 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -963,17 +963,31 @@
 { 'struct': 'IOThreadVirtQueueMapping',
   'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
 
+##
+# @VirtIOGPUOutput:
+#
+# Describes configuration of a VirtIO GPU output.
+#
+# @name: the name of the output
+#
+# Since: 10.1
+##
+
+{ 'struct': 'VirtIOGPUOutput',
+  'data': { 'name': 'str' } }
+
 ##
 # @DummyVirtioForceArrays:
 #
 # Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
-# internally
+# and VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
 
 { 'struct': 'DummyVirtioForceArrays',
-  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] } }
+  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'],
+            'unused-virtio-gpu-output': ['VirtIOGPUOutput'] } }
 
 ##
 # @GranuleMode:
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 520f8ec202..91c0a428af 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,6 +1,8 @@
 #ifndef EDID_H
 #define EDID_H
 
+#define EDID_NAME_MAX_LENGTH 12
+
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
     const char *name;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c52..9601a11a09 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -32,6 +32,7 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 extern const PropertyInfo qdev_prop_endian_mode;
 extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
+extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -110,4 +111,8 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
                          qdev_prop_vmapple_virtio_blk_variant, \
                          VMAppleVirtioBlkVariant)
 
+#define DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_virtio_gpu_output_list, \
+                VirtIOGPUOutputList *)
+
 #endif
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a42957c4e2..9f16f89a36 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -20,6 +20,7 @@
 #include "hw/virtio/virtio.h"
 #include "qemu/log.h"
 #include "system/vhost-user-backend.h"
+#include "qapi/qapi-types-virtio.h"
 
 #include "standard-headers/linux/virtio_gpu.h"
 #include "standard-headers/linux/virtio_ids.h"
@@ -128,6 +129,7 @@ struct virtio_gpu_base_conf {
     uint32_t xres;
     uint32_t yres;
     uint64_t hostmem;
+    VirtIOGPUOutputList *outputs;
 };
 
 struct virtio_gpu_ctrl_command {
@@ -167,6 +169,7 @@ struct VirtIOGPUBaseClass {
 
 #define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       \
     DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    \
+    DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST("outputs", _state, _conf.outputs), \
     DEFINE_PROP_BIT("edid", _state, _conf.flags, \
                     VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 24e145d870..1f810b7ddf 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1299,3 +1299,47 @@ const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
+
+/* --- VirtIOGPUOutputList --- */
+
+static void get_virtio_gpu_output_list(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    visit_type_VirtIOGPUOutputList(v, name, prop_ptr, errp);
+}
+
+static void set_virtio_gpu_output_list(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+    VirtIOGPUOutputList *list;
+
+    if (!visit_type_VirtIOGPUOutputList(v, name, &list, errp)) {
+        return;
+    }
+
+    qapi_free_VirtIOGPUOutputList(*prop_ptr);
+    *prop_ptr = list;
+}
+
+static void release_virtio_gpu_output_list(Object *obj,
+    const char *name, void *opaque)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    qapi_free_VirtIOGPUOutputList(*prop_ptr);
+    *prop_ptr = NULL;
+}
+
+const PropertyInfo qdev_prop_virtio_gpu_output_list = {
+    .type = "VirtIOGPUOutputList",
+    .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
+    .get = get_virtio_gpu_output_list,
+    .set = set_virtio_gpu_output_list,
+    .release = release_virtio_gpu_output_list,
+};
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 9eb806b71f..7269477a1c 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
 #include "trace.h"
+#include "qapi/qapi-types-virtio.h"
 
 void
 virtio_gpu_base_reset(VirtIOGPUBase *g)
@@ -56,6 +57,8 @@ void
 virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
                               struct virtio_gpu_resp_edid *edid)
 {
+    size_t output_idx;
+    VirtIOGPUOutputList *node;
     qemu_edid_info info = {
         .width_mm = g->req_state[scanout].width_mm,
         .height_mm = g->req_state[scanout].height_mm,
@@ -64,6 +67,14 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
         .refresh_rate = g->req_state[scanout].refresh_rate,
     };
 
+    for (output_idx = 0, node = g->conf.outputs;
+         output_idx <= scanout && node; output_idx++, node = node->next) {
+        if (output_idx == scanout && node->value && node->value->name) {
+            info.name = node->value->name;
+            break;
+        }
+    }
+
     edid->size = cpu_to_le32(sizeof(edid->edid));
     qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
 }
@@ -172,6 +183,8 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
                                VirtIOHandleOutput cursor_cb,
                                Error **errp)
 {
+    size_t output_idx;
+    VirtIOGPUOutputList *node;
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
     int i;
@@ -181,6 +194,20 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         return false;
     }
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node; output_idx++, node = node->next) {
+        if (output_idx == g->conf.max_outputs) {
+            error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
+            return false;
+        }
+        if (node->value && node->value->name &&
+            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
+            error_setg(errp, "invalid output name '%s' > %d",
+                       node->value->name, EDID_NAME_MAX_LENGTH);
+            return false;
+        }
+    }
+
     if (virtio_gpu_virgl_enabled(g->conf)) {
         error_setg(&g->migration_blocker, "virgl is not yet migratable");
         if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
-- 
2.50.0


