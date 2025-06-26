Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E32C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJh-0005A6-Qs; Thu, 26 Jun 2025 03:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJb-0004uM-Kq
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJZ-0001zm-Jq
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwrYbNhZkajaewKca5Og/0GorUd7Ik/9Cud+ESMPAxA=;
 b=LY4NNxAK3amSNqjywCR7YkymwryLL/hToMNRA+MM59jE1gqsoLHIZ9WJYOiOuUW8CsuCco
 NxYrG+6FaaUuYk2i7qzdb5h3TfELaVJfrN1Zqbz2nvzs2/kavfUnk/9stIVDGxO3ywqrh4
 S3Hmq0bTWBET+fn8dQzfk6IlOLb+UYA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-yhnMQZoeP-aYKDBAr6-rbQ-1; Thu,
 26 Jun 2025 03:46:27 -0400
X-MC-Unique: yhnMQZoeP-aYKDBAr6-rbQ-1
X-Mimecast-MFC-AGG-ID: yhnMQZoeP-aYKDBAr6-rbQ_1750923986
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EEDE1800268; Thu, 26 Jun 2025 07:46:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83FDD180045B; Thu, 26 Jun 2025 07:46:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/25] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Thu, 26 Jun 2025 09:45:22 +0200
Message-ID: <20250626074529.1384114-19-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-13-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 18 ++++++++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index 619c0f3140650599f930eddeb6d8a4a9ebf10b97..d183a3950e26ea1defac870509265cdfe57a4026 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,6 +17,8 @@
 bool vfio_user_get_device_info(VFIOUserProxy *proxy,
                                struct vfio_device_info *info, Error **errp);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index f01b3925c5a5a22cd8f55303d48b36d9dface54c..3a118e73615a40d5d455dfb379115be66726627a 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -54,6 +54,24 @@ bool vfio_user_get_device_info(VFIOUserProxy *proxy,
     return true;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
+{
+    Error *local_err = NULL;
+    VFIOUserHdr hdr;
+
+    vfio_user_request_msg(&hdr, VFIO_USER_DEVICE_RESET, sizeof(hdr), 0);
+
+    if (!vfio_user_send_wait(proxy, &hdr, NULL, 0, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return;
+    }
+
+    if (hdr.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", hdr.error_reply);
+    }
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c0f00f15b10a80820606ff4ef0383d59ecd91670..49d12763aba73f780ec5b202dfd4d3dc98837491 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -263,6 +263,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -310,6 +324,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
-- 
2.49.0


