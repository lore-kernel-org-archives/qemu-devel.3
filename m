Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA958E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTitX-0002jp-EZ; Fri, 03 Jan 2025 09:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitU-0002h0-Sl
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitS-0007Gw-49
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ib/uRa6H30lofyH3Kg7Wl61++ATqdVSIXhJ1SrcKdWo=;
 b=JelCivCG0/NajBEy1T6yHTNhWwmrc2JFDtUIhG+1vtXo07r6/sHON3h5omJnLVlz3pEx+D
 6ULy0QRHSM1ZXXugCpezwYSHamhGcbjlHd/2iwT349AxefqpgTDVWPyOy6IwMARKlh2Q0f
 gigWik5+TOmafmSgIJsYR/yyPvX3ToA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-zoxlNAEHMBqEZdg92Ca9Mg-1; Fri,
 03 Jan 2025 09:43:16 -0500
X-MC-Unique: zoxlNAEHMBqEZdg92Ca9Mg-1
X-Mimecast-MFC-AGG-ID: zoxlNAEHMBqEZdg92Ca9Mg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B7D719560A5; Fri,  3 Jan 2025 14:43:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2C193000197; Fri,  3 Jan 2025 14:43:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 10/10] hw/s390x: Remove the "adapter_routes_max_batch"
 property from the flic
Date: Fri,  3 Jan 2025 15:42:32 +0100
Message-ID: <20250103144232.520383-11-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the s390-ccw-virtio-2.8 machine has been removed, we don't
need the "adapter_routes_max_batch" property anymore and can remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390_flic.h | 2 --
 hw/intc/s390_flic.c          | 9 ---------
 hw/s390x/virtio-ccw.c        | 5 ++---
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 4d66c5e42e..85016d5ccc 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -41,8 +41,6 @@ OBJECT_DECLARE_TYPE(S390FLICState, S390FLICStateClass,
 
 struct S390FLICState {
     SysBusDevice parent_obj;
-    /* to limit AdapterRoutes.num_routes for compat */
-    uint32_t adapter_routes_max_batch;
     bool ais_supported;
     bool migration_enabled;
 };
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 3f3fa939d3..c20f4c1075 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -471,8 +471,6 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
 }
 
 static const Property s390_flic_common_properties[] = {
-    DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
-                       adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
     DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
                      migration_enabled, true),
 };
@@ -480,13 +478,6 @@ static const Property s390_flic_common_properties[] = {
 static void s390_flic_common_realize(DeviceState *dev, Error **errp)
 {
     S390FLICState *fs = S390_FLIC_COMMON(dev);
-    uint32_t max_batch = fs->adapter_routes_max_batch;
-
-    if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
-        error_setg(errp, "flic property adapter_routes_max_batch too big"
-                   " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
-        return;
-    }
 
     fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 7cbce4766a..43f3b162c8 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1157,7 +1157,6 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
     CcwDevice *ccw_dev = CCW_DEVICE(d);
     SubchDev *sch = ccw_dev->sch;
     int n = virtio_get_num_queues(vdev);
-    S390FLICState *flic = s390_get_flic();
 
     if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         dev->max_rev = 0;
@@ -1184,10 +1183,10 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
                    VIRTIO_QUEUE_MAX);
         return;
     }
-    if (virtio_get_num_queues(vdev) > flic->adapter_routes_max_batch) {
+    if (virtio_get_num_queues(vdev) > ADAPTER_ROUTES_MAX_GSI) {
         error_setg(errp, "The number of virtqueues %d "
                    "exceeds flic adapter route limit %d", n,
-                   flic->adapter_routes_max_batch);
+                   ADAPTER_ROUTES_MAX_GSI);
         return;
     }
 
-- 
2.47.1


