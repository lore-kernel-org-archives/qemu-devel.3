Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A05FE6689D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiua-0001kd-Tn; Fri, 19 Dec 2025 17:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuV-0001iS-G8
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:19 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuT-00051C-S6
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so2981889a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183115; x=1766787915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqDoOAlFV55o0N/7MAws8QXpn6Zj682/72I65EubJ2E=;
 b=K2CmBoYZYW0Ulgqcnan0iSKn3zxuxtYv71sthbEqrYplhRmxVpQ6HpHVOdzYkq22jW
 BV3C4sbfRSKCanoW0cqs+0/BE0NEqTPXRYlBoVAYszPXZTwUOhSL1KDnnJIF60KdS+SB
 QBw8uSOFEm/JMXmcnqInAvepImqvXLTPrCWoeSrvlx81WglpLmqQSpiezuefXTB8vRjL
 FefIITbIDj3ubz6Hswmz3YivZHC/Hyt+hCRCXA4wLjL0z61u82SaBmPkv8D+MOTstUWM
 n+gmhGvtO1Ik5PKyazZyDRKVAI0Lr9tJabsqYgPBkefQi9UsL2I3g1br/mvw3zcZqcnz
 93+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183115; x=1766787915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UqDoOAlFV55o0N/7MAws8QXpn6Zj682/72I65EubJ2E=;
 b=VyV9GabwGtTzwCWpcoZYCg760uLfLQwIsTza9Eca2SM5eTS+R34uIIfkg220u8xoJU
 wCbEq1KMBol1aGMNnkfQ+TU1lPDgOUgIdWiR91GaEEywOXXh+YGiir73yMzfNTvCa88K
 6o3XEkdD5hgqrCtPt3f3Iils5/ITD2lySZ/UwECuW3/Ool7TLMP2nUTxVkf+Re9I2Xpe
 tVcWuUdlCYPQqX7v2hzD59srN15EjkU0/flzhgClOh6BlR3XCZepJnfc96e1BfASfT2v
 zQ1ERqH8IJVM5MBzGZMko4Mbci5GQuSwlTKAKylryHMHB/984XmPbpJUYO8pmlEWbBsP
 S8Rw==
X-Gm-Message-State: AOJu0Yxaqs0z2Dt3aJx9Hv1f0SYVLTfRaDFJ+pXsXenjJ+sXXWOnfiFY
 yVO2WV33CoJB64QTzSO8gSuc5bWByWQBGI53VXNEadBbEmZSfobTmtbtkUUBV1Zg
X-Gm-Gg: AY/fxX5fnyTSwk18BNLZ2/yTBx5lSt+YxipfG8vsKRKZslcnhXCXPT+v8mbj/gW3zw8
 8ns+2cJFmqoB/oZCDBmi6Xh+KtZ6FxUNnipxOf3fNFFM6SMWofl48+Tv+3ou22RzbtdtElF3VgY
 VaV2xXH8utUKdI+G6DM+zfVWG+Xr3ZTdrPOaKFZf8xtz5v784SwOIfxwbSS55PcMqSqjimOtWsd
 L4/VbVpewDKBOQEtAsqnnsb39nTOQckiBAQ2ho4yXqbVWTjDRE5DhE9mUvz6pTN03zcagNORVf9
 gxO86RsNV+m/mIYJAdbXS/feUS+11SPQ1Ni7Ul6dJj0bf76GcDRFF1RwDUzCGuXIqX5rKbVVbsl
 5ahqJP+rD1Sm07/YnuaAILI50BmnNH0G169cwiCppg/khNPjRR4ma1JGAiovct72aziIsoAx/pc
 poYdNM8gsB2bwh0USqJw0WnmG60FrBiMogGwyeAKnPSVHpvdQrX0eii9hlgaH3Pg==
X-Google-Smtp-Source: AGHT+IHCSJ68JlIiCkR4N+C2CQsrlR8kL9XgW7EDKXkNwbHbgrlLnNEQ8YzAQeNeQSHeDYNnB0hLHg==
X-Received: by 2002:a05:6402:51cc:b0:64b:a1e6:8018 with SMTP id
 4fb4d7f45d1cf-64ba1e6832dmr2536582a12.31.1766183115262; 
 Fri, 19 Dec 2025 14:25:15 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:13 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Dmytro Terletskyi <dmytro_terletskyi@epam.com>
Subject: [RFC PATCH 4/6] hw/virtio: add SMMUv3 support and stream ID handling
 for virtio-mmio devices
Date: Fri, 19 Dec 2025 23:24:37 +0100
Message-ID: <20251219222439.2497195-5-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Dmytro Terletskyi <dmytro_terletskyi@epam.com>

This commit extends the ARM virt machine to support attaching virtio-mmio
devices to an SMMUv3 controller.

Key changes:
 - Implemented virtio_mmio_get_dma_as() callback, invoked from get_dma_as()
   when a device is behind an SMMUv3.
 - Added stream ID support for virtio-mmio devices registered with the SMMU.

With these changes, virtio-mmio devices can perform DMA through SMMUv3,
enabling proper address translation and isolation in ARM virt platforms.

Signed-off-by: Dmytro Terletskyi <dmytro_terletskyi@epam.com>
---
 hw/virtio/virtio-mmio.c         | 29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-mmio.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index c05c00bcd4..8f19492e3f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -31,6 +31,7 @@
 #include "system/kvm.h"
 #include "system/replay.h"
 #include "hw/virtio/virtio-mmio.h"
+#include "system/address-spaces.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -775,6 +776,7 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
     SysBusDevice *sbd = SYS_BUS_DEVICE(d);
+    static uint32_t stream_id = VIRTIO_MMIO_STREAM_ID_OFFSET;
 
     qbus_init(&proxy->bus, sizeof(proxy->bus), TYPE_VIRTIO_MMIO_BUS, d, NULL);
     sysbus_init_irq(sbd, &proxy->irq);
@@ -784,6 +786,8 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
         proxy->flags &= ~VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD;
     }
 
+    proxy->stream_id = stream_id++;
+
     if (proxy->legacy) {
         memory_region_init_io(&proxy->iomem, OBJECT(d),
                               &virtio_legacy_mem_ops, proxy,
@@ -867,6 +871,27 @@ static void virtio_mmio_vmstate_change(DeviceState *d, bool running)
     }
 }
 
+static AddressSpace *virtio_mmio_get_dma_as(DeviceState *parent)
+{
+    // BusState *iommu_bus = qdev_get_parent_bus(parent);
+    BusState *iommu_bus = sysbus_get_default();
+    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(parent);
+    AddressSpace *as = NULL;
+
+    if (iommu_bus && iommu_bus->iommu_ops) {
+        as = iommu_bus->iommu_ops->get_address_space(
+            iommu_bus, iommu_bus->iommu_opaque, proxy->stream_id);
+    }
+
+    return as ? as : &address_space_memory;
+}
+
+static bool virtio_mmio_iommu_enabled(DeviceState *parent)
+{
+    AddressSpace *as = virtio_mmio_get_dma_as(parent);
+    return as == &address_space_memory;
+}
+
 static void virtio_mmio_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *bus_class = BUS_CLASS(klass);
@@ -884,6 +909,10 @@ static void virtio_mmio_bus_class_init(ObjectClass *klass, const void *data)
     k->pre_plugged = virtio_mmio_pre_plugged;
     k->vmstate_change = virtio_mmio_vmstate_change;
     k->has_variable_vring_alignment = true;
+
+   k->get_dma_as = virtio_mmio_get_dma_as;
+   k->iommu_enabled = virtio_mmio_iommu_enabled;
+
     bus_class->max_dev = 1;
     bus_class->get_dev_path = virtio_mmio_bus_get_dev_path;
 }
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index aa49262022..f0a1a5e3ab 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -53,6 +53,8 @@ typedef struct VirtIOMMIOQueue {
 #define VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD \
         (1 << VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT)
 
+#define VIRTIO_MMIO_STREAM_ID_OFFSET 0x50
+
 struct VirtIOMMIOProxy {
     /* Generic */
     SysBusDevice parent_obj;
@@ -67,6 +69,7 @@ struct VirtIOMMIOProxy {
     /* virtio-bus */
     VirtioBusState bus;
     bool format_transport_address;
+    uint32_t stream_id;
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
-- 
2.43.0


