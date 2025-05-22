Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736CCC54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAhX-0005kY-Of; Thu, 22 May 2025 14:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhW-0005k3-Na
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhU-0000N1-MN
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747938687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUaTgO2vTys8H4ViTayW5yivwWSc1BhR5TJhH22T7z0=;
 b=Mbj+/CT56TFjul3dTaQFLf6Fx5r/DXiEGVCcc/yUjM6QJFT++9eQtjG12dr8sqLlzGudrf
 9K71pWeYC5ENzOZRRo2BI6mwnEDT/l5kz0akMLzEugHZMLY0ja8SIfdsgocyff1ssqB/YO
 HaZhyXqXNJ588KXxN6yjDFm0j6RfjXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-UVIFQtojPNW7pZi49kk_oA-1; Thu,
 22 May 2025 14:31:24 -0400
X-MC-Unique: UVIFQtojPNW7pZi49kk_oA-1
X-Mimecast-MFC-AGG-ID: UVIFQtojPNW7pZi49kk_oA_1747938683
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71B4018004AD; Thu, 22 May 2025 18:31:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C70E1944DFF; Thu, 22 May 2025 18:31:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 2/5] scsi-disk: Advertise FUA support by default
Date: Thu, 22 May 2025 20:31:12 +0200
Message-ID: <20250522183115.246746-3-kwolf@redhat.com>
In-Reply-To: <20250522183115.246746-1-kwolf@redhat.com>
References: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alberto Faria <afaria@redhat.com>

Allow the guest to submit FUA requests directly, instead of forcing it
to emulate them using a regular flush.

Signed-off-by: Alberto Faria <afaria@redhat.com>
Message-ID: <20250502121115.3613717-3-afaria@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/machine.c   | 4 +++-
 hw/scsi/scsi-disk.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b8ae155dfa..c3f3a5020d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,7 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_10_0[] = {};
+GlobalProperty hw_compat_10_0[] = {
+    { "scsi-hd", "dpofua", "off" },
+};
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
 GlobalProperty hw_compat_9_2[] = {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 738d8df8ec..b4782c6248 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3192,7 +3192,7 @@ static const Property scsi_hd_properties[] = {
     DEFINE_PROP_BIT("removable", SCSIDiskState, features,
                     SCSI_DISK_F_REMOVABLE, false),
     DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
-                    SCSI_DISK_F_DPOFUA, false),
+                    SCSI_DISK_F_DPOFUA, true),
     DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
     DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
     DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),
-- 
2.49.0


