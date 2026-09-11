Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A75C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54JI-0007AT-6W; Fri, 11 Sep 2026 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JG-00077n-8G
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JD-0007FM-NP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKje9pSfHyyRsyz38yvzm39WFiogRTRYIHoL4KWrApI=;
 b=dtNxiA630Wa2HLVU/8HkACXtFcpVZ3GOOGPJVyPesQfAFXgBpcxQw7M0xjNnfUnbF2B6sn
 zh0zXez7Ukw3Tic9ij5+Gt/n/lGA+D+4FluFcfE75kugkPwntRVs0EoPt+yENDTKVBkOds
 fx/cXAo041zN7ixO4fvaoxh0Ctipt3Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-FQJux409PRmoG3-IZIkvAQ-1; Fri,
 11 Sep 2026 12:40:59 -0400
X-MC-Unique: FQJux409PRmoG3-IZIkvAQ-1
X-Mimecast-MFC-AGG-ID: FQJux409PRmoG3-IZIkvAQ_1789144857
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74EEB1954202; Fri, 11 Sep 2026 16:40:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED7821956095; Fri, 11 Sep 2026 16:40:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:30 +0400
Subject: [PATCH v5 56/62] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-56-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Jason Wang <jasowangio@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Eric Auger <eric.auger@redhat.com>, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=18861;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K6fclHUaQnZ9U5C2R6qYlvtUfm41Yo58eQId1qyju58=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC285+rwIKhh5y4qBBTVFkUNHI4zCVNkTpHWl
 rWQ2NGwa+CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvAAKCRDa6OEJdZac
 5XoXD/4gmsMDpwpwEYb65XphyP10u19HXCdk4tKI8jwqW0eEGO+5qHVSm1MerwDbvz8JPMvDeOC
 JejcXiTI22gAqJftMrWFkOF5SvTNZ1VS4T6/SCXdqp/pD6gURTtWpSMNoESQsgIp+kLw9UbU77S
 8/x52OMsDjJC9L67S+d8+m2cGHeCRuLBMtqfYFAJR1sI15qSNlwef202+0pum5btVikeaVyjAL/
 RvFqwBoN4VyFErMeSfwS3IYaB9CEKKHSHJPNJdGLSkn7nrKU8Xtua5fSjB1Y2noLFGxRMN3gWje
 k3LBprRGlae40qyzG+sB35DWNuQkbLPoHJU3gnxOv7P44yoiJ+Sg7TXIOy5nJKdURKZNYYNnmZi
 QgcM4BAbAETSUtEiRITSkN3YWcDUiJS240sfErrKV1giO/Ixu3vhKuoSwB/dMKzxMMl1sTKnbLz
 FkzicC17fvnngncdLpTBSzyGCQvG41s9J5IUN4oOJ3BtOj1nmCEv2PB6Q+cfbdbrCcHPj408LIZ
 shz38BdJ0jDCi8Ob7Qqxdn6KXK3GFYfwr9FN+vU+4GXq/ECUYQLfx6Zx8oTlV81hqcMlkTI5YXZ
 jEp+bHMD4otFHlBGymDLBTlA7tKrM09lKT9J8CXVGPr+3kNdJPDhPqften8+U9rIP6eBCRGlclN
 NupmWpeSSTk1ocQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Change DEFINE_PROP_ARRAY, the macro now uses _arrayprop##_list to
resolve the typed list PropertyInfo (introduced in the previous patch)
instead of the generic qdev_prop_array.

This means the element type and size information is carried by the
PropertyInfo itself rather than duplicated at each callsite. Since
the typed list PropertyInfos encode element_info and element_size,
the .arrayinfo and .arrayfieldsize fields are no longer set by the
macro (they will be removed from the Property struct in the next patch).

Remove qdev_prop_array, which is now unused.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c         |  8 --------
 hw/display/apple-gfx-mmio.m       |  2 +-
 hw/display/apple-gfx-pci.m        |  2 +-
 hw/display/apple-gfx.h            |  1 +
 hw/display/apple-gfx.m            |  4 ++++
 hw/input/stellaris_gamepad.c      |  2 +-
 hw/intc/arm_gicv3_common.c        |  2 +-
 hw/intc/arm_gicv5_common.c        |  4 ++--
 hw/intc/rx_icu.c                  |  4 ++--
 hw/misc/arm_sysctl.c              |  4 ++--
 hw/misc/mps2-scc.c                |  2 +-
 hw/net/rocker/rocker.c            |  2 +-
 hw/net/virtio-net.c               |  2 +-
 hw/nvram/xlnx-efuse.c             |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c |  2 +-
 hw/riscv/riscv_hart.c             |  6 ++----
 hw/virtio/virtio-iommu-pci.c      |  2 +-
 include/hw/block/block.h          |  2 +-
 include/hw/core/qdev-properties.h | 27 ++++++++++-----------------
 tests/unit/test-qdev.c            |  2 +-
 20 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a9ca8e4a03db..b5a9eb97e7dd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -874,14 +874,6 @@ void default_prop_array(ObjectProperty *op, const Property *prop)
     object_property_set_default_list(op);
 }
 
-const PropertyInfo qdev_prop_array = {
-    .type = "list",
-    .get = get_prop_array,
-    .set = set_prop_array,
-    .release = release_prop_array,
-    .set_default_value = default_prop_array,
-};
-
 const PropertyInfo qdev_prop_uint8_list =
     DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t);
 const PropertyInfo qdev_prop_uint16_list =
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f10..dcd04617eb87 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -258,7 +258,7 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
 static const Property apple_gfx_mmio_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_mmio_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index b0694f4cb855..74f79c8b157b 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -118,7 +118,7 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
 static const Property apple_gfx_pci_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853dab..b7eef7b9b14a 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        MemoryRegion **mapping_in_region);
 
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode_list;
 
 #endif
 
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 77c420b30006..592d692d793d 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -16,6 +16,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "qemu/aio-wait.h"
@@ -879,3 +880,6 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
     .get   = apple_gfx_get_display_mode,
     .set   = apple_gfx_set_display_mode,
 };
+
+const PropertyInfo qdev_prop_apple_gfx_display_mode_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode);
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 376d91abad70..20613f649977 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -80,7 +80,7 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 
 static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
-                      keycodes, qdev_prop_uint32, uint32_t),
+                      keycodes, qdev_prop_uint32),
 };
 
 static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f7ba74e6d52a..1298b6b735e9 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -615,7 +615,7 @@ static const Property arm_gicv3_common_properties[] = {
      */
     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
-                      redist_region_count, qdev_prop_uint32, uint32_t),
+                      redist_region_count, qdev_prop_uint32),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b155486af65e..61c8ae493021 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
 
 static const Property arm_gicv5_common_properties[] = {
     DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
-                           cpus, TYPE_ARM_CPU, ARMCPU *),
+                           cpus, TYPE_ARM_CPU),
     DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
-                      cpu_iaffids, qdev_prop_uint32, uint32_t),
+                      cpu_iaffids, qdev_prop_uint32),
     DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
     DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
     DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 992b069ae245..125a6dcb6804 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -356,9 +356,9 @@ static const VMStateDescription vmstate_rxicu = {
 
 static const Property rxicu_properties[] = {
     DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
 };
 
 static void rxicu_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index ebc95b9bb54c..1df85593a5cb 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -626,10 +626,10 @@ static const Property arm_sysctl_properties[] = {
     DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
     /* Daughterboard power supply voltages (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-voltage", arm_sysctl_state, db_num_vsensors,
-                      db_voltage, qdev_prop_uint32, uint32_t),
+                      db_voltage, qdev_prop_uint32),
     /* Daughterboard clock reset values (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
-                      db_clock_reset, qdev_prop_uint32, uint32_t),
+                      db_clock_reset, qdev_prop_uint32),
 };
 
 static void arm_sysctl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 554b504c7203..32f9e166feed 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -464,7 +464,7 @@ static const Property mps2_scc_properties[] = {
      * motherboard configuration controller to suit the FPGA image.
      */
     DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void mps2_scc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 910dce901b67..afbc32e99d94 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1466,7 +1466,7 @@ static const Property rocker_properties[] = {
     DEFINE_PROP_UINT64("switch_id", Rocker,
                        switch_id, 0),
     DEFINE_PROP_ARRAY("ports", Rocker, fp_ports,
-                      fp_ports_peers, qdev_prop_netdev, NICPeers),
+                      fp_ports_peers, qdev_prop_netdev),
 };
 
 static const VMStateDescription rocker_vmsd = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d20..a4e633e54392 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4260,7 +4260,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
     DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
-                      ebpf_rss_fds, qdev_prop_string, char*),
+                      ebpf_rss_fds, qdev_prop_string),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index b1c9ee4980a0..99c16ce76f15 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -266,7 +266,7 @@ static const Property efuse_properties[] = {
     DEFINE_PROP_UINT32("efuse-size", XlnxEFuse, efuse_size, 64 * 32),
     DEFINE_PROP_BOOL("init-factory-tbits", XlnxEFuse, init_tbits, true),
     DEFINE_PROP_ARRAY("read-only", XlnxEFuse, ro_bits_cnt, ro_bits,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void efuse_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index f5d5587cb657..101320b82fd9 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -740,7 +740,7 @@ static const Property efuse_ctrl_props[] = {
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
     DEFINE_PROP_ARRAY("pg0-lock",
                       XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
-                      extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),
+                      extra_pg0_lock_spec, qdev_prop_uint16),
 };
 
 static void efuse_ctrl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 32fd39737ff6..132cf8737001 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -48,11 +48,9 @@ static const Property riscv_harts_props[] = {
      * defined by "rnmi-exception-vector".
      */
     DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
-                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64),
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
-                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64),
     DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 7b5ffddc1e97..1f3a07c5d119 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -38,7 +38,7 @@ static const Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                       vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
-                      qdev_prop_reserved_region, ReservedRegion),
+                      qdev_prop_reserved_region),
 };
 
 static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f26..70bf03a8de73 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -83,7 +83,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 0c067170079d..39f95ce7a3c6 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -76,7 +76,6 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_array;
 extern const PropertyInfo qdev_prop_uint8_list;
 extern const PropertyInfo qdev_prop_uint16_list;
 extern const PropertyInfo qdev_prop_uint32_list;
@@ -148,15 +147,15 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
- * @_arrayprop: PropertyInfo defining what property the array elements have
- * @_arraytype: C type of the array elements
+ * @_arrayfield: field in @_state which will point to the array
+ * @_arrayprop: PropertyInfo for the array elements (e.g. qdev_prop_uint32);
+ *              a corresponding list PropertyInfo named @_arrayprop##_list
+ *              must exist
  *
  * Define device properties for a variable-length array _name.  The array is
  * represented as a list in the visitor interface.
  *
- * @_arraytype is required to be movable with memcpy().
+ * The element type must be movable with memcpy().
  *
  * When the array property is set, the @_field member of the device
  * struct is set to the array length, and @_arrayfield is set to point
@@ -166,12 +165,10 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_arrayfield memory.
  */
 #define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
-                          _arrayfield, _arrayprop, _arraytype)          \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                          _arrayfield, _arrayprop)                      \
+    DEFINE_PROP(_name, _state, _field, _arrayprop##_list, uint32_t,     \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &(_arrayprop),                             \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield))
 
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
@@ -183,10 +180,8 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
+ * @_arrayfield: field in @_state which will point to the array
  * @_linktype: QOM type name of the link type
- * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name of links
  * (i.e. this is the array version of DEFINE_PROP_LINK).
@@ -195,12 +190,10 @@ extern const PropertyInfo qdev_prop_link_list;
  * where each string is the QOM path of the object to be linked.
  */
 #define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
-                               _linktype, _arraytype)                   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                               _linktype)                               \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_link_list, uint32_t,   \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &qdev_prop_link,                           \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield),           \
                 .link_type = _linktype)
 
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 77c3eee71713..8cd004b1efab 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -23,7 +23,7 @@ static const Property my_dev_props[] = {
     DEFINE_PROP_UINT32("u32", MyDev, prop_u32, 100),
     DEFINE_PROP_STRING("string", MyDev, prop_string),
     DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32,
-                     qdev_prop_uint32, uint32_t),
+                     qdev_prop_uint32),
 };
 
 static void my_dev_class_init(ObjectClass *oc, const void *data)

-- 
2.55.0.543.g5ebe2ebe4ea8


