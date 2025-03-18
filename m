Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42AFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgF-0005UR-13; Tue, 18 Mar 2025 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTg1-00053a-Ld
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfz-0002Ov-M0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5sDX7N8Yc+54uJ0ik0JThyw0LCo81DfbjWlX3PON1I=;
 b=M8DubTWXXVay1tThU0ud3hQIG0WHEORn5klcNpV3P3ImoEfm7HNlWiNYys5YDhROTIlD63
 OubydDs1Z4gfLYIJqF2OLq/saHYJ+b95eDeAXeVs/NhIqWiHwtmBYuOCyfQxnj4BNsSBey
 KC1QaUfLp40OtIJxDKvThnSyR9JLmqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-z2-P9YN1O-KPxbuofw5IJg-1; Tue,
 18 Mar 2025 05:55:52 -0400
X-MC-Unique: z2-P9YN1O-KPxbuofw5IJg-1
X-Mimecast-MFC-AGG-ID: z2-P9YN1O-KPxbuofw5IJg_1742291751
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B8A21801A06; Tue, 18 Mar 2025 09:55:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5B671828A87; Tue, 18 Mar 2025 09:55:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 22/32] vfio: Move vfio_device_list into device.c
Date: Tue, 18 Mar 2025 10:54:05 +0100
Message-ID: <20250318095415.670319-23-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

'vfio_device_list' is VFIODevice related. Move its definitions into
"device.c".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 3 ---
 hw/vfio/device.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 52f440c0d05fa9f781221032442b6118ef898a10..df9585d1a471f893da072068f6056bbc6731d448 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -46,9 +46,6 @@
 #include "migration.h"
 #include "helpers.h"
 
-VFIODeviceList vfio_device_list =
-    QLIST_HEAD_INITIALIZER(vfio_device_list);
-
 /*
  * Device state interfaces
  */
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index daa5bae59ca9c65ef23aa193d4e63976fcefdde0..2e0ddec942690514e692b2380a909f15ece430f5 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -32,6 +32,9 @@
 #include "monitor/monitor.h"
 #include "helpers.h"
 
+VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
+
 /*
  * Common VFIO interrupt disable
  */
-- 
2.48.1


