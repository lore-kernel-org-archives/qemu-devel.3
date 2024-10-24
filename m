Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E4D0BB7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3v5A-0000tP-W2; Thu, 24 Oct 2024 06:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3v57-0000pq-Fd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:28:41 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3v51-0008Ad-8X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:28:41 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f7606199so942413e87.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729765713; x=1730370513;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeeiN2yn/TS4rJUlED7bKC2li59eUCEaUtMqhMT8sOo=;
 b=QZfm7Tj8AcwHXggf5Z/mcyGAACm4ZOlUe2YUKQhM77EUf3A3Ox5CPfohWKR7yFRsvA
 CH08lATlQRzZDNoBzMCUcs8R+Ju++6wpoY7nXyOZmIHD3//yABPfoO5/xteMDlUvH30x
 ZlAfWcOvRlCYHJWJNI5zaDDpM8YjrJQws39jyM13S/3fthAUCXpVnGifMqKDvd9K1QBL
 d1BBMeSpOW1olkuNHKbJdwT6kux0/EEeUSF5yoh82kewOa7DUQYwONhNDc1v/ucXQX+m
 acRlzT4OuCZXrgk9B/1sBrH2JoCkbsyLN1mAltObKPEU8Lgc4PNbJr5XDU6k/U/PX0vw
 Beaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729765713; x=1730370513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeeiN2yn/TS4rJUlED7bKC2li59eUCEaUtMqhMT8sOo=;
 b=SxjvqJ7VrazK/Ntaoeo9SXKs5S4nU4Szg+865stPkBqCJtAEq1wQg8boZNtJGdl89N
 QuBZMOxBNayXbH2ACdIFxXEyx2YsTp08NvB39ccaTOFZCVSgiFmid2h7E63CCQ8Wkavk
 jQPr2UPqS73OqBTBN98NpMJbGED8fkkZDarcGink4UKdEJ9eSfDPSyf/X2QBJmFQjGN5
 8sE+W1Z1kH4K3+xx1AKKWyyAwu1sfvbOPZoClcC+6SiSoI1E7DFXA4DqN2UEgVisrINY
 wdsmpkXipP3izPE2+XnbF8IjtufJZonqQt43DS44+feT8AI7O0tA52ldlGt85R+bnU3h
 pAFg==
X-Gm-Message-State: AOJu0YyEVS3F4XcW/3yiPCtJYVoDTtHywVhA5msUXSOSUx/+h1hrmO9i
 Etaxgqy0rDCfcYz9S7iko/zkPaRQQ1Z/TNfu1pVQxbbVO4XE0fXPin/Ny6+ImZ2aQka9tJEvMFc
 inA==
X-Google-Smtp-Source: AGHT+IFxh4yci0JDwmIDjNzFulP0W6W66ohWPCHFfjtnBs6L+lHNzJAKEi1Cxydt0p1hQZe54xqXWA==
X-Received: by 2002:a05:6512:398a:b0:539:f2f6:c70f with SMTP id
 2adb3069b0e04-53b1a2fed80mr2917958e87.8.1729765712713; 
 Thu, 24 Oct 2024 03:28:32 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a913706d3sm601019066b.134.2024.10.24.03.28.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 03:28:32 -0700 (PDT)
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
Subject: [PATCH v4 04/15] hw/display/apple-gfx: Adds configurable mode list
Date: Thu, 24 Oct 2024 12:28:02 +0200
Message-Id: <20241024102813.9855-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024102813.9855-1-phil@philjordan.eu>
References: <20241024102813.9855-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::131;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x131.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The property is an array of a custom type to make the syntax slightly
less awkward to use, for example:

-device '{"driver":"apple-gfx-pci", "display-modes":["1920x1080@60", "3840x2160@60"]}'

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

v4:

 * Switched to the native array property type, which recently gained
	 command line support.
 * The property has also been added to the -mmio variant.
 * Tidied up the code a little.

 hw/display/apple-gfx-mmio.m |   8 +++
 hw/display/apple-gfx-pci.m  |   9 ++-
 hw/display/apple-gfx.h      |  12 ++++
 hw/display/apple-gfx.m      | 127 ++++++++++++++++++++++++++++++++----
 hw/display/trace-events     |   2 +
 5 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 06131bc23f1..5d427c7005e 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -261,6 +261,12 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
     [s->common.pgdev reset];
 }
 
+static Property apple_gfx_mmio_properties[] = {
+    DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
+                      common.num_display_modes, common.display_modes,
+                      qdev_prop_display_mode, AppleGFXDisplayMode),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
 {
@@ -270,6 +276,8 @@ static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
     rc->phases.hold = apple_gfx_mmio_reset;
     dc->hotpluggable = false;
     dc->realize = apple_gfx_mmio_realize;
+
+    device_class_set_props(dc, apple_gfx_mmio_properties);
 }
 
 static TypeInfo apple_gfx_mmio_types[] = {
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index 4ee26dde422..32e81bbef8b 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -115,6 +115,13 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
     [s->common.pgdev reset];
 }
 
+static Property apple_gfx_pci_properties[] = {
+    DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
+                      common.num_display_modes, common.display_modes,
+                      qdev_prop_display_mode, AppleGFXDisplayMode),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -132,7 +139,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
     pci->class_id = PCI_CLASS_DISPLAY_OTHER;
     pci->realize = apple_gfx_pci_realize;
 
-    // TODO: Property for setting mode list
+    device_class_set_props(dc, apple_gfx_pci_properties);
 }
 
 static TypeInfo apple_gfx_pci_types[] = {
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 39931fba65a..d2c6a14229a 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -9,6 +9,7 @@
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 #include "qemu/typedefs.h"
 #include "exec/memory.h"
+#include "hw/qdev-properties.h"
 #include "ui/surface.h"
 
 @class PGDeviceDescriptor;
@@ -20,6 +21,7 @@
 
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
+struct AppleGFXDisplayMode;
 struct AppleGFXMapMemoryJob;
 typedef struct AppleGFXState {
     MemoryRegion iomem_gfx;
@@ -31,6 +33,8 @@ typedef struct AppleGFXState {
     id<MTLCommandQueue> mtl_queue;
     bool cursor_show;
     QEMUCursor *cursor;
+    struct AppleGFXDisplayMode *display_modes;
+    uint32_t num_display_modes;
 
     /* For running PVG memory-mapping requests in the AIO context */
     QemuCond job_cond;
@@ -47,6 +51,12 @@ typedef struct AppleGFXState {
     id<MTLTexture> texture;
 } AppleGFXState;
 
+typedef struct AppleGFXDisplayMode {
+    uint16_t width_px;
+    uint16_t height_px;
+    uint16_t refresh_rate_hz;
+} AppleGFXDisplayMode;
+
 void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
 void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
                               Error **errp);
@@ -54,5 +64,7 @@ uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
                                                uint64_t length, bool read_only);
 void apple_gfx_await_bh_job(AppleGFXState *s, bool *job_done_flag);
 
+extern const PropertyInfo qdev_prop_display_mode;
+
 #endif
 
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 46be9957f69..42b601329fb 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -28,9 +28,10 @@
 #include "qapi/error.h"
 #include "ui/console.h"
 
-static const PGDisplayCoord_t apple_gfx_modes[] = {
-    { .x = 1440, .y = 1080 },
-    { .x = 1280, .y = 1024 },
+static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
+    { 1920, 1080, 60 },
+    { 1440, 1080, 60 },
+    { 1280, 1024, 60 },
 };
 
 /* This implements a type defined in <ParavirtualizedGraphics/PGDevice.h>
@@ -303,7 +304,6 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 static void create_fb(AppleGFXState *s)
 {
     s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
-    set_mode(s, 1440, 1080);
 
     s->cursor_show = true;
 }
@@ -628,20 +628,25 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
     return disp_desc;
 }
 
-static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
+static NSArray<PGDisplayMode*>* apple_gfx_create_display_mode_array(
+    const AppleGFXDisplayMode display_modes[], uint32_t display_mode_count)
 {
-    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
+    PGDisplayMode **modes = alloca(sizeof(modes[0]) * display_mode_count);
     NSArray<PGDisplayMode*>* mode_array = nil;
-    int i;
+    uint32_t i;
 
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
+    for (i = 0; i < display_mode_count; i++) {
+        const AppleGFXDisplayMode *mode = &display_modes[i];
+        trace_apple_gfx_display_mode(i, mode->width_px, mode->height_px);
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
@@ -679,6 +684,8 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
                               Error **errp)
 {
     PGDisplayDescriptor *disp_desc = nil;
+    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
+    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
 
     if (apple_gfx_mig_blocker == NULL) {
         error_setg(&apple_gfx_mig_blocker,
@@ -704,10 +711,106 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
     s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
                                               port:0 serialNum:1234];
     [disp_desc release];
-    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
+
+    if (s->display_modes != NULL && s->num_display_modes > 0) {
+        trace_apple_gfx_common_realize_modes_property(s->num_display_modes);
+        display_modes = s->display_modes;
+        num_display_modes = s->num_display_modes;
+    }
+    s->pgdisp.modeList =
+        apple_gfx_create_display_mode_array(display_modes, num_display_modes);
 
     create_fb(s);
 
     qemu_mutex_init(&s->job_mutex);
     qemu_cond_init(&s->job_cond);
 }
+
+static void apple_gfx_get_display_mode(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    AppleGFXDisplayMode *mode = object_field_prop_ptr(obj, prop);
+    /* 3 uint16s (max 5 digits) and 2 separator characters + nul. */
+    static const size_t buffer_size = 5 * 3 + 2 + 1;
+
+    char buffer[buffer_size];
+    char *pos = buffer;
+
+    int rc = snprintf(buffer, buffer_size,
+                      "%"PRIu16"x%"PRIu16"@%"PRIu16,
+                      mode->width_px, mode->height_px,
+                      mode->refresh_rate_hz);
+    assert(rc < buffer_size);
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
+    Error *local_err = NULL;
+    const char *endptr;
+    char *str;
+    int ret;
+    unsigned int val;
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    endptr = str;
+
+    ret = qemu_strtoui(endptr, &endptr, 10, &val);
+    if (ret || val > UINT16_MAX || val == 0) {
+        error_setg(errp, "width in '%s' must be a decimal integer number "
+                   "of pixels in the range 1..65535", name);
+        goto out;
+    }
+    mode->width_px = val;
+    if (*endptr != 'x') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
+    if (ret || val > UINT16_MAX || val == 0) {
+        error_setg(errp, "height in '%s' must be a decimal integer number "
+                   "of pixels in the range 1..65535", name);
+        goto out;
+    }
+    mode->height_px = val;
+    if (*endptr != '@') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
+    if (ret) {
+        error_setg(errp, "refresh rate in '%s'"
+                   " must be a non-negative decimal integer (Hertz)", name);
+    }
+    mode->refresh_rate_hz = val;
+
+    goto out;
+
+separator_error:
+    error_setg(errp, "Each display mode takes the format "
+               "'<width>x<height>@<rate>'");
+out:
+    g_free(str);
+    return;
+}
+
+const PropertyInfo qdev_prop_display_mode = {
+    .name  = "display_mode",
+    .description =
+        "Display mode in pixels and Hertz, as <width>x<height>@<refresh-rate> "
+        "Example: 3840x2160@60",
+    .get   = apple_gfx_get_display_mode,
+    .set   = apple_gfx_set_display_mode,
+};
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 214998312b9..2780239dbde 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -209,6 +209,8 @@ apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d widt
 apple_gfx_cursor_show(uint32_t show) "show=%d"
 apple_gfx_cursor_move(void) ""
 apple_gfx_common_init(const char *device_name, size_t mmio_size) "device: %s; MMIO size: %zu bytes"
+apple_gfx_common_realize_modes_property(uint32_t num_modes) "using %u modes supplied by 'display-modes' device property"
+apple_gfx_display_mode(uint32_t mode_idx, uint16_t width_px, uint16_t height_px) "mode %2"PRIu32": %4"PRIu16"x%4"PRIu16
 
 # apple-gfx-mmio.m
 apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
-- 
2.39.3 (Apple Git-145)


