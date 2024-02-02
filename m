Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA2C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1UH-0008JG-Pz; Fri, 02 Feb 2024 16:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UF-0008GA-T4
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UE-0004uj-Ft
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYZZpUJmqSm7TaL0kZhutM5lwJZW8aorfX8+7PRkcLU=;
 b=Qu6Ygyn7NV6usz8cNyO5fk/GLcKPXaC+vjw9jvOUVTWXdgmbTo85gOIPP1r6pI9UpKFsJo
 q3Aw8ra5bX7UlCiHXLXn+b4eOTT8oUHKPlJd5j3F3jrOLY/rLsSi2a4xSvh8QLf/73r/rB
 w6XQZSZ0hYo7miTB3fdgyfdRYAC62L4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-SjDiPhsEOSC94M_ChOaHMw-1; Fri, 02 Feb 2024 16:54:10 -0500
X-MC-Unique: SjDiPhsEOSC94M_ChOaHMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 687B7101A526;
 Fri,  2 Feb 2024 21:54:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A2292166B31;
 Fri,  2 Feb 2024 21:54:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 13/15] libvhost-user: Factor out vq usability check
Date: Fri,  2 Feb 2024 22:53:30 +0100
Message-ID: <20240202215332.118728-14-david@redhat.com>
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

Let's factor it out to prepare for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 7d8293dc84..febeb2eb89 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -283,6 +283,12 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static bool
+vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
+{
+    return likely(!dev->broken) && likely(vq->vring.avail);
+}
+
 static size_t
 get_fd_pagesize(int fd)
 {
@@ -2378,8 +2384,7 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
     idx = vq->last_avail_idx;
 
     total_bufs = in_total = out_total = 0;
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         goto done;
     }
 
@@ -2494,8 +2499,7 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
 bool
 vu_queue_empty(VuDev *dev, VuVirtq *vq)
 {
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return true;
     }
 
@@ -2534,8 +2538,7 @@ vring_notify(VuDev *dev, VuVirtq *vq)
 
 static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
 {
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
@@ -2860,8 +2863,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     unsigned int head;
     VuVirtqElement *elem;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return NULL;
     }
 
@@ -3018,8 +3020,7 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
 {
     struct vring_used_elem uelem;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
@@ -3048,8 +3049,7 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int count)
 {
     uint16_t old, new;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
-- 
2.43.0


