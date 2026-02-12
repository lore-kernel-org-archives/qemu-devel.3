Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C1AEE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvT-00061O-7B; Thu, 12 Feb 2026 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvR-0005y1-J0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvP-0006Gb-3H
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBrt5ee4/fiILW9JEjenLshWan4+h+vd2E487X6J0ps=;
 b=FbD1yivwWp7n7p1jAmDKjcKRwWjBmSdq1DJfEja2GvU1Nn8qma0cB+z54uq5ylEf3/BHfn
 e9AGrMZhvpKKUoslNtIS40NEWydTZuLUPU1l4Cweln0LNDENomaBFQZGC8lCfpqCoV0kRq
 /Ih+/glolwNFuaSAi/aeFDjXwLx1b14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-2HZLG-fwMYW90vlFMMeXdA-1; Thu, 12 Feb 2026 09:44:09 -0500
X-MC-Unique: 2HZLG-fwMYW90vlFMMeXdA-1
X-Mimecast-MFC-AGG-ID: 2HZLG-fwMYW90vlFMMeXdA_1770907447
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso70117455e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907446; x=1771512246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBrt5ee4/fiILW9JEjenLshWan4+h+vd2E487X6J0ps=;
 b=LrvL3CvLgN5tUXXHB2BG0MfNlBHcSOaWj3fYBVHsY0kXN3jICX3eYlKPLAL+4Jday1
 M15GuS2KK336KEZPo1QpvYDIrEGyKGBW7yj30z2IjP8dp6MsOkZV2xwCgpcSHXlB+n9f
 sJlHG2eBfuJMoc+JOsyVk+J0PrWry0/+g7xTpQxW58UnEo/7TkteTPCWpjCwRD31WB5y
 FwcMGZZJrVxEKS0cw3b2Ll6CVqcFEFpn5U8DeOoLqsAtW5hu56BLZbiBlRH0YhVSsswO
 WkrNL6nysqHENgu0C3q7nBbP9xxXGkRwSoG7G51fv0RbjaBmmUEaFIoqVofBa33VA1Kj
 GdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907446; x=1771512246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mBrt5ee4/fiILW9JEjenLshWan4+h+vd2E487X6J0ps=;
 b=YfQlcItsUAfO0IGg9fBjtpEJ1RMY0ASWSyhlNDzVg6gEFBHDA8evMffsfT9rIZTOCu
 mfDWrqkMBIUENynL6YvMgovle77PmuTfcKiIquq64m87X96JJSXk1f6iA+7EOe2Gs/jI
 DR3HWZi1mceQiIiSEw4Yi97Eis0T3gZwQp29X7nVz33fQm8f+L1UcT7dcZJlbg/Rni6g
 TAUOjPOia1yry3fgB5fcCB0xkdON5hNshK1iw7Qtx/mm59YsDr5azP2k2uZ1TXJl5wYW
 o1oUORSMS95jQPwbTEj6ph2XuxLMwBeF6eZkS0AoArVE87PLA9Y864c6nccLXHDWv1d8
 KYJA==
X-Gm-Message-State: AOJu0YwvKDGiA4O/jcmsWylFEuXAglhXM2b/Lg2+EN2UDfpn2lxQVKtr
 HIQl0zxMm1QWLxUZ6iiZVnUjU0jR9b8+/cW7kl7Yq3bj/60C82X6LfPiBI6zyZcd55DcY6c6Ao3
 t9xigAvpcO6pGbC591udKaab+yVQHtVpkS3k6XeO2t4ppabjJq2CoTDnBAMRUDBCCNn77+6uO4s
 WhgJkMtcPGPmz2V9P4GODjWzkwdulHHCZ3lVmZy/7k
X-Gm-Gg: AZuq6aIlBh00ZzgYirbdnFV5/pBxWMttxgkM0cFEa89/gFYbkmDQ/cid+MbjsRFalzE
 xALA4D3U/M7Na0Kclk3C7FMiiH79FOeN4K83NO/pcB3jqO18WpVqZ98QETBWwhlNOHlxHdrx5ka
 jBMyOi4kPGjHDW4OyxanB0veWGAXRhUSgxWcXfny693T8nZK5m2iFVj/ffuFK3H8Wkt7SiIDryJ
 C6RyXjn/VGDarxUobu9eywmf397Jo8ljim7SCu65gePooL9SUHf0leTnasrY6pEVjB4sFjhdq1W
 ElogmlnQ2gqf6TTFz/4uYiA5+IFnk8E+Uh1Xy9THnl/tAraB+3VmmCmeq/xpymHK5VNqJRtPFN7
 gJmZtHXBauwi1LrW3Df95QSKbplsg5nupIZ5IkB9sOocMFAb0wSsY3eKy81x/N2mxjX25Zpnvd7
 XJzNFmGnjj9rGoqMjnJy/V+L0fY0CtJqdOTnxnx8mKq8sw4GcWS6E=
X-Received: by 2002:a05:600c:19c6:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-48365715e72mr47458615e9.27.1770907445698; 
 Thu, 12 Feb 2026 06:44:05 -0800 (PST)
X-Received: by 2002:a05:600c:19c6:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-48365715e72mr47457955e9.27.1770907445116; 
 Thu, 12 Feb 2026 06:44:05 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc2b0sm11941539f8f.21.2026.02.12.06.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chandan Somani <csomani@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 35/41] qdev: Free property array on release
Date: Thu, 12 Feb 2026 15:42:37 +0100
Message-ID: <20260212144244.22579-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chandan Somani <csomani@redhat.com>

Before this patch, users of the property array would free the
array themselves in their cleanup functions. This causes
inconsistencies where some users leak the array and some free them.

This patch makes it so that the property array's release function
frees the property array (instead of just its elements). It fixes any
leaks and requires less code.

DEFINE_PROP_ARRAY leakers that are fixed in this patch:
ebpf-rss_fds in hw/net/virtio-net.c
rnmi_irqvec, rnmi_excpvec in hw/riscv/riscv_hart.c
common.display_modes in hw/display/apple-gfx-mmio.m
common.display_modes in hw/display/apple-gfx-pci.m

Signed-off-by: Chandan Somani <csomani@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260108230311.584141-2-csomani@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/accounting.c                |  1 -
 hw/core/qdev-properties.c         | 21 ++++++++++-----------
 hw/input/stellaris_gamepad.c      |  8 --------
 hw/intc/arm_gicv3_common.c        |  8 --------
 hw/intc/rx_icu.c                  |  8 --------
 hw/misc/arm_sysctl.c              |  2 --
 hw/misc/mps2-scc.c                |  8 --------
 hw/net/rocker/rocker.c            |  1 -
 hw/nvram/xlnx-efuse.c             |  8 --------
 hw/nvram/xlnx-versal-efuse-ctrl.c |  8 --------
 hw/virtio/virtio-iommu-pci.c      |  8 --------
 11 files changed, 10 insertions(+), 71 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 0933c61f3a2..5cf51f029b1 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -73,7 +73,6 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
             }
             block_acct_add_interval(stats, stats_intervals[i]);
         }
-        g_free(stats_intervals);
     }
     return true;
 }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c96ccfb2635..c2e3f0543fd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -673,10 +673,8 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
 
 /*
  * Object property release callback for array properties: We call the
- * underlying element's property release hook for each element.
- *
- * Note that it is the responsibility of the individual device's deinit
- * to free the array proper.
+ * underlying element's property release hook for each element and free the
+ * property array.
  */
 static void release_prop_array(Object *obj, const char *name, void *opaque)
 {
@@ -686,15 +684,16 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
     char *elem = *arrayptr;
     int i;
 
-    if (!prop->arrayinfo->release) {
-        return;
+    if (prop->arrayinfo->release) {
+        for (i = 0; i < *alenptr; i++) {
+            Property elem_prop = array_elem_prop(obj, prop, name, elem);
+            prop->arrayinfo->release(obj, NULL, &elem_prop);
+            elem += prop->arrayfieldsize;
+        }
     }
 
-    for (i = 0; i < *alenptr; i++) {
-        Property elem_prop = array_elem_prop(obj, prop, name, elem);
-        prop->arrayinfo->release(obj, NULL, &elem_prop);
-        elem += prop->arrayfieldsize;
-    }
+    g_clear_pointer(arrayptr, g_free);
+    *alenptr = 0;
 }
 
 /*
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index f64f5ea9ce3..42d43f9af51 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -63,13 +63,6 @@ static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
     qemu_input_handler_register(dev, &stellaris_gamepad_handler);
 }
 
-static void stellaris_gamepad_finalize(Object *obj)
-{
-    StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
-
-    g_free(s->keycodes);
-}
-
 static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
@@ -98,7 +91,6 @@ static const TypeInfo stellaris_gamepad_info[] = {
         .name = TYPE_STELLARIS_GAMEPAD,
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(StellarisGamepad),
-        .instance_finalize = stellaris_gamepad_finalize,
         .class_init = stellaris_gamepad_class_init,
     },
 };
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0a2e5a3e2fc..e5f3c3c4473 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -488,13 +488,6 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->itslist = g_ptr_array_new();
 }
 
-static void arm_gicv3_finalize(Object *obj)
-{
-    GICv3State *s = ARM_GICV3_COMMON(obj);
-
-    g_free(s->redist_region_count);
-}
-
 static void arm_gicv3_common_reset_hold(Object *obj, ResetType type)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
@@ -644,7 +637,6 @@ static const TypeInfo arm_gicv3_common_type = {
     .instance_size = sizeof(GICv3State),
     .class_size = sizeof(ARMGICv3CommonClass),
     .class_init = arm_gicv3_common_class_init,
-    .instance_finalize = arm_gicv3_finalize,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 87cdc6cbdef..992b069ae24 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -334,13 +334,6 @@ static void rxicu_init(Object *obj)
     sysbus_init_irq(d, &icu->_swi);
 }
 
-static void rxicu_fini(Object *obj)
-{
-    RXICUState *icu = RX_ICU(obj);
-    g_free(icu->map);
-    g_free(icu->init_sense);
-}
-
 static const VMStateDescription vmstate_rxicu = {
     .name = "rx-icu",
     .version_id = 1,
@@ -382,7 +375,6 @@ static const TypeInfo rxicu_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RXICUState),
     .instance_init = rxicu_init,
-    .instance_finalize = rxicu_fini,
     .class_init = rxicu_class_init,
 };
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 2a317ac7f5b..7b320f89c1f 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -618,9 +618,7 @@ static void arm_sysctl_finalize(Object *obj)
 {
     arm_sysctl_state *s = ARM_SYSCTL(obj);
 
-    g_free(s->db_voltage);
     g_free(s->db_clock);
-    g_free(s->db_clock_reset);
 }
 
 static const Property arm_sysctl_properties[] = {
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 350bba3dab8..7877b31479c 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -405,13 +405,6 @@ static void mps2_scc_realize(DeviceState *dev, Error **errp)
     s->oscclk = g_new0(uint32_t, s->num_oscclk);
 }
 
-static void mps2_scc_finalize(Object *obj)
-{
-    MPS2SCC *s = MPS2_SCC(obj);
-
-    g_free(s->oscclk_reset);
-}
-
 static bool cfg7_needed(void *opaque)
 {
     MPS2SCC *s = opaque;
@@ -489,7 +482,6 @@ static const TypeInfo mps2_scc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MPS2SCC),
     .instance_init = mps2_scc_init,
-    .instance_finalize = mps2_scc_finalize,
     .class_init = mps2_scc_class_init,
 };
 
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 3eb7b445113..4a7056bd45e 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1429,7 +1429,6 @@ static void pci_rocker_uninit(PCIDevice *dev)
             world_free(r->worlds[i]);
         }
     }
-    g_free(r->fp_ports_peers);
 }
 
 static void rocker_reset(DeviceState *dev)
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 34436705dde..1a9650ba128 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -225,13 +225,6 @@ static void efuse_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void efuse_finalize(Object *obj)
-{
-    XlnxEFuse *s = XLNX_EFUSE(obj);
-
-    g_free(s->ro_bits);
-}
-
 static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -289,7 +282,6 @@ static const TypeInfo efuse_info = {
     .name          = TYPE_XLNX_EFUSE,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XlnxEFuse),
-    .instance_finalize = efuse_finalize,
     .class_init    = efuse_class_init,
 };
 
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index b7dc0e49e5f..69acdfa3047 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -724,13 +724,6 @@ static void efuse_ctrl_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
-static void efuse_ctrl_finalize(Object *obj)
-{
-    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
-
-    g_free(s->extra_pg0_lock_spec);
-}
-
 static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
     .version_id = 1,
@@ -767,7 +760,6 @@ static const TypeInfo efuse_ctrl_info = {
     .instance_size = sizeof(XlnxVersalEFuseCtrl),
     .class_init    = efuse_ctrl_class_init,
     .instance_init = efuse_ctrl_init,
-    .instance_finalize = efuse_ctrl_finalize,
 };
 
 static void efuse_ctrl_register_types(void)
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index f5f6ce7359d..7b5ffddc1e9 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -94,18 +94,10 @@ static void virtio_iommu_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_IOMMU);
 }
 
-static void virtio_iommu_pci_instance_finalize(Object *obj)
-{
-    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
-
-    g_free(dev->vdev.prop_resv_regions);
-}
-
 static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
     .generic_name  = TYPE_VIRTIO_IOMMU_PCI,
     .instance_size = sizeof(VirtIOIOMMUPCI),
     .instance_init = virtio_iommu_pci_instance_init,
-    .instance_finalize = virtio_iommu_pci_instance_finalize,
     .class_init    = virtio_iommu_pci_class_init,
 };
 
-- 
2.52.0


