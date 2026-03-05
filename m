Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B09F30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6K4-0001L0-28; Thu, 05 Mar 2026 05:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6K2-0001Jr-1t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6K0-0005Us-Ka
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hsiZRjp9wtNcFrHnonN7EpDfMxmnEWA1JVXjPxVHm0=;
 b=Z5+QcGugCpACMBbsCmAchC6m2eRusdUZuMRoiST6y2JbvFvDU7Xi5j3Z+omgzT6q4go2fM
 KpmCjBNVC2AZm7wo9oWI7dPK6LyhuZgQmHNBAHjNH5l8LF+S7RH5ZTOfWdH5ePoryn2pDJ
 qF7Gf8jaUcOwqx5lJk4cKHdlGt35zTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-6RoG7hpEPm6zgfRzxYY8lQ-1; Thu,
 05 Mar 2026 05:52:42 -0500
X-MC-Unique: 6RoG7hpEPm6zgfRzxYY8lQ-1
X-Mimecast-MFC-AGG-ID: 6RoG7hpEPm6zgfRzxYY8lQ_1772707961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B981956048; Thu,  5 Mar 2026 10:52:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 422D13003E9C; Thu,  5 Mar 2026 10:52:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 07/28] hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_DEVERR
 definition
Date: Thu,  5 Mar 2026 11:51:54 +0100
Message-ID: <20260305105215.302571-8-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VIRTIO_PCI_FLAG_INIT_DEVERR was only used by the hw_compat_2_8[]
array, via the 'x-pcie-deverr-init=off' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_INIT_DEVERR (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-9-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-8-thuth@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 581bb830b79..405e33a3165 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -35,7 +35,6 @@ enum {
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
@@ -63,9 +62,6 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
-/* Init error enabling flags */
-#define VIRTIO_PCI_FLAG_INIT_DEVERR (1 << VIRTIO_PCI_FLAG_INIT_DEVERR_BIT)
-
 /* Init Link Control register */
 #define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT)
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c7b5a79b936..91d736d71c1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2307,10 +2307,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
-            /* Init error enabling flags */
-            pcie_cap_deverr_init(pci_dev);
-        }
+        /* Init error enabling flags */
+        pcie_cap_deverr_init(pci_dev);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
             /* Init Link Control Register */
@@ -2446,8 +2444,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
-    DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
     DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
-- 
2.53.0


