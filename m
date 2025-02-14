Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16835C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyPw-0003UL-AG; Fri, 14 Feb 2025 11:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiyPv-0003U4-3H
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiyPs-0000UY-Dc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739549986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dkyMjYM4b1J1Fi6gpv6okK7CVDrwDsBObI8HRMtHmxg=;
 b=E+stCjRo76Usa3dVlWstR8aV80FJfoETv+4qdzbt399kB6MloTS/gj/+F2LbZRsqHgpexr
 DKChldhGjQp4VCWiG8Qno7qi72227aKDvRk0gf48jqdwn8bTAOGeqRWHYf9jPu4txXbXr3
 xZOMGUynAJQq4isVhePMDWl2OWc3z+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-lMBrx_qHP2-aU1FhhV4t-w-1; Fri,
 14 Feb 2025 11:19:43 -0500
X-MC-Unique: lMBrx_qHP2-aU1FhhV4t-w-1
X-Mimecast-MFC-AGG-ID: lMBrx_qHP2-aU1FhhV4t-w_1739549982
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E05281800873; Fri, 14 Feb 2025 16:19:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 812BF19373C4; Fri, 14 Feb 2025 16:19:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] vfio/ccw: Replace warn_once_pfch() with warn_report_once()
Date: Fri, 14 Feb 2025 17:19:36 +0100
Message-ID: <20250214161936.1720039-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

Use the common helper warn_report_once() instead of implementing its
own.

Cc: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ea766ae26c744c05515e1cc80a486a3462d82834..e5e0d9e3e7ed124f242b3eda345bc973e418a64c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -51,17 +51,8 @@ struct VFIOCCWDevice {
     EventNotifier crw_notifier;
     EventNotifier req_notifier;
     bool force_orb_pfch;
-    bool warned_orb_pfch;
 };
 
-static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
-                                  const char *msg)
-{
-    warn_report_once_cond(&vcdev->warned_orb_pfch,
-                          "vfio-ccw (devno %x.%x.%04x): %s",
-                          sch->cssid, sch->ssid, sch->devno, msg);
-}
-
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = false;
@@ -83,7 +74,8 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
 
     if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
         sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
-        warn_once_pfch(vcdev, sch, "PFCH flag forced");
+        warn_report_once("vfio-ccw (devno %x.%x.%04x): PFCH flag forced",
+                         sch->cssid, sch->ssid, sch->devno);
     }
 
     QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
-- 
2.48.1


