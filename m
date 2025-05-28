Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8218C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDg7-0004K0-98; Wed, 28 May 2025 06:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfw-00048X-Pc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDft-0007Eh-Me
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrXUMB04D9eKs4sNmt0JGGNI3Be/7bQAJFM2t4rb92M=;
 b=OHtO25PWGAGZEsEbHh5lwnb2afqeBCSn4JyHcdByfQQXem4kRVyo5osDKwWaqsfVQLeSxY
 umoJH79sY35Ao5o8IqlvHo74AdB7d/BsxWVUCOEmNv6jUhqLKzBHpqw640Yp4JxKaEG5F6
 B4zFKMFz1eM4JVdtk4Ew+l7n8nEEs3s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-HF-Ca-cSNRSzEq5zqfyBCw-1; Wed,
 28 May 2025 06:06:02 -0400
X-MC-Unique: HF-Ca-cSNRSzEq5zqfyBCw-1
X-Mimecast-MFC-AGG-ID: HF-Ca-cSNRSzEq5zqfyBCw_1748426760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49606194510F; Wed, 28 May 2025 10:06:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D15BA180049D; Wed, 28 May 2025 10:05:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/27] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
Date: Wed, 28 May 2025 12:04:55 +0200
Message-ID: <20250528100507.313906-16-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VIRTIO_PCI_FLAG_MIGRATE_EXTRA was only used by the
hw_compat_2_4[] array, via the 'migrate-extra=true'
property. We removed all machines using that array,
lets remove all the code around VIRTIO_PCI_FLAG_MIGRATE_EXTRA.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20250512083948.39294-8-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 1dbc3851b01..eb22ed0a1d9 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -32,7 +32,6 @@ DECLARE_OBJ_CHECKERS(VirtioPCIBusState, VirtioPCIBusClass,
 enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
-    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
@@ -57,9 +56,6 @@ enum {
 /* virtio version flags */
 #define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
 
-/* migrate extra state */
-#define VIRTIO_PCI_FLAG_MIGRATE_EXTRA (1 << VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT)
-
 /* have pio notification for modern device ? */
 #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
     (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9b48aa8c3e7..f52fac663c2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -146,9 +146,7 @@ static const VMStateDescription vmstate_virtio_pci = {
 
 static bool virtio_pci_has_extra_state(DeviceState *d)
 {
-    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-
-    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
+    return true;
 }
 
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
@@ -2363,8 +2361,6 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 static const Property virtio_pci_properties[] = {
     DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
-    DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
-- 
2.49.0


