Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE550C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC4F-0004Dt-Do; Thu, 06 Mar 2025 09:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1g-0000sH-N5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1a-00028o-TR
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb2pXYyk+rCZrdsQNj/06TLTTEn4q37gLE7EXsSn5qo=;
 b=i7fVQOWW7IgGvstDVX+CxMO/b4U5hv1pTj/q/yhzCjAJI9g8OPceVZDHlplUKo6HqddOqd
 ZXXYMoDQT3KFNI2n3PA8++JHNwR878bEY3zpJqkE00A+B8iNT+BZyj9nkIYO1wfbGBoFsa
 wRI9u/SFzi3G+4R1Kf/UtHM8YCtK+lM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-Zf7mE1gINzCa3Tn8RfUS8Q-1; Thu,
 06 Mar 2025 09:15:58 -0500
X-MC-Unique: Zf7mE1gINzCa3Tn8RfUS8Q-1
X-Mimecast-MFC-AGG-ID: Zf7mE1gINzCa3Tn8RfUS8Q_1741270557
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27C00195421B; Thu,  6 Mar 2025 14:15:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85F9C18001D3; Thu,  6 Mar 2025 14:15:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/42] vfio/migration: Move migration channel flags to
 vfio-common.h header file
Date: Thu,  6 Mar 2025 15:14:06 +0100
Message-ID: <20250306141419.2015340-31-clg@redhat.com>
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This way they can also be referenced in other translation
units than migration.c.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/26a940f6b22c1b685818251b7a3ddbbca601b1d6.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 17 +++++++++++++++++
 hw/vfio/migration.c           | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5c84ebb0029853bf408ffb7d308a603435bd234b..bf5d5208712925f140e55583a2c0fe216184d046 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -36,6 +36,23 @@
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
+/*
+ * Flags to be used as unique delimiters for VFIO devices in the migration
+ * stream. These flags are composed as:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => Magic ID, represents emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ *
+ * The beginning of state information is marked by _DEV_CONFIG_STATE,
+ * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
+ * certain state information is marked by _END_OF_STATE.
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 51c056e152aae694ecc1b590c1a94dd8e5277c4a..a9b0970604aa3e15fe2fb2412286e48cac3b03cc 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -31,23 +31,6 @@
 #include "trace.h"
 #include "hw/hw.h"
 
-/*
- * Flags to be used as unique delimiters for VFIO devices in the migration
- * stream. These flags are composed as:
- * 0xffffffff => MSB 32-bit all 1s
- * 0xef10     => Magic ID, represents emulated (virtual) function IO
- * 0x0000     => 16-bits reserved for flags
- *
- * The beginning of state information is marked by _DEV_CONFIG_STATE,
- * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
- * certain state information is marked by _END_OF_STATE.
- */
-#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
-#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
-#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
-#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
-#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
-
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
  * total device migration size is on the order of 100s of MB. Testing with
-- 
2.48.1


