Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B46C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIFq-0002ZR-Sj; Mon, 15 Jul 2024 05:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFp-0002VX-Bc
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:21 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFm-0005Pt-Lb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721036658; x=1752572658;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b5fT2v6rIKplI18OrZw/uOoTUXfEtQLspwPgsQjq34Y=;
 b=Gt2qhKtdPA+nQBZyhE3XjnIGUEnJeD5wdnhdh26koWLNuQWQYklwHE59
 NQnY88w+AscXfcExB0jlTsQZtb5llL1PfpzcznC0qY1JGIzMBSaNIoHS9
 Jqa6ku8wefhN2ddddsPLdsYe+j4VAcZ1XasY8v9tYEsp2eI6UgzvrWJA5
 BjoyLlOX3a1sjwTs1JteYRKnO70s51N7LLujdVKu33RtW6HXXt+fuy1ep
 wc2qspVXr023B+1RpEwR36QLo1znRPgpRhq5q+em0R0+uponN9WpZ8Kzd
 4MMOAPUrmBzVitQmKEI9dGHo7vTrdCOzEbT4yVVkn4ImOgewu1GifcYDT Q==;
X-CSE-ConnectionGUID: 00bEJPwlQu+pYLQaRsQAkg==
X-CSE-MsgGUID: h2f+imAvR7KHcr2o1K1EWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35837078"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="35837078"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 02:44:18 -0700
X-CSE-ConnectionGUID: 2Lb3z7IbSjiriednDYeVrw==
X-CSE-MsgGUID: GL/0xjgnRLWlCBqUEJe41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="53854612"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2024 02:44:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
Date: Mon, 15 Jul 2024 17:59:38 +0800
Message-Id: <20240715095939.72492-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715095939.72492-1-zhao1.liu@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

Though vhost_vdpa_device_realize() is called at DeviceClass.realize()
context and won't get NULL @errp, it's still better to follow the
requirement to add the ERRP_GUARD().

But qemu_open() and vhost_vdpa_device_get_u32()'s return values can
distinguish between successful and unsuccessful calls, so check the
return values directly without dereferencing @errp, which eliminates
the need of ERRP_GUARD().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/virtio/vdpa-dev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 64b96b226c39..7b439efdc1d3 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -50,6 +50,7 @@ vhost_vdpa_device_get_u32(int fd, unsigned long int cmd, Error **errp)
 
 static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VhostVdpaDevice *v = VHOST_VDPA_DEVICE(vdev);
     struct vhost_vdpa_iova_range iova_range;
@@ -63,19 +64,19 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     }
 
     v->vhostfd = qemu_open(v->vhostdev, O_RDWR, errp);
-    if (*errp) {
+    if (v->vhostfd < 0) {
         return;
     }
 
     v->vdev_id = vhost_vdpa_device_get_u32(v->vhostfd,
                                            VHOST_VDPA_GET_DEVICE_ID, errp);
-    if (*errp) {
+    if (v->vdev_id < 0) {
         goto out;
     }
 
     max_queue_size = vhost_vdpa_device_get_u32(v->vhostfd,
                                                VHOST_VDPA_GET_VRING_NUM, errp);
-    if (*errp) {
+    if (max_queue_size < 0) {
         goto out;
     }
 
@@ -89,7 +90,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
 
     v->num_queues = vhost_vdpa_device_get_u32(v->vhostfd,
                                               VHOST_VDPA_GET_VQS_COUNT, errp);
-    if (*errp) {
+    if (v->num_queues < 0) {
         goto out;
     }
 
@@ -127,7 +128,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     v->config_size = vhost_vdpa_device_get_u32(v->vhostfd,
                                                VHOST_VDPA_GET_CONFIG_SIZE,
                                                errp);
-    if (*errp) {
+    if (v->config_size < 0) {
         goto vhost_cleanup;
     }
 
-- 
2.34.1


