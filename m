Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AD3C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18ZZ-0004ub-JV; Mon, 31 Aug 2026 16:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18ZL-0003dD-5Z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18ZJ-0000HR-9A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pS3gWzM2OpSimpBSFZGIbBPCkdQIT5l3gW1iVRp02q8=;
 b=M0eZOr+XCGKErJ9zQ4JBGjQMHA15hOOrpBiCbGATp+4hX7hAbmqdiSIVFTAAIeUWWTpexB
 G3LZkluvu3DfFWUPk4L2L476bmkLaF9MnC/45K2GJaev4+Pin6mXrhEux37Oc8iSUi3bdF
 NG2Z+uBbzZAhGXQSgsV1dDHC0qSA00k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-uMc_VPINMpqQiIXR6qSURQ-1; Mon,
 31 Aug 2026 16:25:21 -0400
X-MC-Unique: uMc_VPINMpqQiIXR6qSURQ-1
X-Mimecast-MFC-AGG-ID: uMc_VPINMpqQiIXR6qSURQ_1788207918
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0335D18E6780; Mon, 31 Aug 2026 20:25:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D9EB1800347; Mon, 31 Aug 2026 20:25:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 37/43] qapi: convert trivial intro sections for virtio.json
Date: Mon, 31 Aug 2026 16:19:39 -0400
Message-ID: <20260831201945.287730-38-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/virtio.json | 54 ++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44d..9aafc3a212f 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -10,8 +10,7 @@
 
 ##
 # @VirtioInfo:
-#
-# Basic information about a given VirtIODevice
+#     Basic information about a given VirtIODevice
 #
 # @path: The VirtIODevice's canonical QOM path
 #
@@ -25,8 +24,7 @@
 
 ##
 # @x-query-virtio:
-#
-# Return a list of all realized VirtIODevices
+#     Return a list of all realized VirtIODevices
 #
 # Features:
 #
@@ -189,8 +187,7 @@
 
 ##
 # @x-query-virtio-status:
-#
-# Poll for a comprehensive status of a given virtio device
+#     Poll for a comprehensive status of a given virtio device
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
@@ -442,9 +439,8 @@
 
 ##
 # @VirtioDeviceStatus:
-#
-# A structure defined to list the configuration statuses of a virtio
-# device
+#     A structure defined to list the configuration statuses of a
+#     virtio device
 #
 # @statuses: List of decoded configuration statuses of the virtio
 #     device
@@ -460,9 +456,8 @@
 
 ##
 # @VhostDeviceProtocols:
-#
-# A structure defined to list the vhost user protocol features of a
-# Vhost User device
+#     A structure defined to list the vhost user protocol features of
+#     a Vhost User device
 #
 # @protocols: List of decoded vhost user protocol features of a vhost
 #     user device
@@ -503,9 +498,8 @@
 
 ##
 # @VirtQueueStatus:
-#
-# Information of a VirtIODevice VirtQueue, including most members of
-# the VirtQueue data structure.
+#     Information of a VirtIODevice VirtQueue, including most members
+#     of the VirtQueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -556,8 +550,7 @@
 
 ##
 # @x-query-virtio-queue-status:
-#
-# Return the status of a given VirtIODevice's VirtQueue
+#     Return the status of a given VirtIODevice's VirtQueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -640,9 +633,8 @@
 
 ##
 # @VirtVhostQueueStatus:
-#
-# Information of a vhost device's vhost_virtqueue, including most
-# members of the vhost_dev vhost_virtqueue data structure.
+#     Information of a vhost device's vhost_virtqueue, including most
+#     members of the vhost_dev vhost_virtqueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this vhost_virtqueue
 #
@@ -682,8 +674,7 @@
 
 ##
 # @x-query-virtio-vhost-queue-status:
-#
-# Return information of a given vhost device's vhost_virtqueue
+#     Return information of a given vhost device's vhost_virtqueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -746,8 +737,7 @@
 
 ##
 # @VirtioRingDesc:
-#
-# Information regarding the vring descriptor area
+#     Information regarding the vring descriptor area
 #
 # @addr: Guest physical address of the descriptor area
 #
@@ -797,9 +787,8 @@
 
 ##
 # @VirtioQueueElement:
-#
-# Information regarding a VirtQueue's VirtQueueElement including
-# descriptor, driver, and device areas
+#     Information regarding a VirtQueue's VirtQueueElement including
+#     descriptor, driver, and device areas
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -822,8 +811,7 @@
 
 ##
 # @x-query-virtio-queue-element:
-#
-# Return the information about a VirtQueue's VirtQueueElement
+#     Return the information about a VirtQueue's VirtQueueElement
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -933,8 +921,7 @@
 
 ##
 # @IOThreadVirtQueueMapping:
-#
-# Describes the subset of virtqueues assigned to an IOThread.
+#     Describes the subset of virtqueues assigned to an IOThread.
 #
 # @iothread: the id of IOThread object
 #
@@ -973,9 +960,8 @@
 
 ##
 # @DummyVirtioForceArrays:
-#
-# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList and
-# VirtIOGPUOutputList internally
+#     Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
+#     and VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
-- 
2.55.0


