Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D986E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e4-0007SP-Ex; Tue, 24 Dec 2024 10:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dv-0007CU-9z
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6ds-00044s-5m
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5qYckvgIIGDs1pm0GDTPxd8uouPXLvudJ9dPfuOTcI=;
 b=hc+NfkTXCJSSo+HverysWu7RKRLHGkZI96chvMMuTe5yE5W+xPVjy1ytakWiGG4ivCcbzT
 0Pa3lteqnu+D0MCZqq0JBhx3aK+2V29I1yG+42ooPI4Hc5Dqp2vq509xoTGFIb6Fui0mWx
 gqNN3cGvfRxZEKFwEiTyrzD4fsUDqW8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-SUl30bHyNASTjmOlHY3R_w-1; Tue,
 24 Dec 2024 10:16:14 -0500
X-MC-Unique: SUl30bHyNASTjmOlHY3R_w-1
X-Mimecast-MFC-AGG-ID: SUl30bHyNASTjmOlHY3R_w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3673A19560AF; Tue, 24 Dec 2024 15:16:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9D9A3000197; Tue, 24 Dec 2024 15:16:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/17] vfio/igd: add x-igd-gms option back to set DSM region
 size for guest
Date: Tue, 24 Dec 2024 16:15:40 +0100
Message-ID: <20241224151547.386529-11-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

DSM region is likely to store framebuffer in Windows, a small DSM
region may cause display issues (e.g. half of the screen is black).
Since 971ca22f041b ("vfio/igd: don't set stolen memory size to zero"),
the x-igd-gms option was functionally removed, QEMU uses host's
original value, which is determined by DVMT Pre-Allocated option in
Intel FSP of host bios.

However, some vendors do not expose this config item to users. In
such cases, x-igd-gms option can be used to manually set the data
stolen memory size for guest. So this commit brings this option back,
keeping its old behavior. When it is not specified, QEMU uses host's
value.

When DVMT Pre-Allocated option is available in host BIOS, user should
set DSM region size there instead of using x-igd-gms option.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-11-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 73c06bbf64d85b8dbf1575dac34ef8b7e64a3490..b0fef90240ca6dcc0ead7ed536202d618546b4b1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -14,6 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
@@ -722,6 +723,31 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
+    /*
+     * Allow user to override dsm size using x-igd-gms option, in multiples of
+     * 32MiB. This option should only be used when the desired size cannot be
+     * set from DVMT Pre-Allocated option in host BIOS.
+     */
+    if (vdev->igd_gms) {
+        if (gen < 8) {
+            if (vdev->igd_gms <= 0x10) {
+                gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x10");
+            }
+        } else {
+            if (vdev->igd_gms <= 0x40) {
+                gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x40");
+            }
+        }
+    }
+
     ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
-- 
2.47.1


