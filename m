Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09919C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidZ9-0001it-VG; Thu, 13 Feb 2025 13:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWf-000815-03
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWY-0006Tr-Mv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739469676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMYIEGQHBR7kVZ6dwpXdf7eKddEm5uclGvqlO6VoOok=;
 b=gsiLRVNMyvwoORBv2nciswEusmYJddX5Pro3I+FJppmEhXGau74os+5Qle0QKoG6aWtN6L
 tyeL6y0LNrbcNKFCkLkEnO8pG7TTzUJx469Fk8S1tDjHKmIvq8VicKgrOUvHOwhT784OZn
 p4Aes43tVsNIZkA9sCz0/JFFbx6oWxU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-3ch1yV5TNpu1sELZAmFdyA-1; Thu,
 13 Feb 2025 13:01:10 -0500
X-MC-Unique: 3ch1yV5TNpu1sELZAmFdyA-1
X-Mimecast-MFC-AGG-ID: 3ch1yV5TNpu1sELZAmFdyA_1739469669
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462E3180036F; Thu, 13 Feb 2025 18:01:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99129300018D; Thu, 13 Feb 2025 18:01:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 08/12] virtio-blk: extract cleanup_iothread_vq_mapping()
 function
Date: Thu, 13 Feb 2025 13:00:39 -0500
Message-ID: <20250213180043.713434-9-stefanha@redhat.com>
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/block/virtio-blk.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1829e3abd..9af8c51af0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1485,6 +1485,9 @@ validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
  * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
  *
+ * cleanup_iothread_vq_mapping() must be called to free IOThread object
+ * references after this function returns success.
+ *
  * Returns: %true on success, %false on failure.
  **/
 static bool apply_iothread_vq_mapping(
@@ -1535,6 +1538,23 @@ static bool apply_iothread_vq_mapping(
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
@@ -1601,12 +1621,7 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
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


