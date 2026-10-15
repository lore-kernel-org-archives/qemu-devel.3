Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252D1CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSS-0002rL-KF; Thu, 15 Oct 2026 08:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSP-0002pV-FG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSN-0005Ik-4R
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhu6POVbLjiJYuxmQ4vtpr/w3/Vjw8wZhr0borEHm1g=;
 b=ZxtOWbauq8Xm13C+fDh2U2hRqDeNY42h+2Ahojgt3x0DYKQmrVy16qOk89StWFdMKkIqbd
 3TrDuMoN2ZOFA2ZM3lKioSrNgAuSB7EYWGIOLIDdpH5ahaokmE9NFLqI3E9JTgSygD0qda
 S+XWC9H1NOVzbpwOnMrE8kNxVS+xlIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-ZzktSK-SPJmHyLgN6j8KMg-1; Thu,
 15 Oct 2026 12:21:09 +0000
X-MC-Unique: ZzktSK-SPJmHyLgN6j8KMg-1
X-Mimecast-MFC-AGG-ID: ZzktSK-SPJmHyLgN6j8KMg_1792066868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 064221955BD0; Thu, 15 Oct 2026 12:21:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94EA6180057F; Thu, 15 Oct 2026 12:21:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tushar Dave <tdave@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/8] hw/vfio: thread vf-token through iommufd bind
Date: Thu, 15 Oct 2026 14:20:52 +0200
Message-ID: <20261015122055.888209-6-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tushar Dave <tdave@nvidia.com>

A VF fails to bind through the iommufd/cdev backend when its PF is
bound to vfio-pci and requires a matching VF token.

QEMU currently initializes struct vfio_device_bind_iommufd without
the token flag or token UUID.

Pass the existing vf-token device property to the IOMMUFD bind ioctl
for PCI devices.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260908160731.1658621-1-tdave@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 242644aa0010cd5af817a5d451308d730bc0daa4..de482128bf1bda6f2f7cdc35afa4621da6c29b4f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -155,6 +155,7 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
 
 static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 {
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     struct vfio_device_bind_iommufd bind = {
         .argsz = sizeof(bind),
@@ -180,6 +181,15 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
+
+    /*
+     * Pass the VF token when binding a PCI device.
+     */
+    if (vdev && !qemu_uuid_is_null(&vdev->vf_token)) {
+        bind.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
+        bind.token_uuid_ptr = (uintptr_t)&vdev->vf_token;
+    }
+
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
         error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
                          vbasedev->fd, bind.iommufd);
-- 
2.56.0


