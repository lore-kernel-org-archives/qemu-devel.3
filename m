Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D1BC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKps-0004Cq-8p; Mon, 14 Jul 2025 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUj-0000N5-2G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003cl-KS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd3C9KzXT1totXFmIEDcGz62Z1g1UAZ9zIVxyuiaV+E=;
 b=LQekRJMx8dgI2SDR8+yruX2bZNtq4NjtAQzSxLBQ6kLiN/zZzoSs5uevAhpokZuC6x2VkA
 731XqOPK8VgRQeq81JO20tpb1hpar+hxIhdJJNbGAwAVuNoS9JeILIqxEER12fKvtyr6g0
 aOB2FmBDPDezlM1qkr78Mn3UJdA/nIY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-8VPNdd6UN3qwUPPsjsyL2A-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: 8VPNdd6UN3qwUPPsjsyL2A-1
X-Mimecast-MFC-AGG-ID: 8VPNdd6UN3qwUPPsjsyL2A_1752500709
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E749B1808993
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC7A1956094
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D01321E65DF; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 27/32] qapi: add cross-references to virtio.json
Date: Mon, 14 Jul 2025 15:44:53 +0200
Message-ID: <20250714134458.2991097-28-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-17-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/virtio.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 2e23512085..b29c850eaf 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -137,7 +137,7 @@
 # @num-vqs: VirtIODevice virtqueue count.  This is the number of
 #     active virtqueues being used by the VirtIODevice.
 #
-# @status: VirtIODevice configuration status (VirtioDeviceStatus)
+# @status: VirtIODevice configuration status (`VirtioDeviceStatus`)
 #
 # @isr: VirtIODevice ISR
 #
@@ -579,7 +579,7 @@
 # .. qmp-example::
 #    :annotated:
 #
-#    Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#    Get `VirtQueueStatus` for virtio-vsock (vhost-vsock running)
 #    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
@@ -606,7 +606,7 @@
 # .. qmp-example::
 #    :annotated:
 #
-#    Get VirtQueueStatus for virtio-serial (no vhost)
+#    Get `VirtQueueStatus` for virtio-serial (no vhost)
 #    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
@@ -818,7 +818,7 @@
 #
 # @index: Index of the element in the queue
 #
-# @descs: List of descriptors (VirtioRingDesc)
+# @descs: List of descriptors (`VirtioRingDesc`)
 #
 # @avail: VRingAvail info
 #
-- 
2.49.0


