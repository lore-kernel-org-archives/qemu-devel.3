Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C760C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mu-0005I9-BP; Tue, 09 Jul 2024 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mp-0004y4-EW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9MZ-0006JN-TM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yGLBk3on+szjb8yno/MlD+vnSsQAPQcY1uYtpRX0fc=;
 b=AkDEwCtRt1loU3CDJtR92tAI0FvkWYTDgbHCOohdkS6k6ERCD4qMfPWJ8PPxkdepJ6Ii38
 S5VgR3spzXZj/opwi5nYZS3qNfRec7U0xVX8ynQDK3cQX7GcDsOU/4WeUuRo5gaKOgERzn
 HFH+5WoTHQup7Qqxg3q9UJOqaPp8Zgc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-rlpHMtaCNdiNhjmmZEVznA-1; Tue,
 09 Jul 2024 07:50:24 -0400
X-MC-Unique: rlpHMtaCNdiNhjmmZEVznA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A18E1955F3B; Tue,  9 Jul 2024 11:50:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C9763000181; Tue,  9 Jul 2024 11:50:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 1/9] virtio-iommu: Fix error handling in
 virtio_iommu_set_host_iova_ranges()
Date: Tue,  9 Jul 2024 13:50:09 +0200
Message-ID: <20240709115017.798043-2-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric Auger <eric.auger@redhat.com>

In case no IOMMUPciBus/IOMMUDevice are found we need to properly
set the error handle and return.

Fixes : Coverity CID 1549006

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: cf2647a76e ("virtio-iommu: Compute host reserved regions")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7c54c6b5e260e65b555e63809ed247254c785d3f..8fe69ab094f501fced7098f1ba790c26e63aa775 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -563,10 +563,15 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
     int ret = -EINVAL;
 
     if (!sbus) {
-        error_report("%s no sbus", __func__);
+        error_setg(errp, "%s: no IOMMUPciBus found!", __func__);
+        return ret;
     }
 
     sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        error_setg(errp, "%s: no IOMMUDevice found!", __func__);
+        return ret;
+    }
 
     current_ranges = sdev->host_resv_ranges;
 
-- 
2.45.2


