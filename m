Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAD5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCG-0003dB-K8; Mon, 24 Jun 2024 17:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCE-0003XZ-Tu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCD-0006gK-8k
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dOlZmQlSKtCcjRjHqzVdJSfV+gUJAJv7SjHkbgembU=;
 b=FkwJx19jNy7/RkmGw90zhVzCHIMts3VTNldM4SFmHaeBbiDNqE1QAgW/AXRDSRPwiERtru
 sr76Ple10/9LCV397aAr0vWk6JIxiEq/dzBEv77cNKjzlCSemCvR8CkOa9OLY4APypzgW+
 Lm4gK0T7kATqK3OEAltvbekLumbHyJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-X3CcT6XFNBGsK82Wl56tow-1; Mon,
 24 Jun 2024 17:25:47 -0400
X-MC-Unique: X3CcT6XFNBGsK82Wl56tow-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75BA19560AB; Mon, 24 Jun 2024 21:25:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D33B1956051; Mon, 24 Jun 2024 21:25:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 17/42] intel_iommu: Check compatibility with host IOMMU
 capabilities
Date: Mon, 24 Jun 2024 23:24:31 +0200
Message-ID: <20240624212456.350919-18-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

If check fails, host device (either VFIO or VDPA device) is not
compatible with current vIOMMU config and should not be passed to
guest.

Only aw_bits is checked for now, we don't care about other caps
before scalable modern mode is introduced.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 019d1c9c800cde1d84f50e29eac02bea0e3329f3..37c21a0aec655770f5b0190c9e4edcf63f8057fa 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3837,6 +3837,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+                           Error **errp)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    int ret;
+
+    if (!hiodc->get_cap) {
+        error_setg(errp, ".get_cap() not implemented");
+        return false;
+    }
+
+    /* Common checks */
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (s->aw_bits > ret) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
+        return false;
+    }
+
+    return true;
+}
+
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3857,6 +3881,11 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    if (!vtd_check_hiod(s, hiod, errp)) {
+        vtd_iommu_unlock(s);
+        return false;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
-- 
2.45.2


