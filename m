Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE759C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBzs-0006j8-ME; Thu, 06 Mar 2025 09:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzq-0006i7-Dl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzo-0001YK-Ok
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96NNoeYmbYX997FSeXO0A+RNZHQyES2WQ6gVPAsS7hQ=;
 b=A2TxifiFaVIM1h6ODNXFrAeR9nB4WOkqkXPDwAirq2OP+GCvBhwR4IJGyN062xt7h1tJ7f
 rjoLolGhZXXSmTZnOIiSpZgHcI0xA8TlcTu5a4jAnbUIK0nLl00/rU4T0HkVlenCa6DzfH
 uYQwkpi04er1hjLDfO+fqHjro0CgyFY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-k_qVS7vDPveblp5hoSpzUA-1; Thu,
 06 Mar 2025 09:14:35 -0500
X-MC-Unique: k_qVS7vDPveblp5hoSpzUA-1
X-Mimecast-MFC-AGG-ID: k_qVS7vDPveblp5hoSpzUA_1741270475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB613180035E; Thu,  6 Mar 2025 14:14:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BA1F18009BC; Thu,  6 Mar 2025 14:14:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/42] vfio/ccw: Replace warn_once_pfch() with
 warn_report_once()
Date: Thu,  6 Mar 2025 15:13:38 +0100
Message-ID: <20250306141419.2015340-3-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250214161936.1720039-1-clg@redhat.com
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


