Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE6DC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1Tt-00089b-Mt; Fri, 02 Feb 2024 16:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tr-00089D-QK
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tq-0004qc-EL
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTB8Ez+mNhMI/GF/L0T5BLMye43WSG0TKmO8bVZtESY=;
 b=MEp8tcjFQojdxNzg/dHtg4tGMnVxcuYGURspN0LZZxH3Ip7sXKkQ0taMwvoxtShGaH43fL
 Rnk3J1pBFath+TqfPgaQmPmgpsrRxP3TlHd371RiwuKDqh87w0mwH/4jjQ5iPhiZ8JtHgS
 f4QwszcsnmZLVDotTHY3vqQNLhxjcyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-pLyTJv4aOo22QirFJ4xkFA-1; Fri, 02 Feb 2024 16:53:46 -0500
X-MC-Unique: pLyTJv4aOo22QirFJ4xkFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAF78867944;
 Fri,  2 Feb 2024 21:53:45 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA8CD2166B31;
 Fri,  2 Feb 2024 21:53:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 02/15] libvhost-user: Dynamically allocate memory for
 memory slots
Date: Fri,  2 Feb 2024 22:53:19 +0100
Message-ID: <20240202215332.118728-3-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's prepare for increasing VHOST_USER_MAX_RAM_SLOTS by dynamically
allocating dev->regions. We don't have any ABI guarantees (not
dynamically linked), so we can simply change the layout of VuDev.

Let's zero out the memory, just as we used to do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 7e515ed15d..8a5a7a2295 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2171,6 +2171,8 @@ vu_deinit(VuDev *dev)
 
     free(dev->vq);
     dev->vq = NULL;
+    free(dev->regions);
+    dev->regions = NULL;
 }
 
 bool
@@ -2205,9 +2207,18 @@ vu_init(VuDev *dev,
     dev->backend_fd = -1;
     dev->max_queues = max_queues;
 
+    dev->regions = malloc(VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+    if (!dev->regions) {
+        DPRINT("%s: failed to malloc mem regions\n", __func__);
+        return false;
+    }
+    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
     if (!dev->vq) {
         DPRINT("%s: failed to malloc virtqueues\n", __func__);
+        free(dev->regions);
+        dev->regions = NULL;
         return false;
     }
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index c2352904f0..c882b4e3a2 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -398,7 +398,7 @@ typedef struct VuDevInflightInfo {
 struct VuDev {
     int sock;
     uint32_t nregions;
-    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
+    VuDevRegion *regions;
     VuVirtq *vq;
     VuDevInflightInfo inflight_info;
     int log_call_fd;
-- 
2.43.0


