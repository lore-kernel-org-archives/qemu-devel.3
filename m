Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024DC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1Tx-0008CI-RY; Fri, 02 Feb 2024 16:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tw-0008C8-K8
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tv-0004r9-8G
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnD1WbeLBV3hwUM53n89RabIQheGwulLSgdIZsqwAE4=;
 b=XHquorGSh1xpZ+3HUNJhSlVZPlUEauWQ1BR+26A5c3mBv2Vg6VYPikjAKazuBfCDlQ04Zn
 Z0rlZpmAzqYPNXCOesKOvOVt+T12NnKes+7m2Uua4bAO2crCKUP41zIj7zzxSyzmUZqwDF
 EeXsrsWR+Cr7CtBGedtAN/CVQOg7QRE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-9urfckw3ML6wLm4ccBagpw-1; Fri,
 02 Feb 2024 16:53:51 -0500
X-MC-Unique: 9urfckw3ML6wLm4ccBagpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B54C63C0ED43;
 Fri,  2 Feb 2024 21:53:50 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3DE2166B31;
 Fri,  2 Feb 2024 21:53:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 04/15] libvhost-user: Factor out removing all mem regions
Date: Fri,  2 Feb 2024 22:53:21 +0100
Message-ID: <20240202215332.118728-5-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's factor it out. Note that the check for MAP_FAILED was wrong as
we never set mmap_addr if mmap() failed. We'll remove the NULL check
separately.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 34 ++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8a5a7a2295..d5b3468e43 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -240,6 +240,22 @@ qva_to_va(VuDev *dev, uint64_t qemu_addr)
     return NULL;
 }
 
+static void
+vu_remove_all_mem_regs(VuDev *dev)
+{
+    unsigned int i;
+
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+        void *ma = (void *)(uintptr_t)r->mmap_addr;
+
+        if (ma) {
+            munmap(ma, r->size + r->mmap_offset);
+        }
+    }
+    dev->nregions = 0;
+}
+
 static void
 vmsg_close_fds(VhostUserMsg *vmsg)
 {
@@ -1003,14 +1019,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int i;
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
 
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-        void *ma = (void *) (uintptr_t) r->mmap_addr;
-
-        if (ma) {
-            munmap(ma, r->size + r->mmap_offset);
-        }
-    }
+    vu_remove_all_mem_regs(dev);
     dev->nregions = memory->nregions;
 
     if (dev->postcopy_listening) {
@@ -2112,14 +2121,7 @@ vu_deinit(VuDev *dev)
 {
     unsigned int i;
 
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-        void *m = (void *) (uintptr_t) r->mmap_addr;
-        if (m != MAP_FAILED) {
-            munmap(m, r->size + r->mmap_offset);
-        }
-    }
-    dev->nregions = 0;
+    vu_remove_all_mem_regs(dev);
 
     for (i = 0; i < dev->max_queues; i++) {
         VuVirtq *vq = &dev->vq[i];
-- 
2.43.0


