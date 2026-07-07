Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B0FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0fe-0006y3-Es; Tue, 07 Jul 2026 03:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fc-0006xi-HT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:44 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fa-0002br-2Q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OU9IjyZegdcz9Lf9ne4KqZbR+YkgURDpIqN4zIQcLKo=; b=D
 kdPDLHTrG/5PurB9Un+V+vd7AoLV5muj2P7Fd4F3wnzjx9SWi+3AlaTuN500RyxdrL31OB2CmFLvc
 xVOXcjhigIc3GSF+R2mjKOTStRQXOfzTBgxiHk2zHS73VLOQBXAliDeX8A8F/PpUUsbSPv0J4tsd3
 ZnqSCaq5eua/aN69D5H7HjkL+Q/Afm6DuarsQNqQEiizOUdgyPx6719x1Gq+RkYdnieujXvhrqfQ3
 gnwppJMr3ppTB8o1+IjAPFio5v9rsRDnXwhQ7TjpB2TbqF0cEJajT2MyWdBSVkE9D7D0KLB3fi34b
 poVHh7eKBbJTmRRxyU2oSCinRCKSg3HjQ==;
Received: from p4fe11eec.dip0.t-ipconnect.de ([79.225.30.236] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wh0fY-0000000Cnb2-3CwJ;
 Tue, 07 Jul 2026 09:56:40 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH v2 1/5] virtio-gpu: Support the configurable EDID fields
Date: Tue,  7 Jul 2026 09:47:56 +0200
Message-ID: <20260707075536.126865-1-rclobus@rclobus.nl>
X-Mailer: git-send-email 2.53.0
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

Adds support for the fields that are currently configurable
in the function qemu_edid_generate.

* The serial number does not need to be numerical.
See https://en.wikipedia.org/wiki/Extended_Display_Identification_Data

* The name can be optional, there are now many more fields to set

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---

Note: I've not added the struct with 2 elements for bundle the x and y
versions, I think it is easier to keep the flat structure.

Note: I've kept the xres and yres as 32bit, because a lot of the code
works with uint32_t, even though at the end only 16 bits are used.

 hw/display/edid-generate.c   |  1 +
 hw/display/virtio-gpu-base.c | 49 +++++++++++++++++++++++++++++++--
 qapi/virtio.json             | 52 +++++++++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 2cb819675e..3d9b730c0f 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -392,6 +392,7 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     uint32_t large_screen = 0;
 
     /* =============== set defaults  =============== */
+    /* Note: keep the defaults in sync with qapi/virtio.json */
 
     if (!info->vendor || strlen(info->vendor) != 3) {
         info->vendor = "RHT";
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index cb76302e2d..8389ecc20a 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -69,9 +69,47 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
 
     for (output_idx = 0, node = g->conf.outputs;
          output_idx <= scanout && node; output_idx++, node = node->next) {
-        if (output_idx == scanout && node->value && node->value->name) {
+        if (output_idx != scanout || !node->value) {
+            continue;
+        }
+
+        if (node->value->vendor) {
+            info.vendor = node->value->vendor;
+        }
+        if (node->value->name) {
             info.name = node->value->name;
-            break;
+        }
+        if (node->value->serial) {
+            info.serial = node->value->serial;
+        }
+        if (node->value->has_widthmm) {
+            info.width_mm = node->value->widthmm;
+        }
+        if (node->value->has_heightmm) {
+            info.height_mm = node->value->heightmm;
+        }
+        // Resolution change is special:
+        // The provided resolution will be used only once after it has been set.
+        // After that, the viewer has precedence over these settings
+        // and decides about the resolution.
+        if (node->value->has_xres) {
+            info.prefx = node->value->xres;
+            g->req_state[scanout].width = node->value->xres;
+            node->value->has_xres = 0;
+        }
+        if (node->value->has_yres) {
+            info.prefy = node->value->yres;
+            g->req_state[scanout].height = node->value->yres;
+            node->value->has_yres = 0;
+        }
+        if (node->value->has_xmax) {
+            info.maxx = node->value->xmax;
+        }
+        if (node->value->has_ymax) {
+            info.maxy = node->value->ymax;
+        }
+        if (node->value->has_refreshrate) {
+            info.refresh_rate = node->value->refreshrate;
         }
     }
 
@@ -236,6 +274,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     for (output_idx = 0, node = g->conf.outputs;
          node && output_idx < g->conf.max_outputs;
          output_idx++, node = node->next) {
+        if (node->value->has_widthmm && node->value->has_heightmm) {
+            g->req_state[output_idx].width_mm = node->value->widthmm;
+            g->req_state[output_idx].height_mm = node->value->heightmm;
+        }
         if (node->value->has_xres != node->value->has_yres) {
             error_setg(errp,
                        "must set both outputs[%zd].xres and outputs[%zd].yres",
@@ -247,6 +289,9 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             g->req_state[output_idx].width = node->value->xres;
             g->req_state[output_idx].height = node->value->yres;
         }
+        if (node->value->has_refreshrate) {
+            g->req_state[output_idx].refresh_rate = node->value->refreshrate;
+        }
     }
 
     g->hw_ops = &virtio_gpu_ops;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 09dd0e6d05..791d2f30f1 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,24 +970,62 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.  If both @xres and
-# @yres are set, they take precedence over root virtio-gpu resolution
-# configuration and enable the corresponding output.  If none of @xres
-# and @yres are set, root virtio-gpu resolution configuration takes
-# precedence and only the first output is enabled.  Only setting one
-# of @xres or @yres is an error.
+# Describes configuration of a VirtIO GPU output.  Matches the fields
+# of struct @qemu_edid_info.
+# If values are set, they take precedence over the root virtio-gpu
+# configuration.
+# If none of @xres and @yres are set, the root virtio-gpu resolution
+# configuration is used and only the first output is enabled.
+#
+# @vendor: a 3 letter code for the vendor (since xx.x TODO)
+#          Default: "RHT" (Red Hat, Inc.)
 #
 # @name: the name of the output
+#        Default: "QEMU Monitor"
+#
+# @serial: the serial number (since xx.x TODO)
+#
+# @widthmm: width of the display in mm (since xx.x TODO)
+#           If @widthmm is set, @heightmm must be set too
+#           If both @widthmm and @heightmm are unset,
+#             100 DPI is assumed
+#
+# @heightmm: height of the display in mm (since xx.x TODO)
+#           If @heightmm is set, @widthmm must be set too
 #
 # @xres: horizontal resolution of the output in pixels (since 11.0)
+#        If @xres is set, @yres must be set too
 #
 # @yres: vertical resolution of the output in pixels (since 11.0)
+#        If @yres is set, @xres must be set too
+#
+# @xmax: maximum horizontal resolution of the output in pixels
+#        If @xmax is set, @ymax must be set too
+#        (since xx.x TODO)
+#
+# @ymax: maximum vertical resolution of the output in pixels
+#        If @ymax is set, @xmax must be set too
+#        (since xx.x TODO)
+#
+# @refreshrate: refreshrate in mHz (since xx.x TODO)
+#               Default: 75000
+#
+# .. note:: keep the defaults in sync with hw/display/edid-generate.c
 #
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
+  'data': { '*vendor': 'str',
+            '*name': 'str',
+            '*serial': 'str',
+            '*widthmm': 'uint16',
+            '*heightmm': 'uint16',
+            '*xres': 'uint32',
+            '*yres': 'uint32',
+            '*xmax': 'uint32',
+            '*ymax': 'uint32',
+            '*refreshrate': 'uint32' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.53.0


