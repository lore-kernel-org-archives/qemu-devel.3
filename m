Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E14C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC1p-0000sE-3V; Thu, 06 Mar 2025 09:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0z-000858-4C
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0x-0001sS-A8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggH3+7adeq8R4LD9PInlmJ5WYrvAy9ls9kmNXg6IBiE=;
 b=CSAzs40qrxOJGhEk7QjULxF4xDHsZcqt+PyhDY8R7g6Q+3dpls46xCjync8+qWCCZT8m4s
 Ky+CihZlPlhP2YQqcIN6ny+ok/HYzsNTfV3Gs/q/J7Y32vDNbVeOtQzdT6jHSUSXgDgpu6
 0UY4Fc4QFtje7sW7OK+3F8Q8Qbhib2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-Cl-qnIg-MAOUoCsJa4NnDg-1; Thu,
 06 Mar 2025 09:15:50 -0500
X-MC-Unique: Cl-qnIg-MAOUoCsJa4NnDg-1
X-Mimecast-MFC-AGG-ID: Cl-qnIg-MAOUoCsJa4NnDg_1741270549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50E58180AF5A; Thu,  6 Mar 2025 14:15:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E20718001D3; Thu,  6 Mar 2025 14:15:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/42] vfio/migration: Add load_device_config_state_start trace
 event
Date: Thu,  6 Mar 2025 15:14:03 +0100
Message-ID: <20250306141419.2015340-28-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

And rename existing load_device_config_state trace event to
load_device_config_state_end for consistency since it is triggered at the
end of loading of the VFIO device config state.

This way both the start and end points of particular device config
loading operation (a long, BQL-serialized operation) are known.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/1b6c5a2097e64c272eb7e53f9e4cca4b79581b38.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c  | 4 +++-
 hw/vfio/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index adfa752db5272e37d73fc0a435a0834e74e3f2fe..03890eaa48a9b36a9b934b5bb6d4814fadf65a8b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -285,6 +285,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     uint64_t data;
 
+    trace_vfio_load_device_config_state_start(vbasedev->name);
+
     if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
         int ret;
 
@@ -303,7 +305,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
         return -EINVAL;
     }
 
-    trace_vfio_load_device_config_state(vbasedev->name);
+    trace_vfio_load_device_config_state_end(vbasedev->name);
     return qemu_file_get_error(f);
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index c5385e1a4f98ea703c433f9923a37a776fe63e78..a02c668f28a43f73ed2db9f15827f26fed0994c3 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -150,7 +150,8 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_load_cleanup(const char *name) " (%s)"
-vfio_load_device_config_state(const char *name) " (%s)"
+vfio_load_device_config_state_start(const char *name) " (%s)"
+vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"
-- 
2.48.1


