Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1CEC61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 07:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOX2O-0008Py-Nx; Mon, 09 Jun 2025 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOX1s-0008E2-F8
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 03:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOX1r-0005l9-0n
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 03:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749454486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25pOue6onoYQAGYnF02spvqInhU0HxMXPXhjOM+erd8=;
 b=KEn77FrG06nOiQmMgB9tVf9gONZASmOrFOut5W28dJieopsq8aca6K09TAlRySJ0M/XAue
 T13aCYAknaA4qffX6ITYyd45M1o/XUVpWPGi97WXpzevFWvdWffzWzIgWuYjTCkWpZiQzc
 Q2pcl+VAeISvCP4s2p26mA7yMIZETJg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-XLH8ZhbbNua161eSU_mNfg-1; Mon,
 09 Jun 2025 03:34:41 -0400
X-MC-Unique: XLH8ZhbbNua161eSU_mNfg-1
X-Mimecast-MFC-AGG-ID: XLH8ZhbbNua161eSU_mNfg_1749454480
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6641809C83; Mon,  9 Jun 2025 07:34:39 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC7011956087; Mon,  9 Jun 2025 07:34:38 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/arm: Add the romfile compatatibility
Date: Mon,  9 Jun 2025 03:34:08 -0400
Message-Id: <20250609073408.2083831-3-shahuang@redhat.com>
In-Reply-To: <20250609073408.2083831-1-shahuang@redhat.com>
References: <20250609073408.2083831-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On arm64, it doesn't use the vgabios-ramfb.bin, so set the property
"use-legacy-x86-rom" to false, thus the ramfb won't load the
vgabios-ramfb.bin.

This can mitigate the problem that on release version the qemu can't
find the vgabios-ramfb.bin if it use the ramfb.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 hw/arm/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a..5f94f7a2ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,6 +38,7 @@
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
+#include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
@@ -90,6 +91,8 @@
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
+    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "false" },
+    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "false" },
 };
 static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
 
-- 
2.40.1


