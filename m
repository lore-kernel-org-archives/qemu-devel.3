Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B1CC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0fn-0006zT-V0; Tue, 07 Jul 2026 03:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fm-0006z8-5r
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:54 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fk-0002cV-HU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PAN695irVKyZwf+UJtY/OrYgvdfDRmLYuhe9avW/f/M=; b=jJ0aSBImblGQx99Km3Id6FHtXr
 vKnB5hKABUKv3R4DOu7CbqLe/H/gpe53p53Hdr93WCtxurEoFxmJ1sXp0MiRu29uDV5tICUjVrs8j
 hqAD4P9++e49h8aST06/4MhqYG6AKQezLWFNyoN01Re+A+Lkxe82YrZyMq5OUpCWzxwz44SqgLMhA
 wUOg3EokqzhWN2MItCIRvOKAmFITzKvnn/XDbXQ9U1la963YQ+JbmVlX53cqQkEYPsraVnzZbN/U6
 6SPcqAQwqh565FVB86XpXUViIToEBAVNT1Jhuw/11KpTRvvq6u2k6SeYozIfhP1b0Btx2+gMjcRBx
 /m5VtlmQ==;
Received: from p4fe11eec.dip0.t-ipconnect.de ([79.225.30.236] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wh0fg-0000000Cnb2-1a3H;
 Tue, 07 Jul 2026 09:56:48 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH v2 2/5] hw/core: validate VirtIOGPUOutputList properties
Date: Tue,  7 Jul 2026 09:47:57 +0200
Message-ID: <20260707075536.126865-2-rclobus@rclobus.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707075536.126865-1-rclobus@rclobus.nl>
References: <20260707075536.126865-1-rclobus@rclobus.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: rclobus@rclobus.nl
Received-SPF: pass client-ip=2a09:8b00:300:8::10;
 envelope-from=rclobus@rclobus.nl; helo=web05.whitelabeldomein.nl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Validates the values for VirtIOGPUOutputList:
* string length and content
* when a pair of values need to be provided

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---
 hw/core/qdev-properties-system.c | 63 ++++++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c     | 23 ++----------
 2 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a805ee2e1f..04e5acac08 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -33,6 +33,7 @@
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "net/net.h"
+#include "hw/display/edid.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
 #include "hw/i386/x86.h"
@@ -1348,6 +1349,68 @@ static void set_virtio_gpu_output_list(Object *obj, Visitor *v,
         return;
     }
 
+    if (*prop_ptr) {
+        size_t length_current = QAPI_LIST_LENGTH(*prop_ptr);
+        size_t length_new = QAPI_LIST_LENGTH(list);
+        if (length_current != length_new) {
+            error_setg(errp, "new list contains different number of outputs: %zd, old: %zd", length_new, length_current);
+            return;
+        }
+    }
+
+    size_t output_idx;
+    VirtIOGPUOutputList *node;
+    for (output_idx = 0, node = list;
+         node; output_idx++, node = node->next) {
+        if (!node->value) {
+            continue;
+        }
+        if (node->value->vendor) {
+            if (strlen(node->value->vendor) != 3) {
+                error_setg(errp, "invalid vendor length '%s' in outputs[%zd].vendor",
+                           node->value->vendor, output_idx);
+                return;
+            }
+            for (size_t i = 0; i < 3; ++i) {
+                if (node->value->vendor[i] < 'A' || node->value->vendor[i] > 'Z') {
+                    error_setg(errp, "invalid character '%c' in outputs[%zd].vendor '%s'",
+                               node->value->vendor[i], output_idx, node->value->vendor);
+                    return;
+                }
+            }
+        }
+        if (node->value->name &&
+            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
+            error_setg(errp, "invalid output name '%s' > %d in outputs[%zd].name",
+                       node->value->name, EDID_NAME_MAX_LENGTH, output_idx);
+            return;
+        }
+        if (node->value->serial &&
+            strlen(node->value->serial) > EDID_NAME_MAX_LENGTH) {
+            error_setg(errp, "too long serial number '%s' > %d in outputs[%zd].serial",
+                       node->value->serial, EDID_NAME_MAX_LENGTH, output_idx);
+            return;
+        }
+        if (node->value->has_widthmm != node->value->has_heightmm) {
+            error_setg(errp,
+                       "must set both outputs[%zd].widthmm and outputs[%zd].heightmm",
+                       output_idx, output_idx);
+            return;
+        }
+        if (node->value->has_xres != node->value->has_yres) {
+            error_setg(errp,
+                       "must set both outputs[%zd].xres and outputs[%zd].yres",
+                       output_idx, output_idx);
+            return;
+        }
+        if (node->value->has_xmax != node->value->has_ymax) {
+            error_setg(errp,
+                       "must set both outputs[%zd].xmax and outputs[%zd].ymax",
+                       output_idx, output_idx);
+            return;
+        }
+    }
+
     qapi_free_VirtIOGPUOutputList(*prop_ptr);
     *prop_ptr = list;
 }
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 8389ecc20a..41f69a6ca7 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -225,25 +225,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     VirtIOGPUOutputList *node;
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
+    size_t outputlist_length = QAPI_LIST_LENGTH(g->conf.outputs);
     int i;
 
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
         error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCANOUTS);
         return false;
     }
-
-    for (output_idx = 0, node = g->conf.outputs;
-         node; output_idx++, node = node->next) {
-        if (output_idx == g->conf.max_outputs) {
-            error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
-            return false;
-        }
-        if (node->value && node->value->name &&
-            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
-            error_setg(errp, "invalid output name '%s' > %d",
-                       node->value->name, EDID_NAME_MAX_LENGTH);
-            return false;
-        }
+    if (outputlist_length != 0 && outputlist_length != g->conf.max_outputs) {
+        error_setg(errp, "invalid number of outputs are defined, expected: %d, given: %zd", g->conf.max_outputs, outputlist_length);
+        return false;
     }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
@@ -278,12 +269,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             g->req_state[output_idx].width_mm = node->value->widthmm;
             g->req_state[output_idx].height_mm = node->value->heightmm;
         }
-        if (node->value->has_xres != node->value->has_yres) {
-            error_setg(errp,
-                       "must set both outputs[%zd].xres and outputs[%zd].yres",
-                       output_idx, output_idx);
-            return false;
-        }
         if (node->value->has_xres && node->value->has_yres) {
             g->enabled_output_bitmask |= (1 << output_idx);
             g->req_state[output_idx].width = node->value->xres;
-- 
2.53.0


