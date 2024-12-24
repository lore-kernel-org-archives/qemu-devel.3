Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D498AE7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6dh-0006yc-0p; Tue, 24 Dec 2024 10:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dd-0006xG-Dd
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6db-00042s-K6
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8LVIlBW683vDKRuQIBD2Zcn8Iuf6hNj3qTi5kY2/o0=;
 b=WzFHh4uaF4GZCAaeHCyAOIUE1ybNHnQtonRZCnLjvr6ZtQCQAcsdZANApIeRYVSI1A4+Jm
 0OCe0OeidvpsNx2Ls+P6V9EPDzITxAOS5kZjS18GVubRvQd8LBM22ESMlvCTd1u/tuYbl0
 CgGA2wBdBEWGOPz/21aG4saT4fQYmwc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-jSuwJ4ApMY2RYpcUnFsezA-1; Tue,
 24 Dec 2024 10:15:56 -0500
X-MC-Unique: jSuwJ4ApMY2RYpcUnFsezA-1
X-Mimecast-MFC-AGG-ID: jSuwJ4ApMY2RYpcUnFsezA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB5E51956096; Tue, 24 Dec 2024 15:15:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 294C83000197; Tue, 24 Dec 2024 15:15:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/17] vfio/igd: remove unsupported device ids
Date: Tue, 24 Dec 2024 16:15:32 +0100
Message-ID: <20241224151547.386529-3-clg@redhat.com>
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

Since e433f208973f ("vfio/igd: return an invalid generation for unknown
devices"), the default return of igd_gen() was changed to unsupported.
There is no need to filter out those unsupported devices.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Link: https://lore.kernel.org/r/20241206122749.9893-3-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 73ed1ec8e6af60ed58fe6546f750d07fc972193e..059ed56439f127c92cd9df33c6368a8792f07675 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* Old, untested, unavailable, unknown */
-    case 0x0000:
-    case 0x2500:
-    case 0x2700:
-    case 0x2900:
-    case 0x2a00:
-    case 0x2e00:
-    case 0x3500:
-    case 0xa000:
-        return -1;
     /* SandyBridge, IvyBridge, ValleyView, Haswell */
     case 0x0100:
     case 0x0400:
-- 
2.47.1


