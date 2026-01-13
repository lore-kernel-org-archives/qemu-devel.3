Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CDD29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapc-000679-8R; Tue, 13 Jan 2026 04:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapZ-00060f-DN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapX-0003Fq-Aw
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGdILztNMy0HHXpr+S6Sh0/Ub6zEA2jd2NIP03tM6/w=;
 b=ZpGCRBphuLVL8/EwwtnI0rr9xJ22lZq5ctBpXQdRbwgIS7dLEwpWdUAPXIqwLst+wxKieK
 ugk/nOsuei9GX9cx8J5GN49n2YSVOfwJtFwj0WteQf6ESmOb0tDpjLXkLZMk7cJV8fr441
 r0n3kCEXLBfRtgBrKaJVhTw35gvYpF0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-lxVvW5Z-Pee1VNWsN1Wisg-1; Tue,
 13 Jan 2026 04:36:45 -0500
X-MC-Unique: lxVvW5Z-Pee1VNWsN1Wisg-1
X-Mimecast-MFC-AGG-ID: lxVvW5Z-Pee1VNWsN1Wisg_1768297004
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EDCE1800447; Tue, 13 Jan 2026 09:36:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18BE530001A2; Tue, 13 Jan 2026 09:36:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/41] hw/vfio/migration: Check base architecture at runtime
Date: Tue, 13 Jan 2026 10:35:57 +0100
Message-ID: <20260113093637.1549214-2-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Inline vfio_arch_wants_loading_config_after_iter() and
replace the compile time check of the TARGET_ARM definition
by a runtime call to target_base_arm().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20251021161707.8324-1-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h      |  2 --
 hw/vfio/helpers.c           | 17 -----------------
 hw/vfio/migration-multifd.c | 12 +++++++++++-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index ce317580800ac0c96696e8d3769a98c21d2716d0..54a327ffbc04a2df364fdd78bd97fe7e2065b38c 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -32,6 +32,4 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
-bool vfio_arch_wants_loading_config_after_iter(void);
-
 #endif /* HW_VFIO_VFIO_HELPERS_H */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index c595f860cea91398bffce515e8d25bd462c1a20b..f68f8165d091abd7faac778d8c90da27a8f5f5f8 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -210,20 +210,3 @@ retry:
 
     return info;
 }
-
-bool vfio_arch_wants_loading_config_after_iter(void)
-{
-    /*
-     * Starting the config load only after all iterables were loaded (during
-     * non-iterables loading phase) is required for ARM64 due to this platform
-     * VFIO dependency on interrupt controller being loaded first.
-     *
-     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
-     * the right place in VFIO migration").
-     */
-#if defined(TARGET_ARM)
-    return true;
-#else
-    return false;
-#endif
-}
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 4a855f4e1257fd0094d720a1dd0fd2aa25acb25f..a06cbf3c646896d7f87698b0d654b160be995237 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "qemu/thread.h"
 #include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
@@ -44,7 +45,16 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
     }
 
     assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
-    return vfio_arch_wants_loading_config_after_iter();
+
+    /*
+     * Starting the config load only after all iterables were loaded (during
+     * non-iterables loading phase) is required for ARM64 due to this platform
+     * VFIO dependency on interrupt controller being loaded first.
+     *
+     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
+     * the right place in VFIO migration").
+     */
+    return target_base_arm();
 }
 
 /* type safety */
-- 
2.52.0


