Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837A1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4Q-0008Ra-He; Tue, 23 Jul 2024 10:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4O-0008Hf-03
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4M-0003fs-HF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VN5XurOSOhOVI8K7cqKxvgXc+D1w3ycuNbzoZRv8sCw=;
 b=MYPKrN+3S3O+Ylp/Jv9dcWAXMxox5hjZybJ7MKrC4l4rx0EkqCNN2pHPL4rRCH2wVne5ys
 RO6uOmTlRJ9rHnDe/B3uEUtwUU94ekSkgB459Gvf/nUnzB6cu4wZ+KFvTrPmqTSYV5UOzO
 1W09hCTnwCoYDTzkb0bTR26y0Af/H54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-yIKHQ-k9OYCOa1UuWEFMMw-1; Tue,
 23 Jul 2024 10:00:42 -0400
X-MC-Unique: yIKHQ-k9OYCOa1UuWEFMMw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5629D19772E1; Tue, 23 Jul 2024 14:00:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EA161955D48; Tue, 23 Jul 2024 14:00:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL 07/16] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
Date: Tue, 23 Jul 2024 16:00:10 +0200
Message-ID: <20240723140019.387786-8-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

mdevs aren't "physical" devices and when asking for backing IOMMU info,
it fails the entire provisioning of the guest. Fix that by setting
vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
presence of mdevs.

Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1f8e1272c7555cd0a770481d1ae92988f6e2e62e..115862f43036442d99c33f0328e5bc599ba1f2b9 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -675,6 +675,9 @@ static void vfio_ccw_instance_init(Object *obj)
     VFIOCCWDevice *vcdev = VFIO_CCW(obj);
     VFIODevice *vbasedev = &vcdev->vdev;
 
+    /* CCW device is mdev type device */
+    vbasedev->mdev = true;
+
     /*
      * All vfio-ccw devices are believed to operate in a way compatible with
      * discarding of memory in RAM blocks, ie. pages pinned in the host are
-- 
2.45.2


