Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B34AC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSKM-0006Nl-NW; Tue, 18 Feb 2025 13:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSKK-0006NQ-EF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSKI-0008QZ-Nm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739903290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7e0yvKdeKjYjXuavY6rL0tjgXFmYPvHLmA5XFR1YAco=;
 b=JIcBNbnePDV1WNIJul+OTEzBewuIGh3/2C7X/z/+BT8UHVHInOgn/U0px+azyF8XhoUxME
 wPx43eMBgubfV0HOKldSGFH5nYb53y8xMJVIXqrSyxzjHMTSk1r+YXOL63IgRyMIcl39Zi
 H9LVrJntDRVhPAHw+MT7It5fMf+86Uk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-Qwd6eTv6MSOaQIV7Xwwcag-1; Tue,
 18 Feb 2025 13:28:06 -0500
X-MC-Unique: Qwd6eTv6MSOaQIV7Xwwcag-1
X-Mimecast-MFC-AGG-ID: Qwd6eTv6MSOaQIV7Xwwcag_1739903283
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C64CA193578F; Tue, 18 Feb 2025 18:28:03 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56E6D1800359; Tue, 18 Feb 2025 18:27:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH v3 3/5] hw/arm/smmuv3: Move reset to exit phase
Date: Tue, 18 Feb 2025 19:25:33 +0100
Message-ID: <20250218182737.76722-4-eric.auger@redhat.com>
In-Reply-To: <20250218182737.76722-1-eric.auger@redhat.com>
References: <20250218182737.76722-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently the iommu may be reset before the devices
it protects. For example this happens with virtio-scsi-pci.
when system_reset is issued from qmp monitor: spurious
"virtio: zero sized buffers are not allowed" warnings can
be observed. This happens because outstanding DMA requests
are still happening while the SMMU gets reset.

This can also happen with VFIO devices. In that case
spurious DMA translation faults can be observed on host.

Make sure the SMMU is reset in the 'exit' phase after
all DMA capable devices have been reset during the 'enter'
or 'hold' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

---

v1 -> v2:
- also migrate smmu_base_reset_hold to smmu_base_reset_exit
  which was an oversight of v1
- add a comment emphasizing the importance of doing the reset
  in 'exit' phase.
---
 hw/arm/smmu-common.c |  9 +++++++--
 hw/arm/smmuv3.c      | 14 ++++++++++----
 hw/arm/trace-events  |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index dd74c2e558..8c1b407b82 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -924,7 +924,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void smmu_base_reset_hold(Object *obj, ResetType type)
+/*
+ * Make sure the IOMMU is reset in 'exit' phase after
+ * all outstanding DMA requests have been quiesced during
+ * the 'enter' or 'hold' reset phases
+ */
+static void smmu_base_reset_exit(Object *obj, ResetType type)
 {
     SMMUState *s = ARM_SMMU(obj);
 
@@ -949,7 +954,7 @@ static void smmu_base_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, smmu_dev_properties);
     device_class_set_parent_realize(dc, smmu_base_realize,
                                     &sbc->parent_realize);
-    rc->phases.hold = smmu_base_reset_hold;
+    rc->phases.exit = smmu_base_reset_exit;
 }
 
 static const TypeInfo smmu_base_info = {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c0cf5df0f6..b49a59b64c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1870,13 +1870,19 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
     }
 }
 
-static void smmu_reset_hold(Object *obj, ResetType type)
+/*
+ * Make sure the IOMMU is reset in 'exit' phase after
+ * all outstanding DMA requests have been quiesced during
+ * the 'enter' or 'hold' reset phases
+ */
+static void smmu_reset_exit(Object *obj, ResetType type)
 {
     SMMUv3State *s = ARM_SMMUV3(obj);
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
 
-    if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj, type);
+    trace_smmu_reset_exit();
+    if (c->parent_phases.exit) {
+        c->parent_phases.exit(obj, type);
     }
 
     smmuv3_init_regs(s);
@@ -1999,7 +2005,7 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
 
     dc->vmsd = &vmstate_smmuv3;
-    resettable_class_set_parent_phases(rc, NULL, smmu_reset_hold, NULL,
+    resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
                                        &c->parent_phases);
     device_class_set_parent_realize(dc, smmu_realize,
                                     &c->parent_realize);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c64ad344bd..7790db780e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -56,6 +56,7 @@ smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
+smmu_reset_exit(void) ""
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.47.1


