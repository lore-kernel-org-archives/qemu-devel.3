Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C2BC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN30-0005ZY-UG; Wed, 11 Jun 2025 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2r-0005Wq-Vo
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2q-0007Af-8b
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOK6h25bc1ZM6IXxN8YLXSfPeGR1jIW7GAUe4FyrHkw=;
 b=YNnpIRpOknAQebqfatC73eZIcUnWR6rUtegVnuKLOlGjDe26rhofZOaxW7tdgL89T5hw95
 yoKmse/uVMA9pffAmcyIpTXWSvQTsbDkD+Ti1Ix/fYVvmwM2SrhX0HCdbDOo+F9YSWmUV3
 H3jV0AhqlP4pPzmyA8EiN0wWaZljJqU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-1Q0qf0_6NcSrwuZqUxnctg-1; Wed,
 11 Jun 2025 11:07:14 -0400
X-MC-Unique: 1Q0qf0_6NcSrwuZqUxnctg-1
X-Mimecast-MFC-AGG-ID: 1Q0qf0_6NcSrwuZqUxnctg_1749654432
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03EB1195608E; Wed, 11 Jun 2025 15:07:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FFEB180045B; Wed, 11 Jun 2025 15:07:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/27] pci: skip reset during cpr
Date: Wed, 11 Jun 2025 17:06:11 +0200
Message-ID: <20250611150620.701903-20-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Do not reset a vfio-pci device during CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749576403-25355-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pci.h | 2 ++
 hw/pci/pci.c         | 5 +++++
 hw/vfio/pci.c        | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 35d59d7672e2b9ca43ae2f9708e94a07c04f9784..df3cc7b8750014454bd5ab4c3e9a3feca122eca3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -222,6 +222,8 @@ enum {
     QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
 #define QEMU_PCI_CAP_PM_BITNR 14
     QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
+#define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
+    QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
 };
 
 typedef struct PCIINTxRoute {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9b4bf48439ed225e6b443f067928a84950f12a88..c70b5ceebaf1f2b10768bd030526cbb518da2b8d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/cpr.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -537,6 +538,10 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    if ((dev->cap_present & QEMU_PCI_SKIP_RESET_ON_CPR) && cpr_is_incoming()) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89f9246416a700ecbfb21ec3921b5a71cadf9981..b97261c61b4f303cb799e4ed6cdce391c198353c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3411,6 +3411,13 @@ static void vfio_instance_init(Object *obj)
     /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
      * line, therefore, no need to wait to realize like other devices */
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+
+    /*
+     * A device that is resuming for cpr is already configured, so do not
+     * reset it during qemu_system_reset prior to cpr load, else interrupts
+     * may be lost.
+     */
+    pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
 }
 
 static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
-- 
2.49.0


