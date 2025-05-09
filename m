Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BEDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNYB-0001n0-8d; Fri, 09 May 2025 09:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNY7-0001mS-Sh
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNY5-00071u-MK
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gSLGM39m3Jvu/PSF0Lhw1cqS2npjBRM2FDLgxqNPwA=;
 b=OBAGr4yRBqqhJACoYY+uWPzF27KFz6W2GBp6UHvHA6RvYuaZ2vpHi4FIc0plRrb3m5TOCF
 Mjz0L1tFlFrlvMo+0CjiT6D4d2tDZVIeMSriKSs+uUDqOPXrSmS9yS/xiRQpkk2RthEtqI
 isQBel/GR+M1ENGhwbtCDjASH23EDdA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Jx-HYZDBOTmCjebBLH2xbQ-1; Fri,
 09 May 2025 09:13:52 -0400
X-MC-Unique: Jx-HYZDBOTmCjebBLH2xbQ-1
X-Mimecast-MFC-AGG-ID: Jx-HYZDBOTmCjebBLH2xbQ_1746796431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D7F21956051; Fri,  9 May 2025 13:13:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2377F18003FD; Fri,  9 May 2025 13:13:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/28] vfio/igd: Enable OpRegion by default
Date: Fri,  9 May 2025 15:12:58 +0200
Message-ID: <20250509131317.164235-10-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As the presence of OpRegion is used to detect IGD device now, and
guest driver usually depends on OpRegion to work. Enable OpRegion
on IGD devices by default for out-of-the-box passthrough experience
(except pre-boot display output), especially for libvirt users.

Example of IGD passthrough with libvirt:
<hostdev mode="subsystem" type="pci" managed="yes">
  <source>
    <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
  </source>
  <rom file="/path/to/igd/rom"/>
  <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
 </hostdev>

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-7-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/igd-assign.txt | 4 ++--
 hw/vfio/pci.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 95beb7681279ca97fc2b4b390045847dcd59eabd..fc444503ff310a317d5d6724b4656c29c4a7dc87 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -102,7 +102,7 @@ digital formats work well.
 
 Options
 =======
-* x-igd-opregion=[on|*off*]
+* x-igd-opregion=[*on*|off]
   Copy host IGD OpRegion and expose it to guest with fw_cfg
 
 * x-igd-lpc=[on|*off*]
@@ -124,7 +124,7 @@ Examples
 
 * Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
   (For UEFI guests)
-  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-opregion=on,x-igd-lpc=on,romfile=efi_oprom.rom
+  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-lpc=on,romfile=efi_oprom.rom
 
 
 Guest firmware
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6908bcc0d3145c98d2999841d00451bdc51b6a3e..e1fab21b47adb4df9b011b3efb6d7c15c84bc8c2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3385,7 +3385,7 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, true),
     DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
-- 
2.49.0


