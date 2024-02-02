Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E50C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1U4-0008EC-VQ; Fri, 02 Feb 2024 16:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1U3-0008DK-5I
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1U1-0004tD-MV
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Xz/DNogoDrAuG8jKm4UbtdAbPzzBhEQKM/Cy3B57Pw=;
 b=GFp+Dwe/m4iPorFbt2VBWyZF/EJQPX2rKhWZfIGBhEZgMW75mOWfP7u06HpTBQecXqOplr
 D0iNBpPc/PjIwN7UDCRTCeGx9/Vx7hzMjIkQl0bKxS+fqm+3u7R262mz/i5CvtYms8UeK/
 VKJUVXXq6JJ9SH0jYakN882rR9UbAsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-kwvOuFcxPzWBtZevY2vGoQ-1; Fri, 02 Feb 2024 16:53:57 -0500
X-MC-Unique: kwvOuFcxPzWBtZevY2vGoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16AC5800074;
 Fri,  2 Feb 2024 21:53:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7192166B31;
 Fri,  2 Feb 2024 21:53:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 07/15] libvhost-user: No need to check for NULL when
 unmapping
Date: Fri,  2 Feb 2024 22:53:24 +0100
Message-ID: <20240202215332.118728-8-david@redhat.com>
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

We never add a memory region if mmap() failed. Therefore, no need to check
for NULL.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a2baefe84b..f99c888b48 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -247,11 +247,8 @@ vu_remove_all_mem_regs(VuDev *dev)
 
     for (i = 0; i < dev->nregions; i++) {
         VuDevRegion *r = &dev->regions[i];
-        void *ma = (void *)(uintptr_t)r->mmap_addr;
 
-        if (ma) {
-            munmap(ma, r->size + r->mmap_offset);
-        }
+        munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
     }
     dev->nregions = 0;
 }
@@ -888,11 +885,8 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     for (i = 0; i < dev->nregions; i++) {
         if (reg_equal(&dev->regions[i], msg_region)) {
             VuDevRegion *r = &dev->regions[i];
-            void *ma = (void *) (uintptr_t) r->mmap_addr;
 
-            if (ma) {
-                munmap(ma, r->size + r->mmap_offset);
-            }
+            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
             /*
              * Shift all affected entries by 1 to close the hole at index i and
-- 
2.43.0


