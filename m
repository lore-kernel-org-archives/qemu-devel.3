Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CB0C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVglS-0002IK-6c; Sun, 21 Jul 2024 20:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglD-0001lb-46
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglA-0005vB-Cj
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRfxJi15v0LjYUfndDtOwJPZVyigXXbxUoHPnTtDziA=;
 b=EZYJ2TpiUguVFYsRkAZOEDiAgL/Z1w5Cut5KlkylSR3Jxq95ZiFrl9A3HWpralOsdGC8Ot
 RPUvebbD0wq0eLsAyTm7kUYsltXEAonbZfWCcxzXvyXD+NQ369UcEWj26Q6WgO0Sb3scc6
 fsSvAhoyN/nXpJnIhPxMRA8ZQvf9G0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-2FWS31f5Ot213MPUTzXxfQ-1; Sun, 21 Jul 2024 20:18:34 -0400
X-MC-Unique: 2FWS31f5Ot213MPUTzXxfQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36863648335so2230303f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607513; x=1722212313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RRfxJi15v0LjYUfndDtOwJPZVyigXXbxUoHPnTtDziA=;
 b=aP38nqW/FZcKBsUIP2NZveWuve/yi0n25UMT22Wp8NeG8J06RZmwxCGA9VYFkTbq6w
 EQSQEgn9wboOOxE68hpDFbBsMH7bTTh0hPJksd0Ag6S6A0EUGbC/GjqQMDjnYOD26jjW
 7TEes/2ckRZIw/yCbjqFGwI87GGnGw7rLCjAsJCAPnTqU918MqgCdmc7Gwfbo/lPNPWn
 snKMjcX64+jboO8CaQfecK8/QcZ6nmzlX24pxoXMrfgyNCWJbbIKIaC0n83l9Tapxdi2
 1nd1gQJNxYQtPHRSGF9D6cF0PN2k63tQd4bFnYXYVBsE20b8d7IOJ3Rx5iIxjeZgzBkP
 PGOg==
X-Gm-Message-State: AOJu0YwYdOCzdwXQrKvj0ENNbDQR9z42jUYb1VzW/tLnJNhj8bPGrFuP
 VfAb7mKmwksqtiYC0K3G2BTPEvx1+PGoliz/5lNwny05eiOWHyrUf3r8Zjc7BLmF1XdSnV99gw+
 nt5bhqMItu+jPCvW+hyRiyDdmZgZ5Uxhok6NZSfFv/SbRXh/anp9s26xYzN5PUu894k1gyp8p5d
 vy8DUA8qFYdwMxwZOrupcEli5K0+4Vmw==
X-Received: by 2002:a5d:4e42:0:b0:368:4c56:2bd0 with SMTP id
 ffacd0b85a97d-369bae2508bmr2813395f8f.33.1721607512906; 
 Sun, 21 Jul 2024 17:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7+3eNKTyYnhFU6enTq9Eiho1wRamJ+moS5+J+c/M1I6N45PudRahq3fnaA9q7j1xF5wKreQ==
X-Received: by 2002:a5d:4e42:0:b0:368:4c56:2bd0 with SMTP id
 ffacd0b85a97d-369bae2508bmr2813382f8f.33.1721607512384; 
 Sun, 21 Jul 2024 17:18:32 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868490fsm7050188f8f.6.2024.07.21.17.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:31 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 47/63] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Message-ID: <7d2d4621f8af47bafdc5a11b75b6fed06b171084.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We are currently missing the deallocation of the [host_]resv_regions
in case of hot unplug. Also to make things more simple let's rule
out the case where multiple HostIOMMUDevices would be aliased and
attached to the same IOMMUDevice. This allows to remove the handling
of conflicting Host reserved regions. Anyway this is not properly
supported at guest kernel level. On hotunplug the reserved regions
are reset to the ones set by virtio-iommu property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-4-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 62 ++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2c54c0d976..2de41ab412 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -538,8 +538,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
 {
     IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
     IOMMUDevice *sdev;
-    GList *current_ranges;
-    GList *l, *tmp, *new_ranges = NULL;
     int ret = -EINVAL;
 
     if (!sbus) {
@@ -553,33 +551,10 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
         return ret;
     }
 
-    current_ranges = sdev->host_resv_ranges;
-
-    /* check that each new resv region is included in an existing one */
     if (sdev->host_resv_ranges) {
-        range_inverse_array(iova_ranges,
-                            &new_ranges,
-                            0, UINT64_MAX);
-
-        for (tmp = new_ranges; tmp; tmp = tmp->next) {
-            Range *newr = (Range *)tmp->data;
-            bool included = false;
-
-            for (l = current_ranges; l; l = l->next) {
-                Range * r = (Range *)l->data;
-
-                if (range_contains_range(r, newr)) {
-                    included = true;
-                    break;
-                }
-            }
-            if (!included) {
-                goto error;
-            }
-        }
-        /* all new reserved ranges are included in existing ones */
-        ret = 0;
-        goto out;
+        error_setg(errp, "%s virtio-iommu does not support aliased BDF",
+                   __func__);
+        return ret;
     }
 
     range_inverse_array(iova_ranges,
@@ -588,14 +563,31 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
     rebuild_resv_regions(sdev);
 
     return 0;
-error:
-    error_setg(errp, "%s Conflicting host reserved ranges set!",
-               __func__);
-out:
-    g_list_free_full(new_ranges, g_free);
-    return ret;
 }
 
+static void virtio_iommu_unset_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
+                                                int devfn)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    g_list_free_full(g_steal_pointer(&sdev->host_resv_ranges), g_free);
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->host_resv_ranges = NULL;
+    sdev->resv_regions = NULL;
+    add_prop_resv_regions(sdev);
+}
+
+
 static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t new_mask,
                                  Error **errp)
 {
@@ -704,6 +696,8 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     if (!hiod) {
         return;
     }
+    virtio_iommu_unset_host_iova_ranges(viommu, hiod->aliased_bus,
+                                        hiod->aliased_devfn);
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
 }
-- 
MST


