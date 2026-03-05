Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E4BF30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6K7-0001PX-Qb; Thu, 05 Mar 2026 05:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6K6-0001OQ-BK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6K4-0005VG-US
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQ064cg7THdk5RbHXrVzn9h8msOLpA5PYOghjJpJfrc=;
 b=WHNHcSxnZghWo4287BEuBvJLz9e6GiJ3v3ml1DxQJgW87/gTG3TPPqTUsIAdSCtxgHnupS
 0yrosk6vsoD9uza4C/QLFEZVBQHu/09nzVpcAYlsjV1b/mubiU0TmPh+rsR0ARKhoL6ppW
 Aby9qhQWP/m7pyB5RQ7rpGC1OrAXHqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-_pKR90p-NJ6B0Zzy47k1uA-1; Thu,
 05 Mar 2026 05:52:49 -0500
X-MC-Unique: _pKR90p-NJ6B0Zzy47k1uA-1
X-Mimecast-MFC-AGG-ID: _pKR90p-NJ6B0Zzy47k1uA_1772707968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45CA418002C7; Thu,  5 Mar 2026 10:52:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0F923003E98; Thu,  5 Mar 2026 10:52:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 09/28] hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_PM
 definition
Date: Thu,  5 Mar 2026 11:51:56 +0100
Message-ID: <20260305105215.302571-10-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VIRTIO_PCI_FLAG_INIT_PM was only used by the hw_compat_2_8[]
array, via the 'x-pcie-pm-init=off' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_INIT_PM (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-11-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-10-thuth@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  4 ----
 hw/virtio/virtio-pci.c         | 19 +++++--------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9760a3837fa..5cb20b73f62 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -35,7 +35,6 @@ enum {
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
@@ -61,9 +60,6 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
-/* Init Power Management */
-#define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
-
 /* Init The No_Soft_Reset bit of Power Management */
 #define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
   (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9e2201be13c..0f5654f459e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2318,11 +2318,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                          PCI_PM_CTRL_NO_SOFT_RESET);
         }
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
-            /* Init Power Management Control Register */
-            pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
-                         PCI_PM_CTRL_STATE_MASK);
-        }
+        /* Init Power Management Control Register */
+        pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
+                     PCI_PM_CTRL_STATE_MASK);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
             pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
@@ -2418,16 +2416,11 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
-        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
-
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
-            pci_word_test_and_clear_mask(
-                dev->config + dev->pm_cap + PCI_PM_CTRL,
-                PCI_PM_CTRL_STATE_MASK);
-        }
+        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
+                                     PCI_PM_CTRL_STATE_MASK);
     }
 }
 
@@ -2442,8 +2435,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
-    DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
-- 
2.53.0


