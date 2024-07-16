Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA5FC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTelk-0005tc-Oq; Tue, 16 Jul 2024 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelk-0005sz-0P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelh-0000NQ-De
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUjckqLbDLeSWm2r/UdxZCZJsU5t10ssHlVyg/zX46Y=;
 b=VjVkqQHv5WrpWqxVyxfrj2Q2tIzBqOev8EjTlBr/O0ga+vmVFZW/gi1sOyK2xcFnjbNAIj
 k8Dp3x9iBB8thc4W3hy8zMU3qoMgYgVWI5C1IAlARDoxRMU+QXit9LVlCfCHn7wsmHugZc
 KB8i/XaZugAuLmieX7VhzZ+xZnbRuU0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-gqzJtYh8P_y9cqQfrLkWcA-1; Tue,
 16 Jul 2024 05:46:40 -0400
X-MC-Unique: gqzJtYh8P_y9cqQfrLkWcA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 913091955BFA; Tue, 16 Jul 2024 09:46:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCAF13000183; Tue, 16 Jul 2024 09:46:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH 2/6] virtio-iommu: Remove probe_done
Date: Tue, 16 Jul 2024 11:45:04 +0200
Message-ID: <20240716094619.1713905-3-eric.auger@redhat.com>
In-Reply-To: <20240716094619.1713905-1-eric.auger@redhat.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now we have switched to PCIIOMMUOps to convey host IOMMU information,
the host reserved regions are transmitted when the PCIe topology is
built. This happens way before the virtio-iommu driver calls the probe
request. So let's remove the probe_done flag that allowed to check
the probe was not done before the IOMMU MR got enabled. Besides this
probe_done flag had a flaw wrt migration since it was not saved/restored.

The only case at risk is if 2 devices were plugged to a
PCIe to PCI bridge and thus aliased. First of all we
discovered in the past this case was not properly supported for
neither SMMU nor virtio-iommu on guest kernel side: see

[RFC] virtio-iommu: Take into account possible aliasing in virtio_iommu_mr()
https://lore.kernel.org/all/20230116124709.793084-1-eric.auger@redhat.com/

If this were supported by the guest kernel, it is unclear what the call
sequence would be from a virtio-iommu driver point of view.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/virtio/virtio-iommu.h | 1 -
 hw/virtio/virtio-iommu.c         | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index bdb3da72d0..7db4210b16 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -43,7 +43,6 @@ typedef struct IOMMUDevice {
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
     GList *resv_regions;
     GList *host_resv_ranges;
-    bool probe_done;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4e34dacd6e..2c54c0d976 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -555,8 +555,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
 
     current_ranges = sdev->host_resv_ranges;
 
-    g_assert(!sdev->probe_done);
-
     /* check that each new resv region is included in an existing one */
     if (sdev->host_resv_ranges) {
         range_inverse_array(iova_ranges,
@@ -956,7 +954,6 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
     }
     buf += count;
     free -= count;
-    sdev->probe_done = true;
 
     return VIRTIO_IOMMU_S_OK;
 }
-- 
2.41.0


