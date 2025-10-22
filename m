Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A04CCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoQ-00015G-2K; Wed, 22 Oct 2025 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoO-00014n-Ne
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoM-00074F-Qe
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7kgzKTYZ8ou97BveS1sALexRkahzseuftgDs0yDqws=;
 b=Y2qETNp5bqClgDjqUHyZedK7joUG0uBCsVKQGCiP2Q4RbhYULWFw8M8DIXMEZaRrxxNrUy
 AkhXmDjVe133x/6dFI4LgqFq5Y4dThkCWKjEZYg2NKT4S0kM04U2b6ZZZh0TTwF7WBdtaM
 Vi+C0ncYtkAZjW3+UeNSa9AbDLdSD6U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-z7F5lkEpNC2wGwz9Ajqrgw-1; Wed,
 22 Oct 2025 08:19:24 -0400
X-MC-Unique: z7F5lkEpNC2wGwz9Ajqrgw-1
X-Mimecast-MFC-AGG-ID: z7F5lkEpNC2wGwz9Ajqrgw_1761135562
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3030195606C; Wed, 22 Oct 2025 12:19:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC52E1800452; Wed, 22 Oct 2025 12:19:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PULL 12/12] vfio: only check region info cache for initial regions
Date: Wed, 22 Oct 2025 14:18:46 +0200
Message-ID: <20251022121846.874152-13-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

It is semantically valid for a VFIO device to increase the number of
regions after initialization. In this case, we'd attempt to check for
cached region info past the size of the ->reginfo array. Check for the
region index and skip the cache in these cases.

This also works around some VGPU use cases which appear to be a bug,
where VFIO_DEVICE_QUERY_GFX_PLANE returns a region index beyond the
reported ->num_regions.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20251014151227.2298892-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52079f4cf5bda7c1d9e6e3791a6c340a0e3f57ba..8b63e765acbacdccc5365d000e2aa9bd49ae9701 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -205,10 +205,19 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
     int fd = -1;
     int ret;
 
-    /* check cache */
-    if (vbasedev->reginfo[index] != NULL) {
-        *info = vbasedev->reginfo[index];
-        return 0;
+    /*
+     * We only set up the region info cache for the initial number of regions.
+     *
+     * Since a VFIO device may later increase the number of regions then use
+     * such regions with an index past ->num_initial_regions, don't attempt to
+     * use the info cache in those cases.
+     */
+    if (index < vbasedev->num_initial_regions) {
+        /* check cache */
+        if (vbasedev->reginfo[index] != NULL) {
+            *info = vbasedev->reginfo[index];
+            return 0;
+        }
     }
 
     *info = g_malloc0(argsz);
@@ -236,10 +245,12 @@ retry:
         goto retry;
     }
 
-    /* fill cache */
-    vbasedev->reginfo[index] = *info;
-    if (vbasedev->region_fds != NULL) {
-        vbasedev->region_fds[index] = fd;
+    if (index < vbasedev->num_initial_regions) {
+        /* fill cache */
+        vbasedev->reginfo[index] = *info;
+        if (vbasedev->region_fds != NULL) {
+            vbasedev->region_fds[index] = fd;
+        }
     }
 
     return 0;
-- 
2.51.0


