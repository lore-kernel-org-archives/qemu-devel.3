Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC252C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNaC-0004Pw-AB; Fri, 09 May 2025 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYj-00020x-Jm
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYg-0007CP-Nj
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTrdMbGYvmmCDD/7+FBZWHHfPaqZDrsFYQwM6GW69ic=;
 b=e6yihyjO3grMe0xc6ompLbFpHJAu7SCVRupEeH/uAXpaS3rKLjHyiKk8w7yBOutB9E6PUe
 wQz/eoF27QpwVdlALbfnFh82Cx1zb1I3Z6x3zYiCfxoIiaQG/mZwQNBdK3vS26ip4E7gU5
 0ytXRNmiUBNYPDTIrsDwhkcGtNEjmPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-1ESlwjCZMd2pGlCUFFoyKA-1; Fri,
 09 May 2025 09:14:29 -0400
X-MC-Unique: 1ESlwjCZMd2pGlCUFFoyKA-1
X-Mimecast-MFC-AGG-ID: 1ESlwjCZMd2pGlCUFFoyKA_1746796468
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 959891955D81; Fri,  9 May 2025 13:14:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0586B180045B; Fri,  9 May 2025 13:14:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/28] vfio: add strread/writeerror()
Date: Fri,  9 May 2025 15:13:09 +0200
Message-ID: <20250509131317.164235-21-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

Add simple helpers to correctly report failures from read/write routines
using the return -errno style.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-7-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a7eaaa31e7e98a1ec73eefde0d935842ef9da401..4a3220294309d718bb3230a5d3f4bab9e082f951 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -115,6 +115,20 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
+/*
+ * Given a return value of either a short number of bytes read or -errno,
+ * construct a meaningful error message.
+ */
+#define strreaderror(ret) \
+    (ret < 0 ? strerror(-ret) : "short read")
+
+/*
+ * Given a return value of either a short number of bytes written or -errno,
+ * construct a meaningful error message.
+ */
+#define strwriteerror(ret) \
+    (ret < 0 ? strerror(-ret) : "short write")
+
 void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
-- 
2.49.0


