Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6897CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOClj-0005p4-Dv; Mon, 01 Jul 2024 04:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCjq-00036a-TR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCjp-0005LR-8Z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719823816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvaElzgdc5LUZDt5B9HkTKyPwMmB6JE1O0fZPWrvisU=;
 b=Bc6iwmLmZpTht2QVM7w8AUsbeBLnm+oJbnvv3xhTsbMWHN9J/SPvHCCF0qINwLfES3RYIA
 7COlD8ZAjHr/kARn45A4mgfQ1F6hhHDQuBUWpM2eVGg2AlTAzWIKcDgcEN7vLWMx0MBOf1
 3wUiQgC0MpskYGCpRPbKDe6yX/fBNQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-VUUO-PPuObq3G5EDmQaIRg-1; Mon,
 01 Jul 2024 04:50:11 -0400
X-MC-Unique: VUUO-PPuObq3G5EDmQaIRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786E0193318E; Mon,  1 Jul 2024 08:50:09 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.9.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B36EC1955E80; Mon,  1 Jul 2024 08:50:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH v2 1/7] virtio-iommu: Fix error handling in
 virtio_iommu_set_host_iova_ranges()
Date: Mon,  1 Jul 2024 10:48:53 +0200
Message-ID: <20240701084957.1567641-2-eric.auger@redhat.com>
In-Reply-To: <20240701084957.1567641-1-eric.auger@redhat.com>
References: <20240701084957.1567641-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In case no IOMMUPciBus/IOMMUDevice are found we need to properly
set the error handle and return.

Fixes : Coverity CID 1549006
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: cf2647a76e ("virtio-iommu: Compute host reserved regions")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/virtio/virtio-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b9a7ddcd14..b708fb96fd 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -543,10 +543,15 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
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
2.41.0


