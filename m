Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74607C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzeS-0003e4-6I; Tue, 11 Mar 2025 09:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdS-0002Ol-D5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdQ-0005GL-F0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEAblqs+/QeL64NIpBD9nW8zWVA/2GdqUlR+17Zc9i4=;
 b=JN5x/aXBDeZnnNZDqokQKO/GPlIzDEBjkB97K83AojercHqW9HAloMbMSe/hk9Y9eZkCPT
 freYXm8bXglYeDp/MHw/M5nFFsAKu8J4d87gqFlk+Pw9+L1pdjFPz2eCgz54szj9FewHA1
 VorngtR1tOO3BbioJzRYdtkXdCp7e+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-kGSmP0wyMMmia9dXoFBmqA-1; Tue,
 11 Mar 2025 09:27:01 -0400
X-MC-Unique: kGSmP0wyMMmia9dXoFBmqA-1
X-Mimecast-MFC-AGG-ID: kGSmP0wyMMmia9dXoFBmqA_1741699620
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E061C18001E2; Tue, 11 Mar 2025 13:26:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18788195608F; Tue, 11 Mar 2025 13:26:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 08/13] virtio-blk: extract cleanup_iothread_vq_mapping()
 function
Date: Tue, 11 Mar 2025 21:26:11 +0800
Message-ID: <20250311132616.1049687-9-stefanha@redhat.com>
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is the cleanup function that must be called after
apply_iothread_vq_mapping() succeeds. virtio-scsi will need this
function too, so extract it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 5135b4d8f1..21b1b768ed 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1495,6 +1495,9 @@ validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
  * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
  *
+ * cleanup_iothread_vq_mapping() must be called to free IOThread object
+ * references after this function returns success.
+ *
  * Returns: %true on success, %false on failure.
  **/
 static bool apply_iothread_vq_mapping(
@@ -1545,6 +1548,23 @@ static bool apply_iothread_vq_mapping(
     return true;
 }
 
+/**
+ * cleanup_iothread_vq_mapping:
+ * @list: The mapping of virtqueues to IOThreads.
+ *
+ * Release IOThread object references that were acquired by
+ * apply_iothread_vq_mapping().
+ */
+static void cleanup_iothread_vq_mapping(IOThreadVirtQueueMappingList *list)
+{
+    IOThreadVirtQueueMappingList *node;
+
+    for (node = list; node; node = node->next) {
+        IOThread *iothread = iothread_by_id(node->value->iothread);
+        object_unref(OBJECT(iothread));
+    }
+}
+
 /* Context: BQL held */
 static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 {
@@ -1611,12 +1631,7 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        IOThreadVirtQueueMappingList *node;
-
-        for (node = conf->iothread_vq_mapping_list; node; node = node->next) {
-            IOThread *iothread = iothread_by_id(node->value->iothread);
-            object_unref(OBJECT(iothread));
-        }
+        cleanup_iothread_vq_mapping(conf->iothread_vq_mapping_list);
     }
 
     if (conf->iothread) {
-- 
2.48.1


