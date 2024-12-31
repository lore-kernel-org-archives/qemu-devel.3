Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90506E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSinN-0001Sb-6w; Tue, 31 Dec 2024 15:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinJ-00012c-57
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinC-00011I-Vc
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:48 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e3621518so4864461f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676679; x=1736281479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v8hmM8w7uYM6AENFnStcDP4Ll55lmP1xAMZVKQOAoc=;
 b=iiImqmNTh6CL0v8w8RQNzLoRVxmOs6jXcspSHRvXWuQhAqK7i19sDUZ8p2zI9Y9WP1
 QhKc/48LvTh6PzdND1Y3v2SdAZyRHtkAoTJ2SyyelkpDxiRvo/ddTwleQTepA9bwFXZb
 +UYGCm2hl8AXxlS2t/poNol2gC7PRofyIKOjvOqwP1JhZpR4RUGUc5V6dzwqTal57mrE
 8CVy1IiNsnv/kBIHDbmR8fIBG2csvI4KngRqeKWNKBywmWV1EIuIKOCOVEVM7dmS5xjl
 BnkB6anbZWkwBeOXN1dco5eZABMpoSRXX10IoFG+ZfXVHLPYqHQqicmXAydQfSV+HpJL
 hSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676679; x=1736281479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v8hmM8w7uYM6AENFnStcDP4Ll55lmP1xAMZVKQOAoc=;
 b=KhpFV2iip8B1Dd/gG6PR1VkLAPzXi4kAs/64oCn4XUG7gNQA1EDp+MBkr8/fGuDKRX
 ZHxZkIZTibhpIHCVV48MTBGq8WWLbHGwBp/MIJ87TRtUnGVsftw2eglylQl5OQYK7ZZW
 eBglNCTEuGyRhk6qFGoI8S8ltfiY1Yvv+v/QLkgEHnnCS5rPwl6Wq/7QnGBd7qWyLA2B
 /0IcXymZaimz9W4W4UgGbFzmUohI9Wu8yipIxipERxpdJ+795PPhN5QLSlQFSusSRtD3
 xAocMb1ZfUMIcnf7XIMo1vigrpbZK1MdNd+05Mjn3KfMdpb6XjvAOxziH5/FyHPTqCD+
 pWIw==
X-Gm-Message-State: AOJu0Ywzqf2n56EwkoAwoyebY8Xg+JfRZSgWdTsFlhUNQmcaB4rd/GnU
 VXMbKjc9RLB0TKOEHL0oOIeNy/couABcpxEBL1/goJu6Z0zJWzSqw5v7BXs5g0PFdh34ErNifCU
 51w0=
X-Gm-Gg: ASbGncsLzIZiOiDOf6KfahYeQqI5NMPUAJjUa+BcE1IZ7qnH908jLFqvPpSFt3Y6J8x
 w2jjdEhTRlMJiB++FqcBbuydIp+VGqwWGtzMkl327DC9Ds/TRGoM9ienBr4wafcXWItVz+OawDs
 o09atPUk5eD3AO7e8io8wmhvW/HbzlRljomXW688bENB+LXbqSktpCQz0DZ1MPsmfFNGWazTce5
 Mgi9sJgvhKcRu4yWXC07GfcKFDFHLuHmlqSgjb0QVja5WcwWrx9Z5+uby8JHKRMtvaEu0pj5Dvl
 76usv3KlP8K3yd7avftP7LhdTJXaigQ=
X-Google-Smtp-Source: AGHT+IGnqvXoJJnk5gGm0jWrh85nM0nX/nPyhlmO+JskD/FZtjlON7HS2KtqMA83RoAyKGiLXP4E4g==
X-Received: by 2002:a05:6000:480b:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-38a221fa418mr34117327f8f.34.1735676678880; 
 Tue, 31 Dec 2024 12:24:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea47asm397952225e9.4.2024.12.31.12.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/29] hw/display/apple-gfx: Adds configurable mode list
Date: Tue, 31 Dec 2024 21:22:25 +0100
Message-ID: <20241231202228.28819-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This change adds a property 'display_modes' on the graphics device
which permits specifying a list of display modes. (screen resolution
and refresh rate)

The property is an array of a custom type to make the syntax slightly
less awkward to use, for example:

-device '{"driver":"apple-gfx-pci", "display-modes":["1920x1080@60", "3840x2160@60"]}'

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241223221645.29911-5-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/apple-gfx.h      |  10 +++
 hw/display/apple-gfx-mmio.m |   7 ++
 hw/display/apple-gfx-pci.m  |   8 ++-
 hw/display/apple-gfx.m      | 130 +++++++++++++++++++++++++++++++-----
 hw/display/trace-events     |   2 +
 5 files changed, 139 insertions(+), 18 deletions(-)

diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 6c74209b361..3900cdbabbb 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -25,6 +25,12 @@
 
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
+typedef struct AppleGFXDisplayMode {
+    uint16_t width_px;
+    uint16_t height_px;
+    uint16_t refresh_rate_hz;
+} AppleGFXDisplayMode;
+
 typedef struct AppleGFXState {
     /* Initialised on init/realize() */
     MemoryRegion iomem_gfx;
@@ -33,6 +39,8 @@ typedef struct AppleGFXState {
     QemuConsole *con;
     id<MTLDevice> mtl;
     id<MTLCommandQueue> mtl_queue;
+    AppleGFXDisplayMode *display_modes;
+    uint32_t num_display_modes;
 
     /* List `tasks` is protected by task_mutex */
     QemuMutex task_mutex;
@@ -60,5 +68,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        uint64_t length, bool read_only,
                                        MemoryRegion **mapping_in_region);
 
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
+
 #endif
 
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 5a489d2d44f..b2e0e7a30fa 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -255,6 +255,11 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
     [s->common.pgdev reset];
 }
 
+static const Property apple_gfx_mmio_properties[] = {
+    DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
+                      common.num_display_modes, common.display_modes,
+                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+};
 
 static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
 {
@@ -264,6 +269,8 @@ static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
     rc->phases.hold = apple_gfx_mmio_reset;
     dc->hotpluggable = false;
     dc->realize = apple_gfx_mmio_realize;
+
+    device_class_set_props(dc, apple_gfx_mmio_properties);
 }
 
 static const TypeInfo apple_gfx_mmio_types[] = {
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index 35a3c7a7ce6..b939bb9b233 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -115,6 +115,12 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
     [s->common.pgdev reset];
 }
 
+static const Property apple_gfx_pci_properties[] = {
+    DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
+                      common.num_display_modes, common.display_modes,
+                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+};
+
 static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -131,7 +137,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
     pci->class_id = PCI_CLASS_DISPLAY_OTHER;
     pci->realize = apple_gfx_pci_realize;
 
-    /* TODO: Property for setting mode list */
+    device_class_set_props(dc, apple_gfx_pci_properties);
 }
 
 static const TypeInfo apple_gfx_pci_types[] = {
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 59299e339d4..aa1455b6295 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -31,9 +31,10 @@
 
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
-static const PGDisplayCoord_t apple_gfx_modes[] = {
-    { .x = 1440, .y = 1080 },
-    { .x = 1280, .y = 1024 },
+static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
+    { 1920, 1080, 60 },
+    { 1440, 1080, 60 },
+    { 1280, 1024, 60 },
 };
 
 static Error *apple_gfx_mig_blocker;
@@ -690,22 +691,23 @@ static void new_frame_handler_bh(void *opaque)
     return disp_desc;
 }
 
-static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
+static NSArray<PGDisplayMode *> *apple_gfx_create_display_mode_array(
+    const AppleGFXDisplayMode display_modes[], uint32_t display_mode_count)
 {
-    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
-    NSArray<PGDisplayMode*>* mode_array;
-    int i;
+    PGDisplayMode *mode_obj;
+    NSMutableArray<PGDisplayMode *> *mode_array =
+        [[NSMutableArray alloc] initWithCapacity:display_mode_count];
 
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
-        modes[i] =
-            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
-    }
+    for (unsigned i = 0; i < display_mode_count; i++) {
+        const AppleGFXDisplayMode *mode = &display_modes[i];
+        trace_apple_gfx_display_mode(i, mode->width_px, mode->height_px);
+        PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px };
 
-    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
-
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
-        [modes[i] release];
-        modes[i] = nil;
+        mode_obj =
+            [[PGDisplayMode alloc] initWithSizeInPixels:mode_size
+                                        refreshRateInHz:mode->refresh_rate_hz];
+        [mode_array addObject:mode_obj];
+        [mode_obj release];
     }
 
     return mode_array;
@@ -741,6 +743,9 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
                               PGDeviceDescriptor *desc, Error **errp)
 {
     PGDisplayDescriptor *disp_desc;
+    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
+    uint32_t num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
+    NSArray<PGDisplayMode *> *mode_array;
 
     if (apple_gfx_mig_blocker == NULL) {
         error_setg(&apple_gfx_mig_blocker,
@@ -776,8 +781,99 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
                                               port:0
                                          serialNum:next_pgdisplay_serial_num++];
     [disp_desc release];
-    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
+
+    if (s->display_modes != NULL && s->num_display_modes > 0) {
+        trace_apple_gfx_common_realize_modes_property(s->num_display_modes);
+        display_modes = s->display_modes;
+        num_display_modes = s->num_display_modes;
+    }
+    s->pgdisp.modeList = mode_array =
+        apple_gfx_create_display_mode_array(display_modes, num_display_modes);
+    [mode_array release];
 
     s->con = graphic_console_init(dev, 0, &apple_gfx_fb_ops, s);
     return true;
 }
+
+/* ------ Display mode list device property ------ */
+
+static void apple_gfx_get_display_mode(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    AppleGFXDisplayMode *mode = object_field_prop_ptr(obj, prop);
+    /* 3 uint16s (max 5 digits) + 2 separator characters + nul. */
+    char buffer[5 * 3 + 2 + 1];
+    char *pos = buffer;
+
+    int rc = snprintf(buffer, sizeof(buffer),
+                      "%"PRIu16"x%"PRIu16"@%"PRIu16,
+                      mode->width_px, mode->height_px,
+                      mode->refresh_rate_hz);
+    assert(rc < sizeof(buffer));
+
+    visit_type_str(v, name, &pos, errp);
+}
+
+static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    AppleGFXDisplayMode *mode = object_field_prop_ptr(obj, prop);
+    const char *endptr;
+    g_autofree char *str = NULL;
+    int ret;
+    int val;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    endptr = str;
+
+    ret = qemu_strtoi(endptr, &endptr, 10, &val);
+    if (ret || val > UINT16_MAX || val <= 0) {
+        error_setg(errp, "width in '%s' must be a decimal integer number"
+                         " of pixels in the range 1..65535", name);
+        return;
+    }
+    mode->width_px = val;
+    if (*endptr != 'x') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
+    if (ret || val > UINT16_MAX || val <= 0) {
+        error_setg(errp, "height in '%s' must be a decimal integer number"
+                         " of pixels in the range 1..65535", name);
+        return;
+    }
+    mode->height_px = val;
+    if (*endptr != '@') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
+    if (ret || val > UINT16_MAX || val <= 0) {
+        error_setg(errp, "refresh rate in '%s'"
+                         " must be a positive decimal integer (Hertz)", name);
+        return;
+    }
+    mode->refresh_rate_hz = val;
+    return;
+
+separator_error:
+    error_setg(errp,
+               "Each display mode takes the format '<width>x<height>@<rate>'");
+}
+
+const PropertyInfo qdev_prop_apple_gfx_display_mode = {
+    .name  = "display_mode",
+    .description =
+        "Display mode in pixels and Hertz, as <width>x<height>@<refresh-rate> "
+        "Example: 3840x2160@60",
+    .get   = apple_gfx_get_display_mode,
+    .set   = apple_gfx_set_display_mode,
+};
diff --git a/hw/display/trace-events b/hw/display/trace-events
index a50e4eea0c0..52786e6e184 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -212,6 +212,8 @@ apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d widt
 apple_gfx_cursor_show(uint32_t show) "show=%d"
 apple_gfx_cursor_move(void) ""
 apple_gfx_common_init(const char *device_name, size_t mmio_size) "device: %s; MMIO size: %zu bytes"
+apple_gfx_common_realize_modes_property(uint32_t num_modes) "using %u modes supplied by 'display-modes' device property"
+apple_gfx_display_mode(uint32_t mode_idx, uint16_t width_px, uint16_t height_px) "mode %2"PRIu32": %4"PRIu16"x%4"PRIu16
 
 # apple-gfx-mmio.m
 apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
-- 
2.47.1


