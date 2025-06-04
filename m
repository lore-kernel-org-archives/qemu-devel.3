Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5109BC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 19:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMtf1-0006Sq-PJ; Wed, 04 Jun 2025 15:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMtez-0006Rq-J4
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 15:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMtex-0005sz-PN
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 15:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749064822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hk9SSSxsas0sroxMM243zhlTe0jMRs8H72vhMJtSxnM=;
 b=ewRJ+mBjj0DAUsaugPZpzhiRwwtd29S2y9U1Upnk3/LsDd+O51XvOUinPfdEAIjc93eIin
 BFj1ocI41gptLeGQDY1NHNAs/GL9klNgumJ/d169O0nrTN3qLdX64K1L3gGZAiPmZOaLru
 aOVGIlV9we7FfnH02yYuwjdcGo/kL+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-UZOI9sNgOjKXqsWNxeDB5Q-1; Wed,
 04 Jun 2025 15:20:18 -0400
X-MC-Unique: UZOI9sNgOjKXqsWNxeDB5Q-1
X-Mimecast-MFC-AGG-ID: UZOI9sNgOjKXqsWNxeDB5Q_1749064818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0991C1800A13; Wed,  4 Jun 2025 19:20:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.127])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAAA118002B1; Wed,  4 Jun 2025 19:20:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Date: Wed,  4 Jun 2025 15:18:43 -0400
Message-ID: <20250604191843.399309-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
used to zero local variables. While this reduces security risks
associated with uninitialized stack data, it introduced a measurable
bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
functions.

These virtqueue functions are in the hot path. They are called for each
element (request) that is popped from a VIRTIO device's virtqueue. Using
__attribute__((uninitialized)) on large stack variables in these
functions improves fio randread bs=4k iodepth=64 performance from 304k
to 332k IOPS (+9%).

This issue was found using perf-top(1). virtqueue_split_pop() was one of
the top CPU consumers and the "annotate" feature showed that the memory
zeroing instructions at the beginning of the functions were hot.

Fixes: 7ff9ff039380 ("meson: mitigate against use of uninitialize stack for exploits")
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/compiler.h | 12 ++++++++++++
 hw/virtio/virtio.c      |  8 ++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 496dac5ac1..fabd540b02 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -207,6 +207,18 @@
 # define QEMU_USED
 #endif
 
+/*
+ * Disable -ftrivial-auto-var-init on a local variable. Use this in rare cases
+ * when the compiler zeroes a large on-stack variable and this causes a
+ * performance bottleneck. Only use it when performance data indicates this is
+ * necessary since security risks increase with uninitialized stack variables.
+ */
+#if __has_attribute(uninitialized)
+# define QEMU_UNINITIALIZED __attribute__((uninitialized))
+#else
+# define QEMU_UNINITIALIZED
+#endif
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5534251e01..82a285a31d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1689,8 +1689,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num, elem_entries;
-    hwaddr addr[VIRTQUEUE_MAX_SIZE];
-    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    hwaddr QEMU_UNINITIALIZED addr[VIRTQUEUE_MAX_SIZE];
+    struct iovec QEMU_UNINITIALIZED iov[VIRTQUEUE_MAX_SIZE];
     VRingDesc desc;
     int rc;
 
@@ -1836,8 +1836,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num, elem_entries;
-    hwaddr addr[VIRTQUEUE_MAX_SIZE];
-    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    hwaddr QEMU_UNINITIALIZED addr[VIRTQUEUE_MAX_SIZE];
+    struct iovec QEMU_UNINITIALIZED iov[VIRTQUEUE_MAX_SIZE];
     VRingPackedDesc desc;
     uint16_t id;
     int rc;
-- 
2.49.0


