Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3U-0002SW-MS; Thu, 06 Mar 2025 09:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1F-0000Oz-DK
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1D-0001zy-Mj
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PEo31mSNERiGC5mMve2THeVlhL4GmE+0RiWcz7ZlWI=;
 b=Ylg6WggnuNMMvVCPRCSxQN1JIaD6qBF0Gg1u+6Jj8ep5R+fE3nK2qlgfUeI8Q0t8THc9j1
 drgr5oIYCJ44Drqw0qNdkiUi0uFqIsooP4jvYD+oyLrbwSMvSiaTK0g6SDUnO+9liZehyl
 e9t28wuM7ky8Cqkl7SRWeYdfQdPlW10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-WGd7WDaUOg2Yof-lYkMP2Q-1; Thu,
 06 Mar 2025 09:16:02 -0500
X-MC-Unique: WGd7WDaUOg2Yof-lYkMP2Q-1
X-Mimecast-MFC-AGG-ID: WGd7WDaUOg2Yof-lYkMP2Q_1741270561
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73F1019560B7; Thu,  6 Mar 2025 14:16:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEB7B180174D; Thu,  6 Mar 2025 14:15:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/42] vfio/migration: Multifd device state transfer - add
 support checking function
Date: Thu,  6 Mar 2025 15:14:08 +0100
Message-ID: <20250306141419.2015340-33-clg@redhat.com>
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

Add vfio_multifd_transfer_supported() function that tells whether the
multifd device state transfer is supported.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/8ce50256f341b3d47342bb217cb5fbb2deb14639.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.h | 2 ++
 hw/vfio/migration-multifd.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 5b221c6e16b0265314034a6060b588e984b8ac5e..1b60d5f67a1c76cdac21d71a7fb7335f4e194ffe 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -14,4 +14,6 @@
 
 #include "hw/vfio/vfio-common.h"
 
+bool vfio_multifd_transfer_supported(void);
+
 #endif
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index fa594b33fdd1112e1d3ecf52a35fecb551e29999..79fae0b6296f9244317ed5215e4950703c45a717 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -31,3 +31,9 @@ typedef struct VFIODeviceStatePacket {
     uint32_t flags;
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
+
+bool vfio_multifd_transfer_supported(void)
+{
+    return multifd_device_state_supported() &&
+        migrate_send_switchover_start();
+}
-- 
2.48.1


