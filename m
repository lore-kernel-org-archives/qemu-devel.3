Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D4E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRhQ-00068d-F2; Wed, 08 Jan 2025 03:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRhC-00065U-ML
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRhA-0001nc-Rf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYHlcJbTr0/V2iNPBkpTr9ob79LPTB305bDHNna+5oE=;
 b=dJ/Jy1QMFfInDbU26uSuu3WrNv77nauJUfTSxb1RDTxZqkCgKWp5+g+BjANJl/GIMexTWa
 GduaG4gUcSpm76+o10OjJDZwZaalyMn5V94ZGdABOZV5yYZ8cISPcYo1fDMMMAQGc8GBC5
 FMW2gGeMixh1jPcimhHNCG/H2t2cG9A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-BK1FVxAMOkGlMlYt7rBdTg-1; Wed,
 08 Jan 2025 03:45:40 -0500
X-MC-Unique: BK1FVxAMOkGlMlYt7rBdTg-1
X-Mimecast-MFC-AGG-ID: BK1FVxAMOkGlMlYt7rBdTg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740DB19153C3; Wed,  8 Jan 2025 08:45:39 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC90419560AA; Wed,  8 Jan 2025 08:45:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 11/14] hw/s390x: Remove the "adapter_routes_max_batch" property
 from the flic
Date: Wed,  8 Jan 2025 09:45:08 +0100
Message-ID: <20250108084511.238458-12-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Now that the s390-ccw-virtio-2.8 machine has been removed, we don't
need the "adapter_routes_max_batch" property anymore and can remove it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20250103144232.520383-11-thuth@redhat.com>
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


