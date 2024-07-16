Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA80C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTklc-0002PF-D5; Tue, 16 Jul 2024 12:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTklS-0001sf-ON
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:10:56 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTklQ-0002wx-Mx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721146252; x=1752682252;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Xz4aX8dBW2vbxRdbOQqpj1yin6IORC1tzbkn3pSN2EE=;
 b=OKhMw1ZtSH2jlgIaJPmdnhfE7KNovWxGYmRpiYVu2jSP/wpbMDlBqf1b
 +r42cR1+9lqmO9dbkcPZPE5RTAKWsdPbWzSpvz79dcYz7cElRQ8vkslgQ
 F4kxNRqot17WzDSEFS+D34+hswTMQQAEvJlPVXT87UfS/BDhPhQDgl57z
 4g/mBdzxQKEo71bAgi6i0RuzpvRs/ljWCdBO45Jzd26y1JEQfik+fCK44
 E7WkKOqJ0DwH5VPRy6oYF49qLpocfOP5Z+qBSEO6vj9D85AYnNDCwnZ8E
 0ztGysuSQeQesXZrp7iJUUrrYoEZ/L542FVN+EnSCXUeqOwmWmcvoSnnx Q==;
X-CSE-ConnectionGUID: WAVyj2XpSIGrvFyK9cK5Bw==
X-CSE-MsgGUID: vwAkZaHhR9yAssQ6c6tIPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22410115"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="22410115"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 09:10:51 -0700
X-CSE-ConnectionGUID: xDl6QyBIRiCHGF6s/4TjFw==
X-CSE-MsgGUID: K7hEYVqHR46B6UVcjecPTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="49940499"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 16 Jul 2024 09:10:50 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
Date: Wed, 17 Jul 2024 00:26:15 +0800
Message-Id: <20240716162615.271010-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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
Cc: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v2:
 * Added a/b from Eugenio.
 * Deleted unnecessary ERRP_GUARD(). (Eugenio)
---
 hw/virtio/vdpa-dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 64b96b226c39..8a1e16fce3de 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -63,19 +63,19 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
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
 
@@ -89,7 +89,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
 
     v->num_queues = vhost_vdpa_device_get_u32(v->vhostfd,
                                               VHOST_VDPA_GET_VQS_COUNT, errp);
-    if (*errp) {
+    if (v->num_queues < 0) {
         goto out;
     }
 
@@ -127,7 +127,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     v->config_size = vhost_vdpa_device_get_u32(v->vhostfd,
                                                VHOST_VDPA_GET_CONFIG_SIZE,
                                                errp);
-    if (*errp) {
+    if (v->config_size < 0) {
         goto vhost_cleanup;
     }
 
-- 
2.34.1


