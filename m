Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBD3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3sK-0002D4-Lk; Tue, 07 Jul 2026 07:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sI-0002Ch-NU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sH-0002pU-91
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783423319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRrs0HRsKSbo6dcjE3r/xJZpFw5kDBz3/cHORzsSx/w=;
 b=TdrcWR70yLmORsxFab+6GBiknkknlAS4nzadUx9I8Fh0aHslz4NwfQ61R4Rnxjb1JW47l7
 V0xj3OmBZxfgzvOVxR+0UVK/phsAG85l/kr+cxR8GY5sFsh4Tgr9Fd86yOvuSwxhhozNAy
 xBlfxysZnGdnH7f2dHjZO55k2VDylxQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97--Njy3vM5OEqv0efZx9JdOw-1; Tue,
 07 Jul 2026 07:21:58 -0400
X-MC-Unique: -Njy3vM5OEqv0efZx9JdOw-1
X-Mimecast-MFC-AGG-ID: -Njy3vM5OEqv0efZx9JdOw_1783423317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56B1D1954AEC
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:21:57 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3731E1800747; Tue,  7 Jul 2026 11:21:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 1/2] virtio: add shmem map transaction wrappers
Date: Tue,  7 Jul 2026 13:21:48 +0200
Message-ID: <20260707112149.2867886-2-aesteve@redhat.com>
In-Reply-To: <20260707112149.2867886-1-aesteve@redhat.com>
References: <20260707112149.2867886-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Introduce virtio_add_shmem_map_start() and virtio_add_shmem_map_end()
as wrappers around memory_region_transaction_begin() and
memory_region_transaction_commit(). This keeps memory subsystem calls
out of vhost-user.c and gives the transaction pair a name that reflects
its purpose: delaying the commit until after a reply has been sent to
the vhost-user backend.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c     |  6 +++---
 hw/virtio/virtio.c         | 10 ++++++++++
 include/hw/virtio/virtio.h | 17 +++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 517cc4ca71..f6bf9e0ba4 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1977,7 +1977,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         }
     }
 
-    memory_region_transaction_begin();
+    virtio_add_shmem_map_start();
 
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
@@ -2004,11 +2004,11 @@ send_reply_commit:
         hdr->size = sizeof(payload->u64);
         if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
             error_report_err(local_err);
-            memory_region_transaction_commit();
+            virtio_add_shmem_map_end();
             return -EFAULT;
         }
     }
-    memory_region_transaction_commit();
+    virtio_add_shmem_map_end();
     return 0;
 
 send_reply:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..e604781ffe 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3226,6 +3226,16 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
     return mapping;
 }
 
+void virtio_add_shmem_map_start(void)
+{
+    memory_region_transaction_begin();
+}
+
+void virtio_add_shmem_map_end(void)
+{
+    memory_region_transaction_commit();
+}
+
 int virtio_add_shmem_map(VirtioSharedMemory *shmem,
                          VirtioSharedMemoryMapping *mapping)
 {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d88..9935452486 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -390,6 +390,23 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
                                                             uint64_t len,
                                                             bool allow_write);
 
+/**
+ * virtio_add_shmem_map_start() - Begin a shmem map transaction
+ *
+ * Begins a transaction to add a shared memory mapping. Call this before adding
+ * a shared memory mapping when the commit must be delayed until after a reply
+ * is sent to a vhost-user backend.
+ */
+void virtio_add_shmem_map_start(void);
+
+/**
+ * virtio_add_shmem_map_end() - End a shmem map transaction
+ *
+ * Completes the transaction started by virtio_add_shmem_map_start() and makes
+ * the mapping visible to the guest.
+ */
+void virtio_add_shmem_map_end(void);
+
 /**
  * virtio_add_shmem_map() - Add a memory mapping to a shared region
  * @shmem: VirtioSharedMemory region
-- 
2.54.0


