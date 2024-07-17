Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B17C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TD-0003uB-Va; Wed, 17 Jul 2024 07:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2Sj-0001qY-4c
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:47 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SZ-0006zq-VE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:43 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id A6FE938F9CB; Wed, 17 Jul 2024 13:04:06 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 phil@philjordan.eu, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 7/8] hw/display/apple-gfx: Adds configurable mode list
Date: Wed, 17 Jul 2024 13:03:25 +0200
Message-Id: <20240717110326.45230-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240717110326.45230-1-phil@philjordan.eu>
References: <20240717110326.45230-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_NONE=0.001, TVD_RCVD_IP=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This change adds a property 'display_modes' on the graphics device
which permits specifying a list of display modes. (screen resolution
and refresh rate)

PCI variant of apple-gfx only for the moment.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx-pci.m |  43 ++++++++++-
 hw/display/apple-gfx.h     |  17 ++++-
 hw/display/apple-gfx.m     | 151 ++++++++++++++++++++++++++++++++++---
 3 files changed, 198 insertions(+), 13 deletions(-)

diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index b3311e736c..942fba16a2 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -1,6 +1,7 @@
 #include "apple-gfx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "trace.h"
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
@@ -86,6 +87,46 @@ static void apple_gfx_pci_reset(DeviceState *dev)
     [s->common.pgdev reset];
 }
 
+static void apple_gfx_pci_get_display_modes(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    Property *prop = opaque;
+    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj, prop);
+
+    apple_gfx_get_display_modes(mode_list, v, name, errp);
+}
+
+static void apple_gfx_pci_set_display_modes(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    Property *prop = opaque;
+    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj, prop);
+
+    apple_gfx_set_display_modes(mode_list, v, name, errp);
+}
+
+const PropertyInfo apple_gfx_pci_prop_display_modes = {
+    .name  = "display_modes",
+    .description =
+        "Colon-separated list of display modes; "
+        "<width>x<height>@<refresh-rate>; the first mode is considered "
+        "'native'. Example: 3840x2160@60:2560x1440@60:1920x1080@60",
+    .get   = apple_gfx_pci_get_display_modes,
+    .set   = apple_gfx_pci_set_display_modes,
+};
+
+#define DEFINE_PROP_DISPLAY_MODES(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, apple_gfx_pci_prop_display_modes, \
+                AppleGFXDisplayModeList)
+
+static Property apple_gfx_pci_properties[] = {
+    DEFINE_PROP_DISPLAY_MODES("display-modes", AppleGFXPCIState,
+                              common.display_modes),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -101,7 +142,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
     pci->class_id = PCI_CLASS_DISPLAY_OTHER;
     pci->realize = apple_gfx_pci_realize;
 
-    // TODO: Property for setting mode list
+    device_class_set_props(dc, apple_gfx_pci_properties);
 }
 
 static TypeInfo apple_gfx_pci_types[] = {
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 995ecf7f4a..baad4a9865 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -5,14 +5,28 @@
 #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
 
 #include "qemu/typedefs.h"
+#include "qemu/osdep.h"
 
 typedef struct AppleGFXState AppleGFXState;
 
+typedef struct AppleGFXDisplayMode {
+    uint16_t width_px;
+    uint16_t height_px;
+    uint16_t refresh_rate_hz;
+} AppleGFXDisplayMode;
+
+typedef struct AppleGFXDisplayModeList {
+    GArray *modes;
+} AppleGFXDisplayModeList;
+
 void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
+void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
+                                 const char *name, Error **errp);
+void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
+                                 const char *name, Error **errp);
 
 #ifdef __OBJC__
 
-#include "qemu/osdep.h"
 #include "exec/memory.h"
 #include "ui/surface.h"
 #include <dispatch/dispatch.h>
@@ -38,6 +52,7 @@ struct AppleGFXState {
     bool new_frame;
     bool cursor_show;
     QEMUCursor *cursor;
+    AppleGFXDisplayModeList display_modes;
 
     dispatch_queue_t render_queue;
     /* The following fields should only be accessed from render_queue: */
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 018db8bf19..de6dac9e04 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -16,6 +16,9 @@
 #include "trace.h"
 #include "qemu-main.h"
 #include "qemu/main-loop.h"
+#include "qemu/cutils.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
@@ -23,9 +26,10 @@
 #include <mach/mach_vm.h>
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
-static const PGDisplayCoord_t apple_gfx_modes[] = {
-    { .x = 1440, .y = 1080 },
-    { .x = 1280, .y = 1024 },
+static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
+    { 1920, 1080, 60 },
+    { 1440, 1080, 60 },
+    { 1280, 1024, 60 },
 };
 
 typedef struct PGTask_s { // Name matches forward declaration in PG header
@@ -278,7 +282,6 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 static void create_fb(AppleGFXState *s)
 {
     s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
-    set_mode(s, 1440, 1080);
 
     s->cursor_show = true;
 }
@@ -479,20 +482,24 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
     return disp_desc;
 }
 
-static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
+static NSArray<PGDisplayMode*>* apple_gfx_create_display_mode_array(
+    const AppleGFXDisplayMode display_modes[], int display_mode_count)
 {
-    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
+    PGDisplayMode **modes = alloca(sizeof(modes[0]) * display_mode_count);
     NSArray<PGDisplayMode*>* mode_array = nil;
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
+    for (i = 0; i < display_mode_count; i++) {
+        const AppleGFXDisplayMode *mode = &display_modes[i];
+        PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px };
         modes[i] =
-            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
+            [[PGDisplayMode alloc] initWithSizeInPixels:mode_size
+                                        refreshRateInHz:mode->refresh_rate_hz];
     }
 
-    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
+    mode_array = [NSArray arrayWithObjects:modes count:display_mode_count];
 
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
+    for (i = 0; i < display_mode_count; i++) {
         [modes[i] release];
         modes[i] = nil;
     }
@@ -529,6 +536,8 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
 void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
 {
     PGDisplayDescriptor *disp_desc = nil;
+    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
+    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
 
     QTAILQ_INIT(&s->tasks);
     s->render_queue = dispatch_queue_create("apple-gfx.render",
@@ -546,7 +555,127 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
     s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
                                               port:0 serialNum:1234];
     [disp_desc release];
-    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
+
+    if (s->display_modes.modes != NULL && s->display_modes.modes->len > 0) {
+        display_modes =
+            &g_array_index(s->display_modes.modes, AppleGFXDisplayMode, 0);
+        num_display_modes = s->display_modes.modes->len;
+    }
+    s->pgdisp.modeList =
+        apple_gfx_create_display_mode_array(display_modes, num_display_modes);
 
     create_fb(s);
 }
+
+void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
+                                 const char *name, Error **errp)
+{
+    GArray *modes = mode_list->modes;
+    /* 3 uint16s (max 5 digits) and 3 separator characters per mode + nul. */
+    size_t buffer_size = (5 + 1) * 3 * modes->len + 1;
+
+    char *buffer = alloca(buffer_size);
+    char *pos = buffer;
+
+    unsigned used = 0;
+    buffer[0] = '\0';
+    for (guint i = 0; i < modes->len; ++i)
+    {
+        AppleGFXDisplayMode *mode =
+            &g_array_index(modes, AppleGFXDisplayMode, i);
+        int rc = snprintf(pos, buffer_size - used,
+                          "%s%"PRIu16"x%"PRIu16"@%"PRIu16,
+                          i > 0 ? ":" : "",
+                          mode->width_px, mode->height_px,
+                          mode->refresh_rate_hz);
+        used += rc;
+        pos += rc;
+        assert(used < buffer_size);
+    }
+
+    pos = buffer;
+    visit_type_str(v, name, &pos, errp);
+}
+
+void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
+                                 const char *name, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *endptr;
+    char *str;
+    int ret;
+    unsigned int val;
+    uint32_t num_modes;
+    GArray *modes;
+    uint32_t mode_idx;
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    // Count colons to estimate modes. No leading/trailing colons so start at 1.
+    num_modes = 1;
+    for (size_t i = 0; str[i] != '\0'; ++i)
+    {
+        if (str[i] == ':') {
+            ++num_modes;
+        }
+    }
+
+    modes = g_array_sized_new(false, true, sizeof(AppleGFXDisplayMode), num_modes);
+
+    endptr = str;
+    for (mode_idx = 0; mode_idx < num_modes; ++mode_idx)
+    {
+        AppleGFXDisplayMode mode = {};
+        if (mode_idx > 0)
+        {
+            if (*endptr != ':') {
+                goto separator_error;
+            }
+            ++endptr;
+        }
+
+        ret = qemu_strtoui(endptr, &endptr, 10, &val);
+        if (ret || val > UINT16_MAX || val == 0) {
+            error_setg(errp, "width of '%s' must be a decimal integer number "
+                       "of pixels in the range 1..65535", name);
+            goto out;
+        }
+        mode.width_px = val;
+        if (*endptr != 'x') {
+            goto separator_error;
+        }
+
+        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
+        if (ret || val > UINT16_MAX || val == 0) {
+            error_setg(errp, "height of '%s' must be a decimal integer number "
+                       "of pixels in the range 1..65535", name);
+            goto out;
+        }
+        mode.height_px = val;
+        if (*endptr != '@') {
+            goto separator_error;
+        }
+
+        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
+        if (ret) {
+            error_setg(errp, "refresh rate of '%s'"
+                       " must be a non-negative decimal integer (Hertz)", name);
+        }
+        mode.refresh_rate_hz = val;
+        g_array_append_val(modes, mode);
+    }
+
+    mode_list->modes = modes;
+    goto out;
+
+separator_error:
+    error_setg(errp, "Each display mode takes the format "
+               "'<width>x<height>@<rate>', modes are separated by colons. (:)");
+out:
+    g_free(str);
+    return;
+}
-- 
2.39.3 (Apple Git-146)


