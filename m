Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70848C28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC2J-0001lq-Nt; Thu, 06 Mar 2025 09:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC10-00089r-NU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0y-0001st-8T
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qMRgHQOMtuGn9LMz4mIxSzpfeNWUHwblusGaJqRnNg=;
 b=KPKA6zBXXiV1SPMX7DDLED3d0aDSv1BDp6K6CVTSEEi8G10heb2HpjEUYPOOSE5cQ9oETa
 aIEEhOCw82ufQk93ralFnPQQjz1Oi5JsjCJJX98ntPFUMPaXJUQuBT5sz7a0Lh+ZsXq0g9
 738if1LrpcMrTnov7qPeDozwv/cD1q8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-P-xAzp9bPkOpbXLVoffkdw-1; Thu,
 06 Mar 2025 09:15:45 -0500
X-MC-Unique: P-xAzp9bPkOpbXLVoffkdw-1
X-Mimecast-MFC-AGG-ID: P-xAzp9bPkOpbXLVoffkdw_1741270544
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17D7A180AF73; Thu,  6 Mar 2025 14:15:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6CC518001D3; Thu,  6 Mar 2025 14:15:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/42] migration/multifd: Add multifd_device_state_supported()
Date: Thu,  6 Mar 2025 15:14:01 +0100
Message-ID: <20250306141419.2015340-26-clg@redhat.com>
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

Since device state transfer via multifd channels requires multifd
channels with packets and is currently not compatible with multifd
compression add an appropriate query function so device can learn
whether it can actually make use of it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/1ff0d98b85f470e5a33687406e877583b8fab74e.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h         | 1 +
 migration/multifd-device-state.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bd3b725fa0b7efc4551aa19d2ac540f24bde4763..273ebfca6256265507cd6aa28a104a3db1ac106b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -121,5 +121,6 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
 /* migration/multifd-device-state.c */
 bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
+bool multifd_device_state_supported(void);
 
 #endif
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 64d8ca180167b09abf13c9302326404be236717e..3097ffa31025971bb9b893c53dad352d517148d9 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -13,6 +13,7 @@
 #include "qemu/lockable.h"
 #include "migration/misc.h"
 #include "multifd.h"
+#include "options.h"
 
 static struct {
     QemuMutex queue_job_mutex;
@@ -111,3 +112,9 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
 
     return true;
 }
+
+bool multifd_device_state_supported(void)
+{
+    return migrate_multifd() && !migrate_mapped_ram() &&
+        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
+}
-- 
2.48.1


