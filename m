Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE00BCD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE8Q-00013F-Fj; Mon, 15 Jun 2026 16:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8O-0000vL-A4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8L-0003GY-Mu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNn2CddowpIBpSIl95l69NtEfVsCFeRbsjqaync4Su4=;
 b=Jmw/k/7LKyAL3x84CLX0qKLIeiqlejI6kCp3iuM5TjcftV2MVyX7cHPFPm7jk+jzJjKxXg
 K8tv7CH9H66U+ZWdwx2+Gy0/Z50ix1ELD5KzTk5NpSTOLRtwa2g40luQHvzEzW3SsWPNWM
 rHg2sj5koCAW6e/00nRV9edVFQ4cjyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-JKSXxvftMrm17CowXNDMUA-1; Mon,
 15 Jun 2026 16:42:08 -0400
X-MC-Unique: JKSXxvftMrm17CowXNDMUA-1
X-Mimecast-MFC-AGG-ID: JKSXxvftMrm17CowXNDMUA_1781556127
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3E9F1955E7E; Mon, 15 Jun 2026 20:42:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED5B5180058F; Mon, 15 Jun 2026 20:42:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:16 +0400
Subject: [PATCH v2 50/53] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-50-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18734;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EKnaOHXDsjZXdHPfw/0i0/BqqrMNUi3fu5/FWY1Ft4Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQzC9QNQWlc/XcfVTTjArW2o3bgFUltWZE3
 V3EZKl8OyqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5WJvD/43V5J+HvGiyc5kjFuYX9Uf/TtVNkT0+KwcvJb7BNX5u855WDZIajKPvBLfkwuBOpo8JWX
 slfnIXsJ3WbC3UHU2k4p0ngVhWpKtmch4O9Gh0vnWcA1F+rdb0Hd68AGlSTsOO8QzJxcMcJ2G5f
 UKBkB7jrySL5Vv0Dk8yNCGkXBE1bfHt/LLhkHTasaqZd23JRH2MvC7G2sAqHXFf/Pz5xUUidwT7
 AexQXvWH8QMaIlzoz2x3CvHZ+Oyh8ndVQVkAb3VYMoVerr7+Un/wC9jWLmQJkvFyAqY60O6u3e5
 l+KSm8TAwouU6tAyIuLphPfZRl4v3+TOe3y17uc9BcuTPV+Kh756gpD8zHmqnb6GhgXKxI79kZ9
 hzYyXcGCW1Dalg+fCD7cigAB7nmnbYhDtgrCmIAA8roiyJCXZHZausqcGzms/pYZudH/SItwhvl
 bWN+Ut+YNpKrxpP7DVLBDLe/jghoUOOMFmKoQJapQsSLJvidQtHhJMAh5a6CErKYs8HmAYZd0s5
 E8Jpv6TuiFPQXa5niWRqrt48xKU0CCeAGEnmNbERIyFCXXUo60eZZhDUDrUKu+8wJvH3Vl2/9s8
 AHpfO4/EZBSpTIzKJhsXf0gXChOLbtNbRd1bZ3tC1S09jexbL1s3TvTGExUXM3loXzKrP1RHWT9
 xc002c8RpzBsjYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/display/apple-gfx.h            |  1 +
 include/hw/block/block.h          |  2 +-
 include/hw/core/qdev-properties.h | 27 ++++++++++-----------------
 hw/core/qdev-properties.c         |  8 --------
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
 tests/unit/test-qdev.c            |  2 +-
 hw/display/apple-gfx-mmio.m       |  2 +-
 hw/display/apple-gfx-pci.m        |  2 +-
 hw/display/apple-gfx.m            |  4 ++++
 20 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853da..b7eef7b9b14 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        MemoryRegion **mapping_in_region);
 
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode_list;
 
 #endif
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f2..70bf03a8de7 100644
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
index 0c067170079..39f95ce7a3c 100644
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
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a9ca8e4a03d..b5a9eb97e7d 100644
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
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 25769fc2616..4baa3956a9c 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -71,7 +71,7 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 
 static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
-                      keycodes, qdev_prop_uint32, uint32_t),
+                      keycodes, qdev_prop_uint32),
 };
 
 static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f7ba74e6d52..1298b6b735e 100644
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
index b155486af65..61c8ae49302 100644
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
index 992b069ae24..125a6dcb680 100644
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
index ebc95b9bb54..1df85593a5c 100644
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
index 7877b31479c..5c77239d2cf 100644
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
index 910dce901b6..afbc32e99d9 100644
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
index 2a5d642a647..092a262269a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4234,7 +4234,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
     DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
-                      ebpf_rss_fds, qdev_prop_string, char*),
+                      ebpf_rss_fds, qdev_prop_string),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 50a7f2baba1..6514ee84caf 100644
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
index f5d5587cb65..101320b82fd 100644
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
index e675358e1a1..69d605c71e6 100644
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
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 7b5ffddc1e9..1f3a07c5d11 100644
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
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f..1199b761a32 100644
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
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f1..dcd04617eb8 100644
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
index b0694f4cb85..74f79c8b157 100644
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
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 77c420b3000..592d692d793 100644
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

-- 
2.54.0


