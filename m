Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2366CD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 10:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruUoG-0007J3-Nf; Wed, 10 Apr 2024 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruUoE-0007It-Um
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruUoD-0005HI-Eh
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712743440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knHvep8Bq+MN/mk6ErFC7gj0BiOb4fkSCh0kPtg06fI=;
 b=BogQNFUUyOCuTdlWog4E/VUG0VaOWa8T5oVXNHQxOBN3SGP2IYpnAC7wFKk5/dqFVVbKac
 mqsABFkd5WR9dufvqiTYzJG0IPn7S8UVUgamkjxbZRh9zIMBcPpp7wFColGIjFMnf/IZ8o
 ePojgtrigr4BDcO+UFFox1mgdV1RVvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-f6VAVTcXOVCTBBMarXhobA-1; Wed, 10 Apr 2024 06:03:57 -0400
X-MC-Unique: f6VAVTcXOVCTBBMarXhobA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11261806602;
 Wed, 10 Apr 2024 10:03:57 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1D9C0157E;
 Wed, 10 Apr 2024 10:03:55 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: [RFC 2/2] vdpa: identify aliased maps in iova_tree
Date: Wed, 10 Apr 2024 12:03:45 +0200
Message-ID: <20240410100345.389462-3-eperezma@redhat.com>
In-Reply-To: <20240410100345.389462-1-eperezma@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The guest may have overlapped memory regions, where different GPA leads
to the same HVA.  This causes a problem when overlapped regions
(different GPA but same translated HVA) exists in the tree, as looking
them by HVA will return them twice.

To solve this, track GPA in the DMA entry that acs as unique identifiers
to the maps.  When the map needs to be removed, iova tree is able to
find the right one.

Users that does not go to this extra layer of indirection can use the
iova tree as usual, with id = 0.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e827b9175f..90adff597c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -361,6 +361,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
+        mem_region.id = iova;
 
         r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
@@ -443,6 +444,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         DMAMap mem_region = {
             .translated_addr = (hwaddr)(uintptr_t)vaddr,
             .size = int128_get64(llsize) - 1,
+            .id = iova,
         };
 
         result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
-- 
2.44.0


