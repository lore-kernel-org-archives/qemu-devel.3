Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA7BD14899
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 03:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdgPo-00006K-Mw; Wed, 07 Jan 2026 22:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgO6-0005TK-FV; Wed, 07 Jan 2026 22:08:44 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgO4-0005Ri-Pg; Wed, 07 Jan 2026 22:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767841717; x=1799377717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q2S1HbfA2OWc8pT/OJc71U77jdxwWD7j1qTYdHBk0fg=;
 b=kFFpRCRh4bwBTnMslBhyKmuu7RFa+44ZDA7TDCKFXueXLf4/IM4L2da9
 VvuddEE2YIRv0auQyXW09oUH43YcYBam/IDLHEhTV0NRiwxgQp2i8nH5T
 JzhvfwFFKzt5Cv9GPUpzlm07v/9f5+VoCLagyvUMFZQDGRuWDoF60UHDX
 dNJbktvV0poXPbtIEyx/RCRbERvBK2InGQ2Iuho2B65Ux00249EKrCtWd
 3z0KCMDhgCsB3tIfuHYVJnm0yxQ+WkdeWQ4QSRVX7Yxy4EmpdV40fqG9c
 Xvg2Xf9gm49IY6Ypealj2HBr9Vv0iZig08AFS6ZinorEYYOV9P+Wl0yEr Q==;
X-CSE-ConnectionGUID: Ljx2KXscQPWkNsqLfoR1PQ==
X-CSE-MsgGUID: wMS6wA9iTxyTY7Y+hred5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="91877465"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="91877465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 19:08:35 -0800
X-CSE-ConnectionGUID: Zt7DD7dHSre3gamWpWGPog==
X-CSE-MsgGUID: 7KNtoah0RZ2dbmCmnpAKyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="202211171"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 07 Jan 2026 19:08:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 19/27] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
Date: Thu,  8 Jan 2026 11:30:43 +0800
Message-Id: <20260108033051.777361-20-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108033051.777361-1-zhao1.liu@intel.com>
References: <20260108033051.777361-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtIOMMIOProxy::format_transport_address boolean was only set
in the hw_compat_2_6[] array, via the 'format_transport_address=off'
property. We removed all machines using that array, lets remove
that property, simplifying virtio_mmio_bus_get_dev_path().

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/virtio/virtio-mmio.c         | 15 ---------------
 include/hw/virtio/virtio-mmio.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0b0412b22f23..742ca3d3e4d3 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -764,8 +764,6 @@ static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
 /* virtio-mmio device */
 
 static const Property virtio_mmio_properties[] = {
-    DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
-                     format_transport_address, true),
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
@@ -827,19 +825,6 @@ static char *virtio_mmio_bus_get_dev_path(DeviceState *dev)
     virtio_mmio_proxy = VIRTIO_MMIO(virtio_mmio_bus->parent);
     proxy_path = qdev_get_dev_path(DEVICE(virtio_mmio_proxy));
 
-    /*
-     * If @format_transport_address is false, then we just perform the same as
-     * virtio_bus_get_dev_path(): we delegate the address formatting for the
-     * device on the virtio-mmio bus to the bus that the virtio-mmio proxy
-     * (i.e., the device that implements the virtio-mmio bus) resides on. In
-     * this case the base address of the virtio-mmio transport will be
-     * invisible.
-     */
-    if (!virtio_mmio_proxy->format_transport_address) {
-        return proxy_path;
-    }
-
-    /* Otherwise, we append the base address of the transport. */
     section = memory_region_find(&virtio_mmio_proxy->iomem, 0, 0x200);
     assert(section.mr);
 
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index 1eab3c0decef..1644d0981050 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -66,7 +66,6 @@ struct VirtIOMMIOProxy {
     uint32_t guest_page_shift;
     /* virtio-bus */
     VirtioBusState bus;
-    bool format_transport_address;
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
-- 
2.34.1


