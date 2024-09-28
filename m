Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A32CCF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 09:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTHd-0000Jm-IH; Sat, 28 Sep 2024 04:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHb-0000Hv-KX
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHZ-0002JB-J3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cd6ece97cso1079555f8f.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513908; x=1728118708;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnhSO9Zp03vZcISVYUidyjWsniT7WLSHtpVFi0MugPQ=;
 b=njx9waH74qbqDXHcDBKt3h1/WqnJlwdGs94AngFZmrtaQ+FB68I+RmvUMT3j8dUfO3
 dV15YjRj+iZx1qktsaq9udrFiOUnzKjWtfflS77Ern1KjaacY7uE4y2BhjYvXvnFBaB6
 KIOMMFI96xJerFH99mgQljs+P0MOXpPoH3dVMqOH+eHDbMK+MRtm36Q6aL7uge48Vnli
 3qeG6PbiB/9pvcDmqIfDKfgwfR3Gk+zpZ1LzoMWQbYdIB5c0K+RKZ8S3/oyNebamldDe
 fMuvWklsSQQLWes7t2i8V00K3Uvcr1MwfpYeiu3CVJTZ7DY1v1RJsdCenn3H4j93+2vB
 VQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513908; x=1728118708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnhSO9Zp03vZcISVYUidyjWsniT7WLSHtpVFi0MugPQ=;
 b=HqC3mgCXdQRU5udZ2Hh8fKwVjicjV9HoRbiSAkY9P/8nUjTsCfyUFW2nCn2Mliu2G8
 B7G7ncRl1Zsi/FVagQYurMaUKSCusV++UwQ6xQwFURm4qwUPhLY/8MfsOxl6Ch7osDmi
 tWW3kievZhtLuyk0qn1QUeKwPoi99LRkobRlw+GO7Hz9dttsTbRErv3ZAFzBL94otOFT
 7t5dc1kU1ZuiVeOdD2ElJyWrXQVkk3g9JFdJNtTrSj2LxBOo/dyHb3uG8hf0WpoSc3bv
 BDlxVXf64DdoqFMdIqoCINdJgWDxXWb/77eHMQutdHJ2hKPhDLN/mik2YH+7Fu3v78Tu
 ZIew==
X-Gm-Message-State: AOJu0YyEa1H2qYk7++7r8892yqLR6/uPfB5CMEd0+B7h6JtZa+P0HJ/e
 nsfhwDWsKEC7Sb0cmfMaWcSqByq0teb3Zw8DguBQg9SHbbZ7XJWpKz6wN1Z4JN4PZcQb2V4GFbn
 6bg==
X-Google-Smtp-Source: AGHT+IF8xMaG7MBJHZEk74+QrN0YF9AJ8nWp056uZqQG03nR5muYjTa1Yb5gJAfdiHMw2RWQd28kuw==
X-Received: by 2002:a5d:6acf:0:b0:37c:c4bc:181c with SMTP id
 ffacd0b85a97d-37cd5a6b66cmr3694968f8f.11.1727513907803; 
 Sat, 28 Sep 2024 01:58:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:58:27 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 04/14] hw/display/apple-gfx: Adds configurable mode list
Date: Sat, 28 Sep 2024 10:57:17 +0200
Message-Id: <20240928085727.56883-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::435;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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
index 9370258ee46..ea86a1f4a21 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -16,6 +16,7 @@
 #include "apple-gfx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "trace.h"
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
@@ -101,6 +102,46 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
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
@@ -118,7 +159,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
     pci->class_id = PCI_CLASS_DISPLAY_OTHER;
     pci->realize = apple_gfx_pci_realize;
 
-    // TODO: Property for setting mode list
+    device_class_set_props(dc, apple_gfx_pci_properties);
 }
 
 static TypeInfo apple_gfx_pci_types[] = {
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 995ecf7f4a7..baad4a98652 100644
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
index 6ef1048d93d..358192db6a0 100644
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
@@ -264,7 +268,6 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 static void create_fb(AppleGFXState *s)
 {
     s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
-    set_mode(s, 1440, 1080);
 
     s->cursor_show = true;
 }
@@ -466,20 +469,24 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
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
@@ -516,6 +523,8 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
 void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
 {
     PGDisplayDescriptor *disp_desc = nil;
+    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
+    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
 
     QTAILQ_INIT(&s->tasks);
     s->render_queue = dispatch_queue_create("apple-gfx.render",
@@ -533,7 +542,127 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
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
2.39.3 (Apple Git-145)


