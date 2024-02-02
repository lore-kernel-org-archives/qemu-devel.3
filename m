Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626A1C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1U4-0008E5-JR; Fri, 02 Feb 2024 16:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1U3-0008DN-AA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1U1-0004tF-PD
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiM3izwPA+L0qhccpaX2lE+3batb7kEf/yeHcfoCS8E=;
 b=Cl37GK+kyRlcq54KEWzSWVNO17ux8DOZaTji04jQhrzWKZO4iyJVwt4+Yb1FmiJmHT5gq6
 9NUlIvwpjsZJ5xlkaC1yDWwBCE9fQWB+EU4Z68JQ0NGiMMMxXmodRM2jQCDT9xhFREW3CG
 TQrvXVNGg3n6C/E1fAUoitCgQ+l6F8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-l0-zmGLHMY2YWwUJQmbZSQ-1; Fri, 02 Feb 2024 16:53:59 -0500
X-MC-Unique: l0-zmGLHMY2YWwUJQmbZSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18622800074;
 Fri,  2 Feb 2024 21:53:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7700E2166B31;
 Fri,  2 Feb 2024 21:53:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 08/15] libvhost-user: Don't zero out memory for memory
 regions
Date: Fri,  2 Feb 2024 22:53:25 +0100
Message-ID: <20240202215332.118728-9-david@redhat.com>
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

dev->nregions always covers only valid entries. Stop zeroing out other
array elements that are unused.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index f99c888b48..e1a1b9df88 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -888,13 +888,9 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
 
             munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
-            /*
-             * Shift all affected entries by 1 to close the hole at index i and
-             * zero out the last entry.
-             */
+            /* Shift all affected entries by 1 to close the hole at index. */
             memmove(dev->regions + i, dev->regions + i + 1,
                     sizeof(VuDevRegion) * (dev->nregions - i - 1));
-            memset(dev->regions + dev->nregions - 1, 0, sizeof(VuDevRegion));
             DPRINT("Successfully removed a region\n");
             dev->nregions--;
             i--;
@@ -2119,7 +2115,6 @@ vu_init(VuDev *dev,
         DPRINT("%s: failed to malloc mem regions\n", __func__);
         return false;
     }
-    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
 
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
     if (!dev->vq) {
-- 
2.43.0


