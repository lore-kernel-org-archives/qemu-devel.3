Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A1606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfiuIxHO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWx8k-0003UC-Db; Fri, 27 Nov 2026 09:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8Z-0003T8-6G
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8W-0007bo-Ci
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795790473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSMthwgG7Vz1VJ1psD0M5KCX6Sphcc4UXaLqxlEMmbk=;
 b=VfiuIxHOJ3/ZUq6t6xW09pTMYNqcR6ocPflWy+eLhYe1EykUAtFg5QLJ1bMGRjwkRxrZN3
 qJKjt8n70Vf/9pOJtdKmQP/bs/M6z9SrT4cg0d4GS5be4wnYp7y1Owbqv2lpl+qN4ZUmxm
 5NRpXoy5yPesJPa1pxcibZAYmXVvUB0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-ywnCTSrtMQCo6ItYESfMyw-1; Fri,
 27 Nov 2026 14:41:08 +0000
X-MC-Unique: ywnCTSrtMQCo6ItYESfMyw-1
X-Mimecast-MFC-AGG-ID: ywnCTSrtMQCo6ItYESfMyw_1795790467
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5E77180217B; Fri, 27 Nov 2026 14:41:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC3311801A77; Fri, 27 Nov 2026 14:41:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] hw/virtio: Remove hw_compat_4_1[] array and
 "x-pcie-flr-init" from virtio-pci
Date: Fri, 27 Nov 2026 15:40:59 +0100
Message-ID: <20261127144059.278754-3-thuth@redhat.com>
In-Reply-To: <20261127144059.278754-1-thuth@redhat.com>
References: <20261127144059.278754-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no machine left that is using hw_compat_4_1[], so the array
and the "virtio-pci"->"x-pcie-flr-init" setting can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/core/boards.h       |  3 ---
 include/hw/virtio/virtio-pci.h |  4 ----
 hw/core/machine.c              |  5 -----
 hw/virtio/virtio-pci.c         | 13 +++----------
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad98201..a45495db81f 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -893,7 +893,4 @@ extern const size_t hw_compat_5_0_len;
 extern GlobalProperty hw_compat_4_2[];
 extern const size_t hw_compat_4_2_len;
 
-extern GlobalProperty hw_compat_4_1[];
-extern const size_t hw_compat_4_1_len;
-
 #endif
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index f033237035a..b2738ceafac 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -35,7 +35,6 @@ enum {
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
     VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
@@ -64,9 +63,6 @@ enum {
 #define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
   (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
 
-/* Init Function Level Reset capability */
-#define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
-
 /* Advanced Error Reporting capability */
 #define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed9bf8f5008..8342a3bb94c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -235,11 +235,6 @@ GlobalProperty hw_compat_4_2[] = {
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
-GlobalProperty hw_compat_4_1[] = {
-    { "virtio-pci", "x-pcie-flr-init", "off" },
-};
-const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fe2e545c302..9ff8b63d090 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -799,10 +799,7 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
     struct virtio_pci_cfg_cap *cfg;
 
     pci_default_write_config(pci_dev, address, val, len);
-
-    if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
-        pcie_cap_flr_write_config(pci_dev, address, val, len);
-    }
+    pcie_cap_flr_write_config(pci_dev, address, val, len);
 
     if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
         pcie_ats_config_write(pci_dev, address, val, len);
@@ -2309,10 +2306,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
-            /* Set Function Level Reset capability bit */
-            pcie_cap_flr_init(pci_dev);
-        }
+        /* Set Function Level Reset capability bit */
+        pcie_cap_flr_init(pci_dev);
     } else {
         /*
          * make future invocations of pci_is_express() return false
@@ -2418,8 +2413,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
-    DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
 };
-- 
2.56.1


